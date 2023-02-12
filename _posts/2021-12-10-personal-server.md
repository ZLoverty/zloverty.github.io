---
layout: post
tag: tools
note: the original post was quite short and was not maintained very well. The majority of this post is rewritten on 2023-02-11 to recap the successful solution of personal server.
---

Since 2013, when I was an undergrad working on nanoparticle simulations, I was fascinated by sending the code to a server cluster to execute. The cluster was not faraway at all, like most servers in the world we are interacting with. Instead, they were just ~20 normal computers sitting in a small chamber in our office. They were running all day and all night and produce results silently. 

During my PhD at the University of Minnesota, this experience drove me to try out the Minnesota Supercomputing Institute (MSI), a much larger computing server that serves the whole university. Frankly speaking, MSI is no much different than the "next door" server I used before. After logging into the linux commandline, everything is so familiar. The only difference is I was not allowed to execute my code directly. Instead, I had to submit a job file to "queue" my commands, and the system will decide when my code are executed. I understand that for a server of this scale (for 10,000s people), this "queue" mechanism makes the system more stable. 

After PhD, I join the PMMH lab at ESPCI in France. Here, although there exists a computation cluster, it is managed as a "simulation group only" toy. So I have to adopt a very old fashion work style: analyze my images on laptop. I was very frustrated because, since I started doing research, I've always been using at least a desktop to analyze data. Most of the time, I have access to a powerful cluster. Now, at my postdoc, where I need to process the biggest amount of data in my life, I have the most limited hardware - only a laptop, which needs to all my work related things. 

This is clearly not ideal. I want to set up my own server for data analysis. The first motivation is that I want a fixed "station" for data analysis, nonstop. So that I can freely move my laptop anywhere, restart it, or do anything without worrying about interrupting my analysis. The second motivation is my data are already very large (100's GB each day), and I want to minimize the need of transferring raw data. Therefore, I got started to do so back when I wrote this post (Dec 2021). As of today, I think I have a good solution for my problems, so I record it here for future reference. 

I plan to make my PMMH computer a better server. Here is a to-do list. As things are being implemented, I will keep records of how they are done here for future reference.

- Instead of typing in raw IP address, make an alias for the server, such as @pmmh, @pmmh1
- I use multiple external hard drives to store my data. This is not the best way to store data for sure, because external drives can break very easily. However, this is the cheapest way, and is therefore the most popular way. I have data for the same project, but stored in different drives. In this case, write a piece of code to run over all the data becomes complicated, and most importantly, ugly. It is desired to mount external drives to the same folder, so it's easier to retrieve data and no need to remember where data are physically located. An early solution is to create a link file in my home directory `~/drives` that links to `/media/zhengyang/`, so I can use `~/drives/[drive name]` to access the external drive folders. This saves some typing, but the problem is still there. Recently, I successfully use [mergerfs](https://github.com/trapexit/mergerfs) to mount all the drives to the same directory. All the drives are now at `~/drives`, under which I have folders for different projects, such as `DE`. Inside `DE`, I have data from different drives combined together. 

    ```console
    mergerfs /media/zhengyang\* ~/drives cache.files=off,dropcacheonclose=true,category.create=mfs
    ```

### To-do's

- Implement RAID redundancy to keep data secure.
