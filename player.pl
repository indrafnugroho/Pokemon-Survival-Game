:- include('variables.pl').


/* Pemain */
/* Kondisi awal pemain */
inventory(snivy).
posisiPlayer(1,2).
posisiPokemon(1,1,2).
jml_inventory(1).
curr_health(snivy,10).
curr_health(victini,100).
curr_health(virizion,100).



/* Inventory */
/* add_inv(X,Y,Z) : menambahkan pokemon Y ke dalam list inventory X */
add_inv([],X,[X]).
add_inv([Z|T1],X,[Z|T2]):- add_inv(T1,X,T2),!.

/* del_inv(X,Y,Z) : menghapus pokemon Y dari inventory X */
del_inv([H|T],H, T).
del_inv([H, H2|T],X, [H|T2]) :-
    del_inv([H2|T], X, T2),!.

/* idx_inv(IN,X,IDX) : mengembalikan nilai indeks IDX elemen X dari inventori IN */
idx_inv([H|T], H, 1).
idx_inv([H|T], X, I) :-
    idx_inv(T, X, Z),
    I is (Z+1),!.


/* catch(X) : Menangkap pokemon X yang sudah dikalahkan pada suatu lokasi tertentu dan memasukannya ke inventory I sehingga jumlah inventory bertambah 1 */
capture(X) :-
    pokemon(Y,X),
    posisiPlayer(A,B),
    posisiPokemon(Y,A,B),
    jml_inventory(N),
    N1 is N+1,
    N1 < 7,
    asserta(inventory(X)),
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    update_inv,!.


/* drop(X) : Menghapus pokemon X dari inventory */
drop(X) :- 
    pokemon(Y,X),
    inventory(X),
    retract(inventory(X)),
    jml_inventory(N),
    N1 is N-1,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    del_inv(I,X,I2),
    update_inv,!.

/* update_inv : mengupdate list inventory */
update_inv :-
    inventory(X),
    add_inv([],X,List2).
    idx_inv(List2,X,N2),
    asserta(no_inventory(N2,X)),!.

/* choose(X) : Pokemon X dipilih dari inventory untuk battle */
pick(N) :- 
    no_inventory(N,X),
    pokemon(Y,X),!.
    /* buat attack (?) */

/* gym center */
/* healX(X) : Meningkatkan health pokemon X menjadi maksimal seperti semula */
healX(X) :-  
    pokemon(Y,X),
    inventory(X),
    posisiPlayer(A,B),
    gym(A,B),
    health(X,HH),
    Z is HH,
    retract(curr_health(X,H)),
    asserta(curr_health(X,Z)),!.
/* heal : Meningkatkan health semua pokemon menjadi maksimal seperti semula */
heal :-
    inventory(X),
    pokemon(Y,X),
    healX(X).

/* fail state */
/* fail : jumlah inventory = 0 */
fail :- jml_inventory(0),!.
