open:-working_directory(_,'/Users/4x/Google-Drive/DICC/2-Semestre/Cursos/MetodosFormales/programas'),
      open('programa.txt', read, Source),
      read_file(Source,L), !,
      %write(L).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream,Codes),
    atom_chars(X, Codes),
    write(X),
    read_file(Stream,L),
    !.
