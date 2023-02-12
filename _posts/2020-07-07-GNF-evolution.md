---
layout: post
tag: gnf
---

Giant number fluctuation (GNF) is a key distinction of active matter compared to systems in equilibrium. Theories have predicted the deviation of number fluctuations in active matter in a quantitative way. Later on, the predictions are tested in experiment and were mostly true. Despite the success of the theories, the underlying mechanism of GNF still remains to be a hypothesis due to the difficulty of resolving individual active units and the interaction between individual active units in a crowded collection. A recent work by Peng et al. shows that in the transition to active turbulence, flow order and flow energy grow with different time scale. GNF also grows during the course of active turbulence transition, by look at the time scale of this transition, we could gain more insight into the mechanism of GNF.

## Experiment

55 $$n_0$$ light-controlled *E. coli* suspension is sealed into a glass slide chamber and put on microscope. The light voltage is increased from 0V to 12V at $$t=5$$ s. The video is shot at 10 fps and is played 20 times faster of real time (data 060232020/01).

<div>
    <iframe width="640" height="376" src="https://www.youtube.com/embed/nQXKSiHEWLk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Evolution analysis

I use the temporal variance -> spatial average procedure to calculate the giant number flucutation exponents at each time interval of 100 frames (10 seconds). The result is shown below:

![](/assets/images/2020/07/400.png){:width="600px"}

The evolving process can be seen clearly from the increase of $$\alpha$$ after the light is on. However, the fluctuation magnitude at the "steady-state" is large and is not satisfactory. To explore whether the result can be presented better, I use various lengths of video to calculate $$\alpha$$ over time (25, 50, 75 frames).

![](/assets/images/2020/07/i=25.png){:width="600px"}

![](/assets/images/2020/07/i=50.png){:width="600px"}

![](/assets/images/2020/07/i=75.png){:width="600px"}

Turns out the varying segment length used to calculate the GNF evolution does not change the overall increasing-plateau trend. Among the four segment lengths, "25 frames" shows the largest fluctuation in the "plateau" regime, indicating that the length was too short so that the signal is subject to noise. Segment lengths 50, 75 and 100 (the first plot) shows similar fluctuations around plateau, among which "50 frames" gives the best temporal resolution. Hence, it is recommended to set egment length = 50 frames.

## Flow energy and flow order

Following Peng's work, I compare the kinetics of GNF with that of flow energy and flow order. I calculate the flow energy using the formula, assuming the mass of the suspension $$m_i$$ is the same at each location:

$$ 
E = \frac{1}{n}\sum^n_{i=1} \frac{1}{2} \boldsymbol{v_i}^2
$$

![](/assets/images/2020/07/energy_order.png){:width="600px"}

The evolution of flow energy, flow order and GNF together is shown in the plot below:

![](/assets/images/2020/07/60n0.png){:width="600px"}

## Normalizing the image intensities

I noticed that the initial large value of $$\alpha$$ is likely a result of overall illumination change. Hence, I modified the calculation of GNF by normalizing the original image intensity:

$$ 
I'=I/\langle I \rangle
$$

as such, all the modified images now have the same average intensity 1, and the overall illumination variation cannot affect the calculation of $$\alpha$$.

The $$\alpha$$ kinetics curve calculated from normalized images is shown below:

![](/assets/images/2020/07/60n0_norm.png){:width="600px"}

The initial high $$\alpha$$ is still there, because merely normalizing does not exclude the sudden change from a uniform no light image to an actual bacterial suspension image with large spatial variation in intensity.

## Improve statistics

Previously, in order to avoid expensive computation, I set the step for sampling images at 1000 pixels, resulting in very few (4) samples per image. This made the $$\alpha$$ signal noisy, especially the initial part. By reducing the step from 1000 to 500 pixels, the number of samples increases from 4 to 9 in each image. This has led to an improvement in the data, where the initial values of $$\alpha$$ remains low until the increase of flow energy (see the plot below).

![](/assets/images/2020/07/60n0_sample-more.png){:width="600px"}

I further decrease the step to 250 pixels, and let's see if it can reduce the fluctuations of \(\alpha\) further. See below:

![](/assets/images/2020/07/60n0_36-samples.png){:width="600px"}

turns out that smaller step does result in a smoother kinetics curve.

The concentration effect data, which are surely affected by the lack of statistics, will be recalculated with 250-pixel step.