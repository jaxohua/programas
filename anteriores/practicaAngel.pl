pertenece(H,[H|_]).
pertenece(V,[H|T]):-H\=V,pertenece(V,T).

%main:-pertenece(5,[1,2,3,4,5,6]) writef('%t').
factorial(1,0).
factorial(F,N):- R is N-1, factorial(F1,R),F is N*F1.
