at(p,p). % Our first atom.
at(q,q). % Our second atom.
:- op(610, fy, -).
:- op(630, xfy, v).
%fmla shows if it is a formula or not
fmla(X):- at(X,V). % an atom is a formula
fmla(-X) :- fmla(X). % neg(F) is a formula if F is a formula
fmla(X v Y) :- fmla(X), fmla(Y). % or(F,G) is a formula if F and G are formulas

sub(X,Y) :- fmla(X), fmla(Y).
sub(X,X) :-           % any formula X is a trivial subformula of itself
    fmla(X).
sub(-X,Y) :-      % the argument of neg is a subformula
    sub(X,Y).
sub(X v _Y,Z) :-    % the 1st arg. of or is a subformula
    sub(X,Z).
sub(_X v Y,Z) :-    % the 2nd arg. of or is a subformula
    sub(Y,Z).


