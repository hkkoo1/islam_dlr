function [zf, idf, Rf, zn, Rn, cList] = correspond(x, z, R, idz, cList)
    % Maintains a measurement corresponding list. 
    % Adapted from code by Tim Bailey
    % Inputs:
    %    x    - global state covarianc.
    %    z    - observations.
    %   idz   - observations' ID.
    %   cList - corresponding list recoding the observations appearance order.
    % Outputs:
    %  zf, idf, Rf - old observations(already add to the list) and their ID.
    %     zn, Rn   - new observations and their covariances.
    %     cList    - updated corresponding list.  
    %% Store old observations, new observations and their index.
    % Old measurements used to update. New measurements added to global augment state.
     zf = [];  zn = [];
    idf = []; idn = [];
     Rf = [];  Rn = [];
    %% Distinguish old and new measurements.
    for i  = 1:length(idz)
        ii = idz(i);
        j  = 2*i + (-1:0);
        if cList(ii) == 0         % New measurements.
            zn  = [zn z(:,i)];
            idn = [idn ii];       % ID.
            Rn  = [Rn R(:,j)];
        else                      % Old measurements.
            zf  = [zf z(:,i)];
            idf = [idf cList(ii)];% Index to measurements.
            Rf  = [Rf R(:,j)];
        end
    end
    %% Add new features order to corresponding list
    Nxv        = 3;                   
    Nf         = (length(x) - Nxv)/2; % Measurements number in map.
    cList(idn) = Nf + (1:size(zn,2)); % Add new measurements' index.
end