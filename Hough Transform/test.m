clear
% Creating a simple image
im = zeros(101,101);
im(1,1) = 1;
im(1,end) = 1;
im(end,1) = 1;
im(end,end) = 1;
im(floor(end/2),floor(end/2)) = 1;
figure
imshow(im)

theta = ((-90:90)./180) .* pi;
D = sqrt(size(im,1).^2 + size(im,2).^2);
HS = zeros(ceil(2.*D), numel(theta));

[y,x] = find(im); %%nonzero 
y = y - 1;
x = x - 1;


figure
rho = cell(1,numel(x));
%% Calculating the Hough Transform
for i = 1: numel(x)
    rho{i} = x(i).*cos(theta) + y(i).*sin(theta); % [-sqrt(2),sqrt(2)]*D rho interval
    plot(theta,-rho{i})
    hold on
end
%% Creating the Hough Space as an Image
for i = 1:numel(x)
    rho{i} = rho{i} + D; % mapping rho from 0 to 2*sqrt(2)
    rho{i} = floor(rho{i}) + 1;
    for j = 1:numel(rho{i})
        HS(rho{i}(j),j) = HS(rho{i}(j),j) + 1; 
    end
end
figure
imshow(HS)
