---
layout: post
language: en
date: 2024-12-27
title: youtube audio prep
tag: tools
---

Recently, I got interested in listening to history lectures on Youtube. Since many of the lectures are long and the video part is usually unimportant, I start to conceive a more portable format of lecture, which is ad-free and does not require Internet access. This leads to the idea of downloading the videos and converting them to audios came up. 

## Batch download

I started with websites like *y2mate*. They worked, but when I want to download a series of videos, they are not satisfactory because I have to wait for the first one to complete before starting the second one. Ideally, I should be able to make a list of videos I want to download and to have a software keep downloading according to the list -- to enable batch download. 

This led me to the software [yt-dlp](https://github.com/yt-dlp/yt-dlp). It is a command line tool which download Youtube videos with a one-line command. The command typically looks like

```console
yt-dlp [--options] URL
```

Batch download is simple: 

- create a .bat file
- in a text editor, repeat the command with different URLs

```
# batch-download.bat

yt-dlp [--options] URL1
yt-dlp [--options] URL2
yt-dlp [--options] URL3
yt-dlp [--options] URL4
```

When execute the *batch-download.bat* file in a terminal, all the videos will be downloaded. 

## Audio

By default, *yt-dlp* downlaods videos. To download audio only, the `--options` need to be configured correctly. Here's an example:

```
yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 URL
```

## Member-only content

Some videos require subscription to the channel to view/download. To make *yt-dlp* authorized to download member-only content, we need to pass the cookies of the browser as an argument in the command. First, download the cookies using the chrome extension [Get cookies.txt LOCALLY](https://chromewebstore.google.com/detail/get-cookiestxt-locally/cclelndahbckbenkjhflpdbgdldlbecc). The cookies txt file looks like this:

```
# Netscape HTTP Cookie File
# http://curl.haxx.se/rfc/cookie_spec.html
# This is a generated file!  Do not edit.

.youtube.com	TRUE	/	TRUE	1751208406	LOGIN_INFO	AFmmF2swRAIgbOeLIrLuxRY6YyAL9bauDQXDbVxJdIt_xa1t7RM-HjwCIAM1viLjg9sWq_Qc4y1_mPQZYFW6Jfx_7FM_X2gkoblx:QUQ3MjNmek1nd0hvUGFGdDRoRXEyRWNudW1XdEh6Z3Rhb1VNTnhCdE0zRXozSzRjZk5qOGtvX24wQk1DTUlDRnJET055cHN0SW9RUlByZUpJOE9yaTdvRnhOUENUMHFxTTg0Wm5zR2RIU25qbkhfRHVYd0hpZmpmOEgyaS0xR1RtWDhfa2VOZGQ4ZDlTTmZTd0RTeng3WDFXZzZVSkZkaUJR
.youtube.com	TRUE	/	FALSE	1769051874	HSID	A-iCb3kDOJnG5AD6S
.youtube.com	TRUE	/	TRUE	1769051874	SSID	AV_KZaPZG2UsQDFu4
.youtube.com	TRUE	/	FALSE	1769051874	APISID	qlZgHSCBNqOiSYjk/AbEDyy7SdG_vUo0EM
.youtube.com	TRUE	/	TRUE	1769051874	SAPISID	z9PnNR9VFR5N3Jf4/AgcS_3AQA9DbPWNeU
.youtube.com	TRUE	/	TRUE	1769051874	__Secure-1PAPISID	z9PnNR9VFR5N3Jf4/AgcS_3AQA9DbPWNeU
.youtube.com	TRUE	/	TRUE	1769051874	__Secure-3PAPISID	z9PnNR9VFR5N3Jf4/AgcS_3AQA9DbPWNeU
```

Then, put this .txt file in the same directory as the .bat file and the *yt-dlp* executable. Lastly, add the cookies argument to the command. The final command looks like:

```
yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 URL --cookies cookies.txt
```

## Concatenate audios

A complete long lecture are usually divided into small segments for easier browsing on Youtube. For listening, I'd prefer to group the same topic in one audio file. A good way to concatenate audio files is the linux software `sox`. First, put the audio files from one lecture into a same master folder. Then, run WSL, navigate to this folder (`/mnt/c/Users/...`), run the following command:

```
$ sox *.mp3 out.mp3
```

This creates an all-in-one lecture. Happy learning!