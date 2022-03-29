/*======================================= GAME MODE versiГіn 4.02 ==========================================
										Гєltima actualizaciГіn: desconocido
	Creditos:
			В» Cesar Smith
            В» Nobody[x]
            В» pablobl[X]
            В» Jefferson
            В» AlexisFlop

===========================================================================================================																																							*/

#include <a_samp>
#include <crashdetect>
#include <a_actor>
#include <JunkBuster>
#include <jadmin3>
#include <sscanf2>
#include <foreach>
#include <zcmd>
#include <YSI\y_iterate> 	
#include <YSI\y_flooding> 	
#include <YSI\y_va> 		
#include <YSI\y_colors> 		
#include <YSI\y_utils> 			
#include <progress2>	 	
#include <fader> 			
#include <textdraws>
#include <gangzones>			
#include <a_OPSVP> 				
#include <OnPlayerPause> 	
#include <geolocation>			
//DIRECTIVAS
#define v                     "v5"
#define gpversion             v5
#define REBORN                true
//REQUISITO/SCORE POR TEAM
#define SCORES_BALLAS         50
#define SCORES_AZTECAS        300
#define SCORES_NANG           700
#define SCORES_MILITARES      1500
#define SCORES_TRAFICANTES    4500
#define SCORES_VAGABUNDOS     8000
//COLORES
#define COLOR_RED             0xE40000FF
#define COLOR_YELLOW          0xFFFF02FF
#define COLOR_GREEN           0x35E400FF
#define COLOR_WHITE           0xFFFFFFFF
#define COLOR_BLACK           0x000000FF
//COLORES EN HTML
#define white 		  		  "{FFFFFF}"
#define lighblue     		  "{A9C4E4}"
#define red                   "{CC0066}"
#define blue                  "{66FFFF}"
#define green                 "{66FF99}"
#define grey 		          "{A4A3A6}"
#define yellow 		          "{F5C434}"
#define orange 		          "{EC5500}"
#define lime 		          "{B7FF00}"
#define cyan 		          "{00FFEE}"
#define purple 		          "{4921F2}"
#define pink 		          "{FF00EA}"
#define brown 		          "{A90202}"
//DIALOGOSID
#define	DIALOG_ZONES          200
#define	DIALOG_TEAMS          201
//CONQUISTAS
//ГЌNDICE MГЃXIMO DE EQUIPOS
#define MAX_TEAMS             6
//TIEMPO NECESARIO PARA CONQUISTAR
#define STARTUP_TIME    	  100
//MIEMBROS NECESARIOS PARA CONQUISTAR
#define STARTUP_MEMBERS    	  4
//ASESINATOS NECESARIOS PARA CONQUISTAR
#define STARTUP_KILLS         4
//TIEMPO TOTAL PARA CONQUISTAR
#define TURFWAR_TIME          160
//FUNCIONES            
#define SPAO{%0,%1,%2,%3,%4,%5}\
            	SetPlayerAttachedObject(playerid, 0, 18645, 2, (%0), (%1), (%2), (%3), (%4), (%5));

#define JBC_SetPlayerPosEx(%0,%1,%2,%4,%5)\
            	JBC_SetPlayerPos(%0,%1,%2,%4),SetPlayerFacingAngle(%0,%5)

#define JB_PUBLIC%0(%1)\
            	forward %0(%1); public %0(%1)						

#define JB_Function:%0(%1)\
            	stock %0(%1)

#define JBC_ResetPlayerPos(%0);\
            	SetPlayerVirtualWorld(%0, 0); SetPlayerInterior(%0, 0);

//ENUMERADOR DE TEAMS
enum gTeamEnum
{
	E_ID,
	E_NAME[35],
	E_COLOR,
 	TurfWarsWon,
 	TurfWarsLost,
 	RivalsKilled,
 	HomiesDied,
 	TeamScore,
 	E_SCORE,
 	E_VIP[3]

}

enum TurfEnum
{    t_ID,
	 t_name[35],
	 Float:t_minx,
	 Float:t_miny,
	 Float:t_maxx,
	 Float:t_maxy,
	 t_owner,
	 t_attacker,
	 bool:t_attacked,
	 t_kills[2],
	 bool:t_started,
	 t_timer,
	 t_timertick,
	 t_turf
}

static 
	armedbody_pTick[MAX_PLAYERS];

new 
	bool:Destroyed[MAX_PLAYERS];
new 
	bool:InClass[MAX_PLAYERS];
new 
	bool:conquista1;
new 
	bool:conquista2;
new 
	bool:conquista3;

new 
	DamageTaken[MAX_PLAYERS];
new 
	BloqueoCK[MAX_PLAYERS];
new 
	IsSpecating[MAX_PLAYERS];
new 
	VehicleModel[MAX_PLAYERS];
new 
	CFCTimer;
new 
	gTurfwarTimer = -1;
new 
	TiempoDmgA[MAX_PLAYERS]; 
new 
	TiempoDmgB[MAX_PLAYERS];
new 
	gTurfwarMessageTimer[MAX_TEAMS][4];
new 
	ModoCine[MAX_PLAYERS];
new 
	LastTeam[MAX_PLAYERS];
new 
	LastSkin[MAX_PLAYERS];
new 
	Float:DmgA[MAX_PLAYERS];
new 
	Float:DmgB[MAX_PLAYERS];
new 
	Text:ConquistaCaja1;
new 
	Text:ConquistaCaja2;
new 
	Text:ConquistaCaja3;
new 
	Text:Conquista1;
new 
	Text:Conquista2;
new 
	Text:Conquista3;
new 
	PlayerText:IndiA[MAX_PLAYERS];
new 
	PlayerText:IndiB[MAX_PLAYERS];
new 
	PlayerText:ZoneTD;
new 
	PlayerText:Informacion;
new 
	PlayerText:Caja1;
new 
	PlayerText:Caja2;
new 
	PlayerText:Armamento;
new 
	PlayerText:TeamArmas;
new 
	PlayerText:TeamInfo;
new 
	PlayerText:TeamName;
new 
	PlayerText:GPTD;
new 
	PlayerText:VTD;
new 
	PlayerText:GPIP;
new 
	PlayerText:Date;
new 
	PlayerText:gTurfwarTD[4];
new 
	PlayerText:gTurfwarTeamsTD[MAX_PLAYERS][2];
new 
	PlayerBar:gTurfwarBar[MAX_PLAYERS][2];
new 
	PlayerText:gTurfwarStartTD;

new gTeam[MAX_TEAMS][gTeamEnum] =
{
	{0, "Groove Street",    0x009A0080, 0,  0,  0,  0,  0, 0,    "No"},
	{1, "Frontyard Ballas", 0x6300FF80, 0,  0,  0,  0,  0, 25,   "No"},
	{2, "Da Nang Mafia",    0x91000080, 0,  0,  0,  0,  0, 270,  "No"},
	{3, "Militares",   		0x95510080, 0,  0,  0,  0,  0, 1900, "No"},
	{4, "Mercenarios",   	0x74FFFF80, 0,  0,  0,  0,  0, 100,  "Si"},
	{5, "Vagabundos",  	    0xF6C0AA80, 0,  0,  0,  0,  0, 8000, "No"}
};

new gTurf[][TurfEnum] =
{
//ZONAS DE CADA BANDA

	//GROOVE
	{0,		"Zona 0",	2222.50, 	-1852.80, 	2632.80, 	-1722.30, 		0,    	NO_TEAM, false, "0", false, -1, -1, -1}, // Calle lateral derecha ganton
	{1,		"Zona 1",   2222.50, 	-1722.30, 	2632.80, 	-1628.50, 		0,   	NO_TEAM, false, "0", false, -1, -1, -1}, // Groove Ganton
	{2,		"Zona 2",	2056.80, 	-1742.30, 	2222.50, 	-1494.00, 		0,    	NO_TEAM, false, "0", false, -1, -1, -1}, // Autopista
	{3,		"Zona 3",	2421.00, 	-1628.50, 	2632.80, 	-1494.00, 		0,		NO_TEAM, false, "0", false, -1, -1, -1}, //
	{4,		"Zona 4" ,	2222.50,	-1628.50, 	2421.00, 	-1494.00, 		0,		NO_TEAM, false, "0", false, -1, -1, -1}, //
	{5,		"Zona 5",	2324.00, 	-2059.20, 	2703.50, 	-1852.80, 		0,		NO_TEAM, false, "0", false, -1, -1, -1}, //
	//BALLAS
	{6,		"Zona 6",	2056.80,	-1372.00, 	2281.40, 	-1210.70,		1, 		NO_TEAM, false, "1", false, -1, -1, -1}, //
	{7,		"Zona 7",	2056.80, 	-1210.70, 	2281.40, 	-1126.30, 		1,		NO_TEAM, false, "1", false, -1, -1, -1}, //
	{8,		"Zona 8",	2056.80, 	-1494.00, 	2266.20, 	-1372.00, 		1,		NO_TEAM, false, "1", false, -1, -1, -1}, //
	{9,		"Zona 9",	2266.20, 	-1494.00, 	2381.60, 	-1372.00, 		1,		NO_TEAM, false, "1", false, -1, -1, -1}, //
	{10,	"Zona 10",	2281.60,	-1372.00, 	2381.60, 	-1135.00, 		1,		NO_TEAM, false, "1", false, -1, -1, -1}, //
	{11,	"Zona 11",	2381.60, 	-1494.00, 	2462.10, 	-1135.00, 		1,		NO_TEAM, false, "1", false, -1, -1, -1}, //
	{12,	"Zona 12",	2462.10, 	-1494.00, 	2632.80, 	-1135.00, 		1,		NO_TEAM, false, "1", false, -1, -1, -1}, //
	{13,	"Zona 13",  2056.80, 	-1126.30, 	2126.80,  	-920.80,		1,		NO_TEAM, false, "1", false, -1, -1, -1},
	{14,	"Zona 14",  2185.30, 	-1126.30, 	2281.40,  	-934.40, 		1,		NO_TEAM, false, "1", false, -1, -1, -1},
	{15,	"Zona 15",  2126.80, 	-1126.30, 	2185.30,  	-934.40, 		1,		NO_TEAM, false, "1", false, -1, -1, -1},
	//MAFIA
	{16,	"Zona 16",  2201.80, 	-2418.30, 	2324.00, 	-2095.00, 		2,		NO_TEAM, false, "2", false, -1, -1, -1},
	{17,	"Zona 17",  2324.00, 	-2302.30, 	2703.50, 	-2145.10, 		2,		NO_TEAM, false, "2", false, -1, -1, -1},
	{18,	"Zona 18",  2089.00, 	-2394.30, 	2201.80, 	-2095.00, 		2,		NO_TEAM, false, "2", false, -1, -1, -1},
	{19,	"Zona 19",  2703.50, 	-2302.30, 	2959.30, 	-2126.90, 		2,		NO_TEAM, false, "2", false, -1, -1, -1},
	{20,	"Zona 20",  2324.00, 	-2145.10, 	2703.50, 	-2059.20, 		2,		NO_TEAM, false, "2", false, -1, -1, -1},
	//MILITARES
	{21,	"Zona 21",  1249.60,	-2394.30, 	1852.00, 	-2179.20, 		3,		NO_TEAM, false, "3", false, -1, -1, -1},
	{22,	"Zona 22",  1852.00, 	-2394.30, 	2089.00, 	-2179.20, 		3,		NO_TEAM, false, "3", false, -1, -1, -1},
	{23,	"Zona 23",  1382.70, 	-2730.80, 	2201.80, 	-2394.30, 		3,		NO_TEAM, false, "3", false, -1, -1, -1},
	{24,	"Zona 24",  2373.70, 	-2697.00, 	2809.20, 	-2330.40, 		3,		NO_TEAM, false, "3", false, -1, -1, -1},
	{25,	"Zona 25",  2201.80, 	-2730.80, 	2324.00, 	-2418.30, 		3,		NO_TEAM, false, "3", false, -1, -1, -1},
	//MERCENARIOs
	{26,	"Zona 26",  1971.60, 	-1852.80, 	2222.50, 	-1742.30,		4, 		NO_TEAM, false, "4", false, -1, -1, -1},
	{27,	"Zona 27",  1970.60, 	-2179.20, 	2089.00, 	-1852.80, 		4,		NO_TEAM, false, "4", false, -1, -1, -1},
	{28,	"Zona 28",  2089.00, 	-1989.90, 	2324.00, 	-1852.80, 		4,		NO_TEAM, false, "4", false, -1, -1, -1},
	{29,	"Zona 29",  2089.00, 	-2095.00, 	2324.00, 	-1989.90, 		4,		NO_TEAM, false, "4", false, -1, -1, -1},
	//VAGABUNDOS
	{30,	"Zona 30",  1971.60, 	-1852.80, 	2222.50, 	-1742.30,		5, 		NO_TEAM, false, "5", false, -1, -1, -1},
	{31,	"Zona 31",  1970.60, 	-2179.20, 	2089.00, 	-1852.80, 		5,		NO_TEAM, false, "5", false, -1, -1, -1},
	{32,	"Zona 32",  2089.00, 	-1989.90, 	2324.00, 	-1852.80, 		5,		NO_TEAM, false, "5", false, -1, -1, -1},
	{33,	"Zona 33",  2089.00, 	-2095.00, 	2324.00, 	-1989.90, 		5,		NO_TEAM, false, "5", false, -1, -1, -1}
};

new weaponNames[55][] =
{
    {"Punch"},{"Brass Knuckles"},{"Golf Club"},{"Nite Stick"},{"Knife"},{"Baseball Bat"},{"Shovel"},{"Pool Cue"},{"Katana"},{"Chainsaw"},{"Purple Dildo"},
    {"Smal white Vibrator"},{"Large white Vibrator"},{"Silver Vibrator"},{"Flowers"},{"Cane"},{"Grenade"},{"Tear Gas"},{"Molotov Cocktail"},
    {""},{""},{""},
    {"Colt"},{"Silenced 9mm"},{"Deagle"},{"Shotgun"},{"Sawn-off"},{"Combat"},{"Micro SMG"},{"MP5"},{"AK-47"},{"M4"},{"Tec9"},
    {"Rifle"},{"Sniper"},{"Rocket"},{"HS Rocket"},{"Flamethrower"},{"Minigun"},{"Satchel Charge"},{"Detonator"},
    {"Spraycan"},{"Fire Extinguisher"},{"Camera"},{"Nightvision Goggles"},{"Thermal Goggles"},{"Parachute"}, {"Fake Pistol"},{""}, {"Vehicle"}, {"Helicopter Blades"},
    {"Explosion"}, {""}, {"Drowned"}, {"Collision"}
};

//Spawns de teams
new Float:SPAWN_0[4][4] =//Team: Groove Street
{
    {2521.9219,-1678.0366,15.4970,85.7929},  //PosiciГіn 1
    {2536.4236,-1694.4097,13.6406,221.6360}, //PosiciГіn 2
    {2536.4939,-1664.4235,15.1536,359.0366}, //PosiciГіn 3
    {2492.0112,-1640.7340,13.4767,89.2773}   //PosiciГіn 4
};

new Float:SPAWN_1[4][4] =//Team: Ballas
{
    {2236.42700, -1162.16809, 33.27956,80.4806}, //PosiciГіn 1
    {2206.67603, -1165.90710, 25.95633,85.7839}, //PosiciГіn 2
    {2232.3586,-1156.8335,29.7969,360.0000},     //PosiciГіn 3
    {2230.5190, -1174.7095, 26.4428,267.8651}    //PosiciГіn 4
};

new Float:SPAWN_4[][4] =//Team: Da Nang
{
    {1244.7393, -1835.1115, 13.4323,265.0591}, //PosiciГіn 1
    {1257.5674, -1809.6251, 14.2800,264.4324}, //PosiciГіn 2
    {1225.8369,-1815.9146,16.5938,83.6375},    //PosiciГіn 3
    {1227.9567, -1835.6317, 13.9736,184.8451}  //PosiciГіn 4
};

new Float:SPAWN_8[4][4] =//Team: Militares
{
    {2780.2903,-2426.6516,13.6355,273.8326},  //PosiciГіn 1
    {2773.7917,-2547.2539,13.6345,269.7591},  //PosiciГіn 2
    {2781.0691, -2444.6714, 13.2876,88.3375}, //PosiciГіn 3
    {2756.5425, -2395.4839, 13.5455,249.5139} //PosiciГіn 4
};

new Float:SPAWN_13[5][4] =//Team: Mercenarios
{
    {3253.9978, -1893.3604, 28.3043, 59.4492},   //PosiciГіn 1
    {3363.6143, -2251.2900, 27.4292, 4.0503},    //PosiciГіn 2
    {3364.9902, -2087.7126, 27.4497, 351.4335},  //PosiciГіn 3
    {3362.9160, -1965.9174, 28.3043, 0.4801},    //PosiciГіn 4
    {3003.1853, -2011.7463, 12.6482, 80.3007}    //PosiciГіn 5
};

new Float:SPAWN_14[4][4] =//Team: Vagabundos
{
    {2188.6531,-1965.0096,14.0469,175.1316},  //PosiciГіn 1
    {2165.8428,-1986.0477,13.5547,305.1428},  //PosiciГіn 2
    {2185.7651, -2023.2858, 13.6403,4.0734},  //PosiciГіn 3
    {2082.3975, -1965.9597, 13.1309,179.3733} //PosiciГіn 4
};
//CABEZA DEL SCRIPT
main()
{
	print("--------------------------------------------------------------------------------------->");
	print("                                          GP TDM "#v"                                 \n");
	print("    Credits:                                                                            ");
	print("        		� Dark Killer -> script                                                         ");
	print("        		� Cesar Smith -> script                                                         ");
	print("        		� AlexisFlop  -> script                                                         ");
	print("        		� Nobody[x]   -> script                                                         ");
	print("        		� pablobl[X]  -> maps and script                                                ");
	print("        		� Jefferson   -> script                                                       \n");
	print("                                                                      GP 2017 - 2020 (c) ");
	print ("--------------------------------------------------------------------------------------->");
	return 1;
}
//CALLBAKS
public OnGameModeInit()
{
	print("[GAMEMODE] GP loading...");
	DisableInteriorEnterExits();
	SetWorldTime(19);
	SetWeather(36);
	SetGameModeText("GP TDM "#v"");//Modo y versiГіn del servidor
	//Actores en el AdminBarrio.
	CreateActor(167, 1058.9679,-1063.2803,35.9342,356.9816); //Lorenxo
	CreateActor(101, 1060.6323,-1063.2083,35.9342,352.5885);//Yack
	CreateActor(171, 1063.0834,-1063.1400,35.9342,355.8343); //Cesar
	CreateActor(72,1065.0155,-1063.1210,35.9342,1.2172); // Alejo
	CreateActor(240, 1062.3864,-1059.6377,34.0716,358.5096); //Dark
	CreateActor(186, 1064.9626,-1059.5524,34.0716,354.8058); // Fresco
	CreateActor(294, 1059.9254,-1059.5458,34.0716,359.9662); //Party
	CreateActor(90, 1060.5483,-1065.8290,36.4797,356.0104); //Saso
	CreateActor(32, 1063.2656,-1065.6136,36.4797,1.6504); //Nobody
	CreateActor(170, 1066.5400,-1065.9192,36.4797,1.0237); //Blaze
	//FunciГіn que carga los stats de equipos
    LoadTStats();
    //FunciГіn que carga las zonas de equipos
    LoadZones();
    //FunciГіn que hace que no se pueda infringir daГ±o en el vehГ­culo del mismo team.
    EnableVehicleFriendlyFire();
	SetMaxConnections(2);//MГЎxima conexiГіn de IPВґs iguales
	JBC_UsePlayerPedAnims();//AnimaciГіn normal al caminar
  
	//==================================== [Team grooveStreet] =======================================================
	JBC_AddPlayerClass(107, 2530.8713, -1667.0531, 15.1684, 90.6693, 0,0,0,0,0,0);// SpawnGrooves
	JBC_AddPlayerClass(106, 2530.8713, -1667.0531, 15.1684, 90.6693, 0,0,0,0,0,0);//EquipoGroove
	JBC_AddPlayerClass(105, 2530.8713, -1667.0531, 15.1684, 90.6693, 0,0,0,0,0,0);//EquipoGroove
	JBC_AddPlayerClass(47,  2530.8713, -1667.0531, 15.1684, 90.6693, 0,0,0,0,0,0);//EquipoGroove
	//================================== [ EquipoBallas ] ===================================================================
    JBC_AddPlayerClass(149,2215.4844,-1168.9684,25.7266,356.8899,0,0,0,0,0,0); // SpawnBallas
	JBC_AddPlayerClass(102,2215.4844,-1168.9684,25.7266,356.8899,0,0,0,0,0,0); // SpawnBallas
	JBC_AddPlayerClass(103,2215.4844,-1168.9684,25.7266,356.8899,0,0,0,0,0,0); // SpawnBallas
	JBC_AddPlayerClass(104,2215.4844,-1168.9684,25.7266,356.8899,0,0,0,0,0,0); // SpawnBallas
	//================================== [ EquipoNang ] =====================================================================
	JBC_AddPlayerClass(121,1214.1914,-1814.2123,16.5938,265.7277,0,0,0,0,0,0); // Nangs
    JBC_AddPlayerClass(122,1214.1914,-1814.2123,16.5938,265.7277,0,0,0,0,0,0); // Nangs
    JBC_AddPlayerClass(123,1214.1914,-1814.2123,16.5938,265.7277,0,0,0,0,0,0); // Nangs
	//================================ [ Militares ] ========================================================================
	JBC_AddPlayerClass(287,2745.9458,-2454.3940,13.8623,0.1089,0,0,0,0,0,0); // SpawnMilitares
	JBC_AddPlayerClass(73,2745.9458,-2454.3940,13.8623,0.1089,0,0,0,0,0,0); // SpawnMilitares
	JBC_AddPlayerClass(191,2745.9458,-2454.3940,13.8623,0.1089,0,0,0,0,0,0); // SpawnMilitares
	//================================ [ Mercenarios ] ======================================================================
    JBC_AddPlayerClass(144, 3253.9978, -1893.3604, 28.3043, 59.4492,0,0,0,0,0,0); // SpawnTerro
    JBC_AddPlayerClass(3, 3253.9978, -1893.3604, 28.3043, 59.4492,0,0,0,0,0,0); // SpawnTerro
    JBC_AddPlayerClass(180, 3253.9978, -1893.3604, 28.3043, 59.4492,0,0,0,0,0,0); // SpawnTerro
    JBC_AddPlayerClass(273, 3253.9978, -1893.3604, 28.3043, 59.4492,0,0,0,0,0,0); // SpawnTerro
	JBC_AddPlayerClass(192, 3253.9978, -1893.3604, 28.3043, 59.4492,0,0,0,0,0,0); // SpawnTerro
	//================================ [ Vagabundos ] ===========================================================
	JBC_AddPlayerClass(230,2127.5903,-1987.9890,13.7045,324.5686,0,0,0,0,0,0); // SpawnVagabundos
	JBC_AddPlayerClass(225,2127.5903,-1987.9890,13.7045,324.5686,0,0,0,0,0,0);//spawnvagabundos
	JBC_AddPlayerClass(212,2127.5903,-1987.9890,13.7045,324.5686,0,0,0,0,0,0); // SpawnVagabundos
	JBC_AddPlayerClass(213,2127.5903,-1987.9890,13.7045,324.5686,0,0,0,0,0,0); // SpawnVagabundos
	JBC_AddPlayerClass(137,2127.5903,-1987.9890,13.7045,324.5686,0,0,0,0,0,0); // SpawnVagabundos
	JBC_AddPlayerClass(160,2127.5903,-1987.9890,13.7045,324.5686,0,0,0,0,0,0); // SpawnVagabundos
	//
	FadeInit();
	//adding turfs
	for(new i; i < sizeof(gTurf); i++)
	{
	    gTurf[i][t_turf] = GangZoneCreate(gTurf[i][t_minx], gTurf[i][t_miny], gTurf[i][t_maxx], gTurf[i][t_maxy], gTeam[ (gTurf[i][t_owner]) ][E_COLOR], -1, -1, 1.8012);
	}
	
	gTurfwarTimer = SetTimer("OnTurfsUpdate", 1000, true);
	
	return 1;
}

//------------------------------------------------
public OnGameModeExit()
{
	KillTimer(gTurfwarTimer);
	SaveTStats();
	FadeExit();
    return 1;
}

public OnPlayerConnect(playerid)
 {	
 	SetPlayerCameraPos(playerid, 1057.7386,-1053.3350,34.0716);
    SetPlayerCameraLookAt(playerid, 1062.9983,-1053.4705,34.0716);
    //TogglePlayerSpectating(playerid, false);
    SetPlayerColor(playerid, COLOR_RED);
    //==================================== [MAP LS] =============================
    RemoveBuildingForPlayer(playerid, 3672, 2030.0547, -2249.0234, 18.8828, 0.25);
    RemoveBuildingForPlayer(playerid, 3672, 2030.0547, -2315.4297, 18.8828, 0.25);
    RemoveBuildingForPlayer(playerid, 3672, 2030.0547, -2382.1406, 18.8828, 0.25);
    RemoveBuildingForPlayer(playerid, 3629, 2030.0547, -2382.1406, 18.8828, 0.25);
    RemoveBuildingForPlayer(playerid, 3629, 2030.0547, -2315.4297, 18.8828, 0.25);
    RemoveBuildingForPlayer(playerid, 3629, 2030.0547, -2249.0234, 18.8828, 0.25);
    RemoveBuildingForPlayer(playerid, 691, 1240.5469, -2337.7734, 10.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 739, 2011.2266, -1218.9844, 19.1250, 0.25);
    RemoveBuildingForPlayer(playerid, 739, 1864.7656, -1224.8906, 15.5391, 0.25);
    RemoveBuildingForPlayer(playerid, 5551, 2140.5156, -1735.1406, 15.8906, 0.25);
    RemoveBuildingForPlayer(playerid, 740, 1869.9688, -1204.5547, 16.5859, 0.25);
    RemoveBuildingForPlayer(playerid, 740, 2025.1406, -1244.5078, 22.3047, 0.25);
    RemoveBuildingForPlayer(playerid, 1525, 1966.9453, -1174.7266, 20.0391, 0.25);
    RemoveBuildingForPlayer(playerid, 714, 1906.4141, -1152.2578, 22.0234, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1905.7969, -1248.5234, 12.4453, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1935.6875, -1217.3516, 17.6094, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1953.2656, -1234.1797, 17.7422, 0.25);
    RemoveBuildingForPlayer(playerid, 645, 2004.3516, -1240.0938, 20.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2029.7500, -1227.7031, 19.7656, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 1990.1250, -1226.6875, 19.1953, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2036.6953, -1214.1875, 21.1875, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2009.7422, -1212.5156, 17.9922, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2018.4297, -1206.6563, 19.2344, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2048.6016, -1232.8906, 21.6250, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2050.3906, -1208.3516, 21.8125, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1927.5156, -1191.4922, 18.8125, 0.25);
    RemoveBuildingForPlayer(playerid, 700, 1989.0469, -1171.1172, 19.4922, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1880.1250, -1152.1328, 20.8047, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1989.7344, -1153.8984, 18.1094, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2043.2578, -1187.0781, 21.9297, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1998.6328, -1177.2188, 17.8594, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2038.8125, -1168.6250, 21.0234, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1998.6641, -1168.8828, 19.5781, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2010.3750, -1153.4297, 21.0625, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2028.6406, -1150.9297, 21.4922, 0.25);
    RemoveBuildingForPlayer(playerid, 5410, 2140.5156, -1735.1406, 15.8906, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 1327.4297, -1239.9844, 13.9375, 0.25);
    RemoveBuildingForPlayer(playerid, 1412, 1327.4297, -1234.7422, 13.9375, 0.25);
    RemoveBuildingForPlayer(playerid, 1219, 1332.8359, -1241.7188, 13.4141, 0.25);
    RemoveBuildingForPlayer(playerid, 1297, 1337.8828, -1237.7188, 15.4922, 0.25);
    RemoveBuildingForPlayer(playerid, 647, 578.8359, -1822.0000, 6.2188, 0.25);
    RemoveBuildingForPlayer(playerid, 8127, 1278.2969, 1361.4531, 13.7500, 0.25);
    RemoveBuildingForPlayer(playerid, 8252, 1278.0234, 1324.2500, 13.7500, 0.25);
    RemoveBuildingForPlayer(playerid, 8253, 1278.0234, 1324.2500, 13.7500, 0.25);
    RemoveBuildingForPlayer(playerid, 8251, 1278.2969, 1361.4531, 13.7500, 0.25);

    //==================================== [MAP Plaza] =============================
    RemoveBuildingForPlayer(playerid, 4057, 1479.5547, -1693.1406, 19.5781, 0.25);
    RemoveBuildingForPlayer(playerid, 1527, 1448.2344, -1755.8984, 14.5234, 0.25);
    RemoveBuildingForPlayer(playerid, 4210, 1479.5625, -1631.4531, 12.0781, 0.25);
    RemoveBuildingForPlayer(playerid, 713, 1457.9375, -1620.6953, 13.4531, 0.25);
    RemoveBuildingForPlayer(playerid, 713, 1496.8672, -1707.8203, 13.4063, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 1445.8125, -1650.0234, 22.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 1457.7266, -1710.0625, 12.3984, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1461.6563, -1707.6875, 11.8359, 0.25);
    RemoveBuildingForPlayer(playerid, 700, 1463.0625, -1701.5703, 13.7266, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 1457.5547, -1697.2891, 12.3984, 0.25);
    RemoveBuildingForPlayer(playerid, 4186, 1479.5547, -1693.1406, 19.5781, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1461.1250, -1687.5625, 11.8359, 0.25);
    RemoveBuildingForPlayer(playerid, 700, 1463.0625, -1690.6484, 13.7266, 0.25);
    RemoveBuildingForPlayer(playerid, 641, 1458.6172, -1684.1328, 11.1016, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1457.2734, -1666.2969, 13.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 1471.4063, -1666.1797, 22.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 1231, 1479.3828, -1682.3125, 15.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1458.2578, -1659.2578, 13.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 1449.8516, -1655.9375, 22.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1457.3516, -1650.5703, 13.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1454.4219, -1642.4922, 13.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 1231, 1466.4688, -1637.9609, 15.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1449.5938, -1635.0469, 13.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 3985, 1479.5625, -1631.4531, 12.0781, 0.25);
    RemoveBuildingForPlayer(playerid, 700, 1494.2109, -1694.4375, 13.7266, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1496.9766, -1686.8516, 11.8359, 0.25);
    RemoveBuildingForPlayer(playerid, 641, 1494.1406, -1689.2344, 11.1016, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 1480.6094, -1666.1797, 22.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 1488.2266, -1666.1797, 22.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 1498.9609, -1684.6094, 12.3984, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1504.1641, -1662.0156, 13.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1504.7188, -1670.9219, 13.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1503.1875, -1621.1250, 11.8359, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 1501.2813, -1624.5781, 12.3984, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 1498.3594, -1616.9688, 12.3984, 0.25);
    RemoveBuildingForPlayer(playerid, 712, 1508.4453, -1668.7422, 22.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1505.6953, -1654.8359, 13.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1508.5156, -1647.8594, 13.6953, 0.25);
    RemoveBuildingForPlayer(playerid, 625, 1513.2734, -1642.4922, 13.6953, 0.25);

    //==================================== [MAP Groove] =============================
    RemoveBuildingForPlayer(playerid, 3592, 2451.7344, -1637.4844, 15.1328, 0.25);
    RemoveBuildingForPlayer(playerid, 3706, 2520.1875, -1694.8516, 14.8828, 0.25);
    RemoveBuildingForPlayer(playerid, 1265, 2488.8047, -1684.7891, 12.8125, 0.25);
    RemoveBuildingForPlayer(playerid, 1418, 2515.1250, -1683.0859, 13.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 1418, 2512.6094, -1683.1719, 13.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 760, 2514.3438, -1684.5234, 12.3906, 0.25);
    RemoveBuildingForPlayer(playerid, 3594, 2532.9844, -1719.4297, 13.1797, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 2537.1172, -1719.9922, 16.4219, 0.25);
    RemoveBuildingForPlayer(playerid, 3594, 2537.9688, -1700.7109, 13.1797, 0.25);
    RemoveBuildingForPlayer(playerid, 3646, 2520.1875, -1694.8516, 14.8828, 0.25);
    RemoveBuildingForPlayer(playerid, 1418, 2517.7734, -1685.2969, 13.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 760, 2516.6094, -1686.4844, 12.2422, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 2490.1016, -1654.6563, 16.1328, 0.25);
    RemoveBuildingForPlayer(playerid, 1265, 2491.2344, -1653.9609, 12.9219, 0.25);
    RemoveBuildingForPlayer(playerid, 1230, 2492.2656, -1653.9922, 12.8984, 0.25);
    RemoveBuildingForPlayer(playerid, 1211, 2495.2656, -1653.6719, 12.9141, 0.25);
    RemoveBuildingForPlayer(playerid, 1265, 2505.6719, -1658.9063, 12.8125, 0.25);
    RemoveBuildingForPlayer(playerid, 1265, 2510.9219, -1656.1328, 12.8125, 0.25);
    RemoveBuildingForPlayer(playerid, 1230, 2501.9297, -1650.5078, 12.9141, 0.25);
    RemoveBuildingForPlayer(playerid, 669, 2538.0234, -1667.6406, 13.4844, 0.25);
    RemoveBuildingForPlayer(playerid, 3594, 2514.3906, -1658.6016, 13.1406, 0.25);
    RemoveBuildingForPlayer(playerid, 762, 2446.5547, -1681.0703, 12.3828, 0.25);
    RemoveBuildingForPlayer(playerid, 3593, 2457.8672, -1679.6719, 12.9453, 0.25);
    RemoveBuildingForPlayer(playerid, 17879, 2484.5313, -1667.6094, 21.4375, 0.25);
    RemoveBuildingForPlayer(playerid, 1230, 2415.2031, -1653.1328, 12.6797, 0.25);
    RemoveBuildingForPlayer(playerid, 1410, 2448.9141, -1648.8516, 13.2813, 0.25);
    RemoveBuildingForPlayer(playerid, 1410, 2446.7734, -1646.4219, 13.1563, 0.25);
    RemoveBuildingForPlayer(playerid, 1230, 2453.9609, -1653.6953, 12.6797, 0.25);
    RemoveBuildingForPlayer(playerid, 1410, 2455.9063, -1648.8047, 13.2813, 0.25);
    RemoveBuildingForPlayer(playerid, 1230, 2475.0000, -1653.6094, 12.7891, 0.25);
    RemoveBuildingForPlayer(playerid, 3593, 2437.4844, -1644.1172, 12.9844, 0.25);
    RemoveBuildingForPlayer(playerid, 3589, 2451.7344, -1637.4844, 15.1328, 0.25);
    RemoveBuildingForPlayer(playerid, 17858, 2489.2969, -1668.5000, 12.2969, 0.25);
    RemoveBuildingForPlayer(playerid, 17613, 2489.2969, -1668.5000, 12.2969, 0.25);
    RemoveBuildingForPlayer(playerid, 17971, 2484.5313, -1667.6094, 21.4375, 0.25);

    //MAP BALLAS//////////////////////////////////////////////////////////////////////
    RemoveBuildingForPlayer(playerid, 1290, 2216.6797, -1175.8125, 30.5547, 0.25);
    RemoveBuildingForPlayer(playerid, 1290, 2217.1953, -1152.7031, 30.5547, 0.25);

    //MAP VAGOS///////////////////////////////////////////////////////////////////////
    RemoveBuildingForPlayer(playerid, 714, 2834.5547, -1253.5234, 21.3438, 0.25);
    RemoveBuildingForPlayer(playerid, 1530, 2820.3438, -1190.9766, 25.6719, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2831.8594, -1266.8672, 16.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2833.2344, -1273.8750, 14.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 621, 2837.2344, -1277.3828, 18.8438, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2840.1875, -1266.6250, 19.1797, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2796.4609, -1187.0000, 22.5625, 0.25);
    RemoveBuildingForPlayer(playerid, 17947, 2815.4063, -1188.5000, 26.6016, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 2798.9297, -1178.8672, 23.6484, 0.25);
    RemoveBuildingForPlayer(playerid, 1297, 2835.4453, -1175.0781, 27.1563, 0.25);

    //MAP AZTECAS///////////////////////////////////////////////////////////////////////
    RemoveBuildingForPlayer(playerid, 5024, 1748.8438, -1883.0313, 14.1875, 0.25);
    RemoveBuildingForPlayer(playerid, 5083, 1748.8438, -1883.0313, 14.1875, 0.25);

    //MAP DANANG///////////////////////////////////////////////////////////////////////
    RemoveBuildingForPlayer(playerid, 1294, 1280.3125, -1848.1250, 16.9063, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 1234.4766, -1848.0625, 16.9063, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 1204.9219, -1847.8516, 16.9063, 0.25);
    RemoveBuildingForPlayer(playerid, 620, 1196.6016, -1840.3828, 12.3516, 0.25);
    RemoveBuildingForPlayer(playerid, 700, 1281.8750, -1840.0938, 13.0391, 0.25);
    RemoveBuildingForPlayer(playerid, 647, 1192.8281, -1839.8125, 14.0703, 0.25);
    RemoveBuildingForPlayer(playerid, 647, 1284.9766, -1839.8125, 14.0703, 0.25);

    //MAP VAGABUNDOS///////////////////////////////////////////////////////////////////////
    RemoveBuildingForPlayer(playerid, 3723, 2197.7500, -1993.3594, 14.9922, 0.25);
    RemoveBuildingForPlayer(playerid, 3723, 2100.7031, -1989.3984, 16.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 3723, 2093.2813, -1975.5859, 16.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 3723, 2178.7344, -1971.2656, 16.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 3723, 2189.9922, -1949.3281, 16.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 3744, 2159.8281, -1930.6328, 15.0781, 0.25);
    RemoveBuildingForPlayer(playerid, 3744, 2072.5469, -1967.6016, 15.1172, 0.25);
    RemoveBuildingForPlayer(playerid, 1525, 2134.3281, -2011.2031, 10.5156, 0.25);
    RemoveBuildingForPlayer(playerid, 3770, 2197.9766, -1970.5625, 14.0000, 0.25);
    RemoveBuildingForPlayer(playerid, 5357, 2177.9922, -2006.7578, 23.2891, 0.25);
    RemoveBuildingForPlayer(playerid, 5291, 2177.9922, -2006.7578, 23.2891, 0.25);
    RemoveBuildingForPlayer(playerid, 3722, 2100.7031, -1989.3984, 16.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 3722, 2093.2813, -1975.5859, 16.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 3722, 2178.7344, -1971.2656, 16.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 3722, 2197.7500, -1993.3594, 14.9922, 0.25);
    RemoveBuildingForPlayer(playerid, 3626, 2197.9766, -1970.5625, 14.0000, 0.25);
    RemoveBuildingForPlayer(playerid, 1226, 2209.5859, -1977.5234, 16.4844, 0.25);
    RemoveBuildingForPlayer(playerid, 3574, 2072.5469, -1967.6016, 15.1172, 0.25);
    RemoveBuildingForPlayer(playerid, 3567, 2142.9141, -1947.4219, 13.2656, 0.25);
    RemoveBuildingForPlayer(playerid, 3722, 2189.9922, -1949.3281, 16.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 3574, 2159.8281, -1930.6328, 15.0781, 0.25);
    RemoveBuildingForPlayer(playerid, 1308, 2208.5078, -1905.6094, 12.7188, 0.25);

    //MAP POLICIA///////////////////////////////////////////////////////////////////////
    RemoveBuildingForPlayer(playerid, 1266, 1538.5234, -1609.8047, 19.8438, 0.25);
    RemoveBuildingForPlayer(playerid, 4229, 1597.9063, -1699.7500, 30.2109, 0.25);
    RemoveBuildingForPlayer(playerid, 4230, 1597.9063, -1699.7500, 30.2109, 0.25);
    RemoveBuildingForPlayer(playerid, 1260, 1538.5234, -1609.8047, 19.8438, 0.25);
    ///MAP MILITARES///////////////////////////////////////////////////////////////////
    RemoveBuildingForPlayer(playerid, 5164, 2838.1406, -2447.8438, 15.7266, 0.25);
    RemoveBuildingForPlayer(playerid, 3710, 2788.1563, -2455.8828, 16.7266, 0.25);
    RemoveBuildingForPlayer(playerid, 3770, 2746.4063, -2453.4844, 14.0781, 0.25);
    RemoveBuildingForPlayer(playerid, 5352, 2838.1953, -2488.6641, 29.3125, 0.25);
    RemoveBuildingForPlayer(playerid, 3578, 2747.0078, -2480.2422, 13.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2463.8203, 14.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 3624, 2788.1563, -2455.8828, 16.7266, 0.25);
    RemoveBuildingForPlayer(playerid, 3626, 2746.4063, -2453.4844, 14.0781, 0.25);
    RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2448.4766, 14.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 3577, 2744.5703, -2436.1875, 13.3438, 0.25);
    RemoveBuildingForPlayer(playerid, 3577, 2744.5703, -2427.3203, 13.3516, 0.25);
    RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2463.8203, 14.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 3761, 2797.5156, -2448.3438, 14.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2448.4766, 14.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 5154, 2838.1406, -2447.8438, 15.7500, 0.25);
    RemoveBuildingForPlayer(playerid, 3724, 2838.1953, -2488.6641, 29.3125, 0.25);
    RemoveBuildingForPlayer(playerid, 3724, 2838.1953, -2407.1406, 29.3125, 0.25);
    //MADDOG
    RemoveBuildingForPlayer(playerid, 13783, 1254.3984, -803.1719, 85.9609, 0.25);
    RemoveBuildingForPlayer(playerid, 13724, 1254.3984, -803.1719, 85.9609, 0.25);
    RemoveBuildingForPlayer(playerid, 13744, 1272.5938, -803.1094, 86.3594, 0.25);


//MAP AEROPUERTO ABANDONADO////////////////////////////////////////////////////////
    RemoveBuildingForPlayer(playerid, 3345, 400.1172, 2543.5703, 15.4844, 0.25);
    RemoveBuildingForPlayer(playerid, 3367, 149.9141, 2614.6172, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3368, 161.7891, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3369, 123.0469, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3368, 311.1328, 2614.6172, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3368, 176.7891, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3368, 338.0078, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3368, 323.0078, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3369, 203.6563, 2614.6172, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3369, 230.5234, 2641.4844, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3369, 349.8750, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3369, 269.2656, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3369, 242.3984, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3369, 188.6563, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3369, 108.0469, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3367, 176.7891, 2641.4844, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3367, 230.5234, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3367, 257.3984, 2614.6172, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3367, 284.2656, 2641.4844, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3367, 284.2656, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3367, 296.1406, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3367, 215.5313, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3367, 134.9141, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 16597, 437.3828, 2547.5156, 15.1484, 0.25);
    RemoveBuildingForPlayer(playerid, 16598, 231.2813, 2545.7969, 20.0234, 0.25);
    RemoveBuildingForPlayer(playerid, 3296, 255.9844, 2549.3281, 20.2031, 0.25);
    RemoveBuildingForPlayer(playerid, 3295, 392.7109, 2596.4531, 17.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 3296, 376.2969, 2606.3438, 20.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 3295, 390.8203, 2604.0703, 20.0234, 0.25);
    RemoveBuildingForPlayer(playerid, 3295, 389.1328, 2611.0625, 20.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 3295, 382.1875, 2609.4766, 19.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 16600, 435.6250, 2532.0859, 20.1797, 0.25);
    RemoveBuildingForPlayer(playerid, 16602, 307.9531, 2543.4531, 20.3984, 0.25);
    RemoveBuildingForPlayer(playerid, 3269, 108.0469, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3270, 161.7891, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3364, 77.3203, 2456.2500, 15.2813, 0.25);
    RemoveBuildingForPlayer(playerid, 3269, 188.6563, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3271, 134.9141, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3271, 215.5313, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3269, 242.3984, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3287, 255.9844, 2549.3281, 20.2031, 0.25);
    RemoveBuildingForPlayer(playerid, 16599, 231.2813, 2545.7969, 20.0234, 0.25);
    RemoveBuildingForPlayer(playerid, 3269, 269.2656, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 16098, 307.9531, 2543.4531, 20.3984, 0.25);
    RemoveBuildingForPlayer(playerid, 3271, 296.1406, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3269, 123.0469, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3270, 176.7891, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3271, 230.5234, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3271, 284.2656, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3271, 149.9141, 2614.6172, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3271, 176.7891, 2641.4844, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3269, 230.5234, 2641.4844, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3269, 203.6563, 2614.6172, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3271, 257.3984, 2614.6172, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3271, 284.2656, 2641.4844, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3270, 323.0078, 2411.3828, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3269, 349.8750, 2438.2500, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 864, 357.5938, 2449.6172, 15.6406, 0.25);
    RemoveBuildingForPlayer(playerid, 864, 364.2266, 2450.7578, 15.5469, 0.25);
    RemoveBuildingForPlayer(playerid, 3270, 338.0078, 2587.7422, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3270, 311.1328, 2614.6172, 15.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 3287, 376.2969, 2606.3438, 20.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 3286, 382.1875, 2609.4766, 19.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 1224, 410.8281, 2528.5703, 16.1563, 0.25);
    RemoveBuildingForPlayer(playerid, 1224, 409.8047, 2529.6328, 16.1563, 0.25);
    RemoveBuildingForPlayer(playerid, 1224, 408.7188, 2530.7656, 16.1563, 0.25);
    RemoveBuildingForPlayer(playerid, 3172, 400.1172, 2543.5703, 15.4844, 0.25);
    RemoveBuildingForPlayer(playerid, 3286, 390.8203, 2604.0703, 20.0234, 0.25);
    RemoveBuildingForPlayer(playerid, 3286, 392.7109, 2596.4531, 17.6328, 0.25);
    RemoveBuildingForPlayer(playerid, 3286, 389.1328, 2611.0625, 20.1719, 0.25);
    RemoveBuildingForPlayer(playerid, 1498, 422.8281, 2535.7344, 15.1406, 0.25);
    RemoveBuildingForPlayer(playerid, 16501, 429.9844, 2546.5156, 17.3516, 0.25);
    RemoveBuildingForPlayer(playerid, 16409, 437.3828, 2547.5156, 15.1484, 0.25);
    RemoveBuildingForPlayer(playerid, 16601, 435.6250, 2532.0859, 20.1797, 0.25);

    //**MAP BOLICHE////////////////////////////////////////////////////////////////////
    RemoveBuildingForPlayer(playerid, 6456, 397.5391, -1848.4922, 12.1484, 0.25);
    RemoveBuildingForPlayer(playerid, 1215, 384.4297, -1874.0313, 7.3750, 0.25);
    RemoveBuildingForPlayer(playerid, 1215, 384.4297, -1855.5234, 7.3750, 0.25);
    RemoveBuildingForPlayer(playerid, 1215, 384.4297, -1837.9766, 7.3750, 0.25);
    RemoveBuildingForPlayer(playerid, 1368, 381.7969, -1834.9219, 7.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 1371, 387.1328, -1831.4453, 7.5938, 0.25);
    RemoveBuildingForPlayer(playerid, 6288, 397.5391, -1848.4922, 12.1484, 0.25);
    RemoveBuildingForPlayer(playerid, 1500, 387.5625, -1817.0859, 6.8203, 0.25);
    BloqueoCK[playerid] = 0;
   	ModoCine[playerid] = 0;
	    
	new country[64], 
		city[64], 
		msg[128],
		maxPlayers,
		ISP[64],
		logOne[128],
		logTwo[128];
	
	maxPlayers = GetMaxPlayers();
	GetPlayerCountry(playerid, country, sizeof(country));
	GetPlayerCity(playerid, city, sizeof(city));
	GetPlayerISP(playerid, ISP, sizeof(ISP));
	
	format(msg, sizeof(msg), "[%d/100] {007DFF}|| %s [ID:%d]{FFFFFF} ha ingresado GP Reborn{007DFF} || {FFFFFF}Pais:  %s || Ciudad: %s.",ConnectedPlayers(), pName(playerid), playerid, country, city);
	PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/s/sj98uft52jzcqyv/audioclip-1496446459000-223295%20%28online-audio-converter.com%29.mp3");
	
	SendClientMessageToAll(-1, msg);
	
	format(logOne, sizeof(logOne),"\n[CLIENT LOGIN %d/%d] %s [ID:%d] ha ingresado al servidor || Pais: %s || Ciudad: %s", ConnectedPlayers(), maxPlayers, pName(playerid), playerid, country, city);
	format(logTwo, sizeof(logTwo),"IP: %s || Proxy: %d || GTM: %d || Proovedor de internet: %s\n", GetIpPlayer(playerid), GetPlayerProxy(playerid), GetPlayerGMT(playerid), ISP);

	print(logOne);
	print(logTwo);

	SaveLogData("sign.txt", logOne);
	SaveLogData("sign.txt", logTwo);

   	RemoveBuildingForPlayer(playerid, 3589, 2451.7344, -1637.4844, 15.13281, 12.906491); // removeWorldObject (compfukhouse3) (1)
	RemoveBuildingForPlayer(playerid, 3592, 2451.7344, -1637.4844, 15.13281, 12.906491); // (LOD) removeWorldObject (compfukhouse3) (1)
	RemoveBuildingForPlayer(playerid, 3648, 2470.8203, -1640.8203, 15.02344, 12.156319); // removeWorldObject (ganghous02_LAx) (1)
	RemoveBuildingForPlayer(playerid, 3647, 2470.8203, -1640.8203, 15.02344, 12.156319); // (LOD) removeWorldObject (ganghous02_LAx) (1)
	RemoveBuildingForPlayer(playerid, 3646, 2520.1875, -1694.8516, 14.88281, 13.246561); // removeWorldObject (ganghous05_LAx) (1)
	RemoveBuildingForPlayer(playerid, 3706, 2520.1875, -1694.8516, 14.88281, 13.246561); // (LOD) removeWorldObject (ganghous05_LAx) (1)
    CText(playerid);

	GPTD = CreatePlayerTextDraw(playerid, 564.400024, 379.000000, "GP");
    PlayerTextDrawSetShadow(playerid, GPTD, 1);
	PlayerTextDrawBackgroundColor(playerid, GPTD, COLOR_BLACK);
	PlayerTextDrawFont(playerid, GPTD, 1);
	PlayerTextDrawLetterSize(playerid, GPTD, 0.839999, 3.500000);
	PlayerTextDrawColor(playerid, GPTD, 0xFEA800FF);
	PlayerTextDrawSetOutline(playerid, GPTD, 1);
	PlayerTextDrawSetProportional(playerid, GPTD, 0);
	PlayerTextDrawSetSelectable(playerid, GPTD, 0);

	VTD = CreatePlayerTextDraw(playerid, 540.400024, 404.000000, "REBORN");
	PlayerTextDrawBackgroundColor(playerid, VTD, COLOR_BLACK);
	PlayerTextDrawFont(playerid, VTD, 2);
	PlayerTextDrawLetterSize(playerid, VTD, 0.550000, 3.299999);
	PlayerTextDrawColor(playerid, VTD, 0x9D63E9FF);
	PlayerTextDrawSetOutline(playerid, VTD, 0);
	PlayerTextDrawSetProportional(playerid, VTD, 1);
	PlayerTextDrawSetSelectable(playerid, VTD, 0);
	PlayerTextDrawSetShadow(playerid, VTD, 1);
	
	GPIP = CreatePlayerTextDraw(playerid, 583.000000, 433.000000, "74.91.116.215:7777");
	PlayerTextDrawAlignment(playerid, GPIP, 2);
	PlayerTextDrawBackgroundColor(playerid, GPIP, 255);
	PlayerTextDrawFont(playerid, GPIP, 2);
	PlayerTextDrawLetterSize(playerid, GPIP, 0.220000, 1.000000);
	PlayerTextDrawColor(playerid, GPIP, -1);
	PlayerTextDrawSetOutline(playerid, GPIP, 1);
	PlayerTextDrawSetProportional(playerid, GPIP, 1);
	PlayerTextDrawSetSelectable(playerid, GPIP, 0);
	
	CallTDEquipos(playerid);

	ZoneTD = CreatePlayerTextDraw(playerid, 90.000000, 324.000000, "");
	PlayerTextDrawAlignment(playerid, ZoneTD, 2);
	PlayerTextDrawBackgroundColor(playerid, ZoneTD, 255);
	PlayerTextDrawFont(playerid, ZoneTD, 2);
	PlayerTextDrawLetterSize(playerid, ZoneTD, 0.149998, 1.299994);
	PlayerTextDrawColor(playerid, ZoneTD, -1);
	PlayerTextDrawSetOutline(playerid, ZoneTD, 1);
	PlayerTextDrawSetProportional(playerid, ZoneTD, 1);
	PlayerTextDrawSetSelectable(playerid, ZoneTD, 0);
	PlayerTextDrawHide(playerid, ZoneTD);

	//turfwar player textdraws
	gTurfwarTD[0] = CreatePlayerTextDraw(playerid, 338.000000, 327.000000, "�Equipo! Hemos comenzado una guerra contra Groove Street en Idlewood (/guerras)");
	PlayerTextDrawAlignment(playerid, gTurfwarTD[0], 2);
	PlayerTextDrawBackgroundColor(playerid, gTurfwarTD[0], 461934);
	PlayerTextDrawFont(playerid, gTurfwarTD[0], 1);
	PlayerTextDrawLetterSize(playerid, gTurfwarTD[0], 0.239998, 1.600000);
	PlayerTextDrawColor(playerid, gTurfwarTD[0], -1);
	PlayerTextDrawSetOutline(playerid, gTurfwarTD[0], 1);
	PlayerTextDrawSetProportional(playerid, gTurfwarTD[0], 1);
	PlayerTextDrawUseBox(playerid, gTurfwarTD[0], 1);
	PlayerTextDrawBoxColor(playerid, gTurfwarTD[0], 9022319);
	PlayerTextDrawTextSize(playerid, gTurfwarTD[0], 0.000000, 341.000000);
	PlayerTextDrawSetSelectable(playerid, gTurfwarTD[0], 0);
	
	gTurfwarTD[1] = CreatePlayerTextDraw(playerid, 338.000000, 361.000000, "�Atencion! Nuestro territorio en Idlewood estГЎ en disputa con Groove Street (/guerras)");
	PlayerTextDrawAlignment(playerid, gTurfwarTD[1], 2);
	PlayerTextDrawBackgroundColor(playerid, gTurfwarTD[1], 255);
	PlayerTextDrawFont(playerid, gTurfwarTD[1], 1);
	PlayerTextDrawLetterSize(playerid, gTurfwarTD[1], 0.229998, 1.599999);
	PlayerTextDrawColor(playerid, gTurfwarTD[1], -1);
	PlayerTextDrawSetOutline(playerid, gTurfwarTD[1], 1);
	PlayerTextDrawSetProportional(playerid, gTurfwarTD[1], 1);
	PlayerTextDrawUseBox(playerid, gTurfwarTD[1], 1);
	PlayerTextDrawBoxColor(playerid, gTurfwarTD[1], -1509946279);
	PlayerTextDrawTextSize(playerid, gTurfwarTD[1], 0.000000, 342.000000);
	PlayerTextDrawSetSelectable(playerid, gTurfwarTD[1], 0);
	
	gTurfwarTD[2] = CreatePlayerTextDraw(playerid, 338.000000, 327.000000, "�Equpo! Hemos comenzado una guerra contra Groove Street en Idlewood (/guerras)");
	PlayerTextDrawAlignment(playerid, gTurfwarTD[2], 2);
	PlayerTextDrawBackgroundColor(playerid, gTurfwarTD[2], 461934);
	PlayerTextDrawFont(playerid, gTurfwarTD[2], 1);
	PlayerTextDrawLetterSize(playerid, gTurfwarTD[2], 0.239998, 1.600000);
	PlayerTextDrawColor(playerid, gTurfwarTD[2], -1);
	PlayerTextDrawSetOutline(playerid, gTurfwarTD[2], 1);
	PlayerTextDrawSetProportional(playerid, gTurfwarTD[2], 1);
	PlayerTextDrawUseBox(playerid, gTurfwarTD[2], 1);
	PlayerTextDrawBoxColor(playerid, gTurfwarTD[2], 9022319);
	PlayerTextDrawTextSize(playerid, gTurfwarTD[2], 0.000000, 341.000000);
	PlayerTextDrawSetSelectable(playerid, gTurfwarTD[2], 0);

	gTurfwarTD[3] = CreatePlayerTextDraw(playerid, 338.000000, 361.000000, "�Atencion! Nuestro territorio en Idlewood estГЎ en disputa con Groove Street (/guerras)");
	PlayerTextDrawAlignment(playerid, gTurfwarTD[3], 2);
	PlayerTextDrawBackgroundColor(playerid, gTurfwarTD[3], 255);
	PlayerTextDrawFont(playerid, gTurfwarTD[3], 1);
	PlayerTextDrawLetterSize(playerid, gTurfwarTD[3], 0.229998, 1.599999);
	PlayerTextDrawColor(playerid, gTurfwarTD[3], -1);
	PlayerTextDrawSetOutline(playerid, gTurfwarTD[3], 1);
	PlayerTextDrawSetProportional(playerid, gTurfwarTD[3], 1);
	PlayerTextDrawUseBox(playerid, gTurfwarTD[3], 1);
	PlayerTextDrawBoxColor(playerid, gTurfwarTD[3], -1509946279);
	PlayerTextDrawTextSize(playerid, gTurfwarTD[3], 0.000000, 342.000000);
	PlayerTextDrawSetSelectable(playerid, gTurfwarTD[3], 0);
	gTurfwarTeamsTD[playerid][0] = PlayerTextDrawAdd(playerid, 92.000000, 287.000000, "izquierda", 255, 2, 0.219999, 0.799998, -1, 1, 1, true, 1, false);
	gTurfwarTeamsTD[playerid][1] = PlayerTextDrawAdd(playerid, 89.000000, 287.000000, "derecha", 255, 2, 0.219999, 0.799998, -1, 3, 1, true, 1, false);
	//turfwar startup textdraw

	gTurfwarStartTD = CreatePlayerTextDraw(playerid, 49.663253, 283.000000, "Comenzando la guerra en 10 segundos");
	PlayerTextDrawAlignment(playerid, gTurfwarStartTD, 2);
	PlayerTextDrawBackgroundColor(playerid, gTurfwarStartTD, COLOR_BLACK);
	PlayerTextDrawFont(playerid, gTurfwarStartTD, 1);
	PlayerTextDrawLetterSize(playerid, gTurfwarStartTD, 0.159998, 1.000000);
	PlayerTextDrawColor(playerid, gTurfwarStartTD, COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid, gTurfwarStartTD, 1);
	PlayerTextDrawSetProportional(playerid, gTurfwarStartTD, 1);
	PlayerTextDrawUseBox(playerid, gTurfwarStartTD, 1);
	PlayerTextDrawBoxColor(playerid, gTurfwarStartTD, -67569571);
	PlayerTextDrawTextSize(playerid, gTurfwarStartTD, 0.000000, 115.000000);
	PlayerTextDrawSetSelectable(playerid, gTurfwarStartTD, 0);

	new s[64], day, month, year;
	getdate(day, month, year);
	format(s, sizeof(s), "%s[ID: %d] %d/%d/%d", pName(playerid), playerid, day, month, year);
	Date = CreatePlayerTextDraw(playerid, 501.000000, 13.000000, s);
	PlayerTextDrawFont(playerid, Date, 2);
	PlayerTextDrawLetterSize(playerid, Date, 0.179996, 0.899997);
	PlayerTextDrawColor(playerid, Date, -1);
	PlayerTextDrawBackgroundColor(playerid, Date, 255);
	PlayerTextDrawSetProportional(playerid, Date, 1);
	PlayerTextDrawSetShadow(playerid, Date, 1);
	PlayerTextDrawSetSelectable(playerid, Date, 0);
    FadePlayerConnect(playerid);

	ShowAllGangZonesForPlayer(playerid);

	gTurfwarBar[playerid][0] = CreatePlayerProgressBar(playerid, 92.000000, 297.000000, 55.500000, 6.699999, -1429936641, TURFWAR_TIME, 1);
    gTurfwarBar[playerid][1] = CreatePlayerProgressBar(playerid, 91.000000, 297.000000, 55.500000, 6.699999, -1429936641, TURFWAR_TIME, 0);
    PlayerTextDrawShow(playerid, GPTD);
    PlayerTextDrawShow(playerid, VTD);
    PlayerTextDrawShow(playerid, GPIP);
    //TextDrawShowForPlayer(playerid, Sprite);
	
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    ModoCine[playerid] = 0;
    
    FadePlayerDisconnect(playerid);
    BText(playerid);
    
    PlayerTextDrawDestroy(playerid, gTurfwarTD[0]);
    PlayerTextDrawDestroy(playerid, gTurfwarTD[1]);
    PlayerTextDrawDestroy(playerid, gTurfwarTD[2]);
    PlayerTextDrawDestroy(playerid, gTurfwarTD[3]);
    //destroy bar team textdraws
    PlayerTextDrawDestroy(playerid, gTurfwarTeamsTD[playerid][0]);
    PlayerTextDrawDestroy(playerid, gTurfwarTeamsTD[playerid][1]);
    
    //destroy turfwar player bars
    DestroyPlayerProgressBar(playerid, gTurfwarBar[playerid][0]);
    DestroyPlayerProgressBar(playerid, gTurfwarBar[playerid][1]);
//	TextDrawHideForPlayer(playerid,Sprite);
 	PlayerTextDrawDestroy(playerid,Caja1);
	PlayerTextDrawDestroy(playerid,Caja2);
	PlayerTextDrawDestroy(playerid,ZoneTD);
    PlayerTextDrawDestroy(playerid, GPTD);
    PlayerTextDrawDestroy(playerid, VTD);
    PlayerTextDrawDestroy(playerid, GPIP);
    PlayerTextDrawDestroy(playerid, Date);
    
	new m[128];
    switch(reason)
    {
        case 0: format(m, sizeof(m), "%s ha salido del sevidor por crash/perdida de conexion.", pName(playerid));
        case 1: format(m, sizeof(m), "%s ha salido del sevidor por cerrar el juego.", pName(playerid));
        case 2: format(m, sizeof(m), "%s ha salido del sevidor por expulsion/baneo.", pName(playerid));
    }
    SendClientMessageToAll(0x6A5B5CFF, m);
    SetPlayerColor(playerid, 0x6A5B5CFF);

	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{

	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
	    VehicleModel[playerid] = GetVehicleModel(GetPlayerVehicleID(playerid));
	        
	    if(newstate != PLAYER_STATE_DRIVER && (oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)) 
	    	KillTimer(CFCTimer);

	    if(IsABike(GetPlayerVehicleID(playerid)))
	    {
			switch(GetPlayerSkin(playerid))
			{
				case 0, 65, 74, 149, 208, 273:  SPAO{0.070000, 0.000000, 0.000000, 88.000000, 75.000000, 0.000000}
				case 1..6, 8, 14, 16, 22, 27, 29, 33, 41..49, 82..84, 86, 87, 119, 289: SPAO{0.070000, 0.000000, 0.000000, 88.000000, 77.000000, 0.000000}
				case 7, 10: SPAO{0.090000, 0.019999, 0.000000, 88.000000, 90.000000, 0.000000}
				case 9: SPAO{0.059999, 0.019999, 0.000000, 88.000000, 90.000000, 0.000000}
				case 11..13: SPAO{0.070000, 0.019999, 0.000000, 88.000000, 90.000000, 0.000000}
				case 15: SPAO{0.059999, 0.000000, 0.000000, 88.000000, 82.000000, 0.000000}
				case 17..21: SPAO{0.059999, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 23..26, 28, 30..32, 34..39, 57, 58, 98, 99, 104..118, 120..131: SPAO{0.079999, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 40: SPAO{0.050000, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 50, 100..103, 148, 150..189, 222: SPAO{0.070000, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 51..54: SPAO{0.100000, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 55, 56, 63, 64, 66..73, 75, 76, 78..81, 133..143, 147, 190..207, 209..219, 221, 247..272, 274..288, 290..293: SPAO{0.070000, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 59..62: SPAO{0.079999, 0.029999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 77: SPAO{0.059999, 0.019999, 0.000000, 87.000000, 82.000000, 0.000000}
				case 85, 88, 89: SPAO{0.070000, 0.039999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 90..97: SPAO{0.050000, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 132: SPAO{0.000000, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 144..146: SPAO{0.090000, 0.000000, 0.000000, 88.000000, 82.000000, 0.000000}
				case 220: SPAO{0.029999, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 223, 246: SPAO{0.070000, 0.050000, 0.000000, 88.000000, 82.000000, 0.000000}
				case 224..245: SPAO{0.070000, 0.029999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 294: SPAO{0.070000, 0.019999, 0.000000, 91.000000, 84.000000, 0.000000}
				case 295: SPAO{0.050000, 0.019998, 0.000000, 86.000000, 82.000000, 0.000000}
				case 296..298: SPAO{0.064999, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000}
				case 299: SPAO{0.064998, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
		    }
		}
	}

	else
	{
		RemovePlayerAttachedObject(playerid, 0);
	}

	if(newstate == PLAYER_STATE_PASSENGER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(!IsVehicleHasDriver(vehicleid))
	    {
	        new Float:vx, Float:vy, Float:vz;
	        
	        GetVehiclePos(vehicleid, vx, vy, vz);
	        JBC_SetPlayerPos(playerid, vx, vy, vz+5);
	        SetTimerEx("Fix", 500, false, "ii", playerid, vehicleid);
	        SendClientMessage(playerid, -1, "{D90000}[GP.SEC] No puedes ingresar como acompañante si no hay conductor!!");
	        return 1;
	    }
	}
	
	#if defined PassengerAfterDriverLeave
	if(newstate == PLAYER_STATE_DRIVER) 
		return SetPVarInt(playerid, "vehicleid", GetPlayerVehicleID(playerid));
	
	if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER)
	{
	        for(new passengerid = 0; passengerid < MAX_PLAYERS; passengerid++)
	        {
	            if(IsPlayerConnected(passengerid) && GetPlayerVehicleID(passengerid) == GetPVarInt(playerid, "vehicleid"))
	            {
	                RemovePlayerFromVehicle(passengerid);
	                SendClientMessage(passengerid, 0xFF0000FF, "{D90000}[GP.SEC] El conductor abandon� el veh�culo!!");
	                    }
	            }
	            SetPVarInt(playerid, "vehicleid", 0);
	            return 1;
	    }
	    #endif
	    return 1;
}

JB_Function:HighlightTeamForPlayer(playerid, team = 0)
{
	switch(team)
	{
	    case 0: SetPlayerTeam(playerid, team);
	    case 1: SetPlayerTeam(playerid, team);
	    case 2: SetPlayerTeam(playerid, team);
	    case 3: SetPlayerTeam(playerid, team);
	    case 4: SetPlayerTeam(playerid, team);
	    case 5: SetPlayerTeam(playerid, team);
	    case 6: SetPlayerTeam(playerid, team);
	    case 7: SetPlayerTeam(playerid, team);
	    case 8: SetPlayerTeam(playerid, team);
	}

}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    if(newinteriorid != 0)
	PlayerTextDrawHide(playerid, ZoneTD);
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerCameraPos(playerid, 1057.7386,-1053.3350,34.0716);
    SetPlayerCameraLookAt(playerid, 1062.9983,-1053.4705,34.0716);
    //TogglePlayerSpectating(playerid, false);
	InClass[playerid] = true;
	Destroyed[playerid] = false;
    
    new 
    	NombreS[17], 
    	CantidadJ[300], 
    	Armas[100];
	
	ModoCine[playerid] = 0;
	
	//TextDrawHideForPlayer(playerid,Sprite);
    PlayerTextDrawHide(playerid, ZoneTD);
	PlayerTextDrawShow(playerid,Caja1);
	PlayerTextDrawShow(playerid,Caja2);
	// SELECCION DE EQUIPOS //
	switch(classid)
	{
	    case 0..3:

        {
        		HighlightTeamForPlayer(playerid, 0); //Groove
   			  	
   			  	PlayerTextDrawColor(playerid, TeamName, gTeam[GetPlayerTeam(playerid)][E_COLOR]); // red text
                PlayerTextDrawBoxColor(playerid,Armamento, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Informacion, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
				
				format(NombreS,sizeof(NombreS),"%s", gTeam[GetPlayerTeam(playerid)][E_NAME]);
				PlayerTextDrawSetString(playerid, TeamName, NombreS);
				
				format(CantidadJ,sizeof(CantidadJ),"JUGADORES EN EL EQUIPO: %i ~N~TERRITORIOS CONTROLADOS: %i/%i ~N~TERRITORIOS GANADOS/PERDIDOS: %d - %d ~N~ K/D EQUIPO: %d - %d ~N~ TEAM SCORE: %d", CountTeamPlayers(GetPlayerTeam(playerid)),CountTeamTurfs(GetPlayerTeam(playerid)),sizeof(gTurf), gTeam[GetPlayerTeam(playerid)][TurfWarsWon], gTeam[GetPlayerTeam(playerid)][TurfWarsLost], gTeam[GetPlayerTeam(playerid)][RivalsKilled], gTeam[GetPlayerTeam(playerid)][HomiesDied], gTeam[GetPlayerTeam(playerid)][TeamScore]);
				PlayerTextDrawSetString(playerid,TeamInfo, CantidadJ);
				format(Armas,sizeof(Armas),"~w~9mm~n~SPAS~n~MP5~n~Sniper~n~Bate~n~Spray");
				
				PlayerTextDrawSetString(playerid,TeamArmas, Armas);
				PlayerTextDrawShow(playerid,TeamInfo);
				PlayerTextDrawShow(playerid,TeamName);
				PlayerTextDrawShow(playerid,Informacion);
				PlayerTextDrawShow(playerid,TeamArmas);
				PlayerTextDrawShow(playerid,Armamento);
				
				JBC_SetPlayerPos(playerid, 2485.2590, -1638.9948, 25.1094);
				SetPlayerFacingAngle(playerid,185.9147);
                SetPlayerCameraPos(playerid, 2485.6392, -1645.2028, 24.9243);
                SetPlayerCameraLookAt(playerid, 2485.5073, -1644.2142, 24.9093);
		}
		case 4..7:
        {
        		HighlightTeamForPlayer(playerid, 1); // Ballas
				
				PlayerTextDrawHide(playerid,TeamInfo);
				PlayerTextDrawHide(playerid,TeamName);
				PlayerTextDrawHide(playerid,Informacion);
				PlayerTextDrawHide(playerid,TeamArmas);
				PlayerTextDrawHide(playerid,Armamento);
        		
        		PlayerTextDrawColor(playerid,TeamName, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Armamento, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Informacion, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
				
				format(NombreS,sizeof(NombreS),"%s", gTeam[GetPlayerTeam(playerid)][E_NAME]);
				PlayerTextDrawSetString(playerid,TeamName, NombreS);
				
				format(CantidadJ,sizeof(CantidadJ),"JUGADORES EN EL EQUIPO: %i ~N~TERRITORIOS CONTROLADOS: %i/%i ~N~TERRITORIOS GANADOS/PERDIDOS: %d - %d ~N~ K/D EQUIPO: %d - %d ~N~ TEAM SCORE: %d", CountTeamPlayers(GetPlayerTeam(playerid)),CountTeamTurfs(GetPlayerTeam(playerid)),sizeof(gTurf), gTeam[GetPlayerTeam(playerid)][TurfWarsWon]
				, gTeam[GetPlayerTeam(playerid)][TurfWarsLost], gTeam[GetPlayerTeam(playerid)][RivalsKilled], gTeam[GetPlayerTeam(playerid)][HomiesDied], gTeam[GetPlayerTeam(playerid)][TeamScore]);
				PlayerTextDrawSetString(playerid,TeamInfo, CantidadJ);
				
				format(Armas,sizeof(Armas),"~w~Desert Eagle~n~SPAS~n~UZI~n~Cuchillo~n~~r~Score:"#SCORES_BALLAS"");
				PlayerTextDrawSetString(playerid,TeamArmas, Armas);
				
				PlayerTextDrawShow(playerid,TeamInfo);
				PlayerTextDrawShow(playerid,TeamName);
				PlayerTextDrawShow(playerid,Informacion);
				PlayerTextDrawShow(playerid,TeamArmas);
				PlayerTextDrawShow(playerid,Armamento);
				
				JBC_SetPlayerPos(playerid, 2217.8694,-1179.5811,25.8906);
				SetPlayerFacingAngle(playerid,88.6038);
				SetPlayerCameraPos(playerid, 2209.2854,-1179.8859,25.8906);
				SetPlayerCameraLookAt(playerid,2217.8694,-1179.5811,25.8906);
				ApplyAnimation(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
		}
		case 8..10:
        {
        		HighlightTeamForPlayer(playerid, 2); //Nang
				
				PlayerTextDrawHide(playerid,TeamInfo);
				PlayerTextDrawHide(playerid,TeamName);
				PlayerTextDrawHide(playerid,Informacion);
				PlayerTextDrawHide(playerid,TeamArmas);
				PlayerTextDrawHide(playerid,Armamento);
        		PlayerTextDrawColor(playerid,TeamName, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Armamento, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Informacion, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
				
				format(NombreS,sizeof(NombreS),"%s", gTeam[GetPlayerTeam(playerid)][E_NAME]);
				PlayerTextDrawSetString(playerid,TeamName, NombreS);
				
				format(CantidadJ,sizeof(CantidadJ),"JUGADORES EN EL EQUIPO: %i ~N~TERRITORIOS CONTROLADOS: %i/%i ~N~TERRITORIOS GANADOS/PERDIDOS: %d - %d ~N~ K/D EQUIPO: %d - %d ~N~ TEAM SCORE: %d", CountTeamPlayers(GetPlayerTeam(playerid)),CountTeamTurfs(GetPlayerTeam(playerid)),sizeof(gTurf), gTeam[GetPlayerTeam(playerid)][TurfWarsWon]
				, gTeam[GetPlayerTeam(playerid)][TurfWarsLost], gTeam[GetPlayerTeam(playerid)][RivalsKilled], gTeam[GetPlayerTeam(playerid)][HomiesDied], gTeam[GetPlayerTeam(playerid)][TeamScore]);
				PlayerTextDrawSetString(playerid,TeamInfo, CantidadJ);
				
				format(Armas,sizeof(Armas),"~w~ 9mm silenciada~n~SPAS~n~M4~n~Sniper~n~Katana~n~~r~Score:"#SCORES_NANG"");
				PlayerTextDrawSetString(playerid,TeamArmas, Armas);
				
				PlayerTextDrawShow(playerid,TeamInfo);
				PlayerTextDrawShow(playerid,TeamName);
				PlayerTextDrawShow(playerid,Informacion);
				PlayerTextDrawShow(playerid,TeamArmas);
				PlayerTextDrawShow(playerid,Armamento);
				
				JBC_SetPlayerPos(playerid, 1269.2775,-1843.8937,13.3973);
				SetPlayerFacingAngle(playerid,192.4213);
				SetPlayerCameraPos(playerid, 1272.350097, -1851.347167, 16.814598);
				SetPlayerCameraLookAt(playerid, 1269.2775,-1843.8937,13.3973);
				ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0);
		}
		case 11..13: //Militar
        {
        		HighlightTeamForPlayer(playerid, 3);
				
				PlayerTextDrawHide(playerid,TeamInfo);
				PlayerTextDrawHide(playerid,TeamName);
				PlayerTextDrawHide(playerid,Informacion);
				PlayerTextDrawHide(playerid,TeamArmas);
				PlayerTextDrawHide(playerid,Armamento);
        		PlayerTextDrawColor(playerid,TeamName, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Armamento, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Informacion, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
				
				format(NombreS,sizeof(NombreS),"%s", gTeam[GetPlayerTeam(playerid)][E_NAME]);
				PlayerTextDrawSetString(playerid,TeamName, NombreS);
				
				format(CantidadJ,sizeof(CantidadJ),"JUGADORES EN EL EQUIPO: %i ~N~TERRITORIOS CONTROLADOS: %i/%i ~N~TERRITORIOS GANADOS/PERDIDOS: %d - %d ~N~ K/D EQUIPO: %d - %d ~N~ TEAM SCORE: %d", CountTeamPlayers(GetPlayerTeam(playerid)),CountTeamTurfs(GetPlayerTeam(playerid)),sizeof(gTurf), gTeam[GetPlayerTeam(playerid)][TurfWarsWon]
				, gTeam[GetPlayerTeam(playerid)][TurfWarsLost], gTeam[GetPlayerTeam(playerid)][RivalsKilled], gTeam[GetPlayerTeam(playerid)][HomiesDied], gTeam[GetPlayerTeam(playerid)][TeamScore]);
				PlayerTextDrawSetString(playerid,TeamInfo, CantidadJ);
				
				format(Armas,sizeof(Armas),"~w~Desert Eagle~n~SPAS~n~mp5~n~Sniper~n~Encendedor~n~~r~Score:"#SCORES_MILITARES"");
				PlayerTextDrawSetString(playerid,TeamArmas, Armas);
				
				PlayerTextDrawShow(playerid,TeamInfo);
				PlayerTextDrawShow(playerid,TeamName);
				PlayerTextDrawShow(playerid,Informacion);
				PlayerTextDrawShow(playerid,TeamArmas);
				PlayerTextDrawShow(playerid,Armamento);
				
				JBC_SetPlayerPos(playerid, 2748.1182,-2445.5627,13.6484);
				SetPlayerFacingAngle(playerid,97.9059);
				SetPlayerCameraPos(playerid, 2737.003417, -2448.273437, 21.070304);
				SetPlayerCameraLookAt(playerid, 2748.1182,-2445.5627,13.6484);
				ApplyAnimation(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
		}
		case 14..18: //MErcenarios
        {
        		HighlightTeamForPlayer(playerid, 4);
				
				PlayerTextDrawHide(playerid,TeamInfo);
				PlayerTextDrawHide(playerid,TeamName);
				PlayerTextDrawHide(playerid,Informacion);
				PlayerTextDrawHide(playerid,TeamArmas);
				PlayerTextDrawHide(playerid,Armamento);
        		PlayerTextDrawColor(playerid,TeamName, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Armamento, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Informacion, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
				
				format(NombreS,sizeof(NombreS),"%s", gTeam[GetPlayerTeam(playerid)][E_NAME]);
				PlayerTextDrawSetString(playerid,TeamName, NombreS);
				
				format(CantidadJ,sizeof(CantidadJ),"JUGADORES EN EL EQUIPO: %i ~N~TERRITORIOS CONTROLADOS: %i/%i ~N~TERRITORIOS GANADOS/PERDIDOS: %d - %d ~N~ K/D EQUIPO: %d - %d ~N~ TEAM SCORE: %d", CountTeamPlayers(GetPlayerTeam(playerid)),CountTeamTurfs(GetPlayerTeam(playerid)),sizeof(gTurf), gTeam[GetPlayerTeam(playerid)][TurfWarsWon]
				, gTeam[GetPlayerTeam(playerid)][TurfWarsLost], gTeam[GetPlayerTeam(playerid)][RivalsKilled], gTeam[GetPlayerTeam(playerid)][HomiesDied], gTeam[GetPlayerTeam(playerid)][TeamScore]);
				PlayerTextDrawSetString(playerid,TeamInfo, CantidadJ);
				
				format(Armas,sizeof(Armas),"~w~Armadura extra~n~Desert Eagle~n~SPAS~n~M4~n~Sniper~n~~y~Solo VIPS");
				PlayerTextDrawSetString(playerid,TeamArmas, Armas);
				
				PlayerTextDrawShow(playerid,TeamInfo);
				PlayerTextDrawShow(playerid,TeamName);
				PlayerTextDrawShow(playerid,Informacion);
				PlayerTextDrawShow(playerid,TeamArmas);
				PlayerTextDrawShow(playerid,Armamento);
				
				JBC_SetPlayerPos(playerid, 3254.4651, -1911.6868, 28.3043);
				SetPlayerFacingAngle(playerid,58.1724);
                SetPlayerCameraPos(playerid, 3250.3628, -1908.2246, 28.5165);
                SetPlayerCameraLookAt(playerid, 3251.2261, -1908.7277, 28.6164);
				ApplyAnimation(playerid,"COLT45", "colt45_reload", 3.0, 0, 0, 0, 0, 0);



		}
		case 19..24: //vagabundos
        {
        		HighlightTeamForPlayer(playerid, 5);
				
				PlayerTextDrawHide(playerid,TeamInfo);
				PlayerTextDrawHide(playerid,TeamName);
				PlayerTextDrawHide(playerid,Informacion);
				PlayerTextDrawHide(playerid,TeamArmas);
				PlayerTextDrawHide(playerid,Armamento);
        		PlayerTextDrawColor(playerid,TeamName, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Armamento, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
                PlayerTextDrawBoxColor(playerid,Informacion, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
				
				format(NombreS,sizeof(NombreS),"%s", gTeam[GetPlayerTeam(playerid)][E_NAME]);
				PlayerTextDrawSetString(playerid,TeamName, NombreS);
				
				format(CantidadJ,sizeof(CantidadJ),"JUGADORES EN EL EQUIPO: %i ~N~TERRITORIOS CONTROLADOS: %i/%i ~N~TERRITORIOS GANADOS/PERDIDOS: %d - %d ~N~ K/D EQUIPO: %d - %d ~N~ TEAM SCORE: %d", CountTeamPlayers(GetPlayerTeam(playerid)),CountTeamTurfs(GetPlayerTeam(playerid)),sizeof(gTurf), gTeam[GetPlayerTeam(playerid)][TurfWarsWon]
				, gTeam[GetPlayerTeam(playerid)][TurfWarsLost], gTeam[GetPlayerTeam(playerid)][RivalsKilled], gTeam[GetPlayerTeam(playerid)][HomiesDied], gTeam[GetPlayerTeam(playerid)][TeamScore]);
				PlayerTextDrawSetString(playerid,TeamInfo, CantidadJ);
				
				format(Armas,sizeof(Armas),"~w~Desert eagle~n~SPAS~n~M4~n~Mp5~n~Sniper~n~~r~Score:"#SCORES_VAGABUNDOS"");
				PlayerTextDrawSetString(playerid,TeamArmas, Armas);
				
				PlayerTextDrawShow(playerid,TeamInfo);
				PlayerTextDrawShow(playerid,TeamName);
				PlayerTextDrawShow(playerid,Informacion);
				PlayerTextDrawShow(playerid,TeamArmas);
				PlayerTextDrawShow(playerid,Armamento);
				
				JBC_SetPlayerPos(playerid, 2200.8977, -1907.2947, 13.5469);
				JBC_GivePlayerWeapon(playerid, 24 ,7);
				SetPlayerFacingAngle(playerid,178.6017);
                SetPlayerCameraPos(playerid, 2200.0830, -1912.0371, 14.3950);
                SetPlayerCameraLookAt(playerid, 2200.1226, -1911.0394, 14.3550);
				ApplyAnimation(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0);

		}
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	switch(GetPlayerTeam(playerid))
	{
		case 1:
		{
			if(GetPlayerScore(playerid) < SCORES_BALLAS)
			{
				SendClientMessage(playerid,-1, "{EC1B03}[ERROR] Necesitas "#SCORES_BALLAS" score para ser parte de este team.");
       			return 0;
			}
		}
		case 2:
		{
			if(GetPlayerScore(playerid) < SCORES_NANG)
			{
				SendClientMessage(playerid,-1, "{EC1B03}[ERROR] Necesitas "#SCORES_NANG" score para ser parte de este team.");
       			return 0;
			}

		}
		case 3:
		{
			if(GetPlayerScore(playerid) < SCORES_MILITARES)
			{
				SendClientMessage(playerid,-1,"{EC1B03}[ERROR] Necesitas "#SCORES_MILITARES" score para ser parte de este team.");
	   			return 0;
			}

		}
		case 4:
		{
			if(CheckVip(playerid) < 1)
			{
				SendClientMessage(playerid,-1,"{EC1B03}[ERROR] Necesitas ser VIP nivel 2 para acceder al team mercenarios.");
	   			return 0;
			}
		}
		case 5:
		{
			if(GetPlayerScore(playerid) < SCORES_VAGABUNDOS)
			{
				SendClientMessage(playerid,-1,"{EC1B03}[ERROR] Necesitas "#SCORES_VAGABUNDOS" score para ser parte de este team.");
	   			return 0;
			}
		}
	}
    return 1;
}

public OnPlayerSpawn(playerid)
{

	if(GetPlayerTeam(playerid) >0 && GetPlayerTeam(playerid) != NO_TEAM)
	{
		LastTeam[playerid] = GetPlayerTeam(playerid);
	}

	if(GetPlayerSkin(playerid)  >= 1 && GetPlayerSkin(playerid) <=311)
	{
		LastSkin[playerid] = GetPlayerSkin(playerid);
	}

	switch(CheckVip(playerid))
	{
		case 1:
		{
			JBC_SetPlayerArmour(playerid, 30);
			//code
		}
		case 2:
		{
			JBC_SetPlayerArmour(playerid, 70);
			//code
		}
	}
    InClass[playerid] = false;
    
    PlayerPlaySound(playerid, 1149, 0.0, 0.0, 10.0);
    PlayerTextDrawShow(playerid,Date);
    PlayerTextDrawShow(playerid, ZoneTD);
    SetCameraBehindPlayer(playerid);
    
    if(Destroyed[playerid] == false)
    {
       DestroyTDEquipos(playerid);
    }

	switch(GetPlayerTeam(playerid))
	{
		case 0://groove
		{

		new rand = random(sizeof(SPAWN_0));
		JBC_SetPlayerPosEx(playerid, SPAWN_0[rand][0], SPAWN_0[rand][1], SPAWN_0[rand][2], SPAWN_0[rand][3]);

		JBC_GivePlayerWeapon(playerid,22,1000);
		JBC_GivePlayerWeapon(playerid,27,1000);
		JBC_GivePlayerWeapon(playerid,29,1000);
		JBC_GivePlayerWeapon(playerid,34,1000);
		JBC_GivePlayerWeapon(playerid,5,1);
		JBC_GivePlayerWeapon(playerid,41,500);
		SetPlayerColor(playerid, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
		JBC_ResetPlayerPos(playerid);
		}
		case 1://ballas
		{

			CheckRequestScore(playerid, SCORES_BALLAS);
			new rand = random(sizeof(SPAWN_1));
			JBC_SetPlayerPosEx(playerid, SPAWN_1[rand][0], SPAWN_1[rand][1], SPAWN_1[rand][2], SPAWN_1[rand][3]);
			JBC_GivePlayerWeapon(playerid,24,1000);
			JBC_GivePlayerWeapon(playerid,27,1000);
			JBC_GivePlayerWeapon(playerid,28,1000);
			JBC_GivePlayerWeapon(playerid,4,1000);
			SetPlayerColor(playerid, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
			JBC_ResetPlayerPos(playerid);
		}
		case 2://nang
		{
			CheckRequestScore(playerid, SCORES_NANG);

			new rand = random(sizeof(SPAWN_4));
			JBC_SetPlayerPosEx(playerid, SPAWN_4[rand][0], SPAWN_4[rand][1], SPAWN_4[rand][2], SPAWN_4[rand][3]);

			JBC_GivePlayerWeapon(playerid,23,1000);
			JBC_GivePlayerWeapon(playerid,27,1000);
			JBC_GivePlayerWeapon(playerid,31,1000);
			JBC_GivePlayerWeapon(playerid,34,1000);
			JBC_GivePlayerWeapon(playerid,34,8);
			SetPlayerColor(playerid, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
			JBC_ResetPlayerPos(playerid);
		}
		case 3://militares
		{
			CheckRequestScore(playerid, SCORES_MILITARES);
			new rand = random(sizeof(SPAWN_8));
			JBC_SetPlayerPosEx(playerid, SPAWN_8[rand][0], SPAWN_8[rand][1], SPAWN_8[rand][2], SPAWN_8[rand][3]);

			JBC_GivePlayerWeapon(playerid,24,1000);
			JBC_GivePlayerWeapon(playerid,27,1000);
			JBC_GivePlayerWeapon(playerid,29,1000);
			JBC_GivePlayerWeapon(playerid,34,10000);
			JBC_GivePlayerWeapon(playerid,31,1000);
			JBC_GivePlayerWeapon(playerid,37, 100);
			SetPlayerColor(playerid, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
			JBC_ResetPlayerPos(playerid);
		}
		case 4://mercenarios
		{
			if(CheckVip(playerid)<1)
				return SendClientMessage(playerid, 0xEB323CFF, "[GP] Lo sentimos, no posees membres�a VIP.");

			new rand = random(sizeof(SPAWN_13));
			JBC_SetPlayerPosEx(playerid, SPAWN_13[rand][0], SPAWN_13[rand][1], SPAWN_13[rand][2], SPAWN_13[rand][3]);

			JBC_GivePlayerWeapon(playerid,24,1000);
			JBC_GivePlayerWeapon(playerid,27,1000);
			JBC_GivePlayerWeapon(playerid,31,1000);
			JBC_GivePlayerWeapon(playerid,34,1000);
			SetPlayerColor(playerid, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
			JBC_ResetPlayerPos(playerid);
		}
		case 5://vagabundos
		{
			CheckRequestScore(playerid, SCORES_VAGABUNDOS);
			new rand = random(sizeof(SPAWN_14));
			JBC_SetPlayerPosEx(playerid, SPAWN_14[rand][0], SPAWN_14[rand][1], SPAWN_14[rand][2], SPAWN_14[rand][3]);

			JBC_GivePlayerWeapon(playerid,24,1000);
			JBC_GivePlayerWeapon(playerid,27,1000);
			JBC_GivePlayerWeapon(playerid,29,1000);
			JBC_GivePlayerWeapon(playerid,31,10000);
			JBC_GivePlayerWeapon(playerid,34,10000);
			SetPlayerColor(playerid, gTeam[GetPlayerTeam(playerid)][E_COLOR]);
			JBC_ResetPlayerPos(playerid);
		}
	}

				//flashing the gangzones which are under attack
	for(new i; i < sizeof(gTurf); i++)
	{
	if(gTurf[i][t_attacked]) 
	GangZoneFlashForPlayer(playerid, gTurf[i][t_turf], gTeam[ (gTurf[i][t_attacker]) ][E_COLOR]);
	}
		               
	return 1;
}

//------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
 	if(IsPlayerConnected(killerid) && killerid != INVALID_PLAYER_ID)
    {
        ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop",4.1,0,1,1,1,1);
		//turf war generator
		for(new i; i < sizeof(gTurf); i++)
		{
		    if(IsPlayerInGangZone(playerid, gTurf[i][t_turf]))
		    {
		        if(! gTurf[i][t_attacked])
	      		{
				  	if(GetPlayerTeam(killerid) != gTurf[i][t_owner])
		        	{
			            if(gTurf[i][t_kills][1] >= STARTUP_KILLS)
			            {
			                gTurf[i][t_started] = false;
		       				gTurf[i][t_timertick] = 0;
							gTurf[i][t_attacked] = true;
							gTurf[i][t_attacker] = GetPlayerTeam(killerid);

						    //start war
						    GangZoneFlashForAll(gTurf[i][t_turf], gTeam[ (gTurf[i][t_attacker]) ][E_COLOR]);
						    //message
					    	CallLocalFunction("OnTurfWarStart", "iii", i, gTurf[i][t_owner], gTurf[i][t_attacker]);
			                break;
			            }
						gTurf[i][t_kills][1] += 1;
						break;
					}
				}
				else
				{
					if(GetPlayerTeam(playerid) == gTurf[i][t_attacker])
					{
						gTurf[i][t_kills][0] += 1;
					}
					if(GetPlayerTeam(playerid) == gTurf[i][t_owner])
					{
						gTurf[i][t_kills][1] += 1;
					}
					break;
				}
			}
		}
	}
	
	BloqueoCK[playerid] = 0;
    IsSpecating[playerid] = 1;
    SendDeathMessage(killerid, playerid, reason);
    if(killerid != INVALID_PLAYER_ID)// DeathCamera
    {
	   if(IsSpecating[playerid] == 1)
	   {
	       TogglePlayerSpectating(playerid, true);
	       PlayerSpectatePlayer(playerid, killerid);
		   SetTimerEx("StopSpec", 2000, false, "i", playerid);
	       return 1;
       }
   }
    if(killerid != INVALID_PLAYER_ID)
	{
      if(DamageTaken[playerid] == 0)// Anti-FakeKill
      {
	    SendClientMessage(playerid, -1, "{FF0005}[GP.SEC] �Has sido baneado por Fake-Kill!");
        SetTimerEx("BanTimer", 10, 0, "i", playerid);
      }
	  
	  if(killerid == playerid)
	  {
	          SendClientMessage(playerid, -1, "{FF0005}[GP.SEC] �Has sido baneado por Fake-Kill!");
	          SetTimerEx("BanTimer", 10, 0, "i", playerid);
      }
	  if(DamageTaken[playerid] == 1)
	  {
		  SetTimerEx("DamageTimer", 10, false, "i", playerid);
	  }

	  return 1;
	  }
   
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success)
    {
    	if(IsPlayerInFirstSpawn(playerid) == 1)
    	{
	  		new msg[130];
	    	PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
	    	format(msg, sizeof(msg), "GP: {ffff00}El comando {FFFFFF}'%s'{FFFFFF}{ffff00} no existe. Usa /comandos", cmdtext);
	    	SendClientMessage(playerid, COLOR_RED, msg);
		}
    }
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_TEAMS)
	{
	    if(response)
	    {
			ShowPlayerDialogf(playerid,
			DIALOG_ZONES,
			DIALOG_STYLE_MSGBOX,
			"Estad�sticas de tu equipo",
			""white"Equipo: "green"%s\n\
			"white"Territorios bajo control: "green"%i de %i\n\
			"white"Zonas ganadas/perdidas: "green"%i || %i\n\
			"white"Asesinatos/muertes: "green"%i || %i\n\
			"white"Miembros conectados: "green"%i\n\
			"white"Score total: "red"%i",
			""white"Cerrar",
			"",
			gTeam[listitem][E_NAME],
			(listitem + 1),
			sizeof(gTurf),
			CountTeamPlayers(listitem),
			gTeam[(listitem)][TurfWarsWon],
			gTeam[(listitem)][TurfWarsLost],
			gTeam[(listitem)][RivalsKilled],
			gTeam[(listitem)][HomiesDied],
			CountTeamPlayers(listitem),
			gTeam[listitem][TeamScore]);
	     }
	}

    return 1;
}

public OnPlayerUpdate(playerid)
{
	if(GetTickCount() - armedbody_pTick[playerid] > 113)
	{
		new Float:armour, PlayerArmour;
		PlayerArmour = GetPlayerArmour(playerid, armour);
        if(PlayerArmour == 0) 
        {
        	RemovePlayerAttachedObject(playerid, 9);
        }
        new weaponid[13],weaponammo[13],pArmedWeapon;
        pArmedWeapon = GetPlayerWeapon(playerid);
        GetPlayerWeaponData(playerid,1,weaponid[1],weaponammo[1]);
        GetPlayerWeaponData(playerid,2,weaponid[2],weaponammo[2]);
        GetPlayerWeaponData(playerid,4,weaponid[4],weaponammo[4]);
        GetPlayerWeaponData(playerid,5,weaponid[5],weaponammo[5]);
        GetPlayerWeaponData(playerid,7,weaponid[7],weaponammo[7]);
        
        if(weaponid[1] && weaponammo[1] > 0)
        {
            if(pArmedWeapon != weaponid[1])
            {
                if(!IsPlayerAttachedObjectSlotUsed(playerid,0))
                    {
                        SetPlayerAttachedObject(playerid,0,GetWeaponModel(weaponid[1]),1, 0.199999, -0.139999, 0.030000, 0.500007, -115.000000, 0.000000, 1.000000, 1.000000, 1.000000);
                    }
             }
                        else 
                        {
                            if(IsPlayerAttachedObjectSlotUsed(playerid,0))
                            {
                                RemovePlayerAttachedObject(playerid,0);
                            }
                        }
                }
                else if(IsPlayerAttachedObjectSlotUsed(playerid,0))
                {
                    RemovePlayerAttachedObject(playerid,0);
                }
               
        if(weaponid[2] && weaponammo[2] > 0)
                    {
                    if(pArmedWeapon != weaponid[2]){
                            if(!IsPlayerAttachedObjectSlotUsed(playerid,1))
                                {
                                    SetPlayerAttachedObject(playerid,1,GetWeaponModel(weaponid[2]),8, -0.079999, -0.039999, 0.109999, -90.100006, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
                                }
                    }
                        else 
                        {
                            if(IsPlayerAttachedObjectSlotUsed(playerid,1))
                            {
                            RemovePlayerAttachedObject(playerid,1);
                                }
                        }
                }
                else if(IsPlayerAttachedObjectSlotUsed(playerid,1)){
                        RemovePlayerAttachedObject(playerid,1);
                }
        
        if(weaponid[4] && weaponammo[4] > 0)
                {
                   if(pArmedWeapon != weaponid[4])
                   {
                                if(!IsPlayerAttachedObjectSlotUsed(playerid,2))
                                {
                                    SetPlayerAttachedObject(playerid,2,GetWeaponModel(weaponid[4]),7, 0.000000, -0.100000, -0.080000, -95.000000, -10.000000, 0.000000, 1.000000, 1.000000, 1.000000);
                                }
                    }
                        else 
                        {
                                if(IsPlayerAttachedObjectSlotUsed(playerid,2))
                                {
                                    RemovePlayerAttachedObject(playerid,2);
                                }
                        }
                }
                else if(IsPlayerAttachedObjectSlotUsed(playerid,2)){
                        RemovePlayerAttachedObject(playerid,2);
                }
        
        if(weaponid[5] && weaponammo[5] > 0){
                        if(pArmedWeapon != weaponid[5]){
                                if(!IsPlayerAttachedObjectSlotUsed(playerid,3)){
                                        SetPlayerAttachedObject(playerid,3,GetWeaponModel(weaponid[5]),1, 0.200000, -0.119999, -0.059999, 0.000000, 206.000000, 0.000000, 1.000000, 1.000000, 1.000000);
                                }
                        }
                        else {
                                if(IsPlayerAttachedObjectSlotUsed(playerid,3)){
                                        RemovePlayerAttachedObject(playerid,3);
                                }
                        }
                }
                else if(IsPlayerAttachedObjectSlotUsed(playerid,3)){
                        RemovePlayerAttachedObject(playerid,3);
                }

        if(weaponid[7] && weaponammo[7] > 0){
                        if(pArmedWeapon != weaponid[7]){
                                if(!IsPlayerAttachedObjectSlotUsed(playerid,4)){
                                        SetPlayerAttachedObject(playerid,4,GetWeaponModel(weaponid[7]),1,-0.100000, 0.000000, -0.100000, 84.399932, 112.000000, 10.000000, 1.099999, 1.000000, 1.000000);
                                }
                        }
                        else {
                                if(IsPlayerAttachedObjectSlotUsed(playerid,4)){
                                        RemovePlayerAttachedObject(playerid,4);
                                }
                        }
                }
                else if(IsPlayerAttachedObjectSlotUsed(playerid,4)){
                        RemovePlayerAttachedObject(playerid,4);
                }

        armedbody_pTick[playerid] = GetTickCount();
        }
    return true;
}//4slots para armas

CMD:miprenda(playerid, params[])
{
if(CheckPlayerAdmin(playerid) == 10)
{
	SetPlayerAttachedObject(playerid, 5, 18636, 2, 0.1770, 0.0479, -0.0000, 71.5000, 92.9000, 12.6999, 1.0000, 1.0000, 1.0000, 0xFFBA55D3, 0xFF8A2BE2); // PoliceCap1 attached to the Head of Jefferson[iL]
    SetPlayerAttachedObject(playerid, 6, 19026, 2, 0.0910, 0.0460, -0.0080, 58.0000, 88.7000, 38.5999, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF); // GlassesType21 attached to the Head of Jefferson[iL]
    SetPlayerAttachedObject(playerid, 7, 19079, 1, 0.2219, -0.0600, 0.1750, 0.0000, 0.0000, 0.0000, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF); // TheParrot2 attached to the Spine of Jefferson[iL]
}
return 1;
}

public OnPlayerText(playerid,text[])
{

	if(IsPlayerConnected(playerid))
	{
	    if(strfind(text, "/q", true) != -1)
	    {
	        SendClientMessage(playerid, 0xFF0000FF, "[GP.{FFFFFF}SEC] "red"No puedes escribir {ffffff}'/q' "red"en el chat p�blico.");
	        return 0;
	    }

		if(text[0] == '!')
		{
	        new string[128];
		    format(string, sizeof (string), "[Chat Equipo] %s [%d]:{FFFFFF} %s", pName(playerid), playerid, text[1]);
			printf("%s", string);
			OnPlayerSendMessageToGang(playerid,string);
		    OnAdminReceiveMessageToGang(playerid,string);
			return 0;
		}

		new msg[128];
		format(msg,sizeof(msg),"%s[%i]: {FFFFFF}%s",pName(playerid),playerid,text);
	 	SendMessageToAll(GetPlayerColor(playerid), msg);
	 	//SendClientMessageToAll(GetPlayerColor(playerid),msg);
	 	format(msg,sizeof(msg),"%s[%i]: %s",pName(playerid), playerid, text);
	 	print(msg);
		SetPlayerChatBubble(playerid, text, GetPlayerColor(playerid), 100.0, 10000);
		return 0;
	}
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
    new str[50];
    if(TiempoDmgB[playerid] != 0) KillTimer(TiempoDmgB[playerid]);
    DmgB[playerid] += amount;
    format(str,sizeof(str),"~y~%s ~n~~y~-%.0f %s", pName(damagedid), DmgB[playerid], weaponNames[weaponid]);
    PlayerTextDrawSetString(playerid, IndiB[playerid], str);

    TiempoDmgB[playerid] = SetTimerEx("RDDB", 3000, 0, "i", playerid);
    PlayerTextDrawShow(playerid, IndiB[playerid]);
    return 1;
 }

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(! ispassenger)//if the player is entering as a driver
	{
		new target = INVALID_PLAYER_ID;//by default, an invalid player
		foreach(new i : Player)
		{
		    if( i != playerid//if the loop case is not matching the playerid
				&& IsPlayerConnected(i)//if the player is connected
				&& GetPlayerVehicleID(i) == vehicleid//if the player is in vehicle that got hit
				&& GetPlayerVehicleSeat(i) == 0)//if is driver

		    {
				target = i;//store the playerid in "target" variable
				break;//stop the loop and continue
		    }
		}
		if( target != INVALID_PLAYER_ID
		    && GetPlayerTeam(playerid) != NO_TEAM
		    && GetPlayerTeam(playerid) == GetPlayerTeam(target))//if the target player is having same team id that of the shooter
    	{
            ClearAnimations(playerid);//detiene todas las animaciones.
			new Float:x, Float:y, Float:z;//Fload de coordenadas.
			GetPlayerPos(playerid, x, y, z);//obtiene coordenadas X, Y, Z del jugador-
			JBC_SetPlayerPos(playerid, x, y, z);//lo regresa a su ubicaciГіn.
			SetPlayerVirtualWorld(playerid, 3);//lo lleva al mundo virtual nГєmero tres.
			JBC_TogglePlayerControllable(playerid, 0);//congela al jugador
			SetTimerEx("AntiCJ", 3000, 0, "d", playerid);//descongela al jugador
			SetTimerEx("WorldVirtual", 3000, 0, "d", playerid);//envГ­a al jugador al mundo virtual 0
			SendClientMessage(playerid, COLOR_RED, "[INFO]{FFFFFF} No puedes robar el veh�culo de tus compa�eros, quedas congelado por tres segundos, lee /reglas.");
			return 0;//stop the player to take over the vehicle and the action to be taken
	  	}
	}
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    KillTimer(AntiCJ(playerid));

	return 1;
}

public OnPlayerShootVehiclePart(playerid, weaponid, vehicleid, hittype)
{
	//petrol cap destroy system
    if(hittype == BULLET_HIT_PETROL_TANK)//when player shoots on the petrol cap of a vehicle
	{
		foreach(new i : Player)
		{
		    if(	GetPlayerState(i) == PLAYER_STATE_DRIVER &&
				GetPlayerVehicleID(i) == vehicleid)
		    {
		        new Float:x, Float:y, Float:z;
				GetVehiclePos(vehicleid, x, y, z);
				JBC_SetVehicleHealth(vehicleid, 200);
				SetVehicleToRespawn(vehicleid);
				GameTextForPlayer(i, "~p~~h~TANQUE DE GASOLINA HA EXPLOTADO !", 5000, 1);
				GameTextForPlayer(playerid, "~y~~h~~h~~h~TANQUE DE GASOLINA HA EXPLOTADO !", 5000, 1);
				PlayerPlaySound(i, 1053, 0.0, 0.0, 0.0);
				PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
		        return 1;
		    }
		}
	}
	return 1;
}

//---------------------------Callbacks no nativos----------------------------------------------------------
JB_PUBLIC OnTurfsUpdate()
{
    for(new x; x < sizeof(gTurf); x++)
	{
		//lets make turf wars!
		if(! gTurf[x][t_attacked])//if war haven't started
		{
		    //now with new team balancer, priority to that team with more members!
  			if(! gTurf[x][t_started])//if just entered
        	{
                new bool:noteam = true;
				if(noteam)
				{
				    for(new t; t < MAX_TEAMS; t++)
					{
					    if(t != gTurf[x][t_owner])
					    {
					        if(GetPlayersInTurf(x, t) >= STARTUP_MEMBERS)
					        {
								gTurf[x][t_started] = true;
					            gTurf[x][t_timertick] = STARTUP_TIME;
								gTurf[x][t_attacker] = t;
								foreach(new i : Player)
								{
									if(	IsPlayerInGangZone(i, gTurf[x][t_turf]) && GetPlayerTeam(i) == gTurf[x][t_attacker] && ! GetPlayerInterior(i) && ! GetPlayerVirtualWorld(i))
									{
										PlayerTextDrawShow(i, gTurfwarStartTD);
										PlayerTextDrawSetStringf(i, gTurfwarStartTD, "Coquistando en %d segundos...", gTurf[x][t_timertick]);
								   	}
								}
							}
						}
					}
				}
			}
			else//if timer has begun
			{
    			if(GetPlayersInTurf(x, gTurf[x][t_attacker]) < STARTUP_MEMBERS)
				{
			       	GangZoneStopFlashForAll(gTurf[x][t_turf]);
					foreach(new i : Player)
					{
						if(	IsPlayerInGangZone(i, gTurf[x][t_turf]) &&
							GetPlayerTeam(i) == gTurf[x][t_attacker])
					    {
							PlayerTextDrawHide(i, gTurfwarStartTD);
					   	}
					}
 		         	gTurf[x][t_started] = false;
			       	gTurf[x][t_timertick] = -1;
    				gTurf[x][t_attacker] = NO_TEAM;
				}
	    		else
				{
		    		if(gTurf[x][t_timertick] == 0)
					{
						foreach(new i : Player)
						{
						    if(	IsPlayerInGangZone(i, gTurf[x][t_turf]) &&
								GetPlayerTeam(i) == gTurf[x][t_attacker])
						    {
								PlayerTextDrawHide(i, gTurfwarStartTD);
						   	}
						}

						gTurf[x][t_started] = false;
	       				gTurf[x][t_timertick] = 0;
	       				for(new k; k < 2; k++)
	       				{
	       					gTurf[x][t_kills][k] = 0;
					    }
						gTurf[x][t_attacked] = true;

					    //Empezar guerra
					    GangZoneFlashForAll(gTurf[x][t_turf], gTeam[ (gTurf[x][t_attacker]) ][E_COLOR]);
					    //Mensaje
				    	CallLocalFunction("OnTurfWarStart", "iii", x, gTurf[x][t_owner], gTurf[x][t_attacker]);
					}
					else
					{
						gTurf[x][t_timertick] -= 1;
						foreach(new i : Player)
						{
						    if(	IsPlayerInGangZone(i, gTurf[x][t_turf]) &&
								GetPlayerTeam(i) == gTurf[x][t_attacker] &&
								! GetPlayerInterior(i) &&
								! GetPlayerVirtualWorld(i))
						    {
								PlayerTextDrawSetStringf(i, gTurfwarStartTD, "Conquistando en %d segundos.", gTurf[x][t_timertick]);
//								PlayerTextDrawColor(i, gTurfwarStartTD, COLOR_BLACK);
					       	}
						}
					}
				}
			}
		}
		else//if war had started
		{
			if(GetPlayersInTurf(x, gTurf[x][t_attacker]) < STARTUP_MEMBERS)
  			{
  			KillTimer(CallDestroy1());
  			KillTimer(CallDestroy2());
  			TextDrawDestroy(Conquista1);
  			TextDrawDestroy(Conquista2);
  			conquista3 = false;
   		    ConquistaCaja3 = TextDrawCreate(634.503845, 105.333335, "usebox");
    		TextDrawLetterSize(ConquistaCaja3, 0.000000, 8.254450);
    		TextDrawTextSize(ConquistaCaja3, 506.814086, 0.000000);
    		TextDrawAlignment(ConquistaCaja3, 1);
    		TextDrawColor(ConquistaCaja3, 0);
    		TextDrawUseBox(ConquistaCaja3, true);
    		TextDrawBoxColor(ConquistaCaja3, 102);
			TextDrawSetShadow(ConquistaCaja3, 0);
    		TextDrawSetOutline(ConquistaCaja3, 0);
    		TextDrawFont(ConquistaCaja3, 0);

			new msg[250];
			//0.180600, 1.588333
			format(msg, sizeof(msg), "%s no ha podido ~n~conquistar la %s~n~ de %s porque~n~ faltaron miembros.", gTeam[gTurf[x][t_attacker]][E_NAME], gTurf[x][t_name], gTeam[gTurf[x][t_owner]][E_NAME]);
    		Conquista3 = TextDrawCreate(512.093566, 107.916671, msg);
    		TextDrawSetString(Conquista3, msg);
    		TextDrawLetterSize(Conquista3, 0.180600, 1.588333);
    		TextDrawAlignment(Conquista3, 1);
    		TextDrawColor(Conquista3, -1);
    		TextDrawSetShadow(Conquista3, 0);
    		TextDrawSetOutline(Conquista3, 1);
 		    TextDrawBackgroundColor(Conquista3, 51);
    		TextDrawFont(Conquista3, 1);
    		TextDrawSetProportional(Conquista3, 1);

            TextDrawShowForAll(ConquistaCaja3);
            TextDrawShowForAll(Conquista3);
            SaveTStats();
            SaveZones();

            SetTimer("CallDestroy3", 10000, false);

            if(conquista3 == true)
            {
            KillTimer(CallDestroy3());
            }
            foreach(new i : Player)
			{
			PlayerTextDrawHide(i, gTurfwarStartTD);
			}

            SaveTStats();
            SaveZones();
            foreach(new i : Player)
				{
					if(	IsPlayerInGangZone(i, gTurf[x][t_turf]))
					{
						SetPlayerProgressBarValue(i, gTurfwarBar[i][0], 0.0);
						SetPlayerProgressBarValue(i, gTurfwarBar[i][1], 0.0);

						SetPlayerProgressBarColour(i, gTurfwarBar[i][0], 0);
						SetPlayerProgressBarColour(i, gTurfwarBar[i][1], 0);

					    HidePlayerProgressBar(i, gTurfwarBar[i][0]);
						HidePlayerProgressBar(i, gTurfwarBar[i][1]);

						PlayerTextDrawHide(i, gTurfwarTeamsTD[i][0]);
						PlayerTextDrawHide(i, gTurfwarTeamsTD[i][1]);
					}
			    }

		    gTurf[x][t_attacker] = NO_TEAM;
			gTurf[x][t_attacked] = false;
			
			for(new k; k < 2; k++)
				{
					gTurf[x][t_kills][k] = 0;
				}
				
			gTurf[x][t_started] = false;
				//destroy the timer
			KillTimer(gTurf[x][t_timer]);
			gTurf[x][t_timer] = -1;
		    gTurf[x][t_timertick] = -1;
				//stop war
		    GangZoneStopFlashForAll(gTurf[x][t_turf]);

  			}
  			else
  			{
  			    if(gTurf[x][t_timertick] >= TURFWAR_TIME)
  			    {
  			        return CallLocalFunction("OnTurfWarStop", "iii", x, gTurf[x][t_owner], gTurf[x][t_attacker]);
  			    }
                gTurf[x][t_timertick] += 1;

                new score[2] = 0;
				score[0] = (GetPlayersInTurf(x, gTurf[x][t_owner]) + gTurf[x][t_kills][0]);
				score[1] = (GetPlayersInTurf(x, gTurf[x][t_attacker]) + gTurf[x][t_kills][1]);

				if(score[0] < score[1])//if turf attackers are wining the turf from owners
				{
				    foreach(new i : Player)
				    {
				        if(	IsPlayerInGangZone(i, gTurf[x][t_turf]) &&
							! GetPlayerInterior(i) &&
							! GetPlayerVirtualWorld(i))
				        {
							SetPlayerProgressBarValue(i, gTurfwarBar[i][1], gTurf[x][t_timertick]);
  						}
  					}
  				}
  				else if(score[0] >= score[1])//if turf owners are wining the turf from attackers
				{
				    foreach(new i : Player)
				    {
				        if(	IsPlayerInGangZone(i, gTurf[x][t_turf]) &&
							! GetPlayerInterior(i) &&
							! GetPlayerVirtualWorld(i))
				        {
							SetPlayerProgressBarValue(i, gTurfwarBar[i][0], gTurf[x][t_timertick]);
  						}
  					}
  				}
  			}
		}
	}
	return 1;
}

JB_PUBLIC OnTurfWarStart(turfid, owner, attacker)
{
	foreach(new i : Player)
	{
	    if(	IsPlayerInGangZone(i, gTurf[turfid][t_turf]))
		{
		    if(InClass[i] == true) return 0;
			SetPlayerProgressBarValue(i, gTurfwarBar[i][0], 0.0);
			SetPlayerProgressBarValue(i, gTurfwarBar[i][1], 0.0);
			SetPlayerProgressBarColour(i, gTurfwarBar[i][0], COLOR_YELLOW);
			SetPlayerProgressBarColour(i, gTurfwarBar[i][1], COLOR_GREEN);

		    ShowPlayerProgressBar(i, gTurfwarBar[i][0]);
			ShowPlayerProgressBar(i, gTurfwarBar[i][1]);

			PlayerTextDrawColor(i, gTurfwarTeamsTD[i][0], COLOR_GREEN);
			PlayerTextDrawColor(i, gTurfwarTeamsTD[i][1], COLOR_YELLOW);
			PlayerTextDrawSetStringf(i, gTurfwarTeamsTD[i][0], "%s", gTeam[attacker][E_NAME]);
			PlayerTextDrawSetStringf(i, gTurfwarTeamsTD[i][1], "%s", gTeam[owner][E_NAME]);
			PlayerTextDrawShow(i, gTurfwarTeamsTD[i][0]);
			PlayerTextDrawShow(i, gTurfwarTeamsTD[i][1]);
		}
    }
    SaveTStats();
    SaveZones();

    KillTimer(CallDestroy2());
    KillTimer(CallDestroy3());
    TextDrawDestroy(Conquista2);
    TextDrawDestroy(Conquista3);
   	conquista1 = false;
    ConquistaCaja1 = TextDrawCreate(634.503845, 105.333335, "usebox");
    TextDrawLetterSize(ConquistaCaja1, 0.000000, 8.254450);
    TextDrawTextSize(ConquistaCaja1, 506.814086, 0.000000);
    TextDrawAlignment(ConquistaCaja1, 1);
    TextDrawColor(ConquistaCaja1, 0);
    TextDrawUseBox(ConquistaCaja1, true);
    TextDrawBoxColor(ConquistaCaja1, 102);
    TextDrawSetShadow(ConquistaCaja1, 0);
    TextDrawSetOutline(ConquistaCaja1, 0);
    TextDrawFont(ConquistaCaja1, 0);

	new msg[250];
	//0.180600, 1.588333
	format(msg, sizeof(msg), "%s inicio una guerra ~n~contra %s en la %s~n~tiempo para defenderlo: "#TURFWAR_TIME" segundos", gTeam[attacker][E_NAME], gTeam[owner][E_NAME], gTurf[turfid][t_name]);
    Conquista1 = TextDrawCreate(512.093566, 107.916671, msg);
    TextDrawSetString(Conquista1, msg);
    TextDrawLetterSize(Conquista1, 0.180600, 1.588333);
    TextDrawAlignment(Conquista1, 1);
    TextDrawColor(Conquista1, -1);
    TextDrawSetShadow(Conquista1, 0);
    TextDrawSetOutline(Conquista1, 1);
    TextDrawBackgroundColor(Conquista1, 51);
    TextDrawFont(Conquista1, 1);
    TextDrawSetProportional(Conquista1, 1);
  //SetTimerEx("CallDestroy3", 10000, true, "i", gTeam[gTurf[x][t_attacker]][E_NAME]);
    TextDrawShowForAll(ConquistaCaja1);
    TextDrawShowForAll(Conquista1);
    for(new i=0; i<MAX_PLAYERS; i++)
    {
    PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
    }

    SetTimer("CallDestroy1", 10000, false);

    if(conquista1 == true)
    {
    KillTimer(CallDestroy1());
    }
	return 1;
}

JB_PUBLIC OnTurfWarStop(turfid, owner, attacker)
{
	new score[2] = 0;
	score[0] = (GetPlayersInTurf(turfid, owner) + gTurf[turfid][t_kills][0]);
	score[1] = (GetPlayersInTurf(turfid, attacker) + gTurf[turfid][t_kills][1]);

	if(score[0] < score[1])//if turf attackers won the turf from owners
	{
		foreach(new i : Player)
		{
			if(	IsPlayerInGangZone(i, gTurf[turfid][t_turf]))
			{
				SetPlayerProgressBarValue(i, gTurfwarBar[i][0], 0.0);
				SetPlayerProgressBarValue(i, gTurfwarBar[i][1], 0.0);
				SetPlayerProgressBarColour(i, gTurfwarBar[i][0], 0);
				SetPlayerProgressBarColour(i, gTurfwarBar[i][1], 0);
			    HidePlayerProgressBar(i, gTurfwarBar[i][0]);
				HidePlayerProgressBar(i, gTurfwarBar[i][1]);
				PlayerTextDrawHide(i, gTurfwarTeamsTD[i][0]);
				PlayerTextDrawHide(i, gTurfwarTeamsTD[i][1]);
    			gTeam[attacker][TurfWarsWon]++;
       			gTeam[attacker][TeamScore]++;
       			PlayerTextDrawShow(i,ZoneTD);
			}
	    }
        KillTimer(CallDestroy1());
        KillTimer(CallDestroy3());
        TextDrawDestroy(Conquista1);
        TextDrawDestroy(Conquista3);
        conquista2 = false;
        ConquistaCaja2 = TextDrawCreate(634.503845, 105.333335, "usebox");
        TextDrawLetterSize(ConquistaCaja2, 0.000000, 8.254450);
        TextDrawTextSize(ConquistaCaja2, 506.814086, 0.000000);
        TextDrawAlignment(ConquistaCaja2, 1);
        TextDrawColor(ConquistaCaja2, 0);
        TextDrawUseBox(ConquistaCaja2, true);
        TextDrawBoxColor(ConquistaCaja2, 102);
        TextDrawSetShadow(ConquistaCaja2, 0);
        TextDrawSetOutline(ConquistaCaja2, 0);
        TextDrawFont(ConquistaCaja2, 0);

	    new msg[250];
	    //0.180600, 1.588333
	    format(msg, sizeof(msg), "%s ha conquistado la ~n~%s de %s.", gTeam[attacker][E_NAME], gTurf[turfid][t_name], gTeam[owner][E_NAME]);
        Conquista2 = TextDrawCreate(512.093566, 107.916671, msg);
        TextDrawSetString(Conquista2, msg);
        TextDrawLetterSize(Conquista2, 0.180600, 1.588333);
        TextDrawAlignment(Conquista2, 1);
        TextDrawColor(Conquista2, -1);
        TextDrawSetShadow(Conquista2, 0);
        TextDrawSetOutline(Conquista2, 1);
        TextDrawBackgroundColor(Conquista2, 51);
        TextDrawFont(Conquista2, 1);
        TextDrawSetProportional(Conquista2, 1);
        
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            PlayerTextDrawHide(i, ZoneTD);
            PlayerTextDrawShow(i, ZoneTD);
            PlayerPlaySound(i, 1084, 0.0, 0.0, 0.0);
        }

        TextDrawShowForAll(ConquistaCaja2);
        TextDrawShowForAll(Conquista2);
        gTeam[ attacker ][ TurfWarsLost ]++;
        SaveTStats();
        SaveZones();
    
        SetTimer("CallDestroy2", 10000, false);

        if(conquista2 == true)
        {
            KillTimer(CallDestroy2());
        }

    	SaveTStats();
    	SaveZones();
		gTurf[turfid][t_owner] = attacker;
		gTurf[turfid][t_attacker] = NO_TEAM;
		gTurf[turfid][t_attacked] = false;
		for(new k; k < 2; k++)
		{
			gTurf[turfid][t_kills][k] = 0;
		}
		gTurf[turfid][t_started] = false;
		gTurf[turfid][t_timer] = -1;
		gTurf[turfid][t_timertick] = -1;

		//stop war
		GangZoneStopFlashForAll(gTurf[turfid][t_turf]);
		GangZoneSetColorForAll(gTurf[turfid][t_turf], gTeam[attacker][E_COLOR]);

		//rewards

		new money = (5500 + random(24500));
		new scores = (12 + random(15));
		foreach(new i : Player)
		{
		    if(GetPlayerTeam(i) == attacker)
		    {
				SetPlayerChocolate(i,GetPlayerChocolate(i)+money);
				SetPlayerScore(i, GetPlayerScore(i)+scores);
				new win[138], l[128];
				format(win, sizeof(win), "[GP] "white"Zona conquistada, recompensas: score "red"+%i"white" | dinero "green"+%i", scores, money);
				SendClientMessage(i, GetPlayerColor(i), win);
				format(l, sizeof(l), "[ZONAS] El equipo %s gan�%d y %d score por conquistar la %s de %s", gTeam[attacker][E_NAME], money, scores, gTurf[turfid][t_name], gTeam[owner][E_NAME]);
			 	SaveLogData("zonas.txt", l);
			}
		}
	}
	else if(score[0] >= score[1])//if turf owner won the turf from attacker
	{
		foreach(new i : Player)
		{
			if(	IsPlayerInGangZone(i, gTurf[turfid][t_turf]))
			{
				SetPlayerProgressBarValue(i, gTurfwarBar[i][0], 0.0);
				SetPlayerProgressBarValue(i, gTurfwarBar[i][1], 0.0);

				SetPlayerProgressBarColour(i, gTurfwarBar[i][0], 0);
				SetPlayerProgressBarColour(i, gTurfwarBar[i][1], 0);

			    HidePlayerProgressBar(i, gTurfwarBar[i][0]);
				HidePlayerProgressBar(i, gTurfwarBar[i][1]);
				gTeam[ attacker ][ TurfWarsLost ]++;
    			gTeam[ attacker ][ TeamScore ]--;
				PlayerTextDrawHide(i, gTurfwarTeamsTD[i][0]);
				PlayerTextDrawHide(i, gTurfwarTeamsTD[i][1]);
			}
	    }
        conquista3 = false;
        KillTimer(CallDestroy1());
        KillTimer(CallDestroy2());
        ConquistaCaja3 = TextDrawCreate(634.503845, 105.333335, "usebox");
        TextDrawLetterSize(ConquistaCaja3, 0.000000, 8.254450);
        TextDrawTextSize(ConquistaCaja3, 506.814086, 0.000000);
        TextDrawAlignment(ConquistaCaja3, 1);
        TextDrawColor(ConquistaCaja3, 0);
        TextDrawUseBox(ConquistaCaja3, true);
        TextDrawBoxColor(ConquistaCaja3, 102);
        TextDrawSetShadow(ConquistaCaja3, 0);
        TextDrawSetOutline(ConquistaCaja3, 0);
        TextDrawFont(ConquistaCaja3, 0);

    	new msg[250];
    	//0.180600, 1.588333
    	format(msg, sizeof(msg), "%s no ha podido ~n~conquistar la %s~n~ de %s porque~n~ faltaron miembros.", gTeam[attacker][E_NAME], gTurf[turfid][t_name], gTeam[owner][E_NAME]);
        Conquista3 = TextDrawCreate(512.093566, 107.916671, msg);
        TextDrawSetString(Conquista3, msg);
        TextDrawLetterSize(Conquista3, 0.180600, 1.588333);
        TextDrawAlignment(Conquista3, 1);
        TextDrawColor(Conquista3, -1);
        TextDrawSetShadow(Conquista3, 0);
        TextDrawSetOutline(Conquista3, 1);
        TextDrawBackgroundColor(Conquista3, 51);
        TextDrawFont(Conquista3, 1);
        TextDrawSetProportional(Conquista3, 1);
    
        TextDrawShowForAll(ConquistaCaja3);
        TextDrawShowForAll(Conquista3);
        SaveTStats();
        SaveZones();

        SetTimer("CallDestroy3", 10000, false);

    	SaveTStats();
    	SaveZones();
		gTurf[turfid][t_started] = false;
		gTurf[turfid][t_timertick] = -1;
		gTurf[turfid][t_attacked] = false;
		gTurf[turfid][t_attacker] = NO_TEAM;
		for(new k; k < 2; k++)
		{
			gTurf[turfid][t_kills][k] = 0;
		}

		//Detener parpadeo en el mapa al obtener la conquista.
		GangZoneStopFlashForAll(gTurf[turfid][t_turf]);

		//Premios
		new money = (5500 + random(24500));
		new scores = (12 + random(15));

		foreach(new i : Player)
		{
		    if(GetPlayerTeam(i) == owner)
		    {
  				SetPlayerChocolate(i,GetPlayerChocolate(i)+money);
				SetPlayerScore(i, GetPlayerScore(i)+scores);
				new win[138];
				format(win, sizeof(win), "[GP] "white"Zona conquistada, recompensas: score "red"+%i"white" | dinero "green"+%i", scores, money);
				SendClientMessage(i, GetPlayerColor(i), win);

			}
		}
	}
	return 1;
}

JB_PUBLIC CallDestroy1()
{
    TextDrawDestroy(ConquistaCaja1);
    TextDrawDestroy(Conquista1);
    conquista1 = true;

    return 1;
}

JB_PUBLIC CallDestroy2()
{
    TextDrawDestroy(ConquistaCaja2);
    TextDrawDestroy(Conquista2);
    conquista2 = true;
    return 1;
}

JB_PUBLIC CallDestroy3()
{
    TextDrawDestroy(ConquistaCaja3);
    TextDrawDestroy(Conquista3);
    conquista3 = true;

    return 1;
}

JB_PUBLIC split(const strsrc[], strdest[][], delimiter) //Guardado de datos de zonas
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

JB_PUBLIC Fix(playerid, vehicleid)
{
    PutPlayerInVehicle(playerid, vehicleid, 0);
    return 1;
}

JB_PUBLIC BanTimer(playerid)
{
	Ban(playerid);
	return 1;
}

JB_PUBLIC DamageTimer(playerid)
{
    DamageTaken[playerid] = 0;
    return 1;
}

JB_PUBLIC StopSpec(playerid)
{
	SpawnPlayer(playerid);
    TogglePlayerSpectating(playerid, 0);
    IsSpecating[playerid] = 0;

//    Spawnplayer(playerid)
    return 1;
}

JB_PUBLIC AntiCK(playerid)
{
    BloqueoCK[playerid] = 0;
    return 1;
}

JB_PUBLIC RDDB(playerid)
{
    DmgB[playerid] = 0;
    PlayerTextDrawHide(playerid, IndiB[playerid]);
    KillTimer(TiempoDmgB[playerid]);
    return 1;
}

JB_PUBLIC RDDA(playerid)
{
    DmgA[playerid] = 0;
    PlayerTextDrawHide(playerid, IndiA[playerid]);
    KillTimer(TiempoDmgA[playerid]);
    return 1;
}


JB_PUBLIC AntiCJ(playerid)
{
JBC_TogglePlayerControllable(playerid, 1);
return 1;
}

JB_PUBLIC WorldVirtual(playerid)
{
SetPlayerVirtualWorld(playerid, 0);
return 1;
}

JB_PUBLIC CallTDEquipos(playerid)
{
	Destroyed[playerid] = false;

   	Caja1 = CreatePlayerTextDraw(playerid, 310.000000, -19.000000, "_");
	PlayerTextDrawAlignment(playerid, Caja1, 2);
	PlayerTextDrawBackgroundColor(playerid, Caja1, 255);
	PlayerTextDrawFont(playerid, Caja1, 1);
	PlayerTextDrawLetterSize(playerid, Caja1, 0.800000, 5.000000);
	PlayerTextDrawColor(playerid, Caja1, -1);
	PlayerTextDrawSetOutline(playerid, Caja1, 0);
	PlayerTextDrawSetProportional(playerid, Caja1, 1);
	PlayerTextDrawSetShadow(playerid, Caja1, 1);
	PlayerTextDrawUseBox(playerid, Caja1, 1);
	PlayerTextDrawBoxColor(playerid, Caja1, 1535);
	PlayerTextDrawTextSize(playerid, Caja1, 137.000000, 686.000000);
	PlayerTextDrawSetSelectable(playerid, Caja1, 0);

	Caja2 = CreatePlayerTextDraw(playerid, 310.000000, 427.000000, "_");
	PlayerTextDrawAlignment(playerid, Caja2, 2);
	PlayerTextDrawBackgroundColor(playerid, Caja2, 255);
	PlayerTextDrawFont(playerid, Caja2, 1);
	PlayerTextDrawLetterSize(playerid, Caja2, 0.800000, 5.800000);
	PlayerTextDrawColor(playerid, Caja2, -1);
	PlayerTextDrawSetOutline(playerid, Caja2, 0);
	PlayerTextDrawSetProportional(playerid, Caja2, 1);
	PlayerTextDrawSetShadow(playerid, Caja2, 1);
	PlayerTextDrawUseBox(playerid, Caja2, 1);
	PlayerTextDrawBoxColor(playerid, Caja2, 255);
	PlayerTextDrawTextSize(playerid, Caja2, 137.000000, 686.000000);
	PlayerTextDrawSetSelectable(playerid, Caja2, 0);


	TeamName = CreatePlayerTextDraw(playerid, 319.000000, 110.000000, "Groove Street");
	PlayerTextDrawAlignment(playerid, TeamName, 2);
	PlayerTextDrawBackgroundColor(playerid, TeamName, 255);
	PlayerTextDrawFont(playerid, TeamName, 3);
	PlayerTextDrawLetterSize(playerid, TeamName, 0.769999, 3.599997);
	PlayerTextDrawColor(playerid, TeamName, 47120480);
	PlayerTextDrawSetOutline(playerid, TeamName, 0);
	PlayerTextDrawSetProportional(playerid, TeamName, 1);
	PlayerTextDrawSetShadow(playerid, TeamName, 0);
	PlayerTextDrawUseBox(playerid, TeamName, 1);
	PlayerTextDrawBoxColor(playerid, TeamName, 50332335);
	PlayerTextDrawTextSize(playerid, TeamName, 10.000000, 642.000000);
	PlayerTextDrawSetSelectable(playerid, TeamName, 0);


    Informacion = CreatePlayerTextDraw(playerid, 554.000000, 163.000000, "Team Info");
	PlayerTextDrawAlignment(playerid, Informacion, 2);
	PlayerTextDrawBackgroundColor(playerid, Informacion, -8912805);
	PlayerTextDrawFont(playerid, Informacion, 2);
	PlayerTextDrawLetterSize(playerid, Informacion, 0.289999, 1.499998);
	PlayerTextDrawColor(playerid, Informacion, -1);
	PlayerTextDrawSetOutline(playerid, Informacion, 0);
	PlayerTextDrawSetProportional(playerid, Informacion, 1);
	PlayerTextDrawSetShadow(playerid, Informacion, 0);
	PlayerTextDrawUseBox(playerid, Informacion, 1);
	PlayerTextDrawBoxColor(playerid, Informacion, -8912805);
	PlayerTextDrawTextSize(playerid, Informacion, 173.000000, 170.000000);
	PlayerTextDrawSetSelectable(playerid, Informacion, 0);

	Armamento = CreatePlayerTextDraw(playerid, 69.000000, 162.000000, "Spawn Info");
	PlayerTextDrawAlignment(playerid, Armamento, 2);
	PlayerTextDrawBackgroundColor(playerid, Armamento, -8912805);
	PlayerTextDrawFont(playerid, Armamento, 2);
	PlayerTextDrawLetterSize(playerid, Armamento, 0.279999, 1.599998);
	PlayerTextDrawColor(playerid, Armamento, -1);
	PlayerTextDrawSetOutline(playerid, Armamento, 0);
	PlayerTextDrawSetProportional(playerid, Armamento, 1);
	PlayerTextDrawSetShadow(playerid, Armamento, 0);
	PlayerTextDrawUseBox(playerid, Armamento, 1);
	PlayerTextDrawBoxColor(playerid, Armamento, -8912805);
	PlayerTextDrawTextSize(playerid, Armamento, 194.000000, 190.000000);
	PlayerTextDrawSetSelectable(playerid, Armamento, 0);

	TeamArmas = CreatePlayerTextDraw(playerid, 63.000000, 181.000000, "9MM~n~SHOTGUN~n~TEC-9~n~SNIPER");
	PlayerTextDrawAlignment(playerid, TeamArmas, 2);
	PlayerTextDrawBackgroundColor(playerid, TeamArmas, 255);
	PlayerTextDrawFont(playerid, TeamArmas, 3);
	PlayerTextDrawLetterSize(playerid, TeamArmas, 0.499998, 1.800000);
	PlayerTextDrawColor(playerid, TeamArmas, -1);
	PlayerTextDrawSetOutline(playerid, TeamArmas, 0);
	PlayerTextDrawSetProportional(playerid, TeamArmas, 1);
	PlayerTextDrawSetShadow(playerid, TeamArmas, 0);
	PlayerTextDrawUseBox(playerid, TeamArmas, 1);
	PlayerTextDrawBoxColor(playerid, TeamArmas, 50332335);
	PlayerTextDrawTextSize(playerid, TeamArmas, 185.000000, 202.000000);
	PlayerTextDrawSetSelectable(playerid, TeamArmas, 0);

	TeamInfo = CreatePlayerTextDraw(playerid, 557.000000, 181.000000, "JUGADORES EN EL EQUIPO: 10 ~N~TERRITORIOS GANADOS/PERDIDOS: 21-10 ~N~ K/D EQUIPO: 503-430 ~N~ TEAM SCORE: 900");
	PlayerTextDrawAlignment(playerid, TeamInfo, 2);
	PlayerTextDrawBackgroundColor(playerid, TeamInfo, 255);
	PlayerTextDrawFont(playerid, TeamInfo, 2);
	PlayerTextDrawLetterSize(playerid, TeamInfo, 0.159997, 0.899999);
	PlayerTextDrawColor(playerid, TeamInfo, -1);
	PlayerTextDrawSetOutline(playerid, TeamInfo, 0);
	PlayerTextDrawSetProportional(playerid, TeamInfo, 1);
	PlayerTextDrawSetShadow(playerid, TeamInfo, 0);
	PlayerTextDrawUseBox(playerid, TeamInfo, 1);
	PlayerTextDrawBoxColor(playerid, TeamInfo, 50332335);
	PlayerTextDrawTextSize(playerid, TeamInfo, 197.000000, 176.000000);
	PlayerTextDrawSetSelectable(playerid, TeamInfo, 0);

	return 1;
}

JB_PUBLIC DestroyTDEquipos(playerid)
{
    Destroyed[playerid] = true;
	PlayerTextDrawDestroy(playerid,Informacion);
	PlayerTextDrawDestroy(playerid,Armamento);
	PlayerTextDrawDestroy(playerid,TeamArmas);
	PlayerTextDrawDestroy(playerid,TeamInfo);
	PlayerTextDrawDestroy(playerid,TeamName);
	PlayerTextDrawDestroy(playerid,Caja1);
	PlayerTextDrawDestroy(playerid,Caja2);
	
    return Destroyed[playerid] == true;
}

JB_PUBLIC OnPlayerSendMessageToGang(jug,const string[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(GetPlayerTeam(jug) == GetPlayerTeam(i) && CheckPlayerAdmin(i) == 0)
			{
				SendClientMessage(i,GetPlayerColor(jug),string);
				}
			}
	    }
	return 1;
    }

JB_PUBLIC OnAdminReceiveMessageToGang(jug,const string[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(CheckPlayerAdmin(i) != 0)
			{
				SendClientMessage(i,GetPlayerColor(jug),string);
			}
		}
	}
	return 1;
}

JB_PUBLIC OnNotificationExpire(team, type)
{
    foreach(new i : Player)
	{
	    if(	GetPlayerTeam(i) == team)
		{
			PlayerTextDrawSetString(i, gTurfwarTD[type], "");
    		PlayerTextDrawHide(i, gTurfwarTD[type]);
		}
	}
	gTurfwarMessageTimer[team][type] = -1;
    return 1;
}

JB_PUBLIC OnPlayerEnterGangZone(playerid, zone)
{
    new string[50];
    for(new i; i < sizeof(gTurf); i++)
	{
	    if(gTurf[i][t_turf] == zone)
	    {
	        if(gTurf[i][t_attacked])
			{
				ShowPlayerProgressBar(playerid, gTurfwarBar[playerid][0]);
				ShowPlayerProgressBar(playerid, gTurfwarBar[playerid][1]);

			    PlayerTextDrawShow(playerid, gTurfwarTeamsTD[playerid][0]);
			    PlayerTextDrawShow(playerid, gTurfwarTeamsTD[playerid][1]);
	        }
	        else if(gTurf[i][t_started])
			{
				PlayerTextDrawShow(playerid, gTurfwarStartTD);
	        }
	        if( ! GetPlayerVirtualWorld(playerid) &&
	            ! GetPlayerInterior(playerid))
			{//here
			format(string,sizeof(string),"%s: %s", gTeam[ (gTurf[i][t_owner]) ][E_NAME], gTurf[i][t_name]);
			PlayerTextDrawSetString(playerid,ZoneTD, string);
			PlayerTextDrawColor(playerid,ZoneTD, COLOR_WHITE);
			PlayerTextDrawShow(playerid, ZoneTD);
			}
			return 1;
	    }
    }
	return 1;
}


JB_PUBLIC OnPlayerLeaveGangZone(playerid, zone)
{
    for(new i; i < sizeof(gTurf); i++)
	{
	    if(gTurf[i][t_turf] == zone)
	    { 
	    	PlayerTextDrawHide(playerid, ZoneTD);
	        if(gTurf[i][t_attacked])
			{
				HidePlayerProgressBar(playerid, gTurfwarBar[playerid][0]);
				HidePlayerProgressBar(playerid, gTurfwarBar[playerid][1]);
			    PlayerTextDrawHide(playerid, gTurfwarTeamsTD[playerid][0]);
			    PlayerTextDrawHide(playerid, gTurfwarTeamsTD[playerid][1]);
	        }
	        else if(gTurf[i][t_started])
			{
				PlayerTextDrawHide(playerid, gTurfwarStartTD);
	        }
			break;
	    }
    }
	return 1;
}

JB_PUBLIC set_teamex(playerid)
{
	return SetPlayerTeam(playerid, LastTeam[playerid]), JBC_SetPlayerSkin(playerid, LastSkin[playerid]);
}  


//alias:mono("changeteam", "cambiarteam", "class");
CMD:mono(playerid, params[])
{
	new s[110];
	JBC_SetPlayerHealth(playerid, 0);
	format(s, sizeof(s), "[INFO] %s [ID:%d]{FFFFFF} ha vuelto a la selecci�n de equipos. ({D80000}/Mono{FFFFFF})", pName(playerid), playerid);
  	ForceClassSelection(playerid);
  	CallTDEquipos(playerid);
    SendClientMessageToAll(GetPlayerColor(playerid), s);
 	return 1;
}

CMD:miequipo(playerid, params[])
{
	ShowPlayerDialogf(	playerid,
						DIALOG_ZONES,
						DIALOG_STYLE_MSGBOX,
						"Estad�sticas de tu equipo",
						""white"Equipo: "green"%s\n\
						"white"Territorios bajo control: "green"%i de %i\n\
						"white"Zonas ganadas/perdidas: "green"%i || %i\n\
						"white"Asesinatos/muertes: "green"%i || %i\n\
						"white"Miembros conectados: "green"%i\n\
						"white"Score total: "red"%i",
						""white"Cerrar",
						"",
      gTeam[GetPlayerTeam(playerid)][E_NAME],
						(GetPlayerTeam(playerid) + 1),
						sizeof(gTurf),
						gTeam[GetPlayerTeam(playerid)][TurfWarsWon],
						gTeam[GetPlayerTeam(playerid)][TurfWarsLost],
						gTeam[GetPlayerTeam(playerid)][RivalsKilled],
						gTeam[GetPlayerTeam(playerid)][HomiesDied],
						CountTeamPlayers(GetPlayerTeam(playerid)),
      					gTeam[GetPlayerTeam(playerid)][TeamScore]);
	return 1;
}

CMD:infoequipos(playerid, params[])
{
	new teamid = 0;
	if(!sscanf(params, "i", teamid))
	{
	    if(teamid > MAX_TEAMS || teamid < 1) return SendClientMessage(playerid, X11_FIREBRICK, "[ERROR] ID del equipo inv�lido, debe ser entre/w 1-15.");
		ShowPlayerDialogf(	playerid,
						DIALOG_ZONES,
						DIALOG_STYLE_MSGBOX,
						"Estad�sticas de tu equipo",
						""white"Equipo: "green"%s\n\
						"white"Territorios bajo control: "green"%i de %i\n\
						"white"Zonas ganadas/perdidas: "green"%i || %i\n\
						"white"Asesinatos/muertes: "green"%i || %i\n\
						"white"Miembros conectados: "green"%i\n\
						"white"Score total: "red"%i",
						""white"Cerrar",
							"",
							gTeam[(teamid - 1)][E_NAME],
							teamid,
							CountTeamTurfs((teamid - 1)),
							sizeof(gTurf),
							CountTeamPlayers((teamid - 1)),
							gTeam[(teamid - 1)][TurfWarsWon],
							gTeam[(teamid - 1)][TurfWarsLost],
							gTeam[(teamid - 1)][RivalsKilled],
							gTeam[(teamid - 1)][HomiesDied],
							CountTeamPlayers((teamid - 1)),
							gTeam[(teamid - 1)][TeamScore]);
	    return 1;
	}

	new STRING[42];
 	new DIALOG[434];
	for(new i; i < MAX_TEAMS; i++)
	{
		format(STRING, sizeof(STRING), "%s\n", gTeam[i][E_NAME]);
		strcat(DIALOG, STRING);
	}
	ShowPlayerDialog(	playerid,
						DIALOG_TEAMS,
						DIALOG_STYLE_LIST,
						"Lista de equipos",
						DIALOG,
						"Elegir",
						"Cancelar");
	return 1;
}

CMD:zonas(playerid, params[])
{
	new STRING[42];
 	new DIALOG[1024];
 	strcat(DIALOG, "Localizaci�n\tID\n");
	for(new i; i < sizeof(gTurf); i++)
	{
	    if(! gTurf[i][t_attacked])
	    {
			if(gTurf[i][t_owner] == GetPlayerTeam(playerid))
			{
				format(STRING, sizeof(STRING), "%s\t%i\n", gTurf[i][t_name], i);
				strcat(DIALOG, STRING);
			}
		}
	}

	if(! strlen(DIALOG))
	{
		return ShowPlayerDialog(	playerid,
									DIALOG_ZONES,
									DIALOG_STYLE_LIST,
									"Territorios bajo control",
									"No equipo no tiene territorios controlados.\n\
									�Ve y capt�ralos!, /zonasayuda para mas informaci�n.",
									"Cerrar",
									"");
	}
	ShowPlayerDialog(	playerid,
						DIALOG_ZONES,
						DIALOG_STYLE_TABLIST_HEADERS,
						"Territorios bajo control",
						DIALOG,
						"Cerrar",
						"");
	return 1;
}

CMD:guerras(playerid, params[])
{
	new STRING[356];
 	new DIALOG[2500];
 	strcat(DIALOG, "Localizaci�n\tID\tAtacante\tDefensores\n");
	for(new i; i < sizeof(gTurf); i++)
	{
	    if(gTurf[i][t_attacked])
	    {
			if(gTurf[i][t_owner] == GetPlayerTeam(playerid) || gTurf[i][t_attacker] == GetPlayerTeam(playerid))
			{
				format(STRING, sizeof(STRING), "%s\t%i\t %s \t%s\n", gTurf[i][t_name], i, gTeam[ (gTurf[i][t_attacker]) ][E_NAME], gTeam[ (gTurf[i][t_owner]) ][E_NAME]);
				strcat(DIALOG, STRING);
			}
		}
	}

	if(! strlen(DIALOG))
	{
		return ShowPlayerDialog(	playerid,
									DIALOG_ZONES,
									DIALOG_STYLE_LIST,
									"Zonas bajo ataque de tu equipo",
									"No hay ataques en desarrollo por tu equipo.\n\
									Usa /zonas para ver todos los territorios controlados.",
									"Cerrar",
									"");
	}
	ShowPlayerDialog(	playerid,
						DIALOG_ZONES,
						DIALOG_STYLE_TABLIST_HEADERS,
						"Zonas bajo ataque de tu equipo",
						DIALOG,
						"Cerrar",
						"");
	return 1;
}

JB_PUBLIC CheckRequestScore(playerid, score)
{
	if(GetPlayerScore(playerid) < score)
	{
		SendClientMessage(playerid, 0xEB323CFF, "[GP] Has regresado a la selecci�n de equipos porque no cumples con los requerimientos necesarios.");
		return ForceClassSelection(playerid);
	}
	return 1;
}

//=================================    STOCKS =========================================t========================================

JB_Function:SendMessageToAll(color, message[])
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i))
		{
			if(CheckPlayerSpawn(i) == 1)
			{
				SendClientMessage(i, color, message);
			}
		}
	}
}

JB_Function:IsVehicleHasDriver(vehicleid) // Antiabuso de pasajero
{
	    for(new playerid; playerid < MAX_PLAYERS; playerid++)
	    {
	    if(IsPlayerConnected(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(playerid) == vehicleid) 
	    	return 1;
	    }      
        return 0;
}
   
JB_Function:IsABike(vehicleid) //Casco en la cabeza
   {
	    new result;
	    new model = GetVehicleModel(vehicleid);
        
        switch(model)
               {
               case 509, 462, 448, 522, 461, 521, 523, 463, 586, 468, 471: result = model;
               default: result = 0;
               }       
        return result;
   }

JB_Function:pName(playerid)
{
        new nameJ[MAX_PLAYER_NAME];
        GetPlayerName(playerid, nameJ, MAX_PLAYER_NAME);
        return nameJ;
}


   
JB_Function:GetWeaponModel(weaponid) // Armas en la espalda
   {
	  switch(weaponid)
	  {
		  case 1: return 331;
		  case 2..8: return weaponid+331;
	      case 9: return 341;
		  case 10..15: return weaponid+311;
		  case 16..18: return weaponid+326;
		  case 22..29: return weaponid+324;
		  case 30..31: return weaponid+325;
		  case 32: return 372;
		  case 33..45: return weaponid+324;
		  case 46: return 371;
	  }
      return 1;
}

JB_Function:BText(playerid)
{
    PlayerTextDrawHide(playerid,IndiA[playerid]);
    PlayerTextDrawHide(playerid,IndiB[playerid]);
    return 1;
}

JB_Function:CountTeamPlayers(team)
{
	new count;
	foreach(new i : Player)
	{
 		if(	IsPlayerConnected(i)//if player is connected
		 	&& GetPlayerTeam(i) == team)//if team id matches
   		{
     		count++;//add one to the count
	    }
	}
	return count;
}

JB_Function:CountTeamTurfs(team)
{
	new count;
	for(new i; i < sizeof(gTurf); i++)
	{
	    if(gTurf[i][t_owner] == team)
	    {
	        count++;
	    }
	}
	return count;
}

JB_Function:ConnectedPlayers()
{
	new
		Connected,
		redefinedMaxPlayers = GetMaxPlayers();
	for(new i; i < redefinedMaxPlayers; i++)
	{
		if(!IsPlayerConnected(i)) continue;
		Connected++;
	}
	return Connected;
}

JB_Function:CText(playerid)
{
    IndiA[playerid] = CreatePlayerTextDraw(playerid, 400.0,362.0, "");
    PlayerTextDrawLetterSize(playerid, IndiA[playerid], 0.23000, 1.0);
    PlayerTextDrawAlignment(playerid, IndiA[playerid], 1);
    PlayerTextDrawColor(playerid, IndiA[playerid], -1);
    PlayerTextDrawSetShadow(playerid, IndiA[playerid], 0);
    PlayerTextDrawSetOutline(playerid, IndiA[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, IndiA[playerid], 51);
    PlayerTextDrawFont(playerid, IndiA[playerid], 1);
    PlayerTextDrawSetProportional(playerid, IndiA[playerid], 1);

    IndiB[playerid] = CreatePlayerTextDraw(playerid, 180.0,362.0, "");
    PlayerTextDrawLetterSize(playerid, IndiB[playerid], 0.23000, 1.0);
    PlayerTextDrawAlignment(playerid, IndiB[playerid], 1);
    PlayerTextDrawColor(playerid, IndiB[playerid], -1);
    PlayerTextDrawSetShadow(playerid, IndiB[playerid], 0);
    PlayerTextDrawSetOutline(playerid, IndiB[playerid], 1);
    PlayerTextDrawBackgroundColor(playerid, IndiB[playerid], 51);
    PlayerTextDrawFont(playerid, IndiB[playerid], 1);
    PlayerTextDrawSetProportional(playerid, IndiB[playerid], 1);
    return 1;
}

JB_Function:LoadTStats()
{
	new PartOfString[12][64];
	new FileString[128];
	new File: file = fopen("ServerData/TeamStats.ini", io_read);
	if (file)
	{
		new idx;
		while (idx < (sizeof(gTeam)-1) )
		{
			fread(file, FileString);
			split(FileString, PartOfString, ',');

			gTeam[idx][TurfWarsWon] = strval(PartOfString[0]);
			gTeam[idx][TurfWarsLost]= strval(PartOfString[1]);
			gTeam[idx][RivalsKilled] = strval(PartOfString[2]);
			gTeam[idx][HomiesDied] = strval(PartOfString[3]);
			gTeam[idx][TeamScore] = strval(PartOfString[4]);

			idx++;
		}
		fclose(file);
	}
	return 1;
}

JB_Function:LoadZones()
{
	new PartOfString[12][64];
	new FileString[128];
	new File: file = fopen("ServerData/Zones.ini", io_read);
	if (file)
	{
		new idx;
		while (idx < (sizeof(gTurf)-1) )
		{
			fread(file, FileString);
			split(FileString, PartOfString, ',');

			gTurf[idx][t_owner] = strval(PartOfString[0]);
			gTurf[idx][t_ID] = strval(PartOfString[1]);

			idx++;
		}
		fclose(file);
	}
	return 1;
}

JB_Function:SaveTStats()
{
	new idx;
	new File: file2;
	while (idx < (sizeof(gTeam)-1) )
	{
		new FileString[128];
		format(FileString, sizeof(FileString), "%d,%d,%d,%d,%d\r\n",
		gTeam[idx][TurfWarsWon],
		gTeam[idx][TurfWarsLost],
		gTeam[idx][RivalsKilled],
		gTeam[idx][HomiesDied],
		gTeam[idx][TeamScore] );
		//print(FileString);

		if(idx == 0) file2 = fopen("ServerData/TeamStats.ini", io_write);
		else file2 = fopen("ServerData/TeamStats.ini", io_append);

		fwrite(file2, FileString);
		idx++;
		fclose(file2);
	}
	return 1;
}

JB_Function:SaveZones()
{
	new idx;
	new File: file2;
	while (idx < (sizeof(gTurf)-1) )
	{
		new FileString[128];
		format(FileString, sizeof(FileString), "%d,%d\r\n",
		gTurf[idx][t_owner],
		gTurf[idx][t_ID]);
		//print(FileString);

		if(idx == 0) file2 = fopen("ServerData/Zones.ini", io_write);
		else file2 = fopen("ServerData/Zones.ini", io_append);

		fwrite(file2, FileString);
		idx++;
		fclose(file2);
	}
	return 1;
}

JB_Function:IsPlayerInAnyAircraft(playerid)
{
	if(! IsPlayerConnected(playerid)) return false;
	if(! IsPlayerInAnyVehicle(playerid)) return false;
	switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
	{
		case 417,425,447,460,469,476,487,488,497,511,512,513,519,520,548,553,563,577,592,593: return true;
		default: return false;
	}
	return false;
}

JB_Function:GetPlayersInTurf(turfid, teamid)
{
	new count = 0;
	foreach(new i : Player)
	{
	    if(	! GetPlayerInterior(i) &&
			! GetPlayerVirtualWorld(i) &&
			IsPlayerInGangZone(i, gTurf[turfid][t_turf]) &&
			GetPlayerTeam(i) == teamid &&
			! IsPlayerInAnyAircraft(i))
		{
			count++;
		}
	}
	return count;
}

JB_Function:ShowPlayerDialogf(playerid, dialogid, style, title[], const type[], button1[], button2[], va_args<>)
{
    new STRING[540];
	va_format(STRING, sizeof(STRING), type, va_start<7>);
	return ShowPlayerDialog(playerid, dialogid, style, title, STRING, button1, button2);
}

JB_Function:PlayerTextDrawSetStringf(playerid, PlayerText:textdraw, const type[], va_args<>)
{
    new STRING[256];
	va_format(STRING, sizeof(STRING), type, va_start<3>);
	return PlayerTextDrawSetString(playerid, textdraw, STRING);
}
JB_Function:GetIpPlayer(playerid)
{
    new 
        PlayerIp[32];
    
    GetPlayerIp(playerid, PlayerIp, sizeof(PlayerIp));
    return PlayerIp;
}
