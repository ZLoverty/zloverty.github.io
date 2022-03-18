### deLib.py

##### class `droplet_image`

Image processing class of droplet images. For a confocal image with a single bacterial droplet, this class can
- `droplet_traj()`: extract the trajectory of the droplet, usually use together with `moving_mask_piv()`
- `fixed_mask_piv()`: PIV using a fixed mask
- `moving_mask_piv()`: PIV using a moving mask according to droplet trajectory (this is useful when a droplet is driven by bacteria and moves a lot)
- `piv_overlay_fixed()`: generate PIV overlay images for fixed mask PIV data
- `piv_overlay_moving()`: generate PIV overlay images for moving mask PIV data

##### class `fixed_mask_PIV`

Masking procedure test class. The functions are only for testing if different masking procedures change the result of masked PIV. **The test concludes that the difference is negligible.**

##### class `de_data`

Plotting tools class for double emulsion data. It creates an object based on the main double emulsion experiment log "structured_log_DE.ods", and use the data to make plots. This class can
- `parameter_space()`: show the parameter space of DE data
- `generate_msd_repo()`: output MSD plots for all the entries in the main log with available trajectories
- `plot_MSD_model_Cristian`: plot a qualitative MSD predicted by the linear Langevin model
- `look_for_missing_traj()`: check which trajectory is missing in the data repo
- `scatter_0()`: $\tau^*$ vs. $(D-d)/d^2$ scattered plot
- `plot_0()`: $\tau^*$ vs. $(D-d)/d^2$ data binning plot
- `scatter_1()`: $R_\infty$ vs. $(D-d)/d^2$ scattered plot
- `plot_1()`: $R_\infty$ vs. $(D-d)/d^2$ data binning plot
- `Rinf2_tau()`: $R_\infty^2$ vs. $\tau^*$
- `Rinf2_over_tau()`: $R_\infty^2/\tau^*$ vs. $(D-d)/d^2$
- `rescale_Rinf_OD()`: $R_\infty/OD$ vs. $(D-d)/d^2$
- `rescale_Rinf_freespace()`: $R_\infty/(D-d)$ vs. $(D-d)/d^2$
