function spatiotemporal_change(region,leaf_num)
    source = "./land_area/satellite_images/area"+num2str(region);
    i1 = imread(char(source+"/1.png"));
    i2 = imread(char(source+"/2.png"));
    i3 = imread(char(source+"/3.png"));
    i4 = imread(char(source+"/4.png"));
    [green_region1,thres_binary1,area1]=area(i1);
    [green_region2,thres_binary2,area2]=area(i2);
    [green_region3,thres_binary3,area3]=area(i3);
    [green_region4,thres_binary4,area4]=area(i4);
	
    fileID = fopen(char(source+"/conversion.txt"),'r');
    formatSpec = '%dpx = %f m2';
    A = fscanf(fileID,formatSpec);
    conv = A(2);
   
    fileID = fopen(char(source+"/place.txt"),'r');
    formatSpec = '%s';
    A = fscanf(fileID,formatSpec);
    
    area1 = area1*conv; %m2
    area2 = area2*conv; %m2
    area3 = area3*conv; %m2
    area4 = area4*conv; %m2
    
    changes= [area1,area2,area3,area4];
    figure,bar([1999,2005,2011,2018],changes);
    title(char("Forest Cover: "+A));
    xlabel('Year')
    ylabel('10^8 m^2 of Forest cover')
    
    [chloro, nitrogen, leaf_type, oxygen] = analyze_leaf(leaf_num);
    
    oxy_changes = changes*oxygen*1e-12;
    figure,bar([1999,2005,2011,2018],oxy_changes);
    title(char("Oxygen Production: "+A));
    xlabel('Year')
    ylabel('10^3 m^3 of Oxygen per year')
    X = [1999,2005,2011,2018];
    p = polyfit(X,oxy_changes,1)
    f = polyval(p,X);
    hold on
    plot(X,f,'--r')
    hold off
    figure,roc_curve(f,oxy_changes); 
end