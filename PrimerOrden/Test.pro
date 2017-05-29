at(P).

:- op(200, fy, neg).
:- op(210, xfy, ptodo).
:- op(220, xfy, existe).
:- op(400, xfy, and).
:- op(600, xfy, v).
:- op(800, xfy, if).
:- op(1000, xfy, iff).
:- op(1100, xfy, imp).






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% T R A D U C C I O N
trad(F,F):-at(F).
%trad(neg F,neg F1):-trad(F,F1).
trad(x ptodo P, neg (x existe R)):-trad(P,R).

