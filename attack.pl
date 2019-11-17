/* attack mechanism */
do_attack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    \+superEffective(T1,T2),
    \+notEffective(T1,T2),
    Health1 is Health0-Damage,
    assert(curr_health(PokemonDiSerang,Health1)),
    nl,print(PokemonSerang),print(' dealt '),print(Damge),print(' to PokemonDiSerang'),
    !.

do_attack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    superEffective(T1,T2),
    \+notEffective(T1,T2),
    NewDamage is Damage + Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(curr_health(PokemonDiSerang,Health1)),
    nl,print(PokemonSerang),print(' dealt '),print(Damge),print(' to PokemonDiSerang'),
    !.

do_attack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    damage(PokemonSerang,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    \+superEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage - Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(curr_health(PokemonDiSerang,Health1)),
    nl,print(PokemonSerang),print(' dealt '),print(Damge),print(' to PokemonDiSerang'),
    !.

do_specialAttack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    skill(PokemonSerang,Skill,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    \+superEffective(T1,T2),
    \+notEffective(T1,T2),
    Health1 is Health0-Damage,
    assert(health(PokemonDiSerang,Health1)).

do_specialAttack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    skill(PokemonSerang,Skill,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    superEffective(T1,T2),
    \+notEffective(T1,T2),
    NewDamage is Damage + Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.

do_specialAttack(PokemonSerang,PokemonDiSerang) :- 
    retract(curr_health(PokemonDiSerang,Health0)),
    skill(PokemonSerang,Skill,Damage),
    type(T1,PokemonSerang),
    type(T2,PokemonDiSerang),
    \+superEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage - Damage*0.5,
    Health1 is Health0-NewDamage,
    assert(health(PokemonDiSerang,Health1)),!.