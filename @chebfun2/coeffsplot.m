function varargout = coeffsplot( f, varargin )
%COEFFSPLOT   Display the COEFFSPLOT of the column and row slices.
%   COEFFSPLOT(F) plots the Chebyshev coefficients of the one-dimensional
%   slices that form F on a semilogy scale. It returns two figures one for the
%   row slices and one for the column slices. By default only the first six row
%   and column slices are plotted.
%
%   COEFFSPLOT(F, S) allows further plotting options, such as linestyle,
%   linecolor, etc. If S contains a string 'LOGLOG', the coefficients will be
%   displayed on a log-log scale.
%
% See also COEFFSPLOT2, COEFFS2.

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.maths.ox.ac.uk/chebfun/ for Chebfun information.

% Empty check.
if ( isempty( f ) )
    varargout = { [] }; 
    return
end

% Get the low rank representation for f. 
cols = f.cols; 
rows = f.rows; 

% There are two figures. One plots the COEFFSPLOT of the column slices and
% the other the COEFFSPLOT of the row slices.

figure % First figure plots column slices.
h1 = coeffsplot( cols, varargin{:} ); % COEFFSPLOT of column slices.
title('Coeffsplot of column slices', 'FontSize', 16)

figure % Second figure plots row slices.
h2 = coeffsplot( rows, varargin{:} ); % COEFFSPLOT of row slices.
title('Coeffsplot of row slices', 'FontSize', 16)
 
% Return plot handles when appropriate.
if ( nargout == 1 )
    varargout = { h1 };
elseif ( nargout == 2 )
    varargout = { h1, h2 };
end

end
