Cities
======

Cities is a web based MMO Game built with the Phalcon PHP Extension, PhalconPHP is a web framework delivered as a C extension providing high performance and lower resource consumption.

Demo: http://cities.emil.ninja


NOTE
----

Required version: >= 1.1.0 B3

Get Started
-----------

#### Test User

Email: test@test.com

Password: password

#### Requirements

To run this application on your machine, you need at least:

* >= PHP 5.3.9
* Apache Web Server with mod rewrite enabled, and AllowOverride Options (or All) in your httpd.conf
* Latest Phalcon Framework extension installed/enabled

Then you'll need to create the database and initialize schema:

    echo 'CREATE DATABASE cities' | mysql -u root
    cat schemas/cities.sql | mysql -u root Cities

Installing Dependencies via Composer
------------------------------------
Cities dependencies must be installed using Composer. Install composer in a common location or in your project:

```bash
curl -s http://getcomposer.org/installer | php
```

Run the composer installer:

```bash
cd cities
php composer.phar install
```
