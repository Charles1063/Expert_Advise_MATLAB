function [x,error] = tvd_2(y,clean)

%make column vector
lam = 0.1;
Nit = 10;
y = y(:);
cost = zeros(1,Nit);
N = length(y);
I = speye(N);
% D = I(2:N,:) - I(1:N-1,:);
D = I(1:N-2,:)-2*I(2:N-1,:)+I(3:N,:);
DDT = D*D';
loss = 0;


x = y;
Dx = D*x;
Dy = D*y;

for k = 1:Nit
    F = sparse(1:N-2,1:N-2,abs(Dx)/lam) + DDT;
    x = y - D'*(F\Dy);
    Dx = D*x;
    cost(k) = 0.5*sum(abs(x-y).^2)+lam*sum(abs(Dx));
end

for j = 1:N
    loss = loss + (x(j,1) - clean(j,1))^2;
end

error = loss/N;
