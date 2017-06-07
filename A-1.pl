at(p).
at(q).
at(r).

:- op(200, fy, neg).
:- op(400, xfy, and).
:- op(600, xfy, v).
:- op(800, xfy, if).
:- op(1000, xfy, iff).
:- op(1100, xfy, imp).

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


%Secuentes de Gentzen
sequent(Li,Ld):-not(intersection(Li,Ld,[])),escribeAxioma(Li,Ld),
write(Li), write(' -> '), write(Ld),nl.%imprimeAxioma(Li,Ld).    % Caso base.

sequent(Li,[neg P|T]):-sequent([P|Li],T),
                        write(Li), write(' -> '), write([neg P|T]),nl,escribeUnario(Li,[neg P|T]).       % Negacion lado derecho

sequent([neg P|T],Ld):-sequent(T,[P|Ld]),write([neg P|T]),write('-->'),write(Ld),escribeUnario([neg P|T],Ld).       % Negacion lado izquierdo

sequent(Li,[P v Q|T]):-sequent(Li,[P,Q|T]),write(Li),write('-->'),write([ P v Q|T]),nl,escribeUnario(Li,[P v Q|T]).    % Disyuncion lado derecho

sequent([P v Q|T],Ld):-sequent([P|T],Ld),sequent([Q|T],Ld),write([ P v Q|T]),write('-->'),write(Ld),nl,escribeBinario([P v Q|T],Ld).   % Disyuncion lado izquierdo

sequent(Li,Ld):-circularQueue(Ld,Ldr),write(Li),write('  |-  '),write(Ldr),nl,sequent(Li,Ldr).  % Rotar lista derecha

sequent(Li,Ld):-circularQueue(Li,Lir),write(Lir),write('  |-  '),write(Ld),nl,sequent(Lir,Ld).  % Rotar lista izquierda

circularQueue([H|T],L):-not(atomica([H|T])),at(H),append(H,T,L).


%cambiaLista(String,[]):-write(String,'').
%cambiaLista(String,[H|_]):-at(H),write(String,H).
%cambiaLista(String,[neg P|T]):-write(String,'\\neg'),cambiaLista(String,P),write(String,' , '),cambiaLista(String,T).
%cambiaLista(P,String),cambiaLista(T,String).
%cambiaLista(String,[P v Q|T]):-cambiaLista(String,P),write(String,' \\vee '),cambiaLista(String,Q),write(String,' , '),cambiaLista(String,T).

atomica([]).
atomica([X|T]):- at(X), atomica(T).
vacia([]).
validaT(T,Buffer):-not(vacia(T)), write(Buffer,',').


%Genera archivo PDF
 encabezado:-   working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
                open('Tree.tex',write,Buffer),
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

escribeAxioma(LI,LD):-  open('Tree.tex',append,Buffer),
                        write(Buffer,'\\AxiomC{$'),
                        imprimirLista(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        imprimirLista(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).

escribeUnario(LI,LD):-  open('Tree.tex',append,Buffer),
                        write(Buffer,'\\UnaryInfC{$'),
                        imprimirLista(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        imprimirLista(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).


escribeBinario(LI,LD):- open('Tree.tex',append,Buffer),
                        write(Buffer,'\\BinaryInfC{$'),
                        imprimirLista(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        imprimirLista(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).



final:-         working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
                open('Tree.tex',append,Buffer),
                write(Buffer,'\\end{prooftree}'),nl(Buffer),
                write(Buffer,'\\end{document}'),nl(Buffer),
                close(Buffer).
                %shell('pdflatex Tree.tex',R),
                %shell('open Tree.pdf',R),
                %write(R),nl.


imprimirLista([],_).
imprimirLista([C|T],B):-T=[],paso([C],B).
imprimirLista([C|T],B):-
                %imprimirF([C],B),
                paso([C],B),
                %not(vacia(T)),
                write(B,','),
                paso(T,B).

paso([],_).
paso([C|T],B):-  imprimirF([C],B),
                imprimirF(T,B).



imprimirF([],_).


imprimirF([F|_],Buffer):-  at(F),
                       write(Buffer,F).


imprimirF([neg F],Buffer):- write(Buffer,' \\neg '),
                           %imprimirLista([F],Buffer).
                          paso([F],Buffer).

imprimirF([P v Q],Buffer):-  write(Buffer,' ('),
                           paso([P],Buffer),
                           %imprimirLista([P],Buffer),
                            write(Buffer,' \\lor '),
                            paso([Q],Buffer),
                            %imprimirLista([Q],Buffer),
                            write(Buffer,') ').

compilaOpen:-working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
            %shell('sudo -u 4x pdflatex Tree.tex -synctex=1 -interaction=nonstopmode',R),
            shell('/Library/Tex/texbin/pdflatex -synctex=1 -interaction=nonstopmode Tree.tex',R),

            write(R),nl,

            shell('open Tree.pdf',R2),
            %shell('./Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas/arbol',R),
            %-synctex=1 -interaction=nonstopmode
            write(R2),nl.
            %shell('open Tree.pdf',R),
            %write(R),nl.
testA(F):- encabezado,trad(F,FT), sequent([],[FT]),final, compilaOpen.

% trace,escribeUnario([],[neg p, p]).
