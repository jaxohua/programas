%Operadores
:-op(7,fy,neg).
:-op(8,xfx,or).
:-op(9,xfy,and).
:-op(10,xfy,imp).
:-op(10,xfy,dimp).

:-op(7,xfx,>=).
:-op(9,xfx,:=).
:-op(5,yfx,+).
:-op(8,fy,assume).

genera([F|T],VC):-invierteL(T,T2),vc(T2,Wp),VC=[F imp Wp].

vc([F|S],Wp):-[H|T]=S,T==[],wp(F,H,Wp).
vc([F|S],Wp):-[H|T]=S,wp(F,H,Wp1),vc(T,Wp1),Wp=Wp1.

wp(F,assume C,C imp F).
%wp(F,A := B,L):-write(A),nl,write(B),sustitucion(A,B,[F],L).
wp(F,A := B,L):-write(A),nl,write(B),atom_replaced(A,B,[F],L).

%Invierte lisra
invierteL([],[]).
invierteL([H|T],L):-invierteL(T,R),append(R,[H],L).

%Sustituye X por C
sustitucion(X,C,[A >= B|T],LX):-A==X,sustitucion(A,).
sustitucion(_,_,[],[]).
sustitucion(X,C,[X|T1],[C|T2]):-sustitucion(X,C,T1,T2).
sustitucion(X,C,[H|T1],[H|T2]):-sustitucion(X,C,T1,T2).
sustitucion(X,C,[[Hi|Ti]|T1],[[Hi|Li]|T2]):-sustitucion(X,C,Ti,Li),sustitucion(X,C,T1,T2).

%sustitucion(X,C,[A >= B|T],LX):-A==X,LX is [C:=B|T].
atom_replaced(A, R) :-
   atom_chars(A, Chs),
   chars_replaced(Chs, Rs),
   atom_chars(R, Rs).

%?- atom_replaced('Spaces  !',R).
