---
layout: post
tag: tools
language: en
---

I quit Mendeley today, after 5 years of use, because there are serious problems with duplicated files, lack of support for mobile platforms, small cloud drive and poor syncing quality. Solving these problems has been distracting me from focusing on reading, so that I decide to try out some alternatives and leave Mendeley.

After reviewing many alternatives I decided to try **Zotero**, an open-source software that should be able to connect with google drive, so I don't have to pay for cloud storage one more time.

I've realized some advantages of Zotero already in this first minute of use, for example this standalone note functionality. I can just write a single piece of note here with a paper open beside.

There might be more to discover in Zotero. Let's see if this Zotero is a better tool.

## 1. Setup Zotero + Google Drive
### A. Batch import from files
  - Edit -> Preference

  ![preference](/assets/images/2021/12/preference.png){:width="600px"}

  - Uncheck file sync

  ![file sync off](/assets/images/2021/12/file-sync-off.png){:width="600px"}

  - Set base folder to google drive folder

  ![base folder](/assets/images/2021/12/base-folder.png){:width="600px"}

  - Copy .pdf files to google drive folder

  ![gd folder](/assets/images/2021/12/gd-folder.png){:width="600px"}

  - Create linked attachments in Zotero

  ![link to fiel](/assets/images/2021/12/link-to-fiel.png){:width="600px"}

  - Import all the files

  ![import all](/assets/images/2021/12/import-all.png){:width="600px"}

  - Zotero will automatically analyze the metadata of .pdf files and put them into parent items

  ![analyzed items](/assets/images/2021/12/analyzed-items.png){:width="600px"}

  - From now on, we have transferred all the references from Mendeley to Zotero.

### B. Daily use
If we only want to add one reference to our library when browsing the Internet, we can in principle do the same things as in the batch import guide: download the .pdf file to google drive folder and then add linked files. However, there are easier ways to do it. That is to use the chrome extension **Zotero Connector**. We first add the extension to Chrome by clicking the button on Zotero's official website.

![download connector](/assets/images/2021/12/download-connector.png){:width="600px"}

Then we can access the extension at the upper right corner of Chrome. For example, we want to add a reference _Frangipane, G., Vizsnyiczai, G., Maggi, C., Savo, R., Sciortino, A., Gigan, S., et al. (2019). Invariance properties of bacterial random walks in complex structures. Nat. Commun. 10:2442._. We first go to the website of the paper, then click the **Zotero Connector** extension.

![chrome extension example](/assets/images/2021/12/chrome-extension-example.png){:width="600px"}

The following window will show us the files to be downloaded. In this case, it's a full text pdf and a snapshot of the website where I download the paper. I can also specify where to put this paper, so that we can skip the _undefined_ folder.

![zotero connector](/assets/images/2021/12/zotero-connector.png){:width="600px"}

Now in the Papers folder, we can find the item we just created, with exactly the same attachments we just saw in the Chrome extension: a full text pdf and a snapshot.

Where are the files saved locally though? If we right click on the attachment and click _show file_, we can see that this paper is put in the google drive Zotero folder, just as we expect.

![gd folder connector](/assets/images/2021/12/gd-folder-connector.png){:width="600px"}

Notice that this is not the default behavior... This is achieved by a Zotero third-party plugin [ZotFile](http://zotfile.com/). After installation, we can modify the settings of **ZotFile** at Tools -> ZotFile preferences

![zotfile pref](/assets/images/2021/12/zotfile-pref.png){:width="600px"}

Set the _Location of Files_ to he google drive Zotero folder. Done!

![set file dir](/assets/images/2021/12/set-file-dir.png){:width="600px"}

We can also change the naming rules to make it consistent with all other attachment files.

![naming rules](/assets/images/2021/12/naming-rules.png){:width="600px"}

## 2. Mobile compatibility, esp. annotations

1. Open a document on my cell phone using Foxit Reader

![IMG_8094](/assets/images/2021/12/IMG_8094.PNG){:width="600px"}

2. Add a text comment

![IMG_8095](/assets/images/2021/12/IMG_8095.PNG){:width="600px"}

3. Save the document, choose **PATH** to be the google drive

![IMG_8096](/assets/images/2021/12/IMG_8096.PNG){:width="600px"}

4. Replace the original file

![IMG_8097](/assets/images/2021/12/IMG_8097.PNG){:width="600px"}

5. The annotation appears on my laptop Zotero file

![sync annotation](/assets/images/2021/12/sync-annotation.png){:width="600px"}

This method works, though the operations are complicated. I'm looking forward to the Zotero official iOS app, which should make this sync easier.
