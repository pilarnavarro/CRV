% name : Pilar Navarro Ramírez
% student number : 3086150

function [ fimCorr ] = myCorrelation( fim, fop )
%MYCORRELATION calculation 2D correlation for CRV
%   fimCorr = myCorrelation(fim,fop) calculates the correlation of the
%   image function fim and the operator function fop as introduced in the
%   CRV lecture. Both fim and fop have to be matrices. fop has to be
%   smaller than fim and of odd size. fimCorr is of the same size as fim.
%   The outer pixels, where the correlation can not be calculated
%   sufficiently, are set to zero.

    if(~ismatrix(fim))||(~ismatrix(fop))
        error('Error. Both arguments have to be matrices.')
    elseif ~isOdd(fop)
        error('Error. Operator pattern have to be of odd size.')
    elseif ~isSmaller(fim,fop)
        error('Error. Operator pattern is not sufficiently smaller than the image.')
    else
        fim=double(fim);
        fop=double(fop);
        szim=size(fim);
        fimCorr=zeros(szim(1),szim(2));
        for i=2:(szim(1)-1)
            for j=2:(szim(2)-1)
               fimCorr(i,j)=Corr(i,j,fim,fop);
            end
        end
        
    end
end

function odd= isOdd(fop)
  %ISODD determines whether or not the operator pattern fop
  %     is of odd size. odd is a logical value set to true if fop is of odd size
  odd=true;
  sz=size(fop);
  if(mod(sz(1),2)==0)||(mod(sz(2),2)==0)
      odd=false;
  end
end

function smaller=isSmaller(fim,fop)
    %ISSMALLER determines whether or not the operator pattern fop is 
    %   sufficiently smaller than the image fim. This means fop has to 
    %   fit in fim at least at one position.
    %   smaller is a logical value set to true if fop is sufficiently
    %   smaller, and false otherwise.
    smaller=true;
    szim=size(fim);
    szop=size(fop);
    if(szim(1)<szop(1))||(szim(2)<szop(2))
        smaller=false;
    end
end

function pixel=Corr(i,j,fim,fop)
        pixel=0;
        szop=size(fop);
        h1=(szop(2)-1)/2;
        h2=(szop(1)-1)/2;
        for k=-h2:h2, m=1:szop(1);
            for l=-h1:h1, n=1:szop(2);
                op=1+szop(1)-m
                n  %no lo detecta en el for
                op2=fop(op,n)
                im=fim(i+k,j+l)
                pixel=pixel+fop(op,n)*fim(i+k,j+l)
            end
        end
end