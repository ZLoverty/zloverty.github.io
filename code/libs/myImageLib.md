### myImageLib.py

This module has helper classes and functions for routine image analysis.

##### Functions

**General, IO, image processing and plotting**

- `dirrec(path, filename)`: look for files in a given path that matches filename
- `to8bit(image)`: convert image of any bit depth to 8-bit
- `bpass(img, low, high)`: apply bandpass filter on images
- `bestcolor(n)`: default plot color scheme of Matplotlib and Matlab, "tab10" colormap
- `wowcolor(n)`: WOW class color scheme, used in my density fluctuations paper
- `readdata(folder, ext="csv")`: wrapper of `dirrec()`, return DataFrame of ("Name", "Dir")
- `show_progress(progress, label='', bar_length=60)`: show progress in command line

**corrTrack**

- `matlab_style_gauss2D(shape=(3,3), sigma=0.5)`: 2D gaussian mask - should give the same result as MATLAB's `fspecial('gaussian',[shape],[sigma])`
- `FastPeakFind(data)`: utility function of `track_spheres_dt()`
- `minimal_peakfind(img)`: utility function of `track_spheres_dt()`
- `maxk(array, num_max)`: utility function of `track_spheres_dt()`
- `track_spheres_dt(img, num_particles)`: find particle based on cross-correlation and distance transofrm
- `gauss1(x,a,x0,sigma)`: 1-D gaussian function generator

##### class `rawImage`

Raw image converting schemes. Currently, I work with two raw image types: "nd2" and "raw". The class can convert raw images into tif sequences for downstream analysis. More features, such as generating preview images, can be implemented if needed.

- `extract_tif()`: extract tif sequences from *.nd2 or *.raw files. 
