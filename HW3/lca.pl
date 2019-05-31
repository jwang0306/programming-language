grandConnected(A, B) :- parent(A, B).
grandConnected(A, B) :- parent(A, X), grandConnected(X, B).

finaLCA(A, B) :-
    A == B, write(A), nl.
finaLCA(A, B) :-
    grandConnected(A, B),  write(A), nl.
finaLCA(A, B) :-
    parent(X, A), finaLCA(X, B).

loop_input(0).
loop_input(N) :-
    % write("in there"), nl,
    N > 0,
    % read(A), read(B),
    readln([A, B]),
    assert(parent(A, B)),
    M is N - 1, loop_input(M).

loop_query(0).
loop_query(N) :-
    N > 0,
    % read(A), read(B),
    readln([A, B]),
    % write("Input: "), write(A), write(" "), write(B), nl,
    finaLCA(A, B),
    M is N - 1, loop_query(M).

main :- 
    readln(N),
    loop_input(N - 1),
    readln(M),
    loop_query(M),
    halt.

:- initialization(main).