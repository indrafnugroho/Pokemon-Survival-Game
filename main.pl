:- include('variables.pl').
:- include('Map_Eksploration.pl').
:- include('Show_Status.pl').
:- include('Show_Help.pl').

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
    repeat,
		write('>> '), /* Menandakan input */
		read(Input),nl, /*Meminta input dari user */
		do(Input),nl, fail. /* Menjadlankan do(Input) */


do(w) :- atas, moveAllPokemon, spawn, !.
do(s) :- bawah,  moveAllPokemon, spawn, !.
do(a) :- kiri, moveAllPokemon, spawn, !.
do(d) :- kanan, moveAllPokemon, spawn, !.
do(map) :- map.
do(status) :- status.
do(help) :- help.
