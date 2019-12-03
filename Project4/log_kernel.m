function log_kernel = log_kernel(siz,sig)

if  mod(siz,2)==0
    xcenter=(siz/2)-1;
    ycenter=(siz/2)-1;
else
    xcenter=floor(siz/2);
    ycenter=floor(siz/2);
end

for i=-xcenter:floor(siz/2)
    for j=-ycenter:floor(siz/2)
        log_kernel(i+xcenter+1,j+ycenter+1)=(1/(pi*(sig^4)))*((((i^2)+(j^2))/(2*(sig^2)))-1)*(exp(-((i^2)+(j^2))/(2*(sig^2))));
    end
end