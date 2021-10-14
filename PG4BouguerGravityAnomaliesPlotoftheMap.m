clear

data = load('dogu.txt');
latnad83 = data(:,3);
lonnad83 = data(:,4); 
elevngvd88m = data(:,5); 
faanom =  data(:,2); 
figure(1) 
plot(lonnad83,latnad83,'k+','Color','r');
hold on

bfid = fopen('counties.bln');

while feof(bfid)==0;
    
    n = fscanf(bfid,'%i,%i',2);
    if isempty(n)==1;
        break
    end
    fila = fscanf(bfid,'%g,%g',[2 n(1)]);
    if n(1)~=length(fila(1,:));
        fila = fscanf(bfid,'%g %g',[2 n(1)]);
    end
    la=fila(1,:);
    fi=fila(2,:);
    plot(la,fi,'Color',[.4 .4 .4],'LineWidth',1);
    title('Calculation of Bouguer Gravity Anomalies')
    ylabel('Latitude')
    xlabel('Longitude')
    hold on

end