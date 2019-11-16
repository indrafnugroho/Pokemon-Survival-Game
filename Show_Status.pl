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
    write(H),nl,
    health(H,Y),
    write('Health:'),
    write(Y),nl,
    type(Z,H),
    write('Tipe:'),
    write(Z),nl,nl,
    showStatusList(T),!.
    
