software-consultant.net
=======================

This is the source code of my professional website located at [software-consultant.net](http://software-consultant.net). The website is public, so the source might be public just as well. Besides, I've learned so much from the work of others, I assume it might be appropriate to share what I've got.

What is it?
-----------

The website is built as a [Sinatra](http://www.sinatrarb.com) web application. I tried to use [jekyll](https://github.com/mojombo/jekyll) first, even [Octopress](http://octopress.org), however the approach to have only static pages did not quite fit me. Sinatra is an elegant DSL for writing web applications and it isn't as heavywheight as eg. Rails. Granted, Rails does a lot of useful stuff when you're building a complex app, but most of it isn't needed for such a one-page web wonder like mine.

This project shows how to use Sinatra as a Rack application (so I can use passenger to run it) along with sprockets (the asset pipeline also used in Rails 3.1 and up), sass, compass and the inevitable Twitter bootstrap.

### Wait, Bootstrap? Again?

Bootstrap is great, but it sucks that most sites use it almost or completely unmodified. That leads to a lot of sites looking just the same. I use Sass to customize bootstrap (see the `assets/stylesheets/_variables.scss` file) and only include what I actually need (by overriding `bootstrap.scss`). The outcome is minified and gzipped.

### Used projects

* Sinatra
* sinatra-support
* [font-awesome](http://fortawesome.github.com/Font-Awesome/) scalable font icons for bootstrap
* [sprockets](https://github.com/sstephenson/sprockets) Rack-based asset packaging system
* [sprockets-sass](https://github.com/petebrowne/sprockets-sass) better Sass integration with Sprockets 2.x
* [sprockets-helpers](https://github.com/petebrowne/sprockets-helpers) asset path helpers for Sprockets 2.x
* [bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass) sass'ified version of the [twitter-bootstrap](http://twitter.github.com/bootstrap/) files (which use less)

How does it work?
-----------------

The file `config.ru` is the starting point for all rack-based frameworks (such as Rails or Sinatra), this is what Passenger picks up first when deploying the application. It maps the assets environment to the configured URI prefix (here: "/assets") and the [modular sinatra application](http://www.sinatrarb.com/intro#Sinatra::Base%20-%20Middleware,%20Libraries,%20and%20Modular%20Apps) from the required file `swc.rb`. Note that Sinatra doesn't set the load path for a lib-directory so the require statement uses a relative path.

Licensing
---------

The MIT License (MIT)
Copyright (c) 2012 Christian Aust, christian.aust@software-consultant.net

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

