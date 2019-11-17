:- include('variables.pl').

/* Pemain */
/* Kondisi awal pemain */
inventory(snivy).
inventory(pansage).
posisiPlayer(1,2).
jml_inventory(0).
curr_health(snivy,10).

/* Inventory */
/* add_inv(X,Y,Z) : menambahkan pokemon Y ke dalam list inventory X */
add_inv([],X,[X]).
add_inv([H|T],H,[H|T]).
add_inv([Z|T1],X,[Z|T2]):- add_inv(T1,X,T2),!.

/* del_inv(X,Y,Z) : menghapus pokemon Y dari inventory X */
del_inv([X],X,[]).
del_inv([Z|T1],X,[Z|T2]) :- del_inv(T1,X,T2),!.

/* catch(X) : Menangkap pokemon X yang sudah dikalahkan pada suatu lokasi tertentu dan memasukannya ke inventory I sehingga jumlah inventory bertambah 1 */
capture(X) :-
    pokemon(Y,X),
    posisiPlayer(A,B),
    posisiPokemon(Y,A,B),
    asserta(inventory(X)),
    jml_inventory(N),
    N1 is N+1,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    N1 < 7,
    add_inv(I,X,I2),!.

/* drop(X) : Menghapus pokemon X dari inventory */
drop(X) :- 
    pokemon(Y,X),
    retract(inventory(X)),
    jml_inventory(N),
    N1 is N-1,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    del_inv(I,X,I2),!.

/* choose(X) : Pokemon X dipilih dari inventory untuk battle */
pick(X) :- 
    pokemon(Y,X),
    findall(X,inventory(X),I2),!.
    /* buat attack (?) */

/* gym center */
/* healX(X) : Meningkatkan health pokemon X menjadi maksimal seperti semula */
healX(X) :-  
    pokemon(Y,X),
    posisiPlayer(A,B),
    gym(A,B),
    curr_health(X,H),
    health(X,HH),
    Z is HH;
    retract(curr_health(X,H)),
    asserta(curr_health(X,Z)),!.
/* heal : Meningkatkan health semua pokemon menjadi maksimal seperti semula */
heal :-
    \+ pokemon(Y,X),
    healX(X),!.

/* fail state */
/* fail : jumlah inventory = 0 */
fail :- jml_inventory(0),!.
