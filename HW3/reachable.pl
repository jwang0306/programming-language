% connected(A, B) :- edge(A, B), edge(B, A).
% connected(A, B) :- edge(A, X), connected(X, B).

% reachable(A, B) :- 
%     A == B; connected(A, B) -> (write("YES"), nl);
%     (write("NO"), nl).

checkConnection(A, B) :- connected(A, B, []). % an accumulator to remember walked paths
connected(A, B, _) :- edge(A, B).
connected(A, B, Walked) :-
    edge(A, X), 
    not(member(X, Walked)), % if X is not walked before, this stat will be true
    connected(X, B, [A|Walked]). 

reachable(A, B) :-
    checkConnection(A, B), write("YES"), nl;
    write("NO"), nl.

connect_edge(A, B) :- assert(edge(A, B)), assert(edge(B, A)).

loop_input(0).
loop_input(N) :-
    N > 0,
    % read(A), read(B),
    readln([A, B]),
    
    % write("Input: "), write(A), write(" "), write(B), nl,
    connect_edge(A, B),
    M is N - 1, loop_input(M).

loop_query(0).
loop_query(N) :-
    N > 0,
    % read(A), read(B),
    readln([A, B]),
    % write("Input: "), write(A), write(" "), write(B), nl,
    reachable(A, B),
    M is N - 1, loop_query(M).

main :- 
    % read(N), read(E),
    readln([N, E]),
    loop_input(E),
    readln(M),
    loop_query(M),
    halt.

:- initialization(main).