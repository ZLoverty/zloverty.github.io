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
[compare](./img/svg-pdf-compare.pdf)

## Linux
1. When I run many processes (>3) in the background, my computer freezes and many processes are killed. This is due to **resource starvation**. A solution to this is to add `wait` command in between the commands of running processes. For example, I used to run a bash script like this
```bash
python 1.py *** &
python 2.py *** &
python 3.py *** &
python 4.py *** &
```
My computer can run at maximum 3 processes in parallel. As a result, one of the processes is killed. If I add `wait` command after the third command
```bash
python 1.py *** &
python 2.py *** &
python 3.py *** &
wait
python 4.py *** &
```
my computer does not freeze and no process is killed.

2. Ubuntu login loop: after inputting password, Ubuntu sends me back to the login screen again, like an infinite loop. After some searching, I find this a very common problem which is likely caused by incorrectly installed graphics drivers. I've tried several fixes, namely:
  - modify `/etc/run/grub`
  - turn off auto login
  - remove installed Nvidia driver

  But none of the above worked. What eventually worked for me was to enter commandline first by `Ctrl`+`Alt`+`F3`, then type `startx`.

## Cloud Storage
1. Globus file transfer supports command line interface (CLI). Batch transfer with custom filtering can be achieved.
  - [CLI reference](https://docs.globus.org/cli/reference/)
  - [Globus CLI Batch Transfer Recipe](https://www.globus.org/blog/globus-cli-batch-transfer-recipe)
  - [Automation examples](https://github.com/globus/automation-examples#getting-started)

## Git
1. Latex writing with GitHub:
  - [A Git workflow for writing](https://rvprasad.medium.com/a-git-workflow-for-writing-papers-in-latex-4cfb31be4b06)
  - [Tips on collective writing](https://education.github.community/t/github-latex-for-collaborative-writing/35875)
2. How to use branch?
  - [Git Branching - Branches in a Nutshell](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell)
