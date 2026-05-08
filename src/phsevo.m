%*****  PHASE FRACTION EVOLUTION  *****************************************

tic;

%***  update entropy density

% entropy advection rates and fluxes
[advn_Sx,qz_advn_Sx,qx_advn_Sx] = advect(X.*sx,Ux(2:end-1,:),Wx(:,2:end-1),h,{ADVN,''},[1,2],BCA);
[advn_Sm,qz_advn_Sm,qx_advn_Sm] = advect(M.*sm,Um(2:end-1,:),Wm(:,2:end-1),h,{ADVN,''},[1,2],BCA);

% phase diffusion rates and fluxes
[dffn_S ,qz_dffn_S ,qx_dffn_S ] = diffus(T ,      kT.*rho.*cP./T,h,[1,2],BCD);
[dffn_Se,qz_dffn_Se,qx_dffn_Se] = diffus(Tp,fReL.*ke.*rho.*cP./T,h,[1,2],BCD);

% wall cooling rate
bnd_S = (Tw-T).*rho.*cP./(T+273.15)./(tauw + 3*dt).*bndshape;

% total rates of change
dSdt  = - advn_Sx - advn_Sm + dffn_S + dffn_Se + bnd_S;

% residual of phase density evolution
res_S = (a1*S-a2*So-a3*Soo) - (b1*dSdt + b2*dSdto + b3*dSdtoo)*dt;

% semi-implicit update of entropy density
upd_S = - alpha*res_S/a1;
S     = S + upd_S;
s     = S./rho;

% get temperature from entropy
[Tp,~ ] = StoT(Tp,s,0*Pt,cat(3,m,x,0.*x),[cP;cP;cP],[aT;aT;aT],[bPm;bPx;bPx],cat(3,rhom0,rhox0,rhox0),[Dsm;0;0],T0,P0);
[T ,si] = StoT(T,s,   Pt,cat(3,m,x,0.*x),[cP;cP;cP],[aT;aT;aT],[bPm;bPx;bPx],cat(3,rhom0,rhox0,rhox0),[Dsm;0;0],T0,P0);
sm  = si(:,:,1);  sx  = si(:,:,2);

%***  update phase fraction densities

% phase advection rates and fluxes
[advn_X,qz_advn_X,qx_advn_X] = advect(X,Ux(2:end-1,:),Wx(:,2:end-1),h,{ADVN,''},[1,2],BCA);
[advn_M,qz_advn_M,qx_advn_M] = advect(M,Um(2:end-1,:),Wm(:,2:end-1),h,{ADVN,''},[1,2],BCA);
advn_rho = advn_X+advn_M;

% boundary phase change rate
Gx  = (xq-x).*rho./(taux + 3*dt);

% total rates of change
dXdt  = - advn_X + Gx;

% residual of phase density evolution
res_X = (a1*X-a2*Xo-a3*Xoo) - (b1*dXdt + b2*dXdto + b3*dXdtoo)*dt;

% semi-implicit update of phase fraction densities
upd_X = - alpha*res_X/a1;
X     = X + upd_X;
X     = max(rho.*eps,min(rho.*(1-eps), X ));
M     = rho - X;

% update phase fractions
x     = X./rho; 
m     = M./rho;

% record timing
XEtime = XEtime + toc;
