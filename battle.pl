/* ***************** Rules when player meet Pokemon ******************** */

:-dynamic(enemy_health/2).
:-dynamic(isEnemyAfterBattle/1).

executeRun(RandomValue) :-
    RandomValue == 1,
    print('Got away freely'),nl,
    retract(isSedangBertemuPokemon(_)),
    asserta(isSedangBertemuPokemon(0)),!.

executeRun(_) :-
    print('You can\'t run'),nl,    
    pilihPokemon.

pilihPokemon :-
    retract(isBattle(_)),
    asserta(isBattle(1)),
    write('Choose your Pokemon'),nl.

:- dynamic(turnStatus/1).

turnStatus(1).

/* turn pemain */
turnPlayer(NumP,PickedPokemon,Enemy) :-
    turnStatus(X),
    X == 1,
    turnPemain(NumP,PickedPokemon,Enemy),
    retract(turnStatus(_)),
    asserta(turnStatus(0)),
    !.

/* turn enemy */
turnPlayer(NumP,PickedPokemon,Enemy) :-
    turnStatus(X),
    X == 0,
    turnEnemy(NumP,PickedPokemon,Enemy),
    retract(turnStatus(_)),
    asserta(turnStatus(1)),
    !.      

turnPemain(NumP,PickedPokemon,Enemy) :-
    nl,print('-> '),
    read(X),
    commandPlayer(X,NumP,PickedPokemon,Enemy),
    nl,!.

substractHealthPlayer(NumP,Damage,Health) :-
    Health1 is Health-Damage, Health1 >= 0,
    asserta(curr_health(NumP,Health1)),!.

substractHealthPlayer(NumP,Damage,Health) :-
    Health1 is Health-Damage, Health1 < 0,
    asserta(curr_health(NumP,0)),!.

turnEnemy(NumP,PickedPokemon,Enemy) :-
    modifier(Enemy,PickedPokemon,Damage),
    retract(curr_health(NumP,Health)),
    substractHealthPlayer(NumP,Damage,Health),
    nl,print(Enemy),print(' dealt '),print(Damage),print(' to '), print(PickedPokemon),nl,
    !.

substractHealthEnemy(Enemy,Damage,Health) :-
    Health1 is Health-Damage, Health1 >= 0,
    asserta(enemy_health(Enemy,Health1)),!.

substractHealthEnemy(Enemy,Damage,Health) :-
    Health1 is Health-Damage, Health1 < 0,
    asserta(enemy_health(Enemy,0)),!.

commandPlayer(specialAttack,NumP,_,_) :-
    isSkillUsed_Self(NumP,N), N==1,
    write('Special Attack can only be used once in a fight!'),!.

commandPlayer(specialAttack,NumP,PickedPokemon,Enemy) :-
    isSkillUsed_Self(NumP,N), N==0,
    modifierSkill(PickedPokemon,Enemy,Damage,NameSkill),
    retract(enemy_health(Enemy,Health)),
    substractHealthEnemy(Enemy,Damage,Health),
    nl,print(PickedPokemon),print(' used '),print(NameSkill),print(' to '),print(Enemy),write('!'),
    retract(isSkillUsed_Self(NumP,_)),
    asserta(isSkillUsed_Self(NumP,1)),
    !.

commandPlayer(attack,_NumP,PickedPokemon,Enemy) :-
    modifier(PickedPokemon,Enemy,Damage),
    retract(enemy_health(Enemy,Health)),
    substractHealthEnemy(Enemy,Damage,Health),
    nl,print(PickedPokemon),print(' dealt '),print(Damage),print(' to '), print(Enemy),
    !.

/************************************************************************************************************/
battle(NumP) :-
    isEnemyAfterBattle(N), N==0,
    no_inventory(NumP,PickedPokemon),
    write('I choose you '), write(PickedPokemon), nl,
    battleNow(Enemy),
    health(Enemy,HEnemy0),
    asserta(enemy_health(Enemy,HEnemy0)),
    /* battle akan akan terus bergirilir sampai kondisi StatusSelesai bernilai 1 */
    repeat,
        /* cetak data pokemon lawan */
        battleNow(Enemy),
        enemy_health(Enemy,EnemyHealth),
        type(EnemyType,Enemy),

        nl,write(Enemy),nl,
        write('Health: '),write(EnemyHealth),nl,
        write('Type: '),write(EnemyType),nl,

        /* cetak data pokemon kita */
        curr_health(NumP,PickedPokemonHealth),
        type(TypePickedPokemon,PickedPokemon),

        nl,write(PickedPokemon),nl,
        write('Health: '),write(PickedPokemonHealth),nl,
        write('Type: '),write(TypePickedPokemon),nl,

        turnPlayer(NumP,PickedPokemon,Enemy),
        end_battle(NumP,PickedPokemon, Enemy).

battle(NumP) :-
    isEnemyAfterBattle(N), N==1,
    no_inventory(NumP,PickedPokemon),
    write('I choose you '), write(PickedPokemon),write('!'), nl,
    battleNow(Enemy),
    % enemy_health(Enemy,HEnemy0),
    /* battle akan akan terus bergirilir sampai kondisi StatusSelesai bernilai 1 */
    repeat,
        /* cetak data pokemon lawan */
        battleNow(Enemy),
        enemy_health(Enemy,EnemyHealth),
        type(EnemyType,Enemy),

        write(Enemy),nl,
        write('Health: '),write(EnemyHealth),nl,
        write('Type: '),write(EnemyType),nl,

        /* cetak data pokemon kita */
        curr_health(NumP,PickedPokemonHealth),
        type(TypePickedPokemon,PickedPokemon),

        nl,write(PickedPokemon),nl,
        write('Health: '),write(PickedPokemonHealth),nl,
        write('Type: '),write(TypePickedPokemon),nl,

        turnPlayer(NumP,PickedPokemon,Enemy),
        end_battle(NumP,PickedPokemon, Enemy).
/************************************************************************************************************/

end_battle(NumP,PickedPokemon,_Enemy) :-
    curr_health(NumP,Health),
    Health =< 0,
    drop(NumP),
    jml_inventory(N), N>0,
    retract(isSkillUsed_Self(NumP,_)),
    asserta(isSkillUsed_Self(NumP,0)),
    retract(turnStatus(_)),
    asserta(turnStatus(1)),
    retract(isEnemyAfterBattle(_)),
    asserta(isEnemyAfterBattle(1)),
    playerFaint(PickedPokemon),!.

end_battle(NumP,_PickedPokemon,_Enemy) :-
    curr_health(NumP,Health),
    Health =< 0,
    jml_inventory(N), N==0,!.

end_battle(NumP,_PickedPokemon,Enemy) :-
    enemy_health(Enemy,Health),
    Health =< 0,
    retract(isSkillUsed_Self(NumP,_)),
    asserta(isSkillUsed_Self(NumP,0)),
    retract(isSedangBertemuPokemon(_)),
    asserta(isSedangBertemuPokemon(0)),
    retract(turnStatus(_)),
    asserta(turnStatus(1)),
    retract(isBattle(_)),
    asserta(isBattle(0)),
    enemyFaint(Enemy),!.

playerFaint(SelfPokemon) :-
    write(SelfPokemon), write(' is defeated. Pick another Pokemon in your inventory'),nl,
    write('>> '),read(Input),
    playerIsDead(Input),!.

enemyFaint(Enemy) :-
    \+legendary(Enemy),
    write(Enemy), write(' is defeated. What will you do? [capture/move]'),nl,
    write('>> '),read(Input),
    enemyIsDead(Input,Enemy),!.

enemyFaint(Enemy) :-
    legendary(Enemy),
    retract(legendary(Enemy)),
    retract(totalLegendary(N)),
    N1 is N-1,
    asserta(totalLegendary(N1)),
    write(Enemy), write(' is defeated. What will you do? [capture/move]'),nl,
    write('>> '),read(Input),
    enemyIsDead(Input,Enemy),!.

playerIsDead(pick(X)) :- 
    pick(X), 
    battle(X),!.

enemyIsDead(w,_) :- isSedangBertemuPokemon(Status), Status == 0, atas, moveAllPokemon, printInfoLokasi, spawn,  !.
enemyIsDead(s,_) :- isSedangBertemuPokemon(Status), Status == 0, bawah,  moveAllPokemon, printInfoLokasi, spawn,  !.
enemyIsDead(a,_) :- isSedangBertemuPokemon(Status), Status == 0, kiri, moveAllPokemon, printInfoLokasi, spawn,  !.
enemyIsDead(d,_) :- isSedangBertemuPokemon(Status), Status == 0, kanan, moveAllPokemon, printInfoLokasi, spawn, !.
enemyIsDead(capture,Pokemon) :- jml_inventory(N),N<6,capture(Pokemon),write(Pokemon),write(' is now in your inventory!'),nl,!.
enemyIsDead(capture,Pokemon) :- 
    jml_inventory(N), N==6,
    write('Your inventory is full'),nl,
    write('Please drop one of your Pokemon'),nl,
    write('>> '), read(Input),
    dropDrop(Input,Pokemon),!.

dropDrop(drop(X),Pokemon) :- 
    drop(X), capture(Pokemon),
    write(Pokemon), write(' is now in your inventory!'),nl,!.