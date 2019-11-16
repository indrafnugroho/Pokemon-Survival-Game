:-include('variables.pl').
:-include('player.pl').

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
    Status is 1,
    asserta(isBattle(Status)),
    write('Pilih Pokemon mu!'),nl.

battle(PokemonPick) :-
    print('I choose you '), print(PokemonPick), nl,
    /* LANJUTAN: melakukan mekanisme battle (belum selesai) */
    !.

/* attack mechanism */
attack :- 
    battleNow(NamaPokemonFound),
    retract(health(NamaPokemonFound,H0)),
    choose(NamaPokemonKita),
    damage(NamaPokemonKita,D),
    H1 is H0-D,
    assert(health(NamaPokemonFound,H1)).
