---
# front matter tells Jekyll to process Liquid
layout: default
title: Code
---

Although I was trained as an experimental physicist, I found data analysis the most fulfilling part of my work, probably because I enjoyed **coding** and **documentation**. Over the years, I have kept coding notes on things I have to look up multiple times. I  have also developed a number of tools to help me with data analysis. For example, a general tool package [myimagelib](mylib) for file handling and image processing; an adapted particle tracking algorithm [bwtrack](bwtrack) for distinguishing black and white particles; a GUI software [manTrack](manTrack) for manual correction of tracking results; and a new algorithm [imfindcircles](https://zloverty.github.io/mylib/tests/find_circles.html) for improved accuracy of finding circles. 

<div id='libs-panel'>
    {% for item in site.data.code_items %}
        {% include galleryitem.html name=item.name link=item.link imglink=item.img_link %}
    {% endfor %}                
</div>

