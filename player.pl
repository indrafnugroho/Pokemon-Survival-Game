:- dynamic(listPoke/1).
:- dynamic(idAv/1).
:- dynamic(no_inventory/2).
:- dynamic(curr_health/2).
:- dynamic(isSkillUsed_Self/2).
:- dynamic(isHeal/1).

idAv([6]).

/* Pemain */
/* Kondisi awal pemain */
inventory(snivy).
inventory(pansear).
inventory(panpour).
inventory(emolga).
inventory(pidove).
inventory(throh).
/* Current Health */
curr_health(1,100).
curr_health(2,100).
curr_health(3,100).
curr_health(4,100).
curr_health(5,100).
curr_health(6,100).
/* isSkillUsed */
isSkillUsed_Self(1,0).
isSkillUsed_Self(2,0).
isSkillUsed_Self(3,0).
isSkillUsed_Self(4,0).
isSkillUsed_Self(5,0).
isSkillUsed_Self(6,0).

no_inventory(1,snivy).
no_inventory(2,pansear).
no_inventory(3,panpour).
no_inventory(4,emolga).
no_inventory(5,pidove).
no_inventory(6,throh).
posisiPlayer(1,1).
jml_inventory(6).

/* Inventory */
/* add_id(X,Y,Z) : menambahkan pokemon Y ke dalam list inventory X */
add_id([],X,[X]).
add_id([Z|T1],X,[Z|T2]):- add_id(T1,X,T2),!.


/* del_inv(X,Y,Z) : menghapus pokemon Y dari inventory X */
del_id([H|T],H, T).
del_id([H, H2|T],X, [H|T2]) :-
    del_id([H2|T], X, T2),!.

/* idx_inv(IN,X,IDX) : mengembalikan nilai indeks IDX elemen X dari inventory IN */
idx_inv([H|_T], H, 1).
idx_inv([_H|T], X, I) :-
    idx_inv(T, X, Z),
    I is (Z+1),!.

/* isExist(X,Y) : Y ada di dalam List X */
isExist([X],X).
isExist([H|_T],H).
isExist([_H|T],X) :- isExist(T,X),!.

/* capture(X) : Menangkap pokemon X yang sudah dikalahkan pada suatu lokasi tertentu dan memasukannya ke inventory I sehingga jumlah inventory bertambah 1 */
/* prekondisi : jml_inventory selalu < 6 */
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

/* drop(X) : Menghapus pokemon X dari inventory */
drop(M) :- 
    no_inventory(M,X),
    pokemon(_Y,X),
    inventory(X),
    idAv(List),
    add_id(List,M,List2),
    sort(List2,SortedList),
    retract(idAv(List)),
    asserta(idAv(SortedList)),
    jml_inventory(N),
    N1 is N-1,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    retract(no_inventory(M,X)),
    retract(inventory(X)),!.

/* choose(X) : Pokemon X dipilih dari inventory untuk battle */
pick(N) :- 
    no_inventory(N,X),
    pokemon(_Y,X),!.

/* gym center */
/* healX(L) : Meningkatkan health pokemon X menjadi maksimal seperti semula */
isHeal(0).

healX([]) :- 
    retract(isHeal(_)),
    asserta(isHeal(1)),
    write('Your Pokemon are now fully healed'),nl, write('See you next time!'),nl,!.
healX([X|T]) :-  
    no_inventory(M,X),
    curr_health(M,H),
    health(X,HH),
    Z is HH,
    retract(curr_health(M,H)),
    asserta(curr_health(M,Z)),
    healX(T).

/* heal : Meningkatkan health semua pokemon menjadi maksimal seperti semula */
heal :-
    posisiPlayer(A,B),
    gym(A,B),
    isHeal(N), N==0,
    findall(X,inventory(X),ListHeal),
    healX(ListHeal),!.

heal :-
    posisiPlayer(A,B),
    gym(A,B),
    isHeal(N), N==1,
    write('You can only heal your Pokemon once in a game'),nl,!.

heal :-
    posisiPlayer(A,B),
    \+gym(A,B),
    write('You can\'t do that!'),nl,!.

% /* fail state */
% /* fail : jumlah inventory = 0 */
% fail :- jml_inventory(0),!.