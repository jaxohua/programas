at(p).
at(q).
at(r).

:- op(200, fy, neg).
:- op(400, xfy, and).
:- op(600, xfy, v).
:- op(800, xfy, if).
:- op(1000, xfy, iff).
:- op(1100, xfy, imp).


%%%%%    V A R I O S
imprimeL([]).

imprimeL([X|L]) :- write(X),nl,
                    imprimeL(L).

% Saber si un elemento es miembro de una lista
miembro(X,[X|Ys]).
miembro(X,[Y|Ys]):-miembro(X,Ys).

comunes([],Xs,[]).
comunes([X|Xs],Ys,[X|Zs]):- miembro(X,Ys),% comprueba si X es miembro de Ys
                            comunes(Xs,Ys,Zs).

% comprueba que X no es miembro de Ys
comunes([X|Xs],Ys,Zs):- not(miembro(X,Ys)),comunes(Xs,Ys,Zs).

%obtener tamaño de una lista
tamano([],0).
tamano([_|A],N):- tamano(A,B), N is B+1.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    S U B F O R M U L A S (Regresa una lista con las subcadenas.)

subf(X,[X]):-at(X).

subf(neg F,[neg F | T]):-subf(F,T).


subf(F1 v F2,[F1 v F2 | T]):-   subf(F1,T1),
                                subf(F2,T2),
                                union(T1,T2,T).

subf(F1 and F2,[F1 and F2 | T]):-   subf(F1,T1),
                                    subf(F2,T2),
                                    union(T1,T2,T).

subf(F1 if F2,[F1 if F2 | T]):-   subf(F1,T1),
                                    subf(F2,T2),
                                    union(T1,T2,T).

subf(F1 iff F2,[F1 iff F2 | T]):-   subf(F1,T1),
                                    subf(F2,T2),
                                    union(T1,T2,T).
subf(F1,F2,V):-subf(F1,L1),subf(F2,L2),
                esMiembro(L1,L2).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        M O D E L    C H E C K I N G
valorv(0).
valorv(1).
valor_de_verdad(v,0,0,0).
valor_de_verdad(v,1,0,1).
valor_de_verdad(v,0,1,1).
valor_de_verdad(v,1,1,1).

valor_de_verdad(and,0,0,0).
valor_de_verdad(and,1,0,0).
valor_de_verdad(and,0,1,0).
valor_de_verdad(and,1,1,1).

valor_de_verdad(neg,1,0).
valor_de_verdad(neg,0,1).

valorf(F, Mod, V) :-memberchk((F,V), Mod).
valorf(neg A, Mod, V) :- valorf(A, Mod, VA), funcionv(neg, VA, V).
valorf(F, Mod, V) :-  functor(F,Oper,2), arg(1,F,A), arg(2,F,B),
                      valorf(A, Mod, VA),
                      valorf(B, Mod, VB),
                      valor_de_verdad(Oper, VA, VB, V).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% T R A D U C C I O N
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

%%%%%%%%%%%%%%%%%%%%%   S E Q U E N T    C A L C U L U S

%sequent(F):-              trad(F,FT),write('---Traduccion de la Formula---'), nl,write(FT), nl, sequent([],[FT]).
sequent(F):-              sequent([],[F]),!.
sequent(F1,F2):-          not(intersection(F1,F2,[])), write(F1),write(' -> '), write(F2),nl. %sequent([F1|_],[F2|_]).
%sequent(F1,F2):-          write(F1), write(' -> '), write(F2),nl. %sequent([F1,F2).

sequent(F1,[X|_],L):-     at(X), mueve([X|T],LM),sequent(F1,LM).


%reglas Derecha
sequent(F1,[neg X|T]):-       elimina([X|T],D), agrega(X,F1,I), sequent(I,D).
sequent(F1,[ F2 v F3|T]):-    cambia([F2],[F3],C),append(C,T,F4),
                              sequent(F1,F4).
%reglas Izquierda
%revisar perdida de tallo
sequent([neg X|T],F2):-       elimina([X|T],I), agrega(X,F2,D), sequent(I,D).

sequent([ F1 v F2|T],FD):-    agrega(F1,T,F4), sequent(F4,FD),
                              agrega(F2,T,F5), sequent(F5,FD).

cambia(F2,F3,C):-             append(F2,F3,C).
agrega(X,F1,[X|F1]).
elimina([_|T],T).
mueve([X|T],L):-              append(T,X,L).



%F2  = [neg neg (neg (neg neg p v q)v neg (neg neg p v neg q))]
%F3  = [p]
%L = [_12800]
