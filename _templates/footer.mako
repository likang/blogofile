<p id="credits">
Likang.me uses <a href="http://www.ulfpettersson.se/design/modern/">Modern</a> and powered by <a href="http://www.blogofile.com">Blogofile</a>. 
% if bf.config.blog.disqus.enabled:
 and <a
href="http://${bf.config.blog.disqus.name}.disqus.com/latest.rss">Comments</a>.
% endif
<br>
</p>
% if bf.config.blog.disqus.enabled:
<script type="text/javascript">
//<![CDATA[
(function() {
		var links = document.getElementsByTagName('a');
		var query = '?';
		for(var i = 0; i < links.length; i++) {
			if(links[i].href.indexOf('#disqus_thread') >= 0) {
				query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
			}
		}
		document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/${bf.config.blog.disqus.name}/get_num_replies.js' + query + '"></' + 'script>');
	})();
//]]>
</script>
% endif

<script type="text/javascript" src="/javascripts/prettify.js"></script>
<script type="text/javascript">
    window.onload = function(){
        if (!document.getElementsByTagName) return;
        var codes = document.getElementsByTagName("code");
        for (var i=0; i < codes.length; i++) {
            codes[i].setAttribute("class", "prettyprint");
            codes[i].setAttribute("className", "prettyprint"); // for IE
        }
        prettyPrint();
    }

</script>
