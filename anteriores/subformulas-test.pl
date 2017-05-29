at(p).
at(q).
at(r).
:- op(610, fy, -).
:- op(630, xfy, v).
formula(X):- at(X).
formula(-(X)) :- formula(X).
formula(v(X,Y)) :- formula(X),formula(Y).

subformula(X,X) :- formula(X).
subformula(X,Y) :- formula(X),formula(Y).
subformula(-(X),Y) :- subformula(X,Y).


%subformula(p v q, p).
