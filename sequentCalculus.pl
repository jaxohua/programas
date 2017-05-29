at(p).
at(q).
at(r).
at(o).
at(u).

:- op(200, fy, neg).
:- op(400, xfy, and).
:- op(500, xfy, v).
:- op(600, xfy, if).
:- op(700, xfy, iff).
:- op(800, xfy, seq).
%:- op(900, xfy, ).


printlist([]).

printlist([X|L]) :- write(X),nl,
                    printlist(L).
trad(F,F):-at(F).
trad(neg F,neg F1):-trad(F,F1).
trad(F1 v F2,L1 v L2):-trad(F1,L1),
                trad(F2,L2).


trad(F1 and F2, neg (neg F1 v neg F2)):- trad(F1,L1),
                                    trad(F2,L2).

trad(F1 if F2, neg (L1) v (L2)):- trad(F1,L1),
                                  trad(F2,L2).

trad(F1 iff F2, neg(neg L1 v neg L2)):-  trad(F1 if F2,L1), trad(F2 if F1,L2).
                  %      trad(L1 and L2,L3).




%L1  = neg p v q
%L2  = neg q v q
%%%%%%%%%%  S  E  Q  U  E  N  T      C A L C U L U S %%%%%%%%%%%%%%
%sequent(F,F):-at(F).

sequent(F,[seq|L1]):-trad(F,L1),
                    sequent(L1,T1).
%sequent(F1 v F2,(F1 ',' F2) ).

sequent(seq F1 v F2,(seq F1 F2)).