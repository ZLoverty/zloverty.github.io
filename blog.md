---
layout: default
title: blog
---

{% for post in site.posts %}
    {% if post.language == "en" %}

- ## <a id="blog-title" href="{{ post.url }}">{{ post.title }}</a>
        
    {{ post.excerpt }}

    {% endif %}
{% endfor %}