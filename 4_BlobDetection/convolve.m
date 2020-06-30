function final_image = convolve(input_image, kernel, padding)

[rows, columns] = size(input_image);
[krows,kcolumns] = size(kernel);
if  mod(krows,2)==0
    mrows=(krows/2)-1;
else
    mrows=floor(krows/2);
end
if mod(kcolumns,2)==0
    mcolumns=(kcolumns/2)-1;
else
    mcolumns=floor(kcolumns/2);
end
padded_image = zeros(rows+krows-1, columns+kcolumns-1);

if padding == 1 %zero padding
%     for i=(1+mrows):(rows+mrows)
%         for j=(1+mcolumns):(columns+mcolumns)
%             padded_image(i,j) = input_image(i-mrows,j-mcolumns);
%         end
%     end
    padded_image(1+mrows:rows+mrows, 1+mcolumns:columns+mcolumns)=input_image;
end

if padding == 2 %wrap around padding
%     zero pad
    padded_image(1+mrows:rows+mrows, 1+mcolumns:columns+mcolumns)=input_image;
    if mrows ~= 0
        for i=1:mrows
            for j=(1+mcolumns):(columns+mcolumns)
                padded_image(i,j)=padded_image(rows+i,j); %top section padded
            end
        end
    end
    if floor(krows/2) ~= 0
        for i=rows+mrows+1:rows+krows-1
            for j=(1+mcolumns):(columns+mcolumns)
                padded_image(i,j)=padded_image(i-rows,j); %bottom section padded
            end
        end
    end
    if mcolumns ~= 0
        for i=(1+mrows):(rows+mrows)
            for j=1:mcolumns
                padded_image(i,j)=padded_image(i,columns+j); %left section padded
            end
        end
    end
    if floor(kcolumns/2) ~= 0
        for i=(1+mrows):(rows+mrows)
            for j=columns+mcolumns+1:columns+kcolumns-1
                padded_image(i,j)=padded_image(i,j-columns); %right section padded
            end
        end
    end
    if mrows ~= 0 && mcolumns ~= 0
        for i=1:mrows
            for j=1:mcolumns
                padded_image(i,j) = padded_image(rows+i,columns+j); %top left corner padded
            end
        end
    end
    if mrows ~= 0 && floor(kcolumns/2) ~= 0
        for i=1:mrows
            for j=columns+mcolumns+1:columns+kcolumns-1
                padded_image(i,j) = padded_image(rows+i,j-columns); %top right corner padded
            end
        end
    end
    if floor(krows/2) ~= 0 && mcolumns ~= 0
        for i=rows+mrows+1:rows+krows-1
            for j=1:mcolumns
                padded_image(i,j) = padded_image(i-rows,columns+j); %bottom left corner padded
            end
        end
    end
    if floor(krows/2) ~= 0 && floor(kcolumns/2) ~= 0
        for i=rows+mrows+1:rows+krows-1
            for j=columns+mcolumns+1:columns+kcolumns-1
                padded_image(i,j) = padded_image(i-rows,j-columns); %bottom right corner padded
            end
        end
    end
end

if padding == 3 %copy padding
%     zero pad
    padded_image(1+mrows:rows+mrows, 1+mcolumns:columns+mcolumns)=input_image;
    if mrows ~= 0
        for i=1:mrows
            for j=(1+mcolumns):(columns+mcolumns)
                padded_image(i,j)=padded_image(mrows+1,j); %top section padded
            end
        end
    end
    if floor(krows/2) ~= 0
        for i=rows+mrows+1:rows+krows-1
            for j=(1+mcolumns):(columns+mcolumns)
                padded_image(i,j)=padded_image(rows+mrows,j); %bottom section padded
            end
        end
    end
    if mcolumns ~= 0
        for i=(1+mrows):(rows+mrows)
            for j=1:mcolumns
                padded_image(i,j)=padded_image(i,mcolumns+1); %left section padded
            end
        end
    end
    if floor(kcolumns/2) ~= 0
        for i=(1+mrows):(rows+mrows)
            for j=columns+mcolumns+1:columns+kcolumns-1
                padded_image(i,j)=padded_image(i,columns+mcolumns); %right section padded
            end
        end
    end
    if mrows ~= 0 && mcolumns ~= 0
        for i=1:mrows
            for j=1:mcolumns
                padded_image(i,j) = padded_image(mrows+1,mcolumns+1); %top left corner padded
            end
        end
    end
    if mrows ~= 0 && floor(kcolumns/2) ~= 0
        for i=1:mrows
            for j=columns+mcolumns+1:columns+kcolumns-1
                padded_image(i,j) = padded_image(mrows+1,columns+mcolumns); %top right corner padded
            end
        end
    end
    if floor(krows/2) ~= 0 && mcolumns ~= 0
        for i=rows+mrows+1:rows+krows-1
            for j=1:mcolumns
                padded_image(i,j) = padded_image(rows+mrows,mcolumns+1); %bottom left corner padded
            end
        end
    end
    if floor(krows/2) ~= 0 && floor(kcolumns/2) ~= 0
        for i=rows+mrows+1:rows+krows-1
            for j=columns+mcolumns+1:columns+kcolumns-1
                padded_image(i,j) = padded_image(rows+mrows,columns+mcolumns); %bottom right corner padded
            end
        end
    end
end

if padding == 4 %reflect padding
%     zero pad
    padded_image(1+mrows:rows+mrows, 1+mcolumns:columns+mcolumns)=input_image;
    if mrows ~= 0
        for i=1:mrows
            for j=(1+mcolumns):(columns+mcolumns)
                padded_image(mrows-i+1,j)=padded_image(mrows+i,j); %top section padded
            end
        end
    end
    if floor(krows/2) ~= 0
        for i=rows+mrows+1:rows+krows-1
            for j=(1+mcolumns):(columns+mcolumns)
                padded_image(i,j)=padded_image(2*(rows+mrows)-i+1,j); %bottom section padded
            end
        end
    end
    if mcolumns ~= 0
        for i=(1+mrows):(rows+mrows)
            for j=1:mcolumns
                padded_image(i,mcolumns-j+1)=padded_image(i,mcolumns+j); %left section padded
            end
        end
    end
    if floor(kcolumns/2) ~= 0
        for i=(1+mrows):(rows+mrows)
            for j=columns+mcolumns+1:columns+kcolumns-1
                padded_image(i,j)=padded_image(i,2*(columns+mcolumns)-j+1); %right section padded
            end
        end
    end
    if mrows ~= 0 && mcolumns ~= 0
        for i=1:mrows
            for j=1:mcolumns
                padded_image(mrows-i+1,mcolumns-j+1) = padded_image(mrows+i,mcolumns+j); %top left corner padded
            end
        end
    end
    if mrows ~= 0 && floor(kcolumns/2) ~= 0
        for i=1:mrows
            for j=columns+mcolumns+1:columns+kcolumns-1
                padded_image(mrows-i+1,j) = padded_image(mrows+i,2*(columns+mcolumns)-j+1); %top right corner padded
            end
        end
    end
    if floor(krows/2) ~= 0 && mcolumns ~= 0
        for i=rows+mrows+1:rows+krows-1
            for j=1:mcolumns
                padded_image(i,mcolumns-j+1) = padded_image(2*(rows+mrows)-i+1,mcolumns+j); %bottom left corner padded
            end
        end
    end
    if floor(krows/2) ~= 0 && floor(kcolumns/2) ~= 0
        for i=rows+mrows+1:rows+krows-1
            for j=columns+mcolumns+1:columns+kcolumns-1
                padded_image(i,j) = padded_image(2*(rows+mrows)-i+1,2*(columns+mcolumns)-j+1); %bottom right corner padded
            end
        end
    end
end

for i=(1+mrows):(rows+mrows)
    for j=(1+mcolumns):(columns+mcolumns)
        sum=0;
        for p=-mrows:floor(krows/2) %moving through the kernel
            for q=-mcolumns:floor(kcolumns/2)
                sum = sum + kernel(p+mrows+1,q+mcolumns+1)*padded_image(i+p,j+q); %convolution
            end
        end
        final_image(i-mrows,j-mcolumns) = sum;
    end
end