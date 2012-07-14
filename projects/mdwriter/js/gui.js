var mdBorder, mdCard, mdText, preview, body
var mouseWillStop
var mdConverter, lastText
var lastPageX, lastPageY

$(document).ready(startGui)

function startGui(){
    body = $("body")
    mdCard = $("#md-card")
    mdBorder = $("#md-border")
    mdText = $("#md-text").focus()
    preview = $("#preview").hide()
    var editor = CodeMirror.fromTextArea(document.getElementById("md-text"), {
        mode: 'markdown',
        lineNumbers: false,
        matchBrackets: true,
        theme: 'elegant'
    });
    hideScrollBar()
    mouseWillStop = fadeMdBorder(2000, 1000, 0)

    mdConverter = new Showdown.converter()

    $(document).keydown(onKeyDown)
    $(document).mousemove(onMouseMove)
}

function hideScrollBar(){
    var scrollBarWidth = getScrollBarWidth()
    $(".scrollbar-mask").css("margin-right", scrollBarWidth + "px")
    $(".scrollbar-offset").css("left", scrollBarWidth + "px").css("overflow-y", "scroll")
}

function fadeMdBorder(delay, duration, opacity){
    return setTimeout(function(){
        mdBorder.animate({opacity: opacity}, duration)
        if(opacity == 0){
            body.css("cursor", "none")
            mdText.css("cursor", "none")
        }else{
            body.css("cursor", "auto")
            mdText.css("cursor", "auto")
        }
    }, delay)
}

function onKeyDown(e){
    if(e.which == 27){
        if(mdCard.is(":hidden")){
            mdCard.fadeIn(500)
            preview.fadeOut(500)
            if(mdBorder.css("opacity") == 0){
                fadeMdBorder(0, 1000, 1)
            }
            clearTimeout(mouseWillStop)
            mouseWillStop = fadeMdBorder(2500, 1000, 0)
            mdText.focus()
        }else{
            mdBorder.stop(true)
            clearTimeout(mouseWillStop)
            mdText.blur()
            var re = /\S+?/
            var text = mdText.val()
            if (text != lastText) {
                lastText = text
                var result = "no text input, press Esc to write something"
                if(re.test(text)){
                    result = mdConverter.makeHtml(text)
                }
                preview.html(result) 
            }
            body.css("cursor", "auto")
            mdText.css("cursor", "auto")
            mdCard.fadeOut(500)
            preview.fadeIn(500)
        }
    }
}

function onMouseMove(e){
    // console.log(mdBorder.queue("fx").length)
    // some input method may trigger mousemove event even the mouse doesn't move anywhere
    if(e.pageX == lastPageX && e.pageY == lastPageY){
        return
    }
    lastPageX = e.pageX
    lastPageY = e.pageY
    if(mdText.is(":visible") && !mdText.is(":animated")){
        if(mdBorder.css("opacity") == 0){
            fadeMdBorder(0, 1000, 1)
        }else{
            clearTimeout(mouseWillStop)
            mouseWillStop = fadeMdBorder(2000, 1000, 0)
        }
    }
}

/*
  http://www.alexandre-gomes.com/?p=115
*/
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
}  
