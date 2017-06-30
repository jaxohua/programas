verifyingC([ [(l <= i) and ( forall j pu ((l <= j) < i imp a ab j ce <> e)),assume i <= u,assume a ab i ce = e,rv:=true,post rv dimp exist j pu ((l<=j)<=u) and a ab j ce = e ] ]).
verifyingC([ [(l <= i) ,assume i <= u,a ab i ce := 100,rv:=true,post rv imp (1<=i) dimp (a ab i ce <500)]]).
verifyingC([ [(l <= i) and ( forall j pu ((l <= j) < i imp a ab j ce <> e)),assume i <= u,assume a ab i ce = e,a ab x ce :=1981,rv:=true,post rv dimp sorted ab a ab x ce,rv,A ce] ]).


false: sustitucion(a ab i ce,100,true imp 1<=i dimp a ab i ce<500,L)
sustitucion(a ab i ce,100,true imp (1<=i dimp (a ab i ce<500)),L).


pag 139  PATH 3

verifyingC([[l <= i and (forall j pu  ( (l <=j) < i imp (a ab j ce <> e )) ) ,assume i<=u,assume a ab i ce <> e, i:=i+1, post l<=i and (forall j pu ( (l<=j)<i imp (a ab j ce <> e)) )  ]]).


PATH 2
verifyingC([[rv imp sorted, a:=5,l:=10,sorted ab a sp l sp u ce]]).




WP-ParaGentzen
verifyingC([[l <= i and (j forall ( (l <=j) < i imp (a ab j ce <> e )) ) ,assume i<=u,assume a ab i ce <> e, i:=i+1, post l<=i and (j forall ( (l<=j)<i imp (a ab j ce <> e)) )  ]]).
    Respuesta:
    [l<=i and (j forall (l<=j)<i imp a ab j ce<>e)imp[i<=u imp a ab i ce<>e imp l<=(i+1)and(j forall (l<=j)<i+1 imp a ab j ce<>e)]]

verifyingC([ [x>=0,x:=x+1,x>=1] ]).
[x>=0 imp [x+1>=1]]


WP-Cambia
cambia([(x>=0) imp (x+1>=1)],L).
L = [[mayor, x, 0]or[igual, x, 0]imp[mayor, x+1, 1]or[igual, x+1, 1]]



Gentzen
main( neg(y exist([p,y]))  or (x exist ([p,x]))).

[mayor, x, 0]or[igual, x, 0]imp[mayor, x+1, 1]or[igual, x+1, 1]





 [[mayor, x, 0]or[igual, x, 0]imp[mayor, x+1, 1]or[igual, x+1, 1]]


 [a and b,assume c, rv:=true,rv dimp ( d and e)]
  [(x>0) and (y>0),assume x<y, rv:=true,rv dimp ((x>=0) and (y>=0))]


=========== VC ===========
(x>0)and(y>0)imp x<y imp (true dimp (x>=0)and(y>=0))
=========== VC->FormaGentzen ===========
[mayor,x,0]and[mayor,y,0]imp[menor,x,y]imp(true dimp ([mayor,x,0]or[igual,x,0])and([mayor,y,0]or[igual,y,0]))
===========FND============
neg neg (neg[mayor,x,0]or neg[mayor,y,0])or(neg[menor,x,y]or neg (neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0])))or neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true)))
