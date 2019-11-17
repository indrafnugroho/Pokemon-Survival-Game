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
    pokemon(X,H),
    write(N),
    write('. '),
    write(H),nl,
    
    type(Z,H),
    write('Tipe:'),
    write(Z),nl,nl,
    showStatusList(T),!.

showStatusList(L) :-
    L = [H|T],
    legendary(H),
    write(H),nl,
    curr_health(N,Y),
    write('Health:'),
    write(Y),nl,
    type(Z,H),
    write('Tipe:'),
    write(Z),nl,nl,
    showStatusList(T),!.