

/* print map*/
printMap(11,11) :- posisiPlayer(11,11), !,  write('P '), nl, !.
printMap(X,11) :- posisiPlayer(X,11), !,  write('P '), X1 is X+1, nl, printMap(X1,0), !.
printMap(X,Y) :- posisiPlayer(X,Y), !,  write('P '), Y1 is Y+1, printMap(X,Y1), !.
printMap(X,Y) :- gym(X,Y), !,  write('G '), Y1 is Y+1, printMap(X,Y1), !.
printMap(X,Y) :- pagar(X,Y), !,  write('X '), Y1 is Y+1, printMap(X,Y1), !.
printMap(11,11) :- write('X '), nl, !.
printMap(X,11) :- write('X '), nl, X1 is X+1, printMap(X1,0), !.
printMap(11,Y) :- write('X '), Y1 is Y+1, printMap(11,Y1), !.
printMap(0,Y) :- write('X '), Y1 is Y+1, printMap(0,Y1),!.
printMap(X,0) :- write('X '), printMap(X,1), !.

printMap(X,Y) :- write('_ '), Y1 is Y+1, printMap(X,Y1), !.

printInfoLokasi:-  posisiPlayer(X,Y), loc(X,Y,Lokasi), nl, write('Anda sekarang berada di '), write(Lokasi), nl, !.

map :- printMap(0,0), printInfoLokasi.

/* movements */
atas :- posisiPlayer(X,Y), X\=1, X1 is X-1,  retract(posisiPlayer(X,Y)), asserta(posisiPlayer(X1,Y)), !.    
atas :- posisiPlayer(X,_), X==1, write('Tidak bisa keatas, pager cuy'),nl, !. 
 
bawah :- posisiPlayer(X,Y), X\=10, X1 is X+1, retract(posisiPlayer(X,Y)), asserta(posisiPlayer(X1,Y)), !.
bawah :- posisiPlayer(X,_), X==10, write('Tidak bisa kebawah, pager cuy'),nl, !. 

kanan :- posisiPlayer(X,Y), y\=10, Y1 is Y+1, retract(posisiPlayer(X,Y)), asserta(posisiPlayer(X,Y1)), !.
kanan :- posisiPlayer(_,Y), Y==10, write('Tidak bisa kekanan, pager cuy'),nl, !. 

kiri :- posisiPlayer(X,Y), Y\=1, Y1 is Y-1, retract(posisiPlayer(X,Y)), asserta(posisiPlayer(X,Y1)), !.
kiri :- posisiPlayer(_,Y), Y==1, write('Tidak bisa kekiri, pager cuy'),nl, !. 

/* pokemon movement */
movePokemon(ID) :-
    random(1,11,Xnew),
    random(1,11,Ynew),
    \posisiPokemon(_,Xnew,Ynew),
    posisiPokemon(ID,X,Y),
    retract(posisiPokemon(ID,X,Y)),
    asserta(posisiPokemon(ID,Xnew,Ynew)),!.

moveAllPokemon :-
    findall(ID,posisiPokemon(ID,_,_),ListPokemon),
    movePokemonList(ListPokemon).

movePokemonList([]).
movePokemonList(L):-
    L=[H|Tail],
    movePokemon(H),
    movePokemonList(Tail), !.

/* spawning pokemon */

/* Jika Hasil == 1 , pokemon yang memiliki ID tersebut, muncul di posisi yang ditentukan */
/* legendary pokemon */
spawnPokemon(ID, X, Y, Hasil):-
    pokemon(ID,Nama),
    posisiPokemon(ID,X,Y),
    legendary(Nama),
    random(1,5,RandomValue), 
    Hasil is RandomValue,!.

/* normal pokemon */
spawnPokemon(ID, X, Y, Hasil):-
    pokemon(ID,Nama),
    posisiPokemon(ID,X,Y),
    \+legendary(Nama),
    random(1,3,RandomValue), 
    Hasil is RandomValue,!.

spawn:-
    posisiPlayer(X,Y),
    \+posisiPokemon(_,X,Y),
    write('Tidak ada pokemon disini  '),  nl, !.

spawn:-
    posisiPlayer(X,Y),
    pokemon(ID,Nama),
    spawnPokemon(ID,X,Y,Hasil),
    Hasil==1,
    write('Kamu bertemu '), write(Nama),nl,
    write('Choose battle/run '), nl, !.


spawn:-
    posisiPlayer(X,Y),
    pokemon(ID,Nama),
    spawnPokemon(ID,X,Y,Hasil),
    Hasil\=1,
    write('Kamu bertemu tidak bertemu pokemon apapun '),  nl, !.




