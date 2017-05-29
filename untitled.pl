at(p).
at(q).
at(r).

:- op(200, fy, neg).
:- op(400, xfy, and).
:- op(600, xfy, v).
:- op(800, xfy, if).
:- op(1000, xfy, iff).
:- op(1100, xfy, imp).

crea(F):-working_directory(CWD,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
        open('simbolos.txt',write,Buffer),
        write(Buffer,'Archivo con cadena inicial: '),
        write(Buffer,F),nl(Buffer),
        close(Buffer).
sequent(F1,F2):-          not(intersection(F1,F2,[])),crea(F1),escribeAxioma(F1,F2).

escribeAxioma(LI,LD):-  open('simbolos.txt',append,Buffer),
                        write(Buffer,'\\AxiomC{$'),
                        cambiaOper(LI,Buffer),
                        write(Buffer,' \\fCenter '),
                        cambiaOper(LD,Buffer),
                        write(Buffer,'$}'),nl(Buffer),
                        write(Buffer,'\\solidLine'),nl(Buffer),
                        close(Buffer).


cambiaOper([]).


cambiaOper([F],Buffer):-at(F),
                write(Buffer,F).

cambiaOper([neg X],Buffer):- write(Buffer,' \\neg '),
                        cambiaOper([X]).

cambiaOper([P v Q],Buffer):-   cambiaOper([P]),
                        write(Buffer,' \\lor '),
                        cambiaOper([Q]).


prueba(F):-     crea(F),cambiaOper([F]).