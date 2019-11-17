/* ***************** Rules when player meet Pokemon ******************** */
executeRun/1.
battle/0.

:-dynamic(enemy_health/2).
:-dynamic(isSkillUsed_Enemy/1).
:-dynamic(isEnemyAfterBattle/1).
isSkillUsed_Enemy(0).

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
turnPlayer(NumP,PickedPokemon,Enemy) :-
    turnStatus(X),
    X == 1,
    turnPemain(NumP,PickedPokemon,Enemy),
    retract(turnStatus(Old)),
    asserta(turnStatus(0)),
    !.

/* turn enemy */
turnPlayer(NumP,PickedPokemon,Enemy) :-
    turnStatus(X),
    X == 0,
    turnEnemy(NumP,PickedPokemon,Enemy),
    retract(turnStatus(Old)),
    asserta(turnStatus(1)),
    !.      

turnPemain(NumP,PickedPokemon,Enemy) :-
    nl,print('-> '),
    read(X),
    commandPlayer(X,NumP,PickedPokemon,Enemy),
    nl,!.

turnEnemy(NumP,PickedPokemon,Enemy) :-
    damage(Enemy,Damage),
    type(T1,Enemy),
    type(T2,PickedPokemon),
    \+superEffective(T1,T2),
    \+notEffective(T1,T2),
    retract(curr_health(NumP,Health0)),
    Health1 is Health0-Damage,
    asserta(curr_health(NumP,Health1)),
    nl,print(Enemy),print(' dealt '),print(Damage),print(' to '), print(PickedPokemon),nl,
    !.

turnEnemy(NumP,PickedPokemon,Enemy) :-
    damage(Enemy,Damage),
    type(T1,Enemy),
    type(T2,PickedPokemon),
    superEffective(T1,T2),
    \+notEffective(T1,T2),
    NewDamage is Damage+(Damage/2),
    retract(curr_health(NumP,Health0)),
    Health1 is Health0-NewDamage,
    asserta(curr_health(NumP,Health1)),
    nl,print(Enemy),print(' dealt '),print(NewDamage),print(' to '), print(PickedPokemon),nl,
    !.

turnEnemy(NumP,PickedPokemon,Enemy) :-
    damage(Enemy,Damage),
    type(T1,Enemy),
    type(T2,PickedPokemon),
    \+superEffective(T1,T2),
    notEffective(T1,T2),
    retract(curr_health(NumP,Health0)),
    NewDamage is Damage-(Damage/2),
    Health1 is Health0-Damage,
    asserta(curr_health(NumP,Health1)),
    nl,print(Enemy),print(' dealt '),print(NewDamage),print(' to '), print(PickedPokemon),nl,
    !.

commandPlayer(specialAttack,NumP,PickedPokemon,Enemy) :-
    isSkillUsed_Self(NumP,N), N==0,
    skill(PickedPokemon,NameSkill,Damage),
    type(T1,PickedPokemon),
    type(T2,Enemy),
    \+superEffective(T1,T2),
    \+notEffective(T1,T2),
    retract(enemy_health(Enemy,Health0)),
    Health1 is Health0-Damage,
    asserta(enemy_health(Enemy,Health1)),
    nl,print(PickedPokemon),print(' used '),print(NameSkill),print(' to '),print(Enemy),write('!'),nl,
    retract(isSkillUsed_Self(NumP,OldN)),
    asserta(isSkillUsed_Self(NumP,1)),
    !.

commandPlayer(specialAttack,NumP,PickedPokemon,Enemy) :-
    isSkillUsed_Self(NumP,N), N==0,
    skill(PickedPokemon,NameSkill,Damage),
    type(T1,PickedPokemon),
    type(T2,Enemy),
    superEffective(T1,T2),
    \+notEffective(T1,T2),
    retract(enemy_health(Enemy,Health0)),
    NewDamage is Damage + (Damage/2),
    Health1 is Health0-NewDamage,
    asserta(enemy_health(Enemy,Health1)),
    nl,print(PickedPokemon),print(' used '),print(NameSkill),print(' to '),print(Enemy),write('!'),nl,
    retract(isSkillUsed_Self(NumP,OldN)),
    asserta(isSkillUsed_Self(NumP,1)),
    !.

commandPlayer(specialAttack,NumP,PickedPokemon,Enemy) :-
    isSkillUsed_Self(NumP,N), N==0,
    skill(PickedPokemon,NameSkill,Damage),
    type(T1,PickedPokemon),
    type(T2,Enemy),
    \+superEffective(T1,T2),
    notEffective(T1,T2),
    retract(enemy_health(Enemy,Health0)),
    NewDamage is Damage - (Damage/2),
    Health1 is Health0-NewDamage,
    asserta(enemy_health(Enemy,Health1)),
    nl,print(PickedPokemon),print(' used '),print(NameSkill),print(' to '),print(Enemy),write('!'),nl,
    retract(isSkillUsed_Self(NumP,OldN)),
    asserta(isSkillUsed_Self(NumP,1)),
    !.

commandPlayer(attack,NumP,PickedPokemon,Enemy) :-
    damage(PickedPokemon,Damage),
    type(T1,PickedPokemon),
    type(T2,Enemy),
    \+superEffective(T1,T2),
    \+notEffective(T1,T2),
    retract(enemy_health(Enemy,Health0)),
    Health1 is Health0-Damage,
    asserta(enemy_health(Enemy,Health1)),
    nl,print(PickedPokemon),print(' dealt '),print(Damage),print(' to '), print(Enemy),nl,
    !.

commandPlayer(attack,NumP,PickedPokemon,Enemy) :-
    damage(PickedPokemon,Damage),
    type(T1,PickedPokemon),
    type(T2,Enemy),
    superEffective(T1,T2),
    \+notEffective(T1,T2),
    NewDamage is Damage + (Damage/2),
    retract(enemy_health(Enemy,Health0)),
    Health1 is Health0-NewDamage,
    asserta(enemy_health(Enemy,Health1)),
    nl,print(PickedPokemon),print(' dealt '),print(NewDamage),print(' to '),print(Enemy),
    !.

commandPlayer(attack,NumP,PickedPokemon,Enemy) :-
    damage(PickedPokemon,Damage),
    type(T1,PickedPokemon),
    type(T2,Enemy),
    \+superEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage - (Damage/2),
    retract(enemy_health(Enemy,Health0)),
    Health1 is Health0-NewDamage,
    asserta(enemy_health(Enemy,Health1)),
    nl,print(PickedPokemon),print(' dealt '),print(NewDamage),print(' to '),print(Enemy),
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
    write('I choose you '), write(PickedPokemon), nl,
    battleNow(Enemy),
    enemy_health(Enemy,HEnemy0),
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
/************************************************************************************************************/

end_battle(NumP,PickedPokemon,Enemy) :-
    curr_health(NumP,Health),
    Health =< 0,
    drop(NumP),
    jml_inventory(N), N>0,
    retract(isSkillUsed_Self(NumP,OldNum)),
    asserta(isSkillUsed_Self(NumP,0)),
    retract(turnStatus(Old2)),
    asserta(turnStatus(1)),
    retract(isEnemyAfterBattle(Old3)),
    asserta(isEnemyAfterBattle(1)),
    playerFaint(PickedPokemon),!.

end_battle(NumP,PickedPokemon,Enemy) :-
    curr_health(NumP,Health),
    Health =< 0,
    jml_inventory(N), N==0,!.

end_battle(NumP,PickedPokemon,Enemy) :-
    enemy_health(Enemy,Health),
    Health =< 0,
    retract(isSkillUsed_Self(NumP,OldNum)),
    asserta(isSkillUsed_Self(NumP,0)),
    retract(isSedangBertemuPokemon(Old)),
    asserta(isSedangBertemuPokemon(0)),
    retract(turnStatus(Old2)),
    asserta(turnStatus(1)),
    retract(isBattle(Old3)),
    asserta(isBattle(0)),
    enemyFaint(Enemy),!.

playerFaint(SelfPokemon) :-
    write(SelfPokemon), write(' is defeated. Pick another Pokemon in your inventory'),nl,
    read(Input),
    playerIsDead(Input),!.

enemyFaint(Enemy) :-
    write(Enemy), write(' is defeated. What do you wanna do? [capture/move]'),nl,
    read(Input),
    enemyIsDead(Input,Enemy),!.

playerIsDead(pick(X)) :- 
    pick(X), 
    battle(X),!.

enemyIsDead(w,Pokemon) :- isSedangBertemuPokemon(Status), Status == 0, atas, moveAllPokemon, map, spawn,  !.
enemyIsDead(s,Pokemon) :- isSedangBertemuPokemon(Status), Status == 0, bawah,  moveAllPokemon, map, spawn,  !.
enemyIsDead(a,Pokemon) :- isSedangBertemuPokemon(Status), Status == 0, kiri, moveAllPokemon, map, spawn,  !.
enemyIsDead(d,Pokemon) :- isSedangBertemuPokemon(Status), Status == 0, kanan, moveAllPokemon, map, spawn, !.
enemyIsDead(capture,Pokemon) :- capture(Pokemon),!.