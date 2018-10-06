# Formulas

## Sum of 1..n

I’ll use a square instead of a rectangle. It’s more complicated but closer to what I did for a sum of squares so humour me.

Can be visualized as a sum of areas of squares of 1×1 in rows from 1 to n.

```txt
▦ - - -
▦ ▦ - -
▦ ▦ ▦ -
▦ ▦ ▦ ▦
```

Roughly it’s the area of rightangled triangle with legs of n. Only the hypothenuse of the triangle cut n squares in halves, and we have to include those halves to. So, `n*n/2 + n/2`, or `(n+1) * n / 2`.

## Sum of 1^2..n^2

Sum of squares can be visualized as a sum of volumes of cubes of 1×1×1, organized in a stack of diminishing squares, n×n, (n-1)×(n-1) etc.

So, say, here’s a frontal view:

```txt
▥ - - -
▦ ▦ - -
▥ ▥ ▥ -
▦ ▦ ▦ ▦
```

Here’s a lateral one:

```txt
- - - ▥
- - ▦ ▦
- ▥ ▥ ▥
▦ ▦ ▦ ▦
```

And here’s a top viev:

```txt
▥ ▦ ▥ ▦
▦ ▦ ▥ ▦
▥ ▥ ▥ ▦
▦ ▦ ▦ ▦
```

In other words, it’s almost a skewed pyramid where one of the edges is vertical.

The volume of the pyramid is l×w×h/3, or `n^3/3`.

But again, the sides of the pyramid cut some cubes in halves. The amount of those cubes for both sides, excluding those along the edge between those sides, is `(n * (n-1) / 2) * 2`. But we ‘return’ only halves of those cubes, so `n * (n-1) / 2`.

Now, along the edge the parts of the cubes we included so far are little pyramids themselves. Pyramids’ volumes are 1/3 of the cubes’ so we underincluded `(2/3)*n`.

So the total volume is: `(n^3/3) + n*(n-1)/2 + 2n/3`, or `(2n^3 + 3n^2 + n) / 6`.

There’s another way to calculate the compensated volume: all the cut cubes, included those along the edge of the pyramid, can be put in a square of n×n, and the volume of that amount of halves is `n^2/2`. But along the edge we had to compensate 2/3 of the volume, not 1/2, so let’s add `n/6` more.

That second way migth be harder to get your around, but the beauty of it is that it accounts directly for each member of the sum: we have basically our pyramid, our (skewed and stretched) square and our, er, slice of a segment %)
