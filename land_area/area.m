function [it2, ij1, area_] = area(i0)
    it = im2double(i0);

    [row column page] = size(it);
    mask = it(:,:,2) > it(:,:,1) & it(:,:,2) > it(:,:,3);

    it2 = it .* mask(:,:,[1 1 1]);

    ij1 = rgb2gray(it2)>0;
    area_ =(nnz(ij1));	

end