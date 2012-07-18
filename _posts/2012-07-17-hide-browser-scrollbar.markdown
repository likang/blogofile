---
title: 隐藏滚动条
date: 2012/07/17 23:56:56
categories: Tech, Front End
---
与 OSX Lion 原生的滚动条相比，Firefox 以及Windows下的滚动条就显得惨不忍睹了，有时我们想让它干脆不显示。W3C有关滚动条方面的标准几乎是没有，而且不是所有浏览器都能对滚动条进行自定义，我们只能另辟蹊径。

虽然说是隐藏，但是滚动功能还是要有的，否则 overflow: hidden 就可以了。在此我们采取的是用层遮罩的方式来实现。

首先要知道滚动条的宽度。由于JS中并没有直接获取滚动条宽度的方法，我们再耍一个小技巧：先生成一个不显示滚动条的元素块，计算其宽度，然后让其显示滚动条，则当前宽度跟原宽度的差值即是滚动条的宽度。感谢 [alexandre](http://www.alexandre-gomes.com/?p=115) 提供的跨浏览器的解决方案：

    function getScrollBarWidth () {  
        var inner = document.createElement('p');  
        inner.style.width = "100%";  
        inner.style.height = "200px";  
      
        var outer = document.createElement('div');  
        outer.style.position = "absolute";  
        outer.style.top = "0px";  
        outer.style.left = "0px";  
        outer.style.visibility = "hidden";  
        outer.style.width = "200px";  
        outer.style.height = "150px";  
        outer.style.overflow = "hidden";  
        outer.appendChild (inner);  
      
        document.body.appendChild (outer);  
        var w1 = inner.offsetWidth;  
        outer.style.overflow = 'scroll';  
        var w2 = inner.offsetWidth;  
        if (w1 == w2) w2 = outer.clientWidth;  
      
        document.body.removeChild (outer);  
      
        return (w1 - w2);  
    };

拿到滚动条宽度后，我们利用外部块级元素的overflow: hidden;属性将内部元素超出的部分隐藏掉。可使用margin或者手动调整内部元素宽度的方式来改变内部元素滚动条相对于外部元素的位置。

需要注意的是，OSX Lion Webkit内核的滚动条是悬浮在文本框之上的，因此宽度是零。好在我们可以通过设置CSS伪类的方式来达到目的。

    <head>
        <style type="text/css">
            #mask {
                overflow: hidden;
                width: 200px;
                height: 200px;
            }
            #wrap {
                width: 100%;
                height: 100%;
                background-color: #D8D7CF;
                overflow-y: scroll;
            }
            #wrap::-webkit-scrollbar, #wrap::scrollbar {
                width: 0;
                height: 0;
            }
        </style>
    </head>
    <body>
        <div id="mask">
            <div id="wrap">
            </div>
        </div>
        <script type="text/javascript">
            document.getElementById("wrap").style.marginLeft 
                = getScrollBarWidth() + "px"
        </script>
    </body>

大功告成。原生的滚动条不见了，通过监听元素的 scroll 事件我们可以自定义的各种样式的滚动条。
