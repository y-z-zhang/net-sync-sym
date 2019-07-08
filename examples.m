%% Examples accompying the simultaneous block diagonalization code sbd_fast.m
%% Including applications to synchronization patterns arising from symmetry clusters,
%% Laplacian clusters, equitable clusters, as well as chimera states in multilayer networks

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
D{1} = adj + 1e-5*rand(n);

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
P = sbd_fast(D,'real',1e-2);
for ii = 1:6
	D{ii} = P' * D{ii} * P;
end


%% plot the matrices in common block-diagonal form
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
D{1} = laplacian + 1e-5*rand(n);

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
P = sbd_fast(D,'real',1e-2);
for ii = 1:3
	D{ii} = P' * D{ii} * P;
end

%% plot the matrices in common block-diagonal form
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
% Network with 2 equitable clusters from
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
D{1} = laplacian + 1e-5*rand(n);

%% D{2} and D{3} are diagonal matrices that encode cluster info
%% e.g., node 3 and node 6 are in the same equitable cluster
D{2} = zeros(n);
D{2}(3,3) = 1;
D{2}(6,6) = 1;

D{3} = eye(n) - D{2};

%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-2);
for ii = 1:3
	D{ii} = P' * D{ii} * P;
end

%% plot the matrices in common block-diagonal form
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
% Network with 2 equitable clusters from Fig.1 of
% Y. Zhang and A. E. Motter, 
% Fast and symmetry-independent stability analysis
% of cluster synchronization patterns
%%%%%%%%%%%%%%%%%%

n = 15; %% size of the matrices
%% define adjacency matrix
adj = [0,1,1,0,0,0,0,0,0,0,0,1,0,0,0;...
		1,0,1,0,0,0,0,1,0,0,0,0,0,0,0;...
		1,1,0,1,0,0,0,0,0,0,0,0,0,0,0;...
		0,0,1,0,1,1,1,0,0,0,0,0,0,0,0;...
		0,0,0,1,0,0,1,0,0,0,0,0,0,0,0;...
		0,0,0,1,0,0,1,0,0,0,0,0,0,0,0;...
		0,0,0,1,1,1,0,0,0,0,0,0,0,0,0;...
		0,1,0,0,0,0,0,0,1,1,1,0,0,0,0;...
		0,0,0,0,0,0,0,1,0,0,0,0,0,0,0;...
		0,0,0,0,0,0,0,1,0,0,0,0,0,0,0;...
		0,0,0,0,0,0,0,1,0,0,0,0,0,0,0;...
		1,0,0,0,0,0,0,0,0,0,0,0,1,1,1;...
		0,0,0,0,0,0,0,0,0,0,0,1,0,1,1;...
		0,0,0,0,0,0,0,0,0,0,0,1,1,0,1;...
		0,0,0,0,0,0,0,0,0,0,0,1,1,1,0];

%% define Laplacian matrix
rowsum = sum(adj,2);
laplacian = diag(rowsum) - adj;
%% add noise/error to the matrix data
D{1} = laplacian + 1e-5*rand(n);

%% D{2} and D{3} are diagonal matrices that encode cluster info
%% e.g., nodes 4, 8 and 12 are in the same equitable cluster
D{2} = zeros(n);
D{2}(4,4) = 1;
D{2}(8,8) = 1;
D{2}(12,12) = 1;

D{3} = eye(n) - D{2};


%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-2);
for ii = 1:3
	D{ii} = P' * D{ii} * P;
end

%% plot the matrices in common block-diagonal form
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
saveas(gcf,'Fig1_Zhang.pdf')


clc;clear;

%%%%%%%%%%%%%%%%%%
% Random network with 4 symmetry clusters from Fig.3 of
% Y. Zhang and A. E. Motter, 
% Fast and symmetry-independent stability analysis
% of cluster synchronization patterns
%%%%%%%%%%%%%%%%%%

n = 30; %% size of the matrices
%% define adjacency matrix
adj = dlmread('random_net.txt');
%% add noise/error to the matrix data
D{1} = adj + 1e-5*rand(n);

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
P = sbd_fast(D,'real',1e-2);
for ii = 1:5
	D{ii} = P' * D{ii} * P;
end

%% plot the matrices in common block-diagonal form
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
% Chimera states in a multilayer network from Fig.4 of
% Y. Zhang and A. E. Motter, 
% Fast and symmetry-independent stability analysis
% of cluster synchronization patterns
%%%%%%%%%%%%%%%%%%

n = 6; %% size of the matrices representing each layer

%% first-layer subnetwork
adj1 = [0,1,0,0,1,1;...
		1,0,0,0,1,0;...
		0,0,0,1,1,0;...
		0,0,1,0,1,1;...
		1,1,1,1,0,0;...
		1,0,0,1,0,0];

%% second-layer subnetwork
adj2 = [0,1,0,1,0,0;...
		1,0,1,0,1,0;...
		0,1,0,1,1,0;...
		1,0,1,0,1,0;...
		0,1,1,1,0,1;...
		0,0,0,0,1,0];

%% adjacency matrices representing the interlayer and intralayer connections
aij1 = [adj1,zeros(n); zeros(n),adj2];
aij2 = [zeros(n),ones(n); ones(n),zeros(n)];

%% laplacian matrices representing the interlayer and intralayer connections
rowsum = sum(aij1,2);
laplacian1 = diag(rowsum) - aij1;
rowsum = sum(aij2,2);
laplacian2 = diag(rowsum) - aij2;
%% add noise/error to the matrix data
D{1} = laplacian1 + 1e-5*rand(2*n);
D{2} = laplacian2 + 1e-5*rand(2*n);

%% D{3} and D{4} are diagonal matrices that encode cluster info
%% e.g., nodes 1 to n are in the same cluster
D{3} = zeros(2*n);
for i = 1:n
	D{3}(i,i) = 1;
end

D{4} = zeros(2*n);
for i = 1:n
	D{4}(n+i,n+i) = 1;
end

%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-2);
for ii = 1:4
	D{ii} = P' * D{ii} * P;
end

%% plot the matrices in common block-diagonal form
figure
colormap(flipud(colormap));
set(gcf, 'PaperPosition', [0 0 12 12]);
set(gcf, 'PaperSize', [12 12]);
for ii = 1:4
	subplot(2,2,ii)
	imagesc(D{ii});
	caxis([-max(D{ii}(:)) max(D{ii}(:))])
	colormap(lbmap(201,'RedWhiteBlue'))
	set(gca,'XTick',[])
	set(gca,'YTick',[])
end
%set(gca,'Visible','off');
saveas(gcf,'Fig4b_Zhang.pdf')

%% We now study the 7-cluster pattern in the same multilayer network
D{1} = laplacian1 + 1e-5*rand(2*n);
D{2} = laplacian2 + 1e-5*rand(2*n);

%% D{3} to D{9} are diagonal matrices that encode cluster info
%% e.g., nodes 1 to n are in the same cluster
D{3} = zeros(2*n);
for i = 1:n
	D{3}(i,i) = 1;
end

D{4} = zeros(2*n);
D{4}(n+1,n+1) = 1;

D{5} = zeros(2*n);
D{5}(n+2,n+2) = 1;

D{6} = zeros(2*n);
D{6}(n+3,n+3) = 1;

D{7} = zeros(2*n);
D{7}(n+4,n+4) = 1;

D{8} = zeros(2*n);
D{8}(n+5,n+5) = 1;

D{9} = zeros(2*n);
D{9}(n+6,n+6) = 1;

%% calculate orthogonal matrix for simultaneous block-diagonalization
P = sbd_fast(D,'real',1e-2);
for ii = 1:9
	D{ii} = P' * D{ii} * P;
end

%% plot the matrices in common block-diagonal form
figure
colormap(flipud(colormap));
set(gcf, 'PaperPosition', [0 0 12 12]);
set(gcf, 'PaperSize', [12 12]);
for ii = 1:9
	subplot(3,3,ii)
	imagesc(D{ii});
	caxis([-max(D{ii}(:)) max(D{ii}(:))])
	colormap(lbmap(201,'RedWhiteBlue'))
	set(gca,'XTick',[])
	set(gca,'YTick',[])
end
%set(gca,'Visible','off');
saveas(gcf,'Fig4c_Zhang.pdf')