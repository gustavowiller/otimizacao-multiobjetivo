function FX = rastrigin(POP)
    [nPOP, dim] = size(POP);

    FX = ones(nPOP,1) * 10 * dim;

    for d = 1:dim
        FX = FX + POP(:,d).^2 - 10*cos(2*pi*POP(:,d));
    end
    FX = FX;
end