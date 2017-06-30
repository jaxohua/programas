%predicados http://www.swi-prolog.org/pldoc/man?predicate=op/3
%:- op(6,fx,neg).
%:- op(7,xfy,or).
%:- op(7,xfy,and).
%:- op(7,xfy,implies).
%:- op(7,xfy,dimp).
%:- op(8,xfy,forall).
%:- op(8,xfy,exist).


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
:-op(100,yfx,pu).
:-op(400,fx,pre).



trad(A,A):-predicado(A).
trad(neg A, neg X):-trad(A,X).
%trad(neg A, X):-tradneg(A,X).
trad(neg A,neg X):-trad(A,X).
trad(A and B, neg(neg X or neg Y) ):-trad(A,X),trad(B,Y).
trad(A or B, X or Y ):-trad(A,X),trad(B,Y).
trad(A imp B, neg X or  Y ):-trad(A,X),trad(B,Y).
trad(A dimp B, Z ):- trad(A,X), trad(B,Y),
    trad( (X imp Y) and (Y imp X), Z ).
trad(X forall A, neg(X exist Y)):- trad(neg A, Y),!.
trad(X exist A, X exist Y):- trad(A, Y).
%tradneg(neg A,X):-trad(A,X).


%getConst([H|T],R).

predicado([H|L]):-
    atomic(H),
    listaTerminos(L),!.

termino(X):-atomic(X).
termino([F|L]):-atomic(F),listaTerminos(L).

listaTerminos([]).
listaTerminos([T]):-termino(T).
listaTerminos([H|L]):-termino(H),listaTerminos(L),!.

sequent(I,D,_):- not(intersection(I,D,[])),escribeAxioma(I,D),!.

sequent(I,[neg X | TD],LVar):- predicado(X),append(I,[X],I2), sequent(I2,TD,LVar),escribeUnario(I,[neg X|TD]),!.
sequent(I,[neg B | TD],LVar):- sequent([B | I],TD,LVar),escribeUnario(I,[neg B|TD]),!.



%Reglas lado Derecho
sequent(I,[A or B|T],LVar):- predicado(A),predicado(B),
    append([A],[B],AB),append(T,AB,R),sequent(I,R,LVar),escribeUnario(I,[A or B|T]),!.
sequent(I,[A or B|T],LVar):- predicado(A),append([A],T,TA),
    sequent(I,[B|TA],LVar),escribeUnario(I,[A or B|T]),!.
sequent(I,[A or B|T],LVar):- predicado(B),append([B],T,TB),
    sequent(I,[A|TB],LVar),escribeUnario(I,[A or B|T]),!.
sequent(I,[A or B|T],LVar):- sequent(I,[A,B|T],LVar),escribeUnario(I,[A or B|T]),!.

%Reglas Lado Izquerdo
sequent([neg A| TI], D,LVar):- predicado(A),append(D,[A],D2),sequent(TI,D2,LVar),escribeUnario([neg A|TI],D),!.
sequent([neg A | TI],D,LVar) :- sequent(TI,[A | D],LVar),escribeUnario([neg A|TI],D),!.
sequent([A or B|TI],D,LVar):-predicado(A),predicado(B),
    sequent([TI|A],D,LVar),sequent([TI|B],D,LVar),escribeBinario([A or B|TI],D),!.
sequent([A or B|T],D,LVar):-predicado(A),
                            sequent([T|A],D,LVar),
                            sequent([B|T],D,LVar),escribeBinario([A or B|T],D),!.
sequent([A or B|T],D,LVar):-predicado(B),
                            sequent([A|T],D,LVar),
                            sequent([T|B],D,LVar),escribeBinario([A or B|T],D),!.
sequent([A or B|T],D,LVar):-sequent([A | T],D,LVar),
                            sequent([B| T],D,LVar),escribeBinario([A or B|T],D),!.


sequent([X exist F|TI],D,LVar):-
                                obtenerVarIzq(LVar,LVarS,Var),
                                quitaExist(X,Var,F,Fs),
                                append(TI,[Fs],R),
                                sequent(R,D,LVarS),
                                escribeUnario([X exist F|TI],D),!.

sequent(I,[X exist F|TD], LVar):-
    valDer(LVar,LVarS,Var),%obtener salida de lista
    quitaExist(X,Var,F,Fs),
    append(TD,[Fs],D2),
    sequent(I,D2,LVarS),
    escribeUnario(I,[X exist F|TD]),!.



valDer([],[c],c).
valDer([V|LVar],[V|LVar],V).
valDer([_|LVar],L,VR):-valDer( LVar,L,VR).

obtenerVarIzq([],[c],c).


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       GENERA pdflatex                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 encabezado:-   working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
                open('Arbol-PrimerOrden.tex',write,Buffer),
                write(Buffer,'\\documentclass[12pt,landscape]{article}'),  nl(Buffer),
                write(Buffer,'\\usepackage{bussproofs}'),nl(Buffer),
                write(Buffer,'\\usepackage{amssymb}'),nl(Buffer),
                write(Buffer,'\\usepackage{latexsym}'),nl(Buffer),
                write(Buffer,'\\def\\fCenter{{\\mbox{\\Large$\\rightarrow$}}}'),nl(Buffer),
                write(Buffer,'\\EnableBpAbbreviations'),nl(Buffer),
                write(Buffer,'\\begin{document}'),nl(Buffer),
                write(Buffer,'\\begin{prooftree}'),nl(Buffer),
                write(Buffer,'\\def\\fCenter{\\ \\vdash\\ }'),nl(Buffer),
                close(Buffer).

escribeAxioma(LI,LD):-  open('Arbol-PrimerOrden.tex',append,Buffer),
                        write(Buffer,'\\AxiomC{$'),
                        imprimirLista(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        imprimirLista(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).

escribeUnario(LI,LD):-  open('Arbol-PrimerOrden.tex',append,Buffer),
                        write(Buffer,'\\UnaryInfC{$'),
                        imprimirLista(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        imprimirLista(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).


escribeBinario(LI,LD):- open('Arbol-PrimerOrden.tex',append,Buffer),
                        write(Buffer,'\\BinaryInfC{$'),
                        imprimirLista(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        imprimirLista(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).



final:-         working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
                open('Arbol-PrimerOrden.tex',append,Buffer),
                write(Buffer,'\\end{prooftree}'),nl(Buffer),
                write(Buffer,'\\end{document}'),nl(Buffer),
                close(Buffer).



imprimirLista([],_).
imprimirLista([C|T],B):-T=[],paso([C],B).
imprimirLista([C|T],B):-
                paso([C],B),
                write(B,','),
                paso(T,B).

paso([],_).
paso([C|T],B):-  imprimirF([C],B),
                imprimirF(T,B).



imprimirF([],_).


imprimirF([F|_],Buffer):-  atomic(F),
                       write(Buffer,F).

imprimirF([neg B | _],Buffer):- write(Buffer,' \\neg '),
                          paso([B],Buffer).

imprimirF([X exist F|_],Buffer):-
                            write(Buffer,' \\exists '),
                            paso([X],Buffer),
                            paso([F],Buffer).

imprimirF([A or B|_],Buffer):-  write(Buffer,' ('),
                           paso([A],Buffer),
                            write(Buffer,' \\lor '),
                            paso([B],Buffer),
                            write(Buffer,') ').

imprimirF([F|_],Buffer):-
                       write(Buffer,F).

compilaOpen:-working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
            shell('/Library/Tex/texbin/pdflatex -synctex=1 -interaction=nonstopmode Arbol-PrimerOrden.tex',R),
            write(R),nl,
            shell('open Arbol-PrimerOrden.pdf',R2),
            write(R2),nl.


main(Formula):-
    trad(Formula,FormulaFnd),
    sequent([],[FormulaFnd],[]).

testA(F):- encabezado,trad(F,FormulaFnd), sequent([],[FormulaFnd],[]),final, compilaOpen.

% testA( neg(y exist([p,y]))  or (x exist ([p,x]))).
