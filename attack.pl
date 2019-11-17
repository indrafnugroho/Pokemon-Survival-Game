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
turnPlayer(1).

battle :-
    turnPlayer(TurnStatus),
    battleNow(TurnStatus),!.

turnPemain :-
    write('attack'),!.

battleNow(TurnStatus) :-
    pick(PokemonPick),
    print('I choose you '), print(PokemonPick), nl,
    TurnStatus =:= 1,
    turnPemain,
    retract(turnPlayer(TurnStatus)),
    NewTurnStatus is 0,
    asserta(turnPlayer(NewTurnStatus)),
    !.

battleNow(TurnStatus) :-
    TurnStatus =:= 0,
    turnEnemy,
    retract(turnPlayer(TurnStatus)),
    NewTurnStatus is 1,
    asserta(turnPlayer(NewTurnStatus)),
    !.

turnEnemy :-
    write('attack enemy'),!.

/* attack mechanism */
attack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(PokemonSerang,T1),
    type(PokemonDiSerang,T2),
    \x superEffective(T1,T2),
    \x notEffective(T1,T2),
    Health1 is Health0-Damage,
    assert(health(PokemonDiSerang,Health1)),!.

attack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(PokemonSerang,T1),
    type(PokemonDiSerang,T2),
    superEffective(T1,T2),
    \x notEffective(T1,T2),
    NewDamage is Damage + Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.

attack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(PokemonSerang,T1),
    type(PokemonDiSerang,T2),
    \x superEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage - Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.

specialAttack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    skill(PokemonSerang,Skill,Damage),
    type(PokemonSerang,T1),
    type(PokemonDiSerang,T2),
    \x superEffective(T1,T2),
    \x notEffective(T1,T2),
    Health1 is Health0-Damage,
    assert(health(PokemonDiSerang,Health1)),!.

specialAttack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    skill(PokemonSerang,Skill,Damage),
    type(PokemonSerang,T1),
    type(PokemonDiSerang,T2),
    superEffective(T1,T2),
    \x notEffective(T1,T2),
    NewDamage is Damage + Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.

specialAttack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    skill(PokemonSerang,Skill,Damage),
    type(PokemonSerang,T1),
    type(PokemonDiSerang,T2),
    \x superEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage - Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.