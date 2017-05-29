at(p).
at(q).
at(r).

:- op(200, fy, neg).
:- op(400, xfy, and).
:- op(500, xfy, v).
:- op(600, xfy, if).
:- op(700, xfy, iff).


%printlist([]).

%printlist([X|L]) :- write(X),nl,
 %                   printlist(L).
trad(F,F):-at(F).
trad(neg F,neg F1):-trad(F,F1).
trad(F1 v F2,L1 v L2):- trad(F1,L1),
                        trad(F2,L2).


trad(F1 and F2, neg (neg L1 v neg L2)):- trad(F1,L1),
                                    trad(F2,L2).

trad(F1 if F2, neg (L1) v (L2)):-   trad(F1,L1),
                                    trad(F2,L2).

trad(F1 iff F2, neg(neg L1 v neg L2)):-   trad(F1 if F2,L1), trad(F2 if F1,L2).
                  %      trad(L1 and L2,L3).




%L1  = neg p v q
%L2  = neg q v q
