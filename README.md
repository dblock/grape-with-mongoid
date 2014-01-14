Grape API w/ Mongoid
====================

[![Build Status](https://secure.travis-ci.org/dblock/grape-with-mongoid.png)](http://travis-ci.org/dblock/grape-with-mongoid)

A [Grape](http://github.com/intridea/grape) API exposing [Mongoid](http://github.com/mongoid/mongoid) models.

* [crud](api/crud.rb): an example of CRUD methods

Run
---

```
$ bundle install
$ rackup

Loading NewRelic in developer mode ...
[2013-06-20 08:57:58] INFO  WEBrick 1.3.1
[2013-06-20 08:57:58] INFO  ruby 1.9.3 (2013-02-06) [x86_64-darwin11.4.2]
[2013-06-20 08:57:58] INFO  WEBrick::HTTPServer#start: pid=247 port=9292
```

Swagger
-------

Navigate to *http://localhost:9292/api/swagger_doc/api*.
