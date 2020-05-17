function sumofvalues = SumofEigen(value,diagS)
sumofvalues = 0;
for i = 1:value
    sumofvalues = sumofvalues + diagS(136 - i+1);
end
end

