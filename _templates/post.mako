<%page args="post"/>
<div class="hentry">
  <h3 class="entry-title">
    <a href="${post.permapath()}" rel="bookmark" title="Permanent Link to ${post.title}">${post.title}</a> 
    <abbr> · ${post.date.strftime("%Y/%m/%d")} · 

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

</abbr> 

  </h3>

    ${self.post_prose(post)}

</div>

<%def name="post_prose(post)">
  ${post.content}
</%def>
