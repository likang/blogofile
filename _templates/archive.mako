<%inherit file="site.mako" />
<div id = "archive">
<ul>
% for post in posts:
  <li>${post.date.strftime("%Y-%m-%d")} - <a href="${post.permapath()}">${post.title}</a></li>
% endfor
</ul>
</div>
