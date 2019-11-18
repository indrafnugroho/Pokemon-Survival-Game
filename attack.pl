/* Modifier Attack */

modifier(P1,P2,NewDamage) :-
    damage(P1,Damage),
    type(T1,P1),
    type(T2,P2),
    \+superEffective(T1,T2),
    \+notEffective(T1,T2),
    NewDamage is Damage,!.

modifier(P1,P2,NewDamage) :-
    damage(P1,Damage),
    type(T1,P1),
    type(T2,P2),
    superEffective(T1,T2),
    \+notEffective(T1,T2),
    NewDamage is Damage+(Damage/2),!.

modifier(P1,P2,NewDamage) :-
    damage(P1,Damage),
    type(T1,P1),
    type(T2,P2),
    \+superEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage-(Damage/2),!.

modifierSkill(P1,P2,NewDamage,NameSkill) :-
    skill(P1,NameSkill,Damage),
    type(T1,P1),
    type(T2,P2),
    \+superEffective(T1,T2),
    \+notEffective(T1,T2),
    NewDamage is Damage,!.

modifierSkill(P1,P2,NewDamage,NameSkill) :-
    skill(P1,NameSkill,Damage),
    type(T1,P1),
    type(T2,P2),
    superEffective(T1,T2),
    \+notEffective(T1,T2),
    NewDamage is Damage+(Damage/2),!.

modifierSkill(P1,P2,NewDamage,NameSkill) :-
    skill(P1,NameSkill,Damage),
    type(T1,P1),
    type(T2,P2),
    \+superEffective(T1,T2),
    notEffective(T1,T2),
    NewDamage is Damage-(Damage/2),!.