/* STATUS */
status :-
    write('Your Pokemon:'), nl,
    findall(N,no_inventory(N,X),ListInventory),
    sort(ListInventory,SortedList),
    showStatusList(SortedList),

    write('Your enemy:'),nl,
    findall(X,legendary(X),ListLegendary),
    showStatusList(ListLegendary).

showStatusList([]).
showStatusList(L) :-
    L = [N|T],
    no_inventory(N,H),
    pokemon(_X,H),
    write(N),
    write('. '),
    write(H),nl,
    curr_health(N,Y),
    write('Health: '),
    write(Y),nl,
    type(Z,H),
    write('Type: '),
    write(Z),nl,
    showLevel(H),nl,
    showStatusList(T),!.

showStatusList(L) :-
    totalLegendary(N), N\=0,
    L = [H|T],
    legendary(H),
    write(H),nl,
    health(H,Y),
    write('Health: '),
    write(Y),nl,
    type(Z,H),
    write('Type: '),
    write(Z),nl,nl,
    showStatusList(T),!.

showLevel(P) :- \+starter(P),!.
showLevel(P) :-
    starter(P),
    level(Lev,P),
    write('Level: '),write(Lev),nl,!.