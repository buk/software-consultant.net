software-consultant.net
=======================

This is the source code of my professional website located at [software-consultant.net](http://software-consultant.net). The website if public, so the source might be public just as well. Besides, I've learned so much from the work of others, I assume it might be appropriate to share what I've got.

What is it?
-----------

The website is built as a [Sinatra](http://www.sinatrarb.com) web application. I tried to use [jekyll](https://github.com/mojombo/jekyll) first, even [Octopress](http://octopress.org), however the approach to have only static pages did not quite fit me. Sinatra is an elegant DSL for writing web applications and it isn't as heavywheight as eg. Rails. Granted, Rails does a lot of useful stuff when you're building a complex app, but most of it isn't needed for such a one-page web wonder like mine.

This project shows how to use Sinatra as a Rack application (so I can use passenger to run it) along with sprockets (the asset pipeline also used in Rails 3.1 and up), sass, compass and the inevitable Twitter bootstrap.
