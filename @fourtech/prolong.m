function f = prolong(f, nOut)
%PROLONG   Manually adjust the number of points used in a FOURTECH.
%   G = PROLONG(F, N) returns a FOURTECH G where LENGTH(G) = N and G represents
%   the same function as F but using more interpolation points/Fourier
%   coefficients then were stored in F.
%
%   If N < LENGTH(F) than the representation is compressed (by aliasing the
%   coefficients), which may result in loss of accuracy.
%
% See also FOURTECH/ALIAS

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Store the number of values the input function has:
nIn = size(f.values, 1);

% nDiff is the number of new values needed (negative if compressing).
nDiff = nOut - nIn;

% Trivial case
if ( nDiff == 0 )
    % Nothing to do here!
    return
end

% Constant case:
if ( nIn == 1 )
    m = size(f.values, 2);
    f.values = repmat(f.values, nOut, 1);
    f.coeffs = [zeros(nDiff, m) ; f.coeffs(1,:)];
    return
end

% Prolong the points using the FFT:
f.coeffs = f.alias(f.coeffs, nOut);
f.values = f.coeffs2vals(f.coeffs);

% Return a strictly real result if the values are real.
if f.isReal
    f.values = real(f.values);
end

end
