:- op(10, fy, neg).
:- op(20, xfy, v).
valorv(0).
valorv(1).
funcionv(v,0,0,0):-!.
funcionv(v,_,_,1):-!.
funcionv(neg,1,0).
funcionv(neg,0,1).
valorf(F, Mod, V) :-memberchk((F,V), Mod).
valorf(neg A, Mod, V) :- valorf(A, Mod, VA), funcionv(neg, VA, V).
valorf(F, Mod, V) :-  functor(F,Oper,2), arg(1,F,A), arg(2,F,B),
                    valorf(A, Mod, VA),
                    valorf(B, Mod, VB),
                    funcionv(Oper, VA, VB, V).



%main:- valorf(-p,[(p,1)],V) writef('%t\n', [V]).
%main:- valorf((p v q) v (-q v r),[(p,1),(q,0),(r,1)],V) writef('%t \n',[V]).
