function power_supply_sc_P18()

close all;
%Cargo los datos
TableData=importdata('../LTSPICE/power_supply_P15.txt');
Data = TableData.data;

%Paso la corriente a mA.
%Data(:,3)=-1000*Data(:,3);

X1=Data(:,1);

Y1=Data(:,2);

%Y2=Data(:,2);

% Create figure
figure1 = figure;

% Create subplot
% subplot1 = subplot(2,1,1,'Parent',figure1);
% hold(subplot1,'on');

% Create plot
plot(X1,Y1,'Linewidth',2);

% Create ylabel
ylabel('Output Voltage [V]');

% Create xlabel
xlabel('V1 [V]');
grid on;
grid minor;
% set(gca,'FontSize',13,'XTick',...
%     [0 2.5 5 7.5 10 12.5 15 17.5 20 22.5 25 27.5 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100]);
title ('Variacion del voltage de salida por la variacion de la fuente de alimentacion','fontsize', 15,'fontweight','bold');
%axis([0.9 30 -0.1 10])
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[90 200]);
% box(subplot1,'on');
% Set the remaining axes properties
% set(subplot1,'XDir','reverse','XGrid','on','XMinorTick','on','XTick',...
%     [0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100],'YGrid',...
%     'on','YMinorTick','on','YTick',...
%     [0 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200]);


% Create subplot
% subplot2 = subplot(2,1,2,'Parent',figure1);
% hold(subplot2,'on');
% 
% plot(X1,Y2,'Color',[1 0 0],'Parent',subplot2);

% Create ylabel
% ylabel('Output voltage [V]');

% Create xlabel
% xlabel('Load resistance [\Omega]');

% box(subplot2,'on');
% Set the remaining axes properties
% set(subplot2,'XDir','reverse','XGrid','on','XMinorTick','on','XTick',...
%     [0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100],'YGrid',...
%     'on','YMinorTick','on','YTick',...
%     [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);



