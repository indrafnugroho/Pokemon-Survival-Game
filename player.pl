:- dynamic(listPoke/1).
:- dynamic(idAv/1).
:- dynamic(no_inventory/2).
:- dynamic(curr_health/2).
:- dynamic(isSkillUsed_Self/2).
:- dynamic(isHeal/1).

idAv([2,3,4,5,6]).

/* Pemain */
/* Kondisi awal pemain */
chooseStarter :-
    findall(X,starter(X),ListStarter),
    writeStarterList(ListStarter),
    write('Which Pokemon will you choose to be your partner? [choose]'),nl,
    write('>> '), read(Input),
    starterToInventory(Input),!.

starterToInventory(choose(X)) :- 
    starter(X),
    asserta(inventory(X)),
    health(X,H),
    asserta(curr_health(1,H)),
    asserta(isSkillUsed_Self(1,0)),
    asserta(no_inventory(1,X)),
    asserta(jml_inventory(1)),
    write(X), write(' is now your partner!'),nl,!.

writeStarterList([]) :- nl,!.
writeStarterList([H|T]) :-
    pokemon(N,H),
    write(N),
    write('. '), write(H),nl,
    type(X,H),
    write('   Type: '), write(X),nl,
    writeStarterList(T).

posisiPlayer(1,1).

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
    idAv(List),
    isExist(List,1),
    asserta(no_inventory(1,X)),
    asserta(curr_health(1,100)),
    del_id(List,1,Z),
    retract(idAv(_)),
    asserta(idAv(Z)),
    retract(jml_inventory(N)),
    N1 is N+1,
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),
    asserta(isSkillUsed_Self(1,0)),!.

capture(X) :-
    idAv(List),
    isExist(List,2),
    asserta(no_inventory(2,X)),
    asserta(curr_health(2,100)),
    del_id(List,2,Z),
    retract(idAv(_)),
    asserta(idAv(Z)),
    retract(jml_inventory(N)),
    N1 is N+1,
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),
    asserta(isSkillUsed_Self(2,0)),!.

capture(X) :-
    idAv(List),
    isExist(List,3),
    asserta(no_inventory(3,X)),
    asserta(curr_health(3,100)),
    del_id(List,3,Z),
    retract(idAv(_)),
    asserta(idAv(Z)),
    retract(jml_inventory(N)),
    N1 is N+1,
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),
    asserta(isSkillUsed_Self(3,0)),!.

capture(X) :-
    idAv(List),
    isExist(List,4),
    asserta(no_inventory(4,X)),
    asserta(curr_health(4,100)),
    del_id(List,4,Z),
    retract(idAv(_)),
    asserta(idAv(Z)),
    retract(jml_inventory(N)),
    N1 is N+1,
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),
    asserta(isSkillUsed_Self(4,0)),!.

capture(X) :-
    idAv(List),
    isExist(List,5),
    asserta(no_inventory(5,X)),
    asserta(curr_health(5,100)),
    del_id(List,5,Z),
    retract(idAv(_)),
    asserta(idAv(Z)),
    retract(jml_inventory(N)),
    N1 is N+1,
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),
    asserta(isSkillUsed_Self(5,0)),!.

capture(X) :-
    idAv(List),
    isExist(List,6),
    asserta(no_inventory(6,X)),
    asserta(curr_health(6,100)),
    del_id(List,6,Z),
    retract(idAv(_)),
    asserta(idAv(Z)),
    retract(jml_inventory(N)),
    N1 is N+1,
    asserta(jml_inventory(N1)),
    asserta(inventory(X)),
    asserta(isSkillUsed_Self(6,0)),!.

/* drop(X) : Menghapus pokemon X dari inventory */
drop(M) :- 
    no_inventory(M,X),
    idAv(List),
    add_id(List,M,List2),
    sort(List2,SortedList),
    retract(idAv(_)),
    asserta(idAv(SortedList)),
    retract(jml_inventory(N)),
    N1 is N-1,
    asserta(jml_inventory(N1)),
    retract(no_inventory(M,X)),
    retract(inventory(X)),
    retract(curr_health(M,_)),
    retract(isSkillUsed_Self(M,_)),!.

/* pick(N) : Pokemon dengan ID N dipilih dari inventory untuk battle */
pick(N) :- 
    no_inventory(N,_),!.

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

levelUp(P) :- \+starter(P),!.
levelUp(P) :-
    starter(P),
    retract(level(Lev,P)),
    NewLev is Lev+1,
    asserta(level(NewLev,P)),
    retract(damage(P,D)),
    NewD is D+5,
    asserta(damage(P,NewD)),
    retract(skill(P,SName,S)),
    NewS is S+5,
    asserta(skill(P,SName,NewS)),
    retract(health(P,H)),
    NewH is H+10,
    asserta(health(P,NewH)),
    write('Your '),write(P),write(' has leveled up!'),nl,
    write('Health: '), write(NewH),nl,
    write('Damage: '), write(NewD),nl,
    write('Skill: '), write(NewS),nl,!.

evolve(_,P) :- \+starter(P).
evolve(_,P) :- starter(P), level(L,P), L\=3.
evolve(N,P) :-
    starter(P),
    level(L,P), L==3,
    pokemon(I,P),
    write('Oh! Your '), write(P), write(' is evolving'),nl,
    write('.'),nl,
    write('.'),nl,
    write('.'),nl,
    NewI is (I*100 + I),
    pokemon(NewI,NewP),
    retract(no_inventory(N,_)),
    asserta(no_inventory(N,NewP)),
    health(NewP,NewH),
    retract(curr_health(N,_)),
    asserta(curr_health(N,NewH)),
    write('It evolved into '), write(P),write('!'),nl,
    write('Health: '), write(NewH),nl,
    damage(NewP,D),
    write('Damage: '), write(D),nl, 
    skill(NewP,SkillName,S),
    write(NewP), write(' learned '), write(SkillName),nl,
    write('Skill: '), write(S),nl,!.