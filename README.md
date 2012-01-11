What
====
A Blogofile template with customized theme, also easy to deploy to Github Pages.

[Blogofile](http://blogofile.com) is a static website compiler which written and extended in Python. 

I hacked it a little to make it easy to deploy to Github, with friendly post name supported and a nice look-and-feel.

Usage
=====
Get Blogofile
-------------

    sudo easy_install Blogofile


You can get more help from [here](http://blogofile.com).

Fork the template on Github
---------------------------

    git clone git@github.com:[yourname]/blogofile.git
    cd blogofile

Remove all my posts
-------------------

    rm _posts/*  

or just keep them as examples :D

New a post
----------

    sh _new.sh 'the post title'


Build & Run
-----------

    sh _build.sh
    sh _serve.sh

Deploy site to Github Pages
---------------------------
Firstly, you should create a repository named 'username.github.com' on Github.

    cd _site
    git init
    echo "README.*" >> .gitignore
    git add .
    git remote add origin git@github.com:username/username.github.com
    git push -u origin master

You may need to modify the CNAME file if you directed your domain at Github Page. [more](http://pages.github.com)
Important!
----------
Never run 'blogofile build' after you deploy the static site to Github Pages! It will remove '.git' folder and '.gitignore' file in your site folder. So please run 'sh _build.sh' instead.
