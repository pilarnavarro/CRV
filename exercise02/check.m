%myCorrelation(rand(640,480),rand(3,3));
%myCorrelation(rand(640,480,3), rand(3,3)) %error
%myCorrelation(rand(640,480), rand(5,3)); 
%myCorrelation(rand(640,480), rand(4,3)) %error
%myCorrelation(rand(640,480), rand(7,7)); 
%myCorrelation(rand(640,480), rand(501,501)) %error

fim = magic (4) ; % A magic square
fop = kron ( [ -1; 0; 1] , ones (1 ,3) ) ; % Vertical Prewitt
fimCorr = myCorrelation ( fim , fop )

fimCorr = myCorrelation ( magic (5) , magic (3) )

fimCorr = myCorrelation ( magic (5) , -1:1)

fimCorr = myCorrelation ( magic (5) ,(-1:1)' )
