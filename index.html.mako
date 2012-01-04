<%inherit file="_templates/site.mako" />
% for post in bf.config.blog.posts[:bf.config.blog.posts_per_page]:
  <%include file="_templates/post.mako" args="post=post" />
% if bf.config.blog.disqus.enabled:
  <div class="after_post"><a href="${post.permalink}#disqus_thread">Read and Post Comments</a></div>
% endif
% endfor

% if len(bf.config.blog.posts) > bf.config.blog.posts_per_page:
<div id="pagination">
  <p class="previous left">
    <a href="${bf.util.site_path_helper(
      bf.config.blog.path, bf.config.blog.pagination_dir+'/2')}"> « OLDER POSTS</a>
  </p>
</div>
<div class="clear"></div>
%endif

