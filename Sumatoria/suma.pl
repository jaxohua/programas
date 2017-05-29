sumatoria([], 0).

sumatoria([H|T], R):-
          sumatoria(T, R0),
          R is R0 + H.



main:- sumatoria([1,2,3,4,5,3,7], R), writef('La sumatoria es: %t\n', [R]).