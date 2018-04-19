function f = conv2T(h, g)
% f = conv2T(h, g);
% Transpose two-dimentional convolution: f = H' g

Nh = size(h);
Ng = size(g);
f = conv2(h(Nh(1):-1:1, Nh(2):-1:1), g);
f = f(Nh(1):Ng(1), Nh(2):Ng(2));
