function coupling = Vij(V0, atoms, beta, Rij)

    coupling = (V0/atoms)*exp(-(beta*Rij)/2); 
    % Ni = Nj, so V0 is just divided by the atom number
end