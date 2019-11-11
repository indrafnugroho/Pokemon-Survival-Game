:-include('variables.pl').
:-include('player.pl').

/* attack mechanism */
attack :- 
    battleNow(NamaPokemonFound),
    retract(health(NamaPokemonFound,H0)),
    choose(NamaPokemonKita),
    damage(NamaPokemonKita,D),
    H1 is H0-D,
    assert(health(NamaPokemonFound,H1)).
