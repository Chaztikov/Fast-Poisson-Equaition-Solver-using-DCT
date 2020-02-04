# Fast Poisson Equation Solver using DCT


Copyright 2020 The MathWorks, Inc.


# �͂��߂�


�|���\���������̉��𐔒l�I�ɍ���()�ɋ��߂邨�b�B



<img src="https://latex.codecogs.com/gif.latex?\frac{\partial^2&space;u}{\partial&space;x^2&space;}+\frac{\partial^2&space;u}{\partial&space;y^2&space;}=f(x,y)"/>



�P���Ȋi�q��z�肵���ȉ��̗L���������i�Q�����x�j



<img src="https://latex.codecogs.com/gif.latex?\frac{u(i-1,j)-2u(i,j)+u(i+1,j)}{\Delta&space;x^2&space;}+\frac{u(i,j-1)-2u(i,j)+u(i,j+1)}{\Delta&space;y^2&space;}=f(i,j)"/>



�𒼐ږ@��[���U�R�T�C���ϊ�](https://ja.wikipedia.org/wiki/%E9%9B%A2%E6%95%A3%E3%82%B3%E3%82%B5%E3%82%A4%E3%83%B3%E5%A4%89%E6%8F%9B) (DCT, **D**iscrete **C**osine **T**ransform) ���g�����@�� MATLAB �R�[�h�ƂƂ��ɏЉ�܂��B




![image_0.png](README_JP_images/image_0.png)




�����炻�ꂼ��A�|���\���������̉��i��j�A�������Ƃ̌덷��r�A�������Ԃ̔�r


  


���l���̗͊w�̎��Ƃ���������Ƃ�������̓s���Ƃ�����������܂��񂪁A�񈳏k�� Navier-Stokes �������������Ƃ��ɂłĂ��܂��ˁB




����Љ����@�̓X�y�N�g���@�ƈ���� 2 �����x�̂܂܂ł��̂ł����ӂ��B�X�y�N�g���@�ɂ��Ă� [Qiita: ��ŃX�y�N�g���@_\#003_2����������](https://qiita.com/toya42/items/03d3060de125a4289f9c) by @toya42 ����������߁B


## ��


MATLAB R2019b




Signal Processing Toolbox (`dct` �֐� [���� doc page](https://jp.mathworks.com/help/signal/ref/dct.html))




Image Processing Toolbox (`dct2` �֐� [���� doc page](https://jp.mathworks.com/help/images/ref/dct2.html))




�i�ǂ��炩�����OK�j


  


���U�R�T�C���ϊ�������֐���1������2�����ňႤ Toolbox �ɓ����Ă��܂��B���U�R�T�C���ϊ����̂� MATLAB �{�̂� `fft` �֐����g���Ă������\�i�Ⴆ�΂���[ File Exchange: dctt](https://jp.mathworks.com/matlabcentral/fileexchange/18924-dctt)�j�ł����A������͎̂g���������y�Ȃ̂ō���� `dct` �܂��� `dct2` ���g���܂��B


  
# �v�Z�ʁF���ږ@ vs ���U�R�T�C���ϊ�


�Δ����������̉������߂�Ƃ͌����A���ǂ͘A�� 1 �������� <img src="https://latex.codecogs.com/gif.latex?\inline&space;{A}{u}={f}"/> ���������ƂɂȂ�̂ł����A���ږ@�ŉ������Ƃ���ƈ�ʓI�ɂ� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n^3&space;)"/>�̌v�Z�ʁB���Ȃ킿�i�q�T�C�Y�𔼕��i�O���b�h���� 2 �{�j�ɂ��邾���ŁA2 �����̏ꍇ�� 4^3 = 64 �{�A**3 �����̏ꍇ 8^3 = 512 �{�̌v�Z��**�ƂȂ鎎�Z�ɂȂ�܂��B���߂����Ă���H�|������B


  


<img src="https://latex.codecogs.com/gif.latex?\inline&space;{A}"/>���ω������A�J��Ԃ��v�Z����ꍇ�ł���Ύ��O�� LU �������Ă������ƂŁA�����ɘa�ł������ł�������ł� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n^2&space;)"/>.


> �W���s�񂪓���̘A�����������ʂɉ����ꍇ,��񂾂� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n^3&space;)"/> �ŕ������Ă����Ό�͑S�� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n^2&space;)"/> �Ōv�Z�o����Ƃ������ƂɂȂ�܂��B(���p�F[�v���O���}�ׂ̈̐��w�׋����8��](https://nineties.github.io/math-seminar/8.html#))




��ֈĂƂ��Ĕ����@�ŋߎ��������߂�̂��悢�ł����A�����ł͍������̌`���P���Ȃ��Ƃ𗘗p���AFFTW ���g���� <img src="https://latex.codecogs.com/gif.latex?\inline&space;{A}{u}={f}"/> �� <img src="https://latex.codecogs.com/gif.latex?\inline&space;{A}"/>��Ίp�s��ɂ��邱�Ƃō����ɉ������@���Љ�܂��B


  


FFTW �̌v�Z�ʎ��̂�


> �C�ӂ̃T�C�Y�̎�������ѕ��f���̃f�[�^�z����A<img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n\log&space;n)"/> �̃I�[�_�[�̎��ԂŌv�Z���邱�Ƃ��ł���B�i[https://ja.wikipedia.org/wiki/FFTW](https://ja.wikipedia.org/wiki/FFTW)�j




�Ƃ̂��ƁB


  


�v�Z�ʕ]���ɂ��Ă� 



   -  [Qiita: �v�Z�ʃI�[�_�[�̋��ߕ��𑍐����I �� �ǂ����� log ���o�ė��邩 ��](https://qiita.com/drken/items/872ebc3a2b5caaa4a0d0) by @drken ���� 
   -  [Qiita: [���S�Ҍ���] �v���O�����̌v�Z�ʂ����߂���@](https://qiita.com/cotrpepe/items/1f4c38cc9d3e3a5f5e9c) by @cotrpepe ���� 



����ϕ׋��ɂȂ�܂����B���肪�Ƃ��������܂��B


  
# ���ݒ�


���x���؂����₷���悤�ɁA��͉���



<img src="https://latex.codecogs.com/gif.latex?u(x,y)=\cos&space;(\pi&space;x)\cos&space;(\pi&space;y),"/>



�Ƃł���



<img src="https://latex.codecogs.com/gif.latex?\frac{\partial^2&space;u}{\partial&space;x^2&space;}+\frac{\partial^2&space;u}{\partial&space;y^2&space;}=-2\pi^2&space;\cos&space;(\pi&space;x)\cos&space;(\pi&space;y)"/>



���������Ƃɂ��܂��B


  


���}�̒ʂ� <img src="https://latex.codecogs.com/gif.latex?\inline&space;u"/> ���e�O���b�h�̐^�񒆂Œ�`����� staggered grid ���g�p���A�v�Z�̈�� <img src="https://latex.codecogs.com/gif.latex?\inline&space;-1\le&space;x\le&space;1"/>�A$-1\le y\le 1<img src="https://latex.codecogs.com/gif.latex?\inline&space;�A���E������&space;Neumann&space;��&space;"/>\partial u/\partial n=0$ �Ƃ��܂��B�ȒP�̂��ߌ��z�� 0 �Ƃ��Ă��܂����A0 �ł���K�v�͂Ȃ��C�ӂ̒l�ɑ΂��ē������@�_���g���܂��BNeumann BC �łȂ��ꍇ�ɂ́A���U�R�T�C���ϊ��ł͂Ȃ����U�T�C���ϊ����g���ƕ֗��B




![image_1.png](README_JP_images/image_1.png)




2 �����x�ł���Η̈�O�� Ghost Cell ��z�肵�A�Ⴆ��



<img src="https://latex.codecogs.com/gif.latex?\begin{array}{c}&space;u(0,j)=u(1,j)\\&space;u(i,0)=u(i,1)&space;\end{array}"/>



�ȂǂƂ��邱�Ƃŋ��E�E�����̈擯���X�e���V���ŕΔ�������`�ł��܂��ˁB


  
# ���ږ@
  


���āA�����Ă݂܂��傤�B�܂��A



<img src="https://latex.codecogs.com/gif.latex?\frac{u(i-1,j)-2u(i,j)+u(i+1,j)}{\Delta&space;x^2&space;}+\frac{u(i,j-1)-2u(i,j)+u(i,j+1)}{\Delta&space;y^2&space;}=f(i,j)"/>



�̍�������A�� 1 �������� <img src="https://latex.codecogs.com/gif.latex?\inline&space;{A}{u}={f}"/> �ŕ\������ꍇ�A<img src="https://latex.codecogs.com/gif.latex?\inline&space;{u}"/> ��



<img src="https://latex.codecogs.com/gif.latex?u(1,1),u(2,1),...,u(Nx,1),u(1,2),...,u(Nx,Ny)"/>



�ƕ��ׂ� 1 �����̃x�N�g���Ƃ��Ď�舵���܂��B<img src="https://latex.codecogs.com/gif.latex?\inline&space;{f}"/> �����l�ł��B




��������� x-�����Ay-�������ꂼ�� <img src="https://latex.codecogs.com/gif.latex?\inline&space;N_x"/>�A$N_y$ �ɕ�������ꍇ�A<img src="https://latex.codecogs.com/gif.latex?\inline&space;{A}"/> �� $N_x N_y \times N_x N_y$ �̍s��A<img src="https://latex.codecogs.com/gif.latex?\inline&space;{u}"/>�A<img src="https://latex.codecogs.com/gif.latex?\inline&space;{f}"/> �͂��ꂼ�� $N_x N_y \times 1$ �̃x�N�g���ɂȂ�܂��ˁB




������ <img src="https://latex.codecogs.com/gif.latex?\inline&space;{A}"/> ��




![image_2.png](README_JP_images/image_2.png)




����ȃX�p�[�X�s��ɂȂ�܂��B�}�� <img src="https://latex.codecogs.com/gif.latex?\inline&space;N_x&space;=N_y&space;=5"/> �̏ꍇ�ł����A`spy` �֐��ŕ`���܂��B


  


x-�����̍����ɂ��Ă͗v�f�͗ד��m�ɂȂ�̂ł��ꂢ�ȑэs��Ȃ�ł����A�������ꂽ�v�f���Q�Ƃ��� y-�����̍������Ȏ҂ł��ˁB3 �������ǂ���ɑѕ����L����܂��B�v�Z���ׂ������Ȃ�̂����Ȃ����܂��B


  


������͈ȉ��B<img src="https://latex.codecogs.com/gif.latex?\inline&space;{A}"/> ��g�ݗ��Ă镔������Ԏ�Ԃł����A�g�ݗ��Ă���� `\` (�o�b�N�X���b�V��) �ňꔭ�B


  


���������R�[�h�͂����� (solvePoissonEquation_direct.m)


```matlab
function [x,y,u] = solvePoissonEquation_direct(Nx,Ny)

dx = 2/Nx; dy = 2/Ny;

% �e���ɂ����� u �̒�`�ʒu�iNOTE: Staggered Grid�j
xx = -1+dx/2:dx:1-dx/2;
yy = -1+dy/2:dy:1-dy/2;
[x,y] = ndgrid(xx,yy); % meshgrid �ł͂Ȃ��_�ɒ���

% �s�� A �̍\�z�i�������ߖ�̂��߃X�p�[�X�s��Œ�`�j
% �܂� x �����̔����Ɋւ��镔���i�O�d�Ίp�s��j�����`���܂��B
tmp = -2*ones(Nx,1);
tmp([1,end]) = -1; % Neumann ���E�������l�������[�� -1 (not -2)
Ad = diag(tmp);
Au = diag(ones(Nx-1,1),1);
Al = diag(ones(Nx-1,1),-1);
Ax = Ad+Au+Al;

%  y �����̔����Ɋւ��镔��������� = �u���b�N�Ίp�s������܂�
% ���ꕨ�ƂȂ�X�p�[�X�s����`
% Abig = zeros(Nx*Ny,Nx*Ny,'like',sparse(1));
% dd = eye(Nx);
% for jj=1:Ny
%     if jj==1 || jj==Ny % y-�����̒[�͒��ӁiNeumann BC)
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

% ��Ɠ����s����������������ɏ����Ƃ�����B
% �܂��u���b�N�Ίp�s�񐬕����쐬
dd = eye(Nx);
tmp = repmat({sparse(Ax/dx^2 - 2*dd/dy^2)},Ny,1);
tmp{1} = Ax/dx^2 - dd/dy^2;
tmp{Ny} = Ax/dx^2 - dd/dy^2; % y-�����̒[�͒��ӁiNeumann BC)
Abig = blkdiag(tmp{:}); 

% 1�u���b�N���������Ίp�s��� y�����������쐬
d4y = eye(Nx*(Ny-1),'like',sparse(1));
Abig(1:end-Nx,Nx+1:end) = Abig(1:end-Nx,Nx+1:end) + d4y/dy^2; % �㑤
Abig(Nx+1:end,1:end-Nx) = Abig(Nx+1:end,1:end-Nx) + d4y/dy^2; % ����

% �E��
f = - 2*pi^2.*cos(pi*x).*cos(pi*y);
f = f(:); % �x�N�g����

% Abig �͓��ٍs��ł��肱�̂܂܂ł�
% �|���\���������{Neumann ���E���Ɖ�����ӂɒ�܂�Ȃ��̂ŁA
% 1�_�� u = 0 �ƌŒ肵�ĉ��Ƃ��܂��B
Abig(1,:) = 0;
Abig(1,1) = 1;
f(1) = 0;

% ����
u = Abig\f;

% 2�����z��ɖ߂��Ă����܂��B
u = reshape(u,[Nx,Ny]);

end
```
  
# ���U�R�T�C���ϊ��̓K�p


FFTW �̒�`���� [REDFT10 (DCT-II)](http://www.fftw.org/fftw3_doc/1d-Real_002deven-DFTs-_0028DCTs_0029.html) ���g�p���܂��B



<img src="https://latex.codecogs.com/gif.latex?u(x_i&space;,y_j&space;)=2\sum_{k_i&space;=0}^{N_x&space;-1}&space;\tilde{u}&space;(k_i&space;,y_j&space;)\cos&space;\left(\frac{\pi&space;k_i&space;(i+1/2)}{N_x&space;}\right)."/>

## �R�T�C���ϊ��H


����̖��͋��E����������������E�ł͂Ȃ��v�Z�̈�ł����A���E�Ő܂�Ԃ����f�[�^�ɑ΂��� FFT �������邱�ƂŌ��ʓI�ɃT�C��������������̂������ł��B�Ⴆ�� [ABCDEF] �Ƃ����f�[�^�� [ABCDEFFEDCBA] �Ɗg�����Ď����f�[�^�Ƃ��܂��BNeumann ���E���������炱���g�����@�B




Because of the even symmetry, however, the sine terms in the DFT all cancel and the remaining cosine terms are written explicitly below. This formulation often leads people to call such a transform a discrete cosine transform (DCT), although it is really just a special case of the DFT. [FFTW:1d Real-even DFTs (DCTs)](http://www.fftw.org/fftw3_doc/1d-Real_002deven-DFTs-_0028DCTs_0029.html)




FFTW �ł͂ǂ��f�[�^���g�����邩�i�܂�Ԃ��n�_���ǂ��ɂ��邩�j�� DCT-I ���� DCT-IV �܂� 4 ��`����Ă���A���ꂼ�� *dct* �� *dct2* �ɂ���������Ă��܂��B


  


���Ȃ݂ɂ���ɍ����̍����@��K�p����ꍇ�� Simens et al. (2009) �ł�


  
> the Gibb�fs errors due to the implicit derivative discontinuities at the non-periodic end points are of order dx^2 (����) higher-order schemes in non-periodic domains cannot be treated in this (be expanded in cosines series) way, because they require boundary schemes with different modified wavenumbers than the interior operator.


> (Simens, M., Jim�Lenez, J., Hoyas, S., Mizuno, Y., 2009. A high-resolution code for turbulent boundary layers. Journal of Computational Physics.)




�ƋL�ڂ�����܂����AExplicit �Ȓ����������x�ł���Ζ�肠��܂���B���U�R�T�C���ϊ����g������@�ŉ������ƂɂȂ鍷������������ƔF�����Ă���΁B


  
## �K�p���Ă݂�


xy-���������ɑ΂��ė��U�R�T�C���ϊ���K�p�����



<img src="https://latex.codecogs.com/gif.latex?u(x_i&space;,y_j&space;)=4\sum_{k_j&space;=0}^{N_y&space;-1}&space;\sum_{k_j&space;=0}^{N_y&space;-1}&space;\tilde{u}&space;(k_i&space;,k_j&space;)\cos&space;\left(\frac{\pi&space;k_i&space;(i+1/2)}{N_x&space;}\right)\cos&space;\left(\frac{\pi&space;k_j&space;(j+1/2)}{N_y&space;}\right),"/>



�ƂȂ�܂��B��������Ƃ��Ƃ̍������ɑ������**���傱���傱����**�v�Z����ƁE�E���ꂼ��̍���



<img src="https://latex.codecogs.com/gif.latex?\frac{u(i-1,j)-2u(i,j)+u(i+1,j)}{\Delta&space;x^2&space;}=\frac{4}{\Delta&space;x^2&space;}\sum_{k_i&space;=0}^{N_x&space;-1}&space;\sum_{k_j&space;=0}^{N_y&space;-1}&space;\tilde{u}&space;(k_i&space;,k_j&space;)\lambda_{xj}&space;\cos&space;\left(\frac{\pi&space;k_i&space;(i+1/2)}{N_x&space;}\right)\cos&space;\left(\frac{\pi&space;k_j&space;(j+1/2)}{N_y&space;}\right)"/>


<img src="https://latex.codecogs.com/gif.latex?\frac{u(i,j-1)-2u(i,j)+u(i,j+1)}{\Delta&space;y^2&space;}=\frac{4}{\Delta&space;x^2&space;}\sum_{k_i&space;=0}^{N_x&space;-1}&space;\sum_{k_j&space;=0}^{N_y&space;-1}&space;\tilde{u}&space;(k_i&space;,k_j&space;)\lambda_{yi}&space;\cos&space;\left(\frac{\pi&space;k_i&space;(i+1/2)}{N_x&space;}\right)\cos&space;\left(\frac{\pi&space;k_j&space;(j+1/2)}{N_y&space;}\right)"/>

  


�Ƌ��܂�܂��B�Y��ȑΏ̐��������܂��ˁB������



<img src="https://latex.codecogs.com/gif.latex?\lambda_{xi}&space;=2\left(\cos&space;\left(\frac{\pi&space;k_i&space;}{N_x&space;}\right)-1\right),\lambda_{yj}&space;=2\left(\cos&space;\left(\frac{\pi&space;k_j&space;}{N_y&space;}\right)-1\right)"/>



�ł��B



<img src="https://latex.codecogs.com/gif.latex?\frac{\sin&space;(a(i+1))-2\sin&space;(ai)+\sin&space;(a(i-1))}{\sin&space;(ai)}=2\left(\cos&space;a-1\right)."/>



����Ȋ֌W�����ɗ����܂��B��������ƌ��ʓI��



<img src="https://latex.codecogs.com/gif.latex?\frac{u(i-1,j)-2u(i,j)+u(i+1,j)}{\Delta&space;x^2&space;}+\frac{u(i,j-1)-2u(i,j)+u(i,j+1)}{\Delta&space;y^2&space;}=f(i,j)"/>



�̗��U����



<img src="https://latex.codecogs.com/gif.latex?\left\lbrack&space;\frac{\lambda_{xi}&space;}{\Delta&space;x^2&space;}+\frac{\lambda_{yj}&space;}{\Delta&space;y^2&space;}\right\rbrack&space;\tilde{u}&space;(k_i&space;,k_j&space;)=\tilde{f}&space;(k_i&space;,k_j&space;),"/>



�ƕ\�����Ƃ��ł��āA�e <img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda_{xi}"/>, <img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda_{yj}"/> �̑g�ݍ��킹�̐������Ɨ�������������܂����B�����Ȃ�Ɖ����Ղ��B�܂��E�ӂ𗣎U�R�T�C���ϊ����āA��̎��� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\tilde{u}&space;(k_i&space;,k_j&space;)"/> �����߂āA�t���U�R�T�C���ϊ��ł��B


  


������ <img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda_{xi}"/> �� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda_{yj}"/> �̓X�y�N�g���@�Ƃ̊֘A���� **modified wavenumber** �ȂǂƂ��Ă΂�܂��B


  


���������R�[�h�͂����� (solvePoissonEquation_2dDCT.m)


```matlab
function [x,y,u] = solvePoissonEquation_2dDCT(Nx,Ny)

arguments 
    Nx (1,1) {mustBeInteger,mustBeGreaterThan(Nx,1)}
    Ny (1,1) {mustBeInteger,mustBeGreaterThan(Ny,1)}
end

dx = 2/Nx; dy = 2/Ny;
% �e���ɂ����� u �̒�`�ʒu�iNOTE: Staggered Grid�j
xx = -1+dx/2:dx:1-dx/2;
yy = -1+dy/2:dy:1-dy/2;
[x,y] = ndgrid(xx,yy); % meshgrid �ł͂Ȃ��_�ɒ���

% modified wavenumber
kx = 0:Nx-1;
ky = 0:Ny-1;
mwx = 2*(cos(pi*kx/Nx)-1)/dx^2;
mwy = 2*(cos(pi*ky/Ny)-1)/dy^2;

% �E�ӂ𗣎U�R�T�C���ϊ��i2�����j
f = - 2*pi^2.*cos(pi*x).*cos(pi*y);
fhat = dct2(f); % �v Image Processing Toolbox
% fhat = dct(dct(f)')'; % ��Ɠ��l(�v Signal Processing Toolbox)

[MWX, MWY] = ndgrid(mwx,mwy);
uhat = fhat./(MWX+MWY);

% ���̂܂܂ł͉�����ӂɒ�܂�Ȃ� (uhat(0,0) = inf)
% (kx,ky)=(0,0) ���Ȃ킿���𐬕��i=���ϒl�j��
% 0 �Ƃ��邱�Ƃŉ����Œ�
uhat(1,1) = 0;

% �t���U�R�T�C���ϊ�
u = idct2(uhat); % �v Image Processing Toolbox
% u = idct(idct(uhat)')'; % ��Ɠ��l (�v Signal Processing Toolbox)

end
```
  
## �⑫�F�Е����ɂ����K�p���Ă݂�


�������A2���������ɑ΂��ė��U�R�T�C���ϊ���K�p����K�R���͂Ȃ��Ax-�����ɂ����K�p�����



<img src="https://latex.codecogs.com/gif.latex?\left\lbrack&space;\frac{\lambda_{xi}&space;}{\Delta&space;x^2&space;}+\frac{\delta^2&space;}{\delta&space;y^2&space;}\right\rbrack&space;\tilde{u}&space;(k_i&space;,y_j&space;)=\tilde{f}&space;(k_i&space;,y_j&space;)."/>



y-�����̍����͂��̂܂� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\delta^2&space;/\delta&space;y^2"/> �ƕ\�����Ă��܂����Ax-�����̍��� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\delta^2&space;/\delta&space;x^2"/> �ɋN������O�d�Ίp�s�񂪑Ίp������A�c���ꂽ�̂͂��ꂼ��̔g�� <img src="https://latex.codecogs.com/gif.latex?\inline&space;k_i"/> �œƗ����� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\delta^2&space;/\delta&space;y^2"/> �̎O�d�Ίp�s��̂݁B���Ȃ킿�A�e <img src="https://latex.codecogs.com/gif.latex?\inline&space;k_i"/> �������� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\tilde{u_j&space;}&space;=[u_1&space;,u_2&space;,\cdots&space;,u_{ny}&space;]^T"/> �������΂悵�B



<img src="https://latex.codecogs.com/gif.latex?\left\lbrack&space;\frac{1}{\Delta&space;x^2&space;}\lambda_{xi}&space;+\frac{\delta^2&space;}{\delta&space;y^2&space;}\right\rbrack&space;=\frac{1}{\Delta&space;y^2&space;}\left(\begin{array}{cccccc}&space;-1&space;&&space;1&space;&&space;&space;&&space;&space;&&space;\\&space;1&space;&&space;-2&space;&&space;1&space;&&space;&space;&&space;\\&space;&space;&&space;\ddots&space;&space;&&space;\ddots&space;&space;&&space;\ddots&space;&space;&&space;\\&space;&space;&&space;&space;&&space;1&space;&&space;-2&space;&&space;1\\&space;&space;&&space;&space;&&space;&space;&&space;2&space;&&space;-1&space;\end{array}\right)+\frac{1}{\Delta&space;x^2&space;}\lambda_{xi}&space;{I}"/>



����͎O�d�Ίp�s��Ȃ̂ł��̓����𗘗p����� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n)"/> �̌v�Z�ʂł��݂܂��B[Wikipedia: Tridiagonal matrix](https://en.wikipedia.org/wiki/Tridiagonal_matrix)


  


��K�͂ȃV�~�����[�V���������ŉ񂻂��Ƃ���ƁA���񉻂̐헪�ɂ���Ă͂����炪�K���Ă���ꍇ������ł��傤���Ay-���������Ԋu�łȂ��O���b�h�̏ꍇ�ɂ͗��U�R�T�C���ϊ��g���Ȃ��̂ŁA�K�R�I�ɂ�����̕��@�ɂȂ�܂��B


  
# �R�[�h����


���ږ@�ŉ����֐� `solvePoissonEquation_direct.m` �Ɨ��U�R�T�C���ϊ����g���ĉ����֐� `solvePoissonEquation_2dDCT.m` �͏�ŏЉ�܂����B�����Ɖ������܂��Ă��邩�ǂ����A�����Ă��̏������x���ׂĂ݂܂��傤�B


  
## �����Ɖ����Ă�H


![image_3.png](README_JP_images/image_3.png)




�܂����������������������Ă���̂œ��R�ł����A����@�Ƃ������덷���m�F�ł��Ă���A���Ғʂ� 2 �����x�ł��邱�Ƃ��m�F�ł��܂��B�O���b�h���� 10 �{����΁A�������Ƃ̌덷�� 1/100 �ɂȂ��Ă��܂��B�悩�����B


  


�G���[�`�F�b�N�Ɏg�p�����R�[�h


```matlab

ntests = 9;
errors = zeros(ntests,2);
for ii=2:ntests
    N = 2^ii; % N = 4,8,16,...,512
    % ���ږ@�ŋ��߂�
    [x,y,sol1] = solvePoissonEquation_direct(N,N);
    % ���U�R�T�C���ϊ����g���ċ��߂�
    [~,~,sol2] = solvePoissonEquation_2dDCT(N,N);
    
    % ������
    exactsol = cos(pi*x).*cos(pi*y);
    
    % �������Ƃ̌덷���v�Z
    % ���� Neumann BC �ł���́A�萔����������Ă���
    % ���̂����e�����ׂ��Ȃ̂ł��̕��␳���܂��B
    constShift = exactsol(1,1)-sol1(1,1);
    errors(ii,1) = norm(exactsol-constShift-sol1)/N;
    
    constShift = exactsol(1,1)-sol2(1,1);
    errors(ii,2) = norm(exactsol-constShift-sol2)/N;
end

%% �������牺�v���b�g
figure(1)
loglog(2.^(1:ntests),errors,'Marker','o','LineWidth',4)

% ���h���̔�����
handle_axes = gca;
handle_axes.FontSize = 14;
box(handle_axes,'on');
grid(handle_axes,'on');

% legend ���쐬
legend({'���ږ@','���U�R�T�C���ϊ�'});
grid on
% textbox ���쐬
annotation('textbox',[0.51 0.47 0.2 0.1],...
    'String',{'- \Delta x^2'},...
    'FontSize',18,'EdgeColor',[1 1 1]);

% line ���쐬
annotation('line',[0.36 0.73],[0.64 0.27],'LineWidth',3);
xlabel('�O���b�h��')
ylabel('�덷')
title('�������Ƃ̌덷 vs �O���b�h��')
hold off
```
  
## �������x�́H


![image_4.png](README_JP_images/image_4.png)




���U�R�T�C���ϊ����g�������� 1 ��������Ƒ����ł��ˁB


  


���ږ@�̏ꍇ�A<img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n^{2.2}&space;)"/> ���炢���ȁH����قǈ����Ȃ��B MATLAB �� `\`�i�o�b�N�X���b�V���j�̎������ǂ��悤�ɂ���Ă���Ă����ł��傤���B���U�R�T�C���ϊ����g�����P�[�X���ƁA<img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n\log&space;n)"/> �� <img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n)"/> ����{���邱�ƂɂȂ�̂ŁA<img src="https://latex.codecogs.com/gif.latex?\inline&space;\mathcal{O}(n^2&space;\log&space;n)"/> �ɂȂ�̂��E�E�ȁH


  


���̕ӂ̌v�Z�ʂ̕]���ɂ��Ď��M���Ȃ��Ȃ��Ă��܂����E�E�����܂���ڂ������R�����g���������B


  


���s���x�`�F�b�N�Ɏg�p�����R�[�h


```matlab
ntests = 9;
pw = 1:ntests;
times = zeros(ntests,2);
for ii=2:ntests
    N = 2^ii; % N = 4,8,16,...,512
    % ���ږ@
    f1 = @() solvePoissonEquation_direct(N,N);
    % ���U�R�T�C���ϊ�
    f2 = @() solvePoissonEquation_2dDCT(N,N);
    
    % �������Ԍv���i��������s���Ē����l��ۑ����܂��j
    times(ii,1) = timeit(f1,3);
    times(ii,2) = timeit(f2,3);
end

%% ��������v���b�g
figure(1)
loglog(2.^(1:ntests),times,'Marker','o','LineWidth',4)

% ���h���̔�����
handle_axes = gca;
handle_axes.FontSize = 14;
box(handle_axes,'on');
grid(handle_axes,'on');

% legend ���쐬
legend({'���ږ@','���U�R�T�C���ϊ�'},'Location','best');
grid on
xlabel('�O���b�h��')
ylabel('���s���� (s) ')
title('���s���� vs �O���b�h��')
hold off
```
  
# �܂Ƃ�
  


���āA����� Neumann ���E�̃|���\�����������A���ږ@�A���U�R�T�C���ϊ����g���ĉ����Ă݂܂����B


  


FFTW �̂������ŗ��U�R�T�C���ϊ����C�y�ɂł���̂ŁA���ږ@���ނ���R�[�h�͌��₷���ł����A���s���x�������B�������K�p�ł���󋵂������܂����A�g���鎞�ɂ͎�����郁���b�g�͂��肻���ł��B�����A�s�񂪑傫���Ȃ�E�i�q�����G�ɂȂ�ƌ��ǔ����@�ɗ��炴������Ȃ���ł��傤�ˁB


