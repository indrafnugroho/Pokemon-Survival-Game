
/* STATUS */
status :-
    write('Your Pokemon:'), nl,
    findall(X,inventory(X),ListInventory),
    showStatusList(ListInventory),

    write('Your enemy:'),nl,
    findall(X,legendary(X),ListLegendary),
    showStatusList(ListLegendary).

showStatusList([]).
showStatusList(L) :-
    L = [H|T],
    pokemon(X,H),
    no_inventory(N,H),
    write(N),
    write('. '),
    write(H),nl,
    health(H,Y),
    write('Health:'),
    write(Y),nl,
    type(Z,H),
    write('Tipe:'),
    write(Z),nl,nl,
    showStatusList(T),!.

showStatusList(L) :-
    L = [H|T],
    legendary(H),
    write(H),nl,
    health(H,Y),
    write('Health:'),
    write(Y),nl,
    type(Z,H),
    write('Tipe:'),
    write(Z),nl,nl,
    showStatusList(T),!.