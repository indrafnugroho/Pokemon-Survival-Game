/*Kumpulan rule untuk save game*/
savegame:-
	open('savefile.txt',write,Save),
	name(Nama_User),
	write(Save,name(Nama_User)),write(Save,'.'),nl(Save),
	difficulty(Level),
	write(Save,difficulty(Level)),write(Save,'.'),nl(Save),
	armor(Nama_Arm),
	write(Save,armor(Nama_Arm)),write(Save,'.'),nl(Save),
	health(Heal),
	write(Save,health(Heal)),write(Save,'.'),nl(Save),
	equip(Eq),
	write(Save,equip(Eq)),write(Save,'.'),nl(Save),
	currLoc(X,Y),
	write(Save,currLoc(X,Y)),write(Save,'.'),nl(Save),
	ammo(Nama,Amunisi),
	write(Save,ammo(Nama,Amunisi)),write(Save,'.'),nl(Save),
	totalenemy(Jumlah),
	write(Save,totalenemy(Jumlah)),write(Save,'.'),nl(Save),
	disDeadzone(Dead),
	write(Save,disDeadzone(Dead)),write(Save,'.'),nl(Save),
	langkah(L),
	write(Save,langkah(L)),write(Save,'.'),nl(Save),
	maxinventory(Max),
	write(Save,maxinventory(Max)),write(Save,'.'),nl(Save),
	close(Save),
	findall(I,inventory(I),ListInvent),
	write_list_oneparam('savefile.txt',ListInvent,inventory),
	findall(Nama_Object,objLoc(Nama_Object,OX,OY),ListObj),
	findall(OX,objLoc(Nama_Object,OX,OY),ListObjX),
	findall(OY,objLoc(Nama_Object,OX,OY),ListObjY),
	write_list_threeparam('savefile.txt',ListObj,ListObjX,ListObjY,objLoc),
	findall(Nama_Enemy,enemyLoc(Nama_Enemy,EX,EY),ListEnemy),
	findall(EX,enemyLoc(Nama_Object,EX,EY),ListEnemyX),
	findall(EY,enemyLoc(Nama_Object,EX,EY),ListEnemyY),
	write_list_threeparam('savefile.txt',ListEnemy,ListEnemyX,ListEnemyY,enemyLoc),
	findall(Dx,deadzone(Dx,Dy),ListDzoneX),
	findall(Dy,deadzone(Dx,Dy),ListDzoneY),
	write_list_twoparam('savefile.txt',ListDzoneX,ListDzoneY,deadzone).


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
	health(H),
	armor(A),
	currLoc(Px,Py),
	equip(Eq),
	name(N),
	ammo(Nammo,Mag),
	totalenemy(E),
	difficulty(L),
	disDeadzone(D),
	langkah(S),
	maxinventory(Max),
	retractall(langkah(S)),
	retractall(maxinventory(Max)),
	retractall(difficulty(L)),
	retractall(disDeadzone(D)),
	retractall(health(H)),
	retractall(armor(A)),
	retractall(currLoc(Px,Py)),
	retractall(equip(Eq)),
	retractall(name(N)),
	retractall(ammo(Nammo,Mag)),
	retractall(totalenemy(E)),
	remove_all_obj,
	remove_all_deadzone,
	remove_all_invent,
	remove_all_enemies,
	open('savefile.txt',read,Load),
	load_all(Load),
	close(Load).

/*Rule pendukung untuk load game*/
remove_all_obj :-
	objLoc(_,_,_),retractall(objLoc(_,_,_)),!.
remove_all_obj :- !.

remove_all_deadzone :-
	deadzone(_,_),retractall(deadzone(_,_)),!.
remove_all_deadzone:-!.

remove_all_invent :-
	inventory(_),retractall(inventory(_)),!.
remove_all_invent :-!.

load_all(Load):-
	repeat,
		read(Load,L),
		asserta(L),
		at_end_of_stream(Load).