%% Examples accompying the simultaneous block diagonalization code sbd_fast.m
%% Including applications to cluster synchronization, coupled nonidentical oscillators,
%% and networks with nonidentical interactions.

clc;clear;

%%%%%%%%%%%%%%%%%%
% Network with 5 symmetry clusters (two intertwined) from 
% L. M. Pecora, F. Sorrentino, A. M. Hagerstrom, T. E. Murphy, and R. Roy,
% Cluster synchronization and isolated desynchronization in complex networks with symmetries, 
% Nat. Commun., 5 (2014), 4079.
%%%%%%%%%%%%%%%%%%

n = 11; %% size of the network
%% define adjacency matrix
adj = ones(n) - eye(n);
adj(1,5) = 0; adj(5,1) = 0;
adj(2,7) = 0; adj(7,2) = 0;
adj(3,9) = 0; adj(9,3) = 0;
adj(5,11) = 0; adj(11,5) = 0;
adj(8,10) = 0; adj(10,8) = 0;
adj(10,11) = 0; adj(11,10) = 0;
%% add noise/error to the matrix data
D{1} = adj + 1e-10*rand(n);

%% D{2} to D{6} are diagonal matrices that encode cluster info
%% e.g., node 1 and node 8 are in the same symmetry cluster
D{2} = zeros(n);
D{2}(1,1) = 1;
D{2}(8,8) = 1;

D{3} = zeros(n);
D{3}(4,4) = 1;
D{3}(6,6) = 1;

D{4} = zeros(n);
D{4}(2,2) = 1;
D{4}(3,3) = 1;
D{4}(7,7) = 1;
D{4}(9,9) = 1;

D{5} = zeros(n);
D{5}(5,5) = 1;
D{5}(10,10) = 1;

D{6} = zeros(n);
D{6}(11,11) = 1;

%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-5);
for ii = 1:6
	D{ii} = P' * D{ii} * P;
end

set(0,'DefaultAxesFontSize',25)

figure
colormap(flipud(colormap));
set(gcf, 'PaperPosition', [0 0 8 5]);
set(gcf, 'PaperSize', [8 5]);
for ii = 1:6
	subplot(2,3,ii)
	imagesc(D{ii});
	caxis([-max(D{ii}(:)) max(D{ii}(:))])
	colormap(lbmap(201,'RedWhiteBlue'))
	set(gca,'XTick',[])
	set(gca,'YTick',[])
end
%set(gca,'Visible','off');
saveas(gcf,'pecora14.pdf')


clc;clear;

%%%%%%%%%%%%%%%%%%
% Network with 2 Laplacian clusters from
% F. Sorrentino, L. M. Pecora, A. M. Hagerstrom, T. E. Murphy, and R. Roy, 
% Complete characterization of the stability of cluster synchronization in complex dynamical networks, 
% Sci. Adv., 2 (2016), e1501737
%%%%%%%%%%%%%%%%%%

n = 5; %% size of the network
%% define adjacency matrix
adj = ones(n) - eye(n);
adj(1,3) = 0; adj(3,1) = 0;
adj(2,4) = 0; adj(4,2) = 0;
%% define Laplacian matrix
rowsum = sum(adj,2);
laplacian = diag(rowsum) - adj;
%% add noise/error to the matrix data
D{1} = laplacian + 1e-8*rand(n);

%% D{2} and D{3} are diagonal matrices that encode cluster info
%% e.g., node 1, 3 and 5 are in the same Laplacian cluster
D{2} = zeros(n);
D{2}(1,1) = 1;
D{2}(3,3) = 1;
D{2}(5,5) = 1;

D{3} = zeros(n);
D{3}(2,2) = 1;
D{3}(4,4) = 1;

%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-5);
for ii = 1:3
	D{ii} = P' * D{ii} * P;
end

set(0,'DefaultAxesFontSize',25)

figure
colormap(flipud(colormap));
set(gcf, 'PaperPosition', [0 0 20 5]);
set(gcf, 'PaperSize', [20 5]);
for ii = 1:3
	subplot(1,3,ii)
	imagesc(D{ii});
	caxis([-max(D{ii}(:)) max(D{ii}(:))])
	colormap(lbmap(201,'RedWhiteBlue'))
	set(gca,'XTick',[])
	set(gca,'YTick',[])
end
%set(gca,'Visible','off');
saveas(gcf,'sorrentino16.pdf')


clc;clear;

%%%%%%%%%%%%%%%%%%
% Network with 2 external equitable clusters from
% M. T. Schaub, N. O’Clery, Y. N. Billeh, J.-C. Delvenne, R. Lambiotte, and M. Barahona, 
% Graph partitions and cluster synchronization in networks of oscillators, 
% Chaos, 26 (2016), 094821.
%%%%%%%%%%%%%%%%%%

n = 8; %% size of the matrices
%% define adjacency matrix
adj = [0,1,1,0,0,0,0,0;...
 	   1,0,1,0,0,0,0,0;...
 	   1,1,0,1,0,0,0,0;...
 	   0,0,1,0,1,0,0,0;...
 	   0,0,0,1,0,1,0,0;...
 	   0,0,0,0,1,0,1,1;...
 	   0,0,0,0,0,1,0,0;...
 	   0,0,0,0,0,1,0,0];
%% define Laplacian matrix
rowsum = sum(adj,2);
laplacian = diag(rowsum) - adj;
%% add noise/error to the matrix data
D{1} = laplacian + 1e-6*rand(n);

%% D{2} and D{3} are diagonal matrices that encode cluster info
%% e.g., node 3 and node 6 are in the same external equitable cluster
D{2} = zeros(n);
D{2}(3,3) = 1;
D{2}(6,6) = 1;

D{3} = eye(n) - D{2};

%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-4);
for ii = 1:3
	D{ii} = P' * D{ii} * P;
end

set(0,'DefaultAxesFontSize',25)

figure
colormap(flipud(colormap));
set(gcf, 'PaperPosition', [0 0 20 5]);
set(gcf, 'PaperSize', [20 5]);
for ii = 1:3
	subplot(1,3,ii)
	imagesc(D{ii});
	caxis([-max(D{ii}(:)) max(D{ii}(:))])
	colormap(lbmap(201,'RedWhiteBlue'))
	set(gca,'XTick',[])
	set(gca,'YTick',[])
end
%set(gca,'Visible','off');
saveas(gcf,'schaub16.pdf')


clc;clear;

%%%%%%%%%%%%%%%%%%
% Random network with 4 symmetry clusters from Fig. 3 of
% Y. Zhang and A. E. Motter, 
% Fast, unified, and direct approach to network synchronization
%%%%%%%%%%%%%%%%%%

n = 30; %% size of the matrices
%% define adjacency matrix
adj = dlmread('random_net.txt');
%% add noise/error to the matrix data
D{1} = adj + 1e-7*rand(n);

%% D{2} to D{5} are diagonal matrices that encode cluster info
%% e.g., node 20 and node 24 are in the same symmetry cluster
D{2} = zeros(n);
D{2}(20,20) = 1;
D{2}(24,24) = 1;

D{3} = zeros(n);
D{3}(2,2) = 1;
D{3}(10,10) = 1;
D{3}(16,16) = 1;
D{3}(30,30) = 1;

D{4} = zeros(n);
D{4}(3,3) = 1;
D{4}(6,6) = 1;
D{4}(7,7) = 1;
D{4}(11,11) = 1;

D{5} = eye(n) - D{2} - D{3} - D{4};

%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-4);
for ii = 1:5
	D{ii} = P' * D{ii} * P;
end

set(0,'DefaultAxesFontSize',25)

figure
colormap(flipud(colormap));
set(gcf, 'PaperPosition', [0 0 8 5]);
set(gcf, 'PaperSize', [8 5]);
for ii = 1:5
	subplot(2,3,ii)
	imagesc(D{ii});
	caxis([-max(D{ii}(:)) max(D{ii}(:))])
	colormap(lbmap(201,'RedWhiteBlue'))
	set(gca,'XTick',[])
	set(gca,'YTick',[])
end
%set(gca,'Visible','off');
saveas(gcf,'Fig3_Zhang.pdf')


clc;clear;

%%%%%%%%%%%%%%%%%%
% Ring network with 2 types of oscillators from Fig. 4 of
% Y. Zhang and A. E. Motter, 
% Fast, unified, and direct approach to network synchronization
%%%%%%%%%%%%%%%%%%

n = 20; %% size of the matrices
%% define adjacency matrix
adj = zeros(1,n);
adj(1,2) = 1; adj(1,end) = 1;
ring = adj;
for ii = 1:n-1
  adj = [adj;circshift(ring,[0,ii])];
end
D{1} = adj;


%% D{2} and D{3} are diagonal matrices that encode the oscillator type
%% (arranged alternatingly in this case)
D{2} = zeros(n);
for ii = 1:n/2
  D{2}(2*ii,2*ii) = 1;
end

D{3} = eye(n) - D{2};

%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-8);
for ii = 1:3
	D{ii} = P' * D{ii} * P;
end

set(0,'DefaultAxesFontSize',25)

figure
colormap(flipud(colormap));
set(gcf, 'PaperPosition', [0 0 20 5]);
set(gcf, 'PaperSize', [20 5]);
for ii = 1:3
	subplot(1,3,ii)
	imagesc(D{ii});
	caxis([-max(D{ii}(:)) max(D{ii}(:))])
	colormap(lbmap(201,'RedWhiteBlue'))
	set(gca,'XTick',[])
	set(gca,'YTick',[])
end
%set(gca,'Visible','off');
saveas(gcf,'Fig4_Zhang.pdf')


clc;clear;

%%%%%%%%%%%%%%%%%%
% Network with 2 types of diffusive interactions from Fig. 6 of
% Y. Zhang and A. E. Motter, 
% Fast, unified, and direct approach to network synchronization
%%%%%%%%%%%%%%%%%%

n = 16; %% size of the matrices

% define adjacency matrix for first type of interaction
adj = zeros(1,n);
adj(1,2) = 1; adj(1,end) = 1; adj(1,9) = 1;
ring = adj;
for ii = 1:n-1
  adj = [adj;circshift(ring,[0,ii])];
end
% define Laplacian matrix for first type of interaction
rowsum = sum(adj,2);
laplacian = diag(rowsum) - adj;
D{1} = laplacian;

% define adjacency matrix for second type of interaction
adj = zeros(1,n);
adj(1,3) = 1; adj(1,end-1) = 1;
ring = adj;
for ii = 1:n-1
  adj = [adj;circshift(ring,[0,ii])];
end
adj(1,11) = 1; 	adj(11,1) = 1;
adj(3,9) = 1; 	adj(9,3) = 1;
adj(5,15) = 1; 	adj(15,5) = 1;
adj(7,13) = 1; 	adj(13,7) = 1;
adj(2,8) = 1; 	adj(8,2) = 1;
adj(4,14) = 1; 	adj(14,4) = 1;
adj(6,12) = 1; 	adj(12,6) = 1;
adj(10,16) = 1; adj(16,10) = 1;
% define Laplacian matrix for second type of interaction
rowsum = sum(adj,2);
laplacian = diag(rowsum) - adj;
D{2} = laplacian;

%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-8);
for ii = 1:2
	D{ii} = P' * D{ii} * P;
end

set(0,'DefaultAxesFontSize',25)

figure
colormap(flipud(colormap));
set(gcf, 'PaperPosition', [0 0 12 5]);
set(gcf, 'PaperSize', [12 5]);
for ii = 1:2
	subplot(1,2,ii)
	imagesc(D{ii});
	caxis([-max(D{ii}(:)) max(D{ii}(:))])
	colormap(lbmap(201,'RedWhiteBlue'))
	set(gca,'XTick',[])
	set(gca,'YTick',[])
end
%set(gca,'Visible','off');
saveas(gcf,'Fig6_Zhang.pdf')