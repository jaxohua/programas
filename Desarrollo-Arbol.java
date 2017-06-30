->neg neg (neg[mayor,x,0]or neg[mayor,y,0])or(neg[menor,x,y]or neg (neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0])))or neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true)))

->neg[mayor,x,0]or neg[mayor,y,0] or(neg[menor,x,y]or neg (neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0])))or neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true)))

->neg[mayor,x,0],neg[mayor,y,0] or(neg[menor,x,y]or neg (neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0])))or neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true)))

[mayor,x,0],[mayor,y,0]->neg[menor,x,y]or neg (neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0])))or neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true))

[mayor,x,0],[mayor,y,0]->neg[menor,x,y] , neg (neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0])))or neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true))

[menor,x,y],[mayor,x,0],[mayor,y,0]-> neg (neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0])))or neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true))

[menor,x,y],[mayor,x,0],[mayor,y,0],neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))) or neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true)->

[menor,x,y],[mayor,x,0],[mayor,y,0],neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))) or neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true)->

    %%%%%%Primera Rama
    a) [menor,x,y],[mayor,x,0],[mayor,y,0],neg (neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))) ->
    a) [menor,x,y],[mayor,x,0],[mayor,y,0] ->neg true or neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))
    a) [menor,x,y],[mayor,x,0],[mayor,y,0] ->neg true , neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))
    a) [menor,x,y],[mayor,x,0],[mayor,y,0] true -> neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))
    a) [menor,x,y],[mayor,x,0],[mayor,y,0] true ,neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]) ->

        a1) [menor,x,y],[mayor,x,0],[mayor,y,0], true ,neg ([mayor,x,0]or[igual,x,0])->
        a1) [menor,x,y],[mayor,x,0],[mayor,y,0], true ->[mayor,x,0]or[igual,x,0]
        a1) [menor,x,y],[mayor,x,0],[mayor,y,0], true ->[mayor,x,0] , [igual,x,0]

        a2) [menor,x,y],[mayor,x,0],[mayor,y,0], true ,neg ([mayor,y,0]or[igual,y,0]) ->
        a2) [menor,x,y],[mayor,x,0],[mayor,y,0], true -> [mayor,y,0] or [igual,y,0]
        a2) [menor,x,y],[mayor,x,0],[mayor,y,0], true -> [mayor,y,0] , [igual,y,0]






    %%%%% Segunda Rama
    b) [menor,x,y],[mayor,x,0],[mayor,y,0],neg (neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true)-->
    b) [menor,x,y],[mayor,x,0],[mayor,y,0]-> neg neg (neg ([mayor,x,0]or[igual,x,0])or neg ([mayor,y,0]or[igual,y,0]))or true
    b) [menor,x,y],[mayor,x,0],[mayor,y,0]-> neg ([mayor,x,0]or[igual,x,0]) or neg ([mayor,y,0]or[igual,y,0]) or true
    b) [menor,x,y],[mayor,x,0],[mayor,y,0]-> neg ([mayor,x,0]or[igual,x,0]) , neg ([mayor,y,0]or[igual,y,0]) or true
    b) [menor,x,y],[mayor,x,0],[mayor,y,0], [mayor,x,0]or[igual,x,0] -> neg ([mayor,y,0]or[igual,y,0]) or true
    b) [menor,x,y],[mayor,x,0],[mayor,y,0], [mayor,x,0]or[igual,x,0] -> neg ([mayor,y,0]or[igual,y,0]) , true

        b1) [menor,x,y],[mayor,x,0],[mayor,y,0], [mayor,x,0]-> neg ([mayor,y,0]or[igual,y,0]) , true
        b1) [menor,x,y],[mayor,x,0],[mayor,y,0], [mayor,x,0] [mayor,y,0]or[igual,y,0]-> , true
        b1) [menor,x,y],[mayor,x,0],[mayor,y,0], [mayor,x,0], [mayor,y,0]or[igual,y,0]-> , true
            b11) [menor,x,y],[mayor,x,0],[mayor,y,0], [mayor,x,0] [mayor,y,0]->true
            b12)[menor,x,y],[mayor,x,0],[mayor,y,0], [mayor,x,0],[igual,y,0]-> true
                        FALSO



        b2) [menor,x,y],[mayor,x,0],[mayor,y,0], [igual,x,0] -> neg ([mayor,y,0]or[igual,y,0]) , true
        b2) [menor,x,y],[mayor,x,0],[mayor,y,0], [igual,x,0], [mayor,y,0]or[igual,y,0]-> true
            b21) [menor,x,y],[mayor,x,0],[mayor,y,0], [igual,x,0], [mayor,y,0]->true
            b22) [menor,x,y],[mayor,x,0],[mayor,y,0], [igual,x,0], [igual,y,0]-> true
                            FALSO