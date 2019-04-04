function FX = calculaFX(POP)
    
    [numPOP,numVAR] = size(POP);
    FX = repmat(10 * numVAR,numPOP,1);
    for i = 1:numPOP
        for d = 1:numVAR
            FX(i) = FX(i) + POP(i,d) ^ 2 - 10*cos(2*pi*POP(i,d));
        end
    end
end