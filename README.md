# net-sync-sym
This is the Matlab code accompanying the paper
**_Fast and symmetry-independent stability analysis of cluster synchronization patterns_, Y.Zhang and A.E.Motter.**

It includes:
1. sbd_fast.m

  Implementation of the SBD algorithm (Algorithm 1 in the paper), which finds a finest simultaneous block diagonalization of any given set of symmetric matrices.

2. examples.m

  Examples showing applications of the SBD algorithm in analyzing network synchronization patterns. (Including patterns arising from symmetry clusters, Laplacian clusters, equitable clusters, as well as chimera states in multilayer networks.)

3. lbmap.m

  Colormap file used for the plots in examples.m. Blue corresponds to positive values and red to negative values.

4. random_net.txt

  The adjacency matrix of a 30-node random network used in examples.m.
