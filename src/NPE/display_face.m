function fig = display_face(face, size)
%将输入列向量重置为图片格式，并进行展示
%   face    列向量
%   size    原图片尺寸

    img = mat2gray(reshape(face, size));
    fig = imshow(img);
end

