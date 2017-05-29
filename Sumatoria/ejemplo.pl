sumatoria([], 0).

sumatoria([H|T], R):-
          sumatoria(T, R0),
          R is R0 + H.