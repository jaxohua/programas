%Operadores
:-op(7,fy,neg).
:-op(8,xfx,or).
:-op(9,xfy,and).
:-op(10,xfy,imp).
:-op(10,xfy,dimp).

:-op(7,xfx,>).
:-op(7,xfx,>=).
:-op(7,xfx,<).
:-op(7,xfx,<=).
:-op(9,xfx,:=).
:-op(5,yfx,+).
:-op(8,fy,assume).

genera([F|T],VC):-invierteL(T,T2),vc(T2,Wp),VC=[F imp Wp].

vc([F|S],Wp):-[H|T]=S,T==[],wp(F,H,Wp).
vc([F|S],Wp):-[H1|T1]=S,wp(F,H1,Wp1),append(Wp1,T1,T2),vc(T2,Wp).
%vc([F|S],Wp):-[H1|T1]=S,wp(F,H1,Wp1),[H2|T2]=T1,append(Wp1,[H2],F1),vc(F1,Wp2),append(T2,Wp2,Wp).
wp(F,[S|R],R2):-wp(F,S,Result),wp(Result,R,R2).
wp(F,assume C,[C imp F]).
%wp(F,[assume C|T],[C imp F|T]).
wp(F,A := B,L):-sustitucion(A,B,[F],L).
%wp(F,[assume C|_],[C imp F]).
%wp(F,[A := B|_],L):-write(A),sustitucion(A,B,F,L).


%Invierte lista
invierteL([],[]).
invierteL([H|T],L):-invierteL(T,R),append(R,[H],L).

%Sustituye c por x
sustitucion(_,_,[],[]).
sustitucion(X,C,X,[C]).

%Mayor
sustitucion(X,C,X < X1,[C < X1]).
sustitucion(X,C,[A < B],[R1 < R2]):- sustitucion(X,C,A,R1),sustitucion(X,C,B,R2).
%Mayor o igual
sustitucion(X,C,X >= X1,[C >= X1]).
sustitucion(X,C,[A >= B],[R1 >= R2]):- sustitucion(X,C,A,R1),sustitucion(X,C,B,R2).

%Menor
sustitucion(X,C,X < X1,[C < X1]).
sustitucion(X,C,[A < B],[R1 < R2]):- sustitucion(X,C,A,R1),sustitucion(X,C,B,R2).
%Menor o igual
sustitucion(X,C,X <= X1,[C <= X1]).
sustitucion(X,C,[A <= B],[R1 <= R2]):- sustitucion(X,C,A,R1),sustitucion(X,C,B,R2).

%Suma
sustitucion(X,C,X + X1,[C + X1]).
sustitucion(X,C,[A + B],[R1 + R2]):- sustitucion(X,C,A,R1),sustitucion(X,C,B,R2).




%Implica
sustitucion(X,C,[A imp B],[R1 imp R2]):-sustitucion(X,C,A,R1),sustitucion(X,C,B,R2).
sustitucion(X,C,[H|T1],[H|T2]):-sustitucion(X,C,T1,T2).
sustitucion(X,C,[[Hi|Ti]|T1],[[Hi|Li]|T2]):-sustitucion(X,C,Ti,Li),sustitucion(X,C,T1,T2).






