---
title: 使用 PyCrypto 进行 AES/ECB/PKCS#5(7) 加密 
date: 2013/06/05 19:46:43
categories: Tech
---

[PyCrypto](https://www.dlitz.net/software/pycrypto/) 是流行的 Python 加密/解密库。但是其 AES 的 ECB 模式在加密解密时未提供适合的密文填充工具，因此有必要自己实现一个，下面是常见的 [PKCS#5 / PKCS#7](http://en.wikipedia.org/wiki/Padding_(cryptography)) 填充模式的一般写法：

    '''
    PKCS#5 padding is identical to PKCS#7 padding, except that 
    it has only been defined for block ciphers that use a 64 bit (8 byte) 
    block size.
    But in AES, there is no block of 8 bit, so PKCS#5 is PKCS#7.
    '''
    BS = AES.block_size
    pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
    unpad = lambda s : s[0:-ord(s[-1])]   

在进行加密/解密前，只需使用 pad/unpad 进行填充/截断即可。下面是具体实例：

    # -*- coding: utf-8 -*-
    from Crypto.Cipher import AES
    import os
    
    BS = AES.block_size
    pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
    unpad = lambda s : s[0:-ord(s[-1])]

    key = os.urandom(16) # the length can be (16, 24, 32)
    text = 'to be encrypted'

    cipher = AES.new(key)

    encrypted = cipher.encrypt(pad(text)).encode('hex')
    print encrypted  # will be something like 'f456a6b0e54e35f2711a9fa078a76d16'

    decrypted = unpad(cipher.decrypt(encrypted.decode('hex')))
    print decrypted  # will be 'to be encrypted'
    
提醒一点，PKCS#5 和 PKCS#7 唯一的区别就是前者规定了数据块大小是 64 比特(8 字节)，而 AES 中数据块大小是 128 比特(16字节)，因此在 AES 中， PKCS#5 和 PKCS#7 没有区别。

顺便提一下，在 Java 中偶尔遇到如下方式获取 AES 实例：

    Cipher cipher = javax.crypto.Cipher.getInstance("AES") 
    
但是在文档 [Java™ Cryptography Architecture Standard Algorithm Name Documentation](http://docs.oracle.com/javase/7/docs/technotes/guides/security/StandardNames.html#Cipher) 以及 [Cipher Java doc](http://docs.oracle.com/javase/7/docs/api/javax/crypto/Cipher.html#getInstance(java.lang.String)) 中并未直接说明这种方式所使用的模式以及填充方式。而AES默认的 Provider [AESCipher](http://www.docjar.com/html/api/com/sun/crypto/provider/AESCipher.java.html) 中则有所说明，其使用的默认模式和填充方式正是 ECB 和 PKCS5Padding。今天写一个 Python 工具需要与 Java 通讯，我使用的 Java 库正是使用上述方式构造 Cipher，所以进行了一番了解。
