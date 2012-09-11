software-consultant.net
=======================

This is the source code of my professional website located at [software-consultant.net](http://software-consultant.net). The website if public, so the source might be public just as well. Besides, I've learned so much from the work of others, I assume it might be appropriate to share what I've got.

What is it?
-----------

The website is built as a [Sinatra](http://www.sinatrarb.com) web application. I tried to use [jekyll](https://github.com/mojombo/jekyll) first, even [Octopress](http://octopress.org), however the approach to have only static pages did not quite fit me. Sinatra is an elegant DSL for writing web applications and it isn't as heavywheight as eg. Rails. Granted, Rails does a lot of useful stuff when you're building a complex app, but most of it isn't needed for such a one-page web wonder like mine.

This project shows how to use Sinatra as a Rack application (so I can use passenger to run it) along with sprockets (the asset pipeline also used in Rails 3.1 and up), sass, compass and the inevitable Twitter bootstrap.

### Wait, Bootstrap? Again?

Bootstrap is great, but it sucks that most sites use it almost or completely unmodified. That leads to a lot of sites looking just the same. I use Sass to customize bootstrap (see the _variables file) and only include what I actually need. The outcome is minified and gzipped.

### Used projects

* Sinatra
* sinatra-support
* [font-awesome](http://fortawesome.github.com/Font-Awesome/) scalable font icons for bootstrap
* [sprockets](https://github.com/sstephenson/sprockets) Rack-based asset packaging system
* [sprockets-sass](https://github.com/petebrowne/sprockets-sass) better Sass integration with Sprockets 2.x
* [sprockets-helpers](https://github.com/petebrowne/sprockets-helpers) asset path helpers for Sprockets 2.x
* [bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass) sass'ified version of the Bootstrap files (which use less)

Licensing
---------

The MIT License (MIT)
Copyright (c) 2012 Christian Aust, christian.aust@software-consultant.net

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

