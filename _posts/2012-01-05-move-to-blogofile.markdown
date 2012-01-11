---
title: 迁移到 blogofile
date: 2012/01/05 17:01:08
categories: Tech
---

Octopress 蛮好用的。但还是有几个原因让我迁移：

*  Octopress有点重，我只是想要一个简简单单的静态文件博客，可以灵活的定制，不需要太多功能，Blogofile 足够简单和灵活。
*  Blogofile是基于Python的，也就意味着对我来说它的插件和模板系统上手很快。事实上，Blogofile init之后，我立刻就把它的URL生成方式改成了Octopress的方式，即由文章的文件名来指定文章路径。
*  Octopress的Ruby环境安装起来实在不方便，可能是我太笨。可Blogofile只需easy\_install一下就OK了。

当然迁移之后我对Blogofile做了一点改动：

*  做了一个简单的主题
*  支持部署到Github Pages
*  URL生成方式完全根据文件名，如2011-12-25-new-post.markdown 将部署到 2011/12/25/new-post
*  用 sh \_new.sh 帮助生成符合标准的markdown文件

Blogofile 默认没有对部署到Github Pages进行支持，我就想了一个笨方法来实现：将Blogofile生成的\_site目录作为Git repository，由于Blogofile build的时候会首先完全清空\_site目录，所以我写了一个脚本自动备份\_site中的隐藏文件和文件夹，Blogofile build完成之后再将隐藏文件移动过去，是不是很笨。。。

如果你对这个改动后的模板感兴趣，可以在[这里](https://github.com/likang/blogofile)找到。

总之对于现在这个样子的站点我很满意，换了喜欢的主题，换了更贴心的工具。
