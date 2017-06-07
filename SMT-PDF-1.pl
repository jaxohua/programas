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

sequent(F1,F2):-          not(intersection(F1,F2,[])),escribeAxioma(F1,F2),
                            write(F1), write(' -> '), write(F2),nl.

%reglas Derecha
sequent(F1,[neg X|T]):-     elimina([X|T],D), agrega(X,F1,I), sequent(I,D),escribeUnario(F1,[neg X|T]),
                            write(F1), write('--> '), write([neg X|T]),nl.%append(I,D,R),escribeUnario(R).

sequent(F1,[ F2 v F3|T]):-  cambiaOr([F2],[F3],C),append(C,T,F4),
                            sequent(F1,F4),
                            escribeUnario(F1,[ F2 v F3|T]),
                            %escribeUnario(F1,F4),
                            write(F1),write('-->'),write([ F2 v F3|T]),nl.
%reglas Izquierda
%revisar perdida de tallo
sequent([neg X|T],F2):-      elimina([X|T],I), agrega(X,F2,D), sequent(I,D),escribeUnario([neg X|T],F2),
                             write([neg X|T]),write('-->'),write(F2).

sequent([ F1 v F2|T],FD):-   agrega(F1,T,F4), sequent(F4,FD),
                             agrega(F2,T,F5), sequent(F5,FD),
                             write([ F1 v F2|T]),write('-->'),write(FD),nl,
                             escribeBinario([ F1 v F2|T],FD).


sequent(F1,[X|T]):-          at(X),mueve([X|T],LM),sequent(F1,LM).
%sequent([X|_],F2):-          at(X), mueve([X|T],LM),sequent(LM,F2).


cambiaOr(F2,F3,C):-            append(F2,F3,C).
agrega(X,F1,[X|F1]).
elimina([_|T],[T]).
mueve([X|T],L):-             not(atomica([X|T])),append(T,X,L).



%Genera archivo PDF
 encabezado:-   working_directory(CWD,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
                open('Tree.tex',write,Buffer),
                write(Buffer,'\\documentclass[12pt]{article}'),  nl(Buffer),
                write(Buffer,'\\usepackage{bussproofs}'),nl(Buffer),
                write(Buffer,'\\usepackage{amssymb}'),nl(Buffer),
                write(Buffer,'\\usepackage{latexsym}'),nl(Buffer),
                write(Buffer,'\\def\\fCenter{{\\mbox{\\Large$\\rightarrow$}}}'),nl(Buffer),
                write(Buffer,'\\EnableBpAbbreviations'),nl(Buffer),
                write(Buffer,'\\begin{document}'),nl(Buffer),
                write(Buffer,'\\begin{prooftree}'),nl(Buffer),
                write(Buffer,'\\def\\fCenter{\\ \\vdash\\ }'),nl(Buffer),
                close(Buffer).

escribeAxioma(LI,LD):-  open('Tree.tex',append,Buffer),
                        write(Buffer,'\\AxiomC{$'),
                        cambiaOper(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        cambiaOper(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).

escribeUnario(LI,LD):-  open('Tree.tex',append,Buffer),
                        write(Buffer,'\\UnaryInfC{$'),
                        cambiaOper(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        cambiaOper(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).


escribeBinario(LI,LD):- open('Tree.tex',append,Buffer),
                        write(Buffer,'\\BinaryInfC{$'),
                        cambiaOper(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        cambiaOper(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).



final:-         open('Tree.tex',append,Buffer),
                write(Buffer,'\\end{prooftree}'),nl(Buffer),
                write(Buffer,'\\end{document}'),nl(Buffer),
                close(Buffer),
                shell('pdflatex Tree.tex | open Tree.pdf',R),
                write(R),nl.


%cambiaOper([],Buffer):- write(Buffer,'[]').
cambiaOper([],Buffer).

%cambiaOper([F|T],Buffer):-not(vacia([F|T])),write(Buffer,',').


cambiaOper([F|T],Buffer):-  at(F),
                            write(Buffer,F),
                            cambiaOper([T],Buffer).

cambiaOper([neg X|T],Buffer):- write(Buffer,' \\neg '),
                        cambiaOper([X|T],Buffer).

cambiaOper([P v Q|T],Buffer):-  write(Buffer,' ('),
                                cambiaOper([P],Buffer),
                                write(Buffer,' \\lor '),
                                cambiaOper([Q],Buffer),
                                write(Buffer,') '),
                                cambiaOper(T,Buffer).


test(F):- encabezado,trad(F,FT), sequent([],[FT]),final.
vacia([]).
atomica([]).
atomica([X|T]):- at(X), atomica(T).
validaT(T,Buffer):-not(vacia(T)), write(Buffer,',').

%((neg p if q) and (neg p if neg q)) if p