%predicados http://www.swi-prolog.org/pldoc/man?predicate=op/3
:- op(6,fx,neg).
:- op(7,xfy,or).
:- op(7,xfy,and).
:- op(7,xfy,implies).
:- op(7,xfy,dimplies).
:- op(8,xfy,forall).
:- op(8,xfy,exist).

at(p).
at(q).


fnd(A,A):-predicado(A).
fnd(neg A, X):-fndneg(A,X).
fnd(neg A,neg X):-fnd(A,X).
fnd(A and B, neg(neg X or neg Y) ):-fnd(A,X),fnd(B,Y).
fnd(A or B, X or Y ):-fnd(A,X),fnd(B,Y).
fnd(A implies B, neg X or  Y ):-fnd(A,X),fnd(B,Y).
fnd(A dimplies B, Z ):- fnd(A,X), fnd(B,Y),
    fnd( (X implies Y) and (Y implies X), Z ).
fnd(X forall A, neg(X exist Y)):- fnd(neg A, Y).
fnd(X exist A, X exist Y):- fnd(A, Y).
fndneg(neg A,X):-fnd(A,X).


main(Formula):-
    fnd(Formula,FormulaFnd),
    gentzen([],[FormulaFnd],[]).


predicado([H|L]):-
    atomic(H),
    listaTerminos(L).

termino(X):-atomic(X).
termino([F|L]):-atomic(F),listaTerminos(L).

listaTerminos([]).
listaTerminos([T]):-termino(T).
listaTerminos([H|L]):-termino(H),listaTerminos(L).

gentzen(I,D,_):- not(intersection(I,D,[])).

gentzen(A,[neg B | T],LVar):- predicado(B),append(A,[B],R), gentzen(R,T,LVar),!.
gentzen(A,[neg B | T],LVar):- gentzen([B | A],T,LVar),!.

gentzen([neg A| T], B,LVar):- predicado(A),append(B,[A],R),gentzen(R,T,LVar),!.
gentzen([neg A | T],B,LVar) :- gentzen(T,[A | B],LVar),!.


gentzen(I,[A or B|T],LVar):- predicado(A),predicado(B),
    append([A],[B],AB),append(T,AB,R),gentzen(I,R,LVar),!.
gentzen(I,[A or B|T],LVar):- predicado(A),append([A],T,TA),
    gentzen(I,[B|TA],LVar),!.
gentzen(I,[A or B|T],LVar):- predicado(B),append([B],T,TB),
    gentzen(I,[A|TB],LVar),!.
gentzen(I,[A or B|T],LVar):- gentzen(I,[A,B|T],LVar),!.
%

gentzen([A or B|T],D,LVar):-predicado(A),predicado(B),
    gentzen([T|A],D,LVar),gentzen([T|B],D,LVar),!.
gentzen([A or B|T],D,LVar):-predicado(A),
    gentzen([T|A],D,LVar),
    gentzen([B|T],D,LVar),!.
gentzen([A or B|T],D,LVar):-predicado(B),
    gentzen([A|T],D,LVar),
    gentzen([T|B],D,LVar),!.
gentzen([A or B|T],D,LVar):-
    gentzen([A | T],D,LVar),
    gentzen([B| T],D,LVar),!.


gentzen([X exist F|TI],D,LVar):-
    obtenerVarIzq(LVar,LVarS,Var),
    expandirExist(X,Var,F,Fs),
    append(TI,[Fs],R),
    gentzen(R,D,LVarS),!.

gentzen(I,[X exist F|TD], LVar):-
    obtenerVarDer(LVar,LVarS,Var),%obtener salida de lista
    expandirExist(X,Var,F,Fs),
    append(TD,[Fs],R),
    gentzen(I,R,LVarS),!.%Fs|TD



obtenerVarDer([],[0],0).
obtenerVarDer([V|LVar],[V|LVar],V).
obtenerVarDer([_|LVar],L,VR):-
    obtenerVarDer( LVar,L,VR).

recorrerLVar([],0).
recorrerLVar([H|_],H).
recorrerLVar([_|T],V):-recorrerLVar(T,V).

obtenerVarIzq([],[0],0).
%obtenerVarIzq(LVar,LVarS,Var):-
%    contar(LVar,Var),
%    append(LVar,[Var],LVarS).

contar([],0).
contar([_|L],C):- !, contar(L,C1), C is C1+1.



expandirExist(X,Var,F,Fs):-
    predicado(F),
    sust(X,Var,F,Fs),!.
expandirExist(X,Var,A or B, As or Bs):-
    expandirExist(X,Var,A,As),
    expandirExist(X,Var,B,Bs).

expandirExist(X,Var,neg A, neg As  ):-
    expandirExist(X,Var,A,As).
expandirExist(X,Var,Y exist F, Y exist Fs  ):-
    expandirExist(X,Var,F,Fs).



sust(_,_,[],[]).
sust(V,C,[ [H|Tt]|Ti ],[ [H|Tts]|Ts ] ):-
    sust(V,C,Tt,Tts),
    sust(V,C,Ti,Ts).
sust(V,C,[V|Ti],[C|Ts]):-sust(V,C,Ti,Ts).
sust(V,C,[H|Ti],[H|Ts]):-sust(V,C,Ti,Ts).