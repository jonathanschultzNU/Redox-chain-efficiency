function rate = kij(Aij, S, n, deltaG, lambda_c, vibfreq, kbT)

    rate = Aij*((exp(-S)*S^n)/factorial(n))...
            *exp((-(deltaG+lambda_c+n*vibfreq)^2)/(4*lambda_c*kbT));

end