    <script type="text/javascript" src="/javascripts/prettify.js"></script>
    <script type="text/javascript">
        window.onload = function(){
            if (!document.getElementsByTagName) return;
            var codes = document.getElementsByTagName("code");
            for (var i=0; i < codes.length; i++) {
                codes[i].setAttribute("class", "prettyprint");
            }
            prettyPrint();
        }
    
    </script>
