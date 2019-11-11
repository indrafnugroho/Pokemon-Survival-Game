:- include('variables.pl').
:- include('Map_Eksploration.pl').
:- include('Show_Status.pl').
:- include('Show_Help.pl').

start :-
    repeat,
		write('>> '), /* Menandakan input */
		read(Input),nl, /*Meminta input dari user */
		do(Input),nl, fail. /* Menjadlankan do(Input) */
		


do(w) :- atas, moveAllPokemon, spawn, !.
do(s) :- bawah,  moveAllPokemon, spawn, !.
do(a) :- kiri, moveAllPokemon, spawn, !.
do(d) :- kanan, moveAllPokemon, spawn, !.
do(map) :- map.
do(status) :- status.
do(help) :- help.