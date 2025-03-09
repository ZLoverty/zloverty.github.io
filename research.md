---
layout: default
title: Research
---

Below is a collection of my research projects. I will ask questions, record progress and showcase results in each of them. 

<div id='libs-panel'>
    {% for item in site.data.research %}
        {% include galleryitem.html name=item.name link=item.link imglink=item.img_link %}
    {% endfor %}
</div>
