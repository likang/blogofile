<%page args="post"/>
<div class="post">
  <h2>
    <a href="${post.permapath()}" rel="bookmark" title="Permanent Link to ${post.title}">${post.title}</a> 
  </h2>
  <h4 style="margin-top: 0px;">
    ${post.date.strftime("%Y/%m/%d")} · 

<% 
   category_links = []
   for category in post.categories:
       if post.draft:
           #For drafts, we don't write to the category dirs, so just write the categories as text
           category_links.append(category.name)
       else:
           category_links.append("<a href='%s'>%s</a>" % (category.path, category.name))
%>
${u" · ".join(category_links)}
% if bf.config.blog.disqus.enabled:
 | <a href="${post.permalink}#disqus_thread">Comments</a>
% endif

  </h4>

    ${self.post_prose(post)}

    <div class="separator"></div>
</div>

<%def name="post_prose(post)">
  ${post.content}
</%def>
