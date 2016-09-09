function w=wDurch(x,l,q0,EIy)
    %w=1/(EIy)*(1/24 *q0*x^4 - 1/6 *q0*l*x^3 + 1/4 * q0*l^2 * x^2); % Streckenlast

    w = (q0*l^3)/(3*EIy);

end