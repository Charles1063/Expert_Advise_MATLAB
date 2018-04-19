function f = convT(h, x)
% f = convT(h, x);
% Transpose convolution: H' x

Nh = length(h);
Nx = length(x);
f = conv(h(Nh:-1:1), x);
f = f(Nh:Nx);
