%% Author: Minu Pilvankar
%%This code solves the podocyte RAS ODEs generating change of peptide
%%concentration with time. You can keep glucose level constant or make it a
%%function of time as well. The code uses the parameters generated from
%%Approach 3 (param_estimation_0_5.m - scenario 4).
function out = ODE_glucose_RAS
% for i = 1:length(time)
%close all
%% Load the non-sensitive parameters generated by NG

load('NGvalues','NGvalues');
c_nep = NGvalues(4);
c_ace2 = NGvalues(5);
c_apa = NGvalues(6);
c_at2 = NGvalues(8);


% Coefficients and Half life parameters from literature
hAGT = log(2)/(10*3600);
hANGI = log(2)/(0.62);
hANGII = log(2)/(18);
hANG1_7 = log(2)/(30*60);
hANG1_9 = log(2)/(24*60);
hANGIII = log(2)/(0.5*60);
hAT1 = log(2)/(1.5*60);
hAT2 = log(2)/(1.5*60);
Km = 1250;

% Define the coefficients glucose-dependency



%initial values
AGT0 = 17030e3;
ANGI0 = 270;
ANGII0 = 21;
ANG1_70 = 120;
ANG1_90 = 60;
ANGIII0 = 11;
AT10 = 45;
AT20 = 19;


% Define the ODEs
function dpeptide_dt = ODEs_peptide(t, peptide)
 %peptide(1) = AGT
 %peptide(2) = ANGI
 %peptide(3) = ANGII
 %peptide(4) = ANG1_7
 %peptide(5) = ANG1_9
 %peptide(6) = ANGIII
 %peptide(7) = AT1
 %peptide(8) = AT2

% Run this file to generate the coefficients
% For coefficients from approach 1, use load('coefficientsA1','coefficients');
% For coefficients from approach 1, use load('coefficientsA3','coefficients');
% yy = 3
% if yy == 1
load('coefficientsA3','coefficients');
% elseif yy == 3
% load('coefficientsAd3','coefficients');
% end
% UNCOMMENT THE LINE FOR ONLY OF THE GLU EQUATIONS FOR NORMAL OR DIABETIC SUBJECT AS REQUIRED.
% DOES NOT WORK FOR BOTH GLU EQUATIONS AT A TIME
%% For normal subject
% for yy = [1,2]
%  subject = yy;
%  if subject == 1
%GLU = 4.44*exp(-0.0001*t)*cos(0.0006*t);%5mM if glucose(NG state)

%% For diabetic subject
%  elseif subject == 2
 GLU = 4.4003*exp(-0.0001*t)*cos(0.0004*t);
% end
%% Coefficients
% if yy == 1
% kAGT = coefficients(1);
% c_ACEB = coefficients(2);
% c_at1B = coefficients(6);
% Vmb= coefficients(8);
% c_ACEA = coefficients(9);
% c_at1A = coefficients(10);
% Vma = coefficients(11);
% elseif yy == 3
kAGT = coefficients(1);
c_ACEB = coefficients(2);
c_at1B = coefficients(3);
Vmb= coefficients(4);
c_ACEA = coefficients(5);
c_at1A = coefficients(6);
Vma = coefficients(7);
% end
Vm = Vma*GLU+Vmb;
c_ACE = c_ACEA*GLU + c_ACEB;
c_at1 = c_at1A*GLU + c_at1B;
%% Differential equations
dpeptide_dt = zeros(8,1);
dpeptide_dt(1) = kAGT-(Vm+hAGT)*peptide(1); % dAGT/dt
dpeptide_dt(2) = (Vm*peptide(1))-((c_ACE + c_nep + c_ace2 + hANGI))*peptide(2); %dANGI/dt
dpeptide_dt(3) = (c_ACE)*peptide(2)-(c_ace2 + c_apa + c_at1 + c_at2 + hANGII)*peptide(3); %dANGII/dt
dpeptide_dt(4) = c_nep*peptide(2)+c_ace2*peptide(3)-hANG1_7*peptide(4); %dANG1_7/dt
dpeptide_dt(5) = c_ace2*peptide(2)-hANG1_9*peptide(5); %dANG1_9/dt
dpeptide_dt(6) = c_apa*peptide(3)-hANGIII*peptide(6); %dANGIII/dt
dpeptide_dt(7) = c_at1*peptide(3)-hAT1*peptide(7); %dAT1/dt 
dpeptide_dt(8)= c_at2*peptide(3)-hAT2*peptide(8); %dAT2/dt


%% Calling the solver to solve the system of ODEs

end
% Volume varying from 0 to 1 litre with an increment of 0.01
tspan = 0:100000;
% Initial values based on Fa0, Fb0, Fc0, and T0
peptide0 = [AGT0 ANGI0 ANGII0 ANG1_70 ANG1_90 ANGIII0 AT10 AT20];
% Using ode45 to solve the system of ODEs described in the function ODE_CA3
OPTIONS = odeset('RelTol',1e-8,'AbsTol',1e-8);
[t,peptide] = ode45(@ODEs_peptide,tspan,peptide0,OPTIONS);
% 
% ANG_II = peptide(:,2)
% ANG_I = peptide(:,3)
% save('ANG_II','ANG_II')
% save('ANG_I','ANG_I')
out = peptide;
%Plot peptide concentrations vs Time
% figure(1)
% plot(t,peptide(:,2),'d-',t,peptide(:,3),'s-',t,peptide(:,4),'*-',t,peptide(:,5)...
%     ,'o-',t,peptide(:,6),'d-',t,peptide(:,7),'s-',t,peptide(:,8),'o-','LineWidth',2,'MarkerSize',2);
% %axis([0 1000 0 Inf])
% xlabel('t(seconds)');
% ylabel('Concentration(mol/L)');
% legend('ANGI','ANGII','ANG1-7','ANG1-9','ANGIII','AT1','AT2','Location','Northeast');
thours = t/3600 ;
figure(2)
plot(thours,peptide(:,1),'o-','LineWidth',4);
axis([0 Inf 0 Inf])
xlabel('t(hrs)');
ylabel('Concentration(mol/L)');
legend('AGT','Location','Northeast');

figure(3)
hold on
plot(thours,peptide(:,3),'o-','LineWidth',2,'MarkerSize',2); 
%axis([0 1000 0 Inf])
xlabel('t(hrs)');
ylabel('ANG II Concentration(mol/L)');
hold off
end
%legend('ANGI','ANGII','ANG1-7','ANG1-9','ANGIII','AT1','AT2','Location','Northeast');


% 
