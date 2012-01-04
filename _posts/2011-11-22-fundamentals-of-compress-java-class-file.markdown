---
title: Java class 文件压缩原理
date: 2011/11/22 20:27:00
categories: Java
draft: true
---
前些天跟同事讨论class文件反编译出来的Java文件跟源文件相比有哪些缺失，进而讨论class文件到底能压缩到什么程度，讨论到最后一些细节我们都有点吃不准了，于是事后我又复习了一把class文件格式，以及相关的技术，在这里记录一下，如果有人看到并且指出不对的地方，那是幸事:D

对class文件的压缩大体上可以分为两个方向，一是简单的将长变量名/方法名等改成短的，并尽量减少class文件中附加的额外信息(如行号信息，参数名等)；二是通过早期编译技术，将无用或者无效的代码去除等操作，这一部分跟<code>编译器优化</code>基本重合，所以就不展开讨论了，我们只简单的看看字符层面的压缩。

##class文件格式
参考 [The Class File Format](http://java.sun.com/docs/books/jvms/second_edition/html/ClassFile.doc.html) 我们可以知道class文件基本构成为:  

    ClassFile {
    	u4 magic;//文件魔数，值为:0xCAFEBABE
    	u2 minor_version;//次版本号
    	u2 major_version;//主版本号
    	u2 constant_pool_count;//常量池中元素的数量
    	cp_info constant_pool[constant_pool_count-1];//常量池，主要包含字面量和符号引用
    	u2 access_flags;//访问标记，如public/interface/final等
    	u2 this_class;//本类的全限定名
    	u2 super_class;//父类的全限定名
    	u2 interfaces_count;//接口的数量
    	u2 interfaces[interfaces_count];//实现的接口列表
    	u2 fields_count;//字段表中字段数量
    	field_info fields[fields_count];//字段信息表
    	u2 methods_count;//方法数量
    	method_info methods[methods_count];//方法信息表
    	u2 attributes_count;//属性数量
    	attribute_info attributes[attributes_count];//属性信息表
    }

简单说明下关键部分：
  
* constant_pool  
  主要是两大类数据：字面量(Literal)和符号引用(Symbolic References)。字面量就是一些常量值，如字符串的值，final的常量值等，符号引用就是各种描述符，如字段名、方法名等。  
  值得注意的是，常量池里的符号引用被class文件后面的多个模块引用，如fields里的字段名、methods里的方法名等都引用自常量池，也就是说这些地方只保留到常量池的一个引用，不会直接存储常量。
* attributes  
 这又是一个大杂烩的地方，被fields,methods等使用。来看看具体

##压缩
由此可知如果我们只从字符层面看的化，能压缩的就是constant_pool常量池中的符号引用部分、attributes中可以去掉的附加属性，于是
