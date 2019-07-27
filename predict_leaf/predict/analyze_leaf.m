function [chloro, nitrogen, leaf_type, oxygen] = analyze_leaf(imgnum)
   chloro    =predict_chlorophyll(imgnum);  %ug/ml or ug/1000mm3
   nitrogen  =predict_nitrogen(imgnum);     %percentage
   leaf_type =process_predict_leaf(imgnum);
   oxygen    =((chloro/1000)*10)*9*365*15.652114/0.005; %assuming 9 hours of sunlight in a day
   
   fprintf('Leaf Class: %d\n', leaf_type);
   fprintf('Nitrogen: %f percent\n', nitrogen);
   fprintf('Chlorophyll: %f ug/ml\n', chloro);
   fprintf('Oxygen: %f mm3/year/m2\n', oxygen);
   
   %(chloro/1000)*10 = amt of ug of chlorophyll per 50 sq.cm
   %((chloro/1000)*10)*15.652114/0.005 = mm3 of oxygen per hour per sq.m
end
   