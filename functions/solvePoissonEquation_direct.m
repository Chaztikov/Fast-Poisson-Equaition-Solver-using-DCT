function [x,y,u] = solvePoissonEquation_direct(Nx,Ny)
% Copyright 2020 The MathWorks, Inc.

% What is arguments?
% see: https://jp.mathworks.com/help/matlab/matlab_prog/argument-validation-functions.html
arguments 
    Nx (1,1) {mustBeInteger,mustBeGreaterThan(Nx,1)}
    Ny (1,1) {mustBeInteger,mustBeGreaterThan(Ny,1)}
end

dx = 2/Nx; dy = 2/Ny;

% The location of u�iNOTE: Staggered Grid�j
xx = -1+dx/2:dx:1-dx/2;
yy = -1+dy/2:dy:1-dy/2;
[x,y] = ndgrid(xx,yy); % Note: not meshgrid

% Constructing a matrix A (sparse matrix to save memory usage)
% �s�� A �̍\�z�i�������ߖ�̂��߃X�p�[�X�s��Œ�`�j
% Start with the x-derivative (tri-diagonal matrix)
% �܂� x �����̔����Ɋւ��镔���i�O�d�Ίp�s��j�����`���܂��B
tmp = -2*ones(Nx,1);
tmp([1,end]) = -1; % Neumann BC requires -1 (not -2) at both ends
Ad = diag(tmp);
Au = diag(ones(Nx-1,1),1);
Al = diag(ones(Nx-1,1),-1);
Ax = Ad+Au+Al;

% Consider y-derivative = it become block diagnal matrix
%  y �����̔����Ɋւ��镔��������� = �u���b�N�Ίp�s������܂�
% Define the container first
% ���ꕨ�ƂȂ�X�p�[�X�s����`
% Abig = zeros(Nx*Ny,Nx*Ny,'like',sparse(1));
% dd = eye(Nx);
% for jj=1:Ny
%     if jj==1 || jj==Ny % y-ends�iNeumann BC)
%         Abig(1+Nx*(jj-1):Nx*jj,1+Nx*(jj-1):Nx*jj) = Ax/dx^2 - dd/dy^2;
%     else
%         Abig(1+Nx*(jj-1):Nx*jj,1+Nx*(jj-1):Nx*jj) = Ax/dx^2 - 2*dd/dy^2;
%     end
%     if jj~=1 % j
%         Abig(1+Nx*(jj-1):Nx*jj,1+Nx*(jj-2):Nx*(jj-1)) = dd/dy^2;
%     end
%     if jj~=Ny
%         Abig(1+Nx*(jj-1):Nx*jj,1+Nx*(jj-0):Nx*(jj+1)) = dd/dy^2;
%     end
% end

% The above can be written a little simpler:
% ��Ɠ����s����������������ɏ����Ƃ�����B
% Construct the block diagonal matrix
% �܂��u���b�N�Ίp�s�񐬕����쐬
dd = eye(Nx);
tmp = repmat({sparse(Ax/dx^2 - 2*dd/dy^2)},Ny,1);
tmp{1} = Ax/dx^2 - dd/dy^2;
tmp{Ny} = Ax/dx^2 - dd/dy^2; % y-ends�iNeumann BC)
Abig = blkdiag(tmp{:}); 

% A matrix (one block smaller)
% 1�u���b�N���������Ίp�s��� y�����������쐬
d4y = eye(Nx*(Ny-1),'like',sparse(1));
Abig(1:end-Nx,Nx+1:end) = Abig(1:end-Nx,Nx+1:end) + d4y/dy^2; % upper
Abig(Nx+1:end,1:end-Nx) = Abig(Nx+1:end,1:end-Nx) + d4y/dy^2; % lower

% Construction A is done. Let's make the right hand side f
f = - 2*pi^2.*cos(pi*x).*cos(pi*y);
f = f(:); % make it a vector

% Natually, Abig is a singular matrix. Poisson eq with Neumann BC
% does not provide a unique solution. Thus fixing u to be 0 at one point.
% Abig �͓��ٍs��ł��肱�̂܂܂ł�
% �|���\���������{Neumann ���E���Ɖ�����ӂɒ�܂�Ȃ��̂ŁA
% 1�_�� u = 0 �ƌŒ肵�ĉ��Ƃ��܂��B
Abig(1,:) = 0;
Abig(1,1) = 1;
f(1) = 0;

% Solve the system of equation
u = Abig\f;

% Put the solution (a vector) back to 2d matrix
u = reshape(u,[Nx,Ny]);

end