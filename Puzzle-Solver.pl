
% puzzle([6, 1, 3, 4, -1, 5, 7, 2, 0], [-1, 0, 1, 2, 3, 4, 5, 6, 7]).

movable(Index, [C1, C2, C3, C4, C5, C6, C7, C8, C9], [G1, G2, G3, G4, G5, G6, G7, G8, G9]):-
nth0(Index, [C1, C2, C3, C4, C5, C6, C7, C8, C9], N),
nth0(Index, [G1, G2, G3, G4, G5, G6, G7, G8, G9], M),
N \== M.

% Move Up
move([C1, C2, C3, C4, C5, C6, C7, C8, C9], Goal, R):-
C1 > -1,
C2 > -1,
C3 > -1,
nth0(N, [C1, C2, C3, C4, C5, C6, C7, C8, C9], -1), % find the blank space
Z is N-3,
movable(Z, [C1, C2, C3, C4, C5, C6, C7, C8, C9], Goal),
nth0(Z, [C1, C2, C3, C4, C5, C6, C7, C8, C9], TopVal), % find the value on top of the blank space
substitute(-1, [C1, C2, C3, C4, C5, C6, C7, C8, C9], 10, Q),
substitute(TopVal, Q, -1, NewQ),
substitute(10, NewQ, TopVal, R).

% Move Left
move([C1, C2, C3, C4, C5, C6, C7, C8, C9], _, R):-
C1 > -1,
C4 > -1,
C7 > -1,
nth0(N, [C1, C2, C3, C4, C5, C6, C7, C8, C9], -1), % find the blank space
Z is N-1,
nth0(Z, [C1, C2, C3, C4, C5, C6, C7, C8, C9], LeftVal), % find the value on the left of the blank space
substitute(-1, [C1, C2, C3, C4, C5, C6, C7, C8, C9], 10, Q),
substitute(LeftVal, Q, -1, NewQ),
substitute(10, NewQ, LeftVal, R).

% Move Down
move([C1, C2, C3, C4, C5, C6, C7, C8, C9], Goal, R):-
C7 > -1,
C8 > -1,
C9 > -1,
nth0(N, [C1, C2, C3, C4, C5, C6, C7, C8, C9], -1), % find the blank space
Z is N+3,
movable(Z, [C1, C2, C3, C4, C5, C6, C7, C8, C9], Goal),
nth0(Z, [C1, C2, C3, C4, C5, C6, C7, C8, C9], BottomVal), % find the value below the blank space
substitute(-1, [C1, C2, C3, C4, C5, C6, C7, C8, C9], 10, Q),
substitute(BottomVal, Q, -1, NewQ),
substitute(10, NewQ, BottomVal, R).

% Move Right
move([C1, C2, C3, C4, C5, C6, C7, C8, C9], _, R):-
C3 > -1,
C6 > -1,
C9 > -1,
nth0(N, [C1, C2, C3, C4, C5, C6, C7, C8, C9], -1), % find the blank space
Z is N+1,
nth0(Z, [C1, C2, C3, C4, C5, C6, C7, C8, C9], RightVal), % find the value on the right of the blank space
substitute(-1, [C1, C2, C3, C4, C5, C6, C7, C8, C9], 10, Q),
substitute(RightVal, Q, -1, NewQ),
substitute(10, NewQ, RightVal, R).

substitute(_, [], _, []):-!.
substitute(X, [X|T], Y, [Y|T1]):-
	substitute(X, T, Y, T1),!.

substitute(X, [H|T], Y, [H|T1]):-
	substitute(X, T, Y, T1).

reverse([],Z,Z).

reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).

printData([]).

printData([H|T]):-
write(H),
write("\n"),
printData(T).

solve(Goal, Visited, Goal, Visited).

solve(CurrentState, Visited, Goal, R):-
move(CurrentState, Goal, NewState),
\+ member(NewState,Visited),
solve(NewState, [NewState|Visited], Goal, R).

puzzle(CurrentState, Goal):-
solve(CurrentState, [CurrentState], Goal, R),
reverse(R, X, []),
printData(X),!.