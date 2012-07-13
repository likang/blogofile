<%inherit file="base.mako" />\
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>\
    ${self.head()}\
  </head>
  <body>
    <div id="page">\
      ${self.header()}\
      <div id="content" class="single">\
        ${next.body()}\
      </div><!-- End Main Block -->
      <div id="footer" class="single">\
        ${self.footer()}\
      </div> <!-- End Footer -->
    </div> <!-- End Content -->

    <script type="text/javascript" src="/javascripts/prettify.js"></script>
    <script type="text/javascript">
        window.onload = function(){
            if (!document.getElementsByTagName) return;
            var codes = document.getElementsByTagName("code");
            for (var i=0; i < codes.length; i++) {
                codes[i].className = "prettyprint";
            }
            prettyPrint();
        }
    </script>
    <script type="text/javascript">

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-32376704-1']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>

  </body>
</html>
<%def name="head()">
  <%include file="head.mako" />\
</%def>
<%def name="header()">
  <%include file="header.mako" />
</%def>
<%def name="footer()">
  <%include file="footer.mako" />
</%def>
