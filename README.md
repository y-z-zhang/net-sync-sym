# Finest simultaneous block diagonalization of multiple matrices

This is the MATLAB code accompanying the paper: Y. Zhang and A. E. Motter, _Symmetry-independent stability analysis of synchronization patterns_, [SIAM Rev. 62, 817–836 (2020)](https://doi.org/10.1137/19M127358X).
A variant of the algorithm (implemented in Python and MATLAB), which is simpler but not guaranteed to find the finest SBD in rare cases, can be found [here](https://github.com/y-z-zhang/SBD).

The repository includes:

1. `sbd_fast.m`

  Implementation of the SBD algorithm (Algorithm 1 in the paper), which finds the finest simultaneous block diagonalization of any given set of symmetric matrices. The algorithm works by sequentially exploring invariant subspaces under matrix multiplications.

2. `examples.m`

  Examples showing applications of the SBD algorithm in analyzing network synchronization patterns, including patterns arising from symmetry clusters, Laplacian clusters, input clusters, and chimera states in multilayer networks.

3. `lbmap.m`

  Colormap file used for the plots in `examples.m`. Blue corresponds to positive values and red to negative values. This file is modified from [Light Bartlein Color Maps](https://www.mathworks.com/matlabcentral/fileexchange/17555-light-bartlein-color-maps) by Robert Bemis.

4. random_net.txt

  The adjacency matrix of the 30-node random network used in `examples.m`.
