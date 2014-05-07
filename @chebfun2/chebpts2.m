function [xx, yy] = chebpts2(nx, ny, D)
%CHEBPTS2 Chebyshev tensor points
%   [XX YY] = CHEBPTS2(N) constructs an N by N grid of Chebyshev tensor points
%   on [-1 1]^2.
%
%   [XX YY] = CHEBPTS2(NX,NY) constructs an NX by NY grid of Chebyshev tensor
%   points on [-1 1]^2.
%
%   [XX YY] = CHEBPTS2(NX,NY,D) constructs an NX by NY grid of Chebyshev tensor
%   points on the rectangle [a b] x [c d], where D = [a b c d].
% 
%   The particular tensor grid that is returned is based on the currently
%   underlying technology. 
%
% See also CHEBPTS.

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

if ( nargin > 2 )  
   % Third argument should be a domain. 
   D = D(:).';  % make a row vector.   
   if ( ~all( size( D ) == [1 4] ) )
        error('CHEBFUN2:CHEBPTS2:DOMAIN', 'Unrecognised domain.');
   end
else  % Default to the canoncial domain.  
    D = [-1, 1, -1, 1];
end

if ( nargin == 1 ) 
    % Make it a square Chebyshev grid if only one input. 
    ny = nx; 
end

% What tech am I based on?: 
tech = chebfun2pref().tech();

if ( isa(tech, 'chebtech2') )
    x = chebpts( nx, D(1:2), 2 );   % x grid.
    y = chebpts( ny, D(3:4), 2 );   % y grid
    [xx, yy] = meshgrid(x, y);   % Tensor product. 
elseif ( isa(tech, 'chebtech1') ) 
    x = chebpts( nx, D(1:2), 1 );   % x grid.
    y = chebpts( ny, D(3:4), 1 );   % y grid
    [xx, yy] = meshgrid(x, y);   % Tensor product
elseif ( isa(tech, 'fourtech') ) 
    x = fourierpts( nx-1, D(1:2) );   % x grid.
    x = [x;D(2)]; 
    y = fourierpts( ny, D(3:4) );   % y grid
    y = [y;D(4)];
    [xx, yy] = meshgrid(x, y);   % Tensor product
else
    error('CHEBFUN2:PTS', 'Unrecognized technology');
end 
