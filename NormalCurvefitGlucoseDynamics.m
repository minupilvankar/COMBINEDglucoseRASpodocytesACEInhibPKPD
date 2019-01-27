%% Author: Minu Pilvankar
%%This code GENERATES THE BEST FITTED CURVE BASED ON THE DATA POINTS FOR
% GLUCOSE CONCENTRATION VS TIME FROM NORMAL AND DIABETIC SUBJECTS. THE
% FITTED CURVE REPRESENTS THE GLUCOSE DYNAMICS OVER A PERIOD OF TIME. THIS
% CODE GENERATED THE COEFFICIENTS OF THE POLYNOMIAL EQUATION EXPECTED TO DEFINE THE
% CURVE.
function out = NormalCurvefitGlucoseDynamics
close all

% %Diabetic data set (data1)
xdata = [0	2734.177215	3281.012658	3827.848101	5741.772152	8065.822785	8475.949367	8886.075949	9979.746835	11483.5443	12577.21519	14081.01266	15448.10127	16678.48101	17362.02532	18182.27848	19002.53165	20643.03797	21463.29114	23787.34177	26658.22785	28982.27848	31169.62025	33220.25316	34997.46835	36501.26582	37458.22785	39508.86076	38005.06329	40329.11392	41832.91139	42653.16456	43883.5443	45250.63291	46070.88608	47437.97468	47848.10127	48668.35443	49898.73418	51265.82278	52632.91139	54136.70886	55093.67089	56324.05063	57554.43038	58921.51899	61108.86076	62612.65823	64526.58228	65210.12658	66440.50633	68081.01266	70131.64557	70951.89873	73139.24051	75053.16456	77103.79747	79291.13924	79974.68354	81888.60759	83392.40506	85306.32911	86400];% for diabetic patient from paper
xdata2 = xdata./3600;
ydata2 = [7.894736842	8.870813397	8.325358852	9.444976077	10.82296651	12.97607656	14.35406699	14.98564593	14.64114833	15.78947368	15.84688995	13.14832536	13.32057416	11.71291866	12.20095694	11.05263158	11.45454545	10.79425837	10.10526316	11.74162679	12.31578947	10.88038278	11.19617225	9.818181818	9.732057416	9.961722488	9.531100478	9.444976077	10.10526316	8.870813397	8.124401914	8.698564593	8.354066986	9.330143541	10.16267943	10.10526316	10.44976077	9.61722488	9.61722488	9.387559809	9.301435407	9.100478469	8.612440191	8.899521531	8.23923445	8.468899522	8.468899522	8.755980861	8.899521531	8.497607656	8.325358852	8.612440191	8.23923445	8.440191388	8.698564593	8.526315789	9.502392344	8.784688995	9.387559809	8.899521531	9.244019139	8.555023923	8.669856459 ];% for diabetic patient from paper

%normal data set (data2)
xdata1 = [393.6/3600	5969.9/3600	8931.2/3600	14967.6/3600	17701.1/3600	20206.8/3600	22029.1/3600	23509.7/3600 25787.6/3600	26357.1/3600	27040.5/3600	28407.2/3600	30001.8/3600	32165.8/3600	33874.2/3600	36379.9/3600	38771.7/3600	39796.8/3600	41505.2/3600	46744.4/3600	49022.3/3600	50161.2/3600 52439.17/3600	53464.2/3600	53919.8/3600	56425.5/3600	58703.4/3600	59614.5/3600	61436.9/3600	62120.2/3600	63373.1/3600	63828.7/3600	64739.8/3600	66334.39/3600	66789.9/3600	68840.0/3600	70434.6/3600	71687.4/3600	73168.1/3600	74876.5/3600	76584.9/3600	77837.8/3600	79432.3/3600	80229.6/3600	81482.4/3600	82507.5/3600	84329.8/3600	85468.7/3600	86400/3600];
 ydata1 = [6.579310345	7.98697318	7.292528736	6.622030651	6.190996169	5.496551724	6.717816092	6.885440613	6.286781609	6.622030651	6.047318008	6.981226054	6.981226054	5.999425287	6.526245211	5.233141762	4.82605364	5.281034483	4.969731801	7.148850575	6.909386973	6.40651341	6.40651341	6.143103448	6.622030651	6.262835249	6.071264368	5.759961686	5.736015326	6.143103448	6.071264368	6.38256705	5.879693487	6.813601533	6.598084291	6.693869732	6.957279693	6.622030651	6.693869732	6.167049808	6.40651341	6.214942529	6.310727969	5.999425287	6.645977011	6.693869732	6.262835249	6.33467433	6.40651341];
%% Define the degree of polynomial

%% For Diabetic
len1 = length(xdata1);
len2 = length(xdata2);
num = max(len1,len2);
for  i = 1:len1
   % for i = 1:len2  
  n2 = i; 
  n1 = i;
p2 = polyfit(xdata2, ydata2,n2);


% POLYVAL

y2 = polyval(p2,xdata2);
% Find RMSE

RMSEn(i) = sqrt(mean((ydata2 - y2).^2));
if RMSEn(i) < 0.4
   % n1;i
%     p1;
    out = p2;
    return
end 
%% For normal subject
%n1 = j;

% for j = 1:len1
    n1 =i;

p1 = polyfit(xdata1, ydata1,n1);


% POLYVAL

y1 = polyval(p1,xdata1);
% Find RMSE

RMSE(i) = sqrt(mean((ydata1 - y1).^2));
if RMSE(i) < 0.29
   % n1;
%     p1;
    out = p1;
    return
end 

 %save('p2','p2');
   
%% Plot for polyfit

red=[0.6350, 0.0780, 0.1840];
blue = [0, 0.4470, 0.7410];
green=[0.4660, 0.6740, 0.1880];
yellow = [0.9290, 0.6940, 0.1250];

xhours2 = xdata2./3600;

figure(1)
 
plot(xdata1,ydata1,'o',xdata1,y1,'-','LineWidth',2,'Color',blue,'MarkerSize',5,'MarkerEdgeColor',green)
hold on
plot(xdata2,ydata2,'x',xdata2,y2,'-.','LineWidth',3,'Color',red,'MarkerSize',6,'MarkerEdgeColor',yellow)
 
 hold off
legend('*Data points for normal subject','Fit for normal subject',...
   '*Data points for diabetic subject','Fit for diabetic subject','Location','NorthEast')
%legend('Data for subject1','Fit for subject 1')
xlabel('Time (hours)','Fontsize',10)
ylabel('[Glucose] (mmol/L)','Fontsize',10)
axis([0 24 0 25])
set(gca,'Fontsize',10);
ax = gca;
set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 5 3]);
%set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 5 3]);
%export_fig('C:/Research/kidneydiabetes/BullMathBiol/figures/fig11aP1P2', '-pdf', '-png', '-eps', '-tiff');
%title('Data and Fitted Curve')
% save('timer','xdata2');
% save('p2','p2');
%%
%Trying to make a plot of the fit polynomial alone
% figure(4)
% % % t = [0,24];
% % %these values are from p2 generated earlier by polyfit
% % %w = 4.158+(26.17.*t)-(39.80.*t.^2)+(27.96.*t.^3)-(11.24.*t.^4)+(2.84.*t.^5)-(0.47.*t.^6)+(0.054.*t.^7)-(0.0043.*t.^8)+(0.00023.*t.^9)-(8.75e-6.*t.^10)+(2.1e-7.*t.^11)-(2.95e-9.*t.^12)+(1.84e-11.*t.^13)
% equation = poly2sym(p2);
% syms x t
% glucose_con = subs(equation,x,t)
% w = polyval(p2,xdata2);
% plot(xdata2,w);
end
end

