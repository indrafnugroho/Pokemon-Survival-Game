/* Pemain */
jml_inventory(0).
max_inventory(6).
posisiPlayer(1,1).

/* Inventory */
add_inv([],X,[X]).
add_inv([H|T],H,[H|T]).
add_inv([Z|T1],X,[Z|T2]):- add_inv(T1,X,T2),!.

del_inv([X],X,[]).
del_inv([Z|T1],X,[Z|T2]) :- del_inv(T1,X,T2),!.

catch(X) :-
    pokemon(Y,X),
    inventory(I),
    jml_inventory(N).
    N1 is N+1,
    retract(jml_inventory(N)),
    asserta(jml_inventory(N1)),
    max_inventory(N1),
    add_inv(I,X,I2),!.


throw(X) :- pokemon(Y,X),
            inventory(I),
            jml_inventory(N),
            N1 is N-1,
            retract(jml_inventory(N)),
            asserta(jml_inventory(N1)).
            del_inv(I,X,I2).

/* gym center */
heal(X) :- pokemon(Y,X),
            findall(X,inventory(X),ListInventory),
            posisiPlayer(A,B),
            gym(A,B),
            curr_health(X,H),
            health(X,HH),
            retract(curr_health(X,H)),
            asserta(curr_health(X,HH)).

/* fail state */
fail(X) :- jml_inventory(0),!.
