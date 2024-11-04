function prefactor = Aij(hbar, lambda_c, kbT, Vij)

    prefactor = ((2*pi^(3/2))/(hbar*sqrt(lambda_c*kbT)))*Vij.^2;

end