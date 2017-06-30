%at(true).
%Operadores
:-op(200,fy,neg).
:-op(600,xfx,or).
:-op(400,xfy,and).
:-op(400,yfx,div).
:-op(400,fx,post).
:-op(800,xfy,imp).
:-op(1000,xfy,dimp).
:-op(1000,xfy,sp)
:-op(700,xfx,>).
:-op(700,xfx,>=).
:-op(700,xfx,<).
:-op(700,xfx,<=).
:-op(700,xfx,<>).

:-op(700,xfx,=).
:-op(990,xfx,:=).
:-op(500,yfx,+).
:-op(500,yfx,-).
:-op(700,yfx,=).

:-op(800,fy,assume).
:-op(500,xfy,ab).
:-op(500,xf,ce).
:-op(800,fx,exist).
:-op(800,fx,forall).
:-op(100,yfx,pu).
:-op(400,fx,pre).


%:-consult('/Users/angelarmenta/Documents/DCC/2doSemestre/MF/Prolog/Lectura.pl').

inicio(Codigo):-mainpath(Codigo,Paths),imprimeP(Paths),verifyingC(Paths).

imprimeP([]).
imprimeP([H|T]):-write(H),nl,imprimeP(T).

verifyingC(Paths):-crea,verifyingConditions(Paths).

verifyingConditions([]).
verifyingConditions([H|T]):-genera(H),verifyingConditions(T).

genera([F|T]):-invierteL(T,T2),vc(T2,Wp),VC=[F imp Wp],escribe(VC).

vc([F|S],Wp):-[H|T]=S,T==[],wp(F,H,Wp).
vc([F|S],Wp):-[H1|T1]=S,wp(F,H1,Wp1),append(Wp1,T1,T2),vc(T2,Wp).

wp(F,assume C,[C imp F]).
wp(F,A := B,[L]):-sustitucion(A,B,F,L).


%Invierte lista
invierteL([],[]).
invierteL([H|T],L):-invierteL(T,R),append(R,[H],L).

%Sustituye c por x
sustitucion(A,B,A,B).
sustitucion(J,C,[A|J],[A|C]).
%%%sustitucion(A,B,C,R1):-A\=C,not(atomic(C)),sustitucion(A,B,C,R1).
sustitucion(A,_,C,C):-A\=C,atomic(C).
%sustitucion(A,_,C,C):-A\=C.

% sustitucion(A,B,[X|Y],
% [X1|Y1]):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).

sustitucion(A,B,exist X,exist X1):-sustitucion(A,B,X,X1).
sustitucion(A,B,forall X,forall X1):-sustitucion(A,B,X,X1).
sustitucion(A,B,post X, X1):-sustitucion(A,B,X,X1).
sustitucion(A,B,X ab Y ce,X1 ab Y1 ce):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).



sustitucion(A,B,X ab Y ce = Z,X1 ab Y1 ce=Z1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1),sustitucion(A,B,Z,Z1).
sustitucion(A,B,X pu Y,X1 pu Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).

sustitucion(A,B,X imp Y,X1 imp Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).
sustitucion(A,B,X dimp Y,X1 dimp Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1),!.
sustitucion(A,B,X and Y,X1 and Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).
sustitucion(A,B,X div Y,X1 div Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).

sustitucion(A,B,X > Y,X1 > Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).
sustitucion(A,B,X >= Y,X1 >= Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).
sustitucion(A,B,X < Y,X1 < Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).
sustitucion(A,B,X <= Y,X1 <= Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).
sustitucion(A,B,X + Y,X1 + Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).
sustitucion(A,B,X - Y,X1 - Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).
sustitucion(A,B,X <> Y,X1 <> Y1):-sustitucion(A,B,X,X1),sustitucion(A,B,Y,Y1).

%funciones
sustitucion(A,B,X ab Y sp Z sp W ce,X1 ab Y1 sp Z1 sp W1 ce):-sustitucion(A,B,Y,Y1),sustitucion(A,B,Z,Z1),sustitucion(A,B,W,W1).



crea:-working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
         open('WP.txt',write,Buffer),
         close(Buffer).

escribe(T):-working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),

               open('WP.txt',append,Buffer),
               write(Buffer,T),
               nl(Buffer),
               close(Buffer).
