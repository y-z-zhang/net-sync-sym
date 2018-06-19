%% Fast Simultaneous Block Diagonalization
%%                      by Yuanzhao Zhang (yuanzhao@u.northwestern.edu)

%%%%%%%%
%PURPOSE 
%%%%%%%%
%% This code finds a finest simultaneous block diagonalization (SBD) of a set of
%% symmetric or hermitian matrices A within the field \mathbb{R} or \mathbb{C}.
%% It also works for generic matrices (not necessarily symmetric or hermitian),
%% the SBD will then be finest in the sense of matrix *-algebra.

%%%%%%%
%USEAGE 
%%%%%%%
%% P = sbd(A,field)
%% A --- the cell array containing the set of matrices to be simultaneously block diagonalized
%% field --- 'real' or 'complex'
%% threshold --- error tolerance for linear indepedence test (suitable choice makes the algorithm robust against error in matrix data)
%% P --- the orthogonal/unitary transformation matrix that performs SBD on A

%%%%%%%%%%
%REFERENCE 
%%%%%%%%%%
%% Y.Zhang and A.E.Motter, "FAST, UNIFIED, AND DIRECT APPROACH TO NETWORK SYNCHRONIZATION"

function P = sbd(A,field,threshold) 

  n = size(A{1}, 2);  %% size of the matrices to be simultaneously block diagonalized
  P = [];             %% initialize the transformation matrix
  idx = 1:n;          %% idx is used to track which eigenvectors of B are in the span of P's column vectors

  %% B is a random self-adjoint matrix generated by matrices from A (and their conjugate transposes)
  B = zeros(n);
  for p = 1:size(A,2)
    switch field
      case 'real'
        B = B + randn*(A{p}+(A{p})');
      case 'complex'
        B = B + randn*(A{p}+(A{p})') + i*randn*(A{p}-(A{p})');
    end 
  end

  [V,D] = eig(B);      %% find the eigenvalues and eigenvectors of B

  %% loop until the transformation matrix is n-by-n, each loop finds a new invariant subspace (thus also common block) of matrices in A
  while size(P,2) < n       
    if idx == 1:n           %% if this is the first loop
      v(:,1) = V(:,1);      %% pick one of the eigenvectors of B 
      idx(1) = 0;
    else
      %% find one eigenvector of B that is not in the span of P's column vectors
      while true
        ind = find(idx > 0);
        v_test = V(:,ind(1));   %% pick one of the remaining eigenvectors of B
        for ii = 1:size(P,2)    %% test whether v_test is in the span of P's column vectors using Gram–Schmidt
          v_test = v_test - proj(P(:,ii),v_test);
        end
        if norm(v_test) > threshold   %% if not, use v_test to find new invariant subspaces under matrices in A
          v = [];
          v(:,1) = v_test;
          idx(ind(1)) = 0;
          break
        else                    %% otherwise, mark v_test as already in the span of P's column vectors and repeat
          idx(ind(1)) = 0;
        end
      end
    end
  
    %% generate new vectors by applying matrices in A and their conjugate transposes to v_test
    for p = 1:size(A,2)
      v(:,2*p) = A{p}*v(:,1);
      v(:,2*p+1) = (A{p})'*v(:,1);
    end
  
    %% find linearly indepedent vectors among v_test and its images under A as well as A', make them orthonormal
    for ii = 1:2*size(A,2)+1
      if norm(v(:,ii)) > threshold
        v(:,ii) = v(:,ii) / norm(v(:,ii));
        for jj = ii+1:2*size(A,2)+1
          v(:,jj) = v(:,jj) - proj(v(:,ii),v(:,jj));
        end
      else
        v(:,ii) = zeros(n,1);
      end
    end
  
    %% get rid of the redundant vectors
    for ii = 2*size(A,2)+1:-1:1
      if v(:,ii) == zeros(n,1)
        v(:,ii) = [];
      end
    end
  
    %% attemp to expand v to form an invariant subspace under matrices in A
    flag = 1;
    while flag == 1
      flag = 0;
      v1 = zeros(n,1);
      for ii = 1:size(v,2)      %% generate a random linear combination of the orthonormal vectors
        switch field
          case 'real'
            v1 = v1 + randn * v(:,ii);
          case 'complex'
            v1 = v1 + (randn + randn*i) * v(:,ii);
        end 
      end
      for p = 1:size(A,2)       %% see if applying A and A' to it will produce any new vector that is linearly independent from v
        v2 = A{p}*v1;
        v3 = (A{p})'*v1;
        for ii = 1:size(v,2)
          v2 = v2 - proj(v(:,ii),v2);
        end
        if norm(v2) > threshold       %% if so, expand v to include v2
          v2 = v2 / norm(v2);
          v = [v,v2];
          flag = 1;
        end
        for ii = 1:size(v,2)
          v3 = v3 - proj(v(:,ii),v3);
        end
        if norm(v3) > threshold       %% if so, expand v to include v3
          v3 = v3 / norm(v3);
          v = [v,v3];
          flag = 1;
        end
      end
    end
  
    P = [P,v];                  %% v is a basis for the invariant subspace corresponding to the common block found in this iteration, add v to the transformation matrix
  end
end


function w = proj(u,v)
  % This function projects vector v onto vector u
  w = (dot(u,v) / dot(u,u)) * u;
end
