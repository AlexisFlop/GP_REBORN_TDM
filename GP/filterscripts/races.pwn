/*====================================== Ryder Race System ================================================
									última actualización: desconocido
	Creditos:
			» Joker
			» Joe Torran 
			» DracoBlue
	        » Y_Less
	        » Seif_
			» pablobl[X]
			» Jefferson

			NOTA: Editado, optimizado y modificado, por Pablo y Jefferson a partir de: 23/03/2019

                                                                                            GP 2017 - 2020 ©   
=============================================================================================================                                               */
#include <a_samp>
#include <JunkBuster>
#include <dini>
#include <zcmd>
#include <crashdetect>
#include <jadmin3>
//LOG REGISTRADOR DE CARRERAS
#define             	_LOG_                           "Logs/"

#define JB_PUBLIC%0(%1) forward %0(%1);\
                            public %0(%1)
//PARA STOCKS
#define JB_Function:%0(%1) stock %0(%1)

#define ForEach(%0,%1) \
	for(new %0 = 0; %0 != %1; %0++) if(IsPlayerConnected(%0) && !IsPlayerNPC(%0))
//BUCLE FOR
#define Loop(%0,%1) \
	for(new %0 = 0; %0 != %1; %0++)
	
#define IsOdd(%1) \
	((%1) & 1)
	
#define ConvertTime(%0,%1,%2,%3,%4) \
	new \
	    Float: %0 = floatdiv(%1, 60000) \
	;\
	%2 = floatround(%0, floatround_tozero); \
	%3 = floatround(floatmul(%0 - %2, 60), floatround_tozero); \
	%4 = floatround(floatmul(floatmul(%0 - %2, 60) - %3, 1000), floatround_tozero)
//RESETEO DE MUNDO VIRTUAL E INTERIOR
#define ResetPos(%0) SetPlayerInterior(%0, 0);\
					 SetPlayerVirtualWorld(%0, 0);
//LIMITE DE CHECKPOINTS POR CARRERA
#define MAX_RACE_CHECKPOINTS_EACH_RACE \
 	120
//LIMITE DE CARRERAS, ARCHIVOS .RACE	
#define MAX_RACES \
 	100
//CONTEO REGRESIVO DE INICIO DE LAS CARRERAS
#define COUNT_DOWN_TILL_RACE_START \
	35 // seconds
//LÍMITE DE TIEMPO DE LAS CARRERAS	
#define MAX_RACE_TIME \
	350 // seconds
//TAMAÑO DE CADA CHECKPOINT
#define RACE_CHECKPOINT_SIZE \
	12.0
//¿? VER FUNCIÓN
#define DEBUG_RACE \
	1
//COLORES
#define GREY \
	0xAFAFAFAA
	
#define GREEN \
	0x9FFF00FF
	
#define RED \
	0xE60000FF
	
#define YELLOW \
	0xFFFF00AA
	
#define WHITE \
	0xFFFFFFAA

stock isNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

new
	vNames[212][] =
	{
		{"Landstalker"},
		{"Bravura"},
		{"Buffalo"},
		{"Linerunner"},
		{"Perrenial"},
		{"Sentinel"},
		{"Dumper"},
		{"Firetruck"},
		{"Trashmaster"},
		{"Stretch"},
		{"Manana"},
		{"Infernus"},
		{"Voodoo"},
		{"Pony"},
		{"Mule"},
		{"Cheetah"},
		{"Ambulance"},
		{"Leviathan"},
		{"Moonbeam"},
		{"Esperanto"},
		{"Taxi"},
		{"Washington"},
		{"Bobcat"},
		{"Mr Whoopee"},
		{"BF Injection"},
		{"Hunter"},
		{"Premier"},
		{"Enforcer"},
		{"Securicar"},
		{"Banshee"},
		{"Predator"},
		{"Bus"},
		{"Rhino"},
		{"Barracks"},
		{"Hotknife"},
		{"Trailer 1"},
		{"Previon"},
		{"Coach"},
		{"Cabbie"},
		{"Stallion"},
		{"Rumpo"},
		{"RC Bandit"},
		{"Romero"},
		{"Packer"},
		{"Monster"},
		{"Admiral"},
		{"Squalo"},
		{"Seasparrow"},
		{"Pizzaboy"},
		{"Tram"},
		{"Trailer 2"},
		{"Turismo"},
		{"Speeder"},
		{"Reefer"},
		{"Tropic"},
		{"Flatbed"},
		{"Yankee"},
		{"Caddy"},
		{"Solair"},
		{"Berkley's RC Van"},
		{"Skimmer"},
		{"PCJ-600"},
		{"Faggio"},
		{"Freeway"},
		{"RC Baron"},
		{"RC Raider"},
		{"Glendale"},
		{"Oceanic"},
		{"Sanchez"},
		{"Sparrow"},
		{"Patriot"},
		{"Quad"},
		{"Coastguard"},
		{"Dinghy"},
		{"Hermes"},
		{"Sabre"},
		{"Rustler"},
		{"ZR-350"},
		{"Walton"},
		{"Regina"},
		{"Comet"},
		{"BMX"},
		{"Burrito"},
		{"Camper"},
		{"Marquis"},
		{"Baggage"},
		{"Dozer"},
		{"Maverick"},
		{"News Chopper"},
		{"Rancher"},
		{"FBI Rancher"},
		{"Virgo"},
		{"Greenwood"},
		{"Jetmax"},
		{"Hotring"},
		{"Sandking"},
		{"Blista Compact"},
		{"Police Maverick"},
		{"Boxville"},
		{"Benson"},
		{"Mesa"},
		{"RC Goblin"},
		{"Hotring Racer A"},
		{"Hotring Racer B"}, 
		{"Bloodring Banger"},
		{"Rancher"},
		{"Super GT"},
		{"Elegant"},
		{"Journey"},
		{"Bike"},
		{"Mountain Bike"},
		{"Beagle"},
		{"Cropdust"},
		{"Stunt"},
		{"Tanker"},
		{"Roadtrain"},
		{"Nebula"},
		{"Majestic"},
		{"Buccaneer"},
		{"Shamal"},
		{"Hydra"},
		{"FCR-900"},
		{"NRG-500"},
		{"HPV1000"},
		{"Cement Truck"},
		{"Tow Truck"},
		{"Fortune"},
		{"Cadrona"},
		{"FBI Truck"},
		{"Willard"},
		{"Forklift"},
		{"Tractor"},
		{"Combine"},
		{"Feltzer"},
		{"Remington"},
		{"Slamvan"},
		{"Blade"},
		{"Freight"},
		{"Streak"},
		{"Vortex"},
		{"Vincent"},
		{"Bullet"},
		{"Clover"},
		{"Sadler"},
		{"Firetruck LA"},
		{"Hustler"},
		{"Intruder"},
		{"Primo"},
		{"Cargobob"},
		{"Tampa"},
		{"Sunrise"},
		{"Merit"},
		{"Utility"},
		{"Nevada"},
		{"Yosemite"},
		{"Windsor"},
		{"Monster A"},
		{"Monster B"},
		{"Uranus"},
		{"Jester"},
		{"Sultan"},
		{"Stratum"},
		{"Elegy"},
		{"Raindance"},
		{"RC Tiger"},
		{"Flash"},
		{"Tahoma"},
		{"Savanna"},
		{"Bandito"},
		{"Freight Flat"}, 
		{"Streak Carriage"}, 
		{"Kart"},
		{"Mower"},
		{"Duneride"},
		{"Sweeper"},
		{"Broadway"},
		{"Tornado"},
		{"AT-400"},
		{"DFT-30"},
		{"Huntley"},
		{"Stafford"},
		{"BF-400"},
		{"Newsvan"},
		{"Tug"},
		{"Trailer 3"},
		{"Emperor"},
		{"Wayfarer"},
		{"Euros"},
		{"Hotdog"},
		{"Club"},
		{"Freight Carriage"}, 
		{"Trailer 3"},
		{"Andromada"},
		{"Dodo"},
		{"RC Cam"},
		{"Launch"},
		{"Police Car (LSPD)"},
		{"Police Car (SFPD)"},
		{"Police Car (LVPD)"},
		{"Police Ranger"},
		{"Picador"},
		{"S.W.A.T. Van"},
		{"Alpha"},
		{"Phoenix"},
		{"Glendale"},
		{"Sadler"},
		{"Luggage Trailer A"}, 
		{"Luggage Trailer B"},
		{"Stair Trailer"}, 
		{"Boxville"},
		{"Farm Plow"},
		{"Utility Trailer"}
	},
	BuildRace,
	BuildRaceType,
	BuildVehicle,
	BuildCreatedVehicle,
	BuildModeVID,
	BuildName[30],
	bool: BuildTakeVehPos,
	BuildVehPosCount,
	bool: BuildTakeCheckpoints,
	BuildCheckPointCount,
	RaceBusy = 0x00,
	RaceName[30],
	RaceVehicle,
	RaceType,
	TotalCP,
	Float: RaceVehCoords[2][4],
	Float: CPCoords[MAX_RACE_CHECKPOINTS_EACH_RACE][4],
	CreatedRaceVeh[MAX_PLAYERS],
	Index,
	PlayersCount[2],
	CountTimer,
	CountAmount,
	Joined[MAX_PLAYERS],
	RaceTick,
	RaceStarted,
	CPProgess[MAX_PLAYERS],
	Position,
	FinishCount,
	JoinCount,
	rCounter,
	RaceTime,
	PlayerText: RaceInfo,
	InfoTimer[MAX_PLAYERS],
	RacePosition[MAX_PLAYERS],
	RaceNames[MAX_RACES][128],
 	TotalRaces,
 	bool: AutomaticRace,
 	TimeProgress
 	
;

public OnFilterScriptInit()
{
   print("\n[FILTERSCRIPT] Races loading...");
   print("[FILTERSCRIPT] Races loaded\n");
   return 1;
}

public OnFilterScriptExit()
{
	BuildCreatedVehicle = 
		(BuildCreatedVehicle == 0x01) ? 
			(DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	
	KillTimer(rCounter);
	KillTimer(CountTimer);
	//DESACTIVAR CARRERA
	Loop(i, MAX_PLAYERS)
	{
		DisablePlayerRaceCheckpoint(i);
		PlayerTextDrawDestroy(i, RaceInfo);
		DestroyVehicle(CreatedRaceVeh[i]);
		Joined[i] = 0;
		KillTimer(InfoTimer[i]);
	}
	JoinCount = 0;
	FinishCount = 0;
	TimeProgress = 0;
	AutomaticRace = false;
	return 1;
}
//COMANDOS
//CREADO DE CARRERAS
CMD:buildrace(playerid, params[])
{
	if(CheckPlayerAdmin(playerid) < 7)
 		return SendClientMessage(playerid, RED, "[RACE] No tienes el suficiente nivel para crear una carrera!");
 		
	if(BuildRace != 0)
		return SendClientMessage(playerid, RED, "[RACE] Ya hay alguien contruyendo una carrera.");

	if(RaceBusy == 0x01)
		return SendClientMessage(playerid, RED, "[RACE] Espera que la carrera termine!");
	if(IsPlayerInAnyVehicle(playerid)) 
		return SendClientMessage(playerid, RED, "[RACE] Abandona tu vehiculo primero.");
	
	BuildRace = playerid+1;
	ShowDialog(playerid, 899);
	
	new
		string[128]
	;

    //FALTA PONER LA HORA AQUÍ
	format(string, sizeof(string), "[GP - RACE]  \"%s\" ha iniciado la construcción de una carrera", pName(playerid));
	SaveLogData("buildrace.txt", string);
	return 1;
}

CMD:startrace(playerid, params[])
{
	//OPTIMIZAR EL "CHECKADMIN" En include
	if(CheckPlayerAdmin(playerid) < 2)
	   return SendClientMessage(playerid, RED, "[RACE] No eres administrador nivel 2");
	   
    if(AutomaticRace == true)
	   return SendClientMessage(playerid, RED, "[RACE] No puedes empezarla porque AutoRace está activo.");

    if(BuildRace != 0)
	   return SendClientMessage(playerid, RED, "[RACE] error!");

    if(RaceBusy == 0x01 || RaceStarted == 1)
	   return SendClientMessage(playerid, RED, "[RACE] Espera que la carrera actual termine para empezar otra.");
	   
    for(new i=0;i<MAX_PLAYERS;i++)
	{

	if(CheckEvent(i) == 1)
	   return SendClientMessage(playerid, RED, "[ERROR] Hay un evento en curso, espera que finalize para iniciar una carrera.");
    }

    if(isnull(params))
	   return SendClientMessage(playerid, RED, "[RACE] USO: /Startrace+Nombre de la carrera, mira la /lista.");

    LoadRace(playerid, params);
    return 1;
}

CMD:stoprace(playerid, params[])
{
   	if(CheckPlayerAdmin(playerid) < 2) 
   		return SendClientMessage(playerid, RED, "[RACE] No eres administrador nivel 2!");
    
    if(RaceBusy == 0x00 || RaceStarted == 0) 
    	return SendClientMessage(playerid, RED, "[RACE] No existe carrera para detener.");
	
	SendClientMessageToAll(RED, "[RACE] Un administrador ha frenado la carrera!");
	return StopRace();
}

CMD:carrera(playerid, params[])
{
	if(RaceStarted == 1) 
		return SendClientMessage(playerid, RED, "[RACE] La carrera ya ha comenzado, suerte la próxima!");
	
	if(RaceBusy == 0x00) 
		return SendClientMessage(playerid, RED, "[RACE] No hay carrera en la que participar.");
	
	if(Joined[playerid] == 1) 
		return SendClientMessage(playerid, RED, "[RACE] Ya has ingresado a la carrera! Si estas bugeado, usa /carrerasalir");
	
	if(IsPlayerInAnyVehicle(playerid)) 
		return SetTimerEx("SetupRaceForPlayer", 2500, 0, "e", playerid), RemovePlayerFromVehicle(playerid), Joined[playerid] = 1;
	
	SetupRaceForPlayer(playerid);
	
	Joined[playerid] = 1;
	//USAR PNAME EN INCLUDE
	new string[90+MAX_PLAYER_NAME];

    format(string, sizeof(string), "{3EFFB5}[RACE] %s se ha unido a la carrera %s ({FFFFFF}/CARRERA{3EFFB5}) [%d corredores].", pName(playerid), RaceName, JoinCount);
    SendClientMessageToAll(0xC4C4C4FF, string);
	return 1;
}

CMD:stopautorace(playerid, params[])
{
    if(CheckPlayerAdmin(playerid) < 6) 
    	return SendClientMessage(playerid, RED, "[RACE] No eres administrador nivel 6!");
    
    if(AutomaticRace == false) 
    	return SendClientMessage(playerid, RED, "[RACE] AutoRace ya se encuentra desactivado.");
    
    AutomaticRace = false;
    return 1;
}

CMD:exitrace(playerid, params[])
{
    if(Joined[playerid] == 1)
    {
		JoinCount--;
		Joined[playerid] = 1;
		
		DestroyVehicle(CreatedRaceVeh[playerid]);
	    DisablePlayerRaceCheckpoint(playerid);
		PlayerTextDrawHide(playerid, RaceInfo);
		
		CPProgess[playerid] = 0;
		
		KillTimer(InfoTimer[playerid]);
		JBC_TogglePlayerControllable(playerid, true);
		SetCameraBehindPlayer(playerid);
		SpawnPlayer(playerid);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		
		#if defined RACE_IN_OTHER_WORLD
		SetPlayerVirtualWorld(playerid, 0);
		#endif
	} 
	
	else 
		return SendClientMessage(playerid, RED, "[RACE] No estás dentro de una carrera!");
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(CPProgess[playerid] == TotalCP -1)
	{
		new
		    TimeStamp,
		    TotalRaceTime,
		    string[256],
		    rFile[256],
			rTime[3],
			Prize[2],
			TempTotalTime,
			TempTime[3]
		;
		
		Position++;
		
		TimeStamp = GetTickCount();
		TotalRaceTime = TimeStamp - RaceTick;
		
		ConvertTime(var, TotalRaceTime, rTime[0], rTime[1], rTime[2]);
		switch(Position)
		{
		    case 1: Prize[0] = 10000, Prize[1] = 10;
		    case 2: Prize[0] = 900*8, Prize[1] = 9;
		    case 3: Prize[0] = 900*7, Prize[1] = 8;
		    case 4: Prize[0] = 900*6, Prize[1] = 6;
		    case 6: Prize[0] = 900*5, Prize[1] = 5;
		    case 7: Prize[0] = 900*4, Prize[1] = 4;
		    case 8: Prize[0] = 900*3, Prize[1] = 3;
		    case 9: Prize[0] = 900*2, Prize[1] = 2;
		    default: Prize[0] = 900, Prize[1] = 1;
		}
		
		format(string, sizeof(string), "{12FFF1}[GP - RACE] \"%s\" ha terminado la carrera en la posición {FFFFFF}\"%d\".", pName(playerid), Position);
		SendClientMessageToAll(-1, string);
		
		format(string, sizeof(string), "    {FFFA00}Tiempo: \"%d:%d.%d\" - Premio: $%d.", rTime[0], rTime[1], rTime[2], Prize[0]);
		SendClientMessageToAll(-1, string);
		
		format(string, sizeof(string), "[GP - RACE]  \"%s\" ganó en una carrera \"$%d\".", pName(playerid), Prize[0]);
		SaveLogData("races.txt", string);
		
		if(FinishCount <= 5)
		{
			format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", RaceName);
		    format(string, sizeof(string), "BestRacerTime_%d", TimeProgress);
		    TempTotalTime = dini_Int(rFile, string);
		    ConvertTime(var1, TempTotalTime, TempTime[0], TempTime[1], TempTime[2]);
		    if(TotalRaceTime <= dini_Int(rFile, string) || TempTotalTime == 0)
		    {
		        dini_IntSet(rFile, string, TotalRaceTime);
				
				format(string, sizeof(string), "BestRacer_%d", TimeProgress);
		        
		        if(TempTotalTime != 0) 
		        	format(string, sizeof(string), 
		        		">> \"%s\" ha roto el record de la carrera de \"%s\" con \"%d\" segundos con la posicion \"%d\"'st/th posicion!", pName(playerid), dini_Get(rFile, string), -(rTime[1] - TempTime[1]), TimeProgress+1);
					
				else 
					format(string, sizeof(string), ">> \"%s\" ha creado el record de la carrera \"%d\"'st/th lugar!", pName(playerid), TimeProgress+1);
                
                SendClientMessageToAll(GREEN, "  ");
				SendClientMessageToAll(GREEN, string);
				SendClientMessageToAll(GREEN, "  ");
				
				format(string, sizeof(string), "BestRacer_%d", TimeProgress);
				dini_Set(rFile, string, pName(playerid));
				TimeProgress++;
		    }
		}
		
		FinishCount++;
		
		SetPlayerChocolate(playerid, GetPlayerChocolate(playerid)+Prize[0]);
		SetPlayerScore(playerid, GetPlayerScore(playerid) + Prize[1]);
		DisablePlayerRaceCheckpoint(playerid);
		
		CPProgess[playerid]++;
		
		RemovePlayerFromVehicle(playerid);
		DestroyVehicle(CreatedRaceVeh[playerid]);
        SpawnPlayer(playerid);
		if(FinishCount >= JoinCount) 
			return StopRace();
    }

	else
	{
		CPProgess[playerid]++;
		CPCoords[CPProgess[playerid]][3]++;
		RacePosition[playerid] = floatround(CPCoords[CPProgess[playerid]][3], floatround_floor);
	    
	    SetCP(playerid, CPProgess[playerid], CPProgess[playerid]+1, TotalCP, RaceType);
	    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
	}
    return 1;
}

public OnPlayerDisconnect(playerid)
{	//REVISAR ESTA PARTE EN TESTING, PROBABLE OCASIONADOR DE CIERTOS BUGS AL INGRESAR UN NUEVO CLIENTE
	if(Joined[playerid] == 1)
    {
		JoinCount--;
		Joined[playerid] = 0;
		
		DestroyVehicle(CreatedRaceVeh[playerid]);
		DisablePlayerRaceCheckpoint(playerid);
		PlayerTextDrawDestroy(playerid, RaceInfo);
		
		CPProgess[playerid] = 0;
		
		KillTimer(InfoTimer[playerid]);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		
		#if defined RACE_IN_OTHER_WORLD
		SetPlayerVirtualWorld(playerid, 0);
		#endif
	}
	
	PlayerTextDrawDestroy(playerid, RaceInfo);
	if(BuildRace == playerid+1) 
		BuildRace = 0;
	
	return 1;
}

public OnPlayerConnect(playerid)
{	//REVISAR EN TESTINGS, PROBABLEMENTE OCASIONADOR DE BUGS AL INGRESO DE UN NUEVO CLIENTE

	RaceInfo = CreatePlayerTextDraw(playerid, 110.000000, 120.000000, 
		"~y~Carrera: ~r~Infernus Original~n~~y~Checkpoint: ~w~1/52~n~~y~Tiempo: ~w~03:56~n~~y~Posicion: ~w~2/11~n~");
	
	PlayerTextDrawAlignment(playerid, RaceInfo, 2);
	PlayerTextDrawBackgroundColor(playerid, RaceInfo, 255);
	PlayerTextDrawFont(playerid, RaceInfo, 2);
	PlayerTextDrawLetterSize(playerid, RaceInfo, 0.229999, 1.100000);
	PlayerTextDrawColor(playerid, RaceInfo, -1);
	PlayerTextDrawSetOutline(playerid, RaceInfo, 0);
	PlayerTextDrawSetProportional(playerid, RaceInfo, 1);
	PlayerTextDrawSetShadow(playerid, RaceInfo, 1);
	PlayerTextDrawUseBox(playerid, RaceInfo, 1);
	PlayerTextDrawBoxColor(playerid, RaceInfo, 12383);
	PlayerTextDrawTextSize(playerid, RaceInfo, 0.000000, 150.000000);
	PlayerTextDrawSetSelectable(playerid, RaceInfo, 0);

	return 1;
}

public OnPlayerDeath(playerid)
{
    if(Joined[playerid] == 1)
    {
		JoinCount--;
		Joined[playerid] = 0;
		DestroyVehicle(CreatedRaceVeh[playerid]);
		DisablePlayerRaceCheckpoint(playerid);
		PlayerTextDrawHide(playerid, RaceInfo);
		CPProgess[playerid] = 0;
		KillTimer(InfoTimer[playerid]);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		#if defined RACE_IN_OTHER_WORLD
		SetPlayerVirtualWorld(playerid, 0);
		#endif
	}
	if(BuildRace == playerid+1) 
		BuildRace = 0;
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case 899:
	    {
	        if(!response) return BuildRace = 0;
	        switch(listitem)
	        {
	        	case 0: BuildRaceType = 0;
	        	case 1: BuildRaceType = 3;

			}
			ShowDialog(playerid, 900);
			return 1;
	    }
	    case 900..901:
	    {
	        if(!response) 
	        	return ShowDialog(playerid, 899);
	        
	        if(!strlen(inputtext)) 
	        	return ShowDialog(playerid, 901);
	        
	        if(strlen(inputtext) < 1 || strlen(inputtext) > 20) 
	        	return ShowDialog(playerid, 901);
	        
	        strmid(BuildName, inputtext, 0, strlen(inputtext), sizeof(BuildName));
	        ShowDialog(playerid, 902);
	        return 1;
	    }

	    case 902..903:
	    {
	        if(!response) 
	        	return ShowDialog(playerid, 900);
	        
	        if(!strlen(inputtext)) 
	        	return ShowDialog(playerid, 903);
	        
	        if(isNumeric(inputtext))
	        {

	            if(!IsValidVehicle(strval(inputtext))) 
	            	return ShowDialog(playerid, 903);
				
				new
	                Float: pPos[4]
				;
				
				GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
				GetPlayerFacingAngle(playerid, pPos[3]);
				
				BuildModeVID = strval(inputtext);
				BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	            BuildVehicle = JBC_CreateVehicle(strval(inputtext), pPos[0], pPos[1], pPos[2], pPos[3], random(126), random(126), (60 * 60));
	            
	            JBC_PutPlayerInVehicle(playerid, BuildVehicle, 0);
				
				BuildCreatedVehicle = 0x01;
				
				ShowDialog(playerid, 904);
				return 1;
			}
	        
	        else
	        {
	            if(!IsValidVehicle(ReturnVehicleID(inputtext))) 
	            	return ShowDialog(playerid, 903);
				
				new
	                Float: pPos[4]
				;
				
				GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
				GetPlayerFacingAngle(playerid, pPos[3]);
				
				BuildModeVID = ReturnVehicleID(inputtext);
				BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
	            BuildVehicle = JBC_CreateVehicle(ReturnVehicleID(inputtext), pPos[0], pPos[1], pPos[2], pPos[3], random(126), random(126), (60 * 60));
	            
	            JBC_PutPlayerInVehicle(playerid, BuildVehicle, 0);
				BuildCreatedVehicle = 0x01;
				ShowDialog(playerid, 904);
				return 1;
	        }
	    }
	    
	    case 904:
	    {	
	    	//DIÁLOGO DE CONSTRUCTOR DE CARRERA
	        if(!response) return ShowDialog(playerid, 902);
			SendClientMessage(playerid, GREEN, 
				">> Drijase a las coordenadas donde estara ubicada la primera posicion de la carrera y presione el boton de disparo...");
            
            SendClientMessage(playerid, GREEN, 
            	"...Luego de esto dirijase a las coordenadas donde desea que este la segunda posicion y presione el mismo boton.");
			SendClientMessage(playerid, GREEN, 
				"Cuando haya realizado estos pasos correctamente, vera un dialogo para continuar");
			
			BuildVehPosCount = 0;
	        BuildTakeVehPos = true;
	        return 1;
	    }
	    case 905:
	    {
	        if(!response) return 
	        	ShowDialog(playerid, 904);
	        //INICIO AL CONSTRUIR UNA CARRERA
	        SendClientMessage(playerid, GREEN, ">>Ahora comience a grabar los Checkpoint's presionando el boton de disparo.");
	        SendClientMessage(playerid, GREEN, ">>[IMPORTANTE] Presione <ENTER> cuando haya terminado de grabar los Checkpoint's...");
	        SendClientMessage(playerid, GREEN, ">>... Si no reacciona, presione el boton una y otra vez");
	       
	        BuildCheckPointCount = 0;
	        BuildTakeCheckpoints = true;
	        return 1;
	    }
	    case 906:
	    {
	        if(!response) 
	        	return ShowDialog(playerid, 906);
	        
	        BuildRace = 0;
	        BuildCheckPointCount = 0;
	        BuildVehPosCount = 0;
	        BuildTakeCheckpoints = false;
	        BuildTakeVehPos = false;
	        BuildCreatedVehicle = (BuildCreatedVehicle == 0x01) ? (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00) : (DestroyVehicle(BuildVehicle), BuildCreatedVehicle = 0x00);
            return 1;
	    }
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new
 		string[256],
 		rNameFile[256],
   		rFile[256],
     	Float: vPos[4]
	;
	
	if(newkeys & KEY_FIRE)
	{
	    if(BuildRace == playerid+1)
	    {
		    if(BuildTakeVehPos == true)
		    {
		    	//GRABADOR DE CHECKPOINTS, TECLA DISPARO
		    	if(!IsPlayerInAnyVehicle(playerid)) 
		    		return SendClientMessage(playerid, RED, ">> Necesitas estar dentro de un vehiculo");
				
				format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				GetVehicleZAngle(GetPlayerVehicleID(playerid), vPos[3]);
		        
		        dini_Create(rFile);
				dini_IntSet(rFile, "vModel", BuildModeVID);
				dini_IntSet(rFile, "rType", BuildRaceType);
		        //GUARDADO EN TIEMPO REAL DE CHECKPOINTS
		        format(string, sizeof(string), "vPosX_%d", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[0]);
		        format(string, sizeof(string), "vPosY_%d", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[1]);
		        format(string, sizeof(string), "vPosZ_%d", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[2]);
		        format(string, sizeof(string), "vAngle_%d", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[3]);
		        format(string, sizeof(string), ">> Se ha tomado la posicion del vehiculo '%d'.", BuildVehPosCount+1);
		        SendClientMessage(playerid, YELLOW, string);
				BuildVehPosCount++;
			}
   			
   			if(BuildVehPosCount >= 2)
		    {
		        BuildVehPosCount = 0;
		        BuildTakeVehPos = false;
		        ShowDialog(playerid, 905);
		    }
			
			if(BuildTakeCheckpoints == true)
			{
			    if(BuildCheckPointCount > MAX_RACE_CHECKPOINTS_EACH_RACE) 
			    	return SendClientMessage(playerid, RED, ">> Alcanzaste la cantidad maxima de Checkpoint's!");
			    
			    if(!IsPlayerInAnyVehicle(playerid)) 
			    	return SendClientMessage(playerid, RED, ">> Necesitas estar dentro de un vehiculo");
				
				format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				format(string, sizeof(string), "CP_%d_PosX", BuildCheckPointCount), dini_FloatSet(rFile, string, vPos[0]);
				format(string, sizeof(string), "CP_%d_PosY", BuildCheckPointCount), dini_FloatSet(rFile, string, vPos[1]);
				format(string, sizeof(string), "CP_%d_PosZ", BuildCheckPointCount), dini_FloatSet(rFile, string, vPos[2]);
    			format(string, sizeof(string), ">> El Checkpoint N:'%d' ha sido definido!", BuildCheckPointCount+1);
		        
		        SendClientMessage(playerid, YELLOW, string);
				BuildCheckPointCount++;
			}
		}
	}
	
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
	    if(BuildTakeCheckpoints == true)
	    {
	        ShowDialog(playerid, 906);
			format(rNameFile, sizeof(rNameFile), "/rRaceSystem/RaceNames/RaceNames.txt");
			
			TotalRaces = dini_Int(rNameFile, "TotalRaces");
			TotalRaces++;
			
			dini_IntSet(rNameFile, "TotalRaces", TotalRaces);
			format(string, sizeof(string), "Race_%d", TotalRaces-1);
			format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", BuildName);
			dini_Set(rNameFile, string, BuildName);
			dini_IntSet(rFile, "TotalCP", BuildCheckPointCount);
			Loop(x, 5)
			{
				format(string, sizeof(string), "BestRacerTime_%d", x);
				dini_Set(rFile, string, "0");
				format(string, sizeof(string), "BestRacer_%d", x);
				dini_Set(rFile, string, "noone");
			}
	    }
	}
	return 1;
}

JB_PUBLIC StopSoundRace(playerid)
{
    PlayerPlaySound(playerid, 1184, 0.0, 0.0, 0.0);
    return 1;
}

JB_PUBLIC LoadRaceNames()
{
	new
	    rNameFile[64],
	    string[64]
	;
	
	format(rNameFile, sizeof(rNameFile), "scriptfiles/rRaceSystem/RaceNames/RaceNames.txt");
	TotalRaces = dini_Int(rNameFile, "TotalRaces");
	Loop(x, TotalRaces)
	{
		//ESTE ARCHIVO NO SE ESTÁ GUARANDO, REVISAR
	    format(string, sizeof(string), "Race_%d", x), strmid(RaceNames[x], dini_Get(rNameFile, string), 0, 20, sizeof(RaceNames));
	    printf(">> Loaded Races: %s", RaceNames[x]);
	}
	return 1;
}
//FUNCIÓN PROBABLEMENTE INSERVIBLE E INUSUABLE
JB_PUBLIC LoadAutoRace(rName[])
{
	new
		rFile[256],
		string[256]
	;
	
	format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", rName);
	
	if(!dini_Exists(rFile)) 
		return printf("[Races] La carrera \"%s\" no existe", rName);
	
	strmid(RaceName, rName, 0, strlen(rName), sizeof(RaceName));
	
	RaceVehicle = dini_Int(rFile, "vModel");
	RaceType = dini_Int(rFile, "rType");
	TotalCP = dini_Int(rFile, "TotalCP");

	#if DEBUG_RACE == 1
	printf("VehicleModel: %d", RaceVehicle);
	printf("RaceType: %d", RaceType);
	printf("TotalCheckpoints: %d", TotalCP);
	#endif

	Loop(x, 2)
	{
		format(string, sizeof(string), "vPosX_%d", x), RaceVehCoords[x][0] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosY_%d", x), RaceVehCoords[x][1] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosZ_%d", x), RaceVehCoords[x][2] = dini_Float(rFile, string);
		format(string, sizeof(string), "vAngle_%d", x), RaceVehCoords[x][3] = dini_Float(rFile, string);
		#if DEBUG_RACE == 1
		printf("VehiclePos %d: %f, %f, %f, %f", x, RaceVehCoords[x][0], RaceVehCoords[x][1], RaceVehCoords[x][2], RaceVehCoords[x][3]);
		#endif
	}
	Loop(x, TotalCP)
	{
 		format(string, sizeof(string), "CP_%d_PosX", x), CPCoords[x][0] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%d_PosY", x), CPCoords[x][1] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%d_PosZ", x), CPCoords[x][2] = dini_Float(rFile, string);
 		#if DEBUG_RACE == 1
 		printf("RaceCheckPoint %d: %f, %f, %f", x, CPCoords[x][0], CPCoords[x][1], CPCoords[x][2]);
 		#endif
	}
	
	Position = 0;
	FinishCount = 0;
	JoinCount = 0;
	
	Loop(x, 2) PlayersCount[x] = 0;
	
	CountAmount = COUNT_DOWN_TILL_RACE_START;
	RaceTime = MAX_RACE_TIME;
	RaceBusy = 0x01;
	CountTimer = SetTimer("CountTillRace", 999, 1);
	TimeProgress = 0;
	return 1;
}
//CARGADO DE CARRERAS
JB_PUBLIC LoadRace(playerid, rName[])
{
	new
		rFile[256],
		string[256]
	;
	//BÚSQUEDA EN LOS ARCHIVOS POR NOMBRE
	format(rFile, sizeof(rFile), "/rRaceSystem/%s.RRACE", rName);
	//EN CASO DE NO EXISTIR
	if(!dini_Exists(rFile)) 
		return SendClientMessage(playerid, RED, "[RACE] Esa carrera no existe, mira todas las carreras en /lista"), printf("[Races] La carrera \"%s\" no existe", rName);
	
	strmid(RaceName, rName, 0, strlen(rName), sizeof(RaceName));
	
	RaceVehicle = dini_Int(rFile, "vModel");
	RaceType = dini_Int(rFile, "rType"); 
	TotalCP = dini_Int(rFile, "TotalCP");
	
	#if DEBUG_RACE == 1
	printf("VehicleModel: %d", RaceVehicle);
	printf("RaceType: %d", RaceType);
	printf("TotalCheckpoints: %d", TotalCP);
	#endif
	
	Loop(x, 2)
	{
		format(string, sizeof(string), "vPosX_%d", x), RaceVehCoords[x][0] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosY_%d", x), RaceVehCoords[x][1] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosZ_%d", x), RaceVehCoords[x][2] = dini_Float(rFile, string);
		format(string, sizeof(string), "vAngle_%d", x), RaceVehCoords[x][3] = dini_Float(rFile, string);
		#if DEBUG_RACE == 1
		#endif
	}

	Loop(x, TotalCP)
	{
 		format(string, sizeof(string), "CP_%d_PosX", x), CPCoords[x][0] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%d_PosY", x), CPCoords[x][1] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%d_PosZ", x), CPCoords[x][2] = dini_Float(rFile, string);
 		#if DEBUG_RACE == 1
// 		printf("RaceCheckPoint %d: %f, %f, %f", x, CPCoords[x][0], CPCoords[x][1], CPCoords[x][2]);
 		#endif
	}
	Position = 0;
	FinishCount = 0;
	JoinCount = 0;
	
	Loop(x, 2) PlayersCount[x] = 0;
	
	Joined[playerid] = 1;
	CountAmount = COUNT_DOWN_TILL_RACE_START;
	RaceTime = MAX_RACE_TIME;
	RaceBusy = 0x01;
	TimeProgress = 0;
	
	SetupRaceForPlayer(playerid);
	
	CountTimer = SetTimer("CountTillRace", 999, 1);
	
	new 
		l[128]
	;
	
	format(l, sizeof(l), "%s inició la carrera \"%s\" con %d jugadores", pName(playerid),rName, GetPlayerPoolSize());
	SaveLogData("whorace.txt", l);
	return 1;
}

JB_PUBLIC SetCP(playerid, PrevCP, NextCP, MaxCP, Type)
{
	if(Type == 0)
	{
		if(NextCP == MaxCP) 
			JBC_SetPlayerRaceCheckpoint(playerid, 1, 
				CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		else 
			JBC_SetPlayerRaceCheckpoint(playerid, 0, 
				CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
	}

	else if(Type == 3)
	{
		if(NextCP == MaxCP) 
			JBC_SetPlayerRaceCheckpoint(playerid, 4, 
				CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		
		else 
			JBC_SetPlayerRaceCheckpoint(playerid, 3, 
				CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
	}
	return 1;
}
//CONFIGURADO PARA EL JUGADOR
JB_PUBLIC SetupRaceForPlayer(playerid)
{	
	InfoTimer[playerid] = SetTimerEx("TextInfo", 500, 1, "e", playerid);
	new stringw[128];
	
	if(JoinCount == 1) 
		format(stringw, sizeof(stringw), "Nombre: ~r~%s~n~~y~Checkpoint: ~w~%d/%d~n~~r~Tiempo: ~w~%s~n~~y~Posicion: ~w~1/1~n~ ", RaceName, CPProgess[playerid], TotalCP, TimeConvert(RaceTime));
	
	else 
		format(stringw, sizeof(stringw), "Nombre: ~r~%s~n~~y~Checkpoint: ~w~%d/%d~n~~y~Tiempo: ~w~%s~n~~y~Posicion: ~w~%d/%d~n~ ", RaceName, CPProgess[playerid], TotalCP, TimeConvert(RaceTime), RacePosition[playerid], JoinCount);
	
	PlayerTextDrawSetString(playerid,RaceInfo, stringw);
	PlayerTextDrawShow(playerid, RaceInfo);
	
	JoinCount++;
	
	SendClientMessage(playerid, -1, "{FF5700}[INFO] Prohibido disparar, matar y usar nitro - Si deseas salir de la carrera usa {FFFFFF}/EXITRACE");
	
	CPProgess[playerid] = 0;
	
	JBC_TogglePlayerControllable(playerid, false);
	SetPlayerVirtualWorld(playerid, 4);
	SetPlayerInterior(playerid, 0);
	
	CPCoords[playerid][3] = 0;
	
	SetCP(playerid, CPProgess[playerid], CPProgess[playerid]+1, TotalCP, RaceType);
	
	if(IsOdd(playerid)) Index = 1;
	    else Index = 0;


	switch(Index)
	{
		case 0:
		{
		    if(PlayersCount[0] == 1)
		    {
				RaceVehCoords[0][0] -= (6 * floatsin(-RaceVehCoords[0][3], degrees));
		 		RaceVehCoords[0][1] -= (6 * floatcos(-RaceVehCoords[0][3], degrees));
		   		CreatedRaceVeh[playerid] = JBC_CreateVehicle(RaceVehicle, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2]+2, RaceVehCoords[0][3], random(126), random(126), (60 * 60));
		   		SetVehicleVirtualWorld(CreatedRaceVeh[playerid], 4);
				JBC_SetPlayerPos(playerid, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2]+2);
				SetPlayerFacingAngle(playerid, RaceVehCoords[0][3]);
				JBC_PutPlayerInVehicle(playerid, CreatedRaceVeh[playerid], 0);
				Camera(playerid, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2], RaceVehCoords[0][3], 20);
			}
		}
		case 1:
 		{
 		    if(PlayersCount[1] == 1)
 		    {
				RaceVehCoords[1][0] -= (6 * floatsin(-RaceVehCoords[1][3], degrees));
                RaceVehCoords[1][1] -= (6 * floatcos(-RaceVehCoords[1][3], degrees));
                CreatedRaceVeh[playerid] = JBC_CreateVehicle(RaceVehicle, RaceVehCoords[1][0], RaceVehCoords[1][1], RaceVehCoords[1][2]+2, RaceVehCoords[1][3], random(126), random(126), (60 * 60));
                SetVehicleVirtualWorld(CreatedRaceVeh[playerid], 4);
				JBC_SetPlayerPos(playerid, RaceVehCoords[1][0], RaceVehCoords[1][1], RaceVehCoords[1][2]+2);
				SetPlayerFacingAngle(playerid, RaceVehCoords[1][3]);
				JBC_PutPlayerInVehicle(playerid, CreatedRaceVeh[playerid], 0);
				Camera(playerid, RaceVehCoords[1][0], RaceVehCoords[1][1], RaceVehCoords[1][2], RaceVehCoords[1][3], 20);
    		}
 		}
	}
	
	switch(Index)
	{
	    case 0:
		{
			if(PlayersCount[0] != 1)
			{
                
                CreatedRaceVeh[playerid] = JBC_CreateVehicle(RaceVehicle, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2]+2, RaceVehCoords[0][3], random(126), random(126), (60 * 60));
                
                SetVehicleVirtualWorld(CreatedRaceVeh[playerid], 4);
				JBC_SetPlayerPos(playerid, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2]+2);
				SetPlayerFacingAngle(playerid, RaceVehCoords[0][3]);
				JBC_PutPlayerInVehicle(playerid, CreatedRaceVeh[playerid], 0);
				Camera(playerid, RaceVehCoords[0][0], RaceVehCoords[0][1], RaceVehCoords[0][2], RaceVehCoords[0][3], 20);
			    
			    PlayersCount[0] = 1;
		    }
	    }
	    case 1:
	    {
			if(PlayersCount[1] != 1)
			{
                CreatedRaceVeh[playerid] = JBC_CreateVehicle(RaceVehicle, RaceVehCoords[1][0], RaceVehCoords[1][1], RaceVehCoords[1][2]+2, RaceVehCoords[1][3], random(126), random(126), (60 * 60));
                
                SetVehicleVirtualWorld(CreatedRaceVeh[playerid], 4);
				JBC_SetPlayerPos(playerid, RaceVehCoords[1][0], RaceVehCoords[1][1], RaceVehCoords[1][2]+2);
				SetPlayerFacingAngle(playerid, RaceVehCoords[1][3]);
				JBC_PutPlayerInVehicle(playerid, CreatedRaceVeh[playerid], 0);
				Camera(playerid, RaceVehCoords[1][0], RaceVehCoords[1][1], RaceVehCoords[1][2], RaceVehCoords[1][3], 20);
				PlayersCount[1] = 1;
		    }
   		}
	}
	JBC_ResetPlayerWeapons(playerid);
	switch(CheckVip(playerid))
	{
		case 1:
		{
			JBC_SetVehicleHealth(RaceVehicle, 1500);
		}
		case 2:
		{
			JBC_SetVehicleHealth(RaceVehicle, 2100);	
		}
	}
	#if defined RACE_IN_OTHER_WORLD
	SetPlayerVirtualWorld(playerid, 0);
	#endif
	return 1;
}
//CONTEO PÚBLICO REGRESIVO DE CARRERAS
JB_PUBLIC CountTillRace()
{
	switch(CountAmount)
	{
 		case 0:
	    {
			ForEach(i, MAX_PLAYERS)
			{
			    if(Joined[i] == 0)
			    {
			       
					
					//format(string, sizeof(string), "[RACE] Ha comenzado la carrera \"%s\", ya no se aceptan nuevos corredores.", RaceName);
					//SendClientMessageToAll(RED, string);
				}
			}
			StartRace();
	    }
	    case 1..5:
	    {
	        new
	            string[10]
			;
			format(string, sizeof(string), "~y~%d!", CountAmount);
			ForEach(i, MAX_PLAYERS)
			{
			    if(Joined[i] == 1)
			    {
			    	GameTextForPlayer(i, string, 999, 5);
			    	PlayerPlaySound(i, 1039, 0.0, 0.0, 0.0);
			    }
			}
	    }
	    case 6..34:
	    {
	        new
	            string[100]
			;
			format(string, sizeof(string), "~n~~b~%d!", CountAmount);
			ForEach(i, MAX_PLAYERS)
			{
			    if(Joined[i] == 1)
			    {
			    	GameTextForPlayer(i, string, 999, 5);
			    	PlayerPlaySound(i, 1137, 0.0, 0.0, 0.0);
			    }
			}
	    }
		case 35:
	    {
	        new
	            string[140]
			;

			SendClientMessageToAll(-1, " ");
			format(string, sizeof(string), "{FFBE3C}[CARRERA]  {FFBE3C} '%s' está por comenzar en '%d' segundos! Usa {FFFFFF}/CARRERA{FFBE3C} para unirte!", RaceName, CountAmount);
			SendClientMessageToAll(-1, string);
				
       		for(new i = 0; i < GetMaxPlayers(); i ++)
    		{
        		if(IsPlayerConnected(i))
        		{
        			PlayerPlaySound(i, 1183, 0.0, 0.0, 0.0);
        			SetTimerEx("StopSoundRace", 35000, false, "i", i);
        		}
    		}
	    }
	}
	return CountAmount--;
}
//INICIALIZADOR DE CARRERAS
JB_PUBLIC StartRace()
{
	ForEach(i, MAX_PLAYERS)
	{
	    if(Joined[i] == 1)
	    {
	        JBC_TogglePlayerControllable(i, true);
	        PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
  			GameTextForPlayer(i, "~r~GO ~w~GO ~r~GOo!!!", 2000, 5);
			SetCameraBehindPlayer(i);
	    }
	}

	rCounter = SetTimer("RaceCounter", 900, 1);
	RaceTick = GetTickCount();
	RaceStarted = 1;
	KillTimer(CountTimer);
	return 1;
}
//DETENER CARRERA
JB_PUBLIC StopRace()
{
	KillTimer(rCounter);
	RaceStarted = 0;
	RaceTick = 0;
	RaceBusy = 0x00;
	JoinCount = 0;
	FinishCount = 0;
    TimeProgress = 0;
    
	ForEach(i, MAX_PLAYERS)
	{
	    if(Joined[i] == 1)
	    {
	    	DisablePlayerRaceCheckpoint(i);
	    	RemovePlayerFromVehicle(i);
	    	DestroyVehicle(CreatedRaceVeh[i]);
	    	
	    	Joined[i] = 0;
			
			PlayerTextDrawHide(i, RaceInfo);
			
			CPProgess[i] = 0;
			
			KillTimer(InfoTimer[i]);
			SetPlayerVirtualWorld(i, 0);
			KillTimer(StopSoundRace(i));
			SpawnPlayer(i);
		}
	}
	
	SendClientMessageToAll(YELLOW, "[RACE] Tiempo total de la carrera terminado. ¡Carrera finalizada!");
	
	if(AutomaticRace == true) 
		LoadRaceNames(), LoadAutoRace(RaceNames[random(TotalRaces)]);
	return 1;
}
//CONTADOR PERMANENTE DE LA CARRERA, UNA VEZ INICIADA
JB_PUBLIC RaceCounter()
{
	if(RaceStarted == 1)
	{
		RaceTime--;
		if(JoinCount <= 0)
		{
			StopRace();
			SendClientMessageToAll(RED, "[RACE] Ya no queda nadie en la carrera!");
		}
	}
	if(RaceTime <= 0)
	{
	    StopRace();
	}
	return 1;
}
//CUADRO DE INFORMACIÓN EN TIEMPO REAL DE CADA CARRERA
JB_PUBLIC TextInfo(playerid)
{
	new
	    string[128]
	;
	
	if(JoinCount == 1) 
		format(string, sizeof(string), "Nombre: ~r~%s~n~~y~Checkpoint: ~w~%d/%d~n~~y~Tiempo: ~w~%s~n~~y~Posicion: ~w~1/1~n~", RaceName, CPProgess[playerid], TotalCP, TimeConvert(RaceTime));
	
	else 
		format(string, sizeof(string), "Nombre: ~r~%s~n~~y~Checkpoint: ~w~%d/%d~n~~y~Tiempo: ~w~%s~n~~y~Posicion: ~w~%d/%d~n~", RaceName, CPProgess[playerid], TotalCP, TimeConvert(RaceTime), RacePosition[playerid], JoinCount);
	
	PlayerTextDrawSetString(playerid, RaceInfo, string);
	PlayerTextDrawShow(playerid, RaceInfo);
}

//CAMÁRA AL INICIAR UNA CARRERA
JB_PUBLIC Camera(playerid, Float:X, Float:Y, Float:Z, Float:A, Mul)
{
	SetPlayerCameraLookAt(playerid, X, Y, Z);
	SetPlayerCameraPos(playerid, X + (Mul * floatsin(-A, degrees)), Y + (Mul * floatcos(-A, degrees)), Z+6);
}
//CHEQUEO DE SI SE ESTÁ EN UNA CARRERA
JB_PUBLIC IsPlayerInRace(playerid)
{
	if(Joined[playerid] == 1) return 1;
	    else return 0;
}
//NATIVO SHOWPLAYERDIALOG ACORTADO EN UNA FUNCIÓN OPTIMIZADA
JB_PUBLIC ShowDialog(playerid, dialogid)
{
	switch(dialogid)
	{
		case 899: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, CreateCaption("Crear nueva carrera"), "\
		Carrera normal\n\
		Carrera aerea", "Next", "Exit");

	    case 900: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Crear nueva carrera (Paso 1/4)"), "\
		Paso 1:\n\
		********\n\
 		Bienvenido al asistente de 'Crear nueva carrera'.\n\
		Antes de comenzar, necesito saber el nombre de la carrera (Por ejemplo: SFRace) para luego guardarlo.\n\n\
		>> Escribe el nombre a continuacion y presiona 'Siguiente' to continue.", "Siguiente", "Atras");

	    case 901: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Crear nueva carrera (Paso 1/4)"), "\
	    ERROR: El nombre es demasiado corto! (min. 1 - max. 20)\n\n\n\
		Paso 1:\n\
		********\n\
 		Bienvenido al asistente de 'Crear nueva carrera'.\n\
		Antes de comenzar, necesito saber el nombre de la carrera (Por ejemplo: SFRace) para luego guardarlo.\n\n\
		>> Escribe el nombre a continuacion y presiona 'Siguiente' to continue.", "Siguiente", "Atras");

		case 902: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Crear nueva carrera (Paso 2/4)"), "\
		Paso 2:\n\
		********\n\
		Por favor, escriba el ID o el nombre del vehiculo que se utilizara en la carrera que esta creando.\n\n\
		>> Escriba el nombre o ID del vehiculo y presione 'Siguiente' para continuar. 'Atras' para cambiar algo.", "Siguiente", "Atras");

		case 903: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, CreateCaption("Crear nueva carrera (Paso 2/4)"), "\
		ERROR: El nombre o ID del vehiculo es invalido\n\n\n\
		Step 2:\n\
		********\n\
		Por favor, escriba el ID o el nombre del vehiculo que se utilizara en la carrera que esta creando.\n\n\
		>> Escriba el nombre o ID del vehiculo y presione 'Siguiente' para continuar. 'Atras' para cambiar algo.", "Siguiente", "Atras");

		case 904: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, CreateCaption("Crear nueva carrera (Paso 3/4)"),
		"\
		Paso 3:\n\
		********\n\
		¡Casi terminamos! Ahora ve a la línea de salida donde deberían estar el primer y el segundo auto.\n\
		Nota: Cuando haga clic en 'Aceptar', quedará libre. Use el boton de disparo para establecer la primera y la segunda posición.\n\
		Nota: Después de obtener estas posiciones, verá automáticamente un cuadro de diálogo para continuar con el asistente..\n\n\
		>> Presione 'Aceptar' para hacer las cosas antes dichas. 'Atras' para hacer algun cambio.", "Aceptar", "Atras");

		case 905: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, CreateCaption("Crear nueva carrera (Paso 4/4)"),
		"\
		Paso 4:\n\
		********\n\
		Bienvenido al ultimo paso. En este definiremos los Checkpoints; Si hace click en 'Aceptar' podra comenzar a definir los Checkpoint's.\n\
		Puedes definir los Checkpoint's con el Boton de disparo. Cada Checkpoint que establezca, quedara guardado.\n\
		Tienes que presionar el boton 'ENTER' cuando hayas terminado con todo. ¡Tu carrera estara lista!\n\n\
		>> Presiona 'Aceptar' para hacer las cosas antes dichas. 'Atras' para hacer algun cambio.", "Aceptar", "Atras");
		
		case 906: ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, CreateCaption("Crear nueva carrera (Hecho)"),
		"\
		Has creado tu carrera exitosamente, y esta lista para usarse.\n\n\
		>> Presiona 'Finalizar' para finalizar. 'Salir' - No tiene efecto.", "Finalizar", "Salir");
	}
	return 1;
}
//CHEQUEO DE SI SE ESTÁ EN CARRERA (DUPLICADO) REVISAR BIEN
JB_PUBLIC check_race(playerid)
{
   return Joined[playerid];
}

//CREADOR DE ¿? REVISAR FUNCIONALIDAD
JB_Function:CreateCaption(arguments[])
{
	new
	    string[128 char]
	;
	format(string, sizeof(string), "RyDeR's Race System - %s", arguments);
	return string;
}
//CHEQUEO DE VEHICULOSID VALIDOS
JB_Function:IsValidVehicle(vehicleid)
{
	if(vehicleid < 400 || vehicleid > 611) return false;
	    else return true;
}
//¿? REVISAR FUNCIONALIDAD
JB_Function:ReturnVehicleID(vName[])
{
	Loop(x, 211)
	{
	    if(strfind(vNames[x], vName, true) != -1)
		return x + 400;
	}
	return -1;
}
//CONVERTIDOR DE SEC, MIN AND HOURS
JB_Function:TimeConvert(seconds)
{
	new tmp[16];
 	new minutes = floatround(seconds/60);
  	
  	seconds -= minutes*60;
   	
   	format(tmp, sizeof(tmp), "%d:%02d", minutes, seconds);
   	return tmp;
}

JB_Function:pName(playerid)
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, sizeof(pname));
	return pname;
}

