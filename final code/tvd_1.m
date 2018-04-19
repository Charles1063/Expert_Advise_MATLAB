function [x,error] = tvd_1(y,clean)

%make column vector
% change the value of lam to 0.5/0.6/0.8
%best is 0.739
lam = 0.6;
Nit = 18;
y = y(:);
cost = zeros(1,Nit);
N = length(y);
I = speye(N);
D = I(2:N,:) - I(1:N-1,:);
DDT = D*D';
loss = 0;


x = y;
Dx = D*x;
Dy = D*y;

for k = 1:Nit
    F = sparse(1:N-1,1:N-1,abs(Dx)/lam) + DDT;
    x = y - D'*(F\Dy);
    Dx = D*x;
    cost(k) = 0.5*sum(abs(x-y).^2)+lam*sum(abs(Dx));
end

for j = 1:N
    loss = loss + (x(j,1) - clean(j,1))^2;
end

error = loss/N;




