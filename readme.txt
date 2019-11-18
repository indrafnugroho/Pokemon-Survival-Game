                           			POKEMON SURVIVAL SIMULATOR
Kelompok 12 K01
13518016 - Indra Febrio Nugroho
13518058 - Taufiq Husada D
13518100 - Kevin Rizki M
13518142 - Dwiani Yulia A

Permasalahan Permainan
Permainan survival role-playing dengan bertemakan Pokemon.

1. Pemain
Pemain merupakan seorang Pokemon Trainer. Pemain ini memiliki  Pokeball yang jumlahnya infinity  untuk menangkap  Pokemon.  
Saat  awal  permainan,  pemain  sudah  memiliki Pokemon starter dengan jenis Pokemon Normal.
Daftar semua Pokemon yang telah ditangkap selama  permainan berlangsung dapat disimpan dalam sebuah inventori dengan batas maksimal enam Pokemon.  Jika  pemain  ingin menangkap  Pokemon  setelah  inventori  penuh,  pemain 
harus membuang salah satu Pokemon yang ia miliki untuk diganti dengan yang ingin ia tangkap.

2. Map
Ukuran  peta  permainan 10x10.  Player  direpresentasikan  pada  layar dengan simbol P. Peta dapat di-print ke layar. Pada pinggir-pinggir peta, terdapat pagar yang disimbolkan dengan huruf ‘X’ dan peserta tidak diperbolehkan untuk menempati atau melewati batas ‘X’ tersebut. Selain itu, terdapat sebuah gym yang disimbolkan dengan huruf ‘G’.

3. Pokemon
Terdapat dua jenis Pokemon yaitu Normal Pokemon dan Legendary Pokemon. Normal Pokemon akan muncul secara acak pada petak dalam map. Sedangkan Legendary Pokemon akan muncul secara acak pada petak dalam map dengan jumlah minimal dua dan lebih kuat dari Normal Pokemon. 

Pokemon memiliki atribut-atribut sebagai berikut, yaitu:
	a.Health : merupakan jumlah nyawa atau hp yang dimiliki Pokemon itu.
	b.Tipe : terdapat tiga tipe Pokemon (fire, water, leaves).
	c.Normal Attack : value of damage dalam angka dari Pokemon yang akan dikerjakan saat Pokemon melakukan normal attack.
	d.Special Attack atau skill : value of damage dalam angka dari Pokemon yang  akan  dikerjakan  saat  Pokemon  menggunakan skill dan skill ini dapat digunakan hanya sekali dalam tiap pertarungan dengan Pokemon lain. Jumlah skill damage lebih besar dari normal attack. 
	e. Level (Untuk starter Pokemon)

Pokemon starter dapat melakukan mekanisme Level Up (<=3) dan saat Pokemon level 3, Pokemon tersebut dapat Evolve

4. Mekanisme Eksplorasi
Pemain dapat berpindah sebanyak 1 sel pada peta dengan arah sesuai mata angin. Pemain  akan  memiliki  peluang  khusus  untuk bertemu  dengan  seekor  Pokemon  saat  pemain  berpindah  tempat.  Implementasi peluang   berupa  random number  generator. Pokemon  yang  dapat  berkeliaran  di  dalam  map  namun tidak  ditampilkan. Peluang bertemu dengan legendary Pokemon lebih kecil dibanding peluang bertemu dengan Pokemon yang biasa saja. Jika pemain bertemu dengan Pokemon di pada petak yang sama, permainan akan menampilkan informasi ( misal : “a wild Icanmon appears!” ) lalu menampilkan info  Pokemon  yang  baru  saja  ditemukan  pemain  tersebut  seperti  nyawa,  level, damage,  dan  tipe  Pokemon  tersebut.Setelah  itu  permainan  akan  masuk  ke Battle Phase.

5. Mekanisme Battle
Setelah  game  menampilkan  informasi  mengenai  Pokemon  yang  ditemukan pemain,  pemain  akan  memiliki  pilihan  untuk  mencoba  mengalahkan  Pokemon tersebut (fight!) atau lari (run!), akan ada peluang gagal jika pemain memilih untuk lari.

Jika pemain memilih untuk bertarung, pemain akan memilih seekor Pokemon dari  inventorinya  yang  akan  digunakan  untuk  bertarung.  Setelah  pemain  memilih Pokemon  yang  akan  digunakan,  pemain  akan  masuk  ke  fase  utama  battle,fase  ini terbagi menjadi dua bagian yaitu bagian (turn)pemain dan bagian musuh. Pada bagian pemain, pemain dapat memilih untuk melakukan serangan biasa dimana health musuh  akan  berkurang  sebanyak  damage  yang  dimiliki  Pokemon pemain atau pemain dapat memilih untuk menggunakan skill yang dimiliki Pokemon pemain.  Skill  hanya  dapat  digunakan  sekali  saja  untuk  setiap  pertarungan  dengan Pokemon yang lain. Pada bagian musuh, Pokemon musuh dapat melakukan aksi-aksi yang  boleh  dilakukan  oleh  pemain  di  atas. 

Saat Pokemon menyerang Pokemon lain, akan ada modifier khusus yang dapat mengurangi   atau   menambah damage Pokemon   tersebut. Modifier tersebut disesuaikan  dengan  tipe  Pokemon  pemain  dan  Pokemon  musuh,  rule  modifier tersebut adalah sebagai berikut (berlaku untuk normal attack dan penggunaan special attack/skill)  :
	a.Super effective : 50% lebih besar dari damage biasa
	b.Not Effective : 50% lebih kecil dari damage biasa

Jika pemain sudah berhasil mengalahkan Pokemon musuh, pemain akan diberi pilihan  untuk  menangkap  Pokemon  atau  tidak  (jika  inventori  sudah  penuh,  pemain dapat mengganti salah satu Pokemon yang sudah ia miliki dengan Pokemon baru). Jika  tidak  ingin  menangkap Pokemon  tersebut  cukup  berpindah  tempat  saja.  Jika Pokemon yang pemain pilih kalah dalam battle, Pokemon tersebut harus dihapus dari inventori dan pemain akan memiliki kesempatan untuk memilih Pokemon lain dalam inventorinya hingga Pokemon di dalam inventori pemain habis (Game Over).

6. Gym Center
Merupakan  tempat  persinggahan  pemain  untuk  menyembuhkan  Pokemon yang terluka. Pokemon yang dapat disembuhkan hanya Pokemon yang masih hidup pada  inventori  pemain. Pemain  hanya  dapat  menyembuhkan  Pokemon  sekali dalam permainan.

7. Fail State
Pemain  dinyatakan  kalah  bila  semua  Pokemon  di  dalam  inventorinya  sudah mati.  Pokemon  itu  dikatakan  mati  bila  Pokemon  pernah  kalah  dalam  sebuah pertarungan  melawan  Pokemon  lain  dan Pokemon  ini  harus  segera  terhapus  dari inventori.

8. Goal State
Pemain   dinyatakan   menang   apabila   pemain   telah   mengalahkan   semua Legendary Pokemon yang berada di dalam permainan.

9. Command
	a.Start /0 : memulai permainan, menampilkan judul dan instruksi permainan.
	b.Help /0 : menampilkan fungsi-fungsi yang dapat dipanggil dalam permainan, dapat mengandung informasi lain yang mungkin dibutuhkan (legenda).
	c.Quit /0 : mengakhiri permainan..
	d.w /0, s /0, a /0, d /0 : menggerakkan pemain dari satu petak ke petak lain sesuai dengan ketentuan sebagai berikut (w = atas, s = bawah, a = kiri, d = kanan).
	e.Map /0 : mencetak peta permainan saat ini beserta lokasi pemain, dan gym.  
	f.Heal /0 : mengobati semua Pokemon yang ada di inventori pemain. Command hanya bisa dipanggil bila player berada di atau menempati lokasi gym center ‘G’.
	g.Status /0 : menampilkan isi serta informasi dari  inventori player saat ini dan legendary Pokemon yang masih harus dikalahkan untuk memenangkan permainan.
	h.Pick /1 : Memilih Pokemon untuk digunakan (hanya dapat dilakukan dalam battle)
	i.Attack /0 : Melakukan Normal attack (hanya dapat digunakan dalam battle)
	j.specialAttack /0 : Melakukan Special attack pada musuh (hanya dapat dilakukan dalam battle)
	k.Run /0 : Memilih untuk lari (hanya dapat dilakukan dalam battle)
	l.Drop/1 : Menghilangkan pokemon dari inventori
	m.Save/0 : menyimpan state game
	n.Load/0 : memuat state game yang pernah disimpan
