function [x,cost] = tvd_mm(y,lam,Nit)

%make column vector
y = y(:);
cost = zeros(1,Nit);
N = length(y);
I = speye(N);
D = I(2:N,:) - I(1:N-1,:);
DDT = D*D';

x = y;
Dx = D*x;
Dy = D*y;

for k = 1:Nit
    F = sparse(1:N-1,1:N-1,abs(Dx)/lam) + DDT;
    x = y - D'*(F\Dy);
    Dx = D*x;
    cost(k) = 0.5*sum(abs(x-y).^2)+lam*sum(abs(Dx));
end


