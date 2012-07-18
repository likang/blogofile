var preview, editor, editor_frame
var mdConverter

$(document).ready(startGui)

function startGui(){
    editor = CodeMirror.fromTextArea(document.getElementById("manual"), {
        mode: 'markdown',
        lineNumbers: false,
        matchBrackets: true,
        lineWrapping: true,
        theme: 'elegant'
    });
    $('.box-wrap').antiscroll();
    editor.focus()

    editor_frame = $("#editor_frame")
    preview = $("#preview").hide()
    mdConverter = new Showdown.converter()
    $(document).keydown(onKeyDown)
}

function onKeyDown(e){
    if (e.ctrlKey && e.which == 80) {
        if(editor_frame.is(":hidden")){
            editor_frame.fadeIn(500)
            preview.fadeOut(500)
        }else{
            preview.html(mdConverter.makeHtml(editor.getValue()))
            preview.fadeIn(500)
            editor_frame.fadeOut(500)
        }
    };
}
