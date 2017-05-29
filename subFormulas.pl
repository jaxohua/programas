at(p,p).
at(q,q).
at(r,r).
:- op(610, fy, neg).
:- op(630, xfy, or).

nega(neg,X,neg X):-!.
subformula(X):- at(X,L).
subformula(neg X,L4):-  at(X,L1),
                        nega(neg,L1,L2),
                        append([L1],[L2],L4).

subformula(neg X,L):-   subformula(neg X,L).

subformula(X,L):- at(X,L).

%subformula(X or Y, L):-subformula(X,L1),subformula(Y,L2),
 %                       append([L1],[L2],L).


subformula(Formula,Ls):-functor(Formula,Oper,2), arg(1,Formula,A), arg(2,Formula,B),
                        subformula(A,L1),
                        subformula(B,L2),
                        append([L1],[L2],Ls).


%subformula(p v q).
%formula(X):-at(X).
%formula(-X) :- formula(X).

%formula(v(X,Y)) :- formula(X),formula(Y).

%subformula(X,X) :- formula(X).
%subformula(X,Y) :- formula(X),formula(Y).
%subformula(-X,Y) :- subformula(X).
%subformula(v(X,_Y),Z) :- subformula(X,Z).
%subformula(v(_X,Y),Z) :- subformula(Y,Z).
