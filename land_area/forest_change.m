function forest_change(region,i0,i1)
    source = "./land_area/satellite_images/area"+num2str(region);
    img1 = char(source+"/"+num2str(i0)+".png");
    img2 = char(source+"/"+num2str(i1)+".png");
    
    i0 = imread(img1);
    i1 = imread(img2);
    
    [green_region1,thres_binary1,area1]=area(i0);

    [green_region2,thres_binary2,area2]=area(i1);
	
    figure,imshow(green_region1);
    title('Forest Cover Region');
    figure,imshow(thres_binary1);
    title('Thresholded Forest Cover');
    
    figure,imshow(green_region2);
    title('Forest Cover Region');
    figure,imshow(thres_binary2);
    title('Thresholded Forest Cover');
    
    no_change = bitand(thres_binary1,thres_binary2);    %imshow(ij1-~ij2);
    figure,imshow(no_change);
    title('No change in Forest Cover');
    loss = imsubtract(thres_binary1, no_change);
    loss_red = uint8(cat(3, loss * 255, loss * 0, loss * 0));
    figure,imshow(imadd(i0,loss_red));
    title('Forest Cover Loss');
end