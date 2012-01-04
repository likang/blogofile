<%inherit file="site.mako" />
<ul>
% for post in posts:
  <li>${post.date.strftime("%Y-%m-%d")} - <a href="${post.permapath()}">${post.title}</a></li>
% endfor
</ul>
<div id="pagination">
% if prev_link:
 <p class="previous left">
   <a href="${prev_link}">« Previous Page</a>
 </p>
% endif
% if prev_link and next_link:
  --  
% endif
% if next_link:
 <p class="next right">
   <a href="${next_link}">Next Page »</a>
 </p>
% endif
</div>
<div class="clear"></div>
