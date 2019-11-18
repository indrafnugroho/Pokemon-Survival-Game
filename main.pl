:- include('variables.pl').
:- include('Map_Eksploration.pl').
:- include('Show_Status.pl').
:- include('Show_Help.pl').
:- include('player.pl').
:- include('battle.pl').
:- include('attack.pl').
%:- include('saveload.pl').

start :-
	write('                                                   .//`                                           '),nl,
	write('                                                   `+yyyo.                                          '),nl,
	write('                                                 `/yy+:+sy-                                         '),nl,
	write('            `````                 `.-/+/++-     -syo//+so/-       `------.                          '),nl,
	write('      .-/+osssssssso/.       .-/+ssssyyyysyo-``ohyysyyo:.` -osssssyyyoooys     `-:-.``              '),nl,
	write('  `:+ssso+//::::///osyo-    /hyy+/::/syy+:/oys:+yysoooosss+yhyo///+ys::/sy.    /dyysssso+/.-.``     '),nl,
	write('.oyyo/:::::::::::::::+sy-   /hyyyo:::ss/::::+sys+::///::/+yyyy/:::/so:::+y/    :hyyo////oyyyssso+/:`'),nl,
	write('-hhyy/:::::::::++++:::+yo  `:oyhys:::/:::::+yyo::+o/os/:+syhys:::::+/:::+yo.:/+syhys::::/syy+://oyo`'),nl,
	write(' .yhyy+++:::::/ss/so::+ys/oooosyys:::::::+sooy/::s+++:/sssyhy+::::::::::/sysoo+/+osy+::::oys::::sy. '),nl,
	write('  `ohyyyyo:::::+s/so:/sys+/+/::/+ss:::::+ssosy+::/+/:+o+:/osyo::::::::::oy+/os/::+/oy+:::+y+:::+y/  '),nl,
	write('   `/+ohhy+:::::oo/:+sy+:/sy+//o:+yo:::::://osy+:::::::::/osy+::/s/::/:oy/:/sysos+:/yo:::/o:::/ys`  '),nl,
	write('      `odhy+:::::/+syys::/ossss/:/ys:/ss+/:::/ossso+++ossyyy+:::oys/os/sy:::/+o+/::+y+/+::::::sy-   '),nl,
	write('       `ydyy/::::+yyhyo::::///:::oy/:/syhyys+////+osyso+/dhy+///syysyy/oyo::::::::oy+:+o:::::oy/    '),nl,
	write('        .hdyy/:::/syhhy+:::::::/sys::/ss:oyhhyyo+//sy-` :yyyyyyyyhhyyyo/+sso++++sys/::so::::/ys`    '),nl,
	write('         -ddys::::oyyyhhsoo++osshys++oyo  `.:oyhhysyy.   ```..--.+hhdysooooyys+yhyo//+yo::::sy.     '),nl,
	write('          :ddys:::/sy-/oyyyys+-/yyssso+-      `.:oyhs.            `:ossyyyhhy. shyhyyyyo:::+y/      '),nl,
	write('           /ddyo/+oyy/  `````  `..```        `.-:/+o+/::-.`           ```..-.  `..--sdys+++yo``     '),nl,
	write('            omhysso+:`                   .:+ssyyyyyyysssoo++/-`                     -oyyhhhs::+:    '),nl,
	write('            `/:-.`                    `:oyhhhyyyyyyyssoo+//++oo+-`                     `.-:..::-    '),nl,
	write('                                    `/shhhhhhyyyyyyysso+/:-:/+osso:`                          `     '),nl,
	write('                                   -shhhhhhhhyyyyyyyssoo+///++ossyyo.                               '),nl,
	write('                                  :hhhhhhhhhhhyyyyyyyssssoooosssyyyys:                              '),nl,
	write('                                 :hdhhhhhhhhhhhyyyyyyyyyssssssyyyyyyyy:                             '),nl,
	write('                                .hddhhhhhhhhhhhhyyhhhyyyyyyyyyyyyyyyyyy.                            '),nl,
	write('                                odddhhhhhhhhhhhdmNNNNNNmhyyyyyyyyyyyhhh+                            '),nl,
	write('                                hdddddhhhhhhhdNMMNmdhdmMMNhyyyyyyhhhhhhy`                           '),nl,
	write('                                hNNmmmdddddddMMMms+/-..oNMNhhhhhddddmmNy                            '),nl,
	write('                                yNNMMMMMMMMMMMMNyyo+/-..yMMMMMMMMMMNNNmo                            '),nl,
	write('                                shhhhhhhhddddMMMdhyoo+++mMMyssso++//:--.                            '),nl,
	write('                                -hhhhhyyyyssodMMMNmddddNMNs.`````....--`                            '),nl,
	write('                                 /hhhhyyyysssoydNMMMMMMNd+.........---`                             '),nl,
	write('                                  /hhhyyyysssoooosyyyso/-----------::.                              '),nl,
	write('                                   :yhhyyyysssooo+++///:::::---:::::`                               '),nl,
	write('                                    `+yyyyyysssoooo++++/////:////:.                                 '),nl,
	write('                                      `/syyyyssssooooo++++++++//.                                   '),nl,
	write('                                         ./osyysssssooooooo+/-`                                     '),nl,
	write('                                             .-:///+///:-.`                                         '),nl,
    write('dr. Shark: Hello!'),nl,
    write('           Welcome to the world of Pokemon!'),nl,
    write('           Your mission is to defeat the legendary Pokemons roaming in this world'),nl,
    write('           Now, I will give you one of the three Pokemons from my lab to start your adventure'),nl,nl,
	chooseStarter,nl,
    write('Good luck! Hope you enjoy your adventure'),nl,nl,
	help,nl,
    status,nl,
    map,nl,

	repeat,
		write('>> '), /* Menandakan input */
		read(Input), /*Meminta input dari user */
		do(Input),nl,  /* Menjalankan do(Input) */
        end_condition.

/* control w-a-s-d cuman bisa jalan kalo player lagi gak ketemu pokemon atau player telah menyelesaikan battle atau run */
do(w) :- isSedangBertemuPokemon(Status), Status == 0, atas, printInfoLokasi, moveAllPokemon,  spawn, cekGym, !.
do(w) :- isSedangBertemuPokemon(Status), Status == 1, print('You can\'t do that'), cekGym,!.
do(s) :- isSedangBertemuPokemon(Status), Status == 0, bawah, printInfoLokasi, moveAllPokemon,  spawn, cekGym, !.
do(s) :- isSedangBertemuPokemon(Status), Status == 1, print('You can\'t do that'), cekGym,!.
do(a) :- isSedangBertemuPokemon(Status), Status == 0, kiri, printInfoLokasi, moveAllPokemon, spawn, cekGym, !.
do(a) :- isSedangBertemuPokemon(Status), Status == 1, print('You can\'t do that'),cekGym, !.
do(d) :- isSedangBertemuPokemon(Status), Status == 0, kanan, printInfoLokasi, moveAllPokemon,  spawn, cekGym,!.
do(d) :- isSedangBertemuPokemon(Status), Status == 1, print('You can\'t do that'), cekGym,!.

/* run dan battle hanya bisa dijalanin kalo player lagi ketemu pokemon */
do(run) :- 
    isSedangBertemuPokemon(Status), Status is 1,
    isBattle(StatusBattle), StatusBattle is 0,
    random(0,2,RandomValue), executeRun(RandomValue),!.
do(run) :- 
    isSedangBertemuPokemon(Status), Status is 0,
    isBattle(StatusBattle), StatusBattle is 1,
    print('You can\'t do that'),!.
do(battle) :- 
    isSedangBertemuPokemon(Status), Status is 1,
    pilihPokemon,
	!.
do(battle) :- 
    isSedangBertemuPokemon(Status), Status is 0,
    print('You can\'t do that'),!.

do(map) :- map,!.
do(status) :- status,!.
do(help) :- help,!.
do(heal) :- heal,!.
do(drop(X)) :- drop(X),!.

/* pick(X) gak bisa dijalanin kalo player lagi gak battle */
do(pick(X)) :- 
    asserta(isEnemyAfterBattle(0)),
    isBattle(Status), 
    Status is 1, 
    pick(X), 
    battle(X),!.
do(pick(_)) :- 
    isBattle(Status), 
    Status is 0,
    print('You can\'t do that! You are not in a fight now'),nl,!. 

do(quit) :- 
	write('Are you sure you wanna leave the game? [y/n]'),nl,
	write('>> '),read(X),!,end(X),!.
do(save) :- savegame, !.
do(load) :-loadgame,!.




do(_) :- print('You input the wrong command!'),nl,!.
do(fail) :- fail.


savegame:-
	open('savefile.txt',write,Save),
	totalLegendary(Total),
	write(Save,totalLegendary(Total)),write(Save,'.\n'),
	
	jml_inventory(JumInv),
	write(Save,jml_inventory(JumInv)), write(Save,'.\n'),
	
	posisiPlayer(X,Y),
	write(Save,posisiPlayer(X,Y)), write(Save,'.\n'),
	
	isHeal(HealStat),
	write(Save,isHeal(HealStat)), write(Save,'.\n'),

	idAv(List),
	write(Save,idAv(List)), write(Save,'.\n'),
	close(Save),

	findall(I,inventory(I),ListInvent),
	write_list_oneparam('savefile.txt',ListInvent,inventory),
	
	findall(I,inventory(I),ListInvent),
	write_list_oneparam('savefile.txt',ListInvent,inventory),
	
	findall(I,legendary(I),ListLegend),
	write_list_oneparam('savefile.txt',ListLegend,legendary),

	findall(D,damage(NamaD,D),ListDamage),
	findall(NamaD, damage(NamaD,D),ListNamaD),
	write_list_twoparam('savefile.txt',ListNamaD,ListDamage,damage),

	findall(Nama,health(Nama,H),ListNama),
	findall(H,health(Nama,H),ListHealth),
	write_list_twoparam('savefile.txt',ListNama,ListHealth,health),

	findall(Nama2,curr_health(Nama2,H2),ListNama2),
	findall(H2,curr_health(Nama2,H2),ListHealth2),
	write_list_twoparam('savefile.txt',ListNama2,ListHealth2,curr_health),

	findall(GX, gym(GX,GY), ListGX),
	findall(GY, gym(GX,GY), ListGY),
	write_list_twoparam('savefile.txt', ListGX, ListGY, gym),

	findall(NoIv, no_inventory(NoIv, IvPoke), ListNoIv),
	findall(IvPoke, no_inventory(NoIv, IvPoke), ListIvPoke),
	write_list_twoparam('savefile.txt', ListNoIv, ListIvPoke, no_inventory),

	findall(Idpos, posisiPokemon(Idpos, XX, YY),ListIdPos),
	findall(XX, posisiPokemon(Idpos, XX, YY), ListXX),
	findall(YY, posisiPokemon(Idpos,XX,YY), ListYY),
	write_list_threeparam('savefile.txt', ListIdPos, ListXX, ListYY, posisiPokemon).

/*Bagian rekursif untuk save game*/
writeData_One(_,[],_) :- !.
writeData_One(S,[X1|Tail],Name) :-
	write(S,Name),
	write(S,'('),
	write(S,X1),
	write(S,')'),
	write(S,'.'),
	nl(S),
	writeData_One(S,Tail,Name).

write_list_oneparam(NamaFile,L,Name) :-
	open(NamaFile,append,S),
	repeat,
	writeData_One(S,L,Name),
	close(S).

writeData_three(_,[],[],[],_) :- !.
writeData_three(S,[X1|Tail1],[X2|Tail2],[X3|Tail3],Name) :-
	write(S,Name),
	write(S,'('),
	write(S,(X1,X2,X3)),
	write(S,')'),
	write(S,'.'),
	nl(S),
	writeData_three(S,Tail1,Tail2,Tail3,Name).

write_list_threeparam(NamaFile,L1,L2,L3,Name) :-
	open(NamaFile,append,S),
	repeat,
	writeData_three(S,L1,L2,L3,Name),
	close(S).

writeData_two(_,[],[],_) :- !.
writeData_two(S,[X1|Tail1],[X2|Tail2],Name) :-
	write(S,Name),
	write(S,'('),
	write(S,(X1,X2)),
	write(S,')'),
	write(S,'.'),
	nl(S),
	writeData_two(S,Tail1,Tail2,Name).

write_list_twoparam(NamaFile,L1,L2,Name) :-
	open(NamaFile,append,S),
	repeat,
	writeData_two(S,L1,L2,Name),
	close(S).

/*Bagian Load Game*/
loadgame:-
	totalLegendary(Total),
	jml_inventory(JumInv),
	posisiPlayer(X,Y),
	isHeal(HealStat),
	idAv(List),
	retractall(idAv(List)),
	retractall(isHeal(HealStat)),
	retractall(posisiPlayer(X,Y)),
	retractall(jml_inventory(JumInv)),
	retractall(totalLegendary(Total)),
	remove_all_invent,
	remove_all_legend,
	remove_all_damage,
	remove_all_health,
	remove_all_curr_health,
	remove_all_gym,
	remove_all_no_invent,
	remove_all_pos_pokemon,
	open('savefile.txt',read,Load),
	load_all(Load),
	close(Load).

/*Rule pendukung untuk load game*/
remove_all_invent :-
	inventory(_),retractall(inventory(_)),!.
remove_all_invent :-!.

remove_all_legend :-
	legendary(_),retractall(legendary(_)),!.
remove_all_legend :-!.

remove_all_damage :-
	damage(_,_),retractall(damage(_,_)),!.
remove_all_damage :-!.

remove_all_health :-
	health(_,_),retractall(health(_,_)),!.
remove_all_health :-!.

remove_all_curr_health :-
	curr_health(_,_),retractall(curr_health(_,_)),!.
remove_all_curr_health:-!.

remove_all_gym :-
	gym(_,_),retractall(gym(_,_)),!.
remove_all_gym :-!.

remove_all_no_invent :-
	no_inventory(_,_),retractall(no_inventory(_,_)),!.
remove_all_no_invent :-!.

remove_all_pos_pokemon :-
	posisiPokemon(_,_,_),retractall(posisiPokemon(_,_,_)),!.
remove_all_pos_pokemon :-!.

load_all(Load):-
	repeat,
		read(Load,L),
		asserta(L),
		at_end_of_stream(Load).

end('n') :-
	write('Please continue your adventure, trainer!'),nl,!.
end(y) :- halt,!.

end_condition :-
	jml_inventory(0),!,
	write('dr. Shark: Ho ho ho. You have failed to complete the missions.'),nl,
	write('As for now, meet your fate and disappear from this world!'),nl,end(y),!.
end_condition :-
  	totalLegendary(0), !,
  	write('dr. Shark: Congratulation!!! You have helped me in defeating or capturing the 2 Legendary Pokemons.'),nl,
 	write('As promised, I won\'t kill you and you\'re free!'),nl,end(y),!.


