### pivLib.py

This module contains functions and classes that ease the use of openpiv package for specific usage.

##### Functions

- `PIV1(I0, I1, winsize, overlap, dt, smooth=True)`: normal PIV, use `smoothn()` to smooth the velocity fields.
- `PIV(I0, I1, winsize, overlap, dt)`: normal PIV, use the suggested procedure "validation, replace outliers, median filter" to smooth the velocity fields.
- `PIV_masked(I0, I1, winsize, overlap, dt, mask)`: wrapper of `PIV()`, set velocities outside the true region `np.nan`.
- `read_piv_stack(folder, cutoff=None)`: read PIV data as 3D `numpy.array`'s, with axes (t, u, v)

##### class `piv_data`

Tools for PIV data downstream analysis, such as correlation, mean velocity, derivative fields, energy, enstrophy, energy spectrum, etc.

- `__init__(self, file_list, fps=50)`: Initialize with a PIV data file list.
- `load_stack(cutoff=None)`: load data in 3D arrays
- `vacf(mode="direct", smooth_window=3, xlim=None, plot=False)`: compute velocity autocorrelation function
- `corrS2d(mode="sample", n=10, plot=False)`: compute 2D spatial velocity correlation
- `corrS1d(mode="sample", n=10, xlim=None, plot=False)`: compute 1D spatial velocity correlation, assuming isotropic velocity field
- `mean_velocity(mode="abs", plot=False)`: compute a time series of mean velocity from the PIV data
