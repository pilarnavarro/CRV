%% MYFACREC Recursive factorial calculation
 %This function implements the calculation of the factorial for natural numbers .
function f=MyFacRec(n)
	if n>1
		f=n*MyFacRec(n-1);
	else
		f=1;
	end
end


