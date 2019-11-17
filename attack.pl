:- dynamic(turnPlayer/1).

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

/* Battle */
:- dynamic(turnPlayer/1).
:- dynamic(isBattleSelesai/1).
:- dynamic(battleNow/1).

battleNow(1).
turnPlayer(1).
isBattleSelesai(0).

battleNow(TurnStatus) :-
    pick(PokemonPick),
    print('I choose you '), print(PokemonPick), nl,
    TurnStatus =:= 1,
    turnPemain,
    retract(turnPlayer(TurnStatus)),
    NewTurnStatus is 0,
    asserta(turnPlayer(NewTurnStatus)),
    battleNow(NewTurnStatus),
    !.

battleNow(TurnStatus) :-
    TurnStatus =:= 0,
    turnEnemy,
    retract(turnPlayer(TurnStatus)),
    NewTurnStatus is 1,
    asserta(turnPlayer(NewTurnStatus)),
    !.

/* attack mechanism */
attack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    \xsuperEffective(T1,T2),
    \xnotEffective(T1,T2),
    Health1 is Health0-Damage,
    assert(health(PokemonDiSerang,Health1)),!.

attack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    superEffective(T1,T2),
    \xnotEffective(T1,T2),
    NewDamage is Damage + Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.

attack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    \xsuperEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage - Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.

battle :-
    /* battle akan akan terus bergirilir sampai kondisi StatusSelesai bernilai 1 */
    print('hehe'),
    repeat,
        turnPlayer(TurnStatus),
        battleNow(TurnStatus),
        isBattleSelesai(StatusSelesai),
        StatusSelesai == 1,
        !.

turnPemain :-
    write('attack'),nl,!.

turnEnemy :-
    write('attack enemy'),nl,
    retract(isBattleSelesai(OldStatusSelesai)),
    1 is NewStatusSelesai,
    asserta(isBattleSelesai(NewStatusSelesai)),
    !.
    assert(health(PokemonDiSerang,Health1)),!.

specialAttack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    skill(PokemonSerang,Skill,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    \xsuperEffective(T1,T2),
    \xnotEffective(T1,T2),
    Health1 is Health0-Damage,
    assert(health(PokemonDiSerang,Health1)).

specialAttack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    skill(PokemonSerang,Skill,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    superEffective(T1,T2),
    \xnotEffective(T1,T2),
    NewDamage is Damage + Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.

specialAttack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    skill(PokemonSerang,Skill,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    \xsuperEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage - Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.
