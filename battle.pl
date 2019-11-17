/* ***************** Rules when player meet Pokemon ******************** */
executeRun/1.
battle/0.

executeRun(RandomValue) :-
    RandomValue is 1,
    print('Kamu berhasil lari dari Pokemon'),nl,
    retract(isSedangBertemuPokemon(OldStatus)),
    NewStatus is 0,
    asserta(isSedangBertemuPokemon(NewStatus)),!.

executeRun(_) :-
    print('Kamu gagal lari dari Pokemon'),nl,    
    pilihPokemon.

pilihPokemon :-
    retract(isBattle(OldStatus)),
    Status is 1,
    asserta(isBattle(Status)),
    write('Pilih Pokemon mu!'),nl.

:- dynamic(turnStatus/1).
turnStatus(1).

/* turn pemain */
turnPlayer:-
    turnStatus(X),
    X is 1,
    turnPemain,
    X1 is 0,
    retract(turnStatus(X)),
    asserta(turnStatus(X1)),
    !.

/* turn enemy */
turnPlayer :-
    turnStatus(X),
    X is 0,
    turnEnemy,
    X1 is 1,
    retract(turnStatus(X)),
    asserta(turnStatus(X1)),
    !.      

turnPemain :-
    nl,print('-> '),
    read(X),
    commandPlayer(X),
    nl,!.

turnEnemy :-
    !.

commandPlayer(attack) :-
    pick(PokemonSerang),
    battleNow(PokemonDiSerang),

    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    % \+superEffective(T1,T2),
    % \+notEffective(T1,T2),
    Health1 is Health0-Damage,
    asserta(curr_health(PokemonDiSerang,Health1)),
    nl,print(PokemonSerang),print(' dealt '),print(Damage),print(' to '), print(PokemonDiSerang),nl,
    !,fail.

/************************************************************************************************************/
battle :-
    pick(PickedPokemon),
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
        pick(PickedPokemon),
        curr_health(PickedPokemon,PickedPokemonHealth),
        type(TypePickedPokemon,PickedPokemon),

        nl,write(PickedPokemon),nl,
        write('Health: '),write(PickedPokemonHealth),nl,
        write('Type: '),write(TypePickedPokemon),nl,

        turnPlayer,
        end_battle.
/************************************************************************************************************/

end_battle :-
    pick(PickedPokemon),
    curr_health(PickedPokemon,Health),
    Health =< 0 ,!.

end_battle :-
    battleNow(Enemy),
    curr_health(Enemy,Health),
    Health =< 0 ,!.

