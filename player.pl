:- dynamic(listPoke/1).
:- dynamic(idAv/1).
:- dynamic(no_inventory/2).
:-dynamic(isSkillUsed_Self/2).

idAv([6]).

/* Pemain */
/* Kondisi awal pemain */
inventory(snivy).
inventory(pansear).
inventory(panpour).
inventory(emolga).
inventory(pidove).
% inventory(throh).
/* Current Health */
curr_health(1,100).
curr_health(2,100).
curr_health(3,100).
curr_health(4,100).
curr_health(5,100).
/* isSkillUsed */
isSkillUsed_Self(1,0).
isSkillUsed_Self(2,0).
isSkillUsed_Self(3,0).
isSkillUsed_Self(4,0).
isSkillUsed_Self(5,0).

no_inventory(1,snivy).
no_inventory(2,pansear).
no_inventory(3,panpour).
no_inventory(4,emolga).
no_inventory(5,pidove).
% no_inventory(6,throh).
posisiPlayer(1,2).
posisiPokemon(1,1,2).
jml_inventory(5).

/* Inventory */
/* add_id(X,Y,Z) : menambahkan pokemon Y ke dalam list inventory X */
add_id([],X,[X]).
add_id([Z|T1],X,[Z|T2]):- add_id(T1,X,T2),!.


/* del_inv(X,Y,Z) : menghapus pokemon Y dari inventory X */
del_id([H|T],H, T).
del_id([H, H2|T],X, [H|T2]) :-
    del_id([H2|T], X, T2),!.

/* idx_inv(IN,X,IDX) : mengembalikan nilai indeks IDX elemen X dari inventori IN */
idx_inv([H|T], H, 1).
idx_inv([H|T], X, I) :-
    idx_inv(T, X, Z),
    I is (Z+1),!.

/* isExist(X,Y) : Y ada di dalam List X */
isExist([X],X).
isExist([H|T],H).
isExist([H|T],X) :- isExist(T,X),!.

/* capture(X) : Menangkap pokemon X yang sudah dikalahkan pada suatu lokasi tertentu dan memasukannya ke inventory I sehingga jumlah inventory bertambah 1 */
capture(X) :-
    pokemon(Y,X),
    posisiPlayer(A,B),
    posisiPokemon(Y,A,B),
    idAv(List),
    isExist(List,1),
    asserta(no_inventory(1,X)),
    del_id(List,1,Z),
    retract(idAv(List)),
    asserta(idAv(Z)),
    jml_inventory(N),
    N1 is N+1,
    N1 < 7,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),!.

capture(X) :-
    pokemon(Y,X),
    posisiPlayer(A,B),
    posisiPokemon(Y,A,B),
    idAv(List),
    isExist(List,2),
    asserta(no_inventory(2,X)),
    del_id(List,2,Z),
    retract(idAv(List)),
    asserta(idAv(Z)),
    jml_inventory(N),
    N1 is N+1,
    N1 < 7,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),!.

capture(X) :-
    pokemon(Y,X),
    posisiPlayer(A,B),
    posisiPokemon(Y,A,B),
    idAv(List),
    isExist(List,3),
    asserta(no_inventory(3,X)),
    del_id(List,3,Z),
    retract(idAv(List)),
    asserta(idAv(Z)),
    jml_inventory(N),
    N1 is N+1,
    N1 < 7,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),!.

capture(X) :-
    pokemon(Y,X),
    posisiPlayer(A,B),
    posisiPokemon(Y,A,B),
    idAv(List),
    isExist(List,4),
    asserta(no_inventory(4,X)),
    del_id(List,4,Z),
    retract(idAv(List)),
    asserta(idAv(Z)),
    jml_inventory(N),
    N1 is N+1,
    N1 < 7,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),!.

capture(X) :-
    pokemon(Y,X),
    posisiPlayer(A,B),
    posisiPokemon(Y,A,B),
    idAv(List),
    isExist(List,5),
    asserta(no_inventory(5,X)),
    del_id(List,5,Z),
    retract(idAv(List)),
    asserta(idAv(Z)),
    jml_inventory(N),
    N1 is N+1,
    N1 < 7,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),!.

capture(X) :-
    pokemon(Y,X),
    posisiPlayer(A,B),
    posisiPokemon(Y,A,B),
    idAv(List),
    isExist(List,6),
    asserta(no_inventory(6,X)),
    del_id(List,6,Z),
    retract(idAv(List)),
    asserta(idAv(Z)),
    jml_inventory(N),
    N1 is N+1,
    N1 < 7,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),!.

capture(X) :-
    jml_inventory(N),
    N1 is N+1,
    N1 > 6,
    write('Inventory penuh, drop pokemon anda dulu'), nl, !.

/* drop(X) : Menghapus pokemon X dari inventory */
drop(M) :- 
    no_inventory(M,X),
    pokemon(Y,X),
    inventory(X),
    idAv(List),
    add_id(List,M,List2),
    retract(idAv(List)),
    asserta(idAv(List2)),
    jml_inventory(N),
    N1 is N-1,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    retract(no_inventory(M,X)),
    retract(inventory(X)),!.

/* choose(X) : Pokemon X dipilih dari inventory untuk battle */
pick(N) :- 
    no_inventory(N,X),
    pokemon(Y,X),!.

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
    asserta(curr_health(X,Z)),
    write('Health '),
    write(X),
    write('menjadi maksimal'),nl,!.
/* heal : Meningkatkan health semua pokemon menjadi maksimal seperti semula */
heal :-
    inventory(X),
    pokemon(Y,X),
    healX(X).

/* fail state */
/* fail : jumlah inventory = 0 */
fail :- jml_inventory(0),!.
