at(p).
at(q).
at(r).
:- op(100, fy, neg).
:- op(130, xfy, v).

printlist([]).
printlist([X|L]) :- write(X),nl,
                    printlist(L).

subf(X,[X]):-at(X).

subf(neg F,[neg F | T]):-subf(F,T).


subf(F1 v F2,[F1 v F2 | T]):-   subf(F1,T1),
                                subf(F2,T2),
                                union(T1,T2,T).
