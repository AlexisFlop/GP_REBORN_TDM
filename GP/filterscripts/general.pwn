#include <a_samp>
#include <streamer>
#include <JunkBuster>
#include <jadmin3>
#include <sscanf2>
#include <foreach>
#include <formatex>
#include <OnPlayerPause>
#include <zcmd>

#define LevelCheck(%0,%1); \
		new st[128];\
		if(CheckPlayerAdmin(%0) == 0)\
		   return 0;\
		if(CheckPlayerAdmin(%0) < %1) \
		return format(st, 90, "[ERROR] Debes ser nivel %d para usar este comando.", (%1)),\
				SendClientMessage((%0), COLOR_RED, st);

#define EventCheck(%0);\
		if(EnEvento[%0] == 1)\
		   return SendClientMessage(%0, COLOR_RED, "[ERROR] Ya estás en el evento.");

#define OnEventCheck(%0);\
		if(OnEvento[%0] == 0)\
		   return SendClientMessage(%0, COLOR_RED, "[ERROR] No hay ningún evento iniciado por el momento.");

#define JBC_SetPlayerPosEx(%0,%1,%2,%4,%5) JBC_SetPlayerPos(%0,%1,%2,%4),SetPlayerFacingAngle(%0,%5)

#define InVehicleCheck(%0);\
		if(IsPlayerInAnyVehicle(%0))\
		  return SendClientMessage(%0, COLOR_RED, "[ERROR] Debes bajar del vehículo para continuar.");

#define MinigameCheck(%0);\
		if(MinigameMode[%0] != 0)\
		   return SendClientMessage(%0, COLOR_RED, "[ERROR] Estás en un minijuego, usa /exit si deseas salir.");

#define ResetPos(%0) SetPlayerInterior(%0,0), SetPlayerVirtualWorld(%0,0)

#define LockASPKCheck(%0);\
					  if(Bloqueo_ASPK[%0] == 1)\
						 return SendClientMessage(%0, COLOR_RED, "[INFO] Por el momento no puedes usar comandos, espera 10 segundos.");

#define VipCheck(%0,%1);\
					   if(CheckVip(%0) < %1)\
						  return SendClientMessage(%0, COLOR_RED, "[ERROR] Necesitas ser VIP para hacer uso de este comando.");

#define HealthCheck(%0,%1);\
			new Float:h, message[132];\
				GetPlayerHealth(%0, h);\
				format(message, sizeof(message), "[ERROR] Necesitas %i de vida para continuar.", %1);\
					  if(h < %1) return SendClientMessage(%0, COLOR_RED, message);

#define ColiseoCheckOn(%0);\
		if(statuscoliseo == true)\
		   return SendClientMessage(%0, COLOR_RED, "[ERROR] El evento coliseo ya se encuentra activado.");

#define ColiseoCheckOff(%0);\
		if(statuscoliseo == false)\
		   return SendClientMessage(%0, COLOR_RED, "[ERROR] El evento coliseo ya se encuentra desactivado.");
#define JB_PUBLIC%0(%1) forward %0(%1);\
						public %0(%1)

#define JB_Function:%0(%1) stock %0(%1)

#define DisableAS(%0);\
		AntiSpawnKill[%0] = false;\
		Bloqueo_ASPK[%0] = 0;
//EQUIPOSID +
#define TEAM_COLISEO          20
#define TEAM_EVENTO           21		
//HEXADECÍMALES
#define COLOR_RED             0xC80000FF
#define COLOR_LIGHBLUE        0x11E4CAFF
#define COLOR_BEIGE           0xFFB4CAFF
#define COLOR_GOLD            0xE6DD2FFF
#define COLOR_ORANGE          0xFCBC3CFF
#define COLOR_WHITE           0xFFFFFFFF
#define COLOR_BROWN           0xBF0000FF
#define COLOR_BLUE            0x7BF0F1FF
#define COLOR_GREEN           0x00E300FF
#define COLOR_PINK            0xFF70A4FF
#define COLOR_GRAY            0xEAE9E5FF
#define COLOR_HIDE            0xFFFFFF00
#define COLOR_BLIND           0x00D2FF88
//HTML
#define red                   "{CC0066}"
#define orange                "{FF8000}"
#define blue                  "{66FFFF}"
#define green                 "{66FF99}"
#define gray                  "{BDBDBD}"
#define white                 "{FFFFFF}"
#define beige                 "{FFBBAD}"
#define VIP1_COLOR            "{BDBDBD}"
#define VIP2_COLOR            "{FFFF33}"
//DIÁLOGOSID
#define DIALOG_SHOP           4001
#define DIALOG_WEAPS          4002
#define DIALOG_VEHICLES       4003
#define DIALOG_FOOD           4004
#define DIALOG_SPECIAL        4006
#define DIALOG_SECUREBUY      4007
//EVENTOS
#define DIALOG_EVENTLIST      4008
#define DIALOG_HIDESEEK       4009
#define DIALOG_AIRPLANEDEAD   4010
#define DIALOG_SURVIVAL       4011
#define DIALOG_EVENTCARS      4012
#define DIALOG_CHALLENGERS    4013
#define DIALOG_ARMORED        4014
//COMANDOS
#define DIALOG_COMMANDS       4015
#define DIALOG_COMMANDS1      4016
#define DIALOG_COMMANDS2      4017
#define DIALOG_COMMANDS3      4019
#define DIALOG_COMMANDS4      4020
#define DIALOG_COMMANDS5      4021
#define DIALOG_COMMANDS6      4022
#define DIALOG_COMMANDS7      4023
#define DIALOG_COMMANDS8      4024
#define DIALOG_RULES          4025
#define DIALOG_CREDITS        4026
#define DIALOG_HELPGANG       4027
#define DIALOG_HELP           4028

#define ANIT_SPAWNKILL_TIME   10

#if !defined HP_ASPK
	
	#define HP_ASPK (1500)

#endif
//TIEMPO PARA CONQUISTAR (ZONAS)
#define WarStartedTime    	  70
//MIEMBROS REQUERIDOS (ZONAS)		
#define RequiredMembers    	  3
//ASESINATOS REQUERIDOS (ZONAS)
#define RequieredKills        4 
//TIEMPO PARA CONQUISTAR (ZONAS)
#define TimeToConquer         100
//Armas GP SHOP
#define DESERT_PRICE  		  3500
#define COMBAT_PRICE          4350
#define M4_PRICE              7500
#define AK_PRICE              7000
#define MP5_PRICE             7200
#define TEC_PRICE             7850
#define SNIPER_PRICE          10000
#define HEAT_PRICE            28000
#define RPG_PRICE             25500
#define C4_PRICE              30000
#define ARMOUR_PRICE          8950
//VEHICULOS GP SHOP
#define SULTAN_PRICE          15000
#define INFERNUS_PRICE        18500
#define CHEETAH_PRICE         22800
#define BANSHEE_PRICE         25700
#define TURISMO_PRICE         30000
#define BULLET_PRICE          38000
#define MONSTER_PRICE         53250
#define NRG_PRICE             35000
#define KART_PRICE            55200
#define DUMPER_PRICE          75000
#define RHINO_PRICE           1900500
#define HYDRA_PRICE           2800000
#define HUNTER_PRICE          3400000
//SECCIÓN ESPECIAL - GP SHOP
#define BUYSCORE_PRICE        4200000
#define PAINTBALL_A_PRICE     15000
#define ABATTOIR_A_PRICE      15000
#define WW2_A_PRICE           15000
#define DUEL_A_PRICE          18000
#define WARNRESET_PRICE       2500000
#define HIDDEN_PRICE          25000

#pragma tabsize 0

enum nEvento
{
	Escondidas,
	AvionMuerte,
	Supervivencia,
	AutosChocadores,
	Retadores,
	Blindado
};

enum pInformation
{
	FirstPS,
};

new gRandomMessageTimer = -1;
//Variables Globales
new gRandomMessage[19][] =
{
	"[GP NEWS]"white" Para conocer como conquistar territorios, usa "red"/zonasayuda.",
	"[GP NEWS]"white" Si un noob está escapando, disparale al tanque de gasolina, empezará a quemarse y desaparecerá.",
	"[GP NEWS]"white" Para ver los comandos de administración de tu cuenta, minijuegos, y eventos del servidor usa "red"/comandos"white"",
	"[GP NEWS]"white" Puedes comprar armas, comida y vehiculos en el "red"GP SHOP"white", ubícalos en forma de calavera en el mapa.",
	"[GP NEWS]"white" Recuerda que si no hay "green"/admins"white" puedes presionar 'F8' y enviar la foto a nuestro /facebook.",
	"[GP NEWS]"white" Cuando una carrera comience usa "red"/carrera"white" para unirte. Si deseas salir puedes usa"red" /exitrace.",
	"[GP NEWS]"white" Buscanos en Facebook como "red"'SAMP Guerra de Pandillas El Original'.",
	"[GP NEWS]"white" Para jugar un duelo 1 VS 1, puedes usar "red"/duelo,"white" para configurar arena, armas, apuesta y más.",
	"[GP NEWS]"white" Recuerda lee las "red"/reglas"white" para evitar futuras sanciones",
	"[GP NEWS]"white" Para cambiar de equipo usa "red"/mono.",
	"[GP NEWS]"white" Para hablar con tu equipo usa "blue"'!'"white" Ejemplo: "red"!Hola equipo.",
	"[GP NEWS]"white" Puedes evadir carkill usando "red"/CK."white" Si deseas buscar la ID de alguien para reportarlo usa "red"/ID. ",
	"[GP NEWS]"white" Si quieres cambiar tu nick o actualizar tu tag, usá "red"/nombre.",
	"[GP NEWS]"white" Usa "red"/recompensa"white" para ponerle precio al asesinato de alguien.",
	"[GP NEWS]"white" Usa "red"/recompensas"white" para ver la lista de usuarios buscados!",
	"[GP NEWS]"white" ¿Tienes un clan? Usá "red"/ayuda clan"white" para ver todo lo necesario para volverlo oficial!",
	"[GP NEWS]"white" Si vez a un cheater, o a alguien incumpliendo nuestras normas, usa "red"/Reportar ID razón.",
	"[GP NEWS]"white" Unete a nuestro grupo de "red"/facebook"white" para mantenerte al día con las actualizaciones más recientes.",
	"[GP NEWS]"white" Puedes comprar tu auto propio y llevarlo contigo a todas partes comprandolo en la conscesionaria de "red"César."
};

new BotMessages[][]=
{
	"Para cambiar de equipo, puede usar /MONO",
	"Si deseas cambiar de team, usa /Cteam o /Mono",
	"El comando /MONO se llama así porque al creador no se le ocurrió otra cosa"
};

new BotMessages2[][]=
{
	"¿Has visto un hacker? Usa /report para informárselo a los /admins",
	"Usa /Report ID RAZON para enviar un reporte. ¡NUNCA LOS DIGAS AL CHAT!",
	"Usa /Report para reportar. Puedes usar F8 para tomar foto y reportarlo en /Facebook"
};

new 
	bool:IsPlayerGay[MAX_PLAYERS];
new 
	bool:LoginSucessfull[MAX_PLAYERS];
new 
	bool:AntiSpawnKill[MAX_PLAYERS];
new 
	gAntiSpawnKillTimer[MAX_PLAYERS];
new 
	Bloqueo_ASPK[MAX_PLAYERS];
new 
	bool:GivedChocolate[MAX_PLAYERS];
new 
	TimeChocolate[MAX_PLAYERS];
new 
	bool:firstspawn[MAX_PLAYERS];
new 
	bool:e_started;
new 
	bool:c_started;
new 
	bool:isDuel[MAX_PLAYERS];
new 
	bool:received[MAX_PLAYERS];
new 
	bool:statuscoliseo;
new 
	allowlogin[MAX_PLAYERS];
new 
	blindzone = 100;
new 
	bool:IsVehicleBlind[MAX_PLAYERS];
new 
	pInfo[MAX_PLAYERS][pInformation];
new 
	AFK[MAX_PLAYERS];
new 
	FPS[MAX_PLAYERS];
new 
	bool:ChatLock[MAX_PLAYERS];
new 
	buyedCar[MAX_PLAYERS];
new 
	buyedArmour[MAX_PLAYERS];
new 
	streak[MAX_PLAYERS];
new 
	totalReward[MAX_PLAYERS];
new 
	Text3D:label[MAX_PLAYERS];
new 
	murderText[5][]={ "~n~~n~~n~~r~ * Eres el puto Amo!! *", "~n~~n~~n~~b~ <-> En Racha!! <->", "~n~~n~~n~~y~ ] ____Jodidamente Bueno___ ]", "~n~~n~~n~~p~ ] IMPARABLE!! ]", "~n~~n~~n~~g~ == ASESINO SERIAL ==="};
new 
	BloqueoCK[MAX_PLAYERS];

new 
	Events[MAX_PLAYERS][nEvento];//Variable global lista de eventos
new 
	vEvents[MAX_PLAYERS];//Variable global vehiculos eventos
new 
	EnEvento[MAX_PLAYERS];//variable global que revisa si el jugador está o no en un evento
new 
	BloqueoEvento[MAX_PLAYERS];//variable global bloqueo de comandos en evento
new 
	OnEvento[MAX_PLAYERS];//variable global que revisa si un evento está on
new 
	IniciadoEvento[MAX_PLAYERS];//variable global que revisa si un evento está iniciado

static pos_a = -1;
static pos_b = -1;
static pos_c = -1;
static pos_d = -1;
static pos_e = -1;
static pos_f = -1;

new 
	MinigameMode[MAX_PLAYERS];
new 
	MinigunGame;
new 
	Coliseo[MAX_PLAYERS];
new 
	ContadorColiseo = 0;
new 
	ContadorPaintball;
new 
	ContadorWW2 = 0;
new 
	ContadorPesadas = 0;
new 
	ContadorMatadero = 0;
new 
	ContadorMinigun = 0;
new 
	ContadorRW = 0;

new Float:SPAWN_MINIGUN[5][4] =
{
	{2173.5723,1577.8872,999.9675,358.7795},
	{2205.8892,1580.4723,999.9788,37.6098},
	{2206.0720,1549.6593,1008.0951,296.3788},
	{2232.4290,1589.0771,999.9567,140.0240},
	{2199.4785,1613.1299,999.9723,305.1288}
};

new Float:SPAWN_PAINTBALL[ 5 ][ 4 ] = {
	{-975.1050,1061.5844,1345.6755,84.3436},
	{-1042.6305,1031.9932,1342.7920,87.4770},
	{-1089.8619,1094.6024,1343.4906,188.7175},
	{-1130.3995,1057.9498,1346.4141,280.8383},
	{-1078.9012,1020.9278,1342.7163,295.8784}
};

new Float:SPAWN_WW2[ 4 ][ 4 ] = {
	{1416.0387,-45.2366,1000.9264},
	{1382.2964,5.1866,1000.9136},
	{1389.7885,5.3077,1001.9375},
	{1407.9478,-27.6509,1000.9221}
};

new Float:SPAWN_RW[ 4 ][ 4 ] = {
	{1416.0387,-45.2366,1000.9264},
	{1382.2964,5.1866,1000.9136},
	{1389.7885,5.3077,1001.9375},
	{1407.9478,-27.6509,1000.9221}
};

new Float:SPAWN_PESADAS[ 4 ][ 4 ] = {
	{-1480.4335, 993.8453, 1027.1355},
	{-1375.6570, 1032.8770, 1027.1364},
	{1371.8967, 957.4011, 1026.1340},
	{-1424.7223, 942.5839, 1033.1354}
};

new Float:SPAWN_MATADERO[ 4 ][ 4 ] = {
	{963.1047,2108.2656,1011.0303},
	{936.6155,2116.2593,1011.0234},
	{960.0605,2144.7283,1011.0201},
	{942.4542,2175.0020,1011.0234}
};

public OnFilterScriptInit()
{
	MinigunGame = 0;
	ContadorPaintball = 0;
	ContadorMinigun = 0;
	ContadorWW2 = 0;
	ContadorRW = 0;
	ContadorPesadas = 0;
	ContadorMatadero = 0;
	ContadorColiseo = 0;
	gRandomMessageTimer = SetTimer("OnRandomMessageChange", 160000, true);
	
	print("[FILTERSCRIPT] General loading...");
	print("[FILTERSCRIPT] General loaded\n");
	return 1;
}

public OnFilterScriptExit()
{
	KillTimer(gRandomMessageTimer);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	DestroyVehicle(vEvents[playerid]);
	IsVehicleBlind[playerid] = false;
	received[playerid] = false;
	EnEvento[playerid] = 0;
	BloqueoEvento[playerid] = 0;
	IniciadoEvento[playerid] = 0;
	BloqueoCK[playerid] = 0;
	MinigameMode[playerid] = 0;

    switch(MinigameMode[playerid])
    {
    	case 1: ContadorMinigun --;
    	case 2: ContadorPaintball --;
    	case 3: ContadorWW2 --;
    	case 4: ContadorPesadas --;
    	case 5: ContadorMatadero --;
    	case 6: ContadorColiseo --;
    }
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{	
	BloqueoCK[playerid] = 0;
	ChatLock[playerid] = false;
	LoginSucessfull[playerid] = false;
	MinigameMode[playerid] = 0;
	EnEvento[playerid] = 0;
	return 1;
}

public OnPlayerConnect(playerid)
{
	EnEvento[playerid] = 0;
	BloqueoCK[playerid] = 0;
	firstspawn[playerid] = true;
	AFK[playerid] = 0;
	ChatLock[playerid] = false;
	Bloqueo_ASPK[playerid] = 0;
	AntiSpawnKill[playerid] = false;
	gAntiSpawnKillTimer[playerid] = -1;
	buyedCar[playerid] = -1;
	buyedArmour[playerid] = 0;
	streak[playerid] = 0;
	totalReward[playerid] = 0;
	LoginSucessfull[playerid] = false;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	PreloadAnimations(playerid);
	
	if(IsPlayerGay[playerid] == true)
	{
		IsPlayerGay[playerid] = false;
	}

	ChatLock[playerid] = true;
	LoginSucessfull[playerid] = true;
	BloqueoCK[playerid] = 0;
	
	if(EnEvento[playerid] ==1)
	{
		EnEvento[playerid] = 0;
		Events[playerid][Escondidas] = 0;
		Events[playerid][AvionMuerte] = 0;
		Events[playerid][Supervivencia] = 0;
		Events[playerid][AutosChocadores] = 0;
		Events[playerid][Blindado] = 0;
		DestroyVehicle(vEvents[playerid]);
		SetPlayerLastTeam(playerid);
		JBC_SetPlayerArmour(playerid,0);
		SetPlayerTime(playerid, 12, 0);
		SetPlayerWeather(playerid, 36);
		SetPlayerVirtualWorld(playerid, 0);
		BloqueoEvento[playerid] = 0;
		ResetPos(playerid);
	}
		
	switch(MinigameMode[playerid])
	{

		case 1://event
		{
			new rand = random(sizeof(SPAWN_MINIGUN));
			JBC_SetPlayerPosEx(playerid, SPAWN_MINIGUN[rand][0], SPAWN_MINIGUN[rand][1], SPAWN_MINIGUN[rand][2], SPAWN_MINIGUN[rand][3]);

			JBC_SetPlayerArmour(playerid, 0.0);
			JBC_SetPlayerHealth(playerid, 100.0);

			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 5);

			JBC_ResetPlayerWeapons(playerid);
			JBC_GivePlayerWeapon(playerid, 38, 99999);
			SetPlayerTeam(playerid, NO_TEAM);
		}
			//PAINTBALL
		case 2:
		{
			new rand = random(sizeof(SPAWN_PAINTBALL));
			JBC_SetPlayerPosEx(playerid, SPAWN_PAINTBALL[rand][0], SPAWN_PAINTBALL[rand][1], SPAWN_PAINTBALL[rand][2], SPAWN_PAINTBALL[rand][3]);
			SetPlayerInterior(playerid, 10);
			SetPlayerVirtualWorld(playerid, 1);
			JBC_SetPlayerHealth(playerid, 100);
			JBC_SetPlayerArmour(playerid, 0);
			JBC_TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer( playerid );
			SetPlayerTeam(playerid, NO_TEAM);
			PaintBall(playerid);
		}
			//RW

			//WW2
		case 3:
		{
			new rand = random(sizeof(SPAWN_WW2));
			JBC_SetPlayerPosEx(playerid, SPAWN_WW2[rand][0], SPAWN_WW2[rand][1], SPAWN_WW2[rand][2], SPAWN_WW2[rand][3]);
			JBC_TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer( playerid );
			SetPlayerTeam(playerid, NO_TEAM);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 1);
			JBC_ResetPlayerWeapons(playerid);
			JBC_GivePlayerWeapon(playerid,24,1000);
			JBC_GivePlayerWeapon(playerid,25,10000);
			JBC_GivePlayerWeapon(playerid,34,10000);
			JBC_SetPlayerHealth(playerid,100.0);
			JBC_SetPlayerArmour(playerid, 100);
			JBC_SetPlayerHealth(playerid, 100);
			JBC_SetPlayerArmour(playerid, 100);
		}
			//RW
		case 4://RW
		{
			new rand = random(sizeof(SPAWN_RW));
			JBC_SetPlayerPosEx(playerid, SPAWN_RW[rand][0], SPAWN_RW[rand][1], SPAWN_RW[rand][2], SPAWN_RW[rand][3]);
			JBC_TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer( playerid );
			SetPlayerTeam(playerid, NO_TEAM);
			JBC_ResetPlayerWeapons(playerid);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 4);
			JBC_GivePlayerWeapon(playerid,23,10000);
			JBC_GivePlayerWeapon(playerid,26,10000);
			JBC_GivePlayerWeapon(playerid,28,10000);
			JBC_SetPlayerHealth(playerid,100.0);
			JBC_SetPlayerHealth(playerid, 100);
			JBC_SetPlayerArmour(playerid, 100);
		}
			//PESADAS
		case 5:
		{
			new rand = random(sizeof(SPAWN_PESADAS));
			JBC_SetPlayerPosEx(playerid, SPAWN_PESADAS[rand][0], SPAWN_PESADAS[rand][1], SPAWN_PESADAS[rand][2], SPAWN_PESADAS[rand][3]);
			JBC_TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer( playerid );
			SetPlayerTeam(playerid, NO_TEAM);
			SetPlayerInterior(playerid,15);
			SetPlayerVirtualWorld(playerid, 1);
			JBC_ResetPlayerWeapons(playerid);
			JBC_GivePlayerWeapon(playerid,16,10000);
			JBC_GivePlayerWeapon(playerid,34,10000);
			JBC_GivePlayerWeapon(playerid,35,10000);
			JBC_GivePlayerWeapon(playerid,39,10000);
			JBC_SetPlayerHealth(playerid,100.0);
			JBC_SetPlayerArmour(playerid,100.0);
  		}
  		//MATADERO
		case 6:
		{
			new rand = random(sizeof(SPAWN_MATADERO));
			JBC_SetPlayerPosEx(playerid, SPAWN_MATADERO[rand][0], SPAWN_MATADERO[rand][1], SPAWN_MATADERO[rand][2], SPAWN_MATADERO[rand][3]);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 1);
			JBC_SetPlayerHealth(playerid, 30);
			JBC_SetPlayerArmour(playerid, 0);
			JBC_TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer( playerid );
			SetPlayerTeam(playerid, NO_TEAM);
			JBC_ResetPlayerWeapons(playerid);
			JBC_GivePlayerWeapon(playerid,9,1);
			JBC_GivePlayerWeapon(playerid,34,100);
		}
		//COLISEO
		case 7:
		{
			JBC_SetPlayerPos(playerid, 1416.0387, -45.2366, 1000.9264); //cambiar
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld (playerid, 6);
			JBC_SetPlayerHealth(playerid, 100);
			JBC_SetPlayerArmour(playerid, 100);
			JBC_TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer( playerid );
			JBC_SetPlayerSkin(playerid, 155);
			SetPlayerTeam(playerid, TEAM_COLISEO);
			JBC_ResetPlayerWeapons(playerid);
			JBC_GivePlayerWeapon(playerid,43,1000);
		}
	 }
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(IsPlayerConnected(playerid))
	{
		if(ChatLock[playerid] == false) 
			return 0;
		new 
			autoMessages[128];

		if(AFK[playerid] == 1)
		{
			SendClientMessage(playerid, GetPlayerColor(playerid), "[AFK] Para volver a hablar, sal del Modo AFK con /volver");
			return 0;
		}

		if(strfind(text, "cambio de team", true) != -1 || strfind(text, "cambia de equipo", true) != -1 || strfind(text, "cambio de equipo", true) != -1)
		{
			new RandomText = sizeof(BotMessages);
			format(autoMessages,sizeof(autoMessages),"[AYUDA] {FFE200} %s",BotMessages[random(RandomText)]);
			SendClientMessageToAll(-1,autoMessages);
			return 0;
		}
	
		if(strfind(text, "hacker", true) != -1 || strfind(text, "reporte", true) != -1 || strfind(text, "reportar", true) != -1 && strfind(text, "reportalo", true) == -1 || strfind(text, "cheats", true) != -1 || strfind(text,"cheater", true) != -1)
		{
			new RandomText = sizeof(BotMessages2);
			format(autoMessages, sizeof(autoMessages),"[AYUDA] {FFE200}%s", BotMessages2[random(RandomText)]);
			SendClientMessageToAll(-1,autoMessages);
			return 0;
		}
		if(strfind(text, "se conquista", true) != -1 || strfind(text, "conquisto un territorio", true) != -1 || strfind(text, "se conquista", true) != -1 || strfind(text, "para conquistar", true) != -1)
		{
			SendClientMessageToAll(-1,"[AYUDA] {FFE200}Para saber como se conquista un territorio usa /AYUDA, posteriormente va a la sección de 'Territorios'");
			return 0;
		}
		if(strfind(text, "ser vip", true) != -1 || strfind(text, "hago vip", true) != -1 || strfind(text, "dame vip", true) != -1)
		{
			SendClientMessageToAll(COLOR_RED,"[AYUDA] VIPS: {ffffff}Los usuarios VIP poseen privilegios únicos en el servidor puedes leer los /vCMDS");
			SendClientMessageToAll(COLOR_RED,"[VIPS]: {FFFFFF}Membresias disponibles: "VIP1_COLOR"VIP1 {04B404}$5{ffffff} | "VIP2_COLOR"VIP2 {04B404}$8");
			return 0;
		}
		if(strfind(text, "donde comprar auto", true) != -1 || strfind(text, "donde esta el conscencionario", true) != -1 || strfind(text, "donde queda wang cars", true) != -1)
		{
			SendClientMessageToAll(-1,"{FFE200}[AYUDA] Wang Cars queda en cerca de /AEROSF. Busca en el mapa un ícono de un auto");
			return 0;
		}
		if(strfind(text, "cesar", true) != -1 || strfind(text, "zezar", true) != -1 || strfind(text, "cisar", true) != -1 || strfind(text, "bryle", true)!= -1 || strfind(text, "admins", true) != -1 || strfind(text, "staff", true) != -1 || strfind(text, "admin", true) != -1 || strfind(text, "brail", true) != -1)
		{
			SendClientMessageToAll(-1,"[AYUDA] {FFE200}Recuerda que todos los /admins pueden ayudarte.");
			return 0;
		}
		if(strfind(text, "donde compro armas", true) != -1 || strfind(text, "donde esta la tienda", true) != -1 || strfind(text, "como me lleno la vida", true) != -1 || strfind(text, "como recupero vida", true) != -1)
		{
			SendClientMessageToAll(-1, "[AYUDA] {FFE200}Si necesitas comprar armas, comida, armadura, y funciones especiales puedes ir a GP SHOP.");
			SendClientMessageToAll(-1, "[AYUDA] {FFE200}La tienda de GP, está ubícada como calavera celeste en el mapa.");
			SendClientMessageToAll(-1, "[AYUDA] {FFE200}También puedes recuperar vida(parcial) bebiendo sodas en las maquinas sprunk por $1.");
			return 0;
		}
		if(strfind(text, "bug", true) != -1 || strfind(text, "b ug", true)  != -1 || strfind(text, "bu g", true) != -1 || strfind(text, "b u g", true) != -1 && strfind(text, "cbug", true) == -1)
		{
    		SendClientMessageToAll(-1, "[AYUDA] {FFE200} Si encuentas un bug, repórtalo en /facebook en el post \"Reportes de errores\"");
			return 0;
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(EnEvento[playerid] == 1 && CheckPlayerAdmin(playerid) == 0)
	{
		DestroyVehicle(vEvents[playerid]);
		SpawnPlayer(playerid);
		ResetPos(playerid);
		SendClientMessage(playerid, COLOR_RED, "[INFO] Has sido sacado del evento por bajar del vehículo.");
	}
	
	if(Events[playerid][Blindado] == 0 && GetPlayerVehicleID(playerid) == 498 && GetPlayerVirtualWorld(playerid) != 2)
	{
		DestroyVehicle(vEvents[playerid]);
	}
	return 1;
}
//Borrar en caso que genera incovenientes
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	if(MinigameMode[playerid] != 0 && oldinteriorid != 0 && newinteriorid == 0)
	{
		SpawnPlayer(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{	
	if(IsPlayerConnected(killerid))		
	{	
		received[playerid] = false;
		received[killerid] = false;
		buyedArmour[playerid] = 0;

		if(killerid != INVALID_PLAYER_ID)
		{
			new 
				randomMessage,
				m[128],
				l[128],
				r[128];

			randomMessage = random(sizeof(murderText));
			streak[killerid] += 1;
			totalReward[killerid] += 250;
			
			if(totalReward[killerid] >= 1250 && streak[killerid] >= 5)
			{
				GameTextForPlayer(killerid,murderText[randomMessage], 2000, 4);
				Delete3DTextLabel(label[killerid]);
				
				format(m, sizeof(m), "[KillingSpree] %s lleva {FFFFFF}%d{78D1FF} asesinatos sin morir! [recompensa: $%d]", pName(killerid),streak[killerid],totalReward[killerid]);
				SendClientMessageToAll(0x78D1FFFF, m);
				
				format(l, sizeof(l), "[BUSCADO] Recompensa por el: $%d", totalReward[killerid]);
				
				label[killerid] = Create3DTextLabel(l,0xF50C93FF,30.0,40.0,50.0,40.0,0);
				
				Attach3DTextLabelToPlayer(label[killerid], killerid, 0.0, 0.0, 0.7);
				Delete3DTextLabel(label[playerid]);
			}
		
			if(totalReward[playerid] >= 1250)
			{
				SetPlayerChocolate(killerid,GetPlayerChocolate(killerid)+totalReward[playerid]);
				
				format(r, sizeof(r), "[KillingSpree] %s terminó con %s [%d kills] [recompensa: $%d]",pName(killerid), pName(playerid), streak[playerid],totalReward[playerid]);
				SendClientMessageToAll(0xB62E46FF, r);
			}	 
			streak[playerid]= 0;
			totalReward[playerid]= 0;

			if(EnEvento[playerid] ==1)
			{
				Events[playerid][Escondidas] = 0;
				Events[playerid][AvionMuerte] = 0;
				Events[playerid][Supervivencia] = 0;
				Events[playerid][AutosChocadores] = 0;
				Events[playerid][Blindado] = 0;
				DestroyVehicle(vEvents[playerid]);
			}

			if(MinigameMode[playerid] == 7 && MinigameMode[killerid] == 7)
			{
				received[playerid] = false;
				received[killerid] = false;
			}
			
		}
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_YES)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2285.7854,-1681.1276,14.1323))
		{
			if(IsPlayerInAnyVehicle(playerid)) return 0;
			ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST, ""blue"GP "white"SHOP",""white"Armas\n"white"Vehículos(temporales)\nComestibles\nEspecial", "Continuar", "Salir");
		}
		
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1875.1498,-1883.6227,13.4598))
		{
			if(IsPlayerInAnyVehicle(playerid)) return 0;
			ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST, ""blue"GP "white"SHOP",""white"Armas\n"white"Vehículos(temporales)\nComestibles\nEspecial", "Continuar", "Salir");
		}
		
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 2033.0740,-1402.9579,17.2843))
		{
		
			if(IsPlayerInAnyVehicle(playerid)) return 0;
			ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST, ""blue"GP "white"SHOP",""white"Armas\n"white"Vehículos(temporales)\nComestibles\nEspecial", "Continuar", "Salir");
		}
		
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1257.1116,-1237.0879,18.1491))
		{
		
			if(IsPlayerInAnyVehicle(playerid)) return 0;
			ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST, ""blue"GP "white"SHOP",""white"Armas\n"white"Vehículos(temporales)\nComestibles\nEspecial", "Continuar", "Salir");
		}
		
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1489.0989,-1720.3221,8.2355))
		{
		
			if(IsPlayerInAnyVehicle(playerid)) return 0;
			ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST, ""blue"GP "white"SHOP",""white"Armas\n"white"Vehículos(temporales)\nComestibles\nEspecial", "Continuar", "Salir");
		}
		
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 3249.6118, -1904.9523, 28.2086))
		{
		
			if(IsPlayerInAnyVehicle(playerid)) return 0;
			ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST, ""blue"GP "white"SHOP",""white"Armas\n"white"Vehículos(temporales)\nComestibles\nEspecial", "Continuar", "Salir");
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(IsPlayerInAnyVehicle(playerid))
		return 0;
/*    if(dialogid == DIALOG_EVENTLIST)g
    {
        if(!response) return 1;

        switch(listitem)
        {
            case 0:
            {
                new s[450];
               strcat(s, "{B43104}Indicaciones para el administrador.\n");
               strcat(s, "{00BFFF}Descripción: {FFFFFF}El evento escondidas consiste en encontrar a todos los jugadores y el último en ser encontrado gana.\n");
               strcat(s, "{00BFFF}Reglas: {FFFFFF}No se permite el uso de animaciones ya que al realizarlas podrían aventajarse y ser encontrados de último.\n");
               strcat(s, "{01DF3A}¿Estás seguro que deseas activar este evento?");
               ShowPlayerDialog(playerid, DIALOG_HIDESEEK, DIALOG_STYLE_MSGBOX, "{FFFFFF}Configuración del evento", s, "Sí", "Cancelar");
                return 1;
            }
            case 1:
            {
                new s[450];
                strcat(s, "{B43104}Indicaciones para el administrador.\n");
                strcat(s, "{00BFFF}Descripción: {FFFFFF}El evento avión de la muerte consiste en dar tantos giros como puedas, el último en pie gana.\n");
                strcat(s, "{FFFFFF}Sí se permite el uso de acciones.\n");
                strcat(s, "{00BFFF}Reglas: {FFFFFF}No se permite golpear el avión o a un jugador para mal lograr el evento.\n");
                strcat(s, "{01DF3A}¿Estás seguro que deseas activar este evento?");
                ShowPlayerDialog(playerid, DIALOG_AIRPLANEDEAD, DIALOG_STYLE_MSGBOX, "{FFFFFF}Configuración del evento", s, "Sí", "Cancelar");
                return 1;
            }
            case 2:
            {
                new s[450];
                strcat(s, "{B43104}Indicaciones para el administrador.\n");
                strcat(s, "{00BFFF}Descripción: {FFFFFF}El evento supervivencia simplemente consiste en sobrevivir a una serie de adversidades como\n");
                strcat(s, "{FFFFFF}ataques imprevistos, carencia de munición, vida, armadura y todo tipo de obstaculo que se presente.\n");
                strcat(s, "{00BFFF}Reglas: {FFFFFF}No se permite el uso de acciones debido a que lo utilizarían para ocultarse y no recibir daño.\n");
                strcat(s, "{01DF3A}¿Estás seguro que deseas activar este evento?");
                ShowPlayerDialog(playerid, DIALOG_SURVIVAL, DIALOG_STYLE_MSGBOX, "{FFFFFF}Configuración del evento", s, "Sí", "Cancelar");
                return 1;
            }
            case 3:
            {
                new s[450];
                strcat(s, "{B43104}Indicaciones para el administrador.\n");
                strcat(s, "{00BFFF}Descripción: {FFFFFF}El evento autos chocones se basa en impactar al enemígo con el vehículo hasta hacerlo explotar\n");
                strcat(s, "{FFFFFF}el último con vehículo sin explotar gana.\n");
                strcat(s, "{00BFFF}Reglas: {FFFFFF}En este evento no hay reglas, salvo por los jugadores VIP, no se permite el uso de nitro ni repair.\n");
                strcat(s, "{01DF3A}¿Estás seguro que deseas activar este evento?");
                ShowPlayerDialog(playerid, DIALOG_EVENTCARS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Configuración del evento", s, "Sí", "Cancelar");
                return 1;
            }
        	case 4:
            {
                new s[850];
                strcat(s, "{B43104}Indicaciones para el administrador.\n");
                strcat(s, "{00BFFF}Descripción: {FFFFFF}En el evento retadores se generarán dos equipos, equipo "beige"indigente{ffffff}, y el equipo "red"magnate\n");
                strcat(s, "{ffffff}el equipo "beige"indigente {ffffff}está de color "beige"naranja{ffffff}, y los "red"magnate {ffffff}de color "red"rosa.\n");
                strcat(s, "{ffffff}Considerando que sí un jugador gana todo el{FF0000} equipo {ffffff}gana y por ende el equipo ganador tiene derecho a un {cc9900}premio.\n");
                strcat(s, "{00BFFF}Reglas: {FFFFFF}No se permiten acciones, ni alejarse demasiado de la zona de batalla.\n");
                strcat(s, "{01DF3A}¿Estás seguro que deseas activar este evento?");
                ShowPlayerDialog(playerid, DIALOG_CHALLENGERS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Configuración del evento", s, "Sí", "Cancelar");
                return 1;
            }
        	//---------------------------------------------Eventos faltantes-----------------------
            case 5:
            {
                new s[850];
                strcat(s, "{B43104}Indicaciones para el administrador.\n");
                strcat(s, "{00BFFF}Descripción: {FFFFFF}En el evento blindado consiste en hacer una emboscada al camión sin destruirlo\n");
                strcat(s, "{ffffff}El jugador que logre subir al camión {FF0000} ganará el evento\n");
                strcat(s, "{00BFFF}Reglas: {FFFFFF}Ninguna, sí se permite el uso de {FF0000}/vrepair{ffffff} para jugadores VIP.\n");
                strcat(s, "{01DF3A}¿Estás seguro que deseas activar este evento?");
                ShowPlayerDialog(playerid, DIALOG_ARMORED, DIALOG_STYLE_MSGBOX, "{FFFFFF}Configuración del evento", s, "Sí", "Cancelar");
                return 1;
            }

        }
        return 1;
    }

    switch(dialogid)
    {
        case DIALOG_HIDESEEK:
        {
            if(!response)
                return 1;

            for(new i=0;i<MAX_PLAYERS;i++)
            {
                Events[i][Escondidas] = 1;
                OnEvento[i] = 1;
                IniciadoEvento[i] = 1;
            }

            new s[135];

            format(s, sizeof(s), "[Evento] {33FFCC}%s{33FFCC} {FFFFFF}activó el evento escondidas,{FFFFFF} {66FFFF}/evento", pName(playerid));
            SendClientMessageToAll(COLOR_ORANGE, s);

            SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} Para iniciar el evento y cerrar la entrada al mismo usa {FFFFFF}{66FFFF}/iniciar evento");
            SendClientMessage(playerid, COLOR_ORANGE, "[Obligatorio]{FFFFFF} Cuando el evento haya finalizado usa {FFFFFF}{66FFFF}/finalizar{66FFFF}{FFFFFF}.");

            JBC_SetPlayerPos(playerid, 364.0277, 173.9070, 1008.3828);
            SetPlayerFacingAngle(playerid, 264.5110);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 3);
            SetPlayerVirtualWorld(playerid, 2);
            JBC_SetPlayerArmour(playerid, 100);

            Events[playerid][Escondidas] = 1;
            e_started = false;
            SaveLogData("eventos.txt", s);
            return 1;
        }
    }

    switch(dialogid)
    {
        case DIALOG_AIRPLANEDEAD:
        {
            if(!response)
                return 1;

            for(new i=0;i<MAX_PLAYERS;i++)
            {
                Events[i][AvionMuerte] = 1;
                OnEvento[i] = 1;
                IniciadoEvento[i] = 1;
            }

            new s[135];

            format(s, sizeof(s), "[Evento] {33FFCC}%s{33FFCC} {FFFFFF}activó el evento avión de la muerte, {FFFFFF}{66FFFF}/evento", pName(playerid));
            SendClientMessageToAll(COLOR_ORANGE, s);

            SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} Para iniciar el evento y cerrar la entrada al mismo usa {FFFFFF}{66FFFF}/iniciar evento");
            SendClientMessage(playerid, COLOR_ORANGE, "[Obligatorio]{FFFFFF} Cuando el evento haya finalizado usa {FFFFFF}{66FFFF}/finalizar{66FFFF}{FFFFFF}.");

            JBC_SetPlayerPos(playerid, 1940.3300, -2494.1633, 13.5391);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 2);
            SetPlayerFacingAngle(playerid, 88.8963);

            vEvents[playerid] = JBC_CreateVehicle(519, 1940.3300, -2494.1633, 13.5391, 88.8963, 0, -1, -1);

            SetVehicleVirtualWorld(vEvents[playerid], 2);
            JBC_PutPlayerInVehicle(playerid,  vEvents[playerid], 0);
            SetPlayerTime(playerid, 20, 0);
            SetPlayerWeather(playerid, 10);
            JBC_SetPlayerArmour(playerid, 100);

            Events[playerid][AvionMuerte] = 1;
            e_started = false;
            SaveLogData("eventos.txt", s);
            return 1;
        }
    }

    switch(dialogid)
    {
        case DIALOG_SURVIVAL:
        {
            if(!response)
                return 1;

            for(new i=0;i<MAX_PLAYERS;i++)
            {
                Events[i][Supervivencia] = 1;
                OnEvento[i] = 1;
                IniciadoEvento[i] = 1;
            }

            new s[135];

            format(s, sizeof(s), "[Evento] {33FFCC}%s{33FFCC} {FFFFFF}activó el evento supervivencia,{FFFFFF} {66FFFF}/evento", pName(playerid));
            SendClientMessageToAll(COLOR_ORANGE, s);

            SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} Para iniciar el evento y cerrar la entrada al mismo usa {FFFFFF}{66FFFF}/iniciar evento");
            SendClientMessage(playerid, COLOR_ORANGE, "[Obligatorio]{FFFFFF} Cuando el evento haya finalizado usa {FFFFFF}{66FFFF}/finalizar{66FFFF}{FFFFFF}.");

            SetPlayerTime(playerid, 4, 0);
            SetPlayerWeather(playerid, 31);
            JBC_SetPlayerPos(playerid, 1319.3226, 312.4758, 19.4063);
            SetPlayerFacingAngle(playerid, 62.2860);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 2);
            JBC_SetPlayerArmour(playerid, 100);

            Events[playerid][Supervivencia] = 1;
            e_started = false;
            SaveLogData("eventos.txt", s);
            return 1;
        }
    }

    switch(dialogid)
    {
        case DIALOG_EVENTCARS:
        {
            if(!response)
            return 1;

            for(new i=0;i<MAX_PLAYERS;i++)
            {
                Events[i][AutosChocadores] = 1;
                OnEvento[i] = 1;
                IniciadoEvento[i] = 1;

                SetPlayerTime(playerid, 5, 0);
                SetPlayerWeather(playerid, 36);
            }

            new s[135];

            format(s, sizeof(s), "[Evento]{FFFFFF} {33FFCC}%s{33FFCC} {FFFFFF}activó el evento de autos chocones,{FFFFFF} {66FFFF}/evento", pName(playerid));
            SendClientMessageToAll(COLOR_ORANGE, s);

            SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} Para iniciar el evento y cerrar la entrada al mismo usa {FFFFFF}{66FFFF}/iniciar evento");
            SendClientMessage(playerid, COLOR_ORANGE, "[Obligatorio]{FFFFFF} Cuando el evento haya finalizado usa {FFFFFF}{66FFFF}/finalizar{66FFFF}{FFFFFF}.");

            JBC_SetPlayerPos(playerid, 1410.6575, 2153.6111, 18.5391);
            SetPlayerFacingAngle(playerid, 96.3294);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld(playerid, 2);
            SetPlayerInterior(playerid, 0);
            SetPlayerTime(playerid, 5, 0);
            SetPlayerWeather(playerid, 36);
            SetVehicleVirtualWorld( vEvents[playerid], 2);
            JBC_SetPlayerArmour(playerid, 100);

            Events[playerid][AutosChocadores] = 1;
            e_started = false;
            SaveLogData("eventos.txt", s);
            return 1;
        }
    }

    switch(dialogid)
    {
        case DIALOG_CHALLENGERS:
        {
            if(!response)
                return 1;

            for(new i=0;i<MAX_PLAYERS;i++)
            {
                Events[i][Retadores] = 1;
                OnEvento[i] = 1;
                IniciadoEvento[i] = 1;
            }

            new s[135];

            format(s, sizeof(s), "[Evento]{FFFFFF} {33FFCC}%s{33FFCC} {FFFFFF}activó el evento retadores,{FFFFFF} {66FFFF}/evento", pName(playerid));
            SendClientMessageToAll(COLOR_ORANGE, s);

            SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} Para iniciar el evento y cerrar la entrada al mismo usa {FFFFFF}{66FFFF}/iniciar evento");
            SendClientMessage(playerid, COLOR_ORANGE, "[Obligatorio]{FFFFFF} Cuando el evento haya finalizado usa {FFFFFF}{66FFFF}/finalizar{66FFFF}{FFFFFF}.");
            JBC_SetPlayerPos(playerid, -2477.6116, 2285.9343, 21.0955);
            SetPlayerFacingAngle(playerid, 342.7657);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld(playerid, 2);
            SetPlayerInterior(playerid, 0);
            SetPlayerTime(playerid, 6, 0);
            JBC_SetPlayerArmour(playerid, 100);

            e_started = false;
            SaveLogData("eventos.txt", s);
            return 1;
        }
    }

    switch(dialogid)
    {
        case DIALOG_ARMORED:
        {
            if(!response)
                return 1;

            for(new i=0;i<MAX_PLAYERS;i++)
            {
                Events[i][Blindado] = 1;
                OnEvento[i] = 1;
                IniciadoEvento[i] = 1;
                blindzone = GangZoneCreate(-2427.8123, -211.5190, -1999.6635, 308.9568);
            }

            GangZoneShowForPlayer(playerid, blindzone, COLOR_BLIND);
            new
                s[135],
                Float:c_x = -2251.8035,
                Float:c_y = -85.6096,
                Float:c_z = 34.7970,
                Float:c_an =
                359.3263
            ;

            format(s, sizeof(s), "[Evento]{FFFFFF} {33FFCC}%s{33FFCC} {FFFFFF}activó el evento blindado,{FFFFFF} {66FFFF}/evento", pName(playerid));
            SendClientMessageToAll(COLOR_ORANGE, s);
            SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} Para iniciar el evento y cerrar la entrada al mismo usa {FFFFFF}{66FFFF}/iniciar evento");
            SendClientMessage(playerid, COLOR_ORANGE, "[Obligatorio]{FFFFFF} Cuando el evento haya finalizado usa {FFFFFF}{66FFFF}/finalizar{66FFFF}{FFFFFF}.");
            JBC_SetPlayerPos(playerid, c_x, c_y, c_z);
            SetPlayerFacingAngle(playerid, c_an);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld(playerid, 2);
            SetPlayerInterior(playerid, 0);

            vEvents[playerid] =  JBC_CreateVehicle(428, c_x, c_y, c_z, c_an, 127, 127, -1);
            SetVehicleVirtualWorld(vEvents[playerid], 2);
            JBC_PutPlayerInVehicle(playerid, vEvents[playerid], 0);
            IsVehicleBlind[playerid] = true;

            SetPlayerTime(playerid, 19, 0);
            SetPlayerWeather(playerid, 29);
            JBC_SetPlayerHealth(playerid, 100);
            JBC_SetPlayerArmour(playerid, 100);
            Events[playerid][Blindado] = 1;
            e_started = false;
            SaveLogData("Events.txt", s);
            return 1;
        }
    }
*/

    if(dialogid == DIALOG_SHOP)
	{
	    if(!response)
            return SendClientMessage(playerid,0xFFFF00FF,"[HECHO] Vísitame cuando lo necesites.");

        new 
        	s[500];
        
        switch(listitem)
			{
		    case 0:
		    {
			    strcat(s, "{FF0000}Arma\t{66FF99}Precio\t{cc9900}Municion\nDeagle\t$"#DESERT_PRICE"\t150\nEscopeta normal\t$"#COMBAT_PRICE"\t150\nEscopeta de combate\t$"#COMBAT_PRICE"\t174\nM4\t$"#M4_PRICE"\t650\nAK-47\t$"#AK_PRICE"\t650\nMP5\t$"#MP5_PRICE"\t650\nTec-9\t$"#TEC_PRICE"\t500\nSniper\t$"#SNIPER_PRICE"\t60\nHeat Seaker\t$"#HEAT_PRICE"\t30\nRocket\t$"#RPG_PRICE"\t25\nSatchel Explosives\t$"#C4_PRICE"\t25\nbuyedArmour[ Completo\t$"#ARMOUR_PRICE"\t1");
			    ShowPlayerDialog(playerid,DIALOG_WEAPS,5,"{ffffff}Armas", s,"Comprar","Volver");
			    return 1;
		    }

			case 1:
			{
			    strcat(s, "{00BFFF}Nombre\t{66FF99}Precio\nSultan\t$"#SULTAN_PRICE"\nInfernus\t$"#INFERNUS_PRICE"\nCheetah\t$"#CHEETAH_PRICE"\nBanshee\t$"#BANSHEE_PRICE"\nTurismo\t$"#TURISMO_PRICE"\nBullet\t$"#BULLET_PRICE"\nMonster Truck\t$"#MONSTER_PRICE"\nNRG-500\t$"#NRG_PRICE"\nKart\t$"#KART_PRICE"\nDumper\t$"#DUMPER_PRICE"\nRhino\t$"#RHINO_PRICE"\nHydra\t$"#HYDRA_PRICE"\nHunter\t$"#HUNTER_PRICE"");
			    ShowPlayerDialog(playerid,DIALOG_VEHICLES,5,"{ffffff}Vehículos", s ,"Comprar","Volver");
			    return 1;
			}

			case 2:
			{
			    ShowPlayerDialog(playerid,DIALOG_FOOD,5,"{ffffff}Comestibles","{00BFFF}Nombre\t{66FF99}Precio\t{FF8000}vida\nSalad\t$250\t10\nSoda\t$500\t15\nPizza\t$750\t20\nPasta\t$1000\t30\nWine\t$1250\t60\nWeed\t$1500\tVida Completa","Comprar","Volver");
			    return 1;
			}

			case 3:
			{
			    strcat(s, "{00BFFF}Producto\t{66FF99}Precio\nCompra de score: 1.000\t$"#BUYSCORE_PRICE"\nAnuncio en Paintball\t$"#PAINTBALL_A_PRICE"\nAnuncio en Matadero \t$"#ABATTOIR_A_PRICE"\nAnuncio en WW2\t$"#WW2_A_PRICE"\nAnuncio en Duelo\t$"#DUEL_A_PRICE"\nResetear Advertencias\t2000 Score + $"#WARNRESET_PRICE"\nOcultarse del radar(hasta morir)\t$"#HIDDEN_PRICE"");
			    ShowPlayerDialog(playerid, DIALOG_SPECIAL, 5, "{ffffff}Especial", s, "Elegir", "Volver");
			    return 1;
			}
		}
	}

	if(dialogid == DIALOG_WEAPS)
	{
	    if(!response)
            return
                ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST,"{2E9AFE}GP {ffffff}SHOP","{ffffff}Armas\nVehículos\nComestibles\nEspecial","Elegir","Salir");

        switch(listitem)
		{
		    case 0:
            {
                if(GetPlayerChocolate(playerid) < DESERT_PRICE)
                    return SendClientMessage(playerid, COLOR_RED,"[ERROR] Necesitas $"#DESERT_PRICE" para comprar esta arma.");

                SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-DESERT_PRICE);
                JBC_GivePlayerWeapon(playerid,24, 150);
                PlayerPlaySound(playerid, 1052, 0, 0, 0);
                SendClientMessage(playerid, 0xFFFFFFFF, "[GP SHOP] El costo de tu {ff0000}Desert Deagle{ffffff} es de $"#DESERT_PRICE".");

                if(CheckVip(playerid) == 2)
		        {
		        	DiscountChocolate(playerid, DESERT_PRICE, 25);
                }
            }

            case 1:
            {
                if(GetPlayerChocolate(playerid) < COMBAT_PRICE)
                    return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#COMBAT_PRICE" para comprar esta arma.");

        		SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-COMBAT_PRICE);
        		JBC_GivePlayerWeapon(playerid, 27, 150);
        		PlayerPlaySound(playerid, 1052, 0, 0, 0);
        		SendClientMessage(playerid, 0xFFFFFFFF, "[GP SHOP] Has comprado una {ff0000}escopeta de combate{ffffff} - te costo: $"#COMBAT_PRICE"");

                if(CheckVip(playerid) == 2)
        		{
                    DiscountChocolate(playerid, COMBAT_PRICE, 25);
            	}
            }

            case 2:
            {

                if(GetPlayerChocolate(playerid) < COMBAT_PRICE)
                    return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#COMBAT_PRICE" para comprar esta arma.");

                SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-COMBAT_PRICE);
    		    JBC_GivePlayerWeapon(playerid,27,174);
                PlayerPlaySound(playerid,1052,0,0,0);
        		SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado una {ff0000}SPAS{ffffff} - te costo: $"#COMBAT_PRICE"");

                if(CheckVip(playerid) == 2)
        		{
            		DiscountChocolate(playerid, COMBAT_PRICE, 25);
                }
            }
            case 3:
		    {
                if(GetPlayerChocolate(playerid) < M4_PRICE)
                    return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#M4_PRICE" para comprar esta arma.");

                SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-M4_PRICE);
        		JBC_GivePlayerWeapon(playerid,31,650);
        		PlayerPlaySound(playerid,1052,0,0,0);
        		SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado una {ff0000}M4{ffffff} - te costo: $"#M4_PRICE"");

                if(CheckVip(playerid) == 2)
        		{
            		DiscountChocolate(playerid, M4_PRICE, 25);
                }
            }
            case 4:
            {
                if(GetPlayerChocolate(playerid) < AK_PRICE)
                    return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#AK_PRICE" para comprar esta arma.");

        		SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-AK_PRICE);
        		JBC_GivePlayerWeapon(playerid,30,650);
        		PlayerPlaySound(playerid,1052,0,0,0);
        		SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado una {ff0000}AK47{ffffff} - te costo: $"#AK_PRICE"");

                if(CheckVip(playerid) == 2)
        		{
        		    DiscountChocolate(playerid, AK_PRICE, 25);
                }
            }
            case 5:
            {

                if(GetPlayerChocolate(playerid) < MP5_PRICE)
                    return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#MP5_PRICE" para comprar esta arma.");

                SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-MP5_PRICE);
        		JBC_GivePlayerWeapon(playerid,29,650);
        		PlayerPlaySound(playerid,1052,0,0,0);
        		SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado una {ff0000}MP5{ffffff} - te costo: $"#MP5_PRICE"");

                if(CheckVip(playerid) == 2)
        		{
                    DiscountChocolate(playerid, MP5_PRICE, 25);
        		}
            }
            case 6:
            {
                if(GetPlayerChocolate(playerid) < TEC_PRICE)
                    return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#TEC_PRICE" para comprar esta arma.");

                SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-TEC_PRICE);
        		JBC_GivePlayerWeapon(playerid,32,650);
        		PlayerPlaySound(playerid,1052,0,0,0);
        		SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado una {ff0000}Tec9{ffffff} - te costo: $"#TEC_PRICE"");

                if(CheckVip(playerid) == 2)
        		{
                    DiscountChocolate(playerid, TEC_PRICE, 25);
        		}
        	}
            case 7:
            {
            	if(GetPlayerChocolate(playerid) < SNIPER_PRICE)
                	return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#SNIPER_PRICE" para comprar esta arma.");

				SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-SNIPER_PRICE);
				JBC_GivePlayerWeapon(playerid,34,60);
				PlayerPlaySound(playerid,1052,0,0,0);
				SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Sniper{ffffff} - te costo: $"#SNIPER_PRICE"");
				if(CheckVip(playerid) == 2)
				{
					DiscountChocolate(playerid, SNIPER_PRICE, 25);
				}
			}
			case 8:
			{
				if(GetPlayerChocolate(playerid) < HEAT_PRICE)
			   		return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#HEAT_PRICE" para comprar esta arma.");

				SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-HEAT_PRICE);
				JBC_GivePlayerWeapon(playerid,36,30);
				PlayerPlaySound(playerid,1052,0,0,0);
				SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Heat Seaker{ffffff} - te costo: $"#HEAT_PRICE"");
				
				if(CheckVip(playerid) == 2)
				{
					DiscountChocolate(playerid, HEAT_PRICE, 25);
				}
			}
			case 9:
			{
				if(GetPlayerChocolate(playerid) < RPG_PRICE)
			   		return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#RPG_PRICE" para comprar esta arma.");

				SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-RPG_PRICE);
				JBC_GivePlayerWeapon(playerid,35,25);
				PlayerPlaySound(playerid,1052,0,0,0);
				SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Rocket{ffffff} - te costo: $"#RPG_PRICE"");
			
				if(CheckVip(playerid) == 2)
				{
					DiscountChocolate(playerid, RPG_PRICE, 25);
				}
			}
			case 10:
			{

				if(GetPlayerChocolate(playerid) < C4_PRICE)
				   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#C4_PRICE" para comprar esta arma.");
				
				SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-C4_PRICE);
				JBC_GivePlayerWeapon(playerid,39,25);
				JBC_GivePlayerWeapon(playerid,40,25);
				PlayerPlaySound(playerid,1052,0,0,0);
				
				SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Satchel Explosives{ffffff} - te costo: $"#C4_PRICE"");
				
				if(CheckVip(playerid) == 2)
				{
					DiscountChocolate(playerid, C4_PRICE, 25);
				}
			}
			case 11:
			{
				if(GetPlayerChocolate(playerid) < ARMOUR_PRICE)
			   		return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#ARMOUR_PRICE" para comprar esta arma.");

				if(buyedArmour[playerid] == 2)
					return SendClientMessage(playerid,COLOR_RED,"[ERROR] Ya has comprado 2 buyedArmour[s por vida.");
		       	new Float:arm;
		       	
		       	if(GetPlayerArmour(playerid, arm) == 100)
		       		return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya tienes un buyedArmour[ lleno.");

				buyedArmour[playerid]++;
				
				SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-ARMOUR_PRICE);
				JBC_SetPlayerArmour(playerid,100.0);
				PlayerPlaySound(playerid,1052,0,0,0);
				SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}buyedArmour[ completo{ffffff} - te costo: $"#ARMOUR_PRICE"");
				
				if(CheckVip(playerid) == 2)
				{
					DiscountChocolate(playerid, ARMOUR_PRICE, 25);
				}
			}
		}
	}

	if(dialogid == DIALOG_VEHICLES)
	{
		if(!response) 
			return ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST,"{2E9AFE}GP {ffffff}SHOP","{ffffff}Armas\nVehículos\nComestibles\nEspecial","Elegir","Salir");
		
		switch(listitem)
		{
			case 0:
			{
				if(GetPlayerChocolate(playerid) < SULTAN_PRICE)
			   		return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#SULTAN_PRICE" para comprar este vehiculo.");

				DestroyVehicle(buyedCar[playerid]);
				SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-SULTAN_PRICE);
				
				new V,Float:X,Float:Y,Float:Z,Float:A;
				
				GetPlayerPos(playerid,X,Y,Z);
				GetPlayerFacingAngle(playerid,A);
				
				V = JBC_CreateVehicle(560,X,Y,Z,A,random(100),random(100),60000);
				
				PutPlayerInVehicle(playerid, V, 0);
				
				buyedCar[playerid] = V;
				
				PlayerPlaySound(playerid,1052,0,0,0);
				SetVehicleNumberPlate(V, "{FF0000}GP");
				SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Sultan{ffffff} - te costo: $"#SULTAN_PRICE"");
				
				if(CheckVip(playerid) == 2)
				{
					DiscountChocolate(playerid, SULTAN_PRICE, 25);
				}
			}
			case 1:
			{

			if(GetPlayerChocolate(playerid) < INFERNUS_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#INFERNUS_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-INFERNUS_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(411,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Infernus{ffffff} - te costo: $"#INFERNUS_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = INFERNUS_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 2:
			{

			if(GetPlayerChocolate(playerid) < CHEETAH_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#CHEETAH_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-CHEETAH_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(415,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Cheetah{ffffff} - te costo: $"#CHEETAH_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = CHEETAH_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 3:
			{

			if(GetPlayerChocolate(playerid) < BANSHEE_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#BANSHEE_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-BANSHEE_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(429,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Banshee{ffffff} - te costo: $"#BANSHEE_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = BANSHEE_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 4:
			{

			if(GetPlayerChocolate(playerid) < TURISMO_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#TURISMO_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-TURISMO_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(451,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Turismo{ffffff} - te costo: $"#TURISMO_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = TURISMO_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 5:
			{

			if(GetPlayerChocolate(playerid) < BULLET_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#BULLET_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-BULLET_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(541,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Bullet{ffffff} - te costo: $"#BULLET_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = BULLET_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 6:
			{

			if(GetPlayerChocolate(playerid) < MONSTER_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#MONSTER_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-MONSTER_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(556,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Monster Truck{ffffff} - te costo: $"#MONSTER_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = MONSTER_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 7:
			{

			if(GetPlayerChocolate(playerid) < NRG_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#NRG_PRICE" para comprar este vehiculo.");
			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-NRG_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(522,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}NRG-500{ffffff} - te costo: $"#NRG_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = NRG_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 8:
			{

			if(GetPlayerChocolate(playerid) < KART_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#KART_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-KART_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(571,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Kart{ffffff} - te costo: $"#KART_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = KART_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 9:
			{

			if(GetPlayerChocolate(playerid) < DUMPER_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#DUMPER_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-DUMPER_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(406,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Dumper{ffffff} - te costo: $"#DUMPER_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = DUMPER_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 10:
			{

			if(GetPlayerChocolate(playerid) < RHINO_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#RHINO_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-RHINO_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(432,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Rhino{ffffff} - te costo: $"#RHINO_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = RHINO_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 11:
			{

			if(GetPlayerChocolate(playerid) < HYDRA_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#HYDRA_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-HYDRA_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(520,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Hydra{ffffff} - te costo: $"#HYDRA_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = HYDRA_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			case 12:
			{

			if(GetPlayerChocolate(playerid) < HUNTER_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#HUNTER_PRICE" para comprar este vehiculo.");

			DestroyVehicle(buyedCar[playerid]);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-HUNTER_PRICE);
			new V,Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid,X,Y,Z);
			GetPlayerFacingAngle(playerid,A);
			V = JBC_CreateVehicle(425,X,Y,Z,A,random(100),random(100),60000);
			PutPlayerInVehicle(playerid, V, 0);
			buyedCar[playerid] = V;
			PlayerPlaySound(playerid,1052,0,0,0);
			SetVehicleNumberPlate(V, "{FF0000}GP");
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado un {ff0000}Hunter{ffffff} - te costo: $"#HUNTER_PRICE"");
			if(CheckVip(playerid) == 2)
			{
			new discount = HUNTER_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
			}
		}

		if(dialogid == DIALOG_FOOD)
		{
			if(!response) return ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST,"{2E9AFE}GP {ffffff}SHOP","{ffffff}Armas\nVehículos\nComestibles\nEspecial","Elegir","Salir");
			switch(listitem)
			{
			case 0:
			{
			if(GetPlayerChocolate(playerid) < 250) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $250 para comprar este producto.");
			new Float:HP;
			GetPlayerHealth(playerid,HP);
			if(HP >= 100) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Ya tienes la vida llena.");
			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-250);
			if(HP+10 > 100)
			{
			JBC_SetPlayerHealth(playerid,100.0);
			}
			else
			{
			JBC_SetPlayerHealth(playerid,HP+10);
			}
			ApplyAnimation(playerid,"VENDING","VEND_Eat_P",4.1,0,0,0,0,5000,1);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has ingerido {ff0000}Salad{ffffff} - te costo: $250");
			if(CheckVip(playerid) == 2)
			{
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+62);
			PlayerPlaySound(playerid,1052,0,0,0);
			SendClientMessage(playerid, -1, "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$62{FFFFFF} por ser VIP {FFFF33}2.");
			}
			}
			case 1:
			{
			if(GetPlayerChocolate(playerid) < 500) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $500 para comprar este producto.");
			new Float:HP;
			GetPlayerHealth(playerid,HP);
			if(HP >= 100) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Ya tienes la vida llena.");
			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-500);
			if(HP+15 > 100)
			{
			JBC_SetPlayerHealth(playerid,100.0);
			}
			else
			{
			JBC_SetPlayerHealth(playerid,HP+15);
			}
			ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.1,0,0,0,0,5000,1);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has ingerido {ff0000}Soda{ffffff} - te costo: $500");
			if(CheckVip(playerid) == 2)
			{
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+125);
			PlayerPlaySound(playerid,1052,0,0,0);
			SendClientMessage(playerid, -1, "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$125{FFFFFF} por ser VIP {FFFF33}2.");
			}
			}
			case 2:
			{
			if(GetPlayerChocolate(playerid) < 750) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $750 para comprar este producto.");
			new Float:HP;
			GetPlayerHealth(playerid,HP);
			if(HP >= 100) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Ya tienes la vida llena.");
			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-750);
			if(HP+20 > 100)
			{
			JBC_SetPlayerHealth(playerid,100.0);
			}
			else
			{
			JBC_SetPlayerHealth(playerid,HP+20);
			}
			ApplyAnimation(playerid,"VENDING","VEND_Eat_P",4.1,0,0,0,0,5000,1);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has ingerido {ff0000}Pizza{ffffff} - te costo: $750");
			if(CheckVip(playerid) == 2)
			{
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+187);
			PlayerPlaySound(playerid,1052,0,0,0);
			SendClientMessage(playerid, -1, "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$187{FFFFFF} por ser VIP {FFFF33}2.");
			}
			}
			case 3:
			{
			if(GetPlayerChocolate(playerid) < 1000) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $1000 para comprar este producto.");
			new Float:HP;
			GetPlayerHealth(playerid,HP);
			if(HP >= 100) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Ya tienes la vida llena.");
			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-1000);
			if(HP+30 > 100)
			{
			JBC_SetPlayerHealth(playerid,100.0);
			}
			else
			{
			JBC_SetPlayerHealth(playerid,HP+30);
			}
			ApplyAnimation(playerid,"VENDING","VEND_Eat_P",4.1,0,0,0,0,5000,1);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has ingerido {ff0000}Pasta{ffffff} - te costo: $1000");
			if(CheckVip(playerid) == 2)
			{
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+250);
			PlayerPlaySound(playerid,1052,0,0,0);
			SendClientMessage(playerid, -1, "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$250{FFFFFF} por ser VIP {FFFF33}2.");
			}
			}
			case 4:
			{
			if(GetPlayerChocolate(playerid) < 1250) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $1250 para comprar este producto.");
			new Float:HP;
			GetPlayerHealth(playerid,HP);
			if(HP >= 100) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Ya tienes la vida llena.");
			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-1250);
			if(HP+60 > 100)
			{
			JBC_SetPlayerHealth(playerid,100.0);
			}
			else
			{
			JBC_SetPlayerHealth(playerid,HP+60);
			}
			ApplyAnimation(playerid,"VENDING","VEND_Drink_P",4.1,0,0,0,0,5000,1);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has ingerido {ff0000}Pasta{ffffff} - te costo: $1250");
			if(CheckVip(playerid) == 2)
			{
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+312);
			PlayerPlaySound(playerid,1052,0,0,0);
			SendClientMessage(playerid, -1, "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$312{FFFFFF} por ser VIP {FFFF33}2.");
			}
			}
			case 5:
			{
			if(GetPlayerChocolate(playerid) < 1500) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $1500 para comprar este producto.");
			new Float:HP;
			GetPlayerHealth(playerid,HP);
			if(HP >= 100) return SendClientMessage(playerid,COLOR_RED,"[ERROR] Ya tienes la vida llena.");
			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-1500);
			JBC_SetPlayerHealth(playerid,100.0);
			ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.1,0,0,0,0,5000,1);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has ingerido {ff0000}Weed{ffffff} - te costo: $1500");
			if(CheckVip(playerid) == 2)
			{
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+375);
			PlayerPlaySound(playerid,1052,0,0,0);
			SendClientMessage(playerid, -1, "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$375{FFFFFF} por ser VIP {FFFF33}2.");
			}
			}
			}
		}

		if(dialogid == DIALOG_SPECIAL)
		{
			if(!response)
			   return ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_LIST,"{2E9AFE}GP {ffffff}SHOP","{ffffff}Armas\nVehículos\nComestibles\nEspecial","Elegir","Salir");

			switch(listitem)
			{
				case 0:
				{

				if(GetPlayerChocolate(playerid) < BUYSCORE_PRICE)
				   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#BUYSCORE_PRICE" para comprar este producto.");

				PlayerPlaySound(playerid,1150,0,0,0);
				SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-BUYSCORE_PRICE);
				SetPlayerScore(playerid, GetPlayerScore(playerid)+1000);
				SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado {ff0000}1.000 score{ffffff} - te costo: $"#BUYSCORE_PRICE"");
				
				if(CheckVip(playerid) == 2)
				{
					new discount = BUYSCORE_PRICE * 25  / 100, s[135];
					GetPlayerChocolate(playerid);
					SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
					PlayerPlaySound(playerid,1052,0,0,0);
					format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
					SendClientMessage(playerid, -1, s);
				}
				return 1;
				}

			case 1:
			{

			if(GetPlayerChocolate(playerid) < PAINTBALL_A_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#PAINTBALL_A_PRICE" para comprar este producto.");

			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-PAINTBALL_A_PRICE);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado {ff0000}Anuncio PaintBall{ffffff} - te costo: $"#PAINTBALL_A_PRICE"");
			GameTextForAll("OMG OMG ]] Gran matanza en ~w~Paintball ~n~~r~Todo el mundo a ~y~/Paintball! ] ]", 5000, 4);

			if(CheckVip(playerid) == 2)
			{
			new discount = PAINTBALL_A_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}

			return 1;
			}

			case 2:
			{

			if(GetPlayerChocolate(playerid) < ABATTOIR_A_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#ABATTOIR_A_PRICE" para comprar este producto.");

			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-ABATTOIR_A_PRICE);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado {ff0000}Anuncio Matadero{ffffff} - te costo: $"#ABATTOIR_A_PRICE"");
			GameTextForAll("____Go go go! Asesinato y rachas en*** ~n~~r~ ]]~w~/Matadero~r~]]", 5000, 4);

			if(CheckVip(playerid) == 2)
			{
			new discount = ABATTOIR_A_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}

			return 1;
			}

			case 3:
			{

			if(GetPlayerChocolate(playerid) < WW2_A_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#WW2_A_PRICE" para comprar este producto.");

			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-WW2_A_PRICE);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado {ff0000}Anuncio WW2{ffffff} - te costo: $"#WW2_A_PRICE"");
			GameTextForAll("] ] <----> Desmadre, matadero, matanza en <---> ~n~~y~ ____~w~/WW2~y~____ ] ]", 5000, 4);

			if(CheckVip(playerid) == 2)
			{
			new discount = WW2_A_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}

			return 1;
			}

			case 4:
			{

			if(GetPlayerChocolate(playerid) < DUEL_A_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#DUEL_A_PRICE" para comprar este producto.");

			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-DUEL_A_PRICE);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado {ff0000}Anuncio Duelo{ffffff} - te costo: $"#DUEL_A_PRICE"");

			new gtfa[94];
			format(gtfa, sizeof(gtfa), "] ] ] ~n~~r~ %s id:%d esta buscando contrincante para ~n~~w~/duelo.", pName(playerid), playerid);
			GameTextForAll(gtfa, 5000, 4);

			if(CheckVip(playerid) == 2)
			{
			new discount = DUEL_A_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);

			}
			return 1;
			}

			case 5:
			{
			ShowPlayerDialog(playerid, DIALOG_SECUREBUY, DIALOG_STYLE_MSGBOX, "{ffffff}Reseteo de advertencias", "{FF0000}¿Estás seguro que deseas continuar?", "{FFFFFF}Sí", "{FFFFFF}No");
			return 1;
			}

			case 6:
			{

			if(GetPlayerChocolate(playerid) < HIDDEN_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#HIDDEN_PRICE" para comprar este producto.");

			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-HIDDEN_PRICE);
			SetPlayerColor(playerid, 0xFFFFFF00);
			SendClientMessage(playerid,0xFFFFFFFF,"[GP SHOP] Has comprado {ff0000}Ocultarse del radar{ffffff} - te costo: $"#HIDDEN_PRICE"");

			if(CheckVip(playerid) == 2)
			{
			new discount = HIDDEN_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}
			}
		}
		return 1;
	}
		if(dialogid == DIALOG_SECUREBUY)
		{
		    if(!response) return SendClientMessage(playerid,COLOR_RED, "[GP SHOP] Has cancelado la compra de este producto.");
		}

			switch(dialogid)
			{
			case DIALOG_SECUREBUY:
			{

			if(GetPlayerChocolate(playerid) < WARNRESET_PRICE)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas $"#WARNRESET_PRICE" para comprar este producto.");

			if(GetPlayerScore(playerid) < 2000)
			   return SendClientMessage(playerid,COLOR_RED,"[ERROR] Necesitas tener 2000 score para comprar este producto.");

			if(CheckPlayerWarn(playerid) == 0)
			   return SendClientMessage(playerid, COLOR_RED, "[ERROR] No tienes advertencias.");

			PlayerPlaySound(playerid,1150,0,0,0);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-WARNRESET_PRICE);
			SetPlayerScore(playerid,GetPlayerScore(playerid)-3000);
			SetPlayerWarn(playerid, 0);
			SendClientMessage(playerid, COLOR_ORANGE, "[INFO] Pagaste $"#WARNRESET_PRICE" y 2000, tus advertencias han sido reseteadas.");

			if(CheckVip(playerid) == 2)
			{
			new discount = WARNRESET_PRICE * 25  / 100, s[135];
			GetPlayerChocolate(playerid);
			SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discount);
			PlayerPlaySound(playerid,1052,0,0,0);
			format(s, sizeof(s), "{66FFFF}[VIP] {FFFFFF}Se te devolvió {01DF01}$%d{FFFFFF} por ser VIP {FFFF33}2.", discount);
			SendClientMessage(playerid, -1, s);
			}

			return 1;
			}
		  	}

	switch(dialogid)
	{
        case DIALOG_COMMANDS:
        {
            if(!response)
                return 1;

			 if(response)
                {
                        new m[950*3];
                        strcat(m, "{cc9900} Jugador:\n");
        			    strcat(m, "{00FF00}/pm {FF0000}[ID] [Mensaje] {ffffff}- Envía mensaje privado a otro jugador.\n");
        			    strcat(m, "{00FF00}/dardinero {FF0000}[ID] [monto] {ffffff}- Para dar de tu dinero a otro jugador.\n");
            			strcat(m, "{00FF00}/dararma {FF0000}[ID] [munición] {ffffff}- Para dar armas en munición a otros jugadores.\n");
            			strcat(m, "{00FF00}/kill {ffffff}- Comando para suicidarse.\n");
            			strcat(m, "{00FF00}/hora {ffffff}- Muestra la hora actual del servidor.\n");
            			strcat(m, "{00FF00}/acciones {FF0000}[1 - 2 - 3] {ffffff}- Muestra la lista animaciones disponibles.\n");
            			strcat(m, "{00FF00}/clear {ffffff}- Detiene cualquier animación en curso.\n");
            			strcat(m, "{00FF00}/ck {ffffff}- Para escapar de algún intento de carkill\n");
            			strcat(m, "{00FF00}/fps {ffffff}- Se activa el modo primera persona, con el mismo se desactiva.\n");
            			strcat(m, "{00FF00}/stop {ffffff}- Detiene la música que un administrador o VIP haya puesto.\n");
            			strcat(m, "{00FF00}/pos {ffffff}- Muestra tu posición actual, coordenada x, y, z, interior, mundo virtual.\n");
            			strcat(m, "{00FF00}/facebook {ffffff}- Muestra el facebook del servidor.\n");
            			strcat(m, "{00FF00}/afk {ffffff}- Para ponerse AFK(away from keyboarad, mejor conocido como pausa en el juego).\n");
            			strcat(m, "{00FF00}/volver {ffffff}- Para regresar de AFK.\n");
            			strcat(m, "{00FF00}/recompensa {FF0000}[ID][Precio] {ffffff}- Para ponerle precio a la cabeza de alguien.\n");
            			strcat(m, "{00FF00}/recompensas {ffffff}- Muestra la lista de buscados por recompensa.\n");
            			strcat(m, "{00FF00}/verks {ffffff}- Muestra el número de kills que llevas.\n");
            			strcat(m, "{00FF00}/para {ffffff}- Te da un paracaídas\n");
            			strcat(m, "{00FF00}/camera {ffffff}- Te da una camára.\n");
            			strcat(m, "{00FF00}/sirena {ffffff}- Coloca una sirena arriba de tu vehículo.\n");
            			strcat(m, "{00FF00}/cc {FF0000}[color1] [color2] {ffffff}- Cambia el color de tu vehículo por $2500.\n");
            			strcat(m, "{00FF00}/tiempo {ffffff}- Muestra el tiempo de sanción que llevas, en caso de estar sancionado.\n");
            			strcat(m, "{00FF00}/scorelist {ffffff}- Muestra los jugadores con mayor score conectados.\n");
            			strcat(m, "{00FF00}/top {ffffff}- Muestra el TOP de historícos.\n");
            			strcat(m, "{00FF00}/vips {ffffff}- Muestra los jugadores VIP conectados.\n");
            			strcat(m, "{00FF00}/hora {ffffff}- Muestra la hora actual del servidor.\n");
            			ShowPlayerDialog(playerid, DIALOG_COMMANDS1, DIALOG_STYLE_MSGBOX, "Comandos GP", m, "continuar", "");
            			return 1;
                }
            }

		case DIALOG_COMMANDS1:
		{
			 if(response)
			 {
			 new m[540];
			 strcat(m, "{cc9900} Equipos y territorios:\n");
			 strcat(m, "{00FF00}/miequipo {ffffff}- Muestra información de detallada del equipo en el que estás.\n");
			 strcat(m, "{00FF00}/infoequipos {ffffff}- Muestra información detallada de todos los equipos.\n");
			 strcat(m, "{00FF00}/mono {ffffff}- Para cambiar de equipo\n");
			 strcat(m, "{00FF00}/zonas {ffffff}- Muestra los territorios bajo control de tu equipo.\n");
			 strcat(m, "{00FF00}/guerras {ffffff}- Muestra si hay guerras en tiempo real.\n");
			 strcat(m, "{00FF00}Símbolo '!' {ffffff}- Chat de equipo, ejemplo {FF0000}!Hola equipo. {ffffff}No es un comando.");

			 ShowPlayerDialog(playerid, DIALOG_COMMANDS2, DIALOG_STYLE_MSGBOX, "Comandos GP", m, "continuar", "");
			 }
		}

		case DIALOG_COMMANDS2:
		{
			 if(response)
			 {
			 new m[250*2];
			 strcat(m, "{cc9900} Duelos:\n");
			 strcat(m, "{00FF00}/duelo {ffffff}- Muestra un diálogo para que configures un duelo.\n");
			 strcat(m, "{00FF00}/aceptarduelo {FF0000}[ID] {ffffff}- Acepta el duelo envíado por el contrincante.\n");
			 strcat(m, "{00FF00}/dejarduelo {ffffff}- Abandona el duelo en la batalla.\n");
			 strcat(m, "{00FF00}/cancelarduelo {ffffff}- Cancela un duelo envíado.\n");
			 ShowPlayerDialog(playerid, DIALOG_COMMANDS3, DIALOG_STYLE_MSGBOX, "Comandos GP", m, "continuar", "");
			 return 1;
			 }

		}

		case DIALOG_COMMANDS3:
		{
			 if(response)
			 {
			  new m[250*3];
			  strcat(m, "{cc9900} Sistema de autos(propios):\n");
			  strcat(m, "{00FF00}/traervehiculo(traer) {ffffff}- Trae tu vehículo a tu posición\n");
			  strcat(m, "{00FF00}/abrir {ffffff}- Abre las puertas de tu vehículo.\n");
			  strcat(m, "{00FF00}/cerrar {ffffff}- cierra las puertas de tu vehículo.\n");
			  strcat(m, "{00FF00}/estacionar {ffffff}- Para estacionar tu vehículo.\n");
			  ShowPlayerDialog(playerid, DIALOG_COMMANDS4, DIALOG_STYLE_MSGBOX, "Comandos GP", m, "continuar", "");
			 return 1;
			 }

		}

            case DIALOG_COMMANDS4:
            {
                if(response)
			    {
        			new m[280*3];
        			strcat(m, "{cc9900} Minijuegos y eventos:\n");
        			strcat(m, "{00FF00}/ww2 {ffffff}- Minijuegos de armas lentas\n");
        			strcat(m, "{00FF00}/rw {ffffff}- Minijuego de armas rápidas.\n");
        			strcat(m, "{00FF00}/paintball {ffffff}- Minijuego basado en asesinatos rápidos(un tiro un kill).\n");
        			strcat(m, "{00FF00}/cbug {ffffff}- Arena para practicar c-bug.\n");
        			strcat(m, "{00FF00}/pesadas {ffffff}- Minijuego de armas de alto calibre.\n");
        			strcat(m, "{00FF00}/matadero {ffffff}- Minijuego basado sólo en sniper.\n");
        			strcat(m, "{00FF00}/minigun {ffffff}- Minijuego especial(debe ser activado por un administrador).\n");
        			strcat(m, "{00FF00}/exit {ffffff}- Comando para salir de cualquier minijuego.\n");
        			strcat(m, "{00FF00}/Evento {ffffff}- Para ir a un evento(Los eventos no siempre están activos, deben ser activados por un administrador).\n");
        			strcat(m, "{00FF00}/salir {ffffff}- Para salir de un evento.\n");
        			ShowPlayerDialog(playerid, DIALOG_COMMANDS5, DIALOG_STYLE_MSGBOX, "Comandos GP", m, "continuar", "");
        			return 1;
                }

            }

            case DIALOG_COMMANDS5:
            {
                if(response)
                {
                    new m[250*3];
        			strcat(m, "{cc9900} Otros:\n");
        			strcat(m, "{00FF00}/aerols {ffffff}- Teleport a el aereopuerto de Los Santos\n");
        			strcat(m, "{00FF00}/aerosf {ffffff}- Teleport a el aereopuerto de San fierro.\n");
        			strcat(m, "{00FF00}/aerolv {ffffff}- Teleport a el aereopuerto de Las Venturas.\n");
        			strcat(m, "{00FF00}/aeroab {ffffff}- Teleport a el aereopuerto abandonado de las Venturas.\n");
        			strcat(m, "{00FF00}/ingresar {ffffff}- Comando para ingresar a la casa guía(está con el ícono de helado en el radar).\n");
        			strcat(m, "{00FF00}/salida {ffffff}- Para salir de la casa guía.\n");

        			ShowPlayerDialog(playerid, DIALOG_COMMANDS6, DIALOG_STYLE_MSGBOX, "Comandos GP", m, "continuar", "");
        			return 1;
                }

            }
            case DIALOG_COMMANDS6:
            {
                if(response)
                {
                    new m[290*3];
        			strcat(m, "{cc9900} Reportes y administración:\n");
        			strcat(m, "{00FF00}/admins {ffffff}- Muestra la lista de administradores conectados.\n");
        			strcat(m, "{00FF00}/reportar {FF0000}[ID] [razón] {ffffff}- Comando para reportar cheaters.\n");
        			strcat(m, "{00FF00}/id {ffffff}- Muestra el ID, e información detallada de un jugador.\n");
        			strcat(m, "{00FF00}/closereport {ffffff}- Para cancelar un reporte.\n");
        			strcat(m, "{00FF00}/rchat {FF0000}[mensaje]{ffffff}- Chat privado con el administrador que atendió el reporte para dar más información.\n");
        			strcat(m, "{00FF00}/votekick {ffffff}- Comando para iniciar una votación para expulsar a un jugador mientras no hayan {00FF00}/admins{ffffff} conectados.\n");
        			strcat(m, "{00FF00}/voto {FF0000}[si/no] {ffffff}- Para votar en votekick.\n");
        			strcat(m, "{00FF00}/creditos {ffffff}- Muestra los creditos del servidor.\n");
        			ShowPlayerDialog(playerid, DIALOG_COMMANDS7, DIALOG_STYLE_MSGBOX, "Comandos GP", m, "continuar", "");
        			return 1;
                }

		    }

		    case DIALOG_COMMANDS7:
		    {
    			if(response)
    			{
    			    new m[420*3];
    		 	    strcat(m, "{cc9900}Comandos para recibir ayuda:\n");
    			    strcat(m, "{00FF00}/ayuda {ffffff}- Muestra la ayuda general.\n");
                    strcat(m, "{00FF00}/ayuda vip {ffffff}- Muestra la lista de comandos, y ayuda VIP.\n");
        			strcat(m, "{00FF00}/ayuda equipo {ffffff}- Muestra la ayuda e importancia del trabajo en equipo.\n");
        			strcat(m, "{00FF00}/ayuda clan {ffffff}- Muestra los comandos y requisitos para crear un clan.\n");
        			strcat(m, "{00FF00}/ayuda bases {ffffff}- Muestra información acerca de las bases clan.\n");
        			strcat(m, "{00FF00}/ayuda autos {ffffff}- Ayuda básica para comprar un auto propio.\n");
        			strcat(m, "{00FF00}/zonasayuda {ffffff}- Muestra ayuda para conquistar territorios.\n");
        			strcat(m, "{00FF00}/vcmds {ffffff}- Muestra la lista de comandos para jugadores VIP\n");
        			ShowPlayerDialog(playerid, DIALOG_COMMANDS8, DIALOG_STYLE_MSGBOX, "Comandos GP", m, "cerrar", "");
        			return 1;
    			}

            }
		}
    return 0;
}

CMD:sonido(playerid, params[])
{
   CheckPlayerLogin(playerid);
   LevelCheck(playerid, 10);
   new soundid, str[64];
   if(sscanf(params, "d", soundid))
	  return SendClientMessage(playerid, COLOR_RED, "Uso: /sonido [sonidoID]");

   format(str, 64, "Escuchando el sonido nativo ID:"red" %d", soundid);
   SendClientMessage(playerid, -1, str);
   PlayerPlaySound(playerid, soundid, 0.0, 0.0, 0.0);

return 1;
}
CMD:reglas(playerid, params[])
{
	new s[500*2];
	strcat(s, ""red"1. "white"Bugs permitidos: two shoot, c-bug, slide-bug Modo skinshoot.\n");
	strcat(s, ""red"2. "white"No se permite el uso de cheats que te aventajen sobre el resto.\n");
	strcat(s, ""red"3. "white"Los jugadores que falten el respeto en el chat público/privado a jugadores o adminsitradores serán sancionados.\n");
	strcat(s, ""red"4. "white"No puedes atacar a los miembros de tu banda, son tu equipo.\n");
	strcat(s, ""red"5. "white"white kill, duel farming está prohibido. Puedes perder tu cuenta.\n");
	strcat(s, ""red"6. "white"Prohibido evadir kill de manera intencionada o con comandos, spawnkill, carkill, helikill.\n");
	strcat(s, ""red"7. "white"El abuso de bugs o uso mal intencionado de los mismos, será sancionado.\n");
	strcat(s, ""orange"- "white"Las reglas pueden ser alteradas sin previo avíso, así que estén pendientes.\n");
	strcat(s, ""orange"Importante: "white"No cumplir con estas reglas te llevará a una sanción como, advertencia, expulsión y en peores casos baneo, cumplelas.\n");

	ShowPlayerDialog(playerid, DIALOG_RULES, DIALOG_STYLE_MSGBOX, "Reglas del servidor", s, "Cerrar", "");
	return 1;
}

CMD:creditos(playerid, params[])
{
  new s[300*2];
   strcat(s, ""red"Guerra de pandillas reborn © 2012 - 2019\n");
  strcat(s, ""red"Desarolladores: "white" Jefferson - pablobl[X]\n");
  strcat(s, ""red"GP Reborn por: "white" Jefferson - pablobl[X] actual\n");
  strcat(s, ""red"GP Return por: "white" César Smith - [x]sustantcs Período 2015 - 2018\n\n");
  strcat(s, ""red"Contribuciones especiales\n\n");
  strcat(s, ""red"Aportantes: "white"Saso_______[iL] - BlaZe[X] - Artema[CB] - ]iL[Bryle]\n");
  strcat(s, ""red"Música de entrada: "white"Nicolás Iguini (Facebook)\n");
  strcat(s, ""red"GP por: "white"Dark Killer Período 2011 - 2015\n");
  strcat(s, ""red"Fundación: "white"25 de diciembre del 2011 por Dark Killer\n");

  ShowPlayerDialog(playerid, DIALOG_CREDITS, DIALOG_STYLE_MSGBOX, "Sobre el servidor", s, "cerrar", "");
  return 1;
}

//alias:comandos("cmds");
CMD:comandos(playerid, params[])
{
	new m[450*2];
	strcat(m, ""VIP2_COLOR"Cuenta:\n");
	strcat(m, ""green"/register "white"- Registra una cuenta nueva en caso de que no aparezca el diálogo de registro.\n");
	strcat(m, ""green"/login "white"- En caso de que no aparezca el diálogo de ingreso, te hará loguear.\n");
	strcat(m, ""green"/stats  "white"- Muestra tus estadísticas o las de otro jugador al usar /stats [ID].\n");
	strcat(m, ""green"/cpass  "white"- Cambia la contraseña de tu cuenta.\n");
	strcat(m, ""green"/cquestion  "white"- Cambia la pregunta de seguridad de tu cuenta.\n");
	strcat(m, ""green"/nopm  "white"- Desactiva los mensajes privados.\n");
	ShowPlayerDialog(playerid, DIALOG_COMMANDS, DIALOG_STYLE_MSGBOX, "Comandos GP", m, "continuar", "cerrar");
	return 1;
}

CMD:cmds(playerid, params[])
{
	return cmd_comandos(playerid, params);
}

CMD:facebook(playerid, params[])
{
   SendClientMessage(playerid, COLOR_RED, "[GP] "white"Página oficial: "blue"www.facebook.com/GuerraDePandillasSAMP/" );
   SendClientMessage(playerid, COLOR_RED, "[GP] "white"Grupo: "blue"www.facebook.com/groups/GuerraDePandillasSAMP/");
   return 1;
}

CMD:kill(playerid, params[])
{
	LockASPKCheck(playerid);
	MinigameCheck(playerid);
	
	if(CheckPlayerJail(playerid) == 0)
	{
		new bool:count = false;
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
	
		foreach(new i : Player)
		{
			if(	i != playerid &&
				GetPlayerTeam(i) != GetPlayerTeam(playerid) &&
				IsPlayerInRangeOfPoint(i, 100.0, x, y, z))
			{	
				count = true;
			}
		}

	if(! count)
	{
		if(count) return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes suicidarte, hay enemigos cerca en el radio de 100 metros.");
		JBC_SetPlayerHealth(playerid, 0);
	}
	if(count) return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes suicidarte, hay enemigos cerca en el radio de 100 metros.");
	new 
		string[100];

	format(string, sizeof(string), "{0089FF}[INFO] %s [ID:%d] {FFFFFF}se ha suicidado. ({D80000}/Kill{FFFFFF})", pName(playerid),playerid);
	SendClientMessageToAll(-1, string);
	if(IsPlayerInAnyVehicle(playerid))
	{
	 new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		JBC_SetPlayerPos(playerid, pos[0], pos[1], pos[2] + 2.2);//eject the player!
	}
	JBC_SetPlayerHealth(playerid, 0.0);
	}
	return 1;
}


CMD:afk(playerid, params[])
{
	if(CheckPlayerJail(playerid) == 0)
	{
	CheckPlayerLogin(playerid);
	new bool:count = false;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i : Player)
	{
		if(	i != playerid && GetPlayerTeam(i) != GetPlayerTeam(playerid) && IsPlayerInRangeOfPoint(i, 15.0, x, y, z))
		{
			count = true;
		}
	}
	if(! count)
	{
	if(AFK[playerid] == 1)
	{
	SendClientMessage(playerid, COLOR_ORANGE, "[ERROR] Ya estas en Modo AFK! Usa /Volver para abandonarlo.");
	return 1;
	}
	new str[50];
	SendClientMessage(playerid, 0x009BFCFF, "[AFK] Ahora estás en Modo AFK! Usa /Volver para abandonarlo!");
	format(str, sizeof(str), "[AFK] %s [%d] ahora está AFK.", pName(playerid), playerid);
	SendClientMessageToAll(0x009BFCFF, str);
	SetPlayerVirtualWorld(playerid, 3);
	JBC_TogglePlayerControllable(playerid, 0);
	AFK[playerid] = 1;
	}
	else SendClientMessage(playerid,COLOR_RED, "[ERROR] No puedes ponerte AFK, hay enemigos cerca.");
	}
	return 1;
}

CMD:volver(playerid, params[])
{
	if(CheckPlayerJail(playerid) == 0)
	{
	CheckPlayerLogin(playerid);
	new str[53];
	if(AFK[playerid] == 0)
	{
	SendClientMessage(playerid, COLOR_RED, "[ERROR] No estas en modo AFK! Usa /AFK para iniciarlo.");
	return 1;
	}
	format(str, sizeof(str), "[AFK] %s [%d] ha vuelto del AFK.", pName(playerid), playerid);
	SendClientMessageToAll(0x009BFCFF, str);
	SetPlayerVirtualWorld(playerid, 0);
	JBC_TogglePlayerControllable(playerid, 1);
	AFK[playerid] = 0;
	}
	return 1;
}

CMD:fps(playerid, params[])
{
	if(CheckPlayerJail(playerid) == 0)
	{
		CheckPlayerLogin(playerid);
		if(pInfo[playerid][FirstPS] == 0)
		{
				FPS[playerid] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachObjectToPlayer(FPS[playerid],playerid, 0.0, 0.07, 0.7, 0.0, 0.0, 0.0);
				AttachCameraToObject(playerid, FPS[playerid]);
				SendClientMessage(playerid,-1,"{008F8F}[GP] Estas en modo primera persona!, usa /fps para dejar de usarla.");
				PlayerPlaySound(playerid,1083,0.0,0.0,0.0);
				pInfo[playerid][FirstPS] = 1;
		}
		else if(pInfo[playerid][FirstPS] == 1)
		{
				SetCameraBehindPlayer(playerid);
				DestroyObject(FPS[playerid]);
				SendClientMessage(playerid,-1,"{008F8F}[GP] Has desactivado la primera persona");
				PlayerPlaySound(playerid,1084,0.0,0.0,0.0);
				pInfo[playerid][FirstPS] = 0;
		}
		}
		return 1;
}

CMD:dar(playerid, params[])
{
   	new 
   		option[25], 
   		id, 
   		amount, 
   		Float:position[3], 
   		l[135];

   	if(sscanf(params, "s[25]dd", option, id, amount)) 
   		return SendClientMessage(playerid, COLOR_RED, "Uso: /dar [arma - id - munición] o [dinero - id - monto]");
   	if(!sscanf(params, "s[25]dd", option, id, amount))
   	{
	  if(strcmp(option, "arma", true) ==0)
	  {
		 if(id == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador no se encuentra conectado.");

		 if(id == playerid)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes darte armas a tí mismo.");

		 if(amount < 1)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar menos de de munición.");

		 if(amount > 50)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar más de 50 de munición.");

		 if(IsPlayerConnected(id))
		 {
		 GetPlayerPos(playerid, position[0], position[1], position[2]);
		 if(!IsPlayerInRangeOfPoint(id, 5.0, position[0], position[1], position[2]))
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas estar mínimo a cinco metros del jugador.");
		  }

		 if(GetPlayerWeapon(playerid) == 0)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar el puño.");

		 if(GetPlayerAmmo(playerid) < amount)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] No posees esa cantidad de munición.");

		new 
			weaponname[30];
		GetWeaponName(GetPlayerWeapon(playerid), weaponname, sizeof(weaponname));
		switch(GetPlayerWeapon(playerid))
			   {
			   		case 0..15: amount = 1;
			   }
		JBC_GivePlayerWeapon(playerid, GetPlayerWeapon(playerid), - amount);
		JBC_GivePlayerWeapon(id, GetPlayerWeapon(playerid), amount);

			   new s[128], 
			   		s2[128]
			   	;//pName(playerid),playerid, weaponname, ammo

			   format(s, sizeof(s), "[ENTREGADO] Le has dado a %s[ID:%i] un(una) %s con %i de munición.", pName(id),id, weaponname, amount);
			   format(s2, sizeof(s2), "[RECIBIDO] %s[ID:%i] te ha dado un(una) %s con %i de munición.", pName(playerid), playerid, weaponname, amount);
			   
			   SendClientMessage(playerid, COLOR_BLUE, s);
			   SendClientMessage(id, COLOR_BLUE, s2);
	}

	  if(strcmp(option, "dinero", true) == 0)
	  {
	  	if(GetPlayerScore(playerid) < 2500)
	  		return SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas 2500 de score para dar dinero.");

	  	new string[128];
	    format(string, 128, "[INFO]"white" Debes esperar "green"%d segundos "white" para dar dinero nuevamente.", TimeChocolate[playerid]);


		if(id == INVALID_PLAYER_ID)
		   return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador no se encuentra conectado.");

		if(id == playerid)
		   return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes darte dinero a tí mismo.");

        if(GivedChocolate[playerid] == true)
	  		return SendClientMessage(playerid, COLOR_RED, string);

		if(GetPlayerChocolate(playerid) < 1)
		  return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar menos de $1.");

		 if(IsPlayerConnected(id))
		 {
		 GetPlayerPos(playerid, position[0], position[1], position[2]);
		 if(!IsPlayerInRangeOfPoint(id, 5.0, position[0], position[1], position[2]))
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas estar mínimo a cinco metros del jugador.");
		 }

		if(amount > 70000)
		   return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar más de $70.000");

		new str[128], str2[128];
		format(str, sizeof(str), "[INFO]"white" le has dado $%d a %s.", amount, pName(id));
		format(str2, sizeof(str), "[INFO]"white" %s te ha dado $%d.", pName(playerid), amount);
		SendClientMessage(playerid, COLOR_GREEN, str);
		SendClientMessage(id, COLOR_GREEN, str2);
		GetPlayerChocolate(playerid);
		SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)-amount);
		GetPlayerChocolate(id);
		SetPlayerChocolate(id, GetPlayerChocolate(id)+amount);
		TimeChocolate[playerid] = 60;
		SetTimerEx("OnPlayerGiveChocolate", 1150, true, "i", playerid);
		GivedChocolate[playerid] = true;
		format(l, sizeof(l), "[DINERO] %s le ha dado $%d a %s", pName(playerid), amount, pName(id));
		SaveLogData("dar_dinero.txt", l);
		}
   	}
	return 1;
}


CMD:aerols(playerid, params[])
{
	LockASPKCheck(playerid);
	MinigameCheck(playerid);
	HealthCheck(playerid, 90);
	InVehicleCheck(playerid);
	if(CheckPlayerJail(playerid) == 0)
	{
	PlayerPlaySound(playerid, 	1149, 0.0, 0.0, 10.0);
	new string [200];
	format(string, sizeof(string), "{FFE27F}[TELE] %s se fue al Aeropuerto de Los Santos! - ({FFFFFF}/aerols{FFE27F})", pName(playerid));
	SendClientMessageToAll(-1, string);
	JBC_SetPlayerPos(playerid, 1963.07, -2177.12, 13.54);
	ResetPos(playerid);
	}
	return 1;
}
CMD:aerolv(playerid, params[])
{
	LockASPKCheck(playerid);
	MinigameCheck(playerid);
	HealthCheck(playerid, 90);
	InVehicleCheck(playerid);
	if(CheckPlayerJail(playerid) == 0)
	{
	PlayerPlaySound(playerid, 	1149, 0.0, 0.0, 10.0);
	new string [200];
	format(string, sizeof(string), "{FFE27F}[TELE] %s se fue al Aeropuerto de Las Venturas! - ({FFFFFF}/aerolv{FFE27F})", pName(playerid));
	SendClientMessageToAll(-1, string);
	JBC_SetPlayerPos(playerid,1282.6499,1267.8385,10.8203);
	ResetPos(playerid);
	}
	return 1;
}
CMD:aerosf(playerid, params[])
{
	LockASPKCheck(playerid);
	MinigameCheck(playerid);
	HealthCheck(playerid, 90);
	InVehicleCheck(playerid);

	if(CheckPlayerJail(playerid) == 0)
	{
	PlayerPlaySound(playerid, 	1149, 0.0, 0.0, 10.0);
	new string [200];
	format(string, sizeof(string), "{FFE27F}[TELE] %s se fue al Aeropuerto de San Fierro! - ({FFFFFF}/aerosf{FFE27F})", pName(playerid));
	SendClientMessageToAll(-1, string);
	JBC_SetPlayerPos(playerid,-1289.3040,-363.5973,14.1484);
	ResetPos(playerid);
	}
	return 1;
}

CMD:aeroab(playerid, params[])
{
	MinigameCheck(playerid);
	HealthCheck(playerid, 90);
	InVehicleCheck(playerid);
	new s[128];
	format(s, sizeof(s), "{FFE27F}[TELE] %s se fue al Aeropuerto abandonado! - ({FFFFFF}/aeroab{FFE27F})", pName(playerid));
	SendClientMessageToAll(-1, s);
	JBC_SetPlayerPos(playerid, 321.8069, 2518.8660, 16.8136);
	SetPlayerFacingAngle(playerid, 85.7694);
	SetCameraBehindPlayer(playerid);
	ResetPos(playerid);
	return 1;
}

CMD:aldea(playerid, params[])
{
	
	VipCheck(playerid, 2);
	MinigameCheck(playerid);
	LockASPKCheck(playerid);
	InVehicleCheck(playerid);
	if(CheckPlayerJail(playerid) == 0)
	{
	PlayerPlaySound(playerid, 	1149, 0.0, 0.0, 10.0);
	new string [200];
	format(string, sizeof(string), "{3AFFAD}[VIP] %s se fué a la {FFFFFF}Aldea Abandonada! ({D80000}/aldea{FFFFFF})", pName(playerid),playerid);
	SendClientMessageToAll(-1, string);
	JBC_SetPlayerPos(playerid, -1113.0243,-1677.0367,76.3672);
	ResetPos(playerid);
	}
	return 1;
}
CMD:chilliad(playerid, params[])
{
	
	VipCheck(playerid, 2);
	MinigameCheck(playerid);
	LockASPKCheck(playerid);
	InVehicleCheck(playerid);
	if(CheckPlayerJail(playerid) == 0)
	{
	PlayerPlaySound(playerid, 	1149, 0.0, 0.0, 10.0);
	new string [200];
	format(string, sizeof(string), "{3AFFAD}[VIP] %s se fué al Monte {FFFFFF}Chilliad! ({D80000}/Chilliad{FFFFFF})", pName(playerid),playerid);
	SendClientMessageToAll(-1, string);
	JBC_SetPlayerPos(playerid,-2328.3926,-1633.8729,483.7031);
	ResetPos(playerid);
	}
	return 1;
}
//alias:sync("clear");
CMD:sync(playerid, params[])
{
	if(IsPlayerInFirstSpawn(playerid) == 1)
	{
	
	LockASPKCheck(playerid);
	InVehicleCheck(playerid);

//	if(EnEvento[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en eventos, si quieres salir, usa, /salir.");
	if(CheckPlayerJail(playerid) == 0)
	{
	new bool:count = false;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i : Player)
	{
		if(	i != playerid &&
			GetPlayerTeam(i) != GetPlayerTeam(playerid) &&
			IsPlayerInRangeOfPoint(i, 15.0, x, y, z))
		{
			count = true;
		}
	}

	if(! count)
	{
		Sync(playerid);
		SendClientMessage(playerid, COLOR_BLUE, "[INFO] Has sido sincronizado.");
	}
	else SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes sincronizarte, hay enemigos cerca.");
	}
	}
	return 1;
}

CMD:pos(playerid, params[])
{
	if(CheckPlayerJail(playerid) == 0)
	{
	
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	new str[144];
	format(str, sizeof(str), "Tu posición | X: %f | Y: %f | Z: %f | Interior: %d | Mundo Virtual: %d", x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	SendClientMessage(playerid, COLOR_RED, str);
	}
	return 1;
}

CMD:zonasayuda(playerid, params[])
{
	new s[656];
	strcat(s, ""VIP2_COLOR"-Metódos para conquistar\n");
	strcat(s, ""red"1.- "white"El primer metódo consiste en ir con "red""#RequiredMembers""white" compañeros será necesario invadir para comenzar una guerra\n");
	strcat(s, "    deberás permenacer "red""#WarStartedTime""white" segundos con tus compañeros VIVOS dentro del territorio para ganarlo.\n");
	strcat(s, ""red"2.- "white"El segundo metódo consiste en ir a la zona solo o con amigos, podrás conquistar territorios\n");
	strcat(s, "    asesinando a los del equipo necesitarás resistir "red""#WarStartedTime""white" segundos, el equipo con más asesinatos "red"ganará"white" el territorio.\n");
	strcat(s, "    "red"-"white" Si aún te quedan dudas puedes preguntar a los "green"/admins "white"conectados.");

	ShowPlayerDialog(playerid, DIALOG_HELPGANG, DIALOG_STYLE_MSGBOX, "¿Cómo conquistar?", s, "Cerrar", "");
	return 1;
}

CMD:ck(playerid, params[])
{
	CheckPlayerLogin(playerid);
	
	
	if(IsPlayerInAnyVehicle(playerid)) 
		return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar el comando estando en un vehículo.");
	
	new Float:x, Float:y, Float:z;
	
	if(CheckPlayerJail(playerid) == 0)
	{
		if(MinigameMode[playerid]== 0)
		{
			GetPlayerPos(playerid, x, y, z);
			JBC_SetPlayerPos(playerid, x, y, z+5);
			PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
			SendClientMessage(playerid,-1, "{009BFC}[INFO]"white" Utiliza "green"/Reportar "white"para reportar el CarKill.");
			BloqueoCK[playerid] = 1;
		}
	}
	return 1;
}
	CMD:acciones1(playerid, params[])
	{
	SendClientMessage(playerid,0x009BFCFF,"==============[Lista de Animaciones Lista #1]================");
	SendClientMessage(playerid,-1,"/si,/no,/rendirse,/borracho,/mmm,/servir,/servirse");
	SendClientMessage(playerid,-1,"/bomba,/arrestar,/jaja,/sapiar,/asiento,/asiento2");
	SendClientMessage(playerid,-1,"/fumar,/sentarse,/fokear,/rapear");
	SendClientMessage(playerid,-1,"/amenazar,/agredido,/herido,/rodar,/llorar");
	SendClientMessage(playerid,0x009BFCFF,"=============[Para más /acciones2]===============");
	return 1;
	}

	CMD:acciones2(playerid, params[]) {
	SendClientMessage(playerid,0x009BFCFF,"==============[Lista de Animaciones #2]================");
	SendClientMessage(playerid,-1,"/encender,/vigilar,/recostarse,/saludo1 2 3 y 4");
	SendClientMessage(playerid,-1,"/cubrirse,/vomitar,/comer,/despedirse,/dormir");
	SendClientMessage(playerid,-1,"/palmada,/agonizar,/traficar,/beso,/crack,/detener");
	SendClientMessage(playerid,-1,"/taichi,/boxear,/bailar[1-3],/beber");
	SendClientMessage(playerid,-1,"/hablar,/sucidio,/llamar,/recoger,/sanar");
	SendClientMessage(playerid,0x009BFCFF,"==========[Para más acciones, /acciones3]============");
	return 1;
	}

	CMD:acciones3(playerid, params[]) {
	SendClientMessage(playerid,0x009BFCFF,"==============[Lista de Animaciones #3]================");
	SendClientMessage(playerid,-1,"/strip[1-20],/echarse,/asientosexi");
	SendClientMessage(playerid,-1,"/patada,/danzar[0-12], /fumar2,fumar3");
	SendClientMessage(playerid,-1,"/asustado,/taxi,/adolorido,/seacabo,/fuerza ");
	SendClientMessage(playerid,-1,"/choriso,/tullio,/mujer,/cansado,/asco,/comodo");
	SendClientMessage(playerid,-1,"/quepa,/wooo,/quepasa,/alsar,/superpatada");
	SendClientMessage(playerid,-1,"/clica, /flores,/bj1 [1-18] ,/sexo1 [1-8] /spray /grafiti");
	SendClientMessage(playerid,0x009BFCFF,"==============[Lista de Animaciones #3]================");
	return 1;
	}

CMD:para(playerid, params[])
   {
   if(!IsPlayerInRangeOfPoint(playerid, 15.0, 305.8537, 304.1868, 1003.3047) && GetPlayerInterior(playerid) != 4)
   {
	GameTextForPlayer(playerid, "~y~paracaidas ~n~~w~integrado", 2000, 3);
	JBC_GivePlayerWeapon(playerid,46,1);
	}
	return 1;
	}
CMD:camera(playerid, params[])
	{
	if(GetPlayerWeapon(playerid) == 43)
	   return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya tienes una cámara.");
	GameTextForPlayer(playerid, "~y~Camara ~n~~w~obtenida", 2000, 3);
	JBC_GivePlayerWeapon(playerid,43,20);
	return 1;
	}
CMD:sirena(playerid, params[])
{
		CheckPlayerLogin(playerid);
		if(IsPlayerInAnyVehicle(playerid))
		{
		new objectid = CreateObject(19419, 0, 0, 0, 0, 0, 0);
		AttachObjectToVehicle(objectid, GetPlayerVehicleID(playerid), 0.009999, -0.019999, 0.944999, 0.000000, 0.000000, 0.000000); //Object Model: 19419 |
		SendClientMessage(playerid, -1, "[INFO] Ahora tu vehículo tiene sirena.");
		}
		return 1;
	}

CMD:verks(playerid, params[])
{
	new m[72];
	format(m, sizeof(m), "[KillingSpree] Llevas %d asesinatos seguidos! [Tu precio: $%d] ",streak[playerid],totalReward[playerid]);
	SendClientMessage(playerid,0xFF9B00FF,m);
	return 1;
}

CMD:recompensa(playerid, params[])
{
	if(sscanf(params, "ui", params[0], params[1])) return SendClientMessage(playerid, COLOR_RED, "USO: /recompensa [jugador] [cantidad]");
	if(params[1] < 1500 || params[1] > 1000000) return SendClientMessage(playerid, COLOR_RED, "ERROR: Minimo $1.500 - Maximo: $1.000.000");
	if(params[1] > GetPlayerChocolate(playerid)) return SendClientMessage(playerid, COLOR_RED, "ERROR: No posees esa cantidad");
	if(!IsPlayerConnected(params[0])) return SendClientMessage(playerid, COLOR_RED, "ERROR: El jugador no esta conectado.");
	SetPlayerChocolate(playerid,GetPlayerChocolate(playerid)-params[1]);
	totalReward[params[0]]+=params[1];
	new m[127];

	Delete3DTextLabel(label[params[0]]);
	format(m, sizeof(m), "Recompensa: %s ha puesto $%d por el asesinato de %s. Recompensa total: $%d.",pName(playerid), params[1],pName(params[0]),totalReward[params[0]]);
	SendClientMessageToAll(0x78D1FFFF, m);
	new l[41];
	format(l, sizeof(l), "[BUSCADO] Recompensa por el: $%d", totalReward[params[0]]);
	//label[params[0]] = ""TextLabel(l,0xF50C93FF,30.0,40.0,50.0,40.0,0);
	Attach3DTextLabelToPlayer(label[params[0]], params[0], 0.0, 0.0, 0.7);
	return 1;
}

CMD:recompensas(playerid, params[])
{
	new 
		conteo,
		rec[3000],
		texto[61];
	
	strcat(rec, ""red"Jugador\t"green"Recompensa\t"VIP2_COLOR"Racha\n");
	
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		if(totalReward[i] > 1249)
		{
			conteo++;
			format(texto,sizeof(texto),"{%06x}%s [ID: %d]\t"green"$%d\t"VIP2_COLOR"%d\n",GetPlayerColor(i) >>> 8, pName(i),i,totalReward[i],streak[i]);
			strcat(rec,texto);
		}
	}
	
	if(conteo == 0) 
		return SendClientMessage(playerid, COLOR_RED, "ERROR: No hay jugadores con recompensas.");
	
	ShowPlayerDialog(playerid,0,DIALOG_STYLE_TABLIST_HEADERS," ",rec,"Cerrar","");
	return 1;
}

CMD:startcoliseo(playerid, params[]) // COLISEO ON
{
	CheckPlayerLogin(playerid);
	

	ColiseoCheckOn(playerid);

	for(new i = 0;i<MAX_PLAYERS; i++)
	{
	Coliseo[i] = 1;
	allowlogin[i] = 1;
	statuscoliseo = true;
	}
	c_started = true;
	JBC_SetPlayerPos(playerid, 1416.0387, -45.2366, 1000.9264);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 6);
	Coliseo[playerid] = 1;
	SetCameraBehindPlayer(playerid);
	JBC_SetPlayerSkin(playerid, 155);
	new string[150];
	format(string, sizeof(string), "{D62100}[COLISEO GP] %s [ID:%d]{FFFFFF} ha iniciado el COLISEO! ({D62100}/Coliseo)", pName(playerid), playerid);
	SendClientMessageToAll(-1,string);
	PlayAudioStreamForPlayer(playerid, "https://a.tumblr.com/tumblr_peav0kQvIM1szy7eio1.mp3");
	SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} Para iniciar el coliseo y cerrar la entrada al mismo usa {FFFFFF}{66FFFF}/iniciar coliseo");
	return 1;
	}

CMD:pack(playerid, params[])
{
   LevelCheck(playerid, 6);

   if(statuscoliseo == false)
	  return SendClientMessage(playerid, -1, "{CC0000}[ERROR] El evento coliseo no se encuentra activo.");

   new option[10], id, s[132], str[132];

   if(sscanf(params, "s[10]u", option, id))
	  return SendClientMessage(playerid, COLOR_RED, "Uso: /pack [rw - ww2] [playerid]");

   if(!sscanf(params, "s[10]u", option, id))
   {
	  if(strcmp(option, "ww2", true) == 0)
	  {
		 if(id == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador no se encuentra conectado.");

		 if(received[id] == true)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] Este jugador ya ha recibido un paquete de armas.");

	  JBC_GivePlayerWeapon(id, 24, 500);
	  JBC_GivePlayerWeapon(id, 25, 500);
	  JBC_GivePlayerWeapon(id, 34, 10);
	  received[id] = true;
	  isDuel[id] = true;
	  format(s, sizeof(s), "[INFO] "red"%s "white"le ha dado un paquete de lentas a "red"%s"white" para el coliseo.", pName(playerid), pName(id));
	  SendClientMessageToAll( COLOR_PINK, s);
	  format(str, sizeof(str), "[INFO] "red"%s"white" te ha dado un paquete de armas lentas para el coliseo.", pName(playerid));
	  SendClientMessage(id, COLOR_PINK, str);
	  SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} Para iniciar el duelo y activar el daño de los desafiantes usa {FFFFFF}{66FFFF}/iniciar duelo");
	  }
	  if(strcmp(option, "rw", true) == 0)
	  {
		 if(id == INVALID_PLAYER_ID)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador no se encuentra conectado.");

		 if(received[id] == true)
			return SendClientMessage(playerid, COLOR_RED, "[ERROR] Este jugador ya ha recibido un paquete de armas.");

	  JBC_GivePlayerWeapon(id, 26, 700);
	  JBC_GivePlayerWeapon(id, 28, 700);
	  received[id] = true;
	  isDuel[id] = true;
	  format(s, sizeof(s), "[INFO] "red"%s "white"le ha dado un paquete de rápidas a "red"%s"white" para el coliseo.", pName(playerid), pName(id));
	  SendClientMessageToAll( COLOR_PINK, s);
	  format(str, sizeof(str), "[INFO] "red"%s "white"te ha dado un paquete de armas rápidas para el coliseo.", pName(playerid));
	  SendClientMessage(id, COLOR_PINK, str);
	  SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} Para iniciar el duelo y activar el daño de los desafiantes usa {FFFFFF}{66FFFF}/iniciar duelo");
	  }
   }
   return 1;
}
CMD:iniciar(playerid, params[])
{
	LevelCheck(playerid, 4);

	new option[8],str[132];
	if(sscanf(params, "s[8]", option))
	   return SendClientMessage(playerid, COLOR_RED, "Uso: /iniciar [evento - coliseo - duelo]");

	if(!sscanf(params, "s[8]", option))
	{
	   if(strcmp(option, "evento", true) == 0)
	   {
	   if(OnEvento[playerid] == 0)
		 return SendClientMessage(playerid, COLOR_RED, "[ERROR] No hay ningún evento activo.");

		if(e_started == true)
		 return SendClientMessage(playerid, COLOR_RED, "[ERROR] El evento ya ha iniciado.");

		  format(str, sizeof(str), "[Evento] "blue"%s "white"ha iniciado el evento, la entrada ha sido cerrada.", pName(playerid));
		  SendClientMessageToAll(COLOR_BEIGE, str);

		  e_started = true;
		  for(new i = 0;i<MAX_PLAYERS;i++)
		  {
		  Events[i][Escondidas] = 0;
		  Events[i][AvionMuerte] = 0;
		  Events[i][Retadores] = 0;
		  Events[i][Blindado] = 0;

		  if(Events[i][Supervivencia] == 1 || Events[i][AutosChocadores] == 1)
		  {
		  Events[i][Supervivencia] = 0;
		  Events[i][AutosChocadores] = 0;
		  statuscoliseo = false;
		  JBC_TogglePlayerControllable(i, true);
		  SetPlayerTeam(i, NO_TEAM);
		  GameTextForPlayer(i, "~r~ ~h~ El evento ha comenzado", 2000, 3);
		  }

		  }

	   }
	   if(strcmp(option, "coliseo", true) == 0)
	   {
	   if(CheckPlayerAdmin(playerid) == 6)
	   {
	   if(statuscoliseo == false)
		 return SendClientMessage(playerid, COLOR_RED, "[ERROR] El evento coliseo no se encuentra activo.");
	   if(c_started == true)
		 return SendClientMessage(playerid, COLOR_RED, "[ERROR] El coliseo ya ha iniciado.");

	   format(str, sizeof(str), "[COLISEO] "red"%s [ID:%d]"white" ha iniciado el coliseo, la entrada ha sido cerrada.", pName(playerid), playerid);
	   SendClientMessageToAll(COLOR_RED, str);
	   for(new i=0;i<MAX_PLAYERS;i++)
		  {
		  allowlogin[i] = 0;
		  c_started = true;
		  }
	   }
	   }

	   if(strcmp(option, "duelo", true) == 0)
	   {
	   if(CheckPlayerAdmin(playerid) == 6)
	   {
	   if(statuscoliseo == false)
		  return SendClientMessage(playerid, COLOR_RED, "[ERROR] El evento coliseo no se encuentra activo.");

	   SendClientMessageToAll(COLOR_GREEN, "El duelo ha comenzado.");
	   for(new i =0;i<MAX_PLAYERS;i++)
		  {
		  if(isDuel[i] == true)
			{
			SetPlayerTeam(i, NO_TEAM);
			}
		  }
	   }
	   }
	}
	return 1;
}
CMD:win(playerid, params[])
{
	LevelCheck(playerid, 6);

	if(statuscoliseo == false)
	   return SendClientMessage(playerid, COLOR_RED, "[ERROR] El evento coliseo no se encuentra activo.");

	 new id, s[132], str[132];

	 if(sscanf(params, "d", id))
		return SendClientMessage(playerid, COLOR_RED, "Uso: /win [playerid]");

	 JBC_ResetPlayerWeapons(id);
	 SetPlayerTeam(id, TEAM_COLISEO);
	 SetPlayerColor(id, COLOR_GREEN);
	 format(s, sizeof(s), "[INFO]"white" Elegiste a "green"%s"white" como ganador del duelo.", pName(id));
	 SendClientMessage(playerid, COLOR_PINK, s);
	 format(str, sizeof(str), "[INFO] "green"%s"white" te ha elegido como ganador del duelo, ve a la fila, pasaste a la siguiente ronda.", pName(playerid));
	 SendClientMessage(id, COLOR_PINK, str);

   return 1;
}

CMD:lucer(playerid, params[])
{
	LevelCheck(playerid, 6);

	if(statuscoliseo == false)
	   return SendClientMessage(playerid, COLOR_RED, "[ERROR] El evento coliseo no se encuentra activo.");

	 new id, s[132], str[132];

	 if(sscanf(params, "d", id))
		return SendClientMessage(playerid, COLOR_RED, "Uso: /lucer [playerid]");

	 JBC_ResetPlayerWeapons(id);
	 SetPlayerTeam(id, TEAM_COLISEO);
	 SetPlayerColor(id, COLOR_RED);
	 format(s, sizeof(s), "[INFO]"white" Elegiste a "red"%s"white" como perdedor del duelo.", pName(id));
	 SendClientMessage(playerid, COLOR_PINK, s);
	 format(str, sizeof(str), "[INFO] "red"%s "white"te ha elegido como "red"perdedor"white" del duelo, ve a la fila de espera para continuar.", pName(playerid));
	 SendClientMessage(id, COLOR_PINK, str);

	return 1;
}

CMD:endcoliseo(playerid, params[])
{
	LevelCheck(playerid, 6);

	   ColiseoCheckOff(playerid);

	   if(Coliseo[playerid] == 1)
	   {
	   new s[140];
	   format(s, sizeof(s), "{D62100}[COLISEO GP] "orange"%s [ID:%d]"white" ha desactivado las actividades del coliseo.", pName(playerid), playerid);
	   SendClientMessageToAll(-1, s);
	   for(new i =0;i<MAX_PLAYERS;i++)
	   {
				if(GetPlayerInterior(i) == 1 && GetPlayerVirtualWorld(i) == 6)
			   {
			   Coliseo[i] = 0;
				StopAudioStreamForPlayer(i);
				MinigameMode[i] = 0;
				Coliseo[i] = 0;
				SetPlayerLastTeam(i);
				JBC_ResetPlayerWeapons(i);
				SpawnPlayer(i);
				JBC_SetPlayerArmour(i,0);
				SetPlayerTime(i, 12, 0);
				SetPlayerWeather(i, 36);
				ResetPos(i);
				statuscoliseo = false;
				}
		   }
	   }
	return 1;
}
CMD:minigame(playerid, params[])
{
	CheckPlayerLogin(playerid);
	LevelCheck(playerid, 6);
	if(MinigunGame == 0)
	{
	MinigunGame = 1;
	new string[150];
	format(string, sizeof(string), "{FF0088}[MINIJUEGO] %s [ID:%d]{FFFFFF} ha activado el Minijuego Minigun!({FF0088}/Minigun{FFFFFF})", pName(playerid), playerid);
	SendClientMessageToAll(-1,string);
	}
	else
	{
	MinigunGame = 0;
	new string[100];
	format(string, sizeof(string), "[MINIJUEGO] "red"%s [ID:%d]"white" ha desactivado el minijuego"beige" minigun.", pName(playerid), playerid);
	SendClientMessageToAll(COLOR_GRAY ,string);
	SpawnPlayer(playerid);
	for(new i = 0; i<MAX_PLAYERS; i++)
	   {
		   if(MinigameMode[i] == 1)
		   {
		   MinigameMode[i] = 0;
		   SpawnPlayer(i);
		   JBC_ResetPlayerWeapons(i);
		   SetPlayerLastTeam(playerid);
		   ResetPos(i);
		   }
	   }
	}
	return 1;
 }

CMD:minigun(playerid, params[])
{
if(MinigunGame == 1)
{
	
	InVehicleCheck(playerid);

	if(MinigameMode[playerid] != 0)
	   return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] Ya estás dentro de un Minijuego, usa /Exit para salir.");

	if(CheckPlayerJail(playerid) == 0)
	{
	MinigameMode[playerid] = 1;
	ContadorMinigun ++;
	new string [150];
	format(string, sizeof(string), "{3AFFAD}[TELE] {FF006F}%s[%i] {ffffff}ha entrado a Minigun ({FF006F}/Minigun{FFFFFF}) [%d jugadores]", pName(playerid),playerid,ContadorMinigun);
	SendClientMessageToAll(-1, string);
	SendClientMessage(playerid, -1, "{FB86BB}[MINIJUEGO] Has ingresado al Minijuego!. Usa {FFFFFF}/Exit{FB86BB} para salir cuando lo desees. ¡A matar!.");
	SpawnPlayer(playerid);
	GameTextForPlayer(playerid, " ~n~ ~n~ ~n~ ~n~ ~b~/Minigun - Desmadre.~n~~w~~h~Usa /Exit para salir", 5000, 6);
	}
	}

	else
	{
		if(IsPlayerGay[playerid] == false)
		{
		new men[128];
		format(men, sizeof(men), "[ATENCIÓN] "red"%s"white" es el más {FF00FF}gay"white" del servidor!", pName(playerid));
		SendClientMessageToAll(COLOR_PINK, men);
		JBC_GivePlayerWeapon(playerid, 10, 1);
		IsPlayerGay[playerid] = true;
    		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    			return ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.0,1,1,1,1,500, 1);
		}
	}
	return 1;
	}

CMD:paintball(playerid, params[])
{
	
	LockASPKCheck(playerid);
	InVehicleCheck(playerid);
	if(MinigameMode[playerid] != 0) return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] Ya estás dentro de un Minijuego, usa /Exit para salir.");
	InVehicleCheck(playerid);
	if(GetPlayerVirtualWorld(playerid) == 0)
	{
	MinigameMode[playerid] = 2;
	ContadorPaintball ++;
	new string [150];
	format(string, sizeof(string), "{00FFFF}[MINIJUEGO] %s[%i] ha entrado a >> Paintball << ({ffffff}/Paintball{00FFFF}) [%d jugadores]", pName(playerid),playerid,ContadorPaintball);
		SendClientMessage(playerid, -1, "{FB86BB}[MINIJUEGO] Has ingresado al Minijuego!. Usa {FFFFFF}/Exit{FB86BB} para salir cuando lo desees. ¡A matar!.");
	SendClientMessageToAll(-1, string);
	SpawnPlayer(playerid);
	PaintBall( playerid );
	GameTextForPlayer(playerid, " ~n~ ~n~ ~n~ ~n~ ~r~/Paintball - 1 Tiro 1 kill.~n~~w~~h~Usa /Exit para salir", 5000, 6);
	}
	return 1;
}

CMD:rw(playerid, params[])
{
	
	LockASPKCheck(playerid);
	HealthCheck(playerid, 70);
	
	if(MinigameMode[playerid] != 0) 
		return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] Ya estás dentro de un Minijuego, usa /Exit para salir.");
	
	if(BloqueoEvento[playerid] == 1) 
		return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar comandos en evento, si quieres salir, usa /salir");
	
	if(CheckPlayerJail(playerid) == 0)
	{
		MinigameMode[playerid] = 4;
		ContadorRW ++;
		
		new 
			string [150];
		
		format(string, sizeof(string), "{3AFFAD}[DM] %s[%i] ha entrado a > Rápidas! < -({FFFFFF}/RW{3AFFAD}) [%d jugadores]", pName(playerid),playerid,ContadorRW);
		SendClientMessageToAll(-1, string);
		SendClientMessage(playerid, -1, "{FB86BB}[MINIJUEGO] Has ingresado al Minijuego!. Usa {FFFFFF}/Exit{FB86BB} para salir cuando lo desees. ¡A matar!.");
		
		SpawnPlayer(playerid);
		GameTextForPlayer(playerid, " ~n~ ~n~ ~n~ ~n~ ~g~/RW - Rapidas.~n~~w~~h~Usa /Exit para salir", 5000, 6);
	}
	return 1;
}

CMD:ww2(playerid, params[])
{
	
	LockASPKCheck(playerid);
	HealthCheck(playerid, 70);
	if(MinigameMode[playerid] != 0) 
		return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] Ya estás dentro de un Minijuego, usa /Exit para salir.");
	InVehicleCheck(playerid);
	
	if(BloqueoEvento[playerid] == 1) 
		return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar comandos en evento, si quieres salir, usa /salir");
	
	if(CheckPlayerJail(playerid) == 0)
	{
		MinigameMode[playerid] = 3;
		ContadorWW2 ++;
		new 
			string [150];
		
		format(string, sizeof(string), "{3AFFAD}[DM] %s[%i] ha entrado a > Lentas < - ({FFFFFF}/WW2{3AFFAD}) [%d jugadores]", pName(playerid),playerid,ContadorWW2);
		SendClientMessageToAll(-1, string);
		SendClientMessage(playerid, -1, "{FB86BB}[MINIJUEGO] Has ingresado al Minijuego!. Usa {FFFFFF}/Exit{FB86BB} para salir cuando lo desees. ¡A matar!.");
		SpawnPlayer(playerid);
		GameTextForPlayer(playerid, " ~n~ ~n~ ~n~ ~n~ ~y~/WW2 - Lentas.~n~~w~~h~Usa /Exit para salir", 5000, 6);
	}
	return 1;
}

CMD:pesadas(playerid, params[])
{
	
	LockASPKCheck(playerid);
	HealthCheck(playerid, 70);
	if(MinigameMode[playerid] != 0) return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] Ya estás dentro de un Minijuego, usa /Exit para salir.");
	if(BloqueoEvento[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar comandos en evento, si quieres salir, usa /salir");
	InVehicleCheck(playerid);
	if(CheckPlayerJail(playerid) == 0)
	{
	MinigameMode[playerid] = 5;
	ContadorPesadas ++;
	new string [150];
	format(string, sizeof(string), "{3AFFAD}[DM] %s[%i] ha entrado a > Pesadas < - ({ffffff}/Pesadas{3AFFAD}) [%d jugadores]", pName(playerid),playerid,ContadorPesadas);
	SendClientMessageToAll(-1, string);
	SendClientMessage(playerid, -1, "{FB86BB}[MINIJUEGO] Has ingresado al Minijuego!. Usa {FFFFFF}/Exit{FB86BB} para salir cuando lo desees. ¡A matar!.");
	SpawnPlayer(playerid);
	}
	return 1;
}


CMD:matadero(playerid, params[])
{
	
	LockASPKCheck(playerid);
	HealthCheck(playerid, 70);
	if(MinigameMode[playerid] != 0) return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] Ya estás dentro de un Minijuego, usa /Exit para salir.");
	if(BloqueoEvento[playerid] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar comandos en evento, si quieres salir, usa /salir");
	InVehicleCheck(playerid);
	if(CheckPlayerJail(playerid) == 0)
	{
	MinigameMode[playerid] = 6;
	ContadorMatadero ++;
	new string [150];
	format(string, sizeof(string), "{F14B47}[DM] %s[%i] ha entrado a > El Matadero < - ({FFFFFF}/Matadero{F14B47}) [%d jugadores]", pName(playerid),playerid,ContadorMatadero);
	SendClientMessageToAll(-1, string);
	SendClientMessage(playerid, -1, "{F14B47}[MINIJUEGO] Has ingresado al Minijuego!. Usa {FFFFFF}/Exit{F14B47} para salir cuando lo desees. ¡A matar!.");
	SpawnPlayer(playerid);
	}
	return 1;
}

CMD:coliseo(playerid, params[])
if(Coliseo[playerid] == 1)
{
	
	LockASPKCheck(playerid);
	
	if(MinigameMode[playerid] == 7)
	   return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya estás en el coliseo");
	
	if(allowlogin[playerid] == 0)
	   return SendClientMessage(playerid, COLOR_RED, "[ERROR]El ingreso al coliseo ya ha sido cerrado.");
	
	InVehicleCheck(playerid);
	HealthCheck(playerid, 70);
	
	if(CheckPlayerJail(playerid) == 0)
	{
		MinigameMode[playerid] = 7;
		SpawnPlayer(playerid);
		ContadorColiseo ++;
		
		new 
			string [150];
		
		format(string, sizeof(string), "{D62100}[COLISEO GP] {FFB400}%s[%i] {ffffff}ha entrado al COLISEO ({D62100}/coliseo{D62100}) [%d GLADIA{ffffff}DORES!]", pName(playerid),playerid,ContadorColiseo);
		SendClientMessageToAll(-1, string);
		SendClientMessage(playerid, -1, "{D62100}[COLISEO GP]{FFFFFF} Ha ingresado al COLISEO! Usa {D62100}/coliseo{FFFFFF} para unirte!");
		GameTextForPlayer(playerid, " ~n~ ~n~ ~n~ ~n~ ~r~/COLISEO - Zona de Gladiadores!.~n~~w~~y~Usa /Exit para salir", 5000, 6);
	}
	return 1;
}
 else
 {
	 SendClientMessage(playerid, -1, "{D62100}[COLISEO]{FFFFFF} El coliseo no se encuentra activado por el momento.");
		return 1;
		}

CMD:exit(playerid, params[])
{
	

	new Float:hp;

	GetPlayerHealth(playerid, hp);
	if(hp <= 14)
	   return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] No puedes salir teniendo 14 de vida o menos, espera que te maten para tener la vida completa.");

	switch(MinigameMode[playerid])
	{
		case 0: return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] No estas dentro de un minijuego!");
		case 1: ContadorMinigun --;
		case 2: ContadorPaintball --;
		case 3: ContadorWW2 --;
		case 4: ContadorRW--;
		case 5: ContadorPesadas --;
		case 6: ContadorColiseo --;
	}

	MinigameMode[playerid] = 0;
	
	SendClientMessage(playerid, COLOR_RED, "[INFO]"white" Has salido del Minijuego!");
	SetPlayerLastTeam(playerid);
	JBC_ResetPlayerWeapons(playerid);
	
	SpawnPlayer(playerid);
	ResetPos(playerid);
	JBC_SetPlayerArmour(playerid,0);
	JBC_SetPlayerHealth(playerid, 100.0);
	received[playerid] = false;
	return 1;
}

CMD:refuerzos(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        new s[64];
        format(s, sizeof(s), "|- %s Es noob y necesita refuerzos! -|", pName(playerid));
        SendClientMessageToAll(0xFFFF00AA, s);
        ApplyAnimation(playerid, "PED", "WOMAN_walkpro",4.0, 1, 1, 1, 1, 500, 1);
    }
    return 1;
}

CMD:mear(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        JBC_SetPlayerSpecialAction(playerid, 68);
    }
    return 1;
}

CMD:rendirse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        JBC_SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
    }
    return 1;
}

CMD:bj1(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_W", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}


CMD:bj2(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_P", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj3(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj4(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj5(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_END_W", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj6(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_END_P", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj7(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_W", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj8(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_P", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj9(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj10(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj11(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_W", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj12(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_P", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj13(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_START_W", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj14(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
    ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_START_P", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj15(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_LOOP_W", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj16(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_LOOP_P", 4.0, 1, 1, 1, 0, 0, 1);
    }
return 1;
}

CMD:bj17(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_END_W", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:bj18(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
    ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_END_P", 4.0, 1, 1, 1, 0, 0, 1);
    }
    return 1;
}

CMD:rollfall(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","BIKE_fallR",4.0,0,1,1,1,0);
    }
    return 1;
}

CMD:borracho(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0, 1, 1, 1, 1, 500);
    }
	return 1;
}

CMD:bomba(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 1, 1, 0,0);
    }
    return 1;
}

CMD:arrestar(playerid, params[])
{
        if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation( playerid,"PED", "ARRESTGUN", 4.0, 0, 1, 1, 1,500);
    }
    return 1;
}


CMD:reir(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0,0);
    }
    return 1;
}

CMD:sapiar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","roadcross_female",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:amenazar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
    ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 1,500);
    }
    return 1;
}

CMD:paja(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 0, 0, 1, 0);
    }
    return 1;
}

CMD:irsecortao(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:agredido(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "POLICE", "crm_drgbst_01", 4.0, 0, 0, 0, 1, 0);
    }
    return 1;
}

CMD:herido(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
{
    ApplyAnimation(playerid, "SWEET", "LaFin_Sweet", 4.0, 0, 1, 1, 1, 0);
}
    return 1;
}

CMD:encender(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.000000, 0, 0, 1, 1, 0);
    }
    return 1;
}

CMD:inhalar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SMOKING", "M_smk_drag", 4.000000, 1, 0, 0, 0, -1);
    }
    return 1;
}

CMD:vigilar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 1, 1, 1, 0, 4000);
    }
    return 1;
}

CMD:recostarse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"SUNBATHE", "Lay_Bac_in", 4.0, 0, 0, 0, 1, 0);
    }
    return 1;
}

CMD:pararse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"SUNBATHE", "Lay_Bac_out", 4.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:cubrirse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "ped", "cower", 4.0, 1, 0, 0, 0, 0);
    }
    return 1;
}

CMD:vomitar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:comer(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.00, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:chao(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "KISSING", "BD_GF_Wave", 3.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:palmada(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:agonizar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 0, 0, 1, 0);
    }
    return 1;
}

CMD:levantarse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "ped", "getup_front", 4.000000, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:traficar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:beso(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:crack(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 1, 0);
    }
    return 1;
}

CMD:flores(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"FLOWERS","FLOWER_HIT",4.0, 0, 0, 0, 0, -1);
        JBC_GivePlayerWeapon(playerid,14,1);
    }
    return 1;
}

CMD:clica(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GANGS","DRUGS_BUY",4.0, 0, 0, 0, 0, -1);
    }
    return 1;
}

CMD:grafiti(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GRAFFITI","GRAFFITI_CHKOUT",4.0, 0, 0, 0, 0, -1);
    }
    return 1;
}

CMD:spray(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"SPRAYCAN","SPRAYCAN_FIRE",4.0, 0, 0, 0, 0, -1);
    }
    return 1;
}

CMD:shop(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"SHOP","SHP_DUCK_AIM",4.0, 0, 0, 0, 0, -1);
    }
    return 1;
}




CMD:sentarse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SUNBATHE", "ParkSit_M_in", 4.000000, 0, 1, 1, 1, 0);
    }
    return 1;
}


CMD:fokear(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation( playerid,"ped", "fucku", 4.0, 0, 1, 1, 1, 1 );
    }
    return 1;
}

CMD:positivo(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "GANGS", "Invite_Yes", 4.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:negativo(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "GANGS", "Invite_No", 4.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

CMD:llamar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "ped", "phone_in", 4.000000, 0, 0, 0, 1, 4000);
        JBC_SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
    }
    return 1;
}

CMD:colgar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "ped", "phone_out", 4.000000, 0, 1, 1, 0, 0);
    }
    return 1;
}


CMD:taichi(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "PARK", "Tai_Chi_Loop",  4.1,7,5,1,1,1 ,1);
    }
    return 1;
}

CMD:beber(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000);
    }
    return 1;
}

CMD:boxear(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "GYMNASIUM", "gym_shadowbox",  4.1, 7, 5, 1, 1, 1, 1);
    }
    return 1;
}

CMD:pelea(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "ped", "FIGHTIDLE", 4.000000, 0, 1, 1, 1, 1);
    }
    return 1;
}

CMD:recoger(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.000000, 0, 1, 1, 1, 1);
    }
    return 1;
}

CMD:botear(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BSKTBALL", "BBALL_walk", 4.000000, 1, 1, 1, 1, 500);
    }
    return 1;
}

CMD:clavarse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BSKTBALL", "BBALL_def_jump_shot", 4.0, 0, 1, 1, 1, 500);
    }
    return 1;
}

CMD:lanzar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "BSKTBALL", "BBALL_Jump_Shot", 4.0, 0, 1, 1, 1, 500);
    }
    return 1;
}


CMD:asiento(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "ped", "SEAT_down", 4.000000, 0, 0, 0, 1, 0);
    }
    return 1;
}

CMD:depie(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "ped", "SEAT_up", 4.000000, 0, 0, 1, 0, 0);
    }
    return 1;
}

CMD:servirse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"BAR","Barcustom_get",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:servir(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"BAR","Barserve_give",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:asiento2(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"Attractors","Stepsit_in",4.1,0,0,0,1,0);
    }
    return 1;
}

CMD:depie2(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"Attractors","Stepsit_out",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:pensar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"COP_AMBIENT","Coplook_think",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:rodar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"MD_CHASE","MD_HANG_Lnd_Roll",4.1,0,1,1,1,0);
    }
    return 1;
}

CMD:saludo1(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GANGS","hndshkaa",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:saludo2(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GANGS","hndshkba",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:saludo3(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GANGS","hndshkca",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:saludo4(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GANGS","hndshkfa_swt",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:sanar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:llorar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:dormir(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"INT_HOUSE","BED_In_R",4.1,0,0,0,1,0);
    }
return 1;
}

CMD:detener(playerid, params[]) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"POLICE","CopTraf_Stop",4.1,0,0,0,0,0);
    }
    return 1;
}

CMD:rapear(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"RAPPING","RAP_B_Loop",4.0,1,0,0,0,8000);
    }
    return 1;
}


CMD:strip(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        SendClientMessage(playerid, 0xAA3333AA, "/strip[1-20]");
    }
    return 1;
}

CMD:strip1(playerid, params[]) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"CAR","flag_drop",4.1,0,1,1,1,1 ,1);
    }
    return 1;
}

CMD:strip2(playerid, params[]) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,7,5,1,1,1 ,1);
    }
    return 1;
}

CMD:strip3(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","PUN_HOLLER",4.1,7,5,1,1,1 ,1);
    }
    return 1;
}

CMD:strip4(playerid, params[]) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","PUN_LOOP",4.1,7,5,1,1,1 ,1);
    }
    return 1;
}

CMD:strip5(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","strip_A",4.1,7,5,1,1,1 ,1);
    }
    return 1;
}

CMD:strip6(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","strip_B",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip7(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","strip_C",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip8(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","strip_D",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip9(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","strip_E",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip10(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","strip_F",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip11(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","strip_G",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip12(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","STR_B2A",4.1,0,1,1,1,1);
    }
    return 1;
}

CMD:strip13(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","strip_E",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip14(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","STR_B2C",4.000000, 0, 1, 1, 1, 0);
    }
    return 1;
}

CMD:strip15(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","STR_C1",4.000000, 0, 1, 1, 1, 0);
    }
    return 1;
}

CMD:strip16(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","STR_C2",4.000000, 0, 1, 1, 1, 0);
    }
    return 1;
}

CMD:strip17(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","STR_C2B",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip18(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","STR_Loop_A",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip19(playerid, params[]) {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","STR_Loop_C",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:strip20(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"STRIP","STR_Loop_B",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:echarse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"SUNBATHE","SitnWait_in_W",4.000000, 0, 0, 0, 1, 0);
    }
    return 1;
}

CMD:asientosexi(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"SUNBATHE","ParkSit_W_idleA",4.000000, 0, 1, 1, 1, 0);
    }
    return 1;
}

CMD:patada(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"FIGHT_C","FightC_2",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        SendClientMessage(playerid, 0xAA3333AA, "/danzar[0-12]");
    }
    return 1;
}

CMD:danzar0(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","bd_clap",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar1(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","bd_clap1",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar2(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","dance_loop",4.1,7,5,1,1,1);
    }
    return 1;
}



CMD:danzar3(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","DAN_Down_A",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar4(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","DAN_Left_A",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar5(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","DAN_Loop_A",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar6(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","DAN_Right_A",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:danzar7(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","DAN_Up_A",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar8(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","dnce_M_a",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar9(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","dnce_M_b",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar10(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","dnce_M_c",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:danzar11(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","dnce_M_d",4.1,7,5,1,1,1);
    }
return 1;
}


CMD:danzar12(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"DANCING","dnce_M_e",4.1,7,5,1,1,1);
    }
    return 1;
}


CMD:fumar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"SMOKING","F_smklean_loop", 4.0, 1, 0, 0, 0, 0);
    }
    return 1;
}

CMD:asustado(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","handscower",4.1,0,1,1,1,1);
    }
    return 1;
}


CMD:heytaxi(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","IDLE_taxi",4.1,0,1,1,1,1);
    }
    return 1;
}


CMD:adolorido(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","KO_shot_stom",4.1,0,1,1,1,1);
    }
    return 1;
}

CMD:seacabo(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","Shove_Partial",4.1,0,1,1,1,1);
    }
    return 1;
}


CMD:fuerza(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"benchpress","gym_bp_celebrate",4.1,0,1,1,1,1);
    }
    return 1;
}

CMD:choriso(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","WALK_gang1",4.0,1,1,1,1,500);
    }
    return 1;
}



CMD:tullio(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","WALK_old",4.0,1,1,1,1,500);
    }
    return 1;
}

CMD:mujer(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.0,1,1,1,1,500);
    }
    return 1;
}

CMD:quepa(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GANGS","hndshkea",4.1,0,1,1,1,1);
    }
    return 1;

}


CMD:asombro(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"ON_LOOKERS","shout_02",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:molesto(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GHANDS","gsign1LH",4.1,0,1,1,1,1);
    }
    return 1;
}

CMD:alsar(playerid, params[])
    {
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"GHANDS","gsign2LH",4.1,0,1,1,1,1);
    }
    return 1;

}

CMD:cansado(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","WOMAN_runfatold",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:superpatada(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"FIGHT_C","FightC_3",4.1,0,1,1,1,1);
    }
    return 1;
}

CMD:comodo(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"INT_HOUSE","LOU_In",4.1,0,1,1,1,1);
    }
    return 1;
}



CMD:hablar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"PED","IDLE_chat",4.1,7,5,1,1,1);
    }
    return 1;
}

CMD:sexo1(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid,"SNM","SPANKING_IDLEW",4.0, 0, 1, 1, 1, 1);
    }
    return 1;
}

CMD:sexo2(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SNM","SPANKING_IDLEP", 4.0, 1, 1, 1, 1, 1);
    }
    return 1;
}

CMD:sexo3(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SNM","SPANKINGP", 4.0, 1, 1, 1, 1, 1);
    }
    return 1;
}

CMD:sexo4(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SNM","SPANKEDW", 4.0, 1, 1, 1, 1, 1);
    }
    return 1;
}

CMD:sexo5(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SNM","SPANKEDP", 4.0, 1, 1, 1, 1, 1);
    }
    return 1;
}

CMD:sexo6(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SNM","SPANKING_ENDW", 4.0, 1, 1, 1, 1, 1);
    }
    return 1;
}

CMD:sexo7(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        ApplyAnimation(playerid, "SNM","SPANKING_ENDP", 4.0, 1, 1, 1, 1, 1);
    }
    return 1;
}

JB_PUBLIC PaintBall(playerid)
{
	if(MinigameMode[playerid]==2)
	{
		JBC_SetPlayerHealth(playerid, 15);
	  //  JBC_SetPlayerArmour(playerid, 0);
		JBC_ResetPlayerWeapons(playerid);
		new randw=random(5);
		switch(randw)
		{
			case 0: JBC_GivePlayerWeapon(playerid, 24, 40);
			case 1: JBC_GivePlayerWeapon(playerid, 25, 50);
			case 2: JBC_GivePlayerWeapon(playerid, 29, 100);
			case 3: JBC_GivePlayerWeapon(playerid, 34, 30);
			case 4: JBC_GivePlayerWeapon(playerid, 23, 100);
		}
	}
	return 1;

}

/*JB_PUBLIC OnAntiSpawnKillExpire(playerid, Float:health, Float:armour)
{
	JBC_SetPlayerHealth(playerid, health);
	//JBC_SetPlayerArmour(playerid, armour);
	gAntiSpawnKillTimer[playerid] = -1;
	JBC_SetPlayerHealth(playerid,100);
	SendClientMessage(playerid, COLOR_GREEN, "[INFO] Protección finalizada");
	PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
	Bloqueo_ASPK[playerid] = 0;
	KillTimer(gAntiSpawnKillTimer[playerid]);
	return 1;
}*

EnableAntiSpawnKill(playerid, seconds, Float:Health, Float:Armour = 0.00)
{
	if (AntiSpawnKill[playerid])
		return 1;

	AntiSpawnKill[playerid] = true;

	JBC_SetPlayerHealth(playerid, HP_ASPK);

	SetTimerEx("OnPlayerAntiSpawnKill", (seconds * 1000), false, "iff", playerid, Health, Armour);
	return 1;
}

JB_PUBLIC OnPlayerAntiSpawnKill(playerid, Float:Health, Float:Armour)
{
	if (!AntiSpawnKill[playerid]) return 1;

	AntiSpawnKill[playerid] = false;
	SendClientMessage(playerid, COLOR_GREEN, "[INFO] Protección finalizada.");
	Bloqueo_ASPK[playerid] = 0;
	SetPlayerHealth(playerid, Health);
	return 1;
}*/


/*#if RandomMessage == true
JB_PUBLIC OnRandomMessageChange()
{
	for(new i=0; i<MAX_PLAYERS;i++)
	{
	if(LoginSucessfull[i] == false || GetPlayerVirtualWorld(i) != 0) return 0;

	new rand = random(sizeof(gRandomMessage));
	SendClientMessageToAll(COLOR_PINK, gRandomMessage[rand]);
	return 1;
	}
	return 1;
}
#endif*/
//random messages!

JB_PUBLIC OnRandomMessageChange()
{
	for(new i=0; i<MAX_PLAYERS;i++)
	{
	   if(GetPlayerVirtualWorld(i) == 0)
	   {
		 if(LoginSucessfull[i] == true)
		 {
		 new rand = random(sizeof(gRandomMessage));
		 SendClientMessageToAll(COLOR_PINK, gRandomMessage[rand]);
		 return 1;
		 }
	   }
	}
	return 1;
}

JB_PUBLIC event_check(playerid)
{
   return EnEvento[playerid];
}

JB_PUBLIC OnPlayerGiveChocolate(playerid)
{
	TimeChocolate[playerid] --;
	if(TimeChocolate[playerid] == 0)
	{
	TimeChocolate[playerid] = 60;
    GivedChocolate[playerid] = false;
	}
}


JB_PUBLIC check_minigame(playerid)
{
	return MinigameMode[playerid];
}

JB_Function:DiscountChocolate(playerid, money, discount)
{
	new 
		discounted = money*discount/100,
		s[128];
	
    GetPlayerChocolate(playerid);
    SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+discounted);
	
	format(s, sizeof(s), "[VIP] {FFFFFF}Recibiste una remuneración de {01DF01}$%d{FFFFFF} por ser VIP "orange"%d.", discounted, CheckVip(playerid));
    SendClientMessage(playerid, COLOR_GOLD, s);
    PlayerPlaySound(playerid,1052,0,0,0);
}

JB_Function:Sync(playerid)
{
	new world = GetPlayerVirtualWorld(playerid);//store player virtual world in var
	new interior = GetPlayerInterior(playerid);//store player interior in var

	JBC_TogglePlayerControllable(playerid, false);//freeze player
	SetPlayerVirtualWorld(playerid, world + 1);//changing the world id
	SetPlayerInterior(playerid, interior + 1);//changeing the interior (+1)

	SetPlayerVirtualWorld(playerid, world);//reset to default world
	SetPlayerInterior(playerid, interior);//reset to default interior
	JBC_TogglePlayerControllable(playerid, true);//unfreeze player
	ClearAnimations(playerid);//clear anims
	return true;//sucess
}

CMD:ctest(playerid, params[])
{
    LevelCheck(playerid, 10);
    //JBC_SetPlayerPos(playerid, 1057.7386,-1053.3350,34.0716);
    SetPlayerCameraPos(playerid, 1057.7386,-1053.3350,34.0716);
    SetPlayerCameraLookAt(playerid, 1062.9983,-1053.4705,34.0716);
    return 1;
}

CMD:dbc(playerid, params[])
{
    LevelCheck(playerid, 10);
    JBC_TogglePlayerSpectating(playerid, false);
    return 1;
}

//------------------------------------------------------------------
//                                                                 |
//                                                                 |
//              Sistema de eventos fase beta by: Jefferson         |
//                                                                 |
//------------------------------------------------------------------

CMD:eventos(playerid, params[])
{
	CheckPlayerLogin(playerid);
	LevelCheck(playerid, 4);
	
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	if(CheckRace(i) == 1)
	   return SendClientMessage(playerid, COLOR_RED, "[ERROR] Hay una carrera en curso, espera que termine para poder iniciar un evento.");
	}

	if(OnEvento[playerid] == 1)
	   return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya está un evento activo, espera que termine.");

			ShowPlayerDialog(playerid, DIALOG_EVENTLIST, DIALOG_STYLE_LIST, "Lista de eventos", "Escondidas\nAvión de la muerte\nSupervivencia\nAutos chocadores\nRetadores(sin terminar)\nBlindado", "continuar", "cerrar");
//==================Dialogos para que el administrador active/configure el evento=================

  return 1;
}

//'''''''''''''''''''''''''''''''''''''''Comando para que el usuario puedar ir al evento'''''''''''''''''''''''''''''''''''
CMD:evento(playerid, params[])
{
	if(CheckPlayerJail(playerid) == 0)
	{
	
	OnEventCheck(playerid);
	MinigameCheck(playerid);
	InVehicleCheck(playerid);
	HealthCheck(playerid, 80);
	EventCheck(playerid);
	if(e_started == true)
	   return SendClientMessage(playerid, COLOR_RED, "[ERROR] La entrada ha sido cerrada.");
//===================================evento escondidas=====================================================
	if(Events[playerid][Escondidas] ==1)
	{
	EnEvento[playerid] = 1;
	OnEvento[playerid] =1;
	IniciadoEvento[playerid] = 1;
	BloqueoEvento[playerid] =1;
	AntiSpawnKill[playerid] = false;

	new 
		a[135],
		Float:posicion_a[12][15] = {
		{364.7952, 174.9642, 1008.3828},//Posición número: 1
		{367.0638, 175.1331, 1008.3828},//Posición número: 2
		{369.3327, 175.2083, 1008.3828},//Posición número: 3
		{371.7552, 175.1596, 1008.3828},//Posición número: 4
		{373.9750, 174.8047, 1008.3828},//Posición número: 5
		{376.4291, 175.0685, 1008.3828},//Posición número: 6
		{364.5638, 172.5908, 1008.3828},//Posición número: 7
		{366.8446, 172.4050, 1008.3893},//Posición número: 8
		{369.0153, 172.5821, 1008.3828},//Posición número: 9
		{372.1352, 172.4666, 1008.3828},//Posición número: 10
		{373.8109, 172.8490, 1008.3828},//Posición número: 11
		{376.4474, 172.5697, 1008.3828} //Posición número: 12
		};

		   if(pos_a > 10)
			 return SendClientMessage(playerid, -1, "[INFO] El evento ha llegado al límite, máximo 10 personas");
			 ++pos_a;

	JBC_SetPlayerPos(playerid, posicion_a[pos_a][0], posicion_a[pos_a][1], posicion_a[pos_a][2]);
	SetPlayerInterior(playerid, 3);
	SetPlayerVirtualWorld(playerid, 2);
	SetPlayerFacingAngle(playerid, 89.2774);
	SetCameraBehindPlayer(playerid);
	SetPlayerColor(playerid, COLOR_HIDE);

	JBC_ResetPlayerWeapons(playerid);
	JBC_SetPlayerHealth(playerid, 100);
	SetPlayerTeam(playerid, TEAM_EVENTO);

	format(a, sizeof(a), "[Evento] {33FFCC}%s{33FFCC} {FFFFFF}ha ingresado al evento escondidas{FFFFFF} {66FFFF}/evento", pName(playerid));

	SendClientMessageToAll(COLOR_BEIGE, a);
	SendClientMessage(playerid, COLOR_GOLD, "[Escondidas] {FFFFFF}Has ingresado al evento escondidas.");
	SendClientMessage(playerid, COLOR_GOLD, "[INFO] {FFFFFF}El evento consiste en esconderse y ser el último en ser encontrado.");
	SendClientMessage(playerid, COLOR_GOLD, "[Reglas] {FFFFFF}No se permiten animaciones de ningún tipo.");
}
//================================================Evento avión de la muerte=======================================================
	  if(Events[playerid][AvionMuerte] ==1)
		{
		EnEvento[playerid]=1;
		OnEvento[playerid] =1;
		IniciadoEvento[playerid] = 1;
		BloqueoEvento[playerid] =1;

		new b[135];
		new Float:posicion_b[12][15] = {
		   {1965.2972, -2495.4490, 13.5391},
		   {1964.8275, -2491.2920, 13.5391},
		   {1966.0779, -2496.0698, 13.5391},
		   {1965.4685, -2491.4185, 13.5391},
		   {1968.9202, -2495.7256, 13.5391},
		   {1968.3660, -2490.6604, 13.5391},
		   {1970.4774, -2495.8088, 13.5391},
		   {1970.4475, -2490.9421, 13.5391},
		   {1972.8247, -2494.9685, 13.5391},
		   {1971.7656, -2491.1052, 13.5391},
		   {1974.5737, -2495.1587, 13.5391},
		   {1974.0479, -2491.3918, 13.5391}
		   };

		   if(pos_b > 10)
			  return SendClientMessage(playerid, -1, "[INFO] El evento ha llegado al límite, máximo 10 personas");
					 ++pos_b;

	JBC_SetPlayerPos(playerid, posicion_b[pos_b][0], posicion_b[pos_b][1], posicion_b[pos_b][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 2);
	SetPlayerFacingAngle(playerid, 91.3811);
	SetCameraBehindPlayer(playerid);

	JBC_ResetPlayerWeapons(playerid);
	JBC_SetPlayerHealth(playerid, 100);
	SetPlayerTime(playerid, 20, 0);
	SetPlayerWeather(playerid, 10);
	SetPlayerTeam(playerid, TEAM_EVENTO);

	format(b, sizeof(b), "[Evento] {33FFCC}%s{33FFCC} {FFFFFF}ha ingresado al evento avión de la muerte{FFFFFF} {66FFFF}/evento", pName(playerid));

	SendClientMessageToAll(COLOR_BEIGE, b);
	SendClientMessage(playerid, COLOR_GOLD, "[Avión de la muerte]: {FFFFFF}Has ingresado al evento avión de la muerte.");
	SendClientMessage(playerid, COLOR_GOLD, "[INFO evento] {FFFFFF}El evento consiste en mantenerse en pie hasta las últimas estacias haciendo uso de acciones");
	SendClientMessage(playerid, COLOR_GOLD, "[INFO evento] {FFFFFF}Utiliza /acciones1 /acciones2 /acciones3");
	SendClientMessage(playerid, COLOR_GOLD, "[Reglas] {FFFFFF}Aquel que intente mal lograr el evento será sacado.");
	SendClientMessage(playerid, COLOR_RED, "¿Qué esperas para subir al avión?");
}
//===================================================Evento supervivencia=========================================================

		  if(Events[playerid][Supervivencia] ==1)
		  {
		  EnEvento[playerid]=1;
		  OnEvento[playerid] =1;
		  IniciadoEvento[playerid] = 1;
		  BloqueoEvento[playerid] =1;
		  AntiSpawnKill[playerid] = false;
		  new c[135];
		  new Float:posicion_c[12][15] = {
		  {1236.8744, 223.8871, 28.0728},
		  {1267.3665, 243.0225, 31.1073},
		  {1220.7605, 247.1759, 24.5474},
		  {1207.6960, 268.2981, 19.5547},
		  {1258.8423, 305.7189, 28.7555},
		  {1238.7363, 312.8860, 24.7578},
		  {1294.8441, 304.6524, 27.5555},
		  {1266.8541, 273.3112, 23.5555},
		  {1315.0399, 275.0108, 30.6093},
		  {1361.7780, 191.1156, 27.0224},
		  {1375.0265, 257.5041, 24.2750},
		  {1307.5800, 395.5067, 25.0555}
		  };


		   if(pos_c > 10)
			 return SendClientMessage(playerid, -1, "[INFO] El evento ha llegado al límite, máximo 10 personas");
					++pos_c;

	JBC_SetPlayerPos(playerid, posicion_c[pos_c][0], posicion_c[pos_c][1], posicion_c[pos_c][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 2);
	SetPlayerFacingAngle(playerid, 337.8630);
	SetCameraBehindPlayer(playerid);

	JBC_ResetPlayerWeapons(playerid);
	JBC_SetPlayerHealth(playerid, 100);
	JBC_SetPlayerArmour(playerid, 70);
	JBC_GivePlayerWeapon(playerid, 27, 70);
	JBC_GivePlayerWeapon(playerid, 31, 50);
	JBC_GivePlayerWeapon(playerid, 29, 45);
	JBC_GivePlayerWeapon(playerid, 16, 3);
	SetPlayerTime(playerid, 4, 0);
	SetPlayerWeather(playerid, 31);
	JBC_SetPlayerSkin(playerid, 161);
	SetPlayerColor(playerid, COLOR_HIDE);
	SetPlayerTeam(playerid, TEAM_EVENTO);
	JBC_TogglePlayerControllable(playerid, false);

	if(CheckVip(playerid) == 1)
	{
	  JBC_SetPlayerArmour(playerid, 30);
	  SendClientMessage(playerid, COLOR_BEIGE,"[VIP]"white" Recibiste +10 buyedArmour[ en el evento por membresía "VIP1_COLOR"VIP 1.");
	}
		if(CheckVip(playerid) == 2)
		{
		JBC_SetPlayerArmour(playerid, 70);
		SendClientMessage(playerid, COLOR_BEIGE,"[VIP]"white" Recibiste +30 buyedArmour[ en el evento por membresía "VIP2_COLOR"VIP 2.");
		}

	format(c, sizeof(c), "[Evento] {33FFCC}%s{33FFCC} {FFFFFF}ha ingresado al evento supervivencia{FFFFFF} {66FFFF}/evento", pName(playerid));

	SendClientMessageToAll(COLOR_BEIGE, c);
	SendClientMessage(playerid, COLOR_GOLD, "[Supervivencia] {FFFFFF}Has ingresado al evento supervivencia.");
	SendClientMessage(playerid, COLOR_GOLD, "[INFO evento] {FFFFFF}El evento consiste en asesinar a todo lo que se mueva, aquí no hay amistades, el último en pie gana.");
	SendClientMessage(playerid, COLOR_GOLD, "[Reglas] {FFFFFF}No se permiten animaciones para ocultarse.{FFFFFF}");
	SendClientMessage(playerid,COLOR_LIGHBLUE, "[INFO] {FFFFFF}Te encuentras congelado, espera que el administrador inicie el evento para poder moverte.");
}
//=================================================Evento autos chocones=========================================================
		 if(Events[playerid][AutosChocadores] ==1)
		 {
		 EnEvento[playerid]=1;
		 OnEvento[playerid] =1;
		 IniciadoEvento[playerid] = 1;
		 BloqueoEvento[playerid] =1;
		 AntiSpawnKill[playerid] = false;
		 new d[135];
		 new Float:posicion_d[12][15] = {
		 {1307.5137, 2108.0520, 10.7210},
		 {1307.5137, 2114.9641, 10.7256},
		 {1307.5137, 2122.4243, 10.7286},
		 {1307.5137, 2131.8984, 10.7287},
		 {1307.5137, 2138.3027, 10.7285},
		 {1307.5137, 2146.7930, 10.7285},
		 {1307.5137, 2156.4412, 10.7287},
		 {1307.5137, 2162.0640, 10.7293},
		 {1307.5137, 2170.6699, 10.7285},
		 {1307.5137, 2181.5142, 10.7287},
		 {1307.5137, 2190.7207, 10.7287},
		 {1307.5137, 2195.4619, 10.7287}
		 };

		   if(pos_d > 10)
			 return SendClientMessage(playerid, -1, "[INFO] El evento ha llegado al límite, máximo 10 personas.");
					++pos_d;

	JBC_SetPlayerPos(playerid, posicion_d[pos_d][0], posicion_d[pos_d][1], posicion_d[pos_d][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 2);
	SetPlayerFacingAngle(playerid, 272.2913);
	SetCameraBehindPlayer(playerid);

	vEvents[playerid] = JBC_CreateVehicle(560, posicion_d[pos_d][0], posicion_d[pos_d][1], posicion_d[pos_d][2], 272.2913, 126, 126, -1);
	SetVehicleVirtualWorld( vEvents[playerid], 2);
	JBC_PutPlayerInVehicle(playerid,  vEvents[playerid], 0);
	JBC_SetPlayerHealth(playerid, 100);
	JBC_TogglePlayerControllable(playerid, false);

	SetPlayerTime(playerid, 5, 0);
	SetPlayerWeather(playerid, 36);
	SetPlayerTeam(playerid, TEAM_EVENTO);

	format(d, sizeof(d), "[Evento] {33FFCC}%s{33FFCC} {FFFFFF}ha ingresado al evento autos chocones{FFFFFF} {66FFFF}/evento", pName(playerid));
	SendClientMessageToAll(COLOR_BEIGE, d);
	SendClientMessage(playerid, COLOR_GOLD, "[Evento] {FFFFFF}Has ingresado al evento autos chocones.{FFFFFF}");
	SendClientMessage(playerid, COLOR_GOLD, "[INFO evento] {FFFFFF}El evento consiste en chocar a todos los contrincantes hasta explotarles su auto.");
	SendClientMessage(playerid,COLOR_LIGHBLUE, "[INFO evento] {FFFFFF}Te encuentras congelado, espera que un administrador inicie el evento para poder moverte.");
	SendClientMessage(playerid,COLOR_LIGHBLUE, "[Reglas] {FFFFFF}Si bajas del vehículo quedas automáticamente descalificado.");

//vida de vehículos extra para jugadores con membresía VIP 1 - 2 - 3
/*if(CheckVip(playerid) == 1)
{
new Float:in_x, Float:in_y, Float:in_z, Float:hpv;
GetVehiclePos(vEvents[playerid], in_x, in_y, in_z);
GetVehicleVirtualWorld(vEvents[playerid]);
JBC_SetVehicleHealth(vEvents[playerid], GetVehicleHealth(vEvents[playerid], hpv)+1325);
SendClientMessage(playerid, COLOR_BEIGE,"[VIP]"white" Recibiste +325 vida del auto en el evento por membresía "VIP1_COLOR"VIP bronce(1).");
}
if(CheckVip(playerid) == 2 )
{
new Float:in_x, Float:in_y, Float:in_z;
GetVehiclePos(vEvents[playerid], in_x, in_y, in_z);
GetVehicleVirtualWorld(vEvents[playerid]);
JBC_SetVehicleHealth(vEvents[playerid], 1525);
SendClientMessage(playerid, COLOR_BEIGE,"[VIP]"white" Recibiste +525 vida del auto en el evento por membresía "gray"VIP plata(2).");
}
if(CheckVip(playerid) == 2)
{
new Float:v_health;
JBC_SetVehicleHealth(vEvents[playerid], GetVehicleHealth(vEvents[playerid], v_health)+1725);
SendClientMessage(playerid, COLOR_BEIGE,"[VIP]"white" Recibiste +725 vida del auto en el evento por membresía "VIP2_COLOR"VIP 2.");
}*/
}

//========================================Evento retadores(por team)==========================================================
		  if(Events[playerid][Retadores] ==1)
		  {
		  EnEvento[playerid]=1;
		  OnEvento[playerid] =1;
		  IniciadoEvento[playerid] = 1;
		  BloqueoEvento[playerid] =1;
		  AntiSpawnKill[playerid] = false;

		  new e[135];
		  new Float:posicion_e[12][15] ={
		  {-2429.7766, 2361.7444, 10.6943},
		  {-2441.9646, 2449.3799, 16.4969},
		  {-2325.1953, 2395.9485, 5.8676},
		  {-2423.8821, 2310.1428, 3.9974},
		  {-2576.9004, 2299.3335, 5.9489},
		  {-2621.1602, 2247.2673, 8.1525},
		  {-2536.4485, 2296.6152, 13.5234},
		  {-2508.5432, 2364.6541, 4.9868},
		  {-2525.5886, 2348.1558, 13.2361},
		  {-2445.4155, 2269.7988, 14.8363},
		  {-2570.1160, 2380.5039, 11.7058},
		  {-2436.9788, 2402.2021, 16.8868}
		  };

		   if(pos_e > 10)
			 return SendClientMessage(playerid, -1, "[INFO] El evento ha llegado al límite, máximo 10 personas.");
					++pos_e;

	JBC_SetPlayerPos(playerid, posicion_e[pos_e][0], posicion_e[pos_e][1], posicion_e[pos_e][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 2);
	SetPlayerFacingAngle(playerid, 182.6742);
	SetCameraBehindPlayer(playerid);

	JBC_ResetPlayerWeapons(playerid);
	JBC_GivePlayerWeapon(playerid, 24, 72);
	JBC_GivePlayerWeapon(playerid, 29, 62);
	JBC_GivePlayerWeapon(playerid, 34, 5);
	JBC_GivePlayerWeapon(playerid, 31, 72);
	JBC_GivePlayerWeapon(playerid, 25, 12);
	JBC_SetPlayerHealth(playerid, 100);
	JBC_SetPlayerArmour(playerid, 70);
	SetPlayerTeam(playerid, TEAM_EVENTO);
	SetPlayerColor(playerid, COLOR_BEIGE);

	if(CheckVip(playerid) == 1)
	{
		JBC_SetPlayerArmour(playerid, 80);
		SendClientMessage(playerid, COLOR_BEIGE,"[VIP]"white" Recibiste +10 buyedArmour[ en el evento por membresía "VIP1_COLOR"VIP bronce(1).");
	}
	if(CheckVip(playerid) == 2)
	{
		JBC_SetPlayerArmour(playerid, 100);
		SendClientMessage(playerid, COLOR_BEIGE,"[VIP]"white" Recibiste +30 buyedArmour[ en el evento por membresía "VIP2_COLOR"VIP 2.");
	}

	format(e, sizeof(e), "[Evento] {33FFCC}%s{33FFCC} {FFFFFF}ha ingresado al evento retadores{FFFFFF} {66FFFF}/evento", pName(playerid));

	SendClientMessageToAll(COLOR_BEIGE, e);
	//Mensajes con las indicaciones y reglas del evento

	SendClientMessage(playerid, COLOR_GOLD, "[Evento] {FFFFFF}Has ingresado al evento retadores.{FFFFFF}");
	SendClientMessage(playerid, COLOR_GOLD, "[INFO evento] {FFFFFF}En retadores el trabajo en equipo es fundamental, debes cooperar con tus compañeros para ganar.{FFFFFF}");
	SendClientMessage(playerid, COLOR_GOLD, "[INFO evento] {FFFFFF}Si un jugador gana, todo el equipo gana.{FFFFFF}");
	SendClientMessage(playerid, COLOR_GOLD, "[Reglas] {FFFFFF}Los jugadores que intenten alejarse de la zona de batalla serán sacados, no se permiten acciones.{FFFFFF}");
	SendClientMessage(playerid,COLOR_LIGHBLUE, "[INFO] {FFFFFF}Te encuentras congelado, espera que un administrador inicie el evento para poder moverte.");
	}
	if(Events[playerid][Blindado] == 1)
	{
	 EnEvento[playerid]=1;
		  OnEvento[playerid] =1;
		  IniciadoEvento[playerid] = 1;
		  BloqueoEvento[playerid] =1;
		  AntiSpawnKill[playerid] = false;

		  new f[135];
		  new Float:posicion_f[12][15] ={
		  {-2268.3413, 47.3417, 35.1641},
		  {-2267.5176, 52.4180, 35.1641},
		  {-2275.4595, 47.7464, 35.1641},
		  {-2274.6770, 52.0549, 35.1641},
		  {-2279.2239, 47.8809, 35.1641},
		  {-2278.7073, 52.4201, 35.1641},
		  {-2284.5662, 48.0524, 35.1641},
		  {-2283.8013, 52.0521, 35.1641},
		  {-2287.7427, 47.3036, 35.1641},
		  {-2287.0095, 51.5445, 35.1641},
		  {-2290.1084, 47.1260, 35.1641},
		  {-2298.1521, 50.2378, 35.1641}
		  };

		   if(pos_f > 10)
			 return SendClientMessage(playerid, -1, "[INFO] El evento ha llegado al límite, máximo 10 personas.");
					++pos_f;

	JBC_SetPlayerPos(playerid, posicion_f[pos_f][0], posicion_f[pos_f][1], posicion_f[pos_f][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 2);
	SetPlayerFacingAngle(playerid, 268.3817);
	SetCameraBehindPlayer(playerid);

	vEvents[playerid] =  JBC_CreateVehicle(418,posicion_f[pos_f][0], posicion_f[pos_f][1], posicion_f[pos_f][2], 268.3817, 241, 241, -1);
	SetVehicleVirtualWorld(vEvents[playerid], 2);
	JBC_PutPlayerInVehicle(playerid, vEvents[playerid], 0);
	IsVehicleBlind[playerid] = false;

	JBC_ResetPlayerWeapons(playerid);
	JBC_GivePlayerWeapon(playerid, 29, 850);
	JBC_SetPlayerHealth(playerid, 100);
	JBC_SetPlayerArmour(playerid, 0);
	SetPlayerColor(playerid, COLOR_GREEN);
	SetPlayerTeam(playerid, TEAM_EVENTO);
	GangZoneShowForPlayer(playerid, blindzone, COLOR_BLIND);

	format(f, sizeof(f), "[Evento] {33FFCC}%s{33FFCC} {FFFFFF}ha ingresado al evento blindado{FFFFFF} {66FFFF}/evento", pName(playerid));

	SendClientMessageToAll(COLOR_BEIGE, f);
	//Mensajes con las indicaciones y reglas del evento
	SendClientMessage(playerid, COLOR_GOLD, "[Evento] {FFFFFF}Has ingresado al evento blindado.{FFFFFF}");
	SendClientMessage(playerid, COLOR_GOLD, "[INFO evento] {FFFFFF}El evento consiste en hacer una emboscada al blindado, sin destruírlo.");
	SendClientMessage(playerid, COLOR_GOLD, "[INFO evento] {FFFFFF}El jugador que suba al camión blindado gana.");
	SendClientMessage(playerid, COLOR_GOLD, "[Reglas] {FFFFFF}Los jugadores que intenten alejarse de la zona serán sacados automáticamente.");
	SendClientMessage(playerid,COLOR_LIGHBLUE, "[INFO] {FFFFFF}has sido congelado, dentro de treinta segundos podrás moverte.{FFFFFF}");
	}
	}
	return 1;
}

//===============Comando /finalizar, para eliminar, autos, settimers, y regresar a la hora y clima del juego normal============
//alias:finalizar("fin");
CMD:finalizar(playerid, params[])
{
	CheckPlayerLogin(playerid);
	
	LevelCheck(playerid, 4);

	  if(IniciadoEvento[playerid] ==0) 
	  	return SendClientMessage(playerid, COLOR_RED, "[ERROR] No hay eventos para finalizar.");
		 new s[135];

		 format(s, sizeof(s), "[Evento]{33FFCC} %s{33FFCC}{FFFFFF} finalizó el evento.", pName(playerid));
		 SendClientMessageToAll(COLOR_ORANGE, s);
		 RemovePlayerFromVehicle(playerid);
		 JBC_SetPlayerArmour(playerid,0);
		 pos_a = -1;
		 pos_b = -1;
		 pos_c = -1;
		 pos_d = -1;
		 pos_e = -1;
		 pos_f = -1;
		 for(new i=0; i<MAX_PLAYERS; i++)
			 {
			 DestroyVehicle(vEvents[i]);
			 SetWorldTime(12);
			 SetWeather(36);
			 IniciadoEvento[i] = 0;
			 OnEvento[i] = 0;
			 EnEvento[i] = 0;
			 Events[i][Escondidas] = 0;
			 Events[i][AvionMuerte] = 0;
			 Events[i][Supervivencia] = 0;
			 Events[i][AutosChocadores] = 0;
			 Events[i][Retadores] = 0;
			 Events[i][Blindado] = 0;
			 IsVehicleBlind[i] = false;
			 GangZoneDestroy(blindzone);
			 if(GetPlayerVirtualWorld(i) == 2)
			 {
			 RemovePlayerFromVehicle(i);
			 SetPlayerLastTeam(i);
			 JBC_ResetPlayerWeapons(i);
			 SpawnPlayer(i);
			 JBC_SetPlayerArmour(i,0);
			 SetPlayerTime(i, 12, 0);
			 SetPlayerWeather(i, 36);
			 ResetPos(i);
			 }
			 }
	return 1;
}

CMD:salir(playerid, params[])
{
    switch(EnEvento[playerid])
    {
    	case 0:
    	{
    		SendClientMessage(playerid, COLOR_RED, "[ERROR] No estás en ningún evento del que puedas salir.");
    	}
    	case 1:
    	{
			EnEvento[playerid] = 0;
		    BloqueoEvento[playerid] =0;

		    DestroyVehicle(vEvents[playerid]);
		    SetPlayerLastTeam(playerid);
		    JBC_ResetPlayerWeapons(playerid);
		    SpawnPlayer(playerid);
		    JBC_SetPlayerArmour(playerid,0);
		    SetPlayerTime(playerid, 12, 0);
		    SetPlayerWeather(playerid, 36);
		    ResetPos(playerid);    		
    	}
    }
	return 1;
}

JB_Function:pName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

JB_Function:LeaveOfEvent(playerid)
{
	EnEvento[playerid] = 0;
	BloqueoEvento[playerid] =0;
	
	DestroyVehicle(vEvents[playerid]);
	SetPlayerLastTeam(playerid);
	JBC_ResetPlayerWeapons(playerid);
	SpawnPlayer(playerid);
	JBC_SetPlayerArmour(playerid,0);
	SetPlayerTime(playerid, 12, 0);
	SetPlayerWeather(playerid, 36);
	return ResetPos(playerid);
}


JB_Function:PreloadAnimations(playerid)
{
	ApplyAnimation(playerid, "AIRPORT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "Attractors", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BASEBALL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BD_FIRE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BEACH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "benchpress", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BF_injection", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKED", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKEH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKELEAP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKEV", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BIKE_DBZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BMX", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BOMBER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BOX", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BSKTBALL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BLOWJOBZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BUDDY", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "BUS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CAMERA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CARRY", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CAR_CHAT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CASINO", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CHAINSAW", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CHOPPA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CLOTHES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COACH", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COLT45", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COP_AMBIENT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "COP_DVBYZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CRACK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "CRIB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DAM_JUMP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DANCING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DEALER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DILDO", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DODGE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DOZER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "DRIVEBYS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FAT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_B", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_C", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_D", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FIGHT_E", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FINALE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FINALE2", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FLAME", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "Flowers", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "FOOD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "Freeweights", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GANGS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GHANDS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GHETTO_DB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "goggles", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GRAFFITI", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GRAVEYARD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GRENADE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "GYMNASIUM", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "HAIRCUTS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "HEIST9", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "INT_HOUSE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "INT_OFFICE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "INT_SHOP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "JST_BUISNESS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "KART", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "KISSING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "KNIFE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LAPDAN1", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LAPDAN2", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LAPDAN3", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "LOWRIDER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MD_CHASE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MD_END", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MEDIC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MISC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MTB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "MUSCULAR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "NEVADA", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ON_LOOKERS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "OTB", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PARACHUTE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PARK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PAULNMAC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ped", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PLAYER_DVBYS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PLAYIDLES", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "POLICE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "POOL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "POOR", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "PYTHON", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "QUAD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "QUAD_DBZ", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RAPPING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RIFLE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RIOT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "ROB_BANK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RUSTLER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "RYDER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SCRATCHING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SHAMAL", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SHOP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SHOTGUN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SILENCED", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SKATE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SMOKING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SNIPER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SPRAYCAN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "STRIP", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SUNBATHE", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWAT", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWEET", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWIM", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "SWORD", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TANK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TATTOOS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TEC", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TRAIN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "TRUCK", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "UZI", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "VAN", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "VENDING", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "VORTEX", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WAYFARER", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WEAPONS", "null", 0.0, 0, 0, 0, 0, 0);
	ApplyAnimation(playerid, "WUZI", "null", 0.0, 0, 0, 0, 0, 0);
	return 1;
}
