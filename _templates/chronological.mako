<%inherit file="site.mako" />
% for post in posts:
  <%include file="post.mako" args="post=post" />
% if bf.config.blog.disqus.enabled:
  <div class="after_post"><a href="${post.permalink}#disqus_thread">Read and Post Comments</a></div>
% endif
% endfor
<div id="pagination">
% if prev_link:
 <p class="alignright">
   <a href="${prev_link}">NEWER POSTS »</a>
 </p>
% endif
% if prev_link and next_link:
% endif
% if next_link:
 <p class="alignleft">
   <a href="${next_link}">« OLDER POSTS</a>
 </p>
% endif
</div>
<div class="break"></div>
