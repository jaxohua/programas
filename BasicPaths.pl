
cargar :- working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
        open('archivo.txt',read,Buffer),
        leerArchivo(Buffer,Lines),
        close(Buffer),
        write(Lines), nl.

leerArchivo(Buffer,[]) :-
                         at_end_of_stream(Buffer).
leerArchivo(Buffer,[X|L]) :-
                            \+ at_end_of_stream(Buffer),
                            read(Buffer,X),
                            leerArchivo(Buffer,L).

:- use_module(library(pio)).

lines([])           --> call(eos), !.
lines([Line|Lines]) --> line(Line), lines(Lines).

eos([], []).

line([])     --> ( "\n" ; call(eos) ), !.
line([L|Ls]) --> [L], line(Ls).


read_first_line(File, Answer) :-
    see(File),
    read_one_line(Codes),
    seen,
    Answer = Codes.

read_one_line(Codes) :-
    get0(Code),
    (   Code < 0 /* end of file */ ->
        Codes = []
    ;   Code =:= 10 /* end of line */ ->
        Codes = []
    ;   Codes = [Code|Codes1],
        read_one_line(Codes1)
    ).