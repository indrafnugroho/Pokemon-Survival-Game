:-include('variables.pl').
:-include('player.pl').

:- dynamic(turnPlayer/1).

/* ***************** Rules when player meet Pokemon ******************** */
executeRun/1.
battle/0.

executeRun(RandomValue) :-
    RandomValue is 1,
    print('Kamu berhasil lari dari Pokemon'),
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
    TurnStatus is 1,
    turnPemain,
    retract(turnPlayer(TurnStatus)),
    NewTurnStatus is 0,
    asserta(turnPlayer(NewTurnStatus)),
    !.

battleNow(TurnStatus) :-
    TurnStatus is 0,
    turnEnemy,
    retract(turnPlayer(TurnStatus)),
    NewTurnStatus is 1,
    asserta(turnPlayer(NewTurnStatus)),
    !.

turnEnemy :-
    write('attack enemy'),!.

/* attack mechanism */
attack(PokemonSerang,PokemonDiSerang) :- 
    retract(health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    Health1 is Health0-Damage,
    assert(health(PokemonDiSerang,Health1)).
