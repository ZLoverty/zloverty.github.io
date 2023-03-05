---
layout: post
tag: gnf
language: en
---

We have two methods for computing energy spectrum from spatial velocity data. In this post we should how they are related and point out quantitative details when converting between the results from these methods.

## 1 Two methods

### 1.1 FFTreal: real part of standard fft

Energy spectrum function $$E(k)$$ is defined as

$$
E(k) = \oint \frac{1}{2} \Phi_{ii}(k)d S(k)
$$

where $$\Phi_{ii}(k)$$ is the diagonal term of velocity spectrum tensor, defined as

$$
\Phi_{ij}(k) = \iiint\limits_{-\infty}^{\infty} R_{ij}(r)e^{-ik\cdot r} dr
$$

here $$r$$ is position vector (x, y, z) and $$R_{ij}$$ is spatial velocity correlation of $$u_i$$, $$u_j$$ and $$u_k$$.

It is not feasible to measure the full 3 dimensional flow simultaneous, so take a step back and measure $$R_{11}(x, y)$$, and thus $$\Phi_{11}(k_x, k_y)$$.

One dimensional spectra $$E_{ij}(k_1)$$ are defined to be twice the one dimensional Fourier transform of $$R_{ij}(e_1r_1)$$:

$$
E_{ij}(k_1) \equiv \frac{1}{\pi}\int^\infty_{-\infty} R_{ij}(e_1r_1)e^{-ik_1r_1}d r_1
$$

Since the flow in the textbook is measured by hot wire, which is naturally 1D, whereas PIV is naturally 2D, I adapt the equation above to a 2D velocity correlation function version:

$$
E_{11}(k_x, k_y) \equiv \frac{1}{\pi}\int^\infty_{-\infty} R_{11}(x, y)e^{-ik\cdot r}d^2r
$$

### 1.2 velFT: Yi's method

$$
E(k_x, k_y) = \langle u_k(k_x, k_y)u^*_k(k_x, k_y)+v_k(k_x, k_y)v_k^*(k_x, k_y)\rangle/2
$$

The angle bracket $$\langle\rangle$$ denotes an average over consecutive frames.

### 1.3 How they are related?

The idea is to derive the energy spectrum definition in Yi's formula to the velocity correlation definition.

$$
E(k_x, k_y) = u_k(k_x, k_y)u_k^*(k_x, k_y)\\
= \iint u(x, y)e^{-ik_xx}e^{-k_yy}dxdy\left[\iint u(x', y')e^{-ik_xx'}e^{-ik_yy'}dx'dy'\right]^*\\
= \iint u(x, y)e^{-ik_xx}e^{-k_yy}dxdy\iint u^*(x', y')e^{ik_xx'}e^{ik_yy'}dx'dy'\\
= \iiiint u(x, y)u(x', y')e^{-ik_x(x-x')}e^{-k_y(y-y')}dxdydx'dy'\\
$$

here, we change variable and let $$x'' = x - x'$$ and $$y'' = y - y'$$ the original expression can be rearranged into

$$
\iiiint u(x'+x'', y'+y'')u(x', y')e^{-ik_xx''}e^{-k_yy''}d(x'+x'')d(y'+y'')dx'dy'\\
= \iint \left[\iint u(x'+x'', y'+y'')u(x', y')dx'dy'\right] e^{-ik_xx''}e^{-k_yy''} d(x'+x'')d(y'+y'')
$$

using the definition of velocity correlation function (average all possible pairs over available space):

$$
\langle u(x, y)u(x+x'', y+y'') \rangle = \frac{\iint u(x'+x'', y'+y'')u(x', y')dx'dy'}{\iint dx'dy'}
$$

we obtain

$$
\iint dx'dy'\iint \langle u(x, y)u(x+x'', y+y'') \rangle e^{-ik_xx''}e^{-k_yy''} dx''dy''\\
$$

the first integration is the available space size of velocity field, in this case the size of field of view $$A$$. In the code, $$A$$ should be step size $$s$$ times the row number $$r$$ and column number $$c$$ of velocity matrix size:

$$
A = rcss
$$

Note that $$r$$ and $$s$$ should have no unit and $$s$$ should have unit um. 

Let's draw a comparison between the two methods. Method I:

$$
E_1(k_x, k_y) = \iint \langle u(x, y)u(x+x'', y+y'') \rangle e^{-ik_xx''}e^{-k_yy''} dx''dy''
$$

Method II:

$$
E_2(k_x, k_y) = \iint dx'dy' \iint \langle u(x, y)u(x+x'', y+y'') \rangle e^{-ik_xx''}e^{-k_yy''} dx''dy''\\
= A  \iint \langle u(x, y)u(x+x'', y+y'') \rangle e^{-ik_xx''}e^{-k_yy''} dx''dy''
$$

Thus

$$
E_1(k_x, k_y) = \frac{E_2(k_x, k_y)}{A}
$$

We show that the two methods are equivalent mathematically. Next, we test this equivalence using experimental data.

![xiang1](/assets/images/2020/12/energy_spectrum_derivation_1.jpg){:width="600px"}
![xiang2](/assets/images/2020/12/energy_spectrum_derivation_2.jpg){:width="600px"}