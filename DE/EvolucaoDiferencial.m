function [POP,FX] = EvolucaoDiferencial(numVAR)
    tamPOP = 50;
    criterioParada = 1e4;
    xmin = -5.12;
    xmax = 5.12;
    
    POP = xmin + rand(tamPOP,numVAR) * (xmax - xmin);
    FX = calculaFX(POP);
    numIND = tamPOP;
     
    while (numIND < criterioParada)
        for i = 1:tamPOP
            R = randperm(tamPOP);
            P = POP(R(1),:) + (0.5 * rand - 0.5) * (POP(R(2),:) - POP(R(3),:));
            
            j = randperm(numVAR);
            
            for d = 1:numVAR
                if ((rand < 0.3) && (d ~= j(1)))
                    P(d) = POP(i,d);
                end
                %P(d) = P(d) + 0.2 * (rand - 0.5) * (xmax - xmin);
            end
                        
            P = max(P,xmin);
            P = min(P,xmax);
            
            F = calculaFX(P);
            numIND = numIND + 1;
            
            if (F < FX(i)) % Se o novo indivíduo for melhor que o seu pai
                POP(i,:) = P;
                FX(i) = F;
            end
        end
        
%         plot(POP(:,1),POP(:,2),'ro');
%        parallelcoords(POP);
%        grid on;
%         axis([-5.12 5.12 -5.12 5.12]);
%         pause(0.1);
%        drawnow();
    end
    min(FX)
end
