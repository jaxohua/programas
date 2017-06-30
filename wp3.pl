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
wp(F,assume C,[C imp F]).
%wp(F,[assume C|T],[C imp F|T]).
wp(F,A := B,[L]):-sust(A,B,F,L).
%wp(F,[assume C|_],[C imp F]).
%wp(F,[A := B|_],L):-write(A),sustitucion(A,B,F,L).


%Invierte lista
invierteL([],[]).
invierteL([H|T],L):-invierteL(T,R),append(R,[H],L).


sust(A,B,A,B).
%sust(A,_,C,C):-A\=C, atomic(A),atomic(C).
sust(A,_,C,C):-A\=C, atomic(A),atomic(C).
sust(A,B,X > Y,X1 > Y1 ):-sust(A,B,X,X1),sust(A,B,Y,Y1).
sust(A,B,X >= Y,X1 >= Y1 ):-sust(A,B,X,X1),sust(A,B,Y,Y1).
sust(A,B,X < Y,X1 < Y1 ):-sust(A,B,X,X1),sust(A,B,Y,Y1).
sust(A,B,X <= Y,X1 <= Y1 ):-sust(A,B,X,X1),sust(A,B,Y,Y1).
sust(A,B,X + Y,X1 + Y1 ):-sust(A,B,X,X1),sust(A,B,Y,Y1).
sust(A,B,X - Y,X1 - Y1 ):-sust(A,B,X,X1),sust(A,B,Y,Y1).
sust(A,B,X imp Y,X1 imp Y1 ):-sust(A,B,X,X1),sust(A,B,Y,Y1).
sust(A,B,X dimp Y,X1 dimp Y1 ):-sust(A,B,X,X1),sust(A,B,Y,Y1).
sust(A,B,X "["Y"]",X1"["Y1"]"):-sust(A,B,X,X1),sust(A,B,Y,Y1).
%Sustituye c por x
