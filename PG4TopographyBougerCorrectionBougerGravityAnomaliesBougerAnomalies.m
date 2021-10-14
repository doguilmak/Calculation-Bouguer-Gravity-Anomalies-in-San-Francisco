clear
clc

bfid = fopen('counties.bln');

##while feof(bfid)==0;
##    
##    n = fscanf(bfid,'%i,%i',2);
##    if isempty(n)==1;
##        break
##    end
##    fila = fscanf(bfid,'%g,%g',[2 n(1)]);
##    if n(1)~=length(fila(1,:));
##        fila = fscanf(bfid,'%g %g',[2 n(1)]);
##    end
##    la=fila(1,:);
##    fi=fila(2,:);
##    plot(la,fi,'Color',[.4 .4 .4],'LineWidth',1);
##    title('Calculation of Bouguer Gravity Anomalies')
##    ylabel('Latitude')
##    xlabel('Longitude')
##    hold on
##
##end

data = load('dogu.txt');
latnad83 = data(:,3);
lonnad83 = data(:,4);
elevngvd88m = data(:,5);
faanom = data(:,2);

plot(lonnad83,latnad83,'k+'); 
plot3(lonnad83,latnad83,elevngvd88m,'k+');

for i = 1 : length(elevngvd88m)
  if elevngvd88m(i) < 0
    BO(i,1) = -0.0687 * elevngvd88m(i);	%if depths are negative numbers
  else
    BO(i,1) = -0.1119 * elevngvd88m(i);
  end
end

x = -121.48:0.013:-120.70;
y = 37.167:0.01463333333:38.045;
[X,Y] = meshgrid(x,y);
Z = griddata(lonnad83,latnad83,faanom,X,Y);
surf(X,Y,Z)
subplot(2,2,3)
view(35,45)
zlabel('mGal/m')#bouger correction
ylabel('Latitude')
colorbar
xlabel('Longitude')
hold on

Z1 = griddata(lonnad83,latnad83,BO,X,Y);
title('c) Bouger Correction') 
surf(X,Y,Z1)
subplot(2,2,1)
view(35,45)
zlabel('m')# topography
ylabel('Latitude')
colorbar
xlabel('Longitude')
hold on
%
Z2 = griddata(lonnad83,latnad83,elevngvd88m,X,Y);
title('a) Topography')
surf(X,Y,Z2)
subplot(2,2,4)
view(35,45)
zlabel('mGal/m')#f-airanomalies-bouger anomalies
ylabel('Latitude')
colorbar
xlabel('Longitude')
hold on

Z3 = griddata(lonnad83,latnad83,faanom+BO,X,Y);
title('d) Bouger Anomalies')
surf(X,Y,Z3)
subplot(2,2,2)
view(35,45)
ylabel('Latitude')
colorbar
xlabel('Longitude')
hold on

Z4 = griddata(lonnad83,latnad83,faanom,X,Y);
title('b) f-air Anomalies')%f-air anomalies
zlabel('mGal/m')# f-airanomalies
surf(X,Y,Z4)