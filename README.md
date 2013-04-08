software-consultant.net
=======================

This is the source code of my professional website located at [software-consultant.net](http://software-consultant.net). The website is public, so the source might be public just as well. Besides, I've learned so much from the work of others, I assume it might be appropriate to share what I've got.

What's inside?
--------------

This release is built upon [Nesta CMS](http://nestacms.com). Nesta is a CMS built on the [Sinatra web framework](http://www.sinatrarb.com) and adds file-based content management to it. It features a simple themes system, with the theme used here being found under `themes/swc`.

Nesta follows a concept of pages and *articles* (which are simply pages with a date) so it's suitable for standard websites and blogs alike. Page content is stored in files and read from disk when needed, with heavy caching to prevent high IO loads. Pages are written in either haml, markdown or textile, and you can do anything that's possible with Sinatra. Which is pretty much.

My site uses a fork or Nesta, because I implemented the [Sprockets](https://github.com/sstephenson/sprockets) asset pipeline known from Rails 3.1 and up. That'd give me proper asset processors like CoffeScript ans SASS, as well as asset compression and whatnot. My fork basically allows to switch off Nesta's asset handling, in favor of letting Sprockets do the work.

### Inner works

My theme registers a bunch of helpers and model additions from `themes/swc/app.rb`, which in turn loads stuff from my themes `lib` directory. Pages that are flagged as *project* will be extended using some model-specific methods, so I can perform all sorts of nifty selecting and processing on them.

The UI is built upon the [ZURB foundation framework](http://foundation.zurb.com), basically just to see if I could. I've done a number of bootstrap-based projects lately so it was time for something new. ZURB is great in such that it uses SASS instead of LESS (although there are Bootstrap versions as SASS, but no official ones). Still, I've used the wonderful [font-awesome](http://fortawesome.github.com/Font-Awesome/) icons originally designed for bootstrap, but certainly plaing well with anything else.

### Used projects

* Sinatra
* nestacms
* ZURB foundation 4
* [font-awesome](http://fortawesome.github.com/Font-Awesome/) scalable font icons for bootstrap

Licensing
---------

The MIT License (MIT)
Copyright (c) 2012 Christian Aust, christian.aust@software-consultant.net

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

