/* ***************** Rules when player meet Pokemon ******************** */
executeRun/1.
battle/0.

executeRun(RandomValue) :-
    RandomValue == 1,
    print('Kamu berhasil lari dari Pokemon'),nl,
    retract(isSedangBertemuPokemon(OldStatus)),
    NewStatus = 0,
    asserta(isSedangBertemuPokemon(NewStatus)),!.

executeRun(_) :-
    print('Kamu gagal lari dari Pokemon'),nl,    
    pilihPokemon.

pilihPokemon :-
    retract(isBattle(OldStatus)),
    Status = 1,
    asserta(isBattle(Status)),
    write('Pilih Pokemon mu!'),nl.

:- dynamic(turnStatus/1).
turnStatus(1).

/* turn pemain */
turnPlayer(PickedPokemon,Enemy) :-
    turnStatus(X),
    X == 1,
    turnPemain(PickedPokemon,Enemy),
    X1 is 0,
    retract(turnStatus(X)),
    asserta(turnStatus(X1)),
    !.

/* turn enemy */
turnPlayer(PickedPokemon,Enemy) :-
    turnStatus(X),
    X == 0,
    turnEnemy(PickedPokemon,Enemy),
    X1 is 1,
    retract(turnStatus(X)),
    asserta(turnStatus(X1)),
    !.      

turnPemain(PickedPokemon,Enemy) :-
    nl,print('-> '),
    read(X),
    commandPlayer(X,PickedPokemon,Enemy),
    nl,!.

turnEnemy(PickedPokemon,Enemy) :-
    retract(curr_health(PickedPokemon,Health0)),
    damage(Enemy,Damage),
    type(T1,Enemy),
    type(T2,PickedPokemon),
    % \+superEffective(T1,T2),
    % \+notEffective(T1,T2),
    Health1 is Health0-Damage,
    asserta(curr_health(PickedPokemon,Health1)),
    nl,print(Enemy),print(' dealt '),print(Damage),print(' to '), print(PickedPokemon),nl,
    !.

commandPlayer(attack,PickedPokemon,Enemy) :-
    damage(PickedPokemon,Damage),
    type(T1,PickedPokemon),
    type(T2,Enemy),
    \+superEffective(T1,T2),
    \+notEffective(T1,T2),
    retract(curr_health(Enemy,Health0)),
    Health1 is Health0-Damage,
    asserta(curr_health(Enemy,Health1)),
    nl,print(PickedPokemon),print(' dealt '),print(Damage),print(' to '), print(Enemy),nl,
    !.

commandPlayer(attack,PickedPokemon,Enemy) :-
    damage(PickedPokemon,Damage),
    type(T1,PickedPokemon),
    type(T2,Enemy),
    superEffective(T1,T2),
    \+notEffective(T1,T2),
    NewDamage is Damage + (Damage/2),
    retract(curr_health(Enemy,Health0)),
    Health1 is Health0-NewDamage,
    asserta(curr_health(Enemy,Health1)),
    nl,print(PickedPokemon),print(' dealt '),print(NewDamage),print(' to '),print(Enemy),
    !.

commandPlayer(attack,PickedPokemon,Enemy) :-
    damage(PickedPokemon,Damage),
    type(T1,PickedPokemon),
    type(T2,Enemy),
    \+superEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage - (Damage/2),
    retract(curr_health(Enemy,Health0)),
    Health1 is Health0-NewDamage,
    asserta(curr_health(Enemy,Health1)),
    nl,print(PickedPokemon),print(' dealt '),print(NewDamage),print(' to '),print(Enemy),
    !.

/************************************************************************************************************/
battle(PickedPokemon) :-
    write('I choose you '), write(PickedPokemon), nl,
    battleNow(Enemy),
    health(PickedPokemon,H0),
    asserta(curr_health(PickedPokemon,H0)),
    health(Enemy,HEnemy0),
    asserta(curr_health(Enemy,HEnemy0)),
    /* battle akan akan terus bergirilir sampai kondisi StatusSelesai bernilai 1 */
    repeat,
        /* cetak data pokemon lawan */
        battleNow(Enemy),
        curr_health(Enemy,EnemyHealth),
        type(EnemyType,Enemy),

        nl,write(Enemy),nl,
        write('Health: '),write(EnemyHealth),nl,
        write('Type: '),write(EnemyType),nl,

        /* cetak data pokemon kita */
        curr_health(PickedPokemon,PickedPokemonHealth),
        type(TypePickedPokemon,PickedPokemon),

        nl,write(PickedPokemon),nl,
        write('Health: '),write(PickedPokemonHealth),nl,
        write('Type: '),write(TypePickedPokemon),nl,

        turnStatus(X),

        turnPlayer(PickedPokemon,Enemy),
        end_battle(PickedPokemon, Enemy).
/************************************************************************************************************/

end_battle(PickedPokemon,Enemy) :-
    curr_health(PickedPokemon,Health),
    Health =< 0.

end_battle(PickedPokemon, Enemy) :-
    curr_health(Enemy,Health),
    Health =< 0.