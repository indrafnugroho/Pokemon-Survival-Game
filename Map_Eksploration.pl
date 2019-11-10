printmap(11,11) :- posisiPlayer(11,11), !,  write('P '), nl, !.
printmap(X,11) :- posisiPlayer(X,11), !,  write('P '), X1 is X+1, nl, printmap(X1,0), !.
printmap(X,Y) :- posisiPlayer(X,Y), !,  write('P '), Y1 is Y+1, printmap(X,Y1), !.
printmap(11,11) :- write('X '), nl, !.
printmap(X,11) :- write('X '), nl, X1 is X+1, printmap(X1,0), !.
printmap(11,Y) :- write('X '), Y1 is Y+1, printmap(11,Y1), !.
printmap(0,Y) :- write('X '), Y1 is Y+1, printmap(0,Y1),!.
printmap(X,0) :- write('X '), printmap(X,1), !.

printmap(X,Y) :- write('_ '), Y1 is Y+1, printmap(X,Y1), !.

posisiPlayer(3,4).

north :- currLoc(X,Y), X1 is X-1, retract(currLoc(X,Y)), asserta(currLoc(X1,Y)), !.

map :- printmap(0,0).

