---
date: 2023-03-10
title: Principle Componenets Analysis
tag: learn
language: en
---

I have tried to learn machine learning a few times. However, I never find the chance to implement any machine learning algorithm in my research. Here, I want to revisit the subject by reading Goodfellow's book. I like simple things, because they help me understand the basic concept and gain intuition to the abstract math. Principle componenets analysis is such a simple thing, which I shall take some notes here to try to understand. 

### The problem -- data compression

We want to compress a collection of points \( \{x^{(1)}, ..., x^{(m)}\} \) in \(\mathbb{R}^n\) into code points \( \{c^{(1)}, ..., c^{(m)}\} \) in \(\mathbb{R}^l\), where \( n>l \). We want an encode \( f(\bm{x})=\bm{c}\) and a decoder \( g(\bm{c}) \approx \bm{x}\).


A simple choice of the decoder is a matrix \( \bm{D} \) in \( \mathbb{R}^{n\times l}\), \( g(\bm{c}) = \bm{D}\bm{c}\). The goal is to find the best encoder and decoder, so that the distance between original points \(\bm{x}\) and the reconstructed points \(\bm{r}\) is minimized. Formally, we want to solve the following optimization:

$$
\bm{D} ^ * = \argmin_{\bm{D}} \sum_i || \bm{x}^{(i)} - \bm{r}^{(i)} ||_2 .
$$

where \( \bm{r} = g(f(\bm{x})) = \bm{D}f(\bm{x})\). To make the problem solvable, we need to figure out what is the encoder \(f(x)\). One way to do this is to make the distance between the reconstructed points closest to the original points, formally:

$$
\bm{c}^* = \argmin_{\bm{c}} || \bm{x} - g(\bm{c}) ||_2 .
$$

This is equivalent to 

$$
\argmin_{\bm{c}} || \bm{x} - g(\bm{c}) ||_2^2 
$$

we can expand the square:

$$
\argmin_{\bm{c}} (\bm{x} - g(\bm{c}))^\top (\bm{x} - g(\bm{c}))
$$

$$
\argmin_{\bm{c}} \bm{x}^\top\bm{x} - g(\bm{c})^\top \bm{x} -  \bm{x}^\top g(\bm{c}) + g(\bm{c})^\top g(\bm{c})
$$

\(\bm{x}^\top\bm{x}\) is irrelevant since it does not contain \(\bm{c}\) we are optimizing. \(g(\bm{c})^\top \bm{x}\) and \(\bm{x}^\top g(\bm{c})\) are scalars, so they are equal. At this point, we can substitute the exact form of \(g(\bm{c})\), the objective function becomes

$$
\argmin_{\bm{c}}  - 2 (\bm{D}\bm{c})^\top \bm{x} + (\bm{D}\bm{c})^\top \bm{D}\bm{c}
$$

$$
\argmin_{\bm{c}}  - 2 \bm{c}^\top \bm{D}^\top \bm{x} + \bm{c}^\top \bm{D}^\top \bm{D}\bm{c}
$$

$$
\nabla_{\bm{c}} (- 2 \bm{c}^\top \bm{D}^\top \bm{x} + \bm{c}^\top \bm{D}^\top \bm{D}\bm{c}) \\
= - 2 \bm{D}^\top \bm{x} + 2 \bm{D}^\top \bm{D}\bm{c} 
$$

The 0-gradient point corresponds to a local minimum, which is the \(\bm{c}^*\) we are looking for. 

$$
\bm{x} = \bm{D} \bm{c}^*,\, \bm{c}^* = \bm{D}^\top\bm{x}
$$

The best encoder \(f(\bm{x})\) is found to be \(\bm{D}^\top\bm{x}\).

Next, we solve the optimization for \( \bm{D}^* \) to minimize the distance between original data \(\bm{x}\) and reconstructino \(\bm{r} = \bm{D}\bm{D}^\top\bm{x}\).

$$
\bm{D} ^ * = \argmin_{\bm{D}} \sum_i || \bm{x}^{(i)} - \bm{D}\bm{D}^\top\bm{x}^{(i)} ||_2
$$

To simplify the derivation, we can look at a special case where \(l=1\), i.e. \(\bm{D}\) is \(\mathbb{R}^1\). We denote \(\bm{D}\) in this special case \(\bm{d}\), and rewrite the objective function

$$
\bm{D} ^ * = \argmin_{\bm{d}} \sum_i || \bm{x}^{(i)} - \bm{d}\bm{d}^\top\bm{x}^{(i)} ||_2
$$

The summation can be written in a more compact form if we let \( \bm{X}_{i, :} = \bm{x}^{(i)\top}  \), or 

$$
\bm{X} = 
\begin{bmatrix}
\bm{x}^{(1)\top} \\
\vdots \\
\bm{x}^{(m)\top}
\end{bmatrix}
$$

we can write the objective function as 

$$
\bm{D} ^ * = \argmin_{\bm{d}} \sum_i || \bm{x}^{(i)\top} - \bm{x}^{(i)\top} \bm{d}\bm{d}^\top||_2
$$

stack all the \( \bm{x}^{(i)\top} \)

$$
\bm{D} ^ * = \argmin_{\bm{d}} || \bm{X} - \bm{X} \bm{d}\bm{d}^\top||_F
$$

Here, the subscript \(_F\) denotes Frobenius norm, which measures the size of a matrix. This norm can be written in trace form:

$$
\bm{D} ^ * = \argmin_{\bm{d}} \text{Tr}\left( \left( {\bm{X} - \bm{X} \bm{d}\bm{d}^\top}\right)^\top \left( {\bm{X} - \bm{X} \bm{d}\bm{d}^\top}\right) \right) \\
= \argmin_{\bm{d}} \text{Tr}\left( \bm{X}^\top \bm{X} -  \bm{d}\bm{d}^\top\bm{X}^\top\bm{X} - \bm{X}^\top\bm{X}\bm{d}\bm{d}^\top + \bm{d}\bm{d}^\top\bm{X}^\top \bm{X}\bm{d}\bm{d}^\top\right) \\
= \argmin_{\bm{d}} \text{Tr}\left( \bm{X}^\top \bm{X} \right) -  \text{Tr}\left(\bm{d}\bm{d}^\top\bm{X}^\top\bm{X} \right) - \text{Tr}\left( \bm{X}^\top\bm{X}\bm{d}\bm{d}^\top \right) + \text{Tr}\left( \bm{d}\bm{d}^\top\bm{X}^\top \bm{X}\bm{d}\bm{d}^\top \right) \\
= \argmin_{\bm{d}} - \text{Tr}\left(\bm{d}\bm{d}^\top\bm{X}^\top\bm{X} \right) \\
= \argmax_{\bm{d}} \text{Tr}\left(\bm{d}\bm{d}^\top\bm{X}^\top\bm{X} \right) \, \text{subject to} \; \bm{d}^\top\bm{d} = 1
$$

\( \bm{X}^\top \bm{X} \) can be eigendecomposed into \( \bm{V}\bm{\Lambda}\bm{V}^\top \), where \( \bm{V} \) is the eigenvector matrix \( [ \bm{v}^{(1)} \dots \bm{v}^{(n)} ] \) and \( \bm{\Lambda} \) is the diagonal matrix of eigenvalues \( \text{diag}(\lambda_i) \). Substitute the eigendecomposition into the objective function, we get

$$
\argmax_{\bm{d}} \text{Tr}\left(\bm{d}\bm{d}^\top\bm{V}\bm{\Lambda}\bm{V}^\top \right) \, \text{subject to} \; \bm{d}^\top\bm{d} = 1 \\
= \argmax_{\bm{d}} \text{Tr}\left(\bm{d}^\top\bm{V}\bm{\Lambda}(\bm{d}^\top\bm{V})^\top \right) \, \text{subject to} \; \bm{d}^\top\bm{d} = 1
$$

Here \(\bm{d}^\top\bm{V}\) is a row vector. The result inside the trace is a scalar, and can be written as a summation of squares

$$
\sum_i \lambda_i (\bm{d}^\top \bm{v}^{(i)})^2 = \sum_i \lambda_i  \bm{v}^{(i)\top }\bm{d}\bm{d}^\top \bm{v}^{(i)}
$$

If we ignore the eigenvalue coefficient, the summation \( \sum_i (\bm{d}^\top \bm{v}^{(i)})^2 \) is the sum of \( \bm{d} \) components in \( \bm{V} \) space, so it is 1. To maximize the objective function, the best strategy is to let the largest eigenvalue have the biggest weight, which leads to 

$$
\bm{d} ^ * = \bm{v}^{(i)}, \, i = \argmax_j \lambda_j 
$$

that is, the best encoder and decoder set is the eigenvector that corresponds to the largest eigenvalue. This makes sense. The eigendecomposition maps the original data onto the eigenvector space. The largest eigenvalue denotes the longest component of the data set in this space. 

More principle components can be shown to be other large eigenvectors by proof of induction. The key steps are:

1. when \(l = k\), assume

$$
\bm{D}^* = \argmax_{\bm{D}} \text{Tr} \left( \bm{D}\bm{D}^\top\bm{X}^\top\bm{X}\right) = \bm{V}_{:k, :}
$$

2. when \(l = k + 1\)

$$
\argmax_{\bm{D}, \bm{d}} \text{Tr} \left( [\bm{D}, \bm{d}]^\top\bm{X}^\top\bm{X}[\bm{D}, \bm{d}]\right) \\
= \argmax_{\bm{D}, \bm{d}} \text{Tr} \left( [\bm{D}, \bm{d}]^\top\bm{V}\bm{\Lambda}\bm{V}[\bm{D}, \bm{d}]\right) \\
= \argmax_{\bm{D}, \bm{d}} \text{Tr} \left( \bm{D}^\top\bm{V}\bm{\Lambda}\bm{V}\bm{D}\right) + \text{Tr} \left( \bm{d}^\top\bm{V}\bm{\Lambda}\bm{V}\bm{d}\right) \, \text{subject to} \; \bm{D'}^\top\bm{D'} = \bm{I}
$$

\(\bm{D'}=[\bm{D}, \bm{d}]\). Since \(\bm{D'}\) is orthogonal, we cannot have the same vectors. The best choice of \(\bm{d}\) is the eigenvector that corresponds to the largest eigenvalue, which is not already in \(\bm{D}\). Therefore,

$$
\bm{d} = \bm{v}^{(k+1)}
$$

It is also desired to have some examples of image compression. Let's do a simple one. 

```python
import numpy as np

np.random.seed(0)
X = np.random.rand(100, 100) # random 2d array
XX = np.matmul(X.T, X) # X.T X
w, v = np.linalg.eig(XX) # eigendecomp
```

Then compute compression and reconstruction.

```python
import matplotlib.pyplot as plt

for number_principle_components in [2, 50, 100]:
    D = v[:, :number_principle_components]
    C = D.T @ X
    R = D @ C

    fig, ax = plt.subplots(1, 2, figsize=(6, 3), dpi=100)
    ax[0].imshow(X)
    ax[1].imshow(R)
```

![picture 1](/assets/images/2023/03/n2.png)  
![picture 2](/assets/images/2023/03/n50.png)  
![picture 3](/assets/images/2023/03/n100.png)  

![picture 4](/assets/images/2023/03/real-picture-compression.png)  

This is indeed a very simple compression algorithm, which does not recover good image quality.