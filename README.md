# net-sync-sym
This is the Matlab code accompanying the paper 
**Y.Zhang and A.E.Motter, _Fast, Unified, and Direct Approach to Network Synchronization_**

It includes:
1. sbd_fast.m

  Implementation of Algorithm 1 in the paper, which finds a finest simultaneous block diagonalization of symmetric or Hermitian matrices.

2. examples.m

  Examples showing application of the SBD algorithm to various network synchronization problems (cluster synchroinzation, coupled nonidentical oscillators, networks with multiple interaction types).
  
3. lbmap.m

  Colormap file used for the plots in examples.m. Blue corresponds positive values and red to negative values.
  
4. random_net.txt

  The adjacency matrix used in examples.m.
