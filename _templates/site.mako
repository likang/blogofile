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
