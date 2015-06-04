function [x, P] = updateEKF(x, P, z, Rf, idf)
    % Inputs:
    %   x, P - the prior state and covariances.
    %   z, R - range-bearing measurements(old) and their covariances.
    %   idf  - feature index for each z.
    % Outputs:
    %   x, P - the posterior state and covariance.
    %% Arrange to block for more efficency in computition.
    lenz = size(z,2);
    lenx = length(x);
     H   = zeros(2*lenz, lenx); % Jacobian.
     Y   = zeros(2*lenz, 1);    % Innovation.
     R   = zeros(2*lenz);       % Measurement covariance.
    for i = 1:lenz
        j = 2*i + (-1:0);
       [zp,H(j,:)] = obsModel(x, idf(i)); 
         Y(j)      = [z(1,i) - zp(1);
                      z(2,i) - zp(2)];
         R(j,j)    = Rf(:,j);
    end
    %% update
    S  = H * P * H' + R;
    K  = P * H' / S;
    x  = x + K * Y; 
    P  = P - K * S * K';
end


