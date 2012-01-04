---
layout: post
title: cx_Oracle 编译安装及简单使用方法
date: 2011/11/23 20:14:00
categories: Python
---
cx\_Oracle 是Python的一个扩展模块，提供符合Python数据库API规范的Oracle访问支持，是Python下访问Oracle的利器，不过鉴于其版本众多，很多人在安装上就遇到了障碍，我这里简单记录一下。  
最普适的方法就是编译安装了，官方有详尽的[安装文档](http://cx-oracle.sourceforge.net/BUILD.txt)，我这里基本只是翻译。
##准备
首先下载两个东西：
  
* [cx\_Oracle](http://cx-oracle.sourceforge.net/) 
* [Oracle Instant Client](http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html). Oracle官方提供的轻量客户端组件，需要同时下载 instantclient-linux-basic 和 instantclient-sdk-linux 并<code>解压到同一目录</code>。

然后设置环境变量，最好写到profile文件里  

    export ORACLE_HOME=[你的解压目录]/instantclient_11_1
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME

MAC OS X 下还需设置另一个环境变量

    export DYLD_LIBRARY_PATH=$ORACLE_HOME

然后做一下软链

    cd $ORACLE_HOME
    ln -s libclntsh.so.x.x libclntsh.so

##编译安装
接下来非常简单，进入你的cx\_Oracle源码目录后执行以下两条语句就OK了

	python setup.py build
	python setup.py install

测试是否正常

    $ python
    Python 2.5.2 (r252:60911, Oct 25 2008, 19:37:28)
    [GCC 4.1.2 (Gentoo 4.1.2 p1.1)] on linux2
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import cx_Oracle
    >>>

没有异常的话就说明安装成功了。
##简单的使用
    #!/usr/bin/python
    # -*- encoding: utf-8 -*-
    import cx_Oracle

    try:
      db = cx_Oracle.connect('username','passwd','host:port/dsn')
      cursor=db.cursor()
      cursor.execute(sql)
      #查询
      for column, in cursor:#注意只有一列的时候也要后面加','来解包
        #do something
      #取一列
      row = cursor.fetchone()
      #带名字参数的查询
      cursor.execute(
        'select * from table where id = :id ',{'id':5,})
      #按位置参数的查询
      cursor.execute(
        'select * from table where id = :1',
        (id,))#注意只有一个参数时也要加','参数是元组

      cursor.close()
      db.close()
    except cx_Oracle.DatabaseError, e:
      print e
      sys.exit(2)
最后，连接默认是没有设置autocommit的，更删改的话需要commit。
