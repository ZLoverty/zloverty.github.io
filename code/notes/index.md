## Notepad++
1. Set up “runPython” in Notepad++ after installing anaconda:
  - Run -> Run (F5)
  - S:\Anaconda\3\condabin\activate.bat base & S:\Anaconda\3\python.exe -i "$(FULL_CURRENT_PATH)"
  - Save as “runPython”, pick an easy-to-use shortcut
  - Now python can be run in Notepad++ with the shortcut created in step c.
2. The run scripts of Notepad++ are saved in `C:\Users\[username]\AppData\Roaming\Notepad++\shortcuts.xml`

## Python
1. Show all available font families in Python:
```python
import matplotlib.font_manager
from IPython.core.display import HTML
def make_html(fontname):
  return "<p>{font}: <span style='font-family:{font}; font-size:
  24px;'>{font}</p>".format(font=fontname)
  code = "\n".join([make_html(font) for font in sorted(set([f.name for f in
  matplotlib.font_manager.fontManager.ttflist]))])
  HTML("<div style='column-count: 2;'>{}</div>".format(code))
```

2. Get immediate subfolders (next function):
```python
import os
folder = '~'
sfL = next(os.walk(folder))[1]
```

3. Bitmap image can be converted to SMOOTH vector image easily using Python. The original
image shown below can be smoothed by the following command:
```python
import matplotlib.pyplot as plt
plt.imshow(data, interpolation='spline16')
```
Then we need to save the smoothed image (vector) in a vector image format (.pdf, .eps, .svg),
using the following command:
```python
plt.savefig(r'I:\Github\Python\ForFun\Peng\OP\OP_pdf.pdf', format='pdf')
```
This is the image where I compare original, pdf and svg savefig outcome:
[compare](img/svg-pdf-compare.pdf)

4. **Matplotlib colormap:** mpl has a convenient way of creating discrete colormap for curves. [more info](https://matplotlib.org/stable/tutorials/colors/colormap-manipulation.html)
```python
from matplotlib import cm
viridis = cm.get_cmap('viridis', 8)
```
Then the colors in the colormap `viridis` can be accessed by `viridis(x)`, where `x` takes value between 0 and 1. For example, `viridis(0.5)` is `(0.122312, 0.633153, 0.530398, 1.0)` in RGBA. All colors can bee seen by calling `viridis`:
![viridis colormap](https://zloverty.github.io/code/notes/img/viridis.png)

There is no need to import `cm` again, since it's already included in `matplotlib.pyplot`, which I almost import every time. An example:
```python
set3 = plt.cm.get_cmap("Set3")
```
The "Set3" colormap is created where colors can be accessed by `set3()`.

![set3 cmap](../../images/2022/01/set3-cmap.png)

5. Convert date object to formatted string: ([reference](https://docs.python.org/3/library/datetime.html))
```python
Timestamp('2022-01-17 00:00:00') -> '01172022'
```
use
```python
date.strftime("%m%d%Y")
```

6. To "stuff" a DataFrame with `np.nan`: when calculating MSD from particle trajectories, we want to have `frame` column to be continuous integer array. However, sometimes in the data, we have `frame = [0, 50, 100, ...]`. To fill all the frames without position data with `np.nan`, we can set `frame` as the index of the DataFrame, then reindex the DataFrame with continuous integers `np.arange(...)`. This creates a trajectory data with continuous frames:

```python
pos = traj.set_index('frame')[pos_columns]
pos = pos.reindex(np.arange(pos.index[0], 1 + pos.index[-1]))
```

NOTE: I found this method in the `trackpy` function `_msd_gaps()`. This has led to a problem when I try to `plt.plot` the MSD data, because there are many `np.nan` in the data, and `plt.plot` cannot show a continuous line. To make the plot out of the MSD data stuffed with `np.nan`, we need to `dropna()` first.

7. Animation in Jupyter notebook and JupyterLab

I find animation a headache before, but was able to do it with `%matplotlib notebook` in Jupyter notebook (a bit laggy though due to massive `plt.imshow()`). However, now I switch to JupyterLab and the old method stopped working completely. Here is the new solution with `ipympl`. ([source](https://matplotlib.org/ipympl/examples/full-example.html))
```python
# load images and create frame number list
img_stack = {}
for num, i in l.iterrows():
    img_stack[int(i.Name)] = io.imread(i.Dir)
frame_numbers = params = l.Name.astype("int")
# plot
plt.ioff()
fig = plt.figure()
plt.ion()
im = plt.imshow(img_stack[params.iloc[0]], cmap="gray")
def update(change):
    im.set_data(img_stack[change['new']])
    fig.canvas.draw_idle()
slider = widgets.IntSlider(value=params.iloc[0], min=params.iloc[0], max=params.iloc[-1])
slider.observe(update, names='value')
widgets.VBox([slider, fig.canvas])
```
This code generates a plot with a slider, which allows quick overview of an image stack by dragging the slider.
![slider](../../images/2022/08/slider.png)

One interesting thing to note in this method is the `set_data` function. Instead of calling `imshow` again and again, `set_data` can apply new data to a plot handle without remaking axes, saving computational power significantly.

## Atom configs
##### 1. Keymap.cson
```CSON
".platform-win32 atom-text-editor:not([mini])":
  "shift-ctrl-K": "markdown-writer:insert-link"
  "shift-ctrl-I": "markdown-writer:insert-image"
  "shift-ctrl-X": "markdown-writer:toggle-taskdone"
  "ctrl-i":       "markdown-writer:toggle-italic-text"
  "ctrl-b":       "markdown-writer:toggle-bold-text"
  "ctrl-'":       "markdown-writer:toggle-code-text"
  "ctrl-h":       "markdown-writer:toggle-strikethrough-text"
  "ctrl-1":       "markdown-writer:toggle-h1"
  "ctrl-2":       "markdown-writer:toggle-h2"
  "ctrl-3":       "markdown-writer:toggle-h3"
  "ctrl-4":       "markdown-writer:toggle-h4"
  "ctrl-5":       "markdown-writer:toggle-h5"

"atom-text-editor":
  "alt-o": "document-outline:toggle"
```

##### 2. Markdown-preview-enhanced customized style
```less
.markdown-preview.markdown-preview {
  @page{
    size: A4;
  }
  @titlecolor:#707fbaff;
  @bodycolor: #111111;

  color: @bodycolor;
  font-family: helvetica;

  h1,h2,h3,h4,h5 {
     font-family: Arial '[-]';
     color: @titlecolor;
     font-weight: light;
  }
}
```
## Linux

1. Disk activity monitor: `sudo iotop`

## Git (GitHub)

1. To reset `.git`: sometimes you want to ignore certain files, which are already tracked in the repository. At times like this, you need to reset the `.git`, which contains the tracking information. First, untrack everything by typing (this removes any changed files from the index(staging area))
```bash
git rm -r --cached .
```
then run
```bash
git add .
```
This adds everything back, but according to the updated `.gitignore`. Commit this change and it's done.

2. Command line authentication: starting from summer 2021, GitHub no longer allow username and password authentication from command line interface. Token authentication becomes required for git operations ([original blog](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)). With this requirement implemented, when I try to clone my repositories using `git clone` on a new, unauthenticated computer, access is denied.

![denied access](../../images/2022/01/denied-access.png)

It's possible to get around this problem with a GUI. In my memory, it was just a set of well-guided steps, involving some clicks in a web browser, and that's it. However, when a GUI is not available, setting up the authentication is not so straightforward.

One way to do it when only command line interface is available, is to generate a pair of SSH keys using `ssh-keygen`. This will generate a pair of key files with encrypted strings.

![example key files](../../images/2022/01/example-key-files.png)

Paste the content of the pub-key (id_rsa.pub) to the "SSH and GPG keys" tab in GitHub account settings page.

![ssh keys page](../../images/2022/01/ssh-keys-page.png)

Click on "New SSH key" and paste the pub key in the blank. Now, try to clone the repo again with `git clone ssh@url.copied.from.github`.

![it works](../../images/2022/01/it-works.png)

3. Build sphinx docs for my code: I used to use a GitHub workflow to automatically build my documentations on each commit to the repo. It worked fine for some time but recently I encounter numerous issues, including "theme not found". A workaround I found is to build the docs locally, and then manually push the docs to the gh-pages branch. Below is the workflow:

  - `make html` in the docs folder
  - copy all the contents in the `build/html` folder to another folder, e.g. desktop
  - switch to gh-pages branch
  - copy the contents in the html folder back to overwrite the html folder in this branch
  - commit and sync to the repo

  This procedure guarantees that as long as I can build the docs correctly locally, I can get correct documentations online. No worries about the failed build for various reasons.

## SSH

1. `ssh` works when the device you are connecting to is in the same private network.
2. VPN tools, such as OpenVPN, can create a virtual private network, allowing connection from outside a private network.
3. By default, closing a ssh session kills any user programs. To keep programs running after closing a session, we can install a software `screen` on the Linux system.
4. Virtual machines can be used to test server behavior.

## ffmpeg

1. Quick start
```bash
ffmpeg -y -framerate 50 -i %05d.jpg -vcodec h264 output.avi
```
`-y` means automatically replace existing file without asking. `-i` specifies input images. _Note that input images can be an image sequence with C style formatted strings as names._ `-vcodec` provides a lot of options of different encoders, among which `h264` is usually a safe choice. _Not many encoders does black and white encodings._ The last argument is always the output file name.

2. `ffmpeg` image sequence formatted input only supports consecutive names, e.g. image0, image1, image2, ... Inconsecutive names such as image0, image2, image4 cannot be converted by default settings. On Linux build, there is an optional setting called "Globbing" that can be switched on by passing `-pattern_type glob`. However, such option is not included on Windows `ffmpeg`. [Source](https://video.stackexchange.com/questions/7300/how-to-get-ffmpeg-to-join-non-sequential-image-files-skip-by-3s/7320#7320)

## Cloud Storage
1. Globus file transfer supports command line interface (CLI). Batch transfer with custom filtering can be achieved.
  - [CLI reference](https://docs.globus.org/cli/reference/)
  - [Globus CLI Batch Transfer Recipe](https://www.globus.org/blog/globus-cli-batch-transfer-recipe)
  - [Automation examples](https://github.com/globus/automation-examples#getting-started)
