function GP=gpcalc(grades)
if grades<50
    GP=0;
elseif grades<=53
    GP=0.7;
elseif grades<=57
    GP=1.0;
elseif grades<=60
    GP=1.3;
elseif grades<=63
    GP=1.7;
elseif grades<=67
    GP=2.0;
elseif grades<=70
    GP=2.3;
elseif grades<=73
    GP=2.7;
elseif grades<=77
    GP=3.0;
elseif grades<=80
    GP=3.3;
elseif grades<=85
    GP=3.7;
elseif grades<90
    GP=4.0;
else 
    GP=4.3;
end