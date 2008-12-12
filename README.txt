= facebooker

* http://facebooker.rubyforge.org

== DESCRIPTION:

This is a curl-based version of Mike Mangino's excellent Facebooker library. We needed a more robust version of Facebooker that performs well and supports timeouts without the problems that Net::HTTP has in that area (http://blog.headius.com/2008/02/rubys-threadraise-threadkill-timeoutrb.html, http://ph7spot.com/articles/system_timer). Below is the original description of the facebooker project.

Facebooker is a Ruby wrapper over the Facebook[http://facebook.com] {REST API}[http://developer.facebook.com].  Its goals are:

* Idiomatic Ruby
* No dependencies outside of the Ruby standard library (This is true with Rails 2.1. Previous Rails versions require the JSON gem)
* Concrete classes and methods modeling the Facebook data, so it's easy for a Rubyist to understand what's available
* Well tested


== FEATURES/PROBLEMS:

* Idiomatic Ruby
* This version is dependent on libcurl and the curb gem (This is true with Rails 2.1. Previous Rails versions also require the JSON gem)
* Concrete classes and methods modeling the Facebook data, so it's easy for a Rubyist to understand what's available
* Well tested

== SYNOPSIS:

View David Clements' {excellent tutorial}[http://apps.facebook.com/facebooker_tutorial] at {http://apps.facebook.com/facebooker_tutorial/}[http://apps.facebook.com/facebooker_tutorial] or check out {Developing Facebook Platform Applications with Rails}[http://www.pragprog.com/titles/mmfacer].

== REQUIREMENTS:

* libcurl
* curb gem

== INSTALL:

  * Rails

Facebooker-curl can be installed as a Rails plugin by:

  script/plugin install git@github.com:HiroProt/facebooker-curl.git

Once the plugin is installed, you will need to configure your Facebook app in config/facebooker.yml. 

Your application users will need to have added the application in facebook to access all of facebooker's features. You enforce this by adding

  ensure_application_is_installed_by_facebook_user  

to your application controller.

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
