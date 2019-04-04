clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Não mexer nesses valores
xmax = 5.12;
xmin = -5.12;
numExecucoes = 20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numPOP = 10; % Ajustar conforme necessidade

for numVAR = [2 3 5]
    numGER = (1000 + 10 ^ (numVAR)) / numPOP; % Não alterar
    resultado = [];
    
    for n = 1:numExecucoes
        Vmax = 0.5 * (xmax - xmin);
        POP = xmin + rand(numPOP, numVAR) * (xmax - xmin);
        FX = rastrigin(POP);
        V = 0.2 * (xmin + rand(numPOP,numVAR) * (xmax-xmin));
        [~,ind] = min(FX);
        POPgbest = POP(ind,:);
        FXgbest = FX(ind);
        FXpbest = FX;
        POPpbest = POP;
        
        Om = 1;
        phi1 = 10;
        phi2 = 0.5;
        
        for t = 1:numGER
            progresso = t/numGER;
            
            for i=1:numPOP
                for d=1:numVAR
                    V(i,d)= Om * V(i,d) + phi1 * rand * (POPpbest(i,d) - POP(i,d)) + phi2 * rand * (POPgbest(d) - POP(i,d));
                    V(i,d) = min(V(i,d),Vmax);
                    V(i,d) = max(V(i,d),-Vmax);
                    POP(i,d) = POP(i,d) + V(i,d);
                    POP(i,d) = max(POP(i,d),xmin);
                    POP(i,d) = min(POP(i,d),xmax);
                end
                
                FX(i)= rastrigin(POP(i,:));
                
                if (FX(i) < FXpbest(i))
                    FXpbest(i) = FX(i);
                    POPpbest(i,:) = POP(i,:);
                    if (FX(i) < FXgbest)
                        FXgbest = FX(i);
                        POPgbest = POP(i,:);
                    end
                end
            end
            
            % Descomente as linhas abaixo para exibir os gráficos
%             clf;
%             hold on;
%             plot(POP(:,1),POP(:,2),'b.','linewidth',6);
%             plot(POPgbest(1),POPgbest(:,2),'rx','linewidth',2);
%             axis(5.12 *[-1 1 -1 1]);
%             xlabel([num2str(FXgbest) ' - ' num2str(Vmax)]);
%             drawnow();
        end
        resultado(n) = FXgbest;
%        plot(sort(resultado));
%        xlabel(['Valor médio: ' num2str(mean(resultado))]);
%        grid on;
%        drawnow();
    end
    fprintf('O melhor resultado para %d variáveis foi: %2.4f (média %2.4f)\n',numVAR, min(resultado),mean(resultado));
end
