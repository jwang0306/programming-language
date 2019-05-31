checkPrime(2) :- 
    true.
checkPrime(X) :- 
    X < 2, false. % if less than 2, false.
checkPrime(X) :- 
    not(hasFactor(X, 2)). % if can divide by 2, false.

hasFactor(X, Y) :- 
    0 is X mod Y.
hasFactor(X, Y) :- 
    V is Y + 1,
    X > V, hasFactor(X, V). % keep recursive only when X > V

allComb(X, Y) :-
    V is X - Y, 
    V >= Y,
    checkPrime(Y), checkPrime(V),
    write(Y),
    write(" "),
    write(V), nl,
    Z is Y + 1, allComb(X, Z).

allComb(X, Y) :-
    Z is Y + 1, 
    V is X - Z, 
    V > Y,
    allComb(X, Z).

allComb(_, _) :-
    halt.

main :- readln(X), allComb(X, 2).

:- initialization(main).