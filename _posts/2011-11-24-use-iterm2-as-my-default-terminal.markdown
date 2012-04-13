---
title: 使用 iTerm2 作为默认终端
date: 2011/11/24 22:16:00
categories: Mac
---
一直以来 Mac 默认的终端也蛮好用的，但是今天发现 SSH到远程服务器之后，vim无法正常的split分屏显示，让我很郁闷，于是就找到了iTerm2.

iTerm2是从iTerm的基础上开发的，只不过iTerm不再更新，所以这位George Nachman兄就接手继续做起来，修复了很多Bug，一天用下来还是蛮稳定的，而且功能非常强大，在此表示遥远的感谢:)

__功能介绍__

<table>
<tr>
  <th width="30%">功能</th>
  <th>介绍</th>
</tr>
<tr>
  <td>窗口分割  </td>
  <td>支持横/竖/混合等，每个窗口保持一个独立session</td>
</tr>
<tr>
  <td>全局热键  </td>
  <td>通过自定义热键的方式迅速切换到iTerm2</td>
</tr>
<tr>
  <td>搜索  </td>
  <td>支持Mac风格的搜索条，Cmd-F可快速搜索当前页面，支持正则</td>
</tr>
<tr>
  <td>自动完成  </td>
  <td>按Cmd-; 可以打开命令自动完成的下拉菜单</td>
</tr>
<tr>
  <td>无鼠标复制  </td>
  <td>在搜索时，可按shift-tab或者tab左右扩展搜索内容并自动复制到剪切板，按Option-Enter直接将搜索匹配结果粘贴到命令行</td>
</tr>
<tr>
  <td>历史复制  </td>
  <td>按Cmd-Shift-H可打开剪切板历史记录，甚至还可以将记录保存到磁盘</td>
</tr>
<tr>
  <td>快照回放  </td>
  <td>按Cmd-Opt-B可打开快照记录，然后使用左右键来查看某个时间的命令结果快照，按Esq返回</td>
</tr>
<tr>
  <td>丰富的配置  </td>
  <td>支持各种自定义快捷键、皮肤、透明度设置、窗口背景图片等</td>
</tr>
<tr><td>支持Lion全屏  </td><td> * </td></tr>
<tr>
  <td>支持256色  </td>
  <td>顺便说一句，某些服务器上可能不支持256色，导致SSH上去之后看不到颜色，此时只要在Prefences->Profiles->Terminal里设置一下普通的xterm就可以了</td>
</tr>
<tr>
  <td>Unix风格  </td>
  <td>保持原汁原味Unix风格的操作习惯</td>
</tr>
<tr>
  <td>颜色友好  </td>
  <td>启用Smart Cursor后，可以自动的改变光标块颜色使之与选中的文字颜色产生高对比,当你找不到光标时，甚至还可以按Cmd-/让光标突出显示</td>
</tr>
<tr><td>鼠标支持</td><td> * </td></tr>
<tr><td>支持Growl 通知</td><td> * </td></tr>
<tr>
  <td>Exposé 效果</td>
  <td>按Cmd-Opt-E 打开内置的Exposé 效果</td>
</tr>
<tr><td>支持多用户配置</td><td> * </td></tr>
<tr><td>多语言支持</td><td> * </td></tr>
</table>
