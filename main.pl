:- include('variables.pl').
:- include('Map_Eksploration.pl').

start :-
    repeat,
		write('>> '), /* Menandakan input */
		read(Input),nl, /*Meminta input dari user */
		do(Input),nl, fail. /* Menjadlankan do(Input) */
		


do(w) :- atas, spawn, !.
do(s) :- bawah,  spawn, !.
do(a) :- kiri, spawn, !.
do(d) :- kanan, spawn, !.
do(map) :-map.
