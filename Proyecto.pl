%at(true).
%Operadores
:-op(200,fy,neg).
:-op(600,xfx,or).
:-op(400,xfy,and).
:-op(400,yfx,div).
:-op(400,fx,post).
:-op(800,xfy,imp).
:-op(1000,xfy,dimp).
%:-op(1000,xfy,sp)
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
%:-op(800,fx,exist).
:-op(800,xfy,exist).
:-op(800,xfy,forall).

%:-op(800,fx,forall).
:-op(100,yfx,pu).
:-op(400,fx,pre).


%:-consult('/Users/angelarmenta/Documents/DCC/2doSemestre/MF/Prolog/Lectura.pl').

inicio(Codigo):-mainpath(Codigo,Paths),imprimeP(Paths),verifyingC(Paths).

imprimeP([]).
imprimeP([H|T]):-write(H),nl,imprimeP(T).

verifyingC(Paths):-crea,verifyingConditions(Paths).


%Toma la primera lista de listas y la envia a generar WP
%verifyingConditions([]).
%verifyingConditions([H|T]):-genera(H),verifyingConditions(T).

genera([F|T],VC):-invierteL(T,T2),vc(T2,Wp),VC=(F imp Wp),escribe(VC).

vc([F|S],Wp):-[H|T]=S,T==[],wp(F,H,Wp).
vc([F|S],Wp):-[H1|T1]=S,wp(F,H1,Wp1),append(Wp1,T1,T2),vc(T2,Wp).

wp(F,assume C,(C imp F)).
wp(F,A := B,L):-sustitucion(A,B,F,L).

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

sustitucion(A,B,X exist F ,X exist X1):-sustitucion(A,B,F,X1).
sustitucion(A,B,X forall F,X forall X1):-sustitucion(A,B,F,X1).
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

%Cambia a Estructura que lee gentzen first order
cambia(X,X):-valid(X).
%cambia(true dimp Y,(p dimp Y1)):-cambia(Y,Y1),!.
%cambia(true imp Y,(p imp Y1)):-cambia(Y,Y1),!.
cambia(X > Y,[mayor,X,Y]).
cambia(X < Y,[menor,X,Y]).
cambia(X = Y,[igual,X,Y]).
cambia(X >= Y,([mayor,X,Y] or [igual,X,Y])).
cambia(X <= Y,([menor,X,Y] or [igual,X,Y])).
cambia(X and Y,(X1 and Y1)):-cambia(X,X1),cambia(Y,Y1).
cambia(X or Y,(X1 or Y1)):-cambia(X,X1),cambia(Y,Y1).
cambia(X imp Y,(X1 imp Y1)):-cambia(X,X1),cambia(Y,Y1).
cambia(X dimp Y,(X1 dimp Y1)):-cambia(X,X1),cambia(Y,Y1).

%cambia(X + Y,X1 + Y1):-cambia(X,X1),cambia(Y,Y1).
%cambia(X imp Y,(X1 imp Y1)):-cambia([X],X1),cambia([Y],Y1).


%funciones
%sustitucion(A,B,X ab Y sp Z sp W ce,X1 ab Y1 sp Z1 sp W1 ce):-sustitucion(A,B,Y,Y1),sustitucion(A,B,Z,Z1),sustitucion(A,B,W,W1).



crea:-working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
         open('Salida-Proyecto.java',write,Buffer),
         close(Buffer).

escribe(T):-working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),

               open('Salida-Proyecto.java',append,Buffer),
               write(Buffer,T),
               nl(Buffer),
               close(Buffer).


fnd(X forall F, (neg(X exist Y))):- fnd(neg F, Y),!.
fnd(X exist F, X exist Y):- fnd(F, Y),!.


fnd(F,F):-valid(F).

fnd(neg F,( neg (F1) ) ):-fnd(F,F1).

fnd(F1 or F2,L1 or L2):- fnd(F1,L1),
                         fnd(F2,L2).


fnd(F1 and F2, (neg (( neg (L1)) or ( neg (L2) ) ) )):- fnd(F1,L1),
                                    fnd(F2,L2).

fnd(F1 imp F2, (neg (L1)) or (L2)):-   fnd(F1,L1),
                                    fnd(F2,L2).

fnd(F1 dimp F2, (neg((neg (L1)) or ( neg (L2) ) )) ):-   fnd(F1 imp F2,L1), fnd(F2 imp F1,L2).




%Secuentes de Gentzen
sequent(Li,Ld):-not(intersection(Li,Ld,[])),escribeAxioma(Li,Ld),
                write(Li), write(' -> '), write(Ld),nl.%imprimeAxioma(Li,Ld).    % Caso base.

sequent(Li,[neg P|T]):- sequent([P|Li],T),
                        write(Li), write(' -> '), write([neg P|T]),nl,
                        escribeUnario(Li,[neg P|T]).       % Negacion lado derecho

sequent([neg P|T],Ld):- sequent(T,[P|Ld]),
                        write([neg P|T]),write('-->'),write(Ld),
                        escribeUnario([neg P|T],Ld).       % Negacion lado izquierdo

sequent(Li,[P or Q|T]):-sequent(Li,[P,Q|T]),
                       write(Li),write('-->'),write([ P or Q|T]),nl,
                       escribeUnario(Li,[P or Q|T]).    % Disyuncion lado derecho

sequent([P or Q|T],Ld):-sequent([P|T],Ld),sequent([Q|T],Ld),
                        write([ P or Q|T]),write('-->'),write(Ld),nl,
                        escribeBinario([P or Q|T],Ld).   % Disyuncion lado izquierdo

sequent(Li,Ld):-mueve(Ld,LM),
                write(Li),write('-->'),write(LM),nl,
                sequent(Li,LM).  % Rotar lista derecha

sequent(Li,Ld):-mueve(Li,LM),
                write(LM),write('-->'),write(Ld),nl,
                sequent(LM,Ld).  % Rotar lista izquierda
sequent([X exist F|TI],D,_):-
                                quitaExist(X,c,F,Fs),
                                append(TI,[Fs],R),
                                sequent(R,D,c),
                                escribeUnario([X exist F|TI],D),!.

sequent(I,[X exist F|TD], _):-
    quitaExist(X,c,F,Fs),
    append(TD,[Fs],D2),
    sequent(I,D2,c),
    escribeUnario(I,[X exist F|TD]),!.





quitaExist(X,Var,F,Fs):-predicado(F),
                        sustit(X,Var,F,Fs),!.

quitaExist(X,Var,A or B, As or Bs):-quitaExist(X,Var,A,As),
                                    quitaExist(X,Var,B,Bs),!.

quitaExist(X,Var,neg A, neg As  ):-
    quitaExist(X,Var,A,As),!.

quitaExist(X,Var,Y exist F, Y exist Fs  ):-
    quitaExist(X,Var,F,Fs),!.



sustit(_,_,[],[]).
sustit(V,C,[ [H|Tt]|Ti ],[ [H|Tts]|Ts ] ):-sustit(V,C,Tt,Tts),
                                           sustit(V,C,Ti,Ts).
sustit(V,C,[V|Ti],[C|Ts]):-sustit(V,C,Ti,Ts).
sustit(V,C,[H|Ti],[H|Ts]):-sustit(V,C,Ti,Ts).

mueve([H|T],L):-not(atomica([H|T])),at(H),append(H,T,L).

atomica([]).
atomica([X|T]):- at(X), atomica(T).
vacia([]).
validaT(T,Buffer):-not(vacia(T)), write(Buffer,',').









proyect(Basic):-crea,encabezado,
                genera(Basic,VC),escribe('=========== VC ==========='),escribe(VC),
                cambia(VC,Fgentzen),escribe('=========== VC->FormaGentzen ==========='),escribe(Fgentzen),
                escribe('===========FND============'),fnd(Fgentzen,FND),escribe(FND),
                sequent([],[FND]),
                final,compilaOpen.

testA(F):- encabezado,trad(F,FT), sequent([],[FT]),final, compilaOpen.

%[x>=0 imp [x+1>=1]]
%(x>0 or x=0 imp x+1>1 or x+1=1)
%mayor(x,0) or igual(x,0) imp mayor(x+1,1) or igual(x+1,1)

%-=====================================================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       GENERA pdflatex                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 encabezado:-   working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
                open('Proyecto.tex',write,Buffer),
                write(Buffer,'\\documentclass[8pt,landscape,center]{article}'),  nl(Buffer),
                write(Buffer,'\\usepackage[papersize={416mm,630mm},tmargin=15mm,bmargin=15mm,lmargin=15mm,rmargin=15mm]{geometry}'),
                write(Buffer,'\\usepackage{bussproofs}'),nl(Buffer),
                write(Buffer,'\\usepackage{amssymb}'),nl(Buffer),
                write(Buffer,'\\usepackage{latexsym}'),nl(Buffer),
                write(Buffer,'\\def\\fCenter{{\\mbox{\\Large$\\rightarrow$}}}'),nl(Buffer),
                write(Buffer,'\\EnableBpAbbreviations'),nl(Buffer),
                write(Buffer,'\\begin{document}'),nl(Buffer),
                write(Buffer,'\\begin{center}'),nl(Buffer),
                write(Buffer,'\\begin{prooftree}'),nl(Buffer),
                write(Buffer,'\\def\\fCenter{\\ \\vdash\\ }'),nl(Buffer),
                close(Buffer).

escribeAxioma(LI,LD):-  open('Proyecto.tex',append,Buffer),
                        write(Buffer,'\\AxiomC{$'),
                        imprimirLista(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        imprimirLista(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).

escribeUnario(LI,LD):-  open('Proyecto.tex',append,Buffer),
                        write(Buffer,'\\UnaryInfC{$'),
                        imprimirLista(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        imprimirLista(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).


escribeBinario(LI,LD):- open('Proyecto.tex',append,Buffer),
                        write(Buffer,'\\BinaryInfC{$'),
                        imprimirLista(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        imprimirLista(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).



final:-         working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
                open('Proyecto.tex',append,Buffer),
                write(Buffer,'\\end{prooftree}'),nl(Buffer),
                write(Buffer,'\\end{center}'),nl(Buffer),
                write(Buffer,'\\end{document}'),nl(Buffer),
                close(Buffer).



imprimirLista([],_).
imprimirLista([C|T],B):-T=[],paso(C,B).
imprimirLista([C|T],B):-
                %imprimirF([C],B),
                paso([C],B),
                %not(vacia(T)),
                write(B,','),
                paso(T,B).

paso([],_).
paso([C|T],B):-  imprimirF([C],B),
                imprimirF(T,B).



valid(F):-atomic(F).
valid([_|_]).

imprimirF([],_).

imprimirF([F|_],Buffer):-  atomic(F),
                       write(Buffer,F).
imprimirF([F|_],Buffer):-  valid(F),
                       write(Buffer,F).


imprimirF([neg F],Buffer):- write(Buffer,' \\neg '),
                           %imprimirLista([F],Buffer).
                          paso([F],Buffer).

imprimirF([P or Q],Buffer):-  write(Buffer,' ('),
                           paso([P],Buffer),
                           %imprimirLista([P],Buffer),
                            write(Buffer,' \\lor '),
                            paso([Q],Buffer),
                            %imprimirLista([Q],Buffer),
                            write(Buffer,') ').

compilaOpen:-working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
            shell('/Library/Tex/texbin/pdflatex -synctex=1 -interaction=nonstopmode Proyecto.tex',R),
            write(R),nl,
            shell('open Proyecto.pdf',R2),
            write(R2),nl.