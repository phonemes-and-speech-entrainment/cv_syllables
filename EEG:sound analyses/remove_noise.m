%linear regression used to remove noise
function F_pow=remove_noise(Pow,f)
logf=log(f);
logpow=log(Pow);
H=[ones(length(logf),1),logf];
Astar=inv(H'*H)*H'*logpow;
Ytilde=H*Astar;
L_pow=logpow-Ytilde;
F_pow=exp(L_pow);




