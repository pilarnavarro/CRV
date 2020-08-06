% name : Pilar Navarro Ramírez
% student number : 3086150

function [ x, y ] = MyActiveContour( I, x0, y0, N, SIGMA )
    % MYACTIVECONTOUR performs simple contour extraction
    %   [ x, y ] = MyActiveContour( I, x0, y0, N, sigma ) extracts the boundary
    %   of a object. I is a intensity image. x0 and y0 are column vectors
    %   containing the coordinates of the initial curves vertices. The last
    %   vertex has to equal the first one. N defines the number of iteration. A
    %   gaussian blur with variance sigma is applied on the image first.
    
    % Smoothing
    I=imgaussfilt(I,SIGMA);
    I=im2double(I);
    % MoG
    
    fop_x=[-1 0 1;-2 0 2;-1 0 1];
    fop_y=(fop_x)';
    h_derivation=imfilter(I,fop_x);
    %h_derivation=double(h_derivation);
    v_derivation=imfilter(I,fop_y);
    %v_derivation=double(v_derivation);
    MoG=sqrt(h_derivation.^2 + v_derivation.^2);
   
    % E_ima
     MoG(MoG<1/10000)=1/10000;
     E_ima=1./MoG;      
    % Initialization    
    vertices=size(x0)-1;
    x=x0;
    y=y0;
    
    % Shrinking method
    for k=1:N
        for i=1:vertices
            %Coordinates of current point
            vi=[x(i) y(i)];
            %Coordinates of neighboring point
            v_i=[x(i+1) y(i+1)];
            u=v_i-vi;
            s=sign(u);
            p=vi+s;
            if E_ima(p(1),p(2))<= E_ima(vi(1),vi(2))
                x(i)=p(1);
                y(i)=p(2);
            end
        end
        x(vertices+1)=x(1);
        y(vertices+1)=y(1);
    end
end

