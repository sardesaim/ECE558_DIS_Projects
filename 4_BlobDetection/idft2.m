function [recovImg] = idft2(dftImg)
%IDFT2 Summary of this function goes here
    [M N ch] = size(dftImg);
    if ch>1
        recovImg(:,:,1) = (1/numel(dftImg(:,:,1))).*real(conj(dft2(conj(dftImg(:,:,1)))));
        recovImg(:,:,2) = (1/numel(dftImg(:,:,2))).*real(conj(dft2(conj(dftImg(:,:,2)))));
        recovImg(:,:,3) = (1/numel(dftImg(:,:,3))).*real(conj(dft2(conj(dftImg(:,:,3)))));
        recovImg(:,:,1) = (recovImg(:,:,1)-min(recovImg(:,:,1)))./(max(recovImg(:,:,1))-min(recovImg(:,:,1)));
        recovImg(:,:,2) = (recovImg(:,:,2)-min(recovImg(:,:,2)))./(max(recovImg(:,:,2))-min(recovImg(:,:,2)));
        recovImg(:,:,3) = (recovImg(:,:,3)-min(recovImg(:,:,3)))./(max(recovImg(:,:,3))-min(recovImg(:,:,3)));
    else
        recovImg = (1/numel(dftImg)).*real(conj(dft2(conj(dftImg))));
%         recovImg = (recovImg-min(recovImg(:)))./(max(recovImg(:))-min(recovImg(:)));
    end
end

