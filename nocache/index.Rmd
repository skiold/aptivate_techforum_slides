---
title       : client side cache woes
subtitle    : no defaults ~= bad defaults
author      : Adrian
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

## Big releases are a bad idea

Who owns the definition of stale content?
...

_Browser defaults_ : too many, too nasty

--- .class #id 

## How to clean your client's cache

### tl;dr you can't

    FileETag None                # try to disable cache validators
    Header set Cache-Control "no-cache, no-store"
    Header set Pragma "no-cache" # corner cases, old browsers
    Header set Expires "0"       # corner cases, old browsers

---

## Aptivate cache survey

([3ieimpact](http://3ieimpact.org),[caada](https://hub.caada.org.uk/crm/info.php),[cbm](http://lin-cbmdb.aptivate.org),[cdkn](http://cdkn.org),[youwin M&E](https://winners.youwin.org.ng),[econsensus](http://econsensus.org), ...)

### Django cache middleware

Enabled in most of our sites. Default values for [CACHE_MIDDLEWARE_SECONDS][]

    Cache-control: max-age=600

[CACHE_MIDDLEWARE_SECONDS]: https://docs.djangoproject.com/en/dev/ref/settings/#std:setting-CACHE_MIDDLEWARE_SECONDS

### http headers in apache

- static content on django sites

None of the services in the survey defines cache-control headers for static content.

(_Browsers are free to set expires to infinity_)

---

## Leverage lowband for defaults

We are committed to deliver low-bandwidth products. Our
sites perform well with little browser caching.

- Use [default django caching times][CACHE_MIDDLEWARE_SECONDS] (10min).
- Use [default django caching times][CACHE_MIDDLEWARE_SECONDS] for static content also (10min).

[CACHE_MIDDLEWARE_SECONDS]: https://docs.djangoproject.com/en/dev/ref/settings/#std:setting-CACHE_MIDDLEWARE_SECONDS

### apache verbi gratia

This is safe for all our servers

    FileETag MTime Size      # skip inodes in ETag by default. Helps with load-balancing
    Header set Cache-Control "max-age=600, must-revalidate"
