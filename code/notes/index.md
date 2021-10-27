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

## Cloud Storage
1. Globus file transfer supports command line interface (CLI). Batch transfer with custom filtering can be achieved.
  - [CLI reference](https://docs.globus.org/cli/reference/)
  - [Globus CLI Batch Transfer Recipe](https://www.globus.org/blog/globus-cli-batch-transfer-recipe)
  - [Automation examples](https://github.com/globus/automation-examples#getting-started)
