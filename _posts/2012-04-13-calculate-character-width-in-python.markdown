---
title: Python中计算字符宽度
date: 2012/04/13 01:43:12
categories: Python
---

最近在用python写一个CLI小程序，其中涉及到计算字符宽度，目标是以友好的方式将一个长字符串截取为等宽的片段。

对于unicode字符，python的len函数可以准确的计算其中所包含的字符个数，但是个数并不代表宽度，如：

    >>>len(u'你好a')
    3

因此无法简单的使用这种方式来计算宽度。

__GBK decode__

首先我想到[GBK](http://zh.wikipedia.org/zh/GBK)编码，00–7F范围内的字符是一字节编码，其余是双字节编码，正好与字符的宽度大体一致，于是有了这样的投机取巧的办法（假设取8个宽度）：

    >>> a = u'hello你好'
    >>> b=a.encode('gbk')
    >>> try:
    ...   print b[:8].decode('gbk')
    ... except:
    ...   print b[:7].decode('gbk')
    ... 
    hello你
    
如代码所示，首先将unicode的字符串进行GBK编码，然后截取8个字节的宽度后尝试用GBK解码，若解码失败，则少截取一个宽度，截取7个字节后使用GBK解码。

虽然初步解决了问题，但是这样做的硬伤很明显。首先代码不优雅，以试错的方式运行；其次GBK所能表示的字符有限，对于大量GBK编码以外的字符无法支持。

__East_Asian_Width__

徘徊很久之后，偶然发现 [Unicode Character Database](http://www.unicode.org/reports/tr44/tr44-4.html)标准中有East_Asian_Width 属性，并有以下可能值：

    # East_Asian_Width (ea)

    ea ; A         ; Ambiguous    不确定
    ea ; F         ; Fullwidth    全宽
    ea ; H         ; Halfwidth    半宽
    ea ; N         ; Neutral      中性
    ea ; Na        ; Narrow       窄
    ea ; W         ; Wide         宽
  
其中除A不确定外，F/H/N/Na/W都能很明确的知道宽度，如果保守起见，将A视为宽度为2的话，则很容易给出单个字符的宽度：

    >>> import unicodedata
    >>> def chr_width(c):
    ...   if (unicodedata.east_asian_width(c) in ('F','W','A')):
    ...     return 2
    ...   else:
    ...     return 1
    >>> chr_width(u'你')
    2
    >>> chr_width(u'a')
    1

到现在似乎已经可以满足要求了，但是实际使用中发现属性为A的字符真不少见，最典型的就是中文的双引号：

    >>> chr_width(u'”')
    2

在大多数等宽字体中，中文双引号都是只占一位宽的，如果一行里有多个中文双引号，则累加的误判宽度将会使截取效果大打折扣，无疑这也不是最好的办法。

__urwid的解决方案__

[urwid](http://excess.org/urwid/)是一个成熟的python终端UI库，它在curses的基础之上包装了类似HTML的控件用以显示文本内容，如果有这方面的开发需求，非常推荐此库，比直接使用curses库方便很多，非常棒的是它对unicode的文本宽度截取非常准确，让我大为惊讶，于是翻开它的源码一探究竟，文本宽度计算方面其核心代码如下：

    widths = [
        (126,    1), (159,    0), (687,     1), (710,   0), (711,   1), 
        (727,    0), (733,    1), (879,     0), (1154,  1), (1161,  0), 
        (4347,   1), (4447,   2), (7467,    1), (7521,  0), (8369,  1), 
        (8426,   0), (9000,   1), (9002,    2), (11021, 1), (12350, 2), 
        (12351,  1), (12438,  2), (12442,   0), (19893, 2), (19967, 1),
        (55203,  2), (63743,  1), (64106,   2), (65039, 1), (65059, 0),
        (65131,  2), (65279,  1), (65376,   2), (65500, 1), (65510, 2),
        (120831, 1), (262141, 2), (1114109, 1),
    ]

    def get_width( o ):
        """Return the screen column width for unicode ordinal o."""
        global widths
        if o == 0xe or o == 0xf:
            return 0
        for num, wid in widths:
            if o <= num:
                return wid
        return 1

如代码所示，首先根据unicode的官方[EastAsianWidth文档](http://www.unicode.org/Public/4.0-Update/EastAsianWidth-4.0.0.txt)整理出字符宽度的范围表，然后使用unicode代码查表。使用之前的例子测试：

    >>> get_width(ord(u'a'))
    1
    >>> get_width(ord(u'你'))
    2
    >>> get_width(ord(u'”'))
    1

完全准确，而且在实际应用中的表现也比较好，是一个理想的解决方案，更多技巧请查阅urwid的[old_str_util.py](https://github.com/wardi/urwid/blob/master/urwid/old_str_util.py)源码。

