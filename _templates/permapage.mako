<%inherit file="site.mako" />
<%include file="post.mako" args="post=post" />

<div id="pagination">
% if prev_post:
 <p class="alignleft">
   « <a href="${prev_post.permapath()}">${prev_post.title}</a>
 </p>
% endif
% if prev_link and next_link:
  --
% endif
% if next_post:
 <p class="alignright">
   <a href="${next_post.permapath()}">${next_post.title}</a> »
 </p>
% endif
</div>
<div class="break"></div>


<div id="disqus_thread"></div>
<script type="text/javascript">
  var disqus_url = "${post.permalink}";
</script>
% if bf.config.blog.disqus.enabled:
<script type="text/javascript" src="http://disqus.com/forums/${bf.config.blog.disqus.name}/embed.js"></script>
<noscript><a href="http://${bf.config.blog.disqus.name}.disqus.com/?url=ref">View the discussion thread.</a></noscript><a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>
% endif
