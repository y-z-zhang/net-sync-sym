% historical version of COMMDEC (2010.04.16 version)
% rewrite: 2012.11.13
function P = commdec(A, num) 
  n = size(A{1}, 2);

  if nargin < 2; num = 20; end
  num = min(num, n*n);

  S = zeros(n * n);
  for p = 1 : size(A,2)
    T = kron(eye(n), A{p}) - kron(transpose(A{p}), eye(n));
    S = S + T' * T;
  end
  S = S + S';

  [Y, D] = eigs(S, num, -1); % compute 100 small eigs
  D = abs(D); 

  d = sort(diag(D));
  len = max(num, size(d, 2));
  plot(d(1 : len), '.');
  thr = input('set a threshold: ');

  err = 0;
  X = zeros(n^2, 1);
  for k = 1 : num % random sampling
    if D(k,k) < thr
      err = max(err, sqrt(D(k,k) / (4*n)));
      X = randn * Y(:,k);
    end
  end
  disp(sprintf('err = %.8f', err));

  X = reshape(X, n, n);
  [P, D] = eig(X + X');
return
