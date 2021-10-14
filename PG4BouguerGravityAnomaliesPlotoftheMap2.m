clear
data = load('dogu.txt');

latnad83 = data(:,3);
lonnad83 = data(:,4); 
elevngvd88m = data(:,5); 
faanom =  data(:,2); 
plot3(lonnad83,latnad83,elevngvd88m,'k+');

x = -121.48:0.013:-120.70;
y = 37.167:0.01463333333:38.045; 
[X,Y] = meshgrid(x,y);
Z = griddata(lonnad83,latnad83,faanom,X,Y);
surf(X,Y,Z)
title('f-air Anomalies')
zlabel('mGal/m')#f-airanomalies
ylabel('Latitude')
colorbar
xlabel('Longitude')