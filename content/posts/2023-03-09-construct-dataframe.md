---
Title: "How to construct pandas DataFrame efficiently"
tag: "tools"
language: "en"
---

Today, I was reviewing my [droplet tracking code](https://github.com/ZLoverty/DE/blob/main/Code/HoughCircles-DE.ipynb) and saw an interesting way to construct `pandas.DataFrame`:

1. Construct a list of DataFrame, each representing a row: `row_list = [pd.DataFrame({"a": i, "b": 2*i} for i in range(100))]`
2. Concatenate the list into a bigger DataFrame: `df = pd.concat(row_list)`

This is not what I normally do, and that's probably why I find it interesting. Normally, I would 

1. populate two lists for `a` and `b`: `a_list = [i for i in range(100)]; b_list = [2*i for i in range(100)]`
2. use the lists to initiate DataFrame: `df = pd.DataFrame({"a": a_list, "b": b_list})`

Intuitively, the second way is faster, because it involves less DataFrame construction. But I do like the first way, in that I do not have to initiate many temporary lists. So I Google it and find [this question](https://stackoverflow.com/questions/17091769/python-pandas-fill-a-dataframe-row-by-row), which gives another intuitive way to do this:

1. initiate a DataFrame with the right dimensions, but full of NaN: `df = pd.DataFrame(columns=["a", "b"], index=range(100))`
2. set values to each row progressively: `df.loc[i] = {"a": i, "b": 2*i}`

I don't find an answer which is the faster way, or preferred way, to construct the same DataFrame. So I do a small test here.

```python
# dftest.py
import pandas as pd
import time

ind = range(10000)

# method 1
tic = time.monotonic()
row_list = [pd.DataFrame({"a": i, "b": 2*i} for i in ind)]
df = pd.concat(row_list)
toc = time.monotonic()
print("method 1: {:.4f} s".format(toc - tic))

# method 2
tic = time.monotonic()
a_list = [i for i in ind]
b_list = [2*i for i in ind]
df = pd.DataFrame({"a": a_list, "b": b_list})
toc = time.monotonic()
print("method 2: {:.4f} s".format(toc - tic))

# method 3
tic = time.monotonic()
df = pd.DataFrame(columns=["a", "b"], index=ind)
for i in ind:
    df.loc[i] = {"a": i, "b": 2*i}
toc = time.monotonic()
print("method 3: {:.4f} s".format(toc - tic))
```

Then run it.

```console
$ python dftest.py
method 1: 0.0150 s
method 2: 0.0000 s
method 3: 1.7810 s
```

Method 2 is the fastest way to construct a DataFrame. Method 1 is also OK for small data, but the fact that it is slower than method 2 suggests that constructing many DataFrame objects takes extra time. Method 3, although being intuitive, is the slowest way. The method is useful for replacing a few spurious data, but not ideal for constructing big DataFrames from scratch.