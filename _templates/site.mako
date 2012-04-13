<%inherit file="base.mako" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    ${self.head()}
  </head>
  <body>
    <div id="wrapper">
      <div id="content">
        ${next.body()}
      </div><!-- End Main Block -->
      ${self.sidebar()}
      <div class="clear"></div><!-- End Sitebar -->
      <div id="footer">
        ${self.footer()}
      </div> <!-- End Footer -->
    </div> <!-- End Content -->
    ${self.scripts()}
  </body>
</html>
<%def name="head()">
  <%include file="head.mako" />
</%def>
<%def name="sidebar()">
  <%include file="sidebar.mako" />
</%def>
<%def name="footer()">
  <%include file="footer.mako" />
</%def>
<%def name="scripts()">
  <%include file="scripts.mako" />
</%def>
