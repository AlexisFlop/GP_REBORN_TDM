/*====================================== Jake's Admin Sistema; versión 3.5================================
                                          última actualización: 21/08/17
    Creditos:
            » Jake Cipher
            » Zeex
            » DracoBlue
            » Y_Less
            » Dordzy 
            » Ultraz
            » DenNorske

            » Cesar Smith
            » Nobody[x]G
            » pablobl[X]
            » Jefferson
            » AlexisFlop

            NOTA: Editado, optimizado y modificado, por Pablo, AlexisFlop y Jefferson a partir de: 23/03/2019

                                                                                            GP 2017 - 2020 ©                                                                     */
//==========================================================================================================
//USO DESCONOCIDO
native WP_Hash(buffer[], len, const str[]);
native IsValidVehicle(vehicleid);
//LIBRERÍAS
#include <crashdetect>
#include <JunkBuster>
#include <dini>
#include <zcmd>
//#include <Pawn.CMD>
#include <sscanf2>
#include <streamer>
#include <GetVehicleColor>
#include <foreach>
#include <formatex>
#include <jadmin3>
#include <a_actor>
#include <OPRL>
//USO DESCONOCIDO
#pragma dynamic 2934092
//SISTEMA DE AUTOS - PRECIOS
#define SANDKING_PRICE        5500000
#define PATRIOT_PRICE         5300000
#define NRG_PRICE             4500000
#define SANCHEZ_PRICE         4200000
#define INFERNUS_PRICE        3950000
#define TURISMO_PRICE         3800000
#define CHEETAH_PRICE         3550000
#define SUPERGT_PRICE         3300000
#define BULLET_PRICE          3000000
#define COMET_PRICE           2800000
#define BANSHEE_PRICE         2500000
#define SULTAN_PRICE          2300000
#define ELEGY_PRICE           2000000
#define JESTER_PRICE          1950000
#define HUSTLER_PRICE         1800000
#define HUNTLEY_PRICE         1700000
#define SLAMVAN_PRICE         1650000
#define YOSEMITE_PRICE        1600000
#define BUFFALO_PRICE         1400000
#define RANCHER_PRICE         1200000
#define BLADE_PRICE           980000
#define MESv_price            950000
#define PHOENIX_PRICE         900000
#define ZR350_PRICE           850000
#define WINDSOR_PRICE         750000
#define TAMPv_price           700000
#define STALLION_PRICE        670000
#define SABRE_PRICE           650000
#define BROADWAY_PRICE        600000
#define TORNADO_PRICE         550000
#define REMING_PRICE          900000
#define HOTKNIFE_PRICE        450000
#define TAHOMv_price          400000
#define BLISTv_price          350000
#define CLUB_PRICE            320000
#define FLASH_PRICE           290000
#define PRIMO_PRICE           270000
#define CADRONv_price         220000
#define FORTUNE_PRICE         210000
#define HERMES_PRICE          190000
#define SWEEPER_PRICE         125000
//CLASIFICADO DE RANGOS ADM POR COLOR
#define COLOR_RANK1           "{2E9AFE}"
#define COLOR_RANK2           "{2ECCFA}"
#define COLOR_RANK3           "{2EFEF7}"
#define COLOR_RANK4           "{2EFE9A}"
#define COLOR_RANK5           "{2EFE2E}"
#define COLOR_RANK6           "{9AFE2E}"
#define COLOR_RANK7           "{F7FE2E}"
#define COLOR_RANK8           "{FE9A2E}"
#define COLOR_RANK9           "{FE642E}"
#define COLOR_RANK10          "{FE2E2E}"
//COLOR RANGO PING
#define COLOR_PING_A          "{BFFF00}"
#define COLOR_PING_B          "{D7DF01}"
#define COLOR_PING_C          "{FFBF00}"
#define COLOR_PING_D          "{FAAC58}"
#define COLOR_PING_E          "{FE2E2E}"
//LÍMITE DE CLANES
#define MAX_CLANES            100
//COLORES...
//NOTA Y PROPUESTA: CREAR UN INCLUDE CUYA FUNCIÓN SEA ALMACENAR TODOS LOS COLORES DE NUESTROS FS, DE MANERA QUE SE PUEDA DAR MULTIUSO DESDE
//CUALQUIER LUGAR Y AHORRAMOS LÍNEAS DE CÓDIGO.
//HTLM
#define white                 "{FFFFFF}"
#define lightblue             "{00EEFA}"
#define grey                  "{AFAFAF}"
#define orange                "{FF6838}"
#define black                 "{2C2727}"
#define red                   "{FF0000}"
#define yellow                "{FCBC3C}"
#define green                 "{56BE4A}"
#define blue                  "{3B69FA}"
#define purple                "{8E1CFF}"
#define pink                  "{FF50FF}"
#define brown                 "{A52A2A}"
#define help                  "{D8BFD8}"
#define vip1_color            "{BDBDBD}"
#define vip2_color            "{FFFF33}"
//HEXADECÍMALES
#define COLOR_RED             0xC80000FF
#define COLOR_YELLOW          0xFCBC3CFF
#define COLOR_GREEN           0x56BE4AFF
#define COLOR_ORANGE          0xFF6838FF
#define COLOR_WHITE           0xFFFFFFFF
#define COLOR_PURPLE          0x8E1CFFFF
#define COLOR_LIGHTGREEN      0x13FFA0FF
#define COLOR_PINK            0xFF50FFFF
#define COLOR_LIGHTBLUE       0x00EEFAFF
#define COLOR_GREY            0xAFAFAFAA
#define COLOR_BLUE            0x3B69FAFF
#define COLOR_BROWN           0xA52A2AAA
#define COLOR_BLACK           0x2C2727AA
#define COLOR_CLAN            0xE4E4EAFF
//RUTA DE LA CARPETA QUE CONTIENE LAS BASES DE DATOS
#define JB_FOLDER             "JakAdmin3/juser.db"
//RUTA DE LOGS
#define LOG_FOLDER             "Logs/"
//VERSION DEL SCRIPT ¿? BORRAR
#define VERSION               "3.5"
//TIPO DE SPEC
#define SPEC_TYPE_NONE        0
#define SPEC_TYPE_PLAYER      1
#define SPEC_TYPE_VEHICLE     2
//OCULTO
#define reborn                true
//SCORE DE JUGADORES NUEVOS REVISAR USO
#define STARTING_SCORE        1
//DINERO DE JUGADORES NUEVOS
#define STARTING_CASH         2500
//INTENTOS MÁXIMOS DE CONTRASEÑA RCON
#define MAX_RCON_WARNINGS     4
//OCULTO X2
#if !defined reborn
#define reborn false
#endif
#define REGISTER_DIALOG       true
//RCON PROTECTED
#define RconProtect           true
//SISTEMA VIP
#define VipSystem             true
//MÁXIMOS INTENTOS DE SPAM
#define SPAM_MAX_MSGS         6 
//¿?
#define SPAM_TIMELIMIT        8 
//PROTECTED RCON
#if RconProtect == true
    //CONTRASEÑA DE LA SEGUNDA RCON.
    
#define RconPass              "Reborn196535"

#endif

#if reborn == true
//ID DE DIÁLOGOS
#define DIALOG_BEGIN          1000
#define DIALOG_REGISTER       1001
#define DIALOG_LOGIN          1002
#define DIALOG_COLORS         1003
#define DIALOG_RCON           1004
#define DIALOG_QUESTION       1005
#define DIALOG_ANSWER         1006
#define DIALOG_FORGET         1007
#define DIALOG_WOULDYOU       1008
#define DIALOG_SETTINGS       1009
#define DIALOGLOG_FOLDERTRIES 1010
#define DIALOG_SEC_TRIES      1011
#define DIALOG_PING           1012
#define DIALOG_PING_WARN      1013
#define DIALOG_QUESTION2      1014
#define DIALOG_ANSWER2        1015
#define DIALOG_RANKS          1016
#define DIALOG_EDIT_ADMIN_1   1017
#define DIALOG_EDIT_ADMIN_2   1018
#define DIALOG_EDIT_ADMIN_3   1019
#define DIALOG_EDIT_ADMIN_4   1020
#define DIALOG_EDIT_ADMIN_5   1021
#define DIALOG_EDIT_ADMIN_6   1022
#define DIALOG_EDIT_ADMIN_7   1023
#define DIALOG_EDIT_ADMIN_8   1024
#define DIALOG_EDIT_ADMIN_9   1025
#define DIALOG_EDIT_ADMIN_10  1026

#define DIALOG_EDIT_VIP_1     1027
#define DIALOG_EDIT_VIP_2     1028
#define DIALOG_PUNISHMENT     1029
#define DIALOG_REASON         1030
#define TOP_DIALOG            1031
#define DUELO_DIALOG          1032
#define DUELO_DIALOG_1        1033
#define DUELO_DIALOG_2        1034
#define DUELO_DIALOG_3        1035
#define DUELO_DIALOG_4        1036
#define DUELO_DIALOG_5        1037
#define DIALOG_INTERIORES     1038
#define DIALOG_INTERIORES2    1039
#define DIALOG_AUTOS          1040
#define DIALOG_CCOLOR         1041
#define DIALOG_BANLIST        1042
#define RACES_DIALOG          1043
#define DIALOG_1              1044
#define DIALOG_2              1045
#define DIALOG_3              1046
#define DIALOG_4              1047
#define DIALOG_5              1048
#define DIALOG_6              1049
#define DIALOG_FAIL           1050

#define MAX_REPORTS           30
//PARA CALLBACKS NO NATIVOS
#define JB_PUBLIC%0(%1)       forward %0(%1);\
                                  public %0(%1)
//PARA STOCKS
#define JB_Function:%0(%1)    stock %0(%1)
//SYNCRONIZADO DE POSICIÓN
#define ResetPlayerPos(%0);   SetPlayerInterior(%0, 0);\
                                  SetPlayerVirtualWorld(%0, 0);
//CHEQUEO DE NIVEL ADM
new st[90];
#define LevelCheck(%0,%1);\
                              if(playerLogued[playerid] == false)\
                                  return 0;\
                              if(User[(%0)][accountAdmin] == 0)\
                                  return 0;\
                              if(User[(%0)][accountAdmin] < %1) \
                                  return format(st, 90, "[ERROR] Debes ser nivel %d para usar este comando.", (%1)),\
                              SendClientMessage((%0), COLOR_RED, st);

//TECLAS PRESIONADAS (USO DESCONOCIDO)
#define PRESSED(%0)           (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
//CONSULTAR USO Y LUEGO ESCRIBIR AQUÍ
#define strcpy(%0,%1,%2)      strcat((%0[0] = '\0', %0), %1, %2)
//CHEQUEO DE NIVEL VIP
#if VipSystem == true

#define VipCheck(%0,%1); \
                              if(accountVip[(%0)] < %1)\
                                  return format(st, 90, "[ERROR] Debes ser VIP %d para usar este comando.", (%1)),\
                                      SendClientMessage((%0), COLOR_RED, st);
#endif    
//CONVERTOR SEC/MIN/HOUR
#define sec(%0)               (1000 * %0)
#define min(%0)               (1000 * %0 * 60) 
#define hour(%0)              (1000 * %0 * 60 * 60)
//CONFIGURACIÓN DEL SERVIDOR - ASIGNACIÓN DE DATOS
enum ServerData
{
    RegisterOption,
    LoginWarn,
    SecureWarn,
    SaveLogs,
    AutoLogin,
    ReadCmds,
    ReadCmd, // Type 0 - Default (OLD), 1 - Spectate Players
    MaxPing,
    AntiSwear,
    AntiName,
    AntiAd,
    AntiSpam,
    MaxPingWarn,
    #if VipSystem == true
        VipRank1[256],
        VipRank2[256],
    #endif
    AdminRank1[64],
    AdminRank2[64],
    AdminRank3[64],
    AdminRank4[64],
    AdminRank5[64],
    AdminRank6[64],
    AdminRank7[64],
    AdminRank8[64],
    AdminRank9[64],
    AdminRank10[64],
};
//CUENTA DEL CLIENTE - ASIGNACIÓN DE DATOS
enum PlayerInfo
{
    accountID,
    accountJump,
    accountChocolate,
    accountName[24],
    accountIP[20],
    accountQuestion[129],
    accountAnswer[129],
    accountPassword[64],
    accountMarker,
    accountUseSkin,
    accountSkin,
    accountDuelosg,
    accountDuelosp,
    accountAdmin,
    accountAdminEx,
    accountTemporary,
    accountKills,
    accountDeaths,
    accountLogged,
    //accountClan,
    //accountRango,
    accountRacha,
    WarnLog,
    accountDate[150],
    accountWarn,
    accountMuted,
    accountMuteSec,
    accountCMuted,
    accountCMuteSec,
    accountJail,
    accountJailSec,
    SpecID,
    SpecType,
    pCar,
    accountGame[3],
    accountGameEx,
    pDuty,
    SpamCount,
    SpamTime
};
//MENSAJES PRIVADOS - ASIGNACIÓN
enum PMInfo
{
    LastPM,
    NoPM
};
//REPORTES - ASIGNACIÓN DE DATOS
enum ReportInfo
{
    bool:reportTaken,
    reporterID,
    reportedID,
    reportReason[64],
    reportTime[32],
    reportAccepted
};
//SISTEMA DE CLANES - ASIGNACIÓN DE DATOS
/*
enum Clan
{
    CLAN_ID,
    CLAN_TAG[7],
    CLAN_SLOGAN[41],
    CLAN_COLOR,
    CLAN_MIEMBROS,
    CLAN_ASESINATOS,
    CLAN_MUERTES,
    CLAN_LIDER[22],
    CLAN_FECHA[12]
};*/
//SISTEMA DE AUTOS - ASIGNACIÓN DE DATOS
enum ownvehicle_info
{
    v_id,
    v_model,
    v_price,
    v_color1,
    v_color2,
    v_vinyl,
    Float:v_x,
    Float:v_y,
    Float:v_z,
    Float:v_angle,
    a_aleron,
    a_ven_techo,
    a_techo,
    a_laterales,
    a_luces,
    a_nitro,
    a_escape,
    a_ruedas,
    a_puertas,
    a_hidraulica,
    a_par_delantero,
    a_par_trasero,
    a_ven_derecha,
    a_ven_izquierda
};
//DUELOS - ASIGNACIÓN DE DATOS
enum duelo_info
{
    d_arena,
    d_armas,
    d_apuesta,
    d_desafiado,
    d_id,
    d_conteo,
    d_tiempoa,
    d_tiempob,
    bool: d_invitaciones,
    bool: d_enduelo
};
//Configurado del servidor en .ini
new 
    ServerInfo[ServerData],
    bool:ServerLocked,
    BadNames[100][100],
    BadNameCount = 0,
    ForbiddenWords[100][100],
    ForbiddenWordCount = 0;
//Datos del cliente/usuario
new 
    User[MAX_PLAYERS][PlayerInfo],
    DB:DB_USERS,
    Text:StatsTD[MAX_PLAYERS];
//USO DESCONOCIDO
#if VipSystem == true
    new 
        accountVip[MAX_PLAYERS],
        vipsys,
        bool:vweaps[MAX_PLAYERS],
        bool:VipCarRepaired[MAX_PLAYERS],
        bool:vipMessage[MAX_PLAYERS],
        TimeRepair[MAX_PLAYERS] = 30;
#endif
//USO DESCONOCIDO
#if RconProtect == true
    
    new 
        bool:_RCON[MAX_PLAYERS], 
        _RCONwarn[MAX_PLAYERS];

#endif
new    
    VoteKickReason[64],
    VoteKickTarget = INVALID_PLAYER_ID,
    VoteKickHappening = 0,
    bool:HasAlreadyVoted[MAX_PLAYERS char],
    MaxVKICK = 2,
    KickTime = 60,
    svotes = 0,
    avotes = 0,
    VoteTimer,
    rInfo[MAX_PLAYERS][ReportInfo];      
//SISTEMA DE CLANES - DATOS
/*
new 
    DB:DB_CLANS,
    countClans = 0,
    Clans[MAX_CLANES][Clan],
    playerClan[MAX_PLAYERS][7],
    clan_slogan[MAX_PLAYERS][42],
    clan_color[MAX_PLAYERS];
//COLORES DEL CHATCLAN
new ccolor[45][] = {
    {"FFFFFF"},
    {"EAEAEA"},
    {"B6B6B6"},
    {"858585"},
    {"9DB4B2"},
    {"8889AE"},
    {"A488AE"},
    {"E56DD1"},
    {"D433B2"},
    {"A51F89"},
    {"FF008F"},
    {"B063DC"},
    {"9B1EE3"},
    {"7B19F1"},
    {"4900FF"},
    {"020DFE"},
    {"42A6EA"},
    {"0077FE"},
    {"0161CD"},
    {"71CAEC"},
    {"00B9FF"},
    {"0187BA"},
    {"00ECFF"},
    {"02B9C8"},
    {"00FFE0"},
    {"00B19C"},
    {"ABEEA2"},
    {"579E4E"},
    {"119300"},
    {"17C800"},
    {"00FF00"},
    {"AEFF00"},
    {"FCE15D"},
    {"B07500"},
    {"FFF300"},
    {"FF9700"},
    {"FF5900"},
    {"FF3A00"},
    {"FF0032"},
    {"FF0017"},
    {"FF0000"},
    {"B00000"},
    {"AC7878"},
    {"905947"},
    {"B68D71"}
};*/
//NOMBRES DE VEHICULOS
new VehicleNames[212][] = {
    {"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},
    {"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},
    {"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},{"Washington"},
    {"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Hunter"},{"Premier"},{"Enforcer"},{"Securicar"},
    {"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},
    {"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},
    {"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},
    {"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},
    {"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
    {"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},
    {"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},
    {"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
    {"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},
    {"Mesa"},{"RC Goblin"},{"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},
    {"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},
    {"Tanker"}, {"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},
    {"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},
    {"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},
    {"Blade"},{"Freight"},{"Streak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},
    {"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
    {"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},
    {"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},
    {"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},
    {"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},
    {"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},
    {"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},
    {"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},{"Alpha"},{"Phoenix"},{"Glendale"},
    {"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},
    {"Utility Trailer"}
};
//DUELO - INFORMACIÓN Y CONFIG
new 
    Duel[MAX_PLAYERS][duelo_info],
    managerDuel,
    timerDuel[MAX_PLAYERS];
    //jugador_invitado[MAX_PLAYERS];
//SISTEMA DE AUTOS - BASE DE DATOS 
new 
    DB: DB_VEHICLES,
    bool:foundVehicle[MAX_PLAYERS],
    vehicleOwner[MAX_PLAYERS],
    personalVehicles[MAX_PLAYERS][ownvehicle_info],
    bool:VehicleClosed[MAX_PLAYERS];
//unknown
new 
    firstspawn[MAX_PLAYERS],
    bool:playerLogued[MAX_PLAYERS],
    godPlayer[MAX_PLAYERS],
    rachax[MAX_PLAYERS],
    pInfo[MAX_PLAYERS][PMInfo],
    fake_kill[MAX_PLAYERS],
    pSpawned[MAX_PLAYERS];
//USO DESCONOCIDO    
new 
    SpecInt[MAX_PLAYERS][2],
    Float:SpecPos[MAX_PLAYERS][4];
//CONTADOR DEL CMD /CONTEO
new 
    countDisplay = 5;
//none
/*new 
    hourLogin,
    MinuteLogin,
    secondLogin,
    hourLeft.
    minuteLeft,
    secondLeft;*/
//CALLBACKS NATIVOS
public OnFilterScriptInit()
{
    print("\n[FILTERSCRIPT] Admin loading...");
    //ACCESO A INTERIORES(DESACTIVADO)
    DisableInteriorEnterExits();

    new
        day,
        month,
        year,
        hour,
        sec,
        mins,
        result = GetTickCount();

    getdate(year, month, day);
    gettime(hour, mins, sec);

    managerDuel = 0;

    format(VoteKickReason, sizeof(VoteKickReason), "N/D");
    
    VoteKickHappening = 0;
    avotes = 0;
    svotes = 0;
    VoteKickTarget = INVALID_PLAYER_ID;
   
	//RESETEO DE VOTEKICK
    foreach(new i : Player)
    {
        HasAlreadyVoted{i} = false;
    }

    for(new i; i < MAX_REPORTS; i++)
    {
        ResetReport(i);
    }
    //CARGADO DE BASE DE DATOS
    DB_VEHICLES = db_open("Autos.db");
    
    new 
        v[962];
    //CARGADO DE BASE DE DATOS DE AUTOS
    strcat(v, "CREATE TABLE IF NOT EXISTS `Autos` (");
    strcat(v, "`Autoid` INTEGER PRIMARY KEY AUTOINCREMENT,");
    strcat(v, "`Propietario` VARCHAR(22) NOT NULL,");
    strcat(v, "`Modelo` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Precio` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Color1` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Color2` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Vinilo` INTEGER NOT NULL DEFAULT 255,");
    strcat(v, "`v_x` REAL NOT NULL DEFAULT 0.0,");
    strcat(v, "`v_y` REAL NOT NULL DEFAULT 0.0,");
    strcat(v, "`v_z` REAL NOT NULL DEFAULT 0.0,");
    strcat(v, "`v_angle` REAL NOT NULL DEFAULT 0.0,");
    strcat(v, "`Aleron` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Ven_techo` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Techo` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Laterales` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Luces` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Nitro` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Escape` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Ruedas` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Puertas` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Hidraulica` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Par_delantero` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Par_trasero` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Ven_derecha` INTEGER NOT NULL DEFAULT 0,");
    strcat(v, "`Ven_izquierda` INTEGER NOT NULL DEFAULT 0)");
    db_query(DB_VEHICLES, v);

	//CARGADO DE BASE DE DATOS DE CLANES
    //DB_CLANS = db_open("Clanes.db");
    
    /*new
        cl[310];

    strcat(cl, "CREATE TABLE IF NOT EXISTS `Clanes` (");
    strcat(cl, "`ClanID`INTEGER PRIMARY KEY AUTOINCREMENT,");
    strcat(cl, "`Tag` VARCHAR(7) NOT NULL,");
    strcat(cl, "`Slogan` VARCHAR(41) NOT NULL,");
    strcat(cl, "`Color` INTEGER NOT NULL,");
    strcat(cl, "`Miembros` INTEGER NOT NULL,");
    strcat(cl, "`Asesinatos` INTEGER NOT NULL,");
    strcat(cl, "`Muertes` INTEGER NOT NULL,");
    strcat(cl, "`Lider` VARCHAR(22) NOT NULL,");
    strcat(cl, "`Fecha` VARCHAR(12) NOT NULL)");
    db_query(DB_CLANS, cl);
    LoadClanesDB();
	*/
    //CARPETA DE CONFIGURACIONES DEL SERVIDOR - CARGADO
    checkfolder();

    if(checkfolderEx())
    {
        printf("\nJak[ADMIN] %s (c), Copyright - 2017", VERSION);
        print("\n");

        //BASE DE DATOS DE LOS USUARIOS
        LoadUsersDB();

		printf("[JakAdmin3] Duration: %i ms", (GetTickCount() - result));
        printf("[JakAdmin3] Date: %02i/%02i/%02i | Time: %02d:%02d:%02d", day, month, year, hour, mins, sec);

		Config();

		SetTimer("GamePlay", 1000, true);
        SetTimer("PunishmentHandle", 1000, true);

        foreach(new i : Player)
        {
            OnPlayerConnect(i);
        }
    }
    return 1;
}

public OnFilterScriptExit()
{
	//GUARDADO DE DATOS EN CASO DE CRASHEOS
    for(new i=0;i<MAX_PLAYERS; i++)
    {
    	SavePosVehicle(i);
    	SaveModVehicle(i);
    }
    //TIEMPO ONLINE, DETENIDO
    //KillTimer("GamePlay");
    //CERRADO DE BASE DATOS
	//db_close(DB_CLANS);
    db_close(DB_VEHICLES);
    CloseUsersDB();
	//RESETEO DE REPORTES
    for(new c; c < MAX_REPORTS; c++)
    {
        ResetReport(c);
    }
	//BORRADO DE VEHICULOS EN CASO DE CRASHEOS
    foreach(new i : Player)
    {
        if(IsValidVehicle(User[i][pCar]))
        {
            DestroyVehicle(User[i][pCar]);
        }
        OnPlayerDisconnect(i, 1);
        User[i][accountLogged] = 0;
    }
    //CARGADO COMPLETO DE FS
    print("[FILTERSCRIPTS] Admin loaded\n");
	return 1;
}

public OnPlayerConnect(playerid)
{   
    pSpawned[playerid] = 0;
    ResetPlayerData(playerid);
    CheckPlayerIps(playerid);
    

	//GUARDADO DE AKA(IP)
    if(strlen(dini_Get("Logs/aka.txt", GetIP(playerid))) == 0)
    {
		dini_Set("Logs/aka.txt", GetIP(playerid), pName(playerid));
	}
	else if(strfind(dini_Get("Logs/aka.txt", GetIP(playerid)), pName(playerid), true) == -1 )
    {
        new 
            str[64];

        format(str, sizeof(str),"%s,%s", dini_Get("Logs/aka.txt", GetIP(playerid)), pName(playerid));
        dini_Set("Logs/aka.txt", GetIP(playerid), str);
    }

	new
        bQuery[128],
        reason[15],
        admin[24],
        when[32],
        DBResult:jResult,
        Query[128],
        DBResult: Result,
        //fIP[20],
		string[128];
	//ANTI NOMBRES PROHIBIDOS
    if(ServerInfo[AntiName])
    {
        for(new s=0; s<BadNameCount; s++)
        {
            if(!strcmp(BadNames[s], pName(playerid), true))
            {
                format(string, sizeof string, "[KICK] %s[ID:%d] ha sido expulsado por GP.SEC (Forbidden Name)", pName(playerid), playerid);
                SendClientMessageToAll(COLOR_GREY, string);
                printf(string);
                SaveLog("kick.txt", string);
                Kick(playerid);
                return 1;
            }
        }
    }

    GetPlayerName(playerid, User[playerid][accountName], MAX_PLAYER_NAME);
    GetPlayerIp(playerid, User[playerid][accountIP], 15);

	//CARGADO DE IP´S
	new 
        ip_month, 
        ip_day, 
        ip_year, 
        ip_hour, 
        ip_minute, 
        ip_second;
    
    getdate(ip_year, ip_month, ip_day);
    gettime(ip_hour, ip_minute, ip_second);
    
    format(bQuery, sizeof(bQuery), 
        "SELECT * FROM `ips` WHERE `username` = '%s' AND `ip` = '%s'", DB_Escape(pName(playerid)), DB_Escape(User[playerid][accountIP]));
    
    jResult = db_query(DB_USERS, bQuery);


	if(!db_num_rows(jResult))
    {
        format(bQuery, sizeof(bQuery), 
            "INSERT INTO `ips` (`username`, `ip`, `date`, `time`) VALUES('%s', '%s', '%02d-%02d-%d', '%02d:%02d:%02d')", 
                DB_Escape(pName(playerid)), DB_Escape(User[playerid][accountIP]), ip_month, ip_day, ip_year, ip_hour, ip_minute, ip_second);
        
        db_query(DB_USERS, bQuery);
    }

	else
    {
        format(bQuery, sizeof(bQuery), "DELETE FROM `ips` WHERE `ip` = '%s'", DB_Escape(User[playerid][accountIP]));
        db_query(DB_USERS, bQuery);

        format(bQuery, sizeof(bQuery), 
            "INSERT INTO `ips` (`username`, `ip`, `date`, `time`) VALUES('%s', '%s', '%02d-%02d-%d', '%02d:%02d:%02d')", 
                DB_Escape(pName(playerid)), DB_Escape(User[playerid][accountIP]), ip_month, ip_day, ip_year, ip_hour, ip_minute, ip_second);
        
        db_query(DB_USERS, bQuery);
    }

	//EXPULSIÓN DE IP´S BANEADAS
    format(bQuery, sizeof(bQuery), "SELECT * FROM `bans` WHERE `username` = '%s'", DB_Escape(pName(playerid)));
    jResult = db_query(DB_USERS, bQuery);

    if(db_num_rows(jResult) && CheckBan(User[playerid][accountIP]))
    {
        SetPVarInt(playerid, "ban_id", db_get_field_assoc_int(jResult, "banid"));
        db_get_field_assoc(jResult, "banwhen", when, sizeof(when));
        db_get_field_assoc(jResult, "banby", admin, sizeof(admin));
        db_get_field_assoc(jResult, "banreason", reason, sizeof(reason));

        ShowBan(playerid, GetPVarInt(playerid, "ban_id"), when, admin, reason);

        Kick(playerid);
        return 1;
    }

	else if(db_num_rows(jResult) && !CheckBan(User[playerid][accountIP]))
	{
		SetPVarInt(playerid, "ban_id", db_get_field_assoc_int(jResult, "banid"));
 		db_get_field_assoc(jResult, "banwhen", when, sizeof(when));
  		db_get_field_assoc(jResult, "banby", admin, sizeof(admin));
   		db_get_field_assoc(jResult, "banreason", reason, sizeof(reason));

		ShowBan(playerid, GetPVarInt(playerid, "ban_id"), when, admin, reason);

		Kick(playerid);
		
		return 1;
    }

	else if(!db_num_rows(jResult) && CheckBan(User[playerid][accountIP]))
    {
        SendClientMessage(playerid, COLOR_RED, "[INFO] Tu IP se encuentra baneada del servidor.");
        BanAccount(playerid, "GP.SEC", "IP Prohibida");

        Kick(playerid);
        return 1;
    }
    
    db_free_result(jResult);

    //CARGADO DE CLAVES
    if(ServerInfo[AutoLogin])
    {
        format(Query, sizeof(Query), 
            "SELECT `password`, `question`, `answer`, `IP` FROM `users` WHERE `username` = '%s'",  DB_Escape(User[playerid][accountName]));
        
        Result = db_query(DB_USERS, Query);
    }

	//CARGADO DE PREGUNTA DE SEGURIDAD
	else
    {
        format(Query, sizeof(Query), 
            "SELECT `password`, `question`, `answer` FROM `users` WHERE `username` = '%s'", DB_Escape(User[playerid][accountName]));
        
        Result = db_query(DB_USERS, Query);
    }
    
    //LOGUEOS
    if(db_num_rows(Result))
	{

		db_get_field_assoc(Result, "password", User[playerid][accountPassword], 129);
        db_get_field_assoc(Result, "question", User[playerid][accountQuestion], 129);
        db_get_field_assoc(Result, "answer", User[playerid][accountAnswer], 129);

		if(strcmp(User[playerid][accountQuestion], "none", true) == 0)
   		{
            User[playerid][accountWarn] = 0;
      		new m[250*3];
        	strcat(m, ""red"Bienvenido a Guerra de pandillas reborn.\n\n");
         	strcat(m, ""white"Tu cuenta está en nuestra base de datos, escribe tu contraseña para ingresar.\n");
            strcat(m, ""red"Importante: "white"Si no eres el propietario de esta cuenta, sal del juego, y escribe tu nick para volver a ingresar.\n");
            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Ingreso", m, "Ingresar", "Salir");
            printf("advertencias, conectado: %d", User[playerid][WarnLog]);
        }
    }
	//REGISTRO DE NUEVOS USUARIOS
    else
    {
  	    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, ""red"Registro", ""red"Bienvenido a "white"Guerra de Pandillas\n"grey"Tu cuenta no está registrada en nuestra base de datos. \nIngresa una contraseña para registrarte.", "Registro", "Salir");
	    print("funcion 2");
    }
	db_free_result(Result);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	//RESETEO DE DATOS

	if(personalVehicles[playerid][v_id] != -1)
    {
    	SavePosVehicle(playerid);
    	SaveModVehicle(playerid);
    	RemoveCar(playerid);
    } 

	EndPlayerDuel(playerid);
    //KillTimer(timer_dinero[playerid]);
    new string[128];

    if(User[playerid][accountTemporary])
    {
        User[playerid][accountAdmin]     = 0;
        User[playerid][accountAdminEx]   = 0;
        User[playerid][accountTemporary] = false;
    }

	//RESETEO DE REPORTES
    for(new c; c < MAX_REPORTS; c++)
    {
        if(rInfo[c][reportTaken])
        {
            if(rInfo[c][reporterID] == playerid || rInfo[c][reportedID] == playerid)
            {
                ResetReport(c);
            }
        }
    }


    for(new x=0; x<MAX_PLAYERS; x++)
    {
        if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] == playerid)
        {
            AdvanceSpectate(x);
        }
    }

    if(IsValidVehicle(User[playerid][pCar]))
    {
		EraseVeh(User[playerid][pCar]);
	}

    if(VoteKickHappening && VoteKickTarget == playerid)
    {
        format(string, sizeof(string), "[INFO] %s ha salido del servidor mientras era nominado por el VoteKick.", pName(playerid));
        SendClientMessageToAll(COLOR_GREY, string);

		format(VoteKickReason, sizeof(VoteKickReason), "N/D");
        VoteKickHappening = 0;
        avotes = 0;
        svotes = 0;
        VoteKickTarget = INVALID_PLAYER_ID;
        KillTimer(VoteTimer);

        foreach(new i : Player)
        {
            HasAlreadyVoted{i} = false;
        }
    }

    User[playerid][accountGameEx] = 0;
    return 1;
}


public OnVehicleMod(playerid,vehicleid,componentid)
{
	//GUARDADO DE MOD´S AUTOS
    if(vehicleid == vehicleOwner[playerid])
    {
    	SaveModVehicle(playerid);
    }
    return 1;
}


public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	//GUARDADO DE MOD´S AUTOS
    if(IsPlayerInVehicle(playerid, vehicleOwner[playerid]))
    {
    	SaveModVehicle(playerid);
    }
    return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    new 
        string[128]
    ;
    
    if(IsPlayerInVehicle(playerid, vehicleOwner[playerid]))
    {
        //ACTUALIZADO DE DATOS AUTOS
	    personalVehicles[playerid][v_vinyl] = paintjobid;
	    format(string, sizeof(string), 
            "UPDATE `Autos` SET `Vinilo`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][v_vinyl], DB_Escape(pName(playerid)));
	    
        db_free_result(db_query(DB_VEHICLES, string));
	    SaveModVehicle(playerid);
    }
    return 1;
}

public OnPlayerSpawn(playerid)
{
    pSpawned[playerid] = 1;

    SetPlayerTime(playerid, 12, 0);
    SetPlayerWeather(playerid, 36);
    vweaps[playerid] = false;
	//CARGADO DE DATOS AL SPAWNEAR
    if(firstspawn[playerid] == 0)
    {
	    StopAudioStreamForPlayer(playerid);
	    JBC_TogglePlayerControllable(playerid, 0);
	    SetTimerEx("OnPlayerIsUnfreezed", 7000, false, "d", playerid);
	    SetTimerEx("OnPlayerLogued", 7000, false, "d", playerid);
	    SetTimerEx("OnPlayerChocolateChange", 1000, true, "d", playerid);
	    GameTextForPlayer(playerid, "~r~Cargando el juego...~r~", 5000, 4);
	    LoadModVehicle(playerid);
	    SendLastParking(playerid);
	    TextDrawShowForPlayer(playerid,StatsTD[playerid]);
    }
    if(User[playerid][accountJail])
    {
        SetTimerEx("JailPlayer", 2000, 0, "d", playerid);
        JBC_ResetPlayerWeapons(playerid);
    }

	//CARGADO DE SKIN
    if(User[playerid][accountUseSkin])
    {
		//SKIN PARA VIP´S
        #if VipSystem == true
            if(!User[playerid][accountAdmin] && accountVip[playerid])
                JBC_SetPlayerSkin(playerid, User[playerid][accountSkin]);
        #endif
		//SKIN PARA ADMINS
        if(User[playerid][accountAdmin] > 3)
            JBC_SetPlayerSkin(playerid, User[playerid][accountSkin]);
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    new 
        Float:hp, 
        Float:armour
    ;
    
    GetPlayerHealth(playerid, hp);
    GetPlayerArmour(playerid, armour);

	//MOOD ONDUTY
    if(User[playerid][pDuty])
    {
        amount = 0.0;
        if(armour >= 1)
        {
            JBC_SetPlayerArmour(playerid, armour - amount);
        }
        JBC_SetPlayerHealth(playerid, 150.0);
    }
    return 1;
}


public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    new Float:hp, Float:armour;
    GetPlayerHealth(damagedid, hp);
    GetPlayerArmour(damagedid, armour);

	//RECUPERAR EN ONDUTY MOOD
    if(User[damagedid][pDuty])
    {
        amount = 0.0;
        if(armour >= 1)
        {
            JBC_SetPlayerArmour(damagedid, armour - amount);
        }
        JBC_SetPlayerHealth(damagedid, 150);
    }
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    pSpawned[playerid] = 0;
    //PASO AL SIGUIENTE SPEC
    for(new x=0; x<MAX_PLAYERS; x++)
    {
    	if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] == playerid)
    	{
    		AdvanceSpectate(x);
    	}
    }

	//CONTADOR DE MUERTES
    User[playerid][accountDeaths]++;
    ActPlayerData(playerid,"deaths");

	//ANTI FAKEKILLS
    fake_kill[playerid]++;
    SetTimerEx("OnFakeKillDetected", 1000,false,"i",playerid);

	//SISTEMA DE DUELOS
    if(Duel[playerid][d_enduelo] == true && Duel[killerid][d_enduelo] == true)
    {
	    Duel[killerid][d_tiempob] = gettime();
	    new 
            texto[140],
            Float:VidaG,
            Float:BlindajeG
        ;
	    
        GetPlayerHealth(killerid, VidaG);
	    GetPlayerArmour(killerid, BlindajeG);
	    
        Duel[playerid][d_enduelo] = false;
	    Duel[killerid][d_enduelo] = false;
	    Duel[playerid][d_id] = -1;
	    Duel[killerid][d_id] = -1;
	    
        User[killerid][accountDuelosg]++;
	    User[playerid][accountDuelosp]++;
	    User[killerid][accountChocolate] += Duel[killerid][d_apuesta]+ Duel[killerid][d_apuesta];
	    
        SpawnPlayer(killerid);
	    format(texto, sizeof(texto),
            "Duelo: {00FFFF}%s(%d) ganó el duelo vs. %s(%d) con %.0f de vida y %.0f de blindaje. Tiempo: %s", pName(killerid),killerid,pName(playerid),playerid,VidaG,BlindajeG, ConvertTime(Duel[killerid][d_tiempob]-Duel[killerid][d_tiempoa]));
	    
        SaveLog("duelos.txt", texto);
	    SendClientMessageToAll(0x00D4E6FF, texto);
    }

	/*/SISTEMA DE CLANES
    if(User[playerid][accountClan] != 0)
    {
	    for(new c=0;c<MAX_CLANES;c++)
    	{
    		if(Clans[c][CLAN_ID] == User[playerid][accountClan])
    		{
    			new q[77];
			    Clans[c][CLAN_MUERTES]++;
			    format(q, sizeof(q), "UPDATE `Clanes` SET `Muertes`='%d' WHERE `ClanID`='%d' COLLATE NOCASE", Clans[c][CLAN_MUERTES],DB_Escape(User[playerid][accountClan]));
			    db_free_result(db_query(DB_CLANS, q));
    		}
    	}
    }*/

	//CONTADOR DE MUERTES CLANES
    if(killerid != INVALID_PLAYER_ID)
    {
	    /*if(User[killerid][accountClan] != 0)
	    {
		    for(new c=0;c<MAX_CLANES;c++)
    		{
    			if(Clans[c][CLAN_ID] == User[killerid][accountClan])
    			{
    				new q[80];
				    Clans[c][CLAN_ASESINATOS]++;
				    format(q, sizeof(q), "UPDATE `Clanes` SET `Asesinatos`='%d' WHERE `ClanID`='%d' COLLATE NOCASE", Clans[c][CLAN_ASESINATOS],DB_Escape(User[killerid][accountClan]));
				    db_free_result(db_query(DB_CLANS, q));
    			}
    		}
    	}*/

	   //CONTADOR DE RACHA
        rachax[killerid]++;
        rachax[playerid]= 0;

        if(rachax[killerid] > User[killerid][accountRacha])
        {
	        User[killerid][accountRacha] = rachax[killerid];
            ActPlayerData(killerid,"racha");
        }

	   //CONTADOR DE SCORE
        SetPlayerScore(killerid, GetPlayerScore(killerid)+1);
        User[killerid][accountChocolate] += 500;
        User[killerid][accountKills] ++;

	    //BENEFICIOS
	    //VIPS 1
        switch (accountVip[killerid])
        {
            case 1:
            {
                User[killerid][accountChocolate] += 500;
            }
            case 2:
            {
                User[killerid][accountChocolate] += 1000;
                SetPlayerScore(killerid, GetPlayerScore(killerid)+1);
            }
        }
		//ACTUALIZADO DE DATOS AL MORIR
	    ActPlayerData(killerid,"kills");
        ActPlayerData(killerid,"chocolate");
	    ActPlayerData(killerid,"score");
        ActPlayerData(playerid, "deaths");
    }
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	//CARGADO DE AUTOS PRIV
    foreach(new a : Player)
    {
        if(vehicleid == vehicleOwner[a])
        {
        	EraseVeh(vehicleOwner[a]);
        	LoadModVehicle(a);
        	SendLastParking(a);
        }
    }
    
	//ANTI BUG´S DE AUTOS PRIV
    foreach(new i : Player)
    {
        if(vehicleid == User[i][pCar])
        {
            EraseVeh(vehicleid);
        }
    }
    return 1;
}

public OnPlayerText(playerid, text[])
{
    new string[128];

	//ANTI SPAM CHAT
	if(ServerInfo[AntiAd] && User[playerid][accountAdmin] < 6)
    {
        if(IsAdvertisement(text))
        {
            format(string, sizeof(string), "[ATENCION] %s[ID: %d] estaria haciendo SPAM: '%s'.", pName(playerid), playerid, text);
            foreach(new i : Player)
            {
                if(User[i][accountLogged] == 1)
                {
                    if(User[i][accountAdmin] >= 1)
                    {
                        SendClientMessage(i, COLOR_RED, string);

                    }
                }
            }
            //FAKE CHAT PARA SPAMER
            SendClientMessage(playerid, -1, "[INFO] Tu chat ha sido enviado.");
            Kick(playerid);
            return 0;
        }
    }

	//BLOQUEO PARA MUTEADOS
    if(User[playerid][accountMuted] == 1)
    {
        format(string, sizeof(string), "[INFO] Te encuentras silenciado. Podrás hablar luego de %d segundos.", User[playerid][accountMuteSec]);
        SendClientMessage(playerid, COLOR_ORANGE, string);
        return 0;
    }

	//EXPULSIÓN INTENTOS MÁXIMOS SPAM
    if(ServerInfo[AntiSpam])
    {
        if((User[playerid][accountAdmin] == 0 && !IsPlayerAdmin(playerid)))
        {
            if(User[playerid][SpamCount] == 0) User[playerid][SpamTime] = TimeStamp();

			//CONTADOR DE SPAM
            User[playerid][SpamCount]++;
            if(TimeStamp() - User[playerid][SpamTime] > SPAM_TIMELIMIT)
            {
                User[playerid][SpamCount] = 0;
                User[playerid][SpamTime] = TimeStamp();
            }
			//INTENTOS MÁXIMOS SPAM
			else if(User[playerid][SpamCount] == SPAM_MAX_MSGS)
            {
                format(string, sizeof(string), "[KICKED] %s [ID:%d] ha sido expulsado del servidor [Proteccion Anti SPAM]", pName(playerid), playerid);
                SendClientMessageToAll(COLOR_GREY, string);
                print(string);
                SaveLog("kick.txt", string);
                Kick(playerid);
            }

			//TENEMOS QUE BORRAR ESTO, CAMBIAR EL TESTO :V
			else if(User[playerid][SpamCount] == SPAM_MAX_MSGS-1)
            {
                SendClientMessage(playerid, COLOR_RED, "[INFO] ¡Basta de SPAM! La proxima advertencia es expulsion.");
                return 0;
            }
        }
    }

	//DÍGITO ÚNICO CHAT ADMIN
    if(text[0] == '#' && User[playerid][accountAdmin] >= 1)
    {
        format(string, sizeof( string ), "|- [%d] %s[%d]: %s",User[playerid][accountAdmin], pName(playerid), playerid, text[1]);
        SendAdminMessage(0x33FF33AA, string);
        format(string, sizeof( string ), "[CHATADMIN] %s[%d]: %s", pName(playerid), playerid, text[1]);
        print(string);
        SaveLog("adminchat.txt", string);
        return 0;
    }
    
    //DÍGITO ÚNICO CHAT OWNERS
    if(text[0] == '@' && User[playerid][accountAdmin] >= 8 && playerLogued[playerid] == true)
    {
        format(string, sizeof( string ), "|- [%d] @%s[%d]: %s",User[playerid][accountAdmin], pName(playerid), playerid, text[1]);
        foreach(new i : Player) if(User[playerid][accountAdmin] >= 8)
        {
            SendClientMessage(i, 0x00E6E7FF, string);
            print(string);
        }
        return 0;
    }

	#if VipSystem == true
    if(accountVip[playerid] == 2 && vipMessage[playerid] == true)
    {
        new msg[128];
        format(msg,sizeof(msg),"> VIP < %s[%i]: {FFFFFF}%s", pName(playerid), playerid, text);
        SendClientMessageToAll(0x3EFF1FFF,msg);
        format(msg,sizeof(msg),"> VIP < %s[%i]: %s",pName(playerid), playerid,text);
        print(msg);
        SetPlayerChatBubble(playerid, text, GetPlayerColor(playerid), 100.0, 10000);
        return 0;
    }

	//DÍGITO ÚNICO CHAT VIP´S
	if(text[0] == '$' && accountVip[playerid] >= 1)
 	{
        new 
            l[128]
        ;

        format(l, sizeof(l), "[VIPCHAT- %s] %s: %s", GetVIPRank(accountVip[playerid]), pName(playerid), text[1]);
  		format(string, sizeof( string ), "{18EFE1}($) [%s] %s: %s", GetVIPRank(accountVip[playerid]), pName(playerid), text[1]);
    	SaveLog("vipchat.txt", l);

		foreach(new i : Player)
      	{
       		if(User[i][accountLogged] == 1)
			{
				if(accountVip[i] >= 1)
    			{
       				SendClientMessage(i, COLOR_ORANGE, string);
    			}
       		}
       	}
        print(l);
       	return 0;
    }
    #endif

	//ANTI PALABRAS PROHIBIDAS
    if(ServerInfo[AntiSwear])
    {
        for(new s = 0; s < ForbiddenWordCount; s++)
        {
            new pos;
            while((pos = strfind(text,ForbiddenWords[s],true)) != -1) for(new i = pos, j = pos + strlen(ForbiddenWords[s]); i < j; i++) text[i] = '*';
        }
    }
    return 1;
}
public OnPlayerCommandReceived(playerid, cmdtext[])
{

    if(playerLogued[playerid] == false)
    {
        SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas ingresar al juego para hacer uso de comandos.");
        return 0;
    }

    if(check_spawn(playerid) != 1)
    {
        SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas estar spawneado en el juego para hacer uso de comandos.");
        return 0;
    }

    if(Duel[playerid][d_enduelo] == true && strfind(cmdtext,"dejarduelo",true) == -1 && (User[playerid][accountAdmin] < 8))

    {
        SendClientMessage(playerid, 0xFF0000FF, "El unico comando que podes usar ahora es /dejarduelo.");
        return 0;
    }
    
    //LECTURA DE COMANDOS(USUARIOS)
    new string[128];
    if(ServerInfo[ReadCmds])
    {
        if(!ServerInfo[ReadCmd])
        {
            if(strfind(cmdtext, "cpass", true) == -1 || strfind(cmdtext, "register", true) == -1 || strfind(cmdtext, "Ingresar", true) == -1 || strfind(cmdtext, "setpass", true) == -1)
            {
                format(string, sizeof(string), "|- %s[%d] - '%s'", pName(playerid), playerid, cmdtext);
                
                foreach(new i : Player)
                {
                    if(User[i][accountAdmin] >= 1 && User[i][accountAdmin] > User[playerid][accountAdmin] && i != playerid && playerLogued[i] == true)
                    {
                        SendClientMessage(i, COLOR_GREY, string);
                        print(string);
                    }
                }
            }
        }

        //POR RANGO
        else
        {
            foreach(new x : Player)
            {
                if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] == playerid && User[x][SpecType] == SPEC_TYPE_PLAYER)
                {
                    if(strfind(cmdtext, "cpass", true) == -1 || strfind(cmdtext, "register", true) == -1 || strfind(cmdtext, "Ingresar", true) == -1 || strfind(cmdtext, "setpass", true) == -1)
                    {
                        format(string, sizeof(string), "|- %s ha usado"white" %s", pName(playerid), cmdtext);
                        SendClientMessage(x, COLOR_GREEN, string);
                    }
                }
            }
        }
    }

    //ANTI SPAM POR MENSAJES PRIVADOS
    if(ServerInfo[AntiAd] && User[playerid][accountAdmin]==0)
    {
        if(IsAdvertisement(cmdtext))
        {
            format(string, sizeof(string), "[ATENCION] %s[ID: %d] estaria haciendo SPAM: '%s'.", pName(playerid), playerid, cmdtext);
            foreach(new i : Player)
            {
                if(User[i][accountLogged] == 1)
                {
                    if(User[i][accountAdmin] >= 1)
                    {
                        SendClientMessage(i, COLOR_RED, string);
                    }
                }
            }
            SendClientMessage(playerid, -1, "[INFO] Tu comando ha sido enviado.");
            return 0;
        }
    }

    //SANCIÓN BLOQUEO DE COMANDOS EN LA CARCÉL
    if(User[playerid][accountJail] == 1)
    {
        SendClientMessage(playerid, COLOR_ORANGE, "[INFO]{FFFFFF} No puedes usar comandos mientras estés sancionado, puedes mirar el {FF4000}/tiempo {FFFFFF}que te queda.");
        return 0;
    }
    
    //SANCIÓN BLOQUEO DE COMANDOS
    if(User[playerid][accountCMuted] == 1)
    {
        format(string, sizeof(string), "Te encuentras silenciado, podrás usar comandos luego de %d segundos.", User[playerid][accountCMuteSec]);
        SendClientMessage(playerid, COLOR_ORANGE, string);
        return 0;
    }
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	//LOCALIZADO DE AUTO
    foundVehicle[playerid] = true;
    if(foundVehicle[playerid] == true)
    {
        DisablePlayerCheckpoint(playerid);
        SendClientMessage(playerid, COLOR_RED, "[INFO]"white" Has localizado a tu vehículo.");
    }
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    new vehicleid = GetPlayerVehicleID(playerid);
	//SEGUIR SPECTEANDO EN VEHICULOS, REVISAR SI ES NECESARIO, O BORRAR
    if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
    {
        foreach(new x : Player)
        {
            if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] == playerid && User[x][SpecType] == SPEC_TYPE_VEHICLE)
            {
                JBC_TogglePlayerSpectating(x, 1);
                PlayerSpectatePlayer(x, playerid);
                User[x][SpecType] = SPEC_TYPE_PLAYER;
            }
        }
    }

    if(newstate == PLAYER_STATE_PASSENGER)
    {
        foreach(new x : Player)
        {
            if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] == playerid)
            {
                JBC_TogglePlayerSpectating(x, 1);
                PlayerSpectateVehicle(x, vehicleid);
                User[x][SpecType] = SPEC_TYPE_VEHICLE;
            }
        }
    }

    if(newstate == PLAYER_STATE_DRIVER)
    {
        foreach(new x : Player)
        {
            if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] == playerid)
            {
                JBC_TogglePlayerSpectating(x, 1);
                PlayerSpectateVehicle(x, vehicleid);
                User[x][SpecType] = SPEC_TYPE_VEHICLE;
            }
        }
    }
    return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if(!User[playerid][accountLogged])
    {
        if(!ServerInfo[RegisterOption])
        {
            SendClientMessage(playerid, COLOR_RED, "[INFO] Debes estar logueado o registrado para spawnear..");
            return 0;
        }
        else
        {
            if(!CheckAccount(pName(playerid)))
            {   //¿? REFVISAR FUNCIÓN
                #if REGISTER_DIALOG == false
                    new string[128];
                    SetPVarString(playerid, "old_name", pName(playerid));
                    format(string, sizeof(string), "%s_%d", pName(playerid), (random(10000) + 1));
                    JBC_SetPlayerName(playerid, string);
                    format(string, sizeof(string), "[INFO] Has omitido el registro, tu nick se ha establecido en  %s.", pName(playerid));
                    SendClientMessage(playerid, COLOR_RED, string);
                    SendClientMessage(playerid, COLOR_GREEN, "* Signing-up your account will set your name back to normal.");
                #endif
                return 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_RED, "[INFO] Debes estar logueado para spawnear.");
                return 0;
            }
        }
    }
    return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    foreach(new x : Player)
    {   //SEGUIR SPECEANDO EN INTERIORES
        if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] == playerid && User[x][SpecType] == SPEC_TYPE_PLAYER)
        {
            SetPlayerInterior(x,newinteriorid);
        }
    }
    return 1;
}

//COMENTAR TODO ESTE CALLBACK (PENDIENTE)
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && User[playerid][SpecID] != INVALID_PLAYER_ID)
    {
        if(newkeys == KEY_JUMP) AdvanceSpectate(playerid);
        else if(newkeys == KEY_SPRINT) ReverseSpectate(playerid);
    }

    if(PRESSED(KEY_JUMP) && User[playerid][accountJump])
    {
        new 
            Float:P[3]
        ;

        GetPlayerVelocity(playerid, P[0], P[1], P[2]);
        SetPlayerVelocity(playerid, P[0], P[1], P[2]+5.0);
    }

    switch(newkeys)
    {
    	case KEY_YES:
        {
        	if(IsPlayerInRangeOfPoint(playerid, 5.0, -1953.0497,291.6161,35.4688))
        	{
        		if(personalVehicles[playerid][v_id] != -1)
    				return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya tienes un vehículo.");
        		
                if(IsPlayerInAnyVehicle(playerid))
    				return 0;

    			new d[76*42],r[70];
    		    strcat(d,"Modelo\tPrecio\n");
    		    format(r, sizeof(r), "{FFCE00}Sandking\t{00CEFF}$"#SANDKING_PRICE"\n");//case0
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Patriot\t{00CEFF}$"#PATRIOT_PRICE"\n");//case1
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}NRG\t{00CEFF}$"#NRG_PRICE"\n");//case2
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Sanchéz\t{00CEFF}$"#SANCHEZ_PRICE"\n");//case3
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Infernus\t{00CEFF}$"#INFERNUS_PRICE"\n");//case4
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Turismo\t{00CEFF}$"#TURISMO_PRICE"\n");//case5
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Cheetah\t{00CEFF}$"#CHEETAH_PRICE"\n");//case6
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Sabre\t{00CEFF}$"#SABRE_PRICE"\n");//case7
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Super GT\t{00CEFF}$"#SUPERGT_PRICE"\n");//case8
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Bullet\t{00CEFF}$"#BULLET_PRICE"\n");//case9
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Comet\t{00CEFF}$"#COMET_PRICE"\n");//case10
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Banshee\t{00CEFF}$"#BANSHEE_PRICE"\n");//case11
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Slamvan\t{00CEFF}$"#SLAMVAN_PRICE"\n");//case12
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Sultan\t{00CEFF}$"#SULTAN_PRICE"\n");//case13
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Elegy\t{00CEFF}$"#ELEGY_PRICE"\n");//case14
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Jester\t{00CEFF}$"#JESTER_PRICE"\n");//case15
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Hustler\t{00CEFF}$"#HUSTLER_PRICE"\n");//case16
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Huntley\t{00CEFF}$"#HUNTLEY_PRICE"\n");//case17
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Yosemite\t{00CEFF}$"#YOSEMITE_PRICE"\n");//case18
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Buffalo\t{00CEFF}$"#BUFFALO_PRICE"\n");//case19
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Rancher\t{00CEFF}$"#RANCHER_PRICE"\n");//case20
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Blade\t{00CEFF}$"#BLADE_PRICE"\n");//case21
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Mesa\t{00CEFF}$"#MESv_price"\n");//case21
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Phoenix\t{00CEFF}$"#PHOENIX_PRICE"\n");//case22
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}ZR-350\t{00CEFF}$"#ZR350_PRICE"\n");//case23
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Windsor\t{00CEFF}$"#WINDSOR_PRICE"\n");//case24
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Tampa\t{00CEFF}$"#TAMPv_price"\n");//case25
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Broadway\t{00CEFF}$"#BROADWAY_PRICE"\n");//case26
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Tornado\t{00CEFF}$"#TORNADO_PRICE"\n");//case27
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Remington\t{00CEFF}$"#REMING_PRICE"\n");//case28
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Hot Knife\t{00CEFF}$"#HOTKNIFE_PRICE"\n");//case29
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Tahoma\t{00CEFF}$"#TAHOMv_price"\n");//case30
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Blista Compact\t{00CEFF}$"#BLISTv_price"\n");//case31
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Club\t{00CEFF}$"#CLUB_PRICE"\n");//case32
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Flash\t{00CEFF}$"#FLASH_PRICE"\n");//case33
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Primo\t{00CEFF}$"#PRIMO_PRICE"\n");//case34
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Cadrona\t{00CEFF}$"#CADRONv_price"\n");//case35
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Fortune\t{00CEFF}$"#FORTUNE_PRICE"\n");//case36
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Hermes\t{00CEFF}$"#HERMES_PRICE"\n");//case37
    		    strcat(d,r);
    		    format(r, sizeof(r), "{FFCE00}Sweeper\t{00CEFF}$"#SWEEPER_PRICE"\n");//case38
    		    strcat(d,r);

    			ShowPlayerDialog(playerid, DIALOG_AUTOS,DIALOG_STYLE_TABLIST_HEADERS, "Vehículos en venta", d, "Comprar", "Cancelar");
       		    return 1;
    	    }

    		if(IsPlayerInRangeOfPoint(playerid, 5.0, -1688.9515, 13.0076, 3.5547))
        	{
    	    	if(personalVehicles[playerid][v_id] == -1)
    				return SendClientMessage(playerid, COLOR_RED, "[ERROR] No tienes un vehículo propio.");

    			if(IsPlayerInAnyVehicle(playerid))
    				return SendClientMessage(playerid, COLOR_RED, "[ERROR] Baja del vehículo para hacer la venta.");

    			personalVehicles[playerid][v_price] /= 2;
    	    	User[playerid][accountChocolate] += personalVehicles[playerid][v_price];

    			new 
                    l[128],
                    msg[128]
                ;

                format(msg, sizeof(msg), "[GP]{FFFFFF} Compramos tu vehículo al precio del 40 por ciento. Total: "green"$%d.", personalVehicles[playerid][v_price]);
                SendClientMessage(playerid, COLOR_GREEN, msg);

        		format(l, sizeof(l), "[AUTOS] %s vendio su vehiculo. Modelo: %d - Precio: %d", pName(playerid),personalVehicles[playerid][v_model], personalVehicles[playerid][v_price]);
        		SaveLog("buyedcars.txt", l);

    			DestroyVehicle(vehicleOwner[playerid]);

    			vehicleOwner[playerid]=-1;
        		personalVehicles[playerid][v_id]=-1;
    		    personalVehicles[playerid][v_model]=0;
    		    personalVehicles[playerid][v_price]=0;
    		    personalVehicles[playerid][v_color1]=0;
    		    personalVehicles[playerid][v_color2]=0;
    		    personalVehicles[playerid][v_vinyl]=255;
    		    personalVehicles[playerid][v_x]=0;
    		    personalVehicles[playerid][v_y]=0;
    		    personalVehicles[playerid][v_z]=0;
    		    personalVehicles[playerid][v_angle]=0;
    		    personalVehicles[playerid][a_aleron]=0;
    		    personalVehicles[playerid][a_ven_techo]=0;
    		    personalVehicles[playerid][a_techo]=0;
    		    personalVehicles[playerid][a_laterales]=0;
    		    personalVehicles[playerid][a_luces]=0;
    		    personalVehicles[playerid][a_nitro]=0;
    		    personalVehicles[playerid][a_escape]=0;
    		    personalVehicles[playerid][a_ruedas]=0;
    		    personalVehicles[playerid][a_puertas]=0;
    		    personalVehicles[playerid][a_hidraulica]=0;
    		    personalVehicles[playerid][a_par_delantero]=0;
    		    personalVehicles[playerid][a_par_trasero]=0;
    		    personalVehicles[playerid][a_ven_derecha]=0;
    		    personalVehicles[playerid][a_ven_izquierda]=0;

    		    new 
                    Query[66]
                ;
    		    
                format(Query, sizeof(Query), "DELETE FROM `Autos` WHERE `Propietario` = '%s'", DB_Escape(pName(playerid)));
    		    db_query(DB_VEHICLES, Query);
    		    return 1;
    	    }

        }
        //BORRADO DE CHAT CON TECLA: N
        case KEY_NO:
        {
        	        	
        	LevelCheck(playerid, 2);
        	new	string[128];

        	for(new i=0; i<100; i++)
        	{
            	SendClientMessageToAll(-1, " ");
        	}

    		format(string, sizeof string, "[ADMIN] "orange"%s "white"ha limpiado el chat del servidor.", pName(playerid));
    		SendClientMessageToAll(-1, string);
    	}
        //PENDIENTE REVISAR USO
        case KEY_SECONDARY_ATTACK:
        {   //ENTRADA
        	if(IsPlayerInRangeOfPoint(playerid, 5.0, 461.7018, -1500.7772, 31.0455))
        	{
        		JBC_SetPlayerPos(playerid,-2167.2839, 642.5882,1057.5938);
        		SetPlayerInterior(playerid, 1);
        		SetPlayerVirtualWorld(playerid, 1);
        		SetCameraBehindPlayer(playerid);
        		JBC_ResetPlayerWeapons(playerid);
        		JBC_SetPlayerHealth(playerid, 100.00);
    	    }
    		//SALIDA
    		else if(IsPlayerInRangeOfPoint(playerid, 5.0, -2167.2839, 642.5882,1057.5938))//Salida
        	{
           		JBC_SetPlayerPos(playerid, 461.7018, -1500.7772, 31.0455);
           		SetPlayerInterior(playerid, 0);
           		SetPlayerVirtualWorld(playerid, 0);
           		SetCameraBehindPlayer(playerid);
           		SpawnPlayer(playerid);
        	}
        	return 1;
    	}
    }
    return 1;
}

//SEGUNDA RCON
#if RconProtect == true
    public OnPlayerRconLogin(playerid)
    {
        if(_RCON[playerid] == false)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Ingresa la segunda contraseña RCON por favor.");
            ShowPlayerDialog(playerid, DIALOG_RCON, DIALOG_STYLE_PASSWORD, ""green"RCON", ""grey"\nEscribe la segunda contraseña RCON:", "Acceso", "");
        }
        return 1;
    }
#endif


//INDENTADO COMPLETO. FALTA COMENTAR TODO ESTE CALLNACK (PENDIENTE)
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {   //DIALOGO DE COLOR DE CHAT DE CLAN
    	/*case DIALOG_CCOLOR:
    	{
    		if(!response)
				return 1;

			new 
                q[70];
      		
            for(new c=0;c<MAX_CLANES;c++)
	  		{
	  		    if(Clans[c][CLAN_ID] == User[playerid][accountClan])
			  	{
			  		Clans[c][CLAN_COLOR] = listitem;
				}
			}

			format(q, sizeof(q), "UPDATE `Clanes` SET `Color`='%d' WHERE `ClanID`='%d' COLLATE NOCASE",listitem,DB_Escape(User[playerid][accountClan]));
   			db_free_result(db_query(DB_CLANS, q));

			new 
                c[56];
	    	
            format(c, sizeof(c), "[Clan]: %s cambió el color del clan.", pName(playerid));
		    SendClanMessage(playerid,c);

			if(User[playerid][accountAdmin] != 0)
			{
				SendClientMessage(playerid, COLOR_CLAN,c);
            }
 			
            for(new i=0; i<MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
				    if(User[i][accountClan] == User[playerid][accountClan])
					{
						clan_color[i] = listitem;
					}
 				}
  			}
			return 1;
 		}*/
 		
		//DIALOGO COMPRA DE AUTOS
    	case DIALOG_AUTOS:
    	{
	    	if(!response)
				return 1;

			switch(listitem)
	    	{
		    	case 0:  BuyCar(playerid, 495, SANDKING_PRICE);
		    	case 1:  BuyCar(playerid, 470, PATRIOT_PRICE);
			    case 2:  BuyCar(playerid, 522, NRG_PRICE);
			    case 3:  BuyCar(playerid, 468, SANCHEZ_PRICE);
			    case 4:  BuyCar(playerid, 411, INFERNUS_PRICE);
			    case 5:  BuyCar(playerid, 451, TURISMO_PRICE);
			    case 6:  BuyCar(playerid, 415, CHEETAH_PRICE);
			    case 7:  BuyCar(playerid, 475, SABRE_PRICE);
			    case 8:  BuyCar(playerid, 506, SUPERGT_PRICE);
			    case 9:  BuyCar(playerid, 541, BULLET_PRICE);
			    case 10: BuyCar(playerid, 480, COMET_PRICE);
			    case 11: BuyCar(playerid, 429, BANSHEE_PRICE);
			    case 12: BuyCar(playerid, 535, SLAMVAN_PRICE);
			    case 13: BuyCar(playerid, 560, SULTAN_PRICE);
			    case 14: BuyCar(playerid, 562, ELEGY_PRICE);
			    case 15: BuyCar(playerid, 559, JESTER_PRICE);
			    case 16: BuyCar(playerid, 545, HUSTLER_PRICE);
			    case 17: BuyCar(playerid, 579, HUNTLEY_PRICE);
			    case 18: BuyCar(playerid, 554, YOSEMITE_PRICE);
			    case 19: BuyCar(playerid, 402, BUFFALO_PRICE);
			    case 20: BuyCar(playerid, 489, RANCHER_PRICE);
			    case 21: BuyCar(playerid, 536, BLADE_PRICE);
			    case 22: BuyCar(playerid, 500, MESv_price);
			    case 23: BuyCar(playerid, 603, PHOENIX_PRICE);
			    case 24: BuyCar(playerid, 477, ZR350_PRICE);
			    case 25: BuyCar(playerid, 555, WINDSOR_PRICE);
			    case 26: BuyCar(playerid, 549, TAMPv_price);
			    case 27: BuyCar(playerid, 575, BROADWAY_PRICE);
			    case 28: BuyCar(playerid, 576, TORNADO_PRICE);
			    case 29: BuyCar(playerid, 534, REMING_PRICE);
			    case 30: BuyCar(playerid, 434, HOTKNIFE_PRICE);
			    case 31: BuyCar(playerid, 566, TAHOMv_price);
			    case 32: BuyCar(playerid, 496, BLISTv_price);
			    case 33: BuyCar(playerid, 589, CLUB_PRICE);
			    case 34: BuyCar(playerid, 565, FLASH_PRICE);
			    case 35: BuyCar(playerid, 547, PRIMO_PRICE);
			    case 36: BuyCar(playerid, 527, CADRONv_price);
			    case 37: BuyCar(playerid, 526, FORTUNE_PRICE);
			    case 38: BuyCar(playerid, 474, HERMES_PRICE);
			    case 39: BuyCar(playerid, 574, SWEEPER_PRICE);
	    	}
	    	return 1;
	    }

	    case DUELO_DIALOG_5: //ver duelo
	    {
    		if(!response)
				return 1;

			if (strlen(inputtext) == 0)
				return
					ShowPlayerDialog(playerid,DUELO_DIALOG+5, DIALOG_STYLE_INPUT, "Ver duelo", "\n{ffffff}No ingresaste ningun ID.\nEscribe el ID de uno de los jugadores del duelo", "Seleccionar", "Cancelar");

			if(!isnumeric(inputtext))
				return
					ShowPlayerDialog(playerid,DUELO_DIALOG+5, DIALOG_STYLE_INPUT, "Ver duelo", "\n{ffffff}ID Invalido (solo numeros).\nEscribe el ID de uno de los jugadores del duelo", "Seleccionar", "Cancelar");

			new jugador=strval(inputtext);
    		if(!IsPlayerConnected(jugador))
				return ShowPlayerDialog(playerid,DUELO_DIALOG+5, DIALOG_STYLE_INPUT, "Ver duelo", "\n{ffffff}Ese jugador no está conectado.\nEscribe el ID de uno de los jugadores del duelo", "Seleccionar", "Cancelar");

			if(playerid == jugador)
				return
					ShowPlayerDialog(playerid,DUELO_DIALOG+5, DIALOG_STYLE_INPUT, "Ver duelo", "\n{ffffff}El ID ingresado es el tuyo.\nEscribe el ID de uno de los jugadores del duelo", "Seleccionar", "Cancelar");

			if(Duel[jugador][d_enduelo] == false)
				return
				    
            ShowPlayerDialog(playerid,DUELO_DIALOG+5, DIALOG_STYLE_INPUT, "Ver duelo", "\n{ffffff}El jugador no está en un duelo.\nEscribe el ID de uno de los jugadores del duelo", "Seleccionar", "Cancelar");
    		SetPlayerInterior(playerid,GetPlayerInterior(jugador));
    		SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(jugador));
    		TogglePlayerSpectating(playerid, true);
    		PlayerSpectatePlayer(playerid, jugador);
    		
            Duel[playerid][d_enduelo] = true;
    		
            SendClientMessage(playerid, 0xFFFF00FF, "Estás viendo el duelo, para dejarlo usá /dejarduelo.");
    		return 1;
    	}

		case DUELO_DIALOG_4: //selección de apuesta
	    {
	    	if(!response)
				return
					ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}Escribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");

			new 
                apuesta  = strval(inputtext),
	    	    invitado = Duel[playerid][d_desafiado]
            ;

			if(apuesta > User[playerid][accountChocolate])
				return ShowPlayerDialog(playerid,DUELO_DIALOG+4, DIALOG_STYLE_INPUT, "Invitación", "\n{00FF00}Apuesta invalida. No posees esa cantidad.\n{FFFFFF}Escribe la cantidad de dinero que quieres apostar", "Seleccionar", "Cancelar");

			if(apuesta > User[invitado][accountChocolate])
				return ShowPlayerDialog(playerid,DUELO_DIALOG+4, DIALOG_STYLE_INPUT, "Invitación", "\n{00FF00}Apuesta invalida. {FFFF00}El desafiado, no posee esa cantidad.\n{FFFFFF}Escribe la cantidad de dinero que quieres apostar", "Seleccionar", "Cancelar");
	    	
            if(apuesta < 0 || apuesta > 1000000)
				return ShowPlayerDialog(playerid,DUELO_DIALOG+4, DIALOG_STYLE_INPUT, "Invitación", "\n{00FF00}Apuesta invalida. Minimo $0 - Maximo $1,000,000.\n{FFFFFF}Escribe la cantidad de dinero que quieres apostar", "Seleccionar", "Cancelar");

			if(!isnumeric(inputtext)) 
                return ShowPlayerDialog(playerid,DUELO_DIALOG+4, DIALOG_STYLE_INPUT, "Invitación", "\n{00FF00}Apuesta invalida (solo números).\n{FFFFFF}Escribe la cantidad de dinero que quieres apostar", "Seleccionar", "Cancelar");

	    	Duel[playerid][d_apuesta] = apuesta;

			new 
                a[24]
            ;
	    	
            switch(Duel[playerid][d_armas])
	    	{
	    		case 1: a = "Rapidas";
	    		case 2: a = "Lentas";
	    		case 3: a = "Lentas 2";
	    		case 4: a = "Desert Eagle";
	    		case 5: a = "9mm Silenciada";
	    		case 6: a = "9mm";
	    		case 7: a = "Escopeta normal";
	    		case 8: a = "Recortada";
	    		case 9: a = "Escopeta de combate";
	    		case 10: a = "Tec9";
	    		case 11: a = "M4";
	    		case 12: a = "Sniper";
	    	    case 13: a = "Rifle";
	    	}

		    new 
                texto[130]
            ;

    		format(texto, sizeof(texto), "Duelo: {FFCF00}Invitaste a %s(%d) a un duelo. Arena: %d - Armas: %s. {00FF00}Apuesta: $%s", pName(invitado), invitado, Duel[playerid][d_arena], a, SetFormatNumber(apuesta));
    	    SendClientMessage(playerid, 0x00D4E6FF, texto);
    	    SendClientMessage(playerid, 0xFFFF00FF, "Usá /cancelarduelo si necesitas cancelarlo");

    		format(texto, sizeof(texto), "Duelo: {FFCF00}%s(%d) te invito a un duelo. Arena: %d - Armas: %s. {00FF00}Apuesta: $%s", pName(playerid), playerid, Duel[playerid][d_arena], a, SetFormatNumber(apuesta));
    	    SendClientMessage(invitado, 0x00D4E6FF, texto);
    	    SendClientMessage(invitado, 0xFFFF00FF, "Usá /aceptarduelo (ID) para empezar el duelo");

		    return 1;
	    }

	    case DUELO_DIALOG_3: //selección de oponente
	    {
	        if(!response)
			    return
				    ShowPlayerDialog(playerid,DUELO_DIALOG+2, DIALOG_STYLE_LIST, "Selección de armas", "Rapidas\nLentas\nLentas 2\nDesert Eagle\n9mm Silenciada\n9mm\nShotgun\nRecortada\nSpas\nTec9\nM4\nSniper\nRifle", "Seleccionar", "Cancelar");

    		if (strlen(inputtext) == 0)
    			return ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}No ingresaste ningun ID.\nEscribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");

    	    if(!isnumeric(inputtext)) 
                return ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}ID Invalido (solo numeros).\nEscribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");

    		new Invitado=strval(inputtext);
    	    if(GetPlayerTeam(playerid) == GetPlayerTeam(Invitado))
    			return
    				ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}Ese jugador es tu mismo TEAM, no puedes desafiarlo.\nEscribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");

    		if(!IsPlayerConnected(Invitado))
    			return
    				ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}Ese jugador no está conectado.\nEscribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");

    		if(playerid == Invitado)
    			return
    				ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}No te puedes invitar a ti mismo.\nEscribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");

    		if(Duel[Invitado][d_invitaciones] == false)
    			return
    				ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}El jugador tiene las invitaciones de duelos desactivadas.\nEscribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");

    		if(Duel[Invitado][d_enduelo] == true)
    			return
    				ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}El jugador está en un duelo.\nEscribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");

    		if(Duel[Invitado][d_desafiado] != -1)
    			return
    		
            ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}El jugador está programando un duelo.\nEscribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");
            ShowPlayerDialog(playerid,DUELO_DIALOG+4, DIALOG_STYLE_INPUT, "Invitación", "\n{00FF00}**Apuesta** (Opcional)\n{ffffff}Escribe la cantidad de dinero que quieres apostar", "Seleccionar", "Cancelar");

    		Duel[playerid][d_desafiado] = Invitado;
    	    return 1;
	}

		case DUELO_DIALOG_2: //selección de armas
	    {
	    	if(!response)
	    	{
	    		Duel[playerid][d_desafiado] = -1;
	    		ShowPlayerDialog(playerid, DUELO_DIALOG+1, DIALOG_STYLE_LIST, "Selección de arena", "Arena #1\nArena #2\nArena #3\nArena #4\nArena #5", "Seleccionar", "Cancelar");
	    		return 1;
		    }

			ShowPlayerDialog(playerid,DUELO_DIALOG+3, DIALOG_STYLE_INPUT, "Invitación", "\n{ffffff}Escribe el ID del jugador a desafiar", "Seleccionar", "Cancelar");

			Duel[playerid][d_armas] = listitem+1;
     		return 1;
	    }

		case DUELO_DIALOG_1: //selección de arena
	    {
	        if(!response)
			    return 1;

		    ShowPlayerDialog(playerid,DUELO_DIALOG+2, DIALOG_STYLE_LIST, "Selección de armas", "Rapidas\nLentas\nLentas 2\nDesert Eagle\n9mm Silenciada\n9mm\nShotgun\nRecortada\nSpas\nTec9\nM4\nSniper\nRifle", "Seleccionar", "Cancelar");
	    	Duel[playerid][d_arena] = listitem+1;
	    	return 1;
	    }

		case DUELO_DIALOG:
	    {
	    	switch(listitem)
	    	{
	    		case 0:
					ShowPlayerDialog(playerid, DUELO_DIALOG+1, DIALOG_STYLE_LIST, "Selección de arena", "Arena #1\nArena #2\nArena #3\nArena #4\nArena #5", "Seleccionar", "Cancelar");
	    		
                case 1:
					ShowPlayerDialog(playerid, DUELO_DIALOG+5, DIALOG_STYLE_INPUT, "Ver duelo", "\n{ffffff}Escribe el ID de uno de los jugadores del duelo", "Seleccionar", "Cancelar");
	    		
                case 2:
	    		{

					if(Duel[playerid][d_invitaciones] == false)
	    			{
	    				Duel[playerid][d_invitaciones] = true;
	    				return SendClientMessage(playerid, 0xFFFFFFFF, "Invitaciones de duelos activadas, ahora podrán desafiarte");
	    			}

					else
	    			{
	    				Duel[playerid][d_invitaciones] = false;
	    			}
	    			return
						SendClientMessage(playerid, 0xFFFFFFFF, "Invitaciones de duelos desactivadas, ahora no podrán desafiarte");
	    		}
	    	}
	    	return 1;
	    }

		#if RconProtect == true
        case DIALOG_RCON:
        {
            new string[130];

			if(!response)
            {
                format(string, sizeof(string), "[KICKED] %s[ID:%d] ha sido expulsado del servidor. [Razon: Login Modo Rcon fallido]", pName(playerid), playerid);
                SendClientMessageToAll(COLOR_GREY, string);
                
                print(string);
                SaveLog("rcon.txt", string);
                return Ban(playerid);
            }

			if(response)
            {
                if(!strcmp(RconPass, inputtext) && !(!strlen(inputtext)))
                {
                    format(string, sizeof(string), "[INFOADMINS] %s[ID:%d] ha accedido al Modo Rcon!", pName(playerid), playerid);
                    SendAdminMessage(COLOR_GREY, string);
                    
                    print(string);
                    SaveLog("rcon.txt", string);

                    _RCON[playerid] = true;

                    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~g~Acceso ~w~Autorizado!~n~~y~Bienvenido", 3000, 3);
                }

				else
                {
                    if(_RCONwarn[playerid] == MAX_RCON_WARNINGS)
                    {
                        format(string, sizeof(string), "[KICKED] %s[ID:%d] ha sido expulsado por GP.SEC [Razon: Login Modo Rcon fallido]", pName(playerid), playerid);
                        SendClientMessageToAll(COLOR_GREY, string);
                        print(string);
                        SaveLog("kick.txt", string);
                        Ban(playerid);
                        return 1;
                    }

				    _RCONwarn[playerid] ++;
                    format(string, sizeof(string), "[INFO] 2nd Rcon Password es incorrecta  (Intentos: %i/%i)", _RCONwarn[playerid], MAX_RCON_WARNINGS);
                    SendClientMessage(playerid, COLOR_GREY, string);
                    ShowPlayerDialog(playerid, DIALOG_RCON, DIALOG_STYLE_PASSWORD, ""green"2nd RCON Password", ""grey"Rcon protegido por GP.SPEC\nEscribe la 2da Rcon para finalizar el ingreso.", "Acceso", "Ban");
        		}
            }
        }
        #endif

        case DIALOG_PING:
        {
            new string[128];

            if(response)
            {
                if(!strlen(inputtext))
                    return ShowPlayerDialog(playerid, DIALOG_PING, DIALOG_STYLE_INPUT, "Maximum Ping", "Place in the maximum ping in the server (E.G.; 1000);\n* Once player reached this ping, they will get warned first then kick.\n\n* To disable the Ping Kicker, simply place 0.", "Establecer", "Volver");

                if(!isnumeric(inputtext))
                    return ShowPlayerDialog(playerid, DIALOG_PING, DIALOG_STYLE_INPUT, "Maximum Ping", "Place in the maximum ping in the server (E.G.; 1000);\n* Once player reached this ping, they will get warned first then kick.\n\n* To disable the Ping Kicker, simply place 0.", "Establecer", "Volver");

                if(strval(inputtext) < 0)
                    return ShowPlayerDialog(playerid, DIALOG_PING, DIALOG_STYLE_INPUT, "Maximum Ping", "Place in the maximum ping in the server (E.G.; 1000);\n* Once player reached this ping, they will get warned first then kick.\n\n* To disable the Ping Kicker, simply place 0.", "Establecer", "Volver");

                ServerInfo[MaxPing] = strval(inputtext);
                SaveConfig();

                format(string, sizeof(string), "[ADMIN] %s has set the Maximum Ping to (%d).", pName(playerid), ServerInfo[MaxPing]);
                SendAdminMessage(COLOR_YELLOW, string);
            }

			else
            {
                ShowSettings(playerid);
            }
		}

		case DIALOG_PING_WARN:
        {
            new string[128];

            if(response)
            {
                if(!strlen(inputtext))
                    return ShowPlayerDialog(playerid, DIALOG_PING_WARN, DIALOG_STYLE_INPUT, "Ping Warn", "Place in the maximum ping warning before the player gets kicked;", "Establecer", "Volver");

                if(!isnumeric(inputtext))
                    return ShowPlayerDialog(playerid, DIALOG_PING_WARN, DIALOG_STYLE_INPUT, "Ping Warn", "Place in the maximum ping warning before the player gets kicked;", "Establecer", "Volver");

                if(strval(inputtext) < 1)
                    return ShowPlayerDialog(playerid, DIALOG_PING_WARN, DIALOG_STYLE_INPUT, "Ping Warn", "Place in the maximum ping warning before the player gets kicked;", "Establecer", "Volver");

                ServerInfo[MaxPingWarn] = strval(inputtext);
                SaveConfig();

                format(string, sizeof(string), "[ADMIN] %s has set the Maximum Ping Warning to (%d).", pName(playerid), ServerInfo[MaxPingWarn]);
                SendAdminMessage(COLOR_YELLOW, string);
            }

			else
            {
                ShowSettings(playerid);
            }
        }

        case DIALOGLOG_FOLDERTRIES:
        {
            new string[128];

            if(response)
            {
                if(!strlen(inputtext))
                    return ShowPlayerDialog(playerid, DIALOGLOG_FOLDERTRIES, DIALOG_STYLE_INPUT, "Login Tries", "Place in the amount of maximum login tries;\n\n* Once player reached this amount of tries, They will get kicked.", "Establecer", "Volver");

                if(!isnumeric(inputtext))
                    return ShowPlayerDialog(playerid, DIALOGLOG_FOLDERTRIES, DIALOG_STYLE_INPUT, "Login Tries", "Place in the amount of maximum login tries;\n\n* Once player reached this amount of tries, They will get kicked.", "Establecer", "Volver");

                if(strval(inputtext) < 1)
                    return ShowPlayerDialog(playerid, DIALOGLOG_FOLDERTRIES, DIALOG_STYLE_INPUT, "Login Tries", "Place in the amount of maximum login tries;\n\n* Once player reached this amount of tries, They will get kicked.", "Establecer", "Volver");

                ServerInfo[LoginWarn] = strval(inputtext);
                SaveConfig();

                format(string, sizeof(string), "[ADMIN] %s has set the Maximum Login Tries to (%d).", pName(playerid), ServerInfo[LoginWarn]);
                SendAdminMessage(COLOR_YELLOW, string);
            }
            else
            {
                ShowSettings(playerid);
            }
        }

		case DIALOG_SEC_TRIES:
        {
            new string[128];

            if(response)
            {
                if(!strlen(inputtext))
                    return ShowPlayerDialog(playerid, DIALOG_SEC_TRIES, DIALOG_STYLE_INPUT, "Secure Tries", "Place in the amount of maximum security question tries;\n\n* Once player reached this amount of tries, They will get kicked.", "Establecer", "Volver");

                if(!isnumeric(inputtext))
                    return ShowPlayerDialog(playerid, DIALOG_SEC_TRIES, DIALOG_STYLE_INPUT, "Secure Tries", "Place in the amount of maximum security question tries;\n\n* Once player reached this amount of tries, They will get kicked.", "Establecer", "Volver");

                if(strval(inputtext) < 1)
                    return ShowPlayerDialog(playerid, DIALOG_SEC_TRIES, DIALOG_STYLE_INPUT, "Secure Tries", "Place in the amount of maximum security question tries;\n\n* Once player reached this amount of tries, They will get kicked.", "Establecer", "Volver");

                ServerInfo[SecureWarn] = strval(inputtext);
                SaveConfig();

                format(string, sizeof(string), "[ADMIN] %s has set the Maximum Security Question Tries to (%d).", pName(playerid), ServerInfo[SecureWarn]);
                SendAdminMessage(COLOR_YELLOW, string);
            }

			else
            {
                ShowSettings(playerid);
            }
        }

        case DIALOG_RANKS:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_1, DIALOG_STYLE_INPUT, ""COLOR_RANK1"Rango administrativo #1", ""white"Editando rango #1\n\nEscribe el nuevo nombre para el rango "COLOR_RANK1" 1", ""white"Establecer", ""white"Volver");

					case 1:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_2, DIALOG_STYLE_INPUT, ""COLOR_RANK2"Rango administrativo #2", ""white"Editando rango #2\n\nEscribe el nuevo nombre para el rango "COLOR_RANK2" 2", ""white"Establecer", ""white"Volver");

					case 2:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_3, DIALOG_STYLE_INPUT, ""COLOR_RANK3"Rango administrativo #3", ""white"Editando rango #3\n\nEscribe el nuevo nombre para el rango "COLOR_RANK3" 3", ""white"Establecer", ""white"Volver");

					case 3:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_4, DIALOG_STYLE_INPUT, ""COLOR_RANK4"Rango administrativo #4", ""white"Editando rango #4\n\nEscribe el nuevo nombre para el rango "COLOR_RANK4" 4", ""white"Establecer", ""white"Volver");

					case 4:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_5, DIALOG_STYLE_INPUT, ""COLOR_RANK5"Rango administrativo #5", ""white"Editando rango #5\n\nEscribe el nuevo nombre para el rango "COLOR_RANK5" 5", ""white"Establecer", ""white"Volver");

					case 5:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_6, DIALOG_STYLE_INPUT, ""COLOR_RANK6"Rango administrativo #6", ""white"Editando rango #6\n\nEscribe el nuevo nombre para el rango "COLOR_RANK6" 6", ""white"Establecer", ""white"Volver");

					case 6:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_7, DIALOG_STYLE_INPUT, ""COLOR_RANK7"Rango administrativo #7", ""white"Editando rango #7\n\nEscribe el nuevo nombre para el rango "COLOR_RANK7" 7", ""white"Establecer", ""white"Volver");

					case 7:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_8, DIALOG_STYLE_INPUT, ""COLOR_RANK8"Rango administrativo #8", ""white"Editando rango #8\n\nEscribe el nuevo nombre para el rango "COLOR_RANK8" 8", ""white"Establecer", ""white"Volver");

					case 8:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_9, DIALOG_STYLE_INPUT, ""COLOR_RANK9"Rango administrativo #9", ""white"Editando rango #9\n\nEscribe el nuevo nombre para el rango "COLOR_RANK9" 9", ""white"Establecer", ""white"Volver");

					case 9:
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_10, DIALOG_STYLE_INPUT, ""COLOR_RANK10"Rango administrativo #10", ""white"Editando rango #10\n\nEscribe el nuevo nombre para el rango "COLOR_RANK10" 10", ""white"Establecer", "Volver");

					#if VipSystem == true
                        case 10:
							ShowPlayerDialog(playerid, DIALOG_EDIT_VIP_1, DIALOG_STYLE_INPUT, ""vip2_color"Rango VIP #1", ""white"Editando rango VIP "vip2_color"#1\n\nEscribe el nuevo nombre para el rango VIP "vip2_color"1", "Establecer", "Volver");

						case 11:
							ShowPlayerDialog(playerid, DIALOG_EDIT_VIP_2, DIALOG_STYLE_INPUT, ""vip2_color"Rango VIP #2", ""white"Editando rango VIP "vip2_color"#3\n\nEscribe el nuevo nombre para el rango VIP "vip2_color"2", ""white"Establecer", ""white"Volver");
                    #endif
                }
            }

			else
            {
                ShowSettings(playerid);
            }
  		}

		#if VipSystem == true
        case DIALOG_EDIT_VIP_1:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return
                        ShowPlayerDialog(playerid, DIALOG_EDIT_VIP_1, DIALOG_STYLE_INPUT, "VIP 1\nEdita el nombre del rango VIP.", "\nescribe el nuevo nombre.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
                        ShowPlayerDialog(playerid, DIALOG_EDIT_VIP_1, DIALOG_STYLE_INPUT, "VIP 1\nEdita el nombre del rango VIP.", "\nescribe el nuevo nombre.", "Establecer", "Volver");
                format(ServerInfo[VipRank1], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }
            else
            {
                ShowRanks(playerid);
            }
        }

        case DIALOG_EDIT_VIP_2:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return
					ShowPlayerDialog(playerid, DIALOG_EDIT_VIP_1, DIALOG_STYLE_INPUT, "VIP 2\nEdita el nombre del rango VIP.", "\nescribe el nuevo nombre.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
					ShowPlayerDialog(playerid, DIALOG_EDIT_VIP_1, DIALOG_STYLE_INPUT, "VIP 2\nEdita el nombre del rango VIP.", "\nescribe el nuevo nombre.", "Establecer", "Volver");

                format(ServerInfo[VipRank2], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }

            else
            {
                ShowRanks(playerid);
            }
        }
        #endif

        case DIALOG_EDIT_ADMIN_1:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_1, DIALOG_STYLE_INPUT, "Editing; Admin Rank 1", "You are now editing Admin Rank #1;\n\n* Type in the new rank name for admin level 1.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_1, DIALOG_STYLE_INPUT, "Editing; Admin Rank 1", "You are now editing Admin Rank #1;\n\n* Type in the new rank name for admin level 1.", "Establecer", "Volver");

                format(ServerInfo[AdminRank1], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }

            else
            {
                ShowRanks(playerid);
            }
        }

        case DIALOG_EDIT_ADMIN_2:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_2, DIALOG_STYLE_INPUT, "Editing; Admin Rank 2", "You are now editing Admin Rank #2;\n\n* Type in the new rank name for admin level 2.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_2, DIALOG_STYLE_INPUT, "Editing; Admin Rank 2", "You are now editing Admin Rank #2;\n\n* Type in the new rank name for admin level 2.", "Establecer", "Volver");

                format(ServerInfo[AdminRank2], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }

            else
            {
                ShowRanks(playerid);
            }
        }

		case DIALOG_EDIT_ADMIN_4:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_4, DIALOG_STYLE_INPUT, "Editing; Admin Rank 4", "You are now editing Admin Rank #4;\n\n* Type in the new rank name for admin level 4.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_4, DIALOG_STYLE_INPUT, "Editing; Admin Rank 4", "You are now editing Admin Rank #4;\n\n* Type in the new rank name for admin level 4.", "Establecer", "Volver");

                format(ServerInfo[AdminRank4], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }
            else
            {
                ShowRanks(playerid);
            }
        }

        case DIALOG_EDIT_ADMIN_5:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_5, DIALOG_STYLE_INPUT, "Editing; Admin Rank 5", "You are now editing Admin Rank #5;\n\n* Type in the new rank name for admin level 5.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_5, DIALOG_STYLE_INPUT, "Editing; Admin Rank 5", "You are now editing Admin Rank #5;\n\n* Type in the new rank name for admin level 5.", "Establecer", "Volver");

                format(ServerInfo[AdminRank5], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }

			else
            {
                ShowRanks(playerid);
            }
        }

		case DIALOG_EDIT_ADMIN_6:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_6, DIALOG_STYLE_INPUT, "Editing; Admin Rank 6", "You are now editing Admin Rank #6;\n\n* Type in the new rank name for admin level 6.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_6, DIALOG_STYLE_INPUT, "Editing; Admin Rank 6", "You are now editing Admin Rank #6;\n\n* Type in the new rank name for admin level 6.", "Establecer", "Volver");

                format(ServerInfo[AdminRank6], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }

			else
            {
                ShowRanks(playerid);
            }
        }

		case DIALOG_EDIT_ADMIN_7:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_7, DIALOG_STYLE_INPUT, "Editing; Admin Rank 7", "You are now editing Admin Rank #7;\n\n* Type in the new rank name for admin level 7.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_7, DIALOG_STYLE_INPUT, "Editing; Admin Rank 7", "You are now editing Admin Rank #7;\n\n* Type in the new rank name for admin level 7.", "Establecer", "Volver");

                format(ServerInfo[AdminRank7], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }

            else
            {
                ShowRanks(playerid);
            }
        }

		case DIALOG_EDIT_ADMIN_8:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_8, DIALOG_STYLE_INPUT, "Editing; Admin Rank 8", "You are now editing Admin Rank #8;\n\n* Type in the new rank name for admin level 8.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_8, DIALOG_STYLE_INPUT, "Editing; Admin Rank 8", "You are now editing Admin Rank #8;\n\n* Type in the new rank name for admin level 8.", "Establecer", "Volver");

                format(ServerInfo[AdminRank8], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }
            else
            {
                ShowRanks(playerid);
            }
        }

		case DIALOG_EDIT_ADMIN_9:
        {
            if(response)
            {
                if(!strlen(inputtext))
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_9, DIALOG_STYLE_INPUT, "Editing; Admin Rank 9", "You are now editing Admin Rank #9;\n\n* Type in the new rank name for admin level 9.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_9, DIALOG_STYLE_INPUT, "Editing; Admin Rank 9", "You are now editing Admin Rank #9;\n\n* Type in the new rank name for admin level 9.", "Establecer", "Volver");

                format(ServerInfo[AdminRank9], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            	}

				else
            	{
                	ShowRanks(playerid);
            	}
        	}

		 case DIALOG_EDIT_ADMIN_10:
 		 {
   		 	if(response)
      	 	{
        		if(!strlen(inputtext))
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_10, DIALOG_STYLE_INPUT, "Editing; Admin Rank 10", "You are now editing Admin Rank #10;\n\n* Type in the new rank name for admin level 10.", "Establecer", "Volver");

                if(strlen(inputtext) > 63)
                    return
						ShowPlayerDialog(playerid, DIALOG_EDIT_ADMIN_10, DIALOG_STYLE_INPUT, "Editing; Admin Rank 10", "You are now editing Admin Rank #10;\n\n* Type in the new rank name for admin level 10.", "Establecer", "Volver");

                format(ServerInfo[AdminRank10], 256, inputtext);
                SaveConfig();
                ShowRanks(playerid);
            }
            else
            {
                ShowRanks(playerid);
            }
        }
        case DIALOG_SETTINGS:
        {
            new string[128];

            if(response)
            {
                switch(listitem)
                {
                    case 0:
                    {   //GUARDADO DE LOGS
                        switch(ServerInfo[SaveLogs])
                        {
                            case 0:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has enable the Save Log Files feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[SaveLogs] = 1;
                                SaveConfig();
                            }
                            case 1:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has disable the Save Log Files feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[SaveLogs] = 0;
                                SaveConfig();
                            }
                        }
                        ShowSettings(playerid);
                    }

					case 1: // Login Tries
                    {
                        ShowPlayerDialog(playerid, DIALOGLOG_FOLDERTRIES, DIALOG_STYLE_INPUT, "Login Tries", "Place in the amount of maximum login tries;\n\n* Once player reached this amount of tries, They will get kicked.", "Establecer", "Volver");
                    }

					case 2: // Secure Tries
                    {
                        ShowPlayerDialog(playerid, DIALOG_SEC_TRIES, DIALOG_STYLE_INPUT, "Secure Tries", "Place in the amount of maximum security question tries;\n\n* Once player reached this amount of tries, They will get kicked.", "Establecer", "Volver");
                    }

					case 3: // AutoLogin
                    {
                        switch(ServerInfo[AutoLogin])
                        {
                            case 0:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has enable the Auto Login feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AutoLogin] = 1;
                                SaveConfig();
                            }
                            case 1:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has disable the Auto Login feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AutoLogin] = 0;
                                SaveConfig();
                            }
                        }
                        ShowSettings(playerid);
                    }

					case 4: // Read Commands
                    {
                        switch(ServerInfo[ReadCmds])
                        {
                            case 0:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has enable the Read Player Commands feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[ReadCmds] = 1;
                                SaveConfig();
                            }
                            case 1:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has disable the Read Player Commands feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[ReadCmds] = 0;
                                SaveConfig();
                            }
                        }
                        ShowSettings(playerid);
                    }

					case 5: // Ping Kicker
                    {
                        ShowPlayerDialog(playerid, DIALOG_PING, DIALOG_STYLE_INPUT, "Maximum Ping", "Place in the maximum ping in the server (E.G.; 1000);\n* Once player reached this ping, they will get warned first then kick.\n\n* To disable the Ping Kicker, simply place 0.", "Establecer", "Volver");
                    }

					case 6: // Ping Warn
                    {
                        ShowPlayerDialog(playerid, DIALOG_PING_WARN, DIALOG_STYLE_INPUT, "Ping Warn", "Place in the maximum ping warning before the player gets kicked;", "Establecer", "Volver");
                    }

					case 7: // Anti Swear
                    {
                        switch(ServerInfo[AntiSwear])
                        {
                            case 0:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has enable the Anti-Swearing feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AntiSwear] = 1;
                                SaveConfig();
                            }
                            case 1:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has disable the Anti-Swearing feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AntiSwear] = 0;
                                SaveConfig();
                            }
                        }
                        ShowSettings(playerid);
                    }

					case 8: // Anti Name
                    {
                        switch(ServerInfo[AntiName])
                        {
                            case 0:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has enable the Anti-Name feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AntiName] = 1;
                                SaveConfig();
                            }
                            case 1:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has disable the Anti-Name feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AntiName] = 0;
                                SaveConfig();
                            }
                        }
                        ShowSettings(playerid);
                    }

					case 9: // Anti Ad
                    {
                        switch(ServerInfo[AntiAd])
                        {
                            case 0:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has enable the Anti-Advertisement feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AntiAd] = 1;
                                SaveConfig();
                            }
                            case 1:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has disable the Anti-Advertisement feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AntiAd] = 0;
                                SaveConfig();
                            }
                        }
                        ShowSettings(playerid);
                    }

					case 10: // Anti Spam
                    {
                        switch(ServerInfo[AntiSpam])
                        {
                            case 0:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has enable the Anti-Spam feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AntiSpam] = 1;
                                SaveConfig();
                            }
                            case 1:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has disable the Anti-Spam feature (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[AntiSpam] = 0;
                                SaveConfig();
                            }
                        }
                        ShowSettings(playerid);
                    }

					case 11: // Read Command Type
                    {
                        switch(ServerInfo[ReadCmd])
                        {
                            case 0:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has switched to the Spectate Mode Command Reading (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[ReadCmd] = 1;
                                SaveConfig();
                            }
                            case 1:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has switched to the Normal Mode Command Reading (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[ReadCmd] = 0;
                                SaveConfig();
                            }
                        }
                        ShowSettings(playerid);
                    }

					case 12: // Register Optional
                    {
                        switch(ServerInfo[RegisterOption])
                        {
                            case 0:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has allow the Player's to skip the Registration. (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[RegisterOption] = 1;
                                SaveConfig();
                            }
                            case 1:
                            {
                                format(string, sizeof(string), "[ADMIN] %s has no-longer allow the Player's to skip the Registration (/jsettings)", pName(playerid));
                                SendAdminMessage(COLOR_YELLOW, string);
                                ServerInfo[RegisterOption] = 0;
                                SaveConfig();
                            }
                        }
                        ShowSettings(playerid);
                    }
                    case 13: // Ranks
                    {
                        ShowRanks(playerid);
                    }
                }
            }
        }

		case DIALOG_WOULDYOU:
        {
            if(response)
            {
                ShowPlayerDialog(playerid, DIALOG_QUESTION, DIALOG_STYLE_INPUT, ""lightblue"Pregunta de seguridad", ""grey"Puedes usar la pregunta de seguridad en caso de olvidar tu password\n\n* Escribe tu pregunta de seguridad:;", "Hecho", "");
            }

			else
            {
                SendClientMessage(playerid, COLOR_RED, "[INFO] Has decidido no ponerle pregunta de seguridad a tu cuenta.");
                SendClientMessage(playerid, COLOR_RED, "GP: {FFFFFF}Bienvenido a Guerra de Pandillas "lightblue"Reborn.");
                SendClientMessage(playerid, COLOR_RED, "GP: {FFFFFF}Presiona las teclas direccionales para cambiar de skin y seleccionar una banda.");
                SendClientMessage(playerid, COLOR_RED, "GP: {FFFFFF}Cuando hayas escogido un skin y banda, presiona la tecla "red"shift"white" para empezar.");
                SendClientMessage(playerid, COLOR_RED, "GP: {FFFFFF}Ve a la casa guía para entender el modo de juego, está ubícada con el ícono de helado en el mapa.");
            }
        }

		case DIALOG_QUESTION:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_QUESTION, DIALOG_STYLE_INPUT, 
                    ""lightblue"Pregunta de seguridad", ""grey"Puedes usar la pregunta de seguridad en caso de olvidar tu password\n\n* Escribe tu pregunta de seguridad:;", "Hecho", "");
            }

			else
            {
                if(strlen(inputtext) < 6 || strlen(inputtext) > 90)
                {
                    ShowPlayerDialog(playerid, DIALOG_QUESTION, DIALOG_STYLE_INPUT, ""lightblue"Pregunta de seguridad", ""grey"Puedes usar la pregunta de seguridad en caso de olvidar tu password\n\n* Escribe tu pregunta de seguridad:;", "Hecho", "");
                    return 1;
                }
                if(strcmp(inputtext, "none", true) == 0)
                {
                    ShowPlayerDialog(playerid, DIALOG_QUESTION, DIALOG_STYLE_INPUT, ""lightblue"Pregunta de seguridad", ""grey"Puedes usar la pregunta de seguridad en caso de olvidar tu password\n\n* Escribe tu pregunta de seguridad:;", "Hecho", "");
                    return 1;
                }

                format(User[playerid][accountQuestion], 129, "%s", inputtext);
                ActPlayerData(playerid,"question");

                ShowPlayerDialog(playerid, DIALOG_ANSWER, DIALOG_STYLE_INPUT, ""lightblue"Respuesta de seguridad", ""grey"Has establecido la pregunta, ahora establece la respuesta a tu pregunta.\n\n* Escribe la respuesta de seguridad:", "Hecho", "");
            }
        }

        case DIALOG_ANSWER:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_ANSWER, DIALOG_STYLE_INPUT, ""lightblue"Respuesta de seguridad", ""grey"Has establecido la pregutna, ahora establece la respuesta a tu pregunta.\n\n* Escribe la respuesta de seguridad:", "Hecho", "");
            }
            else
            {
                if(strlen(inputtext) < 2 || strlen(inputtext) > 90)
                {
                    ShowPlayerDialog(playerid, DIALOG_ANSWER, DIALOG_STYLE_INPUT, ""lightblue"Respuesta de seguridad", ""grey"Has establecido la pregutna, ahora establece la respuesta a tu pregunta.\n\n* Escribe la respuesta de seguridad:", "Hecho", "");
                    return 1;
                }

                new hashanswer[129];
                WP_Hash(hashanswer, sizeof(hashanswer), inputtext);
                format(User[playerid][accountAnswer], 129, "%s", hashanswer);

                SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Has establecido corretamente tu pregunta y respuesta de seguridad, usala en caso de olvidarte tu password.");
                SendClientMessage(playerid, COLOR_RED, "GP: {FFFFFF}Bienvenido a Guerra de Pandillas "lightblue"Reborn.");
                SendClientMessage(playerid, COLOR_RED, "GP: {FFFFFF}Presiona las teclas direccionales para cambiar de skin y seleccionar una banda.");
                SendClientMessage(playerid, COLOR_RED, "GP: {FFFFFF}Cuando hayas escogido un skin y banda, presiona la tecla "red"shift"white" para empezar.");
                SendClientMessage(playerid, COLOR_RED, "GP: {FFFFFF}Ve a la casa guía para entender el modo de juego, está ubícada con el ícono de helado en el mapa.");
                ActPlayerData(playerid,"answer");
                
                SetPlayerScore(playerid, 1);
                ActPlayerData(playerid,"score");

                JBC_GivePlayerMoney(playerid, 4000);
                ActPlayerData(playerid,"chocolate");

            }
        }

        case DIALOG_QUESTION2:
        {
            if(response)
            {
                if(strlen(inputtext) < 6 || strlen(inputtext) > 90)
                {
                    ShowPlayerDialog(playerid, DIALOG_QUESTION2, DIALOG_STYLE_INPUT, ""lightblue"Pregunta de seguridad", ""grey"* Escribe tu nueva pregunta de seguridad:", "Establecer", "Cancelar");
                    return 1;
                }

                format(User[playerid][accountQuestion], 129, "%s", inputtext);
                ActPlayerData(playerid,"question");

                ShowPlayerDialog(playerid, DIALOG_ANSWER2, DIALOG_STYLE_INPUT, ""lightblue"Respuesta de seguridad", ""grey"* Escribe la respuesta de seguridad:", "Establecer", "Volver");
            }
        }
        case DIALOG_ANSWER2:
        {
            if(!response)
            {
                ShowPlayerDialog(playerid, DIALOG_QUESTION2, DIALOG_STYLE_INPUT, ""lightblue"Pregunta de seguridad", ""grey"* Escribe tu nueva pregunta de seguridad:", "Establecer", "Cancelar");
            }
            else
            {
                if(strlen(inputtext) < 2 || strlen(inputtext) > 90)
                {
                    ShowPlayerDialog(playerid, DIALOG_ANSWER2, DIALOG_STYLE_INPUT, ""lightblue"Respuesta de seguridad", ""grey"* Escribe la respuesta de seguridad:", "Establecer", "Volver");
                    return 1;
                }

                new hashanswer[129];
                WP_Hash(hashanswer, 129, inputtext);
                format(User[playerid][accountAnswer], 129, "%s", hashanswer);

                SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Has establecido tu nueva pregunta y respuesta de seguridad.");
                ActPlayerData(playerid,"answer");
            }
        }

        case DIALOG_REGISTER:
        {
            new hashpass[129];

            if(response)
            {
                if(!IsValidPassword(inputtext))
                {
                    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, ""lightblue"Registro de la cuenta", ""red" ¡Bienvenido a Guerra de Pandillas!\n"grey"Tu cuenta no esta registrada en nuestra base de datos.  password. \n\nTIP: Hazla dificil para que nadie pueda hackearla.\nERROR: Invalid Password Symbols.", "Registrar", "Salir");
                    return 0;
                }
                if (strlen(inputtext) < 4 || strlen(inputtext) > 20)
                {
                    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, ""lightblue"Registro de la cuenta", ""red" ¡Bienvenido a Guerra de Pandillas!\n"grey"Tu cuenta no esta registrada en nuestra base de datos. Ingresa tu password. \n\nTIP: Hazla dificil para que nadie pueda hackearla.\nERROR: Password length shouldn't go below 4 and shouldn't go higher 20.", "Registrar", "Salir");
                    return 0;
                }

                WP_Hash(hashpass, 129, inputtext);

                RegisterPlayer(playerid, hashpass);
            }
            else
            {
                if(ServerInfo[RegisterOption])
                {
                    SetPVarString(playerid, "old_name", pName(playerid));
                    format(hashpass, sizeof(hashpass), "%s_%d", pName(playerid), (random(10000) + 1));
                    JBC_SetPlayerName(playerid, hashpass);
                    format(hashpass, sizeof(hashpass), "[INFO] Has salteado el registro. Tu nuevo nick es %s.", pName(playerid));
                    SendClientMessage(playerid, COLOR_RED, hashpass);
                    SendClientMessage(playerid, COLOR_GREEN, "[INFO] Logueate y tu nick volvera a la normalidad.");
                }
                else
                {
                    Kick(playerid);
                }
            }
        }

        case DIALOG_LOGIN:
        {
            new
                hashp[129], 
                string[900],
                msg[128];
            
            if(response)
            {
                WP_Hash(hashp, 129, inputtext);
                
                if(!strcmp(hashp, User[playerid][accountPassword], false))
                {
                    LoginPlayer(playerid);
				    playerLogued[playerid] = true;
                }

                else 
                {
                    User[playerid][WarnLog] ++;
                    
                    format(msg, sizeof(msg), 
                        ""red"Contraseña incorrecta: %d/%d", User[playerid][WarnLog], ServerInfo[LoginWarn]);
                    
                    SendClientMessage(playerid, COLOR_RED, msg);

                    format(string, sizeof(string), 
                        ""red"Bienvenido a Guerra de pandillas reborn.\n\n"white"Tu cuenta está en nuestra base de datos, escribe tu contraseña para ingresar.\n"red"Importante: "white"Si no eres el propietario de esta cuenta, sal del juego, y escribe tu nick para volver a ingresar.\n\n"red" Contraseña incorrecta, intentos: %d/%d", User[playerid][WarnLog], ServerInfo[LoginWarn]);

                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Ingreso", string, "Ingresar", "Olvidado");
                    
                    if(User[playerid][WarnLog] >= ServerInfo[LoginWarn])
                    {
                        ShowPlayerDialog(playerid, DIALOG_FAIL, DIALOG_STYLE_MSGBOX,  ""red"Expulsado", ""red"[GP] "white"La contraseña ingresada es incorrecta. Ingresa nuevamente al servidor \ny vuelve a intentarlo.", "Cerrar", "");
                        printf("Advertencias de logueo: %d/%d", User[playerid][WarnLog], ServerInfo[LoginWarn]);                       
                        return Kick(playerid);
                    }
                }
            }

            else
            {
                    format(string, sizeof(string), ""white"Responde la pregunta de seguridad para continuar.\n"red"%s\n"white"presiona 'salir' para cancelar.", User[playerid][accountQuestion]);
                    ShowPlayerDialog(playerid, DIALOG_FORGET, DIALOG_STYLE_INPUT, ""red"Pregunta de seguridad", string, "Continuar", "Salir");

            }
        }

        case DIALOG_FORGET:
        {
            if(!response)
            {
                Kick(playerid);
            }

            else
            {
                new hashanswer[129];
                WP_Hash(hashanswer, 129, inputtext);

                if(strcmp(User[playerid][accountAnswer], hashanswer, true) == 0)
                {
                    LoginPlayer(playerid);
                    SendClientMessage(playerid, -1, "[INFO] Acceso garantizado");
                    playerLogued[playerid] = true;
                }
                
                else
                {
                    new string[900];

                    User[playerid][WarnLog]++;

                    if(User[playerid][WarnLog] >= ServerInfo[SecureWarn])
                    {
                        ShowPlayerDialog(playerid, DIALOG_BEGIN, DIALOG_STYLE_MSGBOX, ""white"Opciones de recuperación", ""grey"[INFO] Has sido expulsado del servidor porque tu respuesta fué incorrecta,\nvuelve a intentarlo.", "Cerrar", "");
                        Kick(playerid);
                        return 0;
                    }

                    format(string, sizeof(string), "[ERROR] Respuesta incorrecta - [%d/%d intentos]", User[playerid][WarnLog], ServerInfo[SecureWarn]);
                    SendClientMessage(playerid, COLOR_RED, string);

					format(string, sizeof(string), ""white"Si olvidaste tu contraseña, responde a la pregunta de seguridad, presiona 'salir' para cancelar.\n\n"red"%s\n\n"white"Intentos fallidos: "red"%d/%d.", User[playerid][accountQuestion], User[playerid][WarnLog], ServerInfo[SecureWarn]);
                    ShowPlayerDialog(playerid, DIALOG_FORGET, DIALOG_STYLE_INPUT, ""red"Pregunta de seguridad", string, "Responder", "Salir");
                }
            }
        }

		case TOP_DIALOG:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:
					{
			    		new string[128], query[256];
					    SendClientMessage(playerid,COLOR_LIGHTBLUE,"[INFO] Mostrando a los Jugadores con mas Kills en el servidor.");
					    new SecondString[128];
					    new DBResult:result;
					    new DBResult:result2;
					    new outstring[128*2];
					    format(query,sizeof(query),"SELECT `username` FROM `users` ORDER BY (`kills` * 1) DESC limit 10");
					    result = db_query(DB_USERS,query);
					    format(query,sizeof(query),"SELECT `kills` FROM `users` ORDER BY (`kills` * 1) DESC limit 10");
					    result2 = db_query(DB_USERS,query);
					    strcat(outstring, "Nº\tKills\tNick\n");

						for(new a;a<db_num_rows(result);a++)//what we have now is 10 rows in the DB_USERS result, so we'll do a loop to show each one on a new line.
					    {
					        db_get_field(result,0,string,128);//get the result of the DB_USERS and format it into a string
					        db_get_field(result2,0,SecondString,128);//get the `stat` column from the row of the first player.
					        format(string,sizeof(string),"%d\t%s\t%s\n",a+1,SecondString,string);//it's a+1 because the result starts at 0, this will display as "1. Name Stat: X".
					        strcat(outstring, string);
					        db_next_row(result);//this function changes to the next row down, then when it goes into the next loop cycle it'll get the second top player and so forth.
					        db_next_row(result2);//remember to free any results you don't need anymore
					    }
					    
				    	db_free_result(result);
				    	db_free_result(result2);
				    	ShowPlayerDialog(playerid,     0, DIALOG_STYLE_TABLIST_HEADERS, "Top 10 Asesinos",outstring,"Cerrar", "");
				    	return 1;
		}

		case 1:
		{
	    	new string[128], query[256];
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,"[INFO] Mostrando a los jugadores mas muertos del servidor.");
		    new SecondString[128];
		    new DBResult:result;
		    new DBResult:result2;
		    new outstring[128*2];

		    format(query,sizeof(query),"SELECT `username` FROM `users` ORDER BY (`deaths` * 1) DESC limit 10");
		    result = db_query(DB_USERS,query);
		    format(query,sizeof(query),"SELECT `deaths` FROM `users` ORDER BY (`deaths` * 1) DESC limit 10");
		    result2 = db_query(DB_USERS,query);
		    strcat(outstring, "Nº\tDeaths\tNick\n");

			for(new a;a<db_num_rows(result);a++)//what we have now is 10 rows in the DB_USERS result, so we'll do a loop to show each one on a new line.
		    {
		        db_get_field(result,0,string,128);//get the result of the DB_USERS and format it into a string
		        db_get_field(result2,0,SecondString,128);//get the `stat` column from the row of the first player.
		        format(string,sizeof(string),"%d\t%s\t%s\n",a+1,SecondString,string);//it's a+1 because the result starts at 0, this will display as "1. Name Stat: X".
		        strcat(outstring, string);
		        db_next_row(result);//this function changes to the next row down, then when it goes into the next loop cycle it'll get the second top player and so forth.
		        db_next_row(result2);//remember to free any results you don't need anymore
		    }

			db_free_result(result);
		    db_free_result(result2);
		    ShowPlayerDialog(playerid,     0, DIALOG_STYLE_TABLIST_HEADERS, "Top 10 Advertidos",outstring,"Cerrar", "");

	        return 1;
		}

		case 2:
		{
		    new string[128], query[256];
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,"[INFO] Mostrando jugadores con advertencias.");
		    new SecondString[128];
		    new DBResult:result;
		    new DBResult:result2;
		    new outstring[128*2];

			format(query,sizeof(query),"SELECT `username` FROM `users` ORDER BY (`warn` * 1) DESC limit 10");
		    result = db_query(DB_USERS,query);
		    format(query,sizeof(query),"SELECT `warn` FROM `users` ORDER BY (`warn` * 1) DESC limit 10");
		    result2 = db_query(DB_USERS,query);
		    strcat(outstring, "Nº\tAdvertencias\tNick\n");

			for(new a;a<db_num_rows(result);a++)//what we have now is 10 rows in the DB_USERS result, so we'll do a loop to show each one on a new line.
		    {
		        db_get_field(result,0,string,128);//get the result of the DB_USERS and format it into a string
		        db_get_field(result2,0,SecondString,128);//get the `stat` column from the row of the first player.
		        format(string,sizeof(string),"%d\t%s\t%s\n",a+1,SecondString,string);//it's a+1 because the result starts at 0, this will display as "1. Name Stat: X".
		        strcat(outstring, string);
		        db_next_row(result);//this function changes to the next row down, then when it goes into the next loop cycle it'll get the second top player and so forth.
		        db_next_row(result2);//remember to free any results you don't need anymore
		    }

			db_free_result(result);
		    db_free_result(result2);
		    ShowPlayerDialog(playerid,     0, DIALOG_STYLE_TABLIST_HEADERS, "Top 10 Advertidos",outstring,"Cerrar", "");
		    return 1;
		}

	    case 3:
		{
	    	new string[128], query[256];
	    	SendClientMessage(playerid,COLOR_LIGHTBLUE,"[INFO] Mostrando jugadores con mas horas jugadas.");
	    	new SecondString[128];
	    	new DBResult:result;
	    	new DBResult:result2;
	    	new outstring[128*2];

			format(query,sizeof(query),"SELECT `username` FROM `users` ORDER BY (`hours` * 1) DESC limit 10");
	    	result = db_query(DB_USERS,query);

			format(query,sizeof(query),"SELECT `hours` FROM `users` ORDER BY (`hours` * 1) DESC limit 10");
	    	result2 = db_query(DB_USERS,query);
	    	strcat(outstring, "Nº\tHoras\tNick\n");

			for(new a;a<db_num_rows(result);a++)//what we have now is 10 rows in the DB_USERS result, so we'll do a loop to show each one on a new line.
	    	{
	        	db_get_field(result,0,string,128);//get the result of the DB_USERS and format it into a string
	        	db_get_field(result2,0,SecondString,128);//get the `stat` column from the row of the first player.
	        	format(string,sizeof(string),"%d\t%s\t%s\n",a+1,SecondString,string);//it's a+1 because the result starts at 0, this will display as "1. Name Stat: X".
	        	strcat(outstring, string);
	        	db_next_row(result);//this function changes to the next row down, then when it goes into the next loop cycle it'll get the second top player and so forth.
	        	db_next_row(result2);//remember to free any results you don't need anymore
	    	}
	    	db_free_result(result);
	    	db_free_result(result2);

			ShowPlayerDialog(playerid,     0, DIALOG_STYLE_TABLIST_HEADERS, "Top 10 Horas jugadas",outstring,"Cerrar", "");
	    	return 1;
	    }

		case 4:
		{
	    new string[128],
			query[256]
			;

		SendClientMessage(playerid,COLOR_LIGHTBLUE,"[INFO] Mostrando jugadores con mas Score.");

		new SecondString[128];
	    new DBResult:result;
	    new DBResult:result2;
	    new outstring[128*2];

		format(query,sizeof(query),"SELECT `username` FROM `users` ORDER BY (`score` * 1) DESC limit 10");
	    result = db_query(DB_USERS,query);

		format(query,sizeof(query),"SELECT `score` FROM `users` ORDER BY (`score` * 1) DESC limit 10");
	    result2 = db_query(DB_USERS,query);

		strcat(outstring, "Nº\tScore\tNick\n");

		for(new a;a<db_num_rows(result);a++)//what we have now is 10 rows in the DB_USERS result, so we'll do a loop to show each one on a new line.
	    {
	        db_get_field(result,0,string,128);//get the result of the DB_USERS and format it into a string
	        db_get_field(result2,0,SecondString,128);//get the `stat` column from the row of the first player.
	        format(string,sizeof(string),"%d\t%s\t%s\n",a+1,SecondString,string);//it's a+1 because the result starts at 0, this will display as "1. Name Stat: X".
	        strcat(outstring, string);
	        db_next_row(result);//this function changes to the next row down, then when it goes into the next loop cycle it'll get the second top player and so forth.
	        db_next_row(result2);//remember to free any results you don't need anymore
	    }

		db_free_result(result);
	    db_free_result(result2);

	    ShowPlayerDialog(playerid,     0 , DIALOG_STYLE_TABLIST_HEADERS, "Top 10 mas puntuación del servidor",outstring,"Cerrar", "");

		return 1;
	    }

	    case 5:
		{
		    new string[128], query[256];
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,"[INFO] Mostrando jugadores con mas dinero.");

			new SecondString[128];
		    new DBResult:result;
		    new DBResult:result2;
		    new outstring[128*2];

			format(query,sizeof(query),"SELECT `username` FROM `users` ORDER BY (`chocolate` * 1) DESC limit 10");
		    result = db_query(DB_USERS,query);

			format(query,sizeof(query),"SELECT `chocolate` FROM `users` ORDER BY (`chocolate` * 1) DESC limit 10");
		    result2 = db_query(DB_USERS,query);

			strcat(outstring, "Nº\tDinero\tNick\n");
		    for(new a;a<db_num_rows(result);a++)//what we have now is 10 rows in the DB_USERS result, so we'll do a loop to show each one on a new line.
		    {
		        db_get_field(result,0,string,128);//get the result of the DB_USERS and format it into a string
		        db_get_field(result2,0,SecondString,128);//get the `stat` column from the row of the first player.
		        format(string,sizeof(string),"%d\t%s\t%s\n",a+1,SecondString,string);//it's a+1 because the result starts at 0, this will display as "1. Name Stat: X".
		        strcat(outstring, string);
		        db_next_row(result);//this function changes to the next row down, then when it goes into the next loop cycle it'll get the second top player and so forth.
		        db_next_row(result2);//remember to free any results you don't need anymore
		    }

			db_free_result(result);
		    db_free_result(result2);
		    ShowPlayerDialog(playerid,     0, DIALOG_STYLE_TABLIST_HEADERS, "Top 10 Dinero",outstring,"Cerrar", "");
		    return 1;
	    }

	    case 6:
	    {
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,"[INFO] Mostrando jugadores con mas ratio.");
		    new query[95],Cuadro[2034],Linea[40],Nick[22],Kills[8],Deaths[8],DBResult:resultado,rows;
		    format(query,sizeof(query),"SELECT `username`,`kills`,`deaths` FROM `users` ORDER BY (`kills`/`deaths` * 1) DESC limit 10");
		    resultado = db_query(DB_USERS, query);

		    rows = db_num_rows(resultado);
		    if(rows)
		    {
		    strcat(Cuadro, "Nº\tRatio\tNick\n");
		    for(new i = 0; i < rows; i ++)
		    {
			    db_get_field_assoc(resultado, "username", Nick, 22);
		    	db_get_field_assoc(resultado, "kills", Kills, 8);
		    	db_get_field_assoc(resultado, "deaths", Deaths, 8);
		    	new Float:ratio = (float(strval(Kills))/float(strval(Deaths)));
		    	format(Linea, sizeof(Linea), "%d\t%.2f\t%s\n",i+1, ratio, Nick);
		    	strcat(Cuadro, Linea);
		    	db_next_row(resultado);
	   	 	}
	    	ShowPlayerDialog(playerid,0, DIALOG_STYLE_TABLIST_HEADERS, "Top 10 Ratio", Cuadro, "Cerrar", "");
	    	}
	    	db_free_result(resultado);
	    }

		case 7: //rachas
	    {
			new string[128], query[256];
	     	SendClientMessage(playerid,COLOR_LIGHTBLUE,"[INFO] Mostrando jugadores con las rachas mas largas.");

			new SecondString[128];
		    new DBResult:result;
		    new DBResult:result2;
		    new outstring[128*2];
		    format(query,sizeof(query),"SELECT `username` FROM `users` ORDER BY (`racha` * 1) DESC limit 10");
		    result = db_query(DB_USERS,query);

			format(query,sizeof(query),"SELECT `racha` FROM `users` ORDER BY (`racha` * 1) DESC limit 10");
		    result2 = db_query(DB_USERS,query);

			strcat(outstring, "Nº\tRacha\tNick\n");

			for(new a;a<db_num_rows(result);a++)//what we have now is 10 rows in the DB_USERS result, so we'll do a loop to show each one on a new line.
		    {
		        db_get_field(result,0,string,128);//get the result of the DB_USERS and format it into a string
		        db_get_field(result2,0,SecondString,128);//get the `stat` column from the row of the first player.
		        format(string,sizeof(string),"%d\t%s\t%s\n",a+1,SecondString,string);//it's a+1 because the result starts at 0, this will display as "1. Name Stat: X".
		        strcat(outstring, string);
		        db_next_row(result);//this function changes to the next row down, then when it goes into the next loop cycle it'll get the second top player and so forth.
		        db_next_row(result2);//remember to free any results you don't need anymore
		    }
		    db_free_result(result);
		    db_free_result(result2);
		    ShowPlayerDialog(playerid,     0 , DIALOG_STYLE_TABLIST_HEADERS, "Top 10 las rachas mas largas",outstring,"Cerrar", "");
		    return 1;
	    }
	    /*case 8: //Top de Clanes
	    {
		    new query[114],
				Cuadro[2500],
				Linea[43],
				Tag[7],
				Color[3],
				Asesinatos[7],
				Muertes[7],
				DBResult:resultado,rows
				;

			format(query,sizeof(query),"SELECT `Tag`,`Asesinatos`,`Muertes`,`Color` FROM `Clanes` WHERE `ClanID` > 0 ORDER BY `Asesinatos` DESC limit 50");
		    resultado = db_query(DB_CLANS, query);
		    rows = db_num_rows(resultado);

			if(rows == 0)
				return SendClientMessage(playerid,0xFF0000FF, "ERROR: No hay clanes.");

			if(rows)
		    {
		    	strcat(Cuadro, "Nº\tClan\tAsesinatos\tMuertes\n");
		    	for(new i = 0; i < rows; i ++)
		    	{
		    		db_get_field_assoc(resultado, "Tag", Tag, 7);
		    		db_get_field_assoc(resultado, "Asesinatos", Asesinatos, 7);
		    		db_get_field_assoc(resultado, "Muertes", Muertes, 7);
		    		db_get_field_assoc(resultado, "Color", Color, 3);
		    		format(Linea, sizeof(Linea), "%d.\t{%s}[%s]\t%d\t%d\n",i+1, ccolor[strval(Color)],Tag, strval(Asesinatos),strval(Muertes));
		    		strcat(Cuadro, Linea);
		    		db_next_row(resultado);
		    	}
		    	ShowPlayerDialog(playerid,0, DIALOG_STYLE_TABLIST_HEADERS, "Top 10 Clanes", Cuadro, "Cerrar", "");
		    }
    		db_free_result(resultado);
        }*/

			}
				}

				else
    			{
   					print("Cancelaste la selección de item");
       			}
        }

        case DIALOG_COLORS:
        {
            new string[120], id = GetPVarInt(playerid, "_Colors_");

            switch( response )
            {
                case 0:
                {
                    DeletePVar(playerid, "_Colors_");
                    SendClientMessage(playerid, -1, "Colour setting has been cancelled.");
                }
                case 1:
                {
                    switch( listitem )
                    {
                        case 0:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Negro", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_BLACK);
                            DeletePVar(playerid, "_Colors_");
                        }
                        case 1:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Blanco", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_WHITE);
                            DeletePVar(playerid, "_Colors_");
                        }
                        case 2:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Rojo", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_RED);
                            DeletePVar(playerid, "_Colors_");
                        }
                        case 3:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Naranja", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_ORANGE);
                            DeletePVar(playerid, "_Colors_");
                        }
                        case 4:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Amarillo", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_YELLOW);
                            DeletePVar(playerid, "_Colors_");
                        }
                        case 5:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Verde", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_GREEN);
                            DeletePVar(playerid, "_Colors_");
                        }
                        case 6:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Azul", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_BLUE);
                            DeletePVar(playerid, "_Colors_");
                        }
                        case 7:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Violeta", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_PURPLE);
                            DeletePVar(playerid, "_Colors_");
                        }
                        case 8:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Marron", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_BROWN);
                            DeletePVar(playerid, "_Colors_");
                        }
                        case 9:
                        {
                            format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu name color a Rosa", pName(playerid));
                            SendClientMessage(id, COLOR_YELLOW, string);
                            format(string, sizeof(string), "Color Name for Player %s has been set.", pName(id));
                            SendClientMessage(playerid, COLOR_YELLOW, string);
                            SetPlayerColor(id, COLOR_PINK);
                            DeletePVar(playerid, "_Colors_");
                        }
                    }
                }
            }
        }
    }
    return 0;
}
//TODOS LOS COMANDOS
//COMANDOS VIP NIVEL 1-3
#if VipSystem == true
CMD:vcmds(playerid, params[])
{
	        	
 	VipCheck(playerid, 0);
  	//CMDS VIP LVL 1
   	new s[2500], cb[64];
   	format(cb, sizeof(cb), ""vip1_color"-> %s\n", ServerInfo[VipRank1]);
   	strcat(s, cb);
    strcat(s, ""green" - "white"Acceso Exclusivo al equipo 'mercenarios'.\n");
    strcat(s, ""green" - "white"Chaleco +30 en cualquier /evento.\n");
    strcat(s, ""green" - "white"+30 por ciento de chaleco al spawnear (donde sea).\n");
    strcat(s, ""green" - "white" /Vbici, /SetMyTime, /vDestroycar\n");
    strcat(s, ""green" - "white"VIP Chat: "orange"* (uso: *Hola!)\n");
    strcat(s, ""green" - "white"¡Habla como un VIP! "orange"usando /vsay\n");
    strcat(s, ""green" - "white"Mensaje de bienvenida al loguearse a todo el servidor(serás conocido).\n");
    strcat(s, ""green" - "white"Acceso a artículos especiales en la tienda.\n");
    strcat(s, ""green" - "white"Premio por kill mejorado +$500.\n");
	//VIP CMDS 2
 	format(cb, sizeof(cb), ""vip2_color"-> %s\n", ServerInfo[VipRank2]);
  	strcat(s, cb);   
    strcat(s, ""green" - "white"Acceso exclusivo al teleport /chilliad.\n");    
    strcat(s, ""green" - "white"+70 por ciento de chaleco al spawnear (donde sea).\n");
    strcat(s, ""green" - "white"Chaleco +70 en cualquier /evento.\n");    
    strcat(s, ""green" - "white"Premio por kills mejorado +$1000\n");
    strcat(s, ""green" - "white"Score mejorado en +2.\n");
    strcat(s, ""green" - "white"Descuento del 25% en la tienda en cualquier sección.\n");
    strcat(s, ""green" - "white"Premio por kill mejorado +1000.\n");
    strcat(s, ""green" - "white"/vGoto /vRepair /vHeli /vBoat /vSetColor, /vAddnos /vAnuncio\n");
    strcat(s, ""green" - "white"/vBike /vCar /vSavekin /vUseSkin /patinar /vWeaps /vPlay\n");
    strcat(s, ""green" - "white"/vMsg /vGoto /vRepair\n");      

	ShowPlayerDialog(playerid, DIALOG_1, DIALOG_STYLE_MSGBOX, ""grey"Comandos VIP", s, "Cerrar", "");

	return 1;
}

//VIP LVL 1
CMD:vbici(playerid, params[])
{
	        	
	VipCheck(playerid,1);
	if(IsValidVehicle(User[playerid][pCar]) && !IsPlayerAdmin(playerid))
	{
		EraseVeh(User[playerid][pCar]);
	}

	new VehicleID;
  	new Float:X, Float:Y, Float:Z;
  	new Float:Angle, int1;

	GetPlayerPos(playerid, X, Y, Z);
  	GetPlayerFacingAngle(playerid, Angle);
	int1 = GetPlayerInterior(playerid);
  	VehicleID = JBC_CreateVehicle(481, X+3,Y,Z, Angle, random(255), random(255), -1);

	PutPlayerInVehicle(playerid, VehicleID, 0);
	LinkVehicleToInterior(VehicleID, int1);
	SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(playerid));
	
    User[playerid][pCar] = VehicleID;
	
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* BMX Spawneado satisfactoriamente.");
	return 1;
}
        
CMD:setmytime(playerid, params[])
{
	        	
 	VipCheck(playerid,1);
  	new time, string[128];

	if(sscanf(params, "d", time))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setmytime [hora]");

	format(string, sizeof(string), "Has puesto tu hora en las %d:00", time);
  	SendClientMessage(playerid, COLOR_RED, string);
   	SetPlayerTime(playerid, time, 0);
    return 1;
}

CMD:vsay(playerid, params[])
{
	        	
 	VipCheck(playerid, 1);

	new string[128];

	if(isnull(params))
 		return SendClientMessage(playerid, COLOR_RED, "USO: /vsay [mensaje como vsay]");

	format(string, sizeof(string), "|-[%s] %s: {FFFFFF}%s",GetVIPRank(accountVip[playerid]), pName(playerid), params);
 	SendClientMessageToAll(COLOR_ORANGE, string);

	for(new i = 0; i < MAX_PLAYERS; i++) 
 	{
  		PlayerPlaySound(i,1057, 0.0, 0.0, 0.0); 
   	}
   	return 1;
}
    
CMD:vdestroycar(playerid, params[])
{
	        	
	VipCheck(playerid, 1);
 	if(IsPlayerInVehicle(playerid, vehicleOwner[playerid]))
	 	return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes destruir este vehículo, pertenece al sistema de autos.");

	DelVehicle(GetPlayerVehicleID(playerid));
   	return 1;
}
//VIP LVL 2
CMD:vbike(playerid, params[])
{
 	        	
  	VipCheck(playerid, 2);

    if(IsValidVehicle(User[playerid][pCar]))
    {
        EraseVeh(User[playerid][pCar]);
            
        new VehicleID;
        new Float:X, Float:Y, Float:Z;
        new Float:Angle, int1;
            
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, Angle);
            
        int1 = GetPlayerInterior(playerid);
        VehicleID = JBC_CreateVehicle(522, X+3,Y,Z, Angle, random(255), random(255), -1);
            
        LinkVehicleToInterior(VehicleID, int1);
        SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(playerid));
            
        User[playerid][pCar] = VehicleID;
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "[INFO] Has spawneado un NRG.");
        
    }
    return 1;
}

CMD:vcar(playerid, params[])
{
            	
    VipCheck(playerid, 2);

    if(IsValidVehicle(User[playerid][pCar]) && !IsPlayerAdmin(playerid))
    {    
        EraseVeh(User[playerid][pCar]);
        
        new VehicleID;
        new Float:X, Float:Y, Float:Z;
        new Float:Angle, int1;
        
        GetPlayerPos(playerid, X, Y, Z);
        GetPlayerFacingAngle(playerid, Angle);
        
        int1 = GetPlayerInterior(playerid);
        VehicleID = JBC_CreateVehicle(411, X+3,Y,Z, Angle, random(255), random(255), -1);
        
        LinkVehicleToInterior(VehicleID, int1);
        SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(playerid));
        
        User[playerid][pCar] = VehicleID;
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "[INFO] Tu NRG-500 está lista, dísfrutala");
    }
    return 1;
}    

CMD:vsaveskin(playerid, params[])
{
            	
    VipCheck(playerid, 2);

    new string[128], SkinID;

    if(sscanf(params, "d", SkinID))
        return SendClientMessage(playerid, COLOR_RED, "USO: /vsaveskin [skinid]");

    if(SkinID < 0 || SkinID == 74 || SkinID > 311)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] SkinID no valido.");

    User[playerid][accountSkin] = SkinID;
    ActPlayerData(playerid,"skin");

    format(string, sizeof(string), "[INFO] Has guardado el SKIN ID: %d", SkinID);
    SendClientMessage(playerid, -1, string);
        
    SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Para cargar el Skin, usa /Vuseskin (para dejar el SKIN, usa el mismo comando)");
    return 1;
}

CMD:vuseskin(playerid, params[])
{
            	
    VipCheck(playerid, 2);

    if(User[playerid][accountSkin] == -1)
        return 
            SendClientMessage(playerid, COLOR_RED, "[ERROR] No tienes un Skin guardado. Usa primero /Vsaveskin + SkinID para guardarlo primero.");

    switch(User[playerid][accountUseSkin])
    {
        case false:
        {
            User[playerid][accountUseSkin] = true;
            JBC_SetPlayerSkin(playerid, User[playerid][accountSkin]);
            SendClientMessage(playerid, COLOR_GREEN, "[INFO] Ya estas usando tu Skin favorito.");
        }
        case true:
        {
            User[playerid][accountUseSkin] = false;
            SendClientMessage(playerid, COLOR_RED, "[INFO] Tu Skin favorito no estara disponible al spawnear.");
        }
    }
    ActPlayerData(playerid,"useskin");
    return 1;
}

CMD:patinar(playerid, params[])
{
   VipCheck(playerid, 2);
   if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
   {
        ApplyAnimation(playerid, "SKATE", "skate_sprint", 4.1, 1, 5, 1, 1, 1 , 1);
        SendClientMessage(playerid, -1, ""blue"[VIP] {FFFFFF}Estás patinando, para dejar de hacerlo presiona la tecla"red" shift.");
   }
   return 1;
}

//VIP LVL 3

CMD:vplay(playerid, params[])
{
    VipCheck(playerid, 2);
    new song[128];
    
    if(sscanf(params, "s[128]", song)) 
        return SendClientMessage(playerid, -1, "USO: /vplay [Song url]");
    
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        PlayAudioStreamForPlayer(i, song);
    }
    
    new str[71];
    
    format(str, sizeof(str), "Musica~ El usuario vip %s(%d) ha puesto un audio.", pName(playerid), playerid);    
    SendClientMessageToAll(0xB5B9FFFF, str);
    SendClientMessageToAll(0xB5B9FFFF, "Musica~ Si no te gusta, usa /stop para sacarlo.");
    return 1;
}

CMD:stop(playerid, params[])
{
            	
    StopAudioStreamForPlayer(playerid);
    return 1;
}

CMD:vweaps(playerid, params[])
{
            	
    VipCheck(playerid, 2);
    
    new 
        option[9];

    if(vweaps[playerid] == true)
        return SendClientMessage(playerid,COLOR_RED, "[ERROR] Sólo puedes utilizar armas VIP una vez por vida.");

    if(sscanf(params, "s[9]", option)) 
        return SendClientMessage(playerid, -1, "USO: /vweaps [opción 1-2]");

    if(strcmp(option, "1", true) ==0)
    {
        JBC_ResetPlayerWeapons(playerid);
        JBC_GivePlayerWeapon(playerid, 27, 1000);
        JBC_GivePlayerWeapon(playerid, 31, 1000);
        JBC_GivePlayerWeapon(playerid, 24, 1000);
        JBC_GivePlayerWeapon(playerid, 34, 1000);
        JBC_GivePlayerWeapon(playerid, 8, 1);
        JBC_GivePlayerWeapon(playerid, 16, 3);
        JBC_GivePlayerWeapon(playerid, 29, 1000);      
    }

    if(strcmp(option, "2", true) ==0)
    {
        JBC_ResetPlayerWeapons(playerid);
        JBC_GivePlayerWeapon(playerid, 28, 1000);
        JBC_GivePlayerWeapon(playerid, 30, 1000);
        JBC_GivePlayerWeapon(playerid, 31, 1000);
        JBC_GivePlayerWeapon(playerid, 7, 1);
        JBC_GivePlayerWeapon(playerid, 28, 500);
        JBC_GivePlayerWeapon(playerid, 35, 3);    
    }
    SendClientMessage(playerid, COLOR_YELLOW, "[VIPS]{FFFFFF} Has recibido un {FF8000}Pack de Armas VIP 2.");
    vweaps[playerid] = true;
    return 1;
}
    
CMD:vmsg(playerid, params[])
{
            	
    VipCheck(playerid, 2);

    if(vipMessage[playerid] == false)
    {
        vipMessage[playerid] = true;
        return SendClientMessage(playerid, 0x00FF00FF, "Mensaje VIP Activado, ahora al hablar en el chat, se mostrará el tag VIP.");
    }

    else
    {
        vipMessage[playerid] = false;
    }
    return SendClientMessage(playerid, 0x00FF00FF, "Mensaje VIP Desactivado, ahora al hablar en el chat no se mostrará el tag VIP.");
}

CMD:vaddnos(playerid, params[])
{
            	
    VipCheck(playerid, 2);

    if(CheckRace(playerid) == 1)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en carreras.");

    if(IsPlayerInAnyVehicle(playerid))
    {
        switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
        {
            case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
                SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes agregar nitro a este vehículo..");
        }
        JBC_AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
    }
    else
        SendClientMessage(playerid, COLOR_RED, "[ERROR] Debes estar dentro de un vehículo para usarlo.");
    return 1;
}

CMD:vgoto(playerid, params[])
{
            	
    VipCheck(playerid, 2);

    new string[128], Float:x, Float:y, Float:z;
    new id;

    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /goto [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[id][accountAdmin] == 5)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    GetPlayerPos(id, x, y, z);

    SetPlayerInterior(playerid, GetPlayerInterior(id));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));

    if(GetPlayerState(playerid) == 2)
    {
        JBC_SetVehiclePos(GetPlayerVehicleID(playerid), x+3, y, z);
        LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(id));
        SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(id));
    }
    
    else JBC_SetPlayerPos(playerid, x+2, y, z);

    format(string, sizeof(string), "[INFO] te has teletransportado hacia %s.", pName(id));
    SendClientMessage(playerid, COLOR_ORANGE, string);
    
    format(string, sizeof(string), "[INFO] %s [VIP] se ha teletransportado a tu posición.", pName(playerid));
    SendClientMessage(playerid, COLOR_ORANGE, string);
    
    format(string, sizeof(playerid), "[VGOTO] %s se fué con %s.", pName(playerid),pName(id));
    SaveLog("vabuso.txt", string);
    return 1;
}

CMD:vrepair(playerid, params[])
{
            	
    VipCheck(playerid, 2);
    new id,
    string[128];
    
    if(VipCarRepaired[playerid] == true)
        return 
            format(string, 128, "[GP] "white"Necesitas esperar "green"%d"white" segundos para volver a reparar el vehículo.", TimeRepair[playerid]),
                     SendClientMessage(playerid, COLOR_RED, string);
    
    if(CheckEvent(playerid) == 1)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar el comando en eventos.");

    if(!sscanf(params, "u", id))
    {
        if(id == INVALID_PLAYER_ID)
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] Jugador no conectado.");


        if(User[playerid][accountAdmin] < User[id][accountAdmin])
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un administrador de mayor rango.");

        if(!IsPlayerInAnyVehicle(id)) 
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No estás dentro de un vehículo.");
        
        JBC_RepairVehicle(GetPlayerVehicleID(id));
        JBC_SetVehicleHealth(GetPlayerVehicleID(id),1250.0);
        
        format(string, sizeof(string), "[INFO] Has arreglado el vehículo de %s[ID:%d].", pName(id),id);
        SendClientMessage(playerid, COLOR_ORANGE, string);
        
        format(string, sizeof(string), "[VIP] %s ha arreglado tu vehículo.", pName(playerid));
        SendClientMessage(id, COLOR_ORANGE, string);
        
        VipCarRepaired[playerid] = true;
        TimeRepair[playerid] = 30;
        SetTimerEx("OnPlayerVipRepairVehicle", min(1), true, "i", playerid);

    }
    
    else
    {

        if(!IsPlayerInAnyVehicle(playerid))
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No estás dentro de un vehículo.");
        
        JBC_RepairVehicle(GetPlayerVehicleID(playerid));
        JBC_SetVehicleHealth(GetPlayerVehicleID(playerid),1250.0);
        
        SendClientMessage(playerid, COLOR_YELLOW, "Vehículo arreglado!");
        SendClientMessage(playerid, -1, "Puedes usar este comando en los usuarios!"orange"/vrepair [playerid]");
        
        VipCarRepaired[playerid] = true;
        TimeRepair[playerid] = 30;
        SetTimerEx("OnPlayerVipRepairVehicle", 1110, true, "i", playerid);
    }
    return 1;
}

CMD:vheli(playerid, params[])
{
            	
    VipCheck(playerid, 2);

    if(IsValidVehicle(User[playerid][pCar]) && !IsPlayerAdmin(playerid))
        EraseVeh(User[playerid][pCar]);
    
    new VehicleID;
    new Float:X, Float:Y, Float:Z;
    new Float:Angle, int1;
    
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, Angle);
    
    int1 = GetPlayerInterior(playerid);
    VehicleID = JBC_CreateVehicle(487, X+3,Y,Z, Angle, random(255), random(255), -1);
    
    PutPlayerInVehicle(playerid, VehicleID, 0);
    LinkVehicleToInterior(VehicleID, int1);
    SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(playerid));
    
    User[playerid][pCar] = VehicleID;
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* MAVERICK Spawneado satisfactoriamente.");
    return 1;
}

CMD:vanuncio(playerid, params[])
{
            	
    VipCheck(playerid, 2);
    new texto[128];
        
    if(sscanf(params, "s[128]", params[0])) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /vanuncio [mensaje para todos]");
    
    if(!CheckValidDigit(params[0])) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El anuncio contiene acentos ó digitos invalidos.");
        
    format(texto, sizeof(texto), "~n~~n~~n~~w~~h~%s~n~~y~[VIP %s]",params[0], pName(playerid));
    GameTextForAll(texto, 3000, 3);
    
    format(texto, sizeof(texto), "[ANN] %s announce: %s", pName(playerid), params[0]);
    SaveLog("announces.txt", texto);
    return 1;
}

CMD:vsetcolor(playerid, params[])
{
            	
    VipCheck(playerid, 2);

    new id;
    if(sscanf(params, "u", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setcolor [playerid]");

    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    SetPVarInt(playerid, "_Colors_", id);

    ShowPlayerDialog(playerid, DIALOG_COLORS, DIALOG_STYLE_LIST, ""orange"Colors", ""black"Black\n"white"White\n"red"Red\n"orange"Orange\n"yellow"Yellow\n"green"Green\n"blue"Blue\n"purple"Purple\n"brown"Brown\n"pink"Pink", "Establecer", "Cancelar");
    return 1;
}

CMD:vboat(playerid, params[])
{
            	
    VipCheck(playerid,2);

    if(IsValidVehicle(User[playerid][pCar]) && !IsPlayerAdmin(playerid))
        EraseVeh(User[playerid][pCar]);
    
    new VehicleID;
    new Float:X, Float:Y, Float:Z;
    new Float:Angle, int1;
    
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, Angle);
    
    int1 = GetPlayerInterior(playerid);
    VehicleID = JBC_CreateVehicle(493, X+3,Y,Z, Angle, random(255), random(255), -1);
    
    PutPlayerInVehicle(playerid, VehicleID, 0);
    LinkVehicleToInterior(VehicleID, int1);
    SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(playerid));
    
    User[playerid][pCar] = VehicleID;
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* JetMax Spawneado satisfactoriamente.");
    return 1;
}
#endif

//CMDS ADMIN
CMD:jacmds(playerid, params[])
{
    new string[1600*2], cb[64];

            	
    LevelCheck(playerid, 1);

    if(User[playerid][accountAdmin] >= 1)
    {
        format(cb, sizeof(cb), ""COLOR_RANK1"-> %s\n", ServerInfo[AdminRank1]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /Kick, /Asay, /Spawn, /Reports, /Aceptar, /Rechazar, /Cerrarreporte(cr), /Rchat), /Onduty, /Weaps\n");
        strcat(string, "* /Slap, /(Un)Jail, /Jailed, /(Un)Mute, /Muted, /Eject, /(UN)MuteCMD, /CMDmuted\n");
        strcat(string, "*** {D0AEEB}Admin Chat: {FFD700}#"white" (USO; #Hola a todos!)\n");
    }
    if(User[playerid][accountAdmin] >= 2)
    {
        format(cb, sizeof(cb), ""COLOR_RANK2"-> %s\n", ServerInfo[AdminRank2]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /Goto, /IP, /Warn, /Lspec(off), /AKA, tecla 'N' para borrado de chat, /Disarm, /Explode, /SetInterior\n");        
        strcat(string, "* /Setworld, /Hidemarker, /Screen, /Destroycar, /lista, /Startrace, /Stoprace\n");
    }
    if(User[playerid][accountAdmin] >= 3)
    {
        format(cb, sizeof(cb), ""COLOR_RANK3"-> %s\n", ServerInfo[AdminRank3]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /Adminarea, /SaveSkin, /Useskin, /Flip, /Play, /Ban, /InfoBan, /Get, /(Un)Freeze\n");
        strcat(string, "* /Sethealth, /Setarmour, /Setfstyle, /Acarcolor(acc), /SetdLevel, /Anuncio\n");

    }
    if(User[playerid][accountAdmin] >= 4)
    {
        format(cb, sizeof(cb), ""COLOR_RANK4"-> %s\n", ServerInfo[AdminRank4]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /SetTime, /SetWeather, /Settime, /Setwanted, /Heal, /Armour,  /Baneados, /Giveweapon(gw)\n");
        strcat(string, "* /Givecar(gc), /Aweapons, /Write, /Radiusrespawn(RR), /eventos(e),\n");
        strcat(string, "* /iniciar evento, /finalizar(fin), /prize\n");
    }
    if(User[playerid][accountAdmin] >= 5)
    {
        format(cb, sizeof(cb), ""COLOR_RANK5"-> %s\n", ServerInfo[AdminRank5]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /Repair, /Setskin, /Gotoco, /Setcolor, /Rspawn, /Rweaps, /Rcars, /Rdisarm, /Rheal, /RArmour, /Rtodo\n");
        strcat(string, "* /rDestroycar, /rfreeze, /runfreeze, /Setallweather, /Setalltime, /Giveallweapon, /Disarmall\n");
    }
    if(User[playerid][accountAdmin] >= 6)
    {
        format(cb, sizeof(cb), ""COLOR_RANK6"-> %s\n", ServerInfo[AdminRank6]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /Remwarn, /Oban, /Megajump, /Healall, /ARmourall, /Setallworld, /Setallinterior\n");
        strcat(string, "* /SetWantedAll, /Ejectall, /Fakedeath, /minigame, /startcoliseo /endcoliseo\n");
        strcat(string, "* /pack, /win, /lucer, /iniciar(evento - duelo - coliseo)\n");
    }
    if(User[playerid][accountAdmin] >= 7)
    {
        format(cb, sizeof(cb), ""COLOR_RANK7"-> %s\n", ServerInfo[AdminRank7]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /Cname, /Setallskin, /Force, /Teleplayer, /Forbidword(Name)\n");
        strcat(string, "* /Entercar, /Addnos, /Carpjob, /Setpass, /Jetpack\n");
    }
    if(User[playerid][accountAdmin] >= 8)
    {
        format(cb, sizeof(cb), ""COLOR_RANK8"-> %s\n", ServerInfo[AdminRank8]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /Bankrupt, /SetVhealth,  /Votekicktime, /Endvotekick\n");
        strcat(string, "* /Setvotekicklimit, /Removeacc, /Settemplevel\n");
        strcat(string, "* /armour, /armourall, /Fakechat, /unban\n");
        strcat(string, "*** {D0AEEB}Chat de owners: {FFD700}@"white" USO; @Hola a todos\n");
    }
    if(User[playerid][accountAdmin] >= 9)
    {
        format(cb, sizeof(cb), ""COLOR_RANK9"-> %s\n", ServerInfo[AdminRank9]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /Getall, /Cleardwindow, /Slapall, /Explodeall /SetOnline, /Allowgod, /Fakecmd\n");
        strcat(string, "* /Setkills, /Setdeaths, /Setduelosg(p)\n");
    }
    if(User[playerid][accountAdmin] >= 10)
    {
        format(cb, sizeof(cb), ""COLOR_RANK10"-> %s\n", ServerInfo[AdminRank10]);
        strcat(string, cb);
        strcat(string, ""white"");
        strcat(string, "* /Akill, /Crash, /Kickall, /Killall, /Jsettings, /Setvip, /conscesionaria(cs)\n");
        strcat(string, "* /exportadora, /paintspray(ps), /oficina, /bloquear [password], /desbloquear\n");
        if(IsPlayerAdmin(playerid))
        {
            strcat(string, ""white"* /setlevel, /setscore, /setdinero, /Givealldinero, /Giveallscore\n");
        }
    }   ShowPlayerDialog(playerid, DIALOG_1, DIALOG_STYLE_MSGBOX, ""grey"[GP] Comandos administrativos", string, "Cerrar", "");
    return 1;
}

//ADM LVL 1
CMD:aka(playerid,params[])
{
    LevelCheck(playerid, 1);
    
    if(!strlen(params)) 
        return SendClientMessage(playerid, COLOR_RED, "Uso: /Aka [ID del Jugador]") &&
        
    SendClientMessage(playerid, COLOR_RED, "Funcion: A ver otros Nicks utilizados por determinado jugador (Coincidencias)");
    new player1, str[128], pIP[50];
    player1 = strval(params);
    if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID)
    {
        GetPlayerIp(player1,pIP,50);
        format(str,sizeof(str),"[ == AKA DE %s[%d] - IP:%s == ]", pName(playerid), player1, pIP);
        SendClientMessage(playerid,COLOR_ORANGE,str);
        format(str,sizeof(str),"[ %s ]", dini_Get("Logs/aka.txt",pIP));
        SendClientMessage(playerid,COLOR_ORANGE,str);
    }
    
    else 
        SendClientMessage(playerid, COLOR_RED, "[INFO] El jugador no está conectado o es usted mismo.");
    
    return 1;
}

CMD:weaps(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new
        id,
        Count,
        x,
        string[128],
        SecondString[64],
        WeapName[24],
        slot,
        weap,
        ammo
        ;
    
    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /weaps [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    format(SecondString, sizeof(SecondString), "_______ [ %s[ID:%d] Armamento ] _______", pName(id), id);
    SendClientMessage(playerid, COLOR_WHITE, SecondString);
    
    for(slot = 0; slot < 14; slot++)
    {
        GetPlayerWeaponData(id, slot, weap, ammo);
        if(ammo != 0 && weap != 0)
        Count++;
    }
    
    if(Count < 1) 
        return SendClientMessage(playerid, COLOR_RED, "[INFO] No tiene armas!");
    
    if(Count >= 1)
    {
        for (slot = 0; slot < 14; slot++)
        {
            GetPlayerWeaponData(id, slot, weap, ammo);
            if(ammo != 0 && weap != 0)
            {
                GetWeaponName(weap, WeapName, sizeof(WeapName));
                
                if(ammo == 65535 || ammo == 1)
                    format(string, sizeof(string), "%s%s (1)",string, WeapName);
                
                else 
                    format(string, sizeof(string), "%s%s (%d)", string, WeapName, ammo);
                x++;
                
                if(x >= 5)
                {
                    SendClientMessage(playerid, COLOR_YELLOW, string);
                    x = 0;
                    format(string, sizeof(string), "");
                }
                
                else 
                    format(string, sizeof(string), "%s,  ", string);
            }
        }
        
        if(x <= 4 && x > 0)
        {
            string[strlen(string)-3] = '.';
            SendClientMessage(playerid, COLOR_YELLOW, string);
        }
    }
    return 1;
}

CMD:reports(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new string[1042 * 5], SecondString[150], count;

    strcat(string, ""red"-> Reportes recibidos <-\n\n");
    strcat(string, ""grey"");

    for(new i = 1; i< MAX_REPORTS; i++)
    {
        if(rInfo[i][reportTaken])
        {
            if(IsPlayerConnected(rInfo[i][reportAccepted]))
            {
                format(SecondString, sizeof(SecondString), "[RID %d] %s[ID:%d] reporto a %s[%d] - %s [Enviado: %s] - Recepcionado por %s\n", 
                    i, 
                    pName(rInfo[i][reporterID]), 
                    rInfo[i][reporterID], 
                    pName(rInfo[i][reportedID]), 
                    rInfo[i][reportedID], 
                    rInfo[i][reportReason], 
                    rInfo[i][reportTime], 
                    pName(rInfo[i][reportAccepted]))
                    ;

            }
            
            else if(rInfo[i][reportAccepted] == INVALID_PLAYER_ID)
            {
                format(SecondString, sizeof(SecondString), "[RID %d] %s[ID:%d] reporto a %s[%d] - %s [Enviado: %s] - Nadie lo ha recepcionado\n", 
                    i, 
                    pName(rInfo[i][reporterID]), 
                    rInfo[i][reporterID], 
                    pName(rInfo[i][reportedID]), 
                    rInfo[i][reportedID], 
                    rInfo[i][reportReason], 
                    rInfo[i][reportTime])
                    ;
            }
            strcat(string, SecondString);
            count++;
        }
    }

    if(count < 1) 
        strcat(string, "[INFO] No hay reportes recibidos en este momento.");
    
    ShowPlayerDialog(playerid, DIALOG_2, DIALOG_STYLE_MSGBOX, ""red"Reports", string, "Cerrar", "");
    return 1;
}

CMD:aceptar(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new reportid;
    if(sscanf(params, "d", reportid))
        return SendClientMessage(playerid, COLOR_RED, "USO: /aceptar [RID]");

    if(reportid < 1 || !rInfo[reportid][reportTaken] || reportid >= MAX_REPORTS)
        return SendClientMessage(playerid, COLOR_RED, "[REPORTE] RID no valido.");

    if(rInfo[reportid][reportAccepted] == playerid)
        return SendClientMessage(playerid, COLOR_RED, "[REPORTE] Reporte ha sido recepcionado por ti.");

    if(rInfo[reportid][reportAccepted] != INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[REPORTE] Reporte ha sido recepcionado por otro Administrador.");

    HandleReport(playerid, reportid);
    return 1;
}

CMD:rechazar(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new reportid, reason[20];
    if(sscanf(params, "ds[20]", reportid))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rechazar [reportid]");

    if(reportid < 1 || !rInfo[reportid][reportTaken] || reportid >= MAX_REPORTS)
        return SendClientMessage(playerid, COLOR_RED, "[REPORTE] RID no valido.");

    if(rInfo[reportid][reportAccepted] != INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[REPORTE] Reporte ha sido recepcionado por otro Administrador.");

    DenyReport(playerid, reportid, reason);
    return 1;
}

CMD:cmdmuted(playerid, params[])
{
    new string[128], count = 0;

    SendClientMessage(playerid, -1, "** "orange"Jugadores con CMD Mute "white"**");
    foreach(new i : Player)
    {
        if(User[i][accountLogged] == 1)
        {
            if(User[i][accountCMuted] == 1)
            {
                format(string, sizeof(string), "(%d) %s - Restantes: %d segundos", i, pName(i), User[i][accountCMuteSec]);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                count++;
            }
        }
    }
    if(count == 0) return SendClientMessage(playerid, -1, "[ERROR] No hay jugadores con Mute CMD actualmente.");
    return 1;
}

CMD:play(playerid, params[])
{
            	
    LevelCheck(playerid, 1);
    new song[128];
    if(sscanf(params, "s[128]", song)) 
        return SendClientMessage(playerid, -1, "USO: /play [LINK URL]");
    
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        PlayAudioStreamForPlayer(i, song);
    }
    
    new str[65];
    
    format(str, sizeof(str), "[GP - RADIO] El admin %s(%d) ha puesto una canción.", pName(playerid), playerid);
    SendClientMessageToAll(0x54FFFF2C, str);
    SendClientMessage(playerid,0xE2FFFF2C, "[GP - RADIO] No olvides pedir la tuya!");
    SendClientMessageToAll(0x54FFFF2C, "[GP - RADIO] Si no te gusta, usa /stop para sacarlo.");
    return 1;
}

CMD:jail(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new id, sec, reason[128], string[250];
    if(sscanf(params, "uiS(None)[128]", id, sec, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /jail [playerid] [seconds] [razon]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(sec < 30) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes encarcelar por menos de 30 segundos.");
    
    if(User[id][accountJail] == 1) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya esta encarcelado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[IDIOTA] No puedes usar este comando en ti mismo.");
    
    if(sec  >= 200) 
        return SendClientMessage(playerid, COLOR_RED,  "[INFO] No está permitido sancionar por un tiempo mayor o igual que 200 segundos.");
    
    SpawnPlayer(id);
    JBC_ResetPlayerWeapons(id);
    JBC_SetPlayerPos(id, 305.8537, 304.1868, 1003.3047);
    SetPlayerFacingAngle(id, 93.2811);
    SetCameraBehindPlayer(id);

    format(string, sizeof(string), "[INFO] %s[ID:%d] ha sido sancionado - [Tiempo: %d segundos] [Razón: %s]", pName(id), id, sec, reason);
    SendClientMessageToAll(COLOR_RED, string);
    
    SendClientMessage(id, COLOR_RED, "[INFO] "white"Has sido sancionado por incumplir las "red"/reglas"white", si no las haz leído, leelas.");
    SendClientMessage(id, COLOR_RED, "[INFO]{FFFFFF} Si crees que fué abusivo, pulsa "red"f8 "white"y envía la foto a nuestro "red"/facebook (privado).");

    format(string, sizeof(string), "[JAIL] %s ha sido sancionado por %s  [%d segundos por: %s]", pName(id), pName(playerid), sec, reason);
    SaveLog("jail.txt", string);

    User[id][accountJail] = 1, User[id][accountJailSec] = sec;
     
    if(id != 0)
    {
        SetPlayerVirtualWorld(id, id);
    }
    
    if(id == 0)
    {
        SetPlayerVirtualWorld(id, 8);
    }
    
    for(new i = 0; i < MAX_PLAYERS; i++) 
    {
        PlayerPlaySound(i,1009,0.0,0.0,0.0); 
    }
    return 1;
}

CMD:muted(playerid, params[])
{
            	
    LevelCheck(playerid, 1);
    
    new string[128], count = 0;

    SendClientMessage(playerid, -1, "[INFO] "orange"Jugadores silenciados");
    foreach(new i : Player)
    {
        if(User[i][accountLogged] == 1)
        {
            if(User[i][accountMuted] == 1)
            {
                format(string, sizeof(string), "(%d) %s - Restante: %d segundos.", i, pName(i), User[i][accountMuteSec]);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                count++;
            }
        }
    }
    
    if(count == 0) 
        return SendClientMessage(playerid, -1, "[ERROR] No hay jugadores silenciados actualmente.");
    return 1;
}

CMD:jailed(playerid, params[])
{
            	
    LevelCheck(playerid, 1);
    
    new string[128], count = 0;

    SendClientMessage(playerid, -1, "** "orange"Jugadores encarcelados "white"**");
    foreach(new i : Player)
    {
        if(User[i][accountLogged] == 1)
        {
            if(User[i][accountJail] == 1)
            {
                format(string, sizeof(string), "(%d) %s - Restante: %d segundos.", i, pName(i), User[i][accountJailSec]);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                count++;
            }
        }
    }
    if(count == 0) 
        return SendClientMessage(playerid, -1, "[INFO] No hay jugadores encarcelados.");
    return 1;
}
CMD:eject(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new
        string[130],
        id
        ;      

    if(sscanf(params, "u", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /eject [playerid]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(!IsPlayerInAnyVehicle(id)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador debe estar dentro del vehiculo.");
    
    RemovePlayerFromVehicle(id);
    
    format(string, sizeof(string), "[INFO] Has expulsado del vehiculo a %s[ID:%d].", pName(id), id);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] te ha expulsado del vehiculo.", pName(playerid), playerid);
    SendClientMessage(id, COLOR_YELLOW, string);
    return 1;
}




CMD:unjail(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new id, reason[128], string[250];
    
    if(sscanf(params, "uS(None)[128]", id, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /unjail [playerid] [razon]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(User[id][accountJail] == 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Jugador no esta encarcelado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[IDIOTA] No puedes usar este comando en ti mismo.");

    format(string, sizeof(string), "[INFO] %s[ID:%d] ha sido sacado de la carcel - Razon: %s", pName(id), id, reason);
    SendClientMessageToAll(COLOR_GREY, string);
    
    SendClientMessage(id, COLOR_ORANGE, "[INFO] Has sido sacado de la carcel por un Admin.");

    format(string, sizeof(string), "[JAIL] %s ha sido sacado de la carcel por %s - Razon: %s", pName(id), pName(playerid), reason);
    SaveLog("jail.txt", string);

    User[id][accountJail] = 0, User[id][accountJailSec] = 0;
    
    SpawnPlayer(id);
    SetPlayerVirtualWorld(id, 0);
    SetPlayerInterior(id, 0);
    return 1;
}

CMD:onduty(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new 
        string[128]
    ;
     
    switch(User[playerid][pDuty])
    {
        case 0:
        {
            JBC_SetPlayerArmour(playerid, 100);
            JBC_SetPlayerHealth(playerid, 150);
            
            User[playerid][pDuty] = 1;
            
            format(string, 128, "[ADMIN] %s[ID:%d]  ha entrado en \" Servicio \"", pName(playerid), playerid);
            SendClientMessageToAll(COLOR_GREEN, string);
        }
        case 1:
        {
            User[playerid][pDuty] = 0;
            
            JBC_SetPlayerHealth(playerid, 100);
            JBC_SetPlayerArmour(playerid, 100);
            
            format(string, 128, "[ADMIN] %s[ID:%d]  ahora esta \" Fuera de Servicio \"", pName(playerid), playerid);
            SendClientMessageToAll(COLOR_YELLOW, string);
        }
    }
    return 1;
}

CMD:slap(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new
        Float:x,
        Float:y,
        Float:z,
        Float:health,
        string[128],
        id,
        reason[20],
        l[128]
        ;

    if(sscanf(params, "uS(N/A)[128]", id, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /slap [playerid] [reason(Default: N/A)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    GetPlayerPos(id, x, y, z);
    GetPlayerHealth(id, health);
    
    JBC_SetPlayerHealth(id, health-25);
    JBC_SetPlayerPos(id, x, y, z+5);
    
    PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
    PlayerPlaySound(id, 1190, 0.0, 0.0, 0.0);
    
    format(string, sizeof(string), "[INFO] %s[ID:%d] ha recibido un slap [Razon: %s]", pName(id), id, reason);
    SendClientMessageToAll(COLOR_GREY, string);
    
    format(l, sizeof(l), "[SLAP] %s le dió slap a %s por %s", pName(playerid), pName(id), reason);
    SaveLog("abuso.txt", l);
    return 1;
}


CMD:mutecmd(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new id,
        sec, 
        reason[20], 
        string[250]
        ;
    
    if(sscanf(params, "uiS(None)[128]", id, sec, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /mutecmd [playerid] [seconds] [razon]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(sec < 30) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar mute por menos de 30 segundos.");
    
    if(User[id][accountCMuted] == 1) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya ha sido muteado de usar CMDs.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[IDIOTA] No puedes usar este comando en ti mismo.");
    
    if(sec >= 200) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No está permitido mutear por un tiempo mayor o igual a 200 segundos.");
    
    format(string, sizeof(string), "[INFO] %s[ID:%d] ha sido muteado(CMDs) por %s[ID:%d] - Tiempo: %d segundos [%s]", pName(id), id, pName(playerid), playerid, sec, reason);
    SendClientMessageToAll(COLOR_GREY, string);
    
    SendClientMessage(id, COLOR_ORANGE, "[INFO] Has sido muteado de usar comandos por incumplir las /reglas.");
    SendClientMessage(id, COLOR_ORANGE, "[INFO]{FFFFFF} Si crees que fué abusivo, pulsa "red"'f8' "white"y envía la foto a nuestro "red"/facebook (privado).");

    format(string, sizeof(string), "%s ha sido muteado de comandos por %s (%d segundos, razon %s)", pName(id), pName(playerid), sec, reason);

    User[id][accountCMuted] = 1, User[id][accountCMuteSec] = sec;

    format(string, sizeof(string), "El administrador %s le ha muteado los comandos a %s por %d con razon de: %s", pName(playerid), pName(id), sec, reason);
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:unmutecmd(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new id, 
        reason[20], 
        string[250]
        ;
    
    if(sscanf(params, "uS(None)[128]", id, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /unmutecmd [playerid] [razon]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(User[id][accountCMuted] == 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta muteado de usar comandos.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[IDIOTA] No puedes usar este comando en ti mismo.");

    format(string, sizeof(string), "[INFO] %s(%d) ha sido permitido de usar comandos - Admin: %s[ID:%d] [%s]", pName(id), id, pName(playerid), playerid, reason);
    SendClientMessageToAll(COLOR_GREY, string);
    
    SendClientMessage(id, COLOR_ORANGE, "[INFO] Te han permitido usar comandos.");

    format(string, sizeof(string), "%s se le ha permitido usar comandos - Admin: %s", pName(id), pName(playerid));

    User[id][accountCMuted] = 0, User[id][accountCMuteSec] = 0;
    return 1;
}

CMD:spawn(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new
        string[128],
        id
        ;

    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /spawn [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    JBC_SetPlayerPos(id, 0.0, 0.0, 0.0);
    SpawnPlayer(id);
    
    format(string, sizeof(string), "[INFO] Has respawneado a %s.", pName(id));
    SendClientMessage(playerid, -1, string);
    
    format(string, sizeof(string), "[ADMIN] %s te ha respawneado.", pName(playerid));
    SendClientMessage(id, COLOR_YELLOW, string);
    return 1;
}

CMD:cerrarreporte(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new reason[300];
    if(sscanf(params, "s[300]", reason))
        return SendClientMessage(playerid, COLOR_RED, "USO: /cr [razon]");

    for(new i; i < MAX_REPORTS; i++)
    {
        if(rInfo[i][reportTaken] && rInfo[i][reportAccepted] == playerid)
        {
            EndReport(playerid, i, reason);
            return 1;
        }
    }
    SendClientMessage(playerid, -1, "[REPORTE] No has recepcionado ningun reporte.");
    return 1;
}

CMD:cr(playerid, params[])
{
    return cmd_cerrarreporte(playerid, params);
}

CMD:kick(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new
        string[128],
        id,
        reason[20]
        ;
    
    if(sscanf(params, "uS(N/A)[20]", id, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /kick [playerid] [reason(Default: N/A)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    if(id == playerid)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en ti mismo.");
    
    format(string, sizeof(string), "[KICKED] %s ha sido expulsado del servidor [Razon: %s]", pName(id), reason);
    SendClientMessageToAll(COLOR_RED, string);
    format(string, sizeof(string), "[KICKED] %s ha sido expulsado del servidor [Admin: %s] [Razon: %s]", pName(id), pName(playerid), reason);
    SaveLog("kick.txt", string);
    Kick(id);
    
    for(new i = 0; i < MAX_PLAYERS; i++) 
    {
        PlayerPlaySound(i,1132,0.0,0.0,0.0);
    }
    return 1;
}

CMD:asay(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new string[500];

    if(isnull(params)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /asay [mensaje como asay]");

    format(string, sizeof(string), "{1896FF}|- [%s] %s[%d]: %s", GetAdminRank(User[playerid][accountAdmin]),pName(playerid),playerid, params);
    SendClientMessageToAll(-1, string);
    
    for(new i = 0; i < MAX_PLAYERS; i++) 
    {
        PlayerPlaySound(i,1057, 0.0, 0.0, 0.0); 
    }
    return 1;
}

CMD:mute(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new id, 
        sec, 
        reason[20], 
        string[128+50]
        ;
    
    if(sscanf(params, "uiS(None)[20]", id, sec, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /mute [playerid] [seconds] [razon]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(sec < 30) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar mute por menos de 30 segundos.");
    
    if(User[id][accountMuted] == 1) 
        return SendClientMessage(playerid,COLOR_RED, "[ERROR] El jugador ya esta mutueado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[IDIOTA] No puedes usar este comando en ti mismo.");
    
    if(sec >= 200) 
        return  SendClientMessage(playerid, COLOR_RED, "[ERROR] No está permitido mutear por un tiempo mayor o igual que 200 segundos");
    
    format(string, sizeof(string), "[INFO] %s[ID:%d] ha sido mutueado - Tiempo: %d segundos [razón %s]", pName(id), id, sec, reason);
    SendClientMessageToAll(COLOR_RED, string);
    SendClientMessage(id, COLOR_ORANGE, "[INFO] Has sido muteado por incumplir las /reglas.");
    SendClientMessage(id, COLOR_ORANGE, "[INFO]{FFFFFF} Si crees que fué abusivo, pulsa "red"'f8' "white"y envía la foto a nuestro "red"/facebook (privado).");
    
    format(string, sizeof(string), "[MUTE] %s ha sido muteado por %s (%d segundos, razon %s)", pName(id), pName(playerid), sec, reason);
    SaveLog("mute.txt", string);
    
    User[id][accountMuted] = 1, User[id][accountMuteSec] = sec;
    return 1;
}

CMD:unmute(playerid, params[])
{
            	
    LevelCheck(playerid, 1);

    new id, 
        reason[128], 
        string[250]
        ;
    
    if(sscanf(params, "uS(None)[128]", id, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /unmute [playerid] [razon]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(User[id][accountMuted] == 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Jugador no esta muteado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[IDIOTA] No puedes usar este comando en ti mismo.");

    format(string, sizeof(string), "[INFO] Ha sido desmuteado - Razon: %s", pName(id), id, reason);
    SendClientMessageToAll(COLOR_GREY, string);
    SendClientMessage(id, COLOR_ORANGE, "[INFO] Has sido desmuteado por un administrador.");

    format(string, sizeof(string), "[UNMUTE] %s ha sido desmuteado por %s", pName(id), pName(playerid));
    SaveLog("mute.txt", string);
    
    User[id][accountMuted] = 0, User[id][accountMuteSec] = 0;
    return 1;
}
//CMD ADM LVL 2
CMD:lista(playerid, params[])
{
            	
    LevelCheck(playerid, 2);
    
    new s[600*2];
    
    strcat(s, ""white"3 Laps - A las vueltas - ABP Infernus - Abajo - Airport SF - Al Aguaa! - AleBuccaner - AquaJet - Asaltar - Bayside\n");
    strcat(s, ""white"Big Jump - Bullet 2 - Bullet - Callejones - Camp-ver - Checkpoints - Chilliad - Colision - Colision,2 - CWRace\n");
    strcat(s, ""white"Derrape - Desert - Duneride - Emergency - Euros - Four Dragons - Go to Groove - Infernus Original - LS Infernus\n");
    strcat(s, ""white"LS Tour - LV Drift - Maldito Tren! - Medialuna - Military Miniatura - Military Race - Monsters - Monte Sanchez\n");
    strcat(s, ""white"Ocho Sanchez - Palomino Creek - Pasaje - Quad LS - Race 2.1 - Racer Vegas - Rancher - RC Miniatura - Retadores\n");
    strcat(s, ""white"Returns - Road to Area51 - Salto Mortal - Salto - Sanchez LS - Sanchez LV - Sf Phoenix - Sube y Baja - Sultan\n");
    strcat(s, ""white"TurismosSF - Yack Rally - Picada NRG - Caddy - Salbike - Lado a lado - Reversa infernus - Kings - Hotknife\n");
    strcat(s, ""white"Prueba triatlon - Paradise - Sanchez - Strip - Aero LS - Clocakart - Puente - Idlewood - Rodeo - Verona - GT\n");
    strcat(s, ""red"Importante: "white"Recuerda escribir el nombre de la carrera tal cual está, con mayúsculas, minúsculas, o espacios\n");
    strcat(s, ""white"según corresponda.\n");
    
    ShowPlayerDialog(playerid, RACES_DIALOG, DIALOG_STYLE_MSGBOX, ""vip2_color"Lista de carreras GP", s, "Cerrar", "");
    return 1;
}

CMD:conteo(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    if(countDisplay == 5)
    {
        new string[80];
        format(string, sizeof(string), "[CONTEO] Admin %s(%d) ha iniciado un conteo", pName(playerid),playerid);
        SendClientMessageToAll(COLOR_YELLOW, string);
        CountDown();
    }

    else 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya hay un conteo en curso");
    return 1;
}

CMD:warn(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    new
        string[300],
        id,
        reason[300]
        ;

    if(sscanf(params, "uS(No Reason)[300]", id, reason))
        return SendClientMessage(playerid, COLOR_RED, "USO: /warn [playerid] [razon]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(id == playerid)
        return SendClientMessage(playerid, COLOR_RED, "[IDIOTA] No puedes advertirte a ti mismo");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    User[id][accountWarn] += 1;

    format(string, sizeof(string), "[ADMIN] %s[ID:%d] advirtio a %s(%d) - Razon: %s [Advertencias: %d]", pName(playerid), playerid, pName(id), id, reason, User[id][accountWarn]);
    SendClientMessageToAll(COLOR_YELLOW, string);
    SaveLog("warn.txt", string);

    for(new i = 0; i < MAX_PLAYERS; i++) 
    {
        PlayerPlaySound(i,1190, 0.0, 0.0, 0.0); 
    }
    return 1;
}

CMD:ip(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    new
        id,
        msg[120]
        ;
    
    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /ip [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    format(msg, sizeof(msg), "> %s's IP: %s <", pName(id), GetIP(id));
    SendClientMessage(playerid, COLOR_YELLOW, msg);
    return 1;
}

CMD:goto(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    new
        id,
        string[130],
        Float:x,
        Float:y,
        Float:z
        ;
    
    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /goto [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    GetPlayerPos(id, x, y, z);
    SetPlayerInterior(playerid, GetPlayerInterior(id));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
    
    if(GetPlayerState(playerid) == 2)
    {
        JBC_SetVehiclePos(GetPlayerVehicleID(playerid), x+3, y, z);
        LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(id));
        SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(id));
    }
    
    else 
        JBC_SetPlayerPos(playerid, x+2, y, z);
    
    format(string, sizeof(string), "[INFO] Te has teletransportado a %s.", pName(id));
    SendClientMessage(playerid, COLOR_GREEN, string);
    
    format(string, sizeof(string), "[ADMIN] %s se ha teletransportado hacia tu ubicacion.", pName(playerid));
    SendClientMessage(id, COLOR_GREEN, string);
    return 1;
}

CMD:rv(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    new string[128], carid;

    if(sscanf(params, "d", carid))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rv [vehicleid]");

    if(carid < 1 || !IsValidVehicle(carid) || carid > MAX_VEHICLES)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] ID del vehiculo es invalido.");

    SetVehicleToRespawn(carid);
    format(string, sizeof(string), "[INFO] Has respawenado el Vehiculo ID %d.", carid);
    SendClientMessage(playerid, -1, string);
    return 1;
}

CMD:lspec(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    new 
        string[150], 
        specplayerid, 
        option[32]
        ;

    if(sscanf(params, "s[32]", option))
        return SendClientMessage(playerid, COLOR_RED, "USO: /lspec [playerid(OFF)]");

    if(!strcmp(option, "off", true))
    {
        if(User[playerid][SpecType] != SPEC_TYPE_NONE)
        {
            StopSpectate(playerid);
            SetTimerEx("PosAfterSpec", 1000, 0, "d", playerid);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "[INFO] Ya no estas specteando.");
        }
        else 
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No estas specteando a nadie.");
        return 1;
    }

    specplayerid = ReturnUser(option);

    if(!IsPlayerConnected(specplayerid))
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[specplayerid][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    if(specplayerid == playerid)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes spectearte a ti mismo.");

    if(GetPlayerState(specplayerid) == PLAYER_STATE_SPECTATING && User[specplayerid][SpecID] != INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Jugador esta specteando a alguien mas.");

    if(GetPlayerState(specplayerid) != 1 && GetPlayerState(specplayerid) != 2 && GetPlayerState(specplayerid) != 3)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Jugador no ha spawneado.");

    GetPlayerPos(playerid, SpecPos[playerid][0], SpecPos[playerid][1], SpecPos[playerid][2]);
    GetPlayerFacingAngle(playerid, SpecPos[playerid][3]);
    
    SpecInt[playerid][0] = GetPlayerInterior(playerid);
    SpecInt[playerid][1] = GetPlayerVirtualWorld(playerid);
    
    StartSpectate(playerid, specplayerid);
    
    format(string, sizeof(string), "[INFO] Spectando a: %s (ID: %d)", pName(specplayerid), specplayerid);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    SendClientMessage(playerid, -1, "Presiona SHIFT para pasar al siguiente jugador y SPACE para volver al anterior.");
    return 1;
}

CMD:setinterior(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    new
        string[130],
        id,
        interior
        ;

    if(sscanf(params, "ui", id, interior)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setinterior [playerid] [interior]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    SetPlayerInterior(id, interior);
    
    format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu interior a %d.", pName(playerid), interior);
    SendClientMessage(id, COLOR_ORANGE, string);
    
    format(string, sizeof(string), "[INFO] Le has seteado a %s el interior en %d.", pName(id), interior);
    SendClientMessage(playerid, COLOR_ORANGE, string);
    return 1;
}

CMD:setworld(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    new
        string[130],
        id,
        vw
        ;

    if(sscanf(params, "ui", id, vw)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setworld [playerid] [virtual world]");
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    SetPlayerVirtualWorld(id, vw);
    
    format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu Mundo virtual a %d.", pName(playerid), vw);
    SendClientMessage(id, COLOR_ORANGE, string);
    
    format(string, sizeof(string), "[INFO] Le has seteado a %s el Mundo Virtual a %d.", pName(id), vw);
    SendClientMessage(playerid, COLOR_ORANGE, string);
    return 1;
}

CMD:explode(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    new string[128],
        id,
        Float:x,
        Float:y,
        Float:z,
        reason[128],
        l[128]
        ;

    if(sscanf(params, "uS(N/A)[128]", id, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /explode [playerid] [reason(Default: N/A)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    GetPlayerPos(id, x, y, z);
    format(string, sizeof(string), "[INFO] %s[ID:%d] ha sido explotado por %s [Razon: %s]", pName(id), id, pName(playerid), reason);
    
    SendClientMessageToAll(COLOR_GREY, string);
    CreateExplosionForPlayer(id, x, y, z, 7, 1.00);
    
    format(l, sizeof(l), "[EXPLODE] %s explotó a %s por %s", pName(playerid), pName(id), reason);
    SaveLog("abuso.txt", l);
    return 1;
}

CMD:disarm(playerid, params[])
{
            	
    LevelCheck(playerid, 2);

    new
        string[130],
        id,
        l[128]
        ;

    if(sscanf(params, "u", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /disarm [playerid]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    JBC_ResetPlayerWeapons(id);
    
    format(string, sizeof(string), "[INFO] Le has quitado toda sus armas a %s.", pName(id));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s te ha removida todas tus armas.", pName(playerid));
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(l, sizeof(l), "[DISARM] %s desarmó a %s", pName(playerid), pName(id));
    SaveLog("abuso.txt", l);
    return 1;
}
CMD:hidemarker(playerid, params[])
{
    new string[92];

            	
    LevelCheck(playerid, 2);

    switch(User[playerid][accountMarker])
    {
        case false:
        {
            format(string, sizeof(string), "[HIDEMARKER] %s ahora en el mapa estas ocultado.", pName(playerid));
            SendAdminMessage(COLOR_YELLOW, string);
            SaveLog("abuso.txt", string);
            User[playerid][accountMarker] = true;
            SetPlayerColor(playerid, RemoveAlpha(GetPlayerColor(playerid)));
        }
        case true:
        {
            format(string, sizeof(string), "[INFO] %s ahora en el mapa estas visible.", pName(playerid));
            SendAdminMessage(COLOR_YELLOW, string);
            User[playerid][accountMarker] = false;
            SetPlayerColor(playerid, AddAlpha(GetPlayerColor(playerid)));
        }
    }
    return 1;
}

CMD:destroycar(playerid, params[])
{
            	
    LevelCheck(playerid, 2);
    if(IsPlayerInVehicle(playerid, vehicleOwner[playerid])) return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes destruir este vehículo, pertenece al sistema de autos.");
    DelVehicle(GetPlayerVehicleID(playerid));
    return 1;
}
//CMD ADM LVL 3
CMD:adminarea(playerid,params[])
{
    LevelCheck(playerid, 3);
    #pragma unused params
    
    JBC_SetPlayerPos(playerid,377,170,1008);
    
    new string [70];
    
    format(string, sizeof(string), "[ADMINS] %s se fué al AdminArea.", pName(playerid), params);
    SendAdminMessage(COLOR_ORANGE, string);
    
    SetPlayerFacingAngle(playerid, 90);
    SetPlayerInterior(playerid, 3);
    SetPlayerVirtualWorld(playerid, 0);
    
    GameTextForPlayer(playerid,"~y~Bienvenido al Admin Area",1000,3);
    return 1;
}

CMD:setdlevel(playerid, params[])
{
    new string[128], id, level;

            	
    LevelCheck(playerid, 3);

    if(sscanf(params, "ui", id, level))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setdlevel [playerid] [level(0-50,000)]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(level < 0 || level > 50000)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Drunk Level no valido.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu Drunk Level a %d.", pName(playerid), level);
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[INFO] Le has seteado a %s el Drunk Level a %d.", pName(id), level);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    SetPlayerDrunkLevel(id, level);
    return 1;
}


CMD:saveskin(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new string[128], SkinID;

    if(sscanf(params, "d", SkinID))
        return SendClientMessage(playerid, COLOR_RED, "USO: /saveskin [skinid]");

    if(SkinID < 0 || SkinID == 74 || SkinID > 311)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] SkinID no valido.");

    User[playerid][accountSkin] = SkinID;
    ActPlayerData(playerid,"skin");

    format(string, sizeof(string), "[INFO] Has guardado el SKIN ID: %d", SkinID);
    SendClientMessage(playerid, -1, string);
    
    SendClientMessage(playerid, COLOR_YELLOW, "TIP: Usa /Useskin para usar el Skin cuando spawneas (usa el mismo comando para dejar de hacerlo)");
    return 1;
}

CMD:useskin(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    if(User[playerid][accountSkin] == -1)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No tienes un Skin guardado. Usa primero /Saveskin + SkinID para guardarlo primero.");

    switch(User[playerid][accountUseSkin])
    {
        case false:
        {
            User[playerid][accountUseSkin] = true;
            JBC_SetPlayerSkin(playerid, User[playerid][accountSkin]);
            SendClientMessage(playerid, COLOR_GREEN, "[INFO] Ya estas usando tu Skin favorito.");
        }
        case true:
        {
            User[playerid][accountUseSkin] = false;
            SendClientMessage(playerid, COLOR_RED, "[INFO] Ahora tu skin favorito no estará disponible al spawnear.");
        }
    }
    ActPlayerData(playerid,"useskin");
    return 1;
}

CMD:flip(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new id,
        string[128],
        Float:angle
    ;

    if(!sscanf(params, "u", id))
    {
        if(id == INVALID_PLAYER_ID)
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

        if(User[playerid][accountAdmin] < User[id][accountAdmin])
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
        
        if(!IsPlayerInAnyVehicle(id)) 
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta en un vehiculo.");
        
        GetVehicleZAngle(GetPlayerVehicleID(id), angle);
        SetVehicleZAngle(GetPlayerVehicleID(id), angle);

        format(string, sizeof(string), "[INFO] Le has enderezado el vehiculo a %s.", pName(id));
        SendClientMessage(playerid, COLOR_GREEN, string);
        
        format(string, sizeof(string), "[ADMIN] %s te ha enderezado el vehiculo.", pName(playerid));
        SendClientMessage(id, COLOR_GREEN, string);
    }
    
    else
    {
        if(!IsPlayerInAnyVehicle(playerid))
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] Debes estar en un vehiculo para usar /Flip.");

        GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
        SetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
        SendClientMessage(playerid, COLOR_YELLOW, "Vehiculo corregido!");
        SendClientMessage(playerid, -1, "[TIP] Puedes enderezar el vehiculo de alguien mas "orange"/Flip [playerid]");
    }
    return 1;
}

CMD:anuncio(playerid, params[])
{
            	
    LevelCheck(playerid, 3);
    
    new texto[128];
    
    if(sscanf(params, "s[128]", params[0])) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /anuncio [mensaje para todos]");
        
    if(!CheckValidDigit(params[0])) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El anuncio contiene acentos ó digitos invalidos.");
        
    format(texto, sizeof(texto), "~n~~n~~n~~w~~h~%s~n~~g~[by %s]",params[0], pName(playerid));
    GameTextForAll(texto, 5000, 3);
    
    format(texto, sizeof(texto), "[ANN] %s announce: %s", pName(playerid), params[0]);
    SaveLog("announces.txt", texto);
    return 1;
}

CMD:acarcolor(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new
        string[130],
        id,
        col1,
        col2
        ;
    if(sscanf(params, "uiI(255)", id, col1, col2)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /acarcolor [playerid] [colour1] [colour2(optional)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(!IsPlayerInAnyVehicle(id)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador debe estar dentro del vehiculo.");

    if(col2==255) 
        col2=random(256);

    format(string, sizeof(string), "[INFO] Has cambiado el color de %s[ID:%d] %s a '%d,%d'", pName(id), id, VehicleNames[GetVehicleModel(GetPlayerVehicleID(id))-400], col1, col2);
    SendClientMessage(playerid, COLOR_GREEN, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] ha cambiado el color de tu %s a '%d,%d'", pName(playerid), playerid, VehicleNames[GetVehicleModel(GetPlayerVehicleID(id))-400], col1, col2);
    SendClientMessage(id, COLOR_YELLOW, string);
    
    ChangeVehicleColor(GetPlayerVehicleID(id), col1, col2);
    return 1;
}

CMD:get(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new
        id,
        string[130],
        Float:x,
        Float:y,
        Float:z
        ;
    
    if(sscanf(params, "u", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /get [playerid]");

    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[MEGAIDIOTA] No puedes teletrasportarte a ti mismo hacia ti mismo.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    GetPlayerPos(playerid, x, y, z);
    SetPlayerInterior(id, GetPlayerInterior(playerid));
    SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(playerid));

    if(GetPlayerState(id) == 2)
    {
        new VehicleID = GetPlayerVehicleID(id);
        JBC_SetVehiclePos(VehicleID, x+3, y, z);
        LinkVehicleToInterior(VehicleID, GetPlayerInterior(playerid));
        SetVehicleVirtualWorld(GetPlayerVehicleID(id), GetPlayerVirtualWorld(playerid));
    }
    
    else JBC_SetPlayerPos(id, x+2, y, z);

    format(string, sizeof(string), "[ADMIN] %s[ID:%d] te ha teletransportado a su ubicacion.", pName(playerid), playerid);
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[INFO] Has teletransportado a %s[ID:%d] hacia tu ubicacion.", pName(id), id);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    return 1;
}

CMD:setfstyle(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new
        string[128],
        id,
        fstyle,
        style[50]
        ;

    if(sscanf(params, "ui", id, fstyle)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setfstyle [playerid] [styles]") &&
    
    SendClientMessage(playerid, COLOR_GREY, "Styles: [0]Normal, [1]Boxing, [2]Kungfu, [3]Kneehead, [4]Grabkick, [5]Elbow");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(fstyle > 5) 
        return SendClientMessage(playerid, COLOR_RED, "* Inavlid Fighting Style.");

    switch(fstyle)
    {
        case 0:
        {
            SetPlayerFightingStyle(id, 4);
            style = "Normal";
        }
        case 1:
        {
            SetPlayerFightingStyle(id, 5);
            style = "Boxing";
        }
        case 2:
        {
            SetPlayerFightingStyle(id, 6);
            style = "Kung Fu";
        }
        case 3:
        {
            SetPlayerFightingStyle(id, 7);
            style = "Kneehead";
        }
        case 4:
        {
            SetPlayerFightingStyle(id, 15);
            style = "Grabkick";
        }
        case 5:
        {
            SetPlayerFightingStyle(id, 16);
            style = "Elbow";
        }
    }
    
    format(string, sizeof(string), "You have set %s[ID:%d] fighting style to '%s'", pName(id), id, style);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d]  te ha cambiado tu fighting style to '%s'", pName(playerid), playerid, style);
    SendClientMessage(id, COLOR_YELLOW, string);
    return 1;
}

CMD:sethealth(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new
        string[130],
        id,
        hp
        ;

    if(sscanf(params, "ud", id, hp)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /sethealth [playerid] [heatlh]");
    
    if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(hp >= 101) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes setear más de 100 de vida.");
    
    if(hp <= 10) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes setear menos de 10 de vida.");

    new Float:hp2 = float(hp);

    if(hp2 >= 101) return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes setear más de 100 de vida.");
    if(hp2 <= 10) return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes setear menos de 10 de vida.");

    JBC_SetPlayerHealth(id, hp2);

    format(string, sizeof(string), "[INFO] Le has seteado a %s[ID:%d] la vida a %d", pName(id), id, floatround(hp2));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] te ha setado tu vida en: %d", pName(playerid), playerid, floatround(hp2));
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[SETHEAL] %s le ha seteado a %s la vida en %d", pName(playerid), pName(id), floatround(hp2));
    SaveLog("abuso.txt",string);
    return 1;
}

CMD:setarmour(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new
        string[130],
        id,
        armour
        ;

    if(sscanf(params, "ud", id, armour)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setarmour [playerid] [armour]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    if(armour >= 101) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes setear más de 100 de chaleco.");
    
    if(armour <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes setear menos de 0 de chaleco.");

    new Float:ar = float(armour);
    JBC_SetPlayerArmour(id, ar);

    if(ar >= 101) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes setear más de 100 de chaleco.");
    
    if(ar <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes setear menos de 0 de chaleco.");

    format(string, sizeof(string), "[INFO] Le has seteado a %s[ID:%d] el chaleco en %d", pName(id), id, floatround(ar));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] te ha seteado el chaleco en %d", pName(playerid), playerid, floatround(ar));
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[SETARMOUR] %s le ha seteado a %s la vida en %d", pName(playerid), pName(id), floatround(ar));
    SaveLog("abuso.txt",string);
    return 1;
}


CMD:freeze(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new
        string[130],
        id,
        reason[128]
        ;
    
    if(sscanf(params, "uS(No Reason)[128]", id, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /freeze [playerid] [razon]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[IDIOTA] No puedes darte Freeze a ti mismo.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    JBC_TogglePlayerControllable(id, false);

    format(string, sizeof(string), "[INFO] Has frezeado a %s(%d) (Razon: %s)", pName(id), id, reason);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] te ha congelado [Razon: %s]", pName(playerid), playerid, reason);
    SendClientMessage(id, COLOR_YELLOW, string);
    return 1;
}

CMD:unfreeze(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new
        string[128],
        id
        ;

    if(sscanf(params, "u", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /unfreeze [playerid]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[IDIOTA] No puedes descongelarte a ti mismo.");
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    JBC_TogglePlayerControllable(id, true);

    format(string, sizeof(string), "[INFO] Has descongelado a %s(%d)", pName(id), id);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] te ha descongelado.", pName(playerid), playerid);
    SendClientMessage(id, COLOR_YELLOW, string);
    return 1;
}

CMD:unban(playerid, params[])
{
            	
    LevelCheck(playerid, 8);

    new
        string[150],
        Account[24],
        DBResult:Result,
        Query[129],
        fIP[30]
        ;
    
    if(sscanf(params, "s[24]", Account)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /unban [account name]");
    
    format(Query, 129, "SELECT * FROM `bans` WHERE `username` = '%s'", Account);
    Result = db_query(DB_USERS, Query);

    if(db_num_rows(Result))
    {
        db_get_field_assoc(Result, "ip", fIP, 30);
        RemoveBan(fIP);

        format(Query, 129, "DELETE FROM `bans` WHERE `username` = '%s'", DB_Escape(Account));
        db_query(DB_USERS, Query);

        format(string, sizeof string, "[UNBANNED] %s[ID:%d] ha retirado de la lista de prohibidos a %s.", pName(playerid), playerid, Account);
        SendClientMessageToAll(COLOR_YELLOW, string);
        print(string);

        SaveLog("ban.txt", string);
    }
    
    else
    {
        format(string, sizeof(string), "[ERROR] %s no se encuentra en la Base de Datos.", Account);
        SendClientMessage(playerid, COLOR_RED, string);
    }
    db_free_result(Result);
    return 1;
}


CMD:infoban(playerid, params[])
{
            	
    LevelCheck(playerid, 3);
    
    if(sscanf(params, "s[22]", params[0])) 
        return SendClientMessage(playerid, 0xFFFF00FF, "* Uso: /infoban [nombre del baneado]");
    
    new 
        Query[79], 
        DBResult: Resultado
        ;
    
    format(Query, sizeof(Query), "SELECT * FROM `bans` WHERE `username` = '%s' COLLATE NOCASE", DB_Escape(params[0]));
    Resultado = db_query(DB_USERS, Query);
    
    new 
        bid,admin[22],
        baneado[22],
        bip[22],
        reason[128],
        fecha[18],
        dialog[300]
        ;
    
    if(db_num_rows(Resultado))
    {
        bid = db_get_field_assoc_int(Resultado, "banid");
        db_get_field_assoc(Resultado, "banby", admin, 22);
        db_get_field_assoc(Resultado, "banwhen", fecha,25);
        db_get_field_assoc(Resultado, "username", baneado, 22);
        db_get_field_assoc(Resultado, "ip", bip, 22);
        db_get_field_assoc(Resultado, "banreason", reason, 128);
        
        format(dialog, sizeof(dialog), "{80C1D5}-Ban ID: {E7EBEF}%d\n{80C1D5}-Fecha: {E7EBEF}%s\n{80C1D5}-IP: {E7EBEF}%s\n{80C1D5}-Baneado: {E7EBEF}%s\n{80C1D5}-Admin: {E7EBEF}%s\n{80C1D5}-Razón: {E7EBEF}%s",bid,fecha,bip,baneado,admin,reason);
        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, " ", dialog, "Aceptar", "");
    }

    else
    {
        SendClientMessage(playerid, 0xFF0000FF, "ERROR: El nickname no se encuentra en la lista de baneados.");
        db_free_result(Resultado);
    }
    return 1;
}

CMD:ban(playerid, params[])
{
            	
    LevelCheck(playerid, 3);

    new
        string[128],
        id,
        reason[128],
        when[128],
        ban_hr, ban_min, ban_sec, ban_month, ban_days, ban_years
    ;

    gettime(ban_hr, ban_min, ban_sec);
    getdate(ban_years, ban_month, ban_days);

    if(sscanf(params, "uS(No Reason)[128]", id, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /ban [playerid] [reason(Default: No Reason)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando contigo mismo.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    format(when, 128, "%02d/%02d/%d %02d:%02d:%02d", ban_month, ban_days, ban_years, ban_hr, ban_min, ban_sec);

    format(string, sizeof(string), "[BANNED] %s[ID:%d] ha sido baneado del servidor [Razon: %s]", pName(id), id, reason);
    SendClientMessageToAll(COLOR_RED, string);
    printf(string);
    
    format(string, sizeof(string), "[BANNED] %s[ID:%d] ha sido baneado del servidor por %s [Razon: %s]", pName(id), id, pName(playerid), reason);
    SaveLog("ban.txt", string);

    format(string, sizeof(string), "[INFO] Has baneado a %s(%d) por %s.", pName(id), id, reason);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[BANNED] %s[ID:%d] te ha baneado del servidor [Razon: %s]", pName(playerid), playerid, reason);
    SendClientMessage(id, COLOR_YELLOW, string);
    
    BanAccount(id, pName(playerid), reason);
    ShowBan(id, GetPVarInt(id, "ban_id"), pName(playerid), reason, when);
    
    for(new i = 0; i < MAX_PLAYERS; i++) // Cambiar por foreach si usas foreach
    {
        PlayerPlaySound(i,1132,0.0,0.0,0.0); // Ponemos el sonido
    }
    Kick(id);
    return 1;
}
//CMD ADM LVL 4
CMD:setwanted(playerid, params[])
{
    new string[128], id, level;

            	
    LevelCheck(playerid, 4);

    if(sscanf(params, "ui", id, level))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setwanted [playerid] [level(0-6)]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(level < 0 || level > 6)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Nivel de buscado invalido.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu Wanted Level a %d.", pName(playerid), level);
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[INFO] Le has seteado a %s el Wanted Level a %d.", pName(id), level);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    SetPlayerWantedLevel(id, level);
    return 1;
}



CMD:setweather(playerid, params[])
{
            	
    LevelCheck(playerid, 4);

    new
        string[130],
        id,
        weather
        ;

    if(sscanf(params, "ui", id, weather))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setweather [playerid] [0/45]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(weather < 0 || weather > 45) 
        return SendClientMessage(playerid, COLOR_RED, "* Invalid Weather ID. (0/45)");
    
    SetPlayerWeather(id, weather);
    
    format(string, sizeof(string), "[INFO] Le has seteado a %s el Clima ID: %d", pName(id), weather);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s te ha seteado el Clima ID: %d", pName(playerid), weather);
    SendClientMessage(id, COLOR_YELLOW, string);
    return 1;
}

CMD:settime(playerid, params[])
{
            	
    LevelCheck(playerid, 4);

    new
        string[130],
        id,
        time
        ;

    if(sscanf(params, "ui", id, time))
        return SendClientMessage(playerid, COLOR_RED, "USO: /settime [playerid] [0/23]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    if(time < 0 || time > 23) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Hora invalida. Debe ser entre 0 y 23.");
    
    SetPlayerTime(id, time, 0);
    
    format(string, sizeof(string), "[INFO] Le has seteado a %s la hora %d:00", pName(id), time);
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s te ha cambiado hora a %d:00", pName(playerid), time);
    SendClientMessage(id, COLOR_YELLOW, string);
    return 1;
}



CMD:radiusrespawn(playerid, params[])
{
            	
    LevelCheck(playerid, 4);

    new 
        string[128], 
        Float:range, 
        numcars
        ;
    
    new Float:x, 
        Float:y, 
        Float:z;
    
    GetPlayerPos(playerid, x, y, z);

    if(sscanf(params, "f", range))
        return SendClientMessage(playerid, COLOR_RED, "USO: /radiusrespawn [rango]");

    for(new i = 1; i < MAX_VEHICLES; i++)
    {
        if(IsValidVehicle(i) && GetVehicleDistanceFromPoint(i, x, y, z) <= range && !VehicleOccupied(i))
        {
            SetVehicleToRespawn(i);
            numcars++;
        }
    }

    if(!numcars)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningun vehiculo respawneado.");

    format(string, sizeof(string), "[INFO] Has respawneado %d vehiculos en el rango de %d metros.", numcars, floatround(range));
    SendClientMessage(playerid, -1, string);
    return 1;
}

CMD:rr(playerid, params[])
{
    return cmd_radiusrespawn(playerid, params);

}

CMD:aweapons(playerid, params[])
{
            	
    LevelCheck(playerid, 4);

    JBC_GivePlayerWeapon(playerid, 24, 99999);
    JBC_GivePlayerWeapon(playerid, 26, 99999);
    JBC_GivePlayerWeapon(playerid, 29, 99999);
    JBC_GivePlayerWeapon(playerid, 31, 99999);
    JBC_GivePlayerWeapon(playerid, 33, 99999);
    JBC_GivePlayerWeapon(playerid, 38, 99999);
    JBC_GivePlayerWeapon(playerid, 9, 1);
    
    new string[50];
    
    SendClientMessage(playerid, COLOR_YELLOW, "[INFO] Has recibido un Pack Admin!");
    format(string, sizeof(string), "[AWEAPS] %s[ID:%d] uso AWEAPS.", pName(playerid), playerid);
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:givecar(playerid, params[])
{
            	
    LevelCheck(playerid, 4);

    new string[130],
        vID[32],
        id,
        vVW,
        vINT,
        vid,
        Float:x,
        Float:y,
        Float:z,
        Float:ang,
        vehicle,
        col1,
        col2
        ;
    
    if(sscanf(params, "us[32]I(255)I(255)", id, vID, col1, col2)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /givecar [playerid] [vehicleid(or name)] [color1(optional)] [color2(optional)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(isnumeric(vID)) vid = strval(vID);
    
    else 
        vid = GetVehicleModelIDFromName(vID);
    
    GetPlayerPos(id, x, y, z);
    GetPlayerFacingAngle(id, ang);
    if(vid < 400 || vid > 611) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] ID de Vehiculo no valido.");
    
    if(IsPlayerInAnyVehicle(id)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador ya tiene vehiculo.");

    if(col1==255) 
        col1=random(256);
    
    if(col2==255)
        col2=random(256);

    if(IsValidVehicle(User[playerid][pCar]) && !IsPlayerAdmin(id))
        EraseVeh(User[id][pCar]);

    vehicle = JBC_CreateVehicle(vid, x, y, z, 0, -1, -1, 0);
    vVW = GetPlayerVirtualWorld(id);
    vINT = GetPlayerInterior(id);
    
    SetVehicleVirtualWorld(vehicle, vVW);
    LinkVehicleToInterior(vehicle, vINT);
    JBC_PutPlayerInVehicle(id, vehicle, 0);
    
    User[id][pCar] = vehicle;
    
    ChangeVehicleColor(vehicle, col1, col2);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] te ha dado un \"%s\"(%i)", pName(playerid), playerid, VehicleNames[vid - 400], vid);
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[INFO] Le has dado a %s(%d) un \"%s\"(%i)", pName(id), id, VehicleNames[vid - 400], vid);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[GIVECAR] %s ha spawneado para %s un \"%s\"", pName(playerid),pName(id), VehicleNames[vid - 400]);
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:gc(playerid, params[])
{
    return cmd_givecar(playerid, params);
}

CMD:prize(playerid, params[])
{
            	
    LevelCheck(playerid, 4);
    
    new 
        id, 
        amount, 
        l[132], s[132], str[132]
        ;
    
    if(sscanf(params, "ud", id, amount))
        return SendClientMessage(playerid, COLOR_RED, "Uso: /prize [playerid] [monto]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador no está conectado.");

    if(id == playerid)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar para tu beneficio este comando.");

    if(amount > 70000)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar más de $70.000");

    User[id][accountChocolate] += amount;
   
    format(str, 128, "[INFO] "red"%s "white"ha recibido "green"$%d "white"como premio.", pName(id), amount);
    SendClientMessage(playerid, COLOR_YELLOW, str);
   
    format(s, 128, "[INFO] "red"%s "white"te ha dado como premio "green"$%d.", pName(playerid), amount);
    SendClientMessage(id, COLOR_YELLOW, s);
   
    format(l, sizeof(l), "[PRIZE] %s le dió $%d a %s", pName(playerid), amount, pName(id));
    SaveLog("prizes.txt", l);
    return 1;
}

CMD:heal(playerid, params[])
{
            	
    LevelCheck(playerid, 4);

    new
        id,
        string[130]
    ;

    if(sscanf(params, "u", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /heal [playerid]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes darte un paquete de vida a tí mismo.");
    
    JBC_SetPlayerHealth(id, 100.0);
    
    format(string, sizeof(string), "[INFO] Le has dado Player %s un paquete de vida.", pName(id));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s te ha dado un paquete de vida completo.", pName(playerid));
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[HEAL] %s le ha dado a %s vida completa.", pName(playerid), pName(id));
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:giveweapon(playerid, params[])
{
            	
    LevelCheck(playerid, 4);

    new
        id,
        ammo,
        wID[32],
        weap,
        WeapName[32],
        string[130]
    ;

    if(sscanf(params, "us[32]i", id, wID, ammo)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /giveweapon [playerid] [weaponid(or weapon name)] [ammo]");
    
    if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "[ERROR] Jugador no conectado.");
    
    if(ammo <= 0 || ammo > 99999) 
        ammo = 500;
    
    if(!isnumeric(wID)) 
        weap = GetWeaponIDFromName(wID);
    
    else 
        weap = strval(wID);
    
    if(!IsValidWeapon(weap)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] ID del arma es inválido.");
    
    if(weap == 26)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar este tipo de armas.");

    GetWeaponName(weap, WeapName, 32);

    format(string, sizeof(string), "[INFO] Le has dado una %s[ID:%d] con %d rondas de munición a %s.", WeapName, weap, ammo, pName(id));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string,sizeof(string),"[ADMIN] %s[ID:%d] te ha dado una %s[ID:%d] con %d rondas de municion.", pName(playerid),playerid, WeapName, weap, ammo);
    SendClientMessage(id, COLOR_LIGHTBLUE, string);
    
    format(string,sizeof(string),"[ADMIN] %s[ID:%d] te ha dado a %s %s[ID:%d] con %d de municion.", pName(playerid),playerid,pName(id), WeapName, weap, ammo);
    SaveLog("abuso.txt", string);
    JBC_GivePlayerWeapon(id, weap, ammo);
    return 1;
}

CMD:gw(playerid, params[])
{
    return cmd_giveweapon(playerid, params);
}

CMD:baneados(playerid, params[])
{
            	
    LevelCheck(playerid, 4);
    
    new 
        Cuadro[2200], 
        Linea[128],
        DBResult:resultado,rows
        ;
    
    resultado = db_query(DB_USERS,
                "SELECT `banid`,`banwhen`,`username`,`banby`,`banreason` FROM `bans` ORDER BY (`banid` * 1) DESC limit 20");
    
    rows = db_num_rows(resultado);
    
    if(rows == 0) 
        return SendClientMessage(playerid,COLOR_RED,"ERROR: No hay jugadores baneados.");
    
    if(rows)
    {
        new 
            bid,
            fecha[18], 
            baneado[22],
            admin[22],
            razon[25]
            ;

        strcat(Cuadro, ""red"Ban ID - "yellow"Fecha\t"yellow"Baneado\t"green"Admininstrador\t"green"Razón\n");
        
        for(new i = 0; i < rows; i ++)
        {
            bid = db_get_field_assoc_int(resultado, "banid");
            db_get_field_assoc(resultado, "banwhen", fecha,25);
            db_get_field_assoc(resultado, "username", baneado, 22);
            db_get_field_assoc(resultado, "banby", admin, 22);
            db_get_field_assoc(resultado, "banreason", razon, 25);
            format(Linea, sizeof(Linea), 
                    ""red"%d - "yellow"%s\t"yellow"%s\t"green"%s\t"green"%s\n",bid, fecha, baneado, admin, razon);
            
            strcat(Cuadro, Linea);
            db_next_row(resultado);
        }
        ShowPlayerDialog(playerid,DIALOG_BANLIST,DIALOG_STYLE_TABLIST_HEADERS, ""blue"Base de datos de baneos "white" últimos 20 baneados.",Cuadro,"Cerrar", "");
    }
    db_free_result(resultado);
    return 1;
}

CMD:write(playerid, params[])
{
            	
    LevelCheck(playerid, 4);

    new
        Colour,
        string[130]
        ;
    
    if(sscanf(params, "is[128]", Colour, params))
        return SendClientMessage(playerid, COLOR_RED, "USO: /write [color] [text]") &&
                    SendClientMessage(playerid, COLOR_GREY, 
                        "Colors: [1]Black, [2]White, [3]Red, [4]Orange, [5]Yellow, [6]Green, [7]Blue, [8]Purple, [9]Brown, [10]Pink");
    
    if(Colour > 10)
        return SendClientMessage(playerid, COLOR_GREY, "Colors: [1]Black, [2]White, [3]Red, [4]Orange, [5]Yellow, [6]Green, [7]Blue, [8]Purple, [9]Brown, [10]Pink");
    //OPTMIZAR: CAMBIAR IF POR CASE
    switch(Colour)
    {
        case 1:
        {
            format(string,sizeof(string),"%s",params); SendClientMessageToAll(COLOR_BLACK,string);
            return 1;
		}
		case 2:
		{
		    format(string,sizeof(string),"%s",params);SendClientMessageToAll(COLOR_WHITE,string);
		    return 1;
		}
		case 3:
		{
		    format(string,sizeof(string),"%s",params);SendClientMessageToAll(COLOR_RED,string);
		    return 1;
		}
		case 4:
		{
		    format(string,sizeof(string),"%s",params);SendClientMessageToAll(COLOR_ORANGE,string);
			return 1;
		}
		case 5:
		{
		    format(string,sizeof(string),"%s",params);SendClientMessageToAll(COLOR_YELLOW,string);
			return 1;
		}
		case 6:
  		{
		  	format(string,sizeof(string),"%s",params);SendClientMessageToAll(COLOR_GREEN,string);
			return 1;
		}
		case 7:
		{
		    format(string,sizeof(string),"%s",params);SendClientMessageToAll(COLOR_BLUE,string);
			return 1;
		}
		case 8:
		{
		    format(string,sizeof(string),"%s",params);SendClientMessageToAll(COLOR_PURPLE,string);
			return 1;
		}
		case 9:
		{
		    format(string,sizeof(string),"%s",params);SendClientMessageToAll(COLOR_BROWN,string);
			return 1;
		}
		case 10:
		{
		    format(string,sizeof(string),"%s",params);SendClientMessageToAll(COLOR_PINK,string);
			return 1;
		}
    }
    return 1;
}
//CMD ADM LVL 5
CMD:disarmall(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new string[92];

    foreach(new i : Player)
    {
        JBC_ResetPlayerWeapons(i);
    }
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] ha desarmado a todos los jugadores.", pName(playerid), playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}

CMD:setalltime(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new
       id,
       string[128]
        ;

    if(sscanf(params, "i", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setalltime [time(0-23)]");
    
    if(id < 0 || id > 23) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Hora no valida. Debe ser entre 0 y 23.");
    
    foreach(new i : Player)
    {
        PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
        SetPlayerTime(i, id, 0);
    }

    format(string, sizeof(string), 
        "[ADMIN] %s[ID:%d] le ha seteado a todos los jugadores la hora en:\"%d:00\"", pName(playerid), playerid, id);
    
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}

CMD:setallweather(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new
        id,
        string[128]
        ;
    if(sscanf(params, "i", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setallweather [weather(0-45)]");
    
    if(id < 0 || id > 45) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Clima no valida. Debe ser entre 0 y 45.");
    
    foreach(new i : Player)
    {
        PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
        SetPlayerWeather(i, id);
    }
    format(string, sizeof(string), 
        "[ADMIN] %s[ID:%d] le ha seteado a todos los jugadores el clima en: \"%d\"", pName(playerid), playerid, id);
    
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}

CMD:giveallweapon(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new
        ammo,
        wID[32],
        weap,
        WeapName[32],
        string[130]
        ;
    
    if(sscanf(params, "s[32]i", wID, ammo)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /giveallweapon [weaponid(or name)] [ammo]");
    
    if(ammo <= 0 || ammo > 99999) 
        ammo = 500;
    
    if(!isnumeric(wID)) 
        weap = GetWeaponIDFromName(wID);
    
    else 
        weap = strval(wID);
    
    if(!IsValidWeapon(weap)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] ID del arma no valida.");
    
    GetWeaponName(weap, WeapName, 32);
    
    foreach(new i : Player)
    {
        JBC_GivePlayerWeapon(i, weap, ammo);
        format(string, sizeof string, "~g~%s for all!", WeapName);
        GameTextForPlayer(i, string, 2500, 3);
    }
    
    format(string,sizeof(string), 
        "[ADMIN] %s[ID:%d] le ha dado a todos los jugadores un %s(%d) con %d municiones", pName(playerid), playerid, WeapName, weap, ammo);
    
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}


CMD:setcolor(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new id;
    if(sscanf(params, "u", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setcolor [playerid]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    SetPVarInt(playerid, "_Colors_", id);

    ShowPlayerDialog(playerid, DIALOG_COLORS, DIALOG_STYLE_LIST, 
        ""orange"Colors", ""black"Black\n"white"White\n"red"Red\n"orange"Orange\n"yellow"Yellow\n"green"Green\n"blue"Blue\n"purple"Purple\n"brown"Brown\n"pink"Pink", "Establecer", "Cancelar");

    return 1;
}

CMD:gotoco(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new
        Float: Pos[3],
        string[128]
        ;
    
    if(sscanf(params, "fff", Pos[0], Pos[1], Pos[2]))
        return SendClientMessage(playerid, COLOR_RED, "USO: /gotoco [x] [y] [z]");

    if(IsPlayerInAnyVehicle(playerid)) 
        JBC_SetVehiclePos(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
    
    else 
        JBC_SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);

    format(string, sizeof string, "[INFO] Has ido a las coordenadas: %.1f %.1f %.1f", Pos[0], Pos[1], Pos[2]);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    return 1;
}



CMD:repair(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    if(IsPlayerInAnyVehicle(playerid))
    {
        new VehicleID = GetPlayerVehicleID(playerid);
        JBC_RepairVehicle(VehicleID);
        GameTextForPlayer(playerid, "~w~~n~~n~~n~~n~~n~~n~Vehiculo ~g~Reparado!", 3000, 3);
    }
    
    else
        SendClientMessage(playerid, COLOR_RED, "[ERROR] Debes estar dentro de un vehiculo para usar este comando.");
    return 1;
}

CMD:rcars(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new 
        Float:range,
        carID[50],
        car,
        colour1,
        colour2,
        string[128], 
        numcars;
    new 
        Float:ax, 
        Float:ay,
        Float:az;
    
    GetPlayerPos(playerid, ax, ay, az);

    if(sscanf(params, "fs[50]I(255)I(255)", range, carID, colour1, colour2))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rcars [rango] [vehiculo] [color1] [color2]");

    if(range < 1 || range > 1000) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");
    
    if(!isnumeric(carID)) 
        car = GetVehicleModelIDFromName(carID);
    
    else 
        car = strval(carID);
    
    if(car < 400 || car > 611) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] ID de Vehiculo no valido.");
    
    if(colour1==255) 
        colour1=random(256);
    
    if(colour2==255) 
        colour2=random(256);

    for(new i = 1; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && 
            GetPlayerVirtualWorld(i) == 
                GetPlayerVirtualWorld(playerid) && GetPlayerDistanceFromPoint(i, ax, ay, az) <= range)
        {
            if(IsValidVehicle(User[i][pCar]) && !IsPlayerAdmin(i)) 
                EraseVeh(User[i][pCar]);
            
            DelVehicle(GetPlayerVehicleID(i));
            new VehicleID;
            new 
                Float:X, 
                Float:Y, 
                Float:Z;
            
            new 
                Float:Angle, 
                int1;
            
            GetPlayerPos(i, X, Y, Z);
            GetPlayerFacingAngle(i, Angle);
            
            int1 = GetPlayerInterior(i);
            VehicleID = JBC_CreateVehicle(car, X+3,Y,Z, Angle, colour1, colour2, -1);
            
            LinkVehicleToInterior(VehicleID, int1);
            SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(i));
            JBC_PutPlayerInVehicle(i, VehicleID, 0);
            
            User[i][pCar] = VehicleID;
            numcars++;
        }
    }
    if(!numcars) 
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador beneficiado.");
    
    format(string, sizeof(string), 
        "[RCAR] %s[%d] les dio un %s(%d) a %d jugadores en el radio de %d metros.",
            pName(playerid),playerid,VehicleNames[car-400],car,numcars,floatround(range));
    
    SaveLog("abuso.txt", string);
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}

CMD:rweaps(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new 
        string[128], 
        Float:range, 
        numcars, 
        arma, 
        municion;
    new 
        Float:x, 
        Float:y, 
        Float:z;
    
    GetPlayerPos(playerid, x, y, z);

    if(sscanf(params, "fdd", range, arma, municion)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /rweaps [rango] [armaid] [municion]");
    
    if(range > 1000 || range <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");

    if(range < 1 || range > 1000) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");
    if(!IsValidWeapon(arma)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El ID del arma es invalido.");
    
    if(municion <= 0 || municion > 99999) municion = 500;

    for(new i = 1; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerDistanceFromPoint(i, x, y, z) <= range)
        {
            JBC_GivePlayerWeapon(i,arma,municion);
            numcars++;
        }
    }

    if(!numcars) 
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador beneficiado.");

    format(string, sizeof(string), 
        "[RWEAPS] %s[%d] les dio el arma id %d (municiones: %d) a %d jugadores en el radio de %d metros.",pName(playerid),playerid,arma,municion,numcars,floatround(range));
    
    SaveLog("abuso.txt", string);
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}
CMD:rheal(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new 
        string[128], 
        Float:range, 
        numcars;
    new 
        Float:x, 
        Float:y, 
        Float:z;
    
    GetPlayerPos(playerid, x, y, z);

    if(sscanf(params, "f", range))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rheal [rango]");

    if(range > 1000 || range <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");

    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && GetPlayerDistanceFromPoint(i, x, y, z) <= range && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
        {
            numcars++;
        }
    }

    if(!numcars)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador curado.");

    format(string, sizeof(string), "[INFO] Has curado %d jugadores en el rango de %d metros.", numcars, floatround(range));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[RHEAL] %s[ID:%d] ha curado a %d jugadores en el radio de %d metros.", pName(playerid), playerid, numcars, floatround(range));
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}

CMD:rarmour(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new 
        string[128], 
        Float:range, 
        numcars;
    
    new 
        Float:x, 
        Float:y, 
        Float:z;
    
    GetPlayerPos(playerid, x, y, z);

    if(sscanf(params, "f", range))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rarmour [rango]");

    if(range > 1000 || range <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");

    for(new i = 1; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && 
            GetPlayerVirtualWorld(i) == 
                GetPlayerVirtualWorld(playerid) && 
                    GetPlayerDistanceFromPoint(i, x, y, z) <= range)
        {
            JBC_SetPlayerArmour(i,100);
            numcars++;
        }
    }

    if(!numcars)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador ha recibido chaleco.");

    format(string, sizeof(string), "[INFO] Has dado chaleco a %d jugadores en el rango de %d metros.", numcars, floatround(range));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[RARMOUR] %s[ID:%d] ha dado chaleco a %d jugadores en el radio de %d metros.", pName(playerid), playerid, numcars, floatround(range));
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}
CMD:rtodo(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new 
        string[128], 
        Float:range, 
        numcars;
    new 
        Float:x, 
        Float:y, 
        Float:z;
    
    GetPlayerPos(playerid, x, y, z);

    if(sscanf(params, "f", range))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rtodo [rango]");

    if(range > 1000 || range <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");

    for(new i = 1; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && 
            GetPlayerVirtualWorld(i) == 
                GetPlayerVirtualWorld(playerid) && 
                    GetPlayerDistanceFromPoint(i, x, y, z) <= range)
                    {
                    JBC_SetPlayerHealth(i,100);
                    JBC_SetPlayerArmour(i,100);
                    numcars++;
                    }
    }

    if(!numcars)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador beneficiado.");

    format(string, sizeof(string), "[INFO] Has dado vida y chaleco %d jugadores en el rango de %d metros.", numcars, floatround(range));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[RTODO] %s[ID:%d] ha dado vida y chaleco a %d jugadores en el radio de %d metros.", pName(playerid), playerid, numcars, floatround(range));
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}

CMD:rdestroycar(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new string[128], Float:range, numcars;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    if(range > 1000 || range <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");

    if(sscanf(params, "f", range))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rdestroycar [rango]");

    for(new i = 1; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && 
                GetPlayerVirtualWorld(i) == 
                    GetPlayerVirtualWorld(playerid) && 
                        GetPlayerDistanceFromPoint(i, x, y, z) <= range)
        {
            DelVehicle(GetPlayerVehicleID(i));
            numcars++;
        }
    }

    if(!numcars)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador beneficiado.");

    format(string, sizeof(string), "[INFO] Has destruido el vehiculo %d jugadores en el rango de %d metros.", numcars, floatround(range));
    SendClientMessage(playerid, COLOR_YELLOW, string);

    format(string, sizeof(string), "[INFO] %s[ID:%d] ha quitado el auto a %d jugadores en el radio de %d metros.", pName(playerid), playerid, numcars, floatround(range));
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}
CMD:rdisarm(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new string[128], Float:range, numcars;
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    if(range > 1000 || range <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");

    if(sscanf(params, "f", range))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rdisarm [rango]");

    for(new i = 1; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && 
            GetPlayerVirtualWorld(i) == 
                GetPlayerVirtualWorld(playerid) && 
                    GetPlayerDistanceFromPoint(i, x, y, z) <= range)
        {
            ResetPlayerWeapons(i);
            numcars++;
        }
    }

    if(!numcars)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador beneficiado.");

    format(string, sizeof(string), "[INFO] Has desarmado a %d jugadores en el rango de %d metros.", numcars, floatround(range));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[RDISARM] %s[ID:%d] ha desarmado a %d jugadores en el radio de %d metros.", pName(playerid), playerid, numcars, floatround(range));
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}

CMD:rspawn(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new 
        string[128], 
        Float:range, 
        numcars;
    new 
        Float:x, 
        Float:y, 
        Float:z;
    GetPlayerPos(playerid, x, y, z);

    if(sscanf(params, "f", range))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rspawn [rango]");

    if(range > 1000 || range <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");

    for(new i = 1; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && 
            GetPlayerVirtualWorld(i) == 
                GetPlayerVirtualWorld(playerid) && 
                    GetPlayerDistanceFromPoint(i, x, y, z) <= range)
        {
            SpawnPlayer(i);
            numcars++;
        }
    }

    if(!numcars)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador beneficiado.");

    format(string, sizeof(string), "[INFO] Has spawneado a %d jugadores en el rango de %d metros.", numcars, floatround(range));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[RSPAWN] %s[ID:%d] ha spawneado a %d jugadores en el radio de %d metros.", pName(playerid), playerid, numcars, floatround(range));
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}
CMD:rfreeze(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new 
        string[128], 
        Float:range, 
        numcars;
    new 
        Float:x, 
        Float:y, 
        Float:z;
    
    GetPlayerPos(playerid, x, y, z);

    if(sscanf(params, "f", range))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rfreeze [rango]");

    if(range > 1000 || range <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");

    for(new i = 1; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && 
            GetPlayerVirtualWorld(i) == 
                GetPlayerVirtualWorld(playerid) && 
                    GetPlayerDistanceFromPoint(i, x, y, z) <= range)
        {
            JBC_TogglePlayerControllable(i, false);
            numcars ++;
        }
    }

    if(!numcars)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador beneficiado.");

    format(string, sizeof(string), "[INFO] Has congelado a %d jugadores en el rango de %d metros.", numcars, floatround(range));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[RFREEZE] %s[ID:%d] ha congelado a %d jugadores en el radio de %d metros.", pName(playerid), playerid, numcars, floatround(range));
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}
CMD:runfreeze(playerid, params[])
{
            	
    LevelCheck(playerid, 5);

    new 
        string[128], 
        Float:range, 
        numcars;
    new 
        Float:x, 
        Float:y, 
        Float:z;
    
    GetPlayerPos(playerid, x, y, z);

    if(sscanf(params, "f", range))
        return SendClientMessage(playerid, COLOR_RED, "USO: /runfreeze [rango]");

    if(range > 1000 || range <= 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El rango debe ser entre 1 y 1000.");

    for(new i = 1; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && 
            GetPlayerVirtualWorld(i) == 
                GetPlayerVirtualWorld(playerid) && 
                    GetPlayerDistanceFromPoint(i, x, y, z) <= range)
        {
            JBC_TogglePlayerControllable(i, true);
            numcars ++;
        }
    }

    if(!numcars)
    return SendClientMessage(playerid, COLOR_RED, "[INFO] Ningún jugador beneficiado.");

    format(string, sizeof(string), "[INFO] Has descongelado a %d jugadores en el rango de %d metros.", numcars, floatround(range));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[RUNFREEZE] %s[ID:%d] ha descongelado a %d jugadores en el radio de %d metros.", pName(playerid), playerid, numcars, floatround(range));
    SendClientMessageToAll(COLOR_LIGHTBLUE, string);
    return 1;
}
//CMD ADM LVL 6
CMD:remwarn(playerid, params[])
{
            	
    LevelCheck(playerid, 6);

    new
        string[130],
        id
        ;

    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /remwarn [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(id == playerid)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes quitarte advertencias a ti mismo.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    if(User[id][accountWarn] == 0)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No tiene advertencias.");
    
    User[id][accountWarn] -= 1;

    format(string, sizeof(string), "[ADMIN] %s[ID:%d] le ha quitado a %s[%d] una advertencia (Restantes: %i)", pName(playerid), playerid, pName(id), id, User[id][accountWarn]);
    SaveLog("warn.txt", string);
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}

CMD:car(playerid, params[])
{
            	
    LevelCheck(playerid, 6);

    new 
        carID[50], 
        car, 
        colour1, 
        colour2, 
        string[128];
    
    if(sscanf(params, "s[50]I(255)I(255)", carID, colour1, colour2)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /car [VehicleID(Name)] [Color1(Optional)] [Color2(Optional)]");
    
    if(!isnumeric(carID)) 
        car = GetVehicleModelIDFromName(carID);
    
    else 
        car = strval(carID);
    
    if(IsPlayerInAnyVehicle(playerid)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya tienes un vehículo.");
    
    if(car < 400 || car > 611) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] ID de Vehiculo no valido.");

    if(colour1==255) 
        colour1=random(256);
    
    if(colour2==255) 
        colour2=random(256);

    if(IsValidVehicle(User[playerid][pCar]) && !IsPlayerAdmin(playerid))
        EraseVeh(User[playerid][pCar]);
    
    new 
        VehicleID;
    
    new 
        Float:X, 
        Float:Y, 
        Float:Z;
    new 
        Float:Angle, 
        int1;
    
    GetPlayerPos(playerid, X, Y, Z);
    GetPlayerFacingAngle(playerid, Angle);
    
    int1 = GetPlayerInterior(playerid);
    VehicleID = JBC_CreateVehicle(car, X+3,Y,Z, Angle, colour1, colour2, -1);
    
    LinkVehicleToInterior(VehicleID, int1);
    SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(playerid));
    JBC_PutPlayerInVehicle(playerid, VehicleID, 0);
    
    User[playerid][pCar] = VehicleID;
    
    format(string, sizeof(string), "[INFO] Has spawneado un \"%s\" (Modelo: %d) - Colores: %d,%d", VehicleNames[car-400], car, colour1, colour2);
    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    
    format(string, sizeof(string), "[CAR] %s ha spawneado un \"%s\" (Modelo: %d)", pName(playerid),VehicleNames[car-400], car);
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:megajump(playerid, params[])
{
    new string[128], id;

            	
    LevelCheck(playerid, 6);

    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /megajump [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    switch(User[id][accountJump])
    {
        case 0:
        {
            format(string, sizeof(string), "[ADMIN] %s le ha dado a %s el poder del MegaJump.", pName(playerid), pName(id));
            SendAdminMessage(COLOR_GREEN, string);
            format(string, sizeof(string), "* [INFO] %s te ha dado la habilidad del MegaJump.", pName(playerid));
            SendClientMessage(id, COLOR_GREEN, string);
            format(string, sizeof(string), "* [INFO] Le has dado a %s la habilidad del Mega-Jump.", pName(id));
            SendClientMessage(playerid, -1, string);
            User[id][accountJump] = 1;
        }
        case 1:
        {
            format(string, sizeof(string), "[ADMIN] %s le ha quitado a %s el poder de MegaJump.", pName(playerid), pName(id));
            SendAdminMessage(COLOR_RED, string);
            format(string, sizeof(string), "[INFO] %s te ha quitado el poder del MegaJump.", pName(playerid));
            SendClientMessage(id, COLOR_RED, string);
            format(string, sizeof(string), "[INFO] Le has quitado el poder de MegaJump a %s.", pName(id));
            SendClientMessage(playerid, -1, string);
            User[id][accountJump] = 0;
        }
    }
    return 1;
}

CMD:healall(playerid, params[])
{
            	
    LevelCheck(playerid, 6);

    new
        string[130]
    ;

    foreach(new i : Player)
    {
        if(i != playerid)
        {
            JBC_SetPlayerHealth(i, 100.0);
        }
    }
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] ha curado a todos los jugadores del servidor.", pName(playerid), playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}

CMD:oban(playerid, params[])
{
            	
    LevelCheck(playerid, 6);

    new
        string[150],
        name[24],
        reason[25],
        Query[256],
        admin,
        ip[20],
        DBResult:Result,
        ban_hr, ban_min, ban_sec, ban_month, ban_days, ban_years
    ;

    gettime(ban_hr, ban_min, ban_sec);
    getdate(ban_years, ban_month, ban_days);

    if(sscanf(params, "s[24]s[128]", name, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /oban [name in the data] [razon]");
    
    foreach(new i : Player)
    {
        if(strcmp(pName(i), name, true) == 0)
        {
            SendClientMessage(playerid, COLOR_RED, "[INFO] El jugador que intentas banear se encuentra Online, usa /Ban..");
            return 1;
        }
    }
    
    format(Query, sizeof(Query), "SELECT * FROM `users` WHERE `username` = '%s'", DB_Escape(name));
    Result = db_query(DB_USERS, Query);
    
    if(db_num_rows(Result))
    {
        admin = db_get_field_assoc_int(Result, "admin");
        db_get_field_assoc(Result, "IP", ip, 20);

        if(User[playerid][accountAdmin] < admin)
        {
            SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

            format(string, sizeof(string), "[OBAN] %s ha intentado un Offline Ban contra %s pero fallo porque %s", pName(playerid), name, reason);
            SaveLog("ban.txt", string);
            return 1;
        }

        BanAccountEx(name, ip, pName(playerid), reason);

        format(string, sizeof(string), "[BANNED] %s ha recibido un Offline Ban [Razon: {FFFFFF}%s]", name, reason);
        SendClientMessageToAll(COLOR_GREY, string);
        printf(string);
        
        for(new i = 0; i < MAX_PLAYERS; i++) 
        {
            PlayerPlaySound(i,1132,0.0,0.0,0.0);
        }
        
        format(string, sizeof(string), "[BANNED] %s ha recibido un Offline Ban de %s [Razon: {FFFFFF}%s]", name, pName(playerid), reason);
        SaveLog("ban.txt", string);
        }
    
    else
    {
        SendClientMessage(playerid, COLOR_RED, "[ERROR] No se encuentra en la base de datos.");
    }
    db_free_result(Result);
    return 1;
}

CMD:setallinterior(playerid, params[])
{
            	
    LevelCheck(playerid, 6);

    new
        id,
        string[130]
        ;
    
    if(sscanf(params, "i", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setallinterior [interior]");
    
    foreach(new i : Player)
    {
        PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
        SetPlayerInterior(i, id);
    }
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] ha seteado el interior de todos en: \"%d\"", pName(playerid), playerid, id);
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}

CMD:setwantedall(playerid, params[])
{
            	
    LevelCheck(playerid, 6);

    new 
        string[128], 
        amount
        ;

    if(sscanf(params, "d", amount))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setwantedall [amount(0/6)]");

    if(amount < 0 || amount > 6)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Nivel de buscado no valido.");

    foreach(new i : Player)
    {
        if(i != playerid)
        {
            SetPlayerWantedLevel(i, amount);
        }
    }

    format(string, sizeof(string), "[ADMIN] %s[ID:%d] le ha seteado a todos el Nivel de buscado: %d.", pName(playerid), playerid, amount);
    SendClientMessageToAll(COLOR_YELLOW, string);
    printf(string);
    return 1;
}
CMD:ejectall(playerid, params[])
{
            	
    LevelCheck(playerid, 6);

    new string[128];

    foreach(new i : Player)
    {
        if(IsPlayerInAnyVehicle(i))
        {
            RemovePlayerFromVehicle(i);
        }
    }
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] ha expulsado a todos de su vehiculo.", pName(playerid), playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}



CMD:setallworld(playerid, params[])
{
            	
    LevelCheck(playerid, 6);

    new
        id,
        string[130]
        ;

    if(sscanf(params, "i", id)) return SendClientMessage(playerid, COLOR_RED, "USO: /setallworld [world]");
    foreach(new i : Player)
    {
        PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
        SetPlayerVirtualWorld(i, id);
    }
    
    format(string, sizeof(string), 
        "[ADMIN] %s[ID:%d] le ha seteado a todos los jugadores el Munto virtual en: \"%d\"", pName(playerid), playerid, id);
    
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}
//CMD ADM LVL 7
CMD:entercar(playerid, params[])
{
    new 
        string[128], 
        id;

            	
    LevelCheck(playerid, 7);

    if(sscanf(params, "d", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /entercar [vehicleid]");

    if(id < 1 || !IsValidVehicle(id) || id > MAX_VEHICLES)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] ID del vehiculo es invalido.");

    if(!IsSeatAvailable(id, 0))
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El vehiculo esta ocupado.");

    JBC_PutPlayerInVehicle(playerid, id, 0);
    format(string, sizeof(string), "[INFO] Te has teletransportado al vehiculo ID: %d. Ahora lo manejas.", id);
    SendClientMessage(playerid, -1, string);
    return 1;
}

CMD:addnos(playerid, params[])
{
            	
    LevelCheck(playerid, 7);

    if(IsPlayerInAnyVehicle(playerid))
    {
        switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
        {
            case 448,461,462,463,468,471,509,510,521,522,523,581,586,449: SendClientMessage(playerid, COLOR_RED, "[ERROR] No le puedes agregar nitro a este vehiculo.");
        }
        JBC_AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
    }
    else
        SendClientMessage(playerid, COLOR_RED, "[ERROR] Debes estar dentro de un vehiculo para usar este comando.");
    return 1;
}


CMD:jetpack(playerid, params[])
{
            	
    LevelCheck(playerid, 7);

    new
        id,
        string[130]
        ;

    if(!sscanf(params, "u", id))
    {
        if(id == INVALID_PLAYER_ID) 
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
        if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
        
        JBC_SetPlayerSpecialAction(id, SPECIAL_ACTION_USEJETPACK);
        format(string, sizeof(string), "[INFO] Le has dado a %s[ID:%d] un Jetpack.", pName(id), id);
        SendClientMessage(playerid, COLOR_YELLOW, string);
        
        format(string, sizeof(string), "[ADMIN] %s[ID:%d] te ha dado un Jetpack.", pName(playerid), playerid);
        SendClientMessage(id, COLOR_YELLOW, string);
    }
    
    else
    {
        JBC_SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
        SendClientMessage(playerid, COLOR_YELLOW, "Jetpack Spawneado!");
        SendClientMessage(playerid, -1, "[TIP] Puedes usar este comando en alguien mas. Usa "orange"/jetpack [playerid]");
    }
    return 1;
}

CMD:carpjob(playerid, params[])
{
            	
    LevelCheck(playerid, 7);

    new
        string[130],
        id,
        pjob
        ;
    
    if(sscanf(params, "ui", id, pjob)) 
        return SendClientMessage(playerid, COLOR_RED, "* /carpjob [playerid] [paintjob(0-3)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(!IsPlayerInAnyVehicle(id)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador debe estar dentro del vehiculo.");
    
    if(pjob < 0 || pjob > 3) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] PaintJob ID no valido.");

    format(string, sizeof(string), "[INFO] Has cambiado el Paintjob de %s[ID:%d] %s a '%d'", pName(id), id, VehicleNames[GetVehicleModel(GetPlayerVehicleID(id))-400], pjob);
    SendClientMessage(playerid, COLOR_GREEN, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] ha cambiado el PaintJob de tu %s a '%d'", pName(playerid), playerid, VehicleNames[GetVehicleModel(GetPlayerVehicleID(id))-400], pjob);
    SendClientMessage(id, COLOR_YELLOW, string);
    ChangeVehiclePaintjob(GetPlayerVehicleID(id), pjob);
    
    if(IsPlayerInVehicle(id, vehicleOwner[id]))
    {
        ChangeVehiclePaintjob(vehicleOwner[id], pjob);
    }
    return 1;
}
CMD:forbidword(playerid, params[])
{
            	
    LevelCheck(playerid, 7);

    new 
        string[128], 
        File:BLfile, 
        word[25]
        ;

    if(sscanf(params, "s[25]", word))
        return SendClientMessage(playerid, COLOR_RED, "USO: /forbidword [word]");

    BLfile = fopen("JakAdmin3/ForbiddenWords.cfg", io_append);
    
    format(string, sizeof(string), "%s\r\n", word);
    fwrite(BLfile, word);
    fclose(BLfile);

    format(string, sizeof(string), "%s añadió la palabra %s a la lista de palabras prohibidas.", pName(playerid), word);
    SendAdminMessage(COLOR_GREEN, string);

    UpdateForbidden();
    return 1;
}

CMD:forbidname(playerid, params[])
{
            	
    LevelCheck(playerid, 7);

    new 
        string[128], 
        File:BLfile
        ;

    if(isnull(params))
        return SendClientMessage(playerid, COLOR_RED, "USO: /forbidname [nickname]");

    if(strlen(params) < 3 || strlen(params) > 20)
        return SendClientMessage(playerid, COLOR_RED, "USO: /forbidname [nickname]");

    BLfile = fopen("JakAdmin3/ForbiddenNames.cfg", io_append);
    
    format(string, sizeof(string), "%s\r\n", params);
    fwrite(BLfile, string);
    fclose(BLfile);

    format(string, sizeof(string), "[ADMIN] %s ha agregado el Nick \"%s\" a la Forbidenn Name List.", pName(playerid), params);
    SendAdminMessage(COLOR_GREEN, string);

    UpdateForbidden();
    return 1;
}
CMD:force(playerid, params[])
{
            	
    LevelCheck(playerid, 7);

    new
        string[130],
        id
        ;

    if(sscanf(params, "u", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /force [playerid]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    format(string, sizeof(string), "[INFO] Has forzado a %s[ID:%d] a volver a la seleccion de equipos.", pName(id), id);
    SendClientMessage(playerid, COLOR_YELLOW, string);

    format(string, sizeof(string), "[ADMIN] %s[ID:%d] te ha forzado a volver a la seleccion de equipos.", pName(playerid), playerid);
    SendClientMessage(id, COLOR_YELLOW, string);

    JBC_SetPlayerHealth(id, 0.0);
    ForceClassSelection(id);
    return 1;
}


CMD:teleplayer(playerid, params[])
{
            	
    LevelCheck(playerid, 7);

    new
        string[128],
        id,
        id2,
        Float:x,
        Float:y,
        Float:z
        ;
    
    if(sscanf(params, "uu", id, id2)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /teleplayer [playerid] to [playerid2]");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(User[playerid][accountAdmin] < User[id2][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(id2 == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(id == playerid && id2 == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "* You cannot teleport yourself to yourself!");
    
    GetPlayerPos(id2, x, y, z);
    
    format(string, sizeof(string), "You have teleported Player %s(%d) a %s(%d)", pName(id), id, pName(id2), id2);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[INFO] Te has teleported a %s(%d) by [ADMIN] %s[ID:%d]", pName(id2), id2, pName(playerid), playerid);
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] has port %s(%d) to you", pName(playerid), playerid, pName(id), id);
    SendClientMessage(id2, COLOR_YELLOW, string);
    
    SetPlayerInterior(id, GetPlayerInterior(id2));
    SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(id2));
    
    if(GetPlayerState(id) == 2)
    {
        JBC_SetVehiclePos(GetPlayerVehicleID(id), x+3, y, z);
        LinkVehicleToInterior(GetPlayerVehicleID(id), GetPlayerInterior(id2));
        SetVehicleVirtualWorld(GetPlayerVehicleID(id), GetPlayerVirtualWorld(id2));
    }
    
    else 
        JBC_SetPlayerPos(id, x+2, y, z);

    return 1;
}
CMD:cname(playerid, params[])
{
            	
    LevelCheck(playerid, 7);

    new
        string[450],
        id,
        result = 0,
        newname[24]
        ;

    if(sscanf(params, "us[24]", id, newname)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /cname [playerid] [new name]");
    
    if(strlen(newname) < 3 || strlen(newname) > MAX_PLAYER_NAME) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Cantidad de caracteres no validos.");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if((result = CheckAccount(newname)) != 0)
    {
        format(string, sizeof(string), "[ERROR] Ese Nick ya esta en uso (#UserID %d)", result);
        SendClientMessage(playerid, COLOR_RED, string);
        return 1;
    }
    
    if(!User[id][accountLogged]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No estas logueado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    /*if(User[id][accountClan] != 0 && User[id][accountRango] == 4)
    {
        new q[88];
        
        for(new c=0;c<MAX_CLANES;c++)
        {
            if(Clans[c][CLAN_ID] == User[id][accountClan])
            {
                format(Clans[c][CLAN_LIDER], 22, newname);
                format(q, sizeof(q), "UPDATE `Clanes` SET `Lider`='%s' WHERE `ClanID`='%d' COLLATE NOCASE", DB_Escape(newname),DB_Escape(User[id][accountClan]));
                db_free_result(db_query(DB_CLANS, q));
            }
        }
    }*/
    
    format(string, sizeof string, "[ADMIN] %s le ha cambiado el Nick a %s - Nuevo: %s", pName(playerid), pName(id), newname);
    SendClientMessageToAll(COLOR_RED, string);
    SaveLog("cuentas.txt", string);

    format(string, sizeof(string), "[INFO] Le has cambiado el Nick de \"%s\" a \"%s\".", pName(id), newname); SendClientMessage(playerid, COLOR_YELLOW, string);
    format(string, sizeof(string), "[ADMIN] \"%s\" te ha cambiado tu Nick a \"%s\".", pName(playerid), newname); SendClientMessage(id, COLOR_YELLOW, string);
    
    JBC_SetPlayerName(id, newname);
    
    format(string, sizeof(string), "UPDATE `users` SET `username` = '%s' WHERE `userid` = %d", DB_Escape(newname), User[id][accountID]);
    db_query(DB_USERS, string);
    return 1;
}
CMD:setpass(playerid, params[])
{
            	
    LevelCheck(playerid, 7);

    new 
        NewPass[24], 
        AccountName[24], 
        string[128], 
        Buf[129], 
        Query[300], DBResult:Result
        ;

    if(sscanf(params, "s[24]s[24]", AccountName, NewPass))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setpass [account name] [new pass]");

    if(strlen(NewPass) < 4 || strlen(NewPass) > 20)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Tu nueva password no debe ser menor que 4 ni mayor que 20 caracteres.");

    WP_Hash(Buf, 129, NewPass);

    format(Query, sizeof(Query), "SELECT `userid` FROM `users` WHERE `username` = '%s'", DB_Escape(AccountName));
    Result = db_query(DB_USERS, Query);

    if(db_num_rows(Result))
    {
        format(Query, sizeof(Query), "UPDATE `users` SET `password` = '%s' WHERE `username` = '%s'", DB_Escape(Buf), DB_Escape(AccountName));
        db_query(DB_USERS, Query);

        format(string, sizeof string, "[ADMIN] %s le ha cambiado a %s la password a %s.", pName(playerid), AccountName, NewPass);
        SaveLog("cuentas.txt", string);
        format(string, sizeof string, "[INFOADMINS] %s le ha cambiado a %s su password.", pName(playerid), AccountName);
        SendAdminMessage(COLOR_GREEN, string);

        format(string, sizeof(string), "[INFO] Le has cambiado a %s la password a %s.", AccountName, NewPass);
        SendClientMessage(playerid, COLOR_YELLOW, string);
    }
    
    else
    {
        format(string, sizeof(string), "[ERROR] Cuenta: %s, no existe.", AccountName);
        SendClientMessage(playerid, COLOR_RED, string);
    }
    db_free_result(Result);
    return 1;
}

CMD:setallskin(playerid, params[])
{
    new string[128+40], skin;

            	
    LevelCheck(playerid, 7);

    if(sscanf(params, "i", skin)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setallskin [skin(0-311)]");

    if(skin < 0 || skin == 74 || skin > 311) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] SkinID no valido.");

    foreach(new i : Player)
    {
        JBC_SetPlayerSkin(i, skin);

        if(GetPlayerState(i) == PLAYER_STATE_ONFOOT)
        {
            ClearAnimations(i, 1);
        }
        
        if(IsPlayerInAnyVehicle(i))
        {
            RemovePlayerFromVehicle(i);
            ClearAnimations(i, 1);
        }
    }

    format(string, sizeof(string), "[ADMIN] %s[ID:%d]  ha seteado a todos el skinID: %d.", pName(playerid), playerid, skin);
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}
//CMD ADM LVL 8
CMD:fakechat(playerid, params[])
{
            	
    LevelCheck(playerid, 8);

    new
        string[130],
        id,
        text[128],
        s[128]
        ;

    if(sscanf(params, "us[128]", id, text)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /fakechat [playerid] [text]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    format(string, sizeof(string), "[INFO]Enviaste un chat falso de: %s[ID:%d] Mensaje: %s", pName(id), id, text);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(s, sizeof(s), "%s[%d]:"white" %s", pName(id), id, text);
    SendClientMessageToAll(GetPlayerColor(id), s);
    return 1;
}


CMD:votekicktime(playerid, params[])
{
    new 
        string[128], 
        second
        ;

            	
    LevelCheck(playerid, 8);

    if(sscanf(params, "i", second))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setvotekicklimit [limite(30/300)]");

    if(second < 30 || second > 300)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El tiempo debe ser mayor a 30 y menor a 300 segundos.");

    if(second == KickTime)
    {
        format(string, sizeof(string), "[ERROR] Tiempo de VoteKick es igual al valor que intentas ingresar [%i segundos].", second);
        return SendClientMessage(playerid, COLOR_RED, string);
    }

    format(string, sizeof(string), "[INFO] %s[ID:%d] ha cambiado el tiempo del VoteKick a %d segundos.", pName(playerid), playerid, second);
    SendClientMessageToAll(COLOR_YELLOW, string);
    SaveLog("votekick.txt", string);
    
    KickTime = second;
    return 1;
}

CMD:endvotekick(playerid, params[])
{
    new
        string[128],
        reason[38]
        ;

            	
    LevelCheck(playerid, 8);

    if(!VoteKickHappening)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No hay un VoteKick abierto ahora mismo.");

    if(sscanf(params, "s[38]", reason))
        return SendClientMessage(playerid, COLOR_RED, "USO: /endvotekick [razon]");

    format(string, sizeof(string), "[ADMIN] %s ha revocado y cerrado el VoteKick contra %s [Razon: %s]", pName(playerid), pName(VoteKickTarget), reason);
    SendClientMessageToAll(COLOR_YELLOW, string);
    SaveLog("votekick.txt", string);

    format(VoteKickReason, sizeof(VoteKickReason), "N/D");
    
    VoteKickHappening = 0;
    avotes = 0;
    svotes = 0;
    VoteKickTarget = INVALID_PLAYER_ID;
    
    KillTimer(VoteTimer);
    foreach(new i : Player)
    {
        HasAlreadyVoted{i} = false;
    }
    return 1;
}

CMD:bankrupt(playerid, params[])
{
            	
    LevelCheck(playerid, 8);
   
    new 
        id, 
        s[128], 
        s2[128],
        l[64],
        reason[10]
        ;
   
    if(sscanf(params, "us[10]", id, reason))
        return SendClientMessage(playerid, COLOR_RED, "Uso: /bankrupt [playerid] [razón]");

    format(s, 128, "[INFO] Dejaste en banca rota a %s[ID:%d] por %s.", pName(id), id, reason);
    SendClientMessage(playerid, COLOR_ORANGE, s);
   
    format(s2, 128, "[INFO] %s te ha dejado en banca rota por %s.", pName(playerid), reason);
    SendClientMessage(id, COLOR_ORANGE, s2);

    User[id][accountChocolate] = 0;
    SetPlayerScore(id, 0);

    format(l, 64, "%s dejo en banca rota a %s por %s", pName(playerid), pName(id), reason);
    SaveLog("abuso.txt", l);
    return 1;
}

CMD:setvhealth(playerid, params[])
{
            	
    LevelCheck(playerid, 8);

    new
        string[130],
        id,
        hp
        ;

    if(sscanf(params, "ud", id, hp)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setvhealth [playerid] [health]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    new Float:hp2 = float(hp);

    if(hp < 375 || hp > 2000)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Mínimo 375, máximo 2000");

    if(!IsPlayerInAnyVehicle(id)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Jugador debe estar dentro de un vehiculo");
    
    JBC_SetVehicleHealth(GetPlayerVehicleID(id), hp2);

    format(string, sizeof(string), "[INFO] Le has setado al jugador %s[ID:%d] la vida del vehiculo a %d", pName(id), id, floatround(hp2));
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d]  te ha cambiado tu vida del vehiculo a %d", pName(playerid), playerid, floatround(hp2));
    SendClientMessage(id, COLOR_YELLOW, string);
    return 1;
}

CMD:setskin(playerid, params[])
{
    new
        string[128+40],
        id,
        skin
        ;

            	
    LevelCheck(playerid, 8);

    if(sscanf(params, "ui", id, skin)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setskin [playerid] [skin(0-311)]");
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(skin < 0 || skin == 74 || skin > 311) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] SkinID no valido.");

    format(string, 128, "[INFO] Le has seteado a "orange"%s "white"el SkinID a "grey"%d", pName(id), skin);
    SendClientMessage(playerid, -1, string);

    format(string, 128, "[ADMIN] "orange"%s "white"te ha cambiado tu skinID a "grey"%d", pName(playerid), skin);
    SendClientMessage(id, -1, string);
    
    format(string, 128, "[SETSKIN] "orange"%s "white"la cambio a %s el skinid "grey"%d", pName(playerid), pName(id), skin);
    SaveLog("set.txt", string);
    
    JBC_SetPlayerSkin(id, skin);
    
    if(GetPlayerState(id) == PLAYER_STATE_ONFOOT)
    {
        ClearAnimations(id, 1);
    }
    
    if(IsPlayerInAnyVehicle(id))
    {
        RemovePlayerFromVehicle(id);
        ClearAnimations(id, 1);
    }
    return 1;
}

CMD:armour(playerid, params[])
{
            	
    LevelCheck(playerid, 8);

    new
        id,
        string[130]
        ;

    if(sscanf(params, "u", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /armour [playerid]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(id == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes darte armadura a tí mismo.");

    JBC_SetPlayerArmour(id, 100.0);
    format(string, sizeof(string), "[INFO] Le has dado a %s un chaleco completo.", pName(id));
    
    SendClientMessage(playerid, COLOR_YELLOW, string);
    format(string, sizeof(string), "[ADMIN] %s te ha dado un chaleco completo.", pName(playerid));
    
    SendClientMessage(id, COLOR_YELLOW, string);
    format(string, sizeof(string), "[ARMOR] %s te ha dado a %s chaleco completo.", pName(playerid), pName(id));
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:setvotekicklimit(playerid, params[])
{
    new string[128], limit;

            	
    LevelCheck(playerid, 8);

    if(sscanf(params, "i", limit))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setvotekicklimit [limit(3-10)]");

    if(limit > 3 && limit < 10)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El limite debe estar entre 1 y 10.");

    if(limit == MaxVKICK)
    {
        format(string, sizeof(string), "[ERROR] La cantidad de votos es %i!", limit);
        return SendClientMessage(playerid, COLOR_RED, string);
    }

    format(string, sizeof(string), "[VOTEKICK] %s[ID:%d] ha cambiado la cantidad de votos requeridos a %d.", pName(playerid), playerid, limit);
    SendClientMessageToAll(COLOR_YELLOW, string);
    SaveLog("votekick.txt", string);
   
    MaxVKICK = limit;
    return 1;
}
CMD:armourall(playerid, params[])
{
            	
    LevelCheck(playerid, 8);

    new
        string[130]
        ;
   
    foreach(new i : Player)
    {
        if(i != playerid)
        {
            JBC_SetPlayerArmour(i, 100.0);
        }
    }
    
    format(string, sizeof(string), "[ADMIN] %s[ID:%d] le ha dado un chaleco completo a todos los jugadores del servidor.", pName(playerid), playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}
CMD:removeacc(playerid, params[])
{
            	
    LevelCheck(playerid, 8);

    new
        Account[MAX_PLAYER_NAME],
        Reason[15],
        string[128]
        ;
    
    if(sscanf(params, "s[24]s[15]", Account, Reason))
        return SendClientMessage(playerid, COLOR_RED, "USO: /removeacc [account name] [razon]");
    
    if(DataExist(Account))
    {
        if(!strcmp(pName(playerid), Account, false))
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes eliminar tu propia cuenta.");

        foreach(new i : Player)
        {
            if(strcmp(Account, pName(i), true) == 0)
            {
                SendClientMessage(playerid, COLOR_RED, "[ERROR] Esta Online, no se puede eliminar.");
                return 1;
            }
        }

        new Query[128+50];
        
        format(Query, 100, "DELETE FROM `users` WHERE `username` = '%s'", Account);
        db_query(DB_USERS, Query);
        db_free_result(db_query(DB_USERS, Query));

        format(string, 128, "[ADMIN] %s[ID:%d] ha eliminado la cuenta de %s [Razon: %s]", pName(playerid), playerid, Account, Reason);
        SendClientMessageToAll(COLOR_YELLOW, string);
        SaveLog("cuentas.txt", string);

        format(string, 128, "[INFO] Has eliminado la cuenta de  %s [Razon: %s]", Account, Reason);
        SendClientMessage(playerid, COLOR_YELLOW, string);
    }
    
    else
    {
        SendClientMessage(playerid, COLOR_RED, "[ERROR] La cuenta no existe en la base de datos.");
    }
    return 1;
}

CMD:settemplevel(playerid, params[])
{
    new
        string[128],
        id,
        level
    ;

            	
    LevelCheck(playerid, 8);

    if(sscanf(params, "ui", id, level)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /settemplevel [playerid] [level(0/10)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(level < 0 || level > 10) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El nivel no puede ser menor que 0 ni mayor que 10..");
    
    if(level == User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya tiene ese nivel.");
    
    if(User[id][accountLogged] == 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No estas logueado.");

    if(User[id][accountAdmin] < level)
    {
        format(string, 128, "[INFO] Has sido promovido temporalmente al nivel %d. - Por: %s.", level, pName(playerid));
        SendClientMessage(id, COLOR_YELLOW, string);
        
        format(string, 128, "[INFO] Le has dado TempLevel a %s Nivel: %d.", pName(id), level);
        SendClientMessage(playerid, COLOR_YELLOW, string);
        
        format(string, 128, "[INFO] Volveras a tu nivel anterior (%d) al salir del servidor.", User[id][accountAdmin]);
        SendClientMessage(id, COLOR_GREEN, string);
    }
    
    else if(User[id][accountAdmin] > level)
    {
        format(string, 128, "[INFO] Has sido descendo temporalmente al nivel %d. - Por: %s.", level, pName(playerid));
        SendClientMessage(id, COLOR_YELLOW, string);
        
        format(string, 128, "[INFO] Has descendo el TempLevel de %s - Nivel: %d.", pName(id), level);
        SendClientMessage(playerid, COLOR_YELLOW, string);
        
        format(string, 128, "[INFO] Volveras a tu nivel anterior (%d) al salir del servidor.", User[id][accountAdmin]);
        SendClientMessage(id, COLOR_GREEN, string);
     }

    User[id][accountTemporary] = true;
    User[id][accountAdminEx] = User[id][accountAdmin];
    User[id][accountAdmin] = level;

    format(string, sizeof string, "[ADMIN] %s le dió a %s el nivel: %d", pName(playerid), pName(id), level);
    SaveLog("cuentas.txt", string);
    return 1;
}
//CMD ADM LVL 9
CMD:fakedeath(playerid, params[])
{
            	
    LevelCheck(playerid, 9);
    
    new
        string[128],
        id,
        killerid,
        weapid
    ;

    if(sscanf(params, "uui", killerid, id, weapid)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /fakedeath [killer] [victim] [weapon]");
    
    if(killerid == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "* KillerID not connected.");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "* VictimID not connected.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(User[playerid][accountAdmin] < User[killerid][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(id == playerid && killerid == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "* You can't be KillerID and VictimID at the same time.");
    
    if(!IsValidWeapon(weapid)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] ID del arma no valida..");//CAMBIAR

    SendDeathMessage(killerid, id, weapid);

    format(string, sizeof(string), "Muerte envíada. [ Victima: %s(ID:%d) | Asesino: %s(%d) | ArmaID: %i ]", pName(id), id, pName(killerid), killerid, weapid);
    SendClientMessage(playerid, COLOR_YELLOW, string);

    format(string, sizeof(string), "El administrador %s ha usado el comando /fakedeath en el usuario %s.", pName(playerid), pName(id));
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:setkills(playerid, params[])
{
            	
    LevelCheck(playerid, 9);

    new 
        id, 
        string[128], 
        amount
        ;

    if(sscanf(params, "ud", id, amount))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setkills [playerid] [amount(cannot be below zero)]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    format(string, sizeof(string), "[INFO] Tus Kills han sido seteados de %d a %d - Admin: %s.", User[id][accountKills], amount, pName(playerid));
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[INFO] Le has seteado los Kills de %s, de %d a %d.", pName(id), User[id][accountKills], amount);
    SendClientMessage(playerid, -1, string);

    User[id][accountKills] = amount;
    ActPlayerData(id,"kills");
    return 1;
}

CMD:setdeaths(playerid, params[])
{
            	
    LevelCheck(playerid, 9);

    new 
        id, 
        string[128], 
        amount
        ;

    if(sscanf(params, "ud", id, amount))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setdeaths [playerid] [cantidad]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    format(string, sizeof(string), "[INFO] Tus Muertes han sido seteados de %d a %d - Admin: %s.", User[id][accountDeaths], amount, pName(playerid));
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[INFO] Le has seteado las muertes de %s, de %d a %d.", pName(id), User[id][accountDeaths], amount);
    SendClientMessage(playerid, -1, string);

    User[id][accountDeaths] = amount;
    ActPlayerData(id,"deaths");
    return 1;
}

CMD:getall(playerid, params[])
{
            	
    LevelCheck(playerid, 9);

    new Float:x,
        Float:y,
        Float:z,
        string[130],
        interior = GetPlayerInterior(playerid)
        ;

    GetPlayerPos(playerid, x, y, z);
    
    foreach(new i : Player)
    {
        if(i != playerid)
        {
            PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
            JBC_SetPlayerPos(i, x+(playerid/4)+1, y+(playerid/4), z);
            SetPlayerInterior(i, interior);
            SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
        }
    }

    format(string, sizeof(string), "[ADMIN] %s[ID:%d] ha teletransportado a su ubicacion a todos los jugadores del servidor.", pName(playerid), playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    return 1;
}
CMD:setduelosg(playerid, params[])
{
            	
    LevelCheck(playerid, 9);

    new string[128+40],id,duelosg;

    if(sscanf(params, "ui", id, duelosg)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setduelosg [playerid] [duelos ganados]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(duelosg < 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] SkinID no valido.");

    format(string, 128, "[INFO] Le has seteado a "orange"%s "white"los duelos ganados a "grey"%d", pName(id), duelosg);
    SendClientMessage(playerid, -1, string);

    format(string, 128, "[ADMIN] "orange"%s "white"te seteado tus duelos ganados a "grey"%d", pName(playerid), duelosg);
    SendClientMessage(id, -1, string);
    
    format(string, 128, "[SETSKIN] "orange"%s "white"le seteo a %s los duelos ganados en"grey"%d", pName(playerid), pName(id), duelosg);
    SaveLog("set.txt", string);
    User[id][accountDuelosp] = duelosg;
    return 1;
}

CMD:setduelosp(playerid, params[])
{
            	
    LevelCheck(playerid, 9);

    new string[128+40],id,duelosp;

    if(sscanf(params, "ui", id, duelosp)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setduelosp [playerid] [duelos perdidos]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(duelosp < 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] SkinID no valido.");

    format(string, 128, "[INFO] Le has seteado a "orange"%s "white"los duelos perdidos a "grey"%d", pName(id), duelosp);
    SendClientMessage(playerid, -1, string);

    format(string, 128, "[ADMIN] "orange"%s "white"te seteado tus duelos perdidos a "grey"%d", pName(playerid), duelosp);
    SendClientMessage(id, -1, string);
    
    format(string, 128, "[SETSKIN] "orange"%s "white"le seteo a %s los duelos perdidos en"grey"%d", pName(playerid), pName(id), duelosp);
    SaveLog("set.txt", string);
    User[id][accountDuelosp] = duelosp;
    return 1;
}

CMD:allowgod(playerid, params[])
{
    new 
        string[128], 
        id;

            	
    LevelCheck(playerid, 9);

    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /allowgod [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    switch(godPlayer[id])
    {
        case 0:
        {
            format(string, sizeof(string), "[INFOADMINS] %s le ha dado a %s GOD MODE (/allowgod)", pName(playerid), pName(id));
            SendAdminMessage(COLOR_GREEN, string);
            
            format(string, sizeof(string), "* [ADMIN] %s te ha dado GOD MODE.", pName(playerid));
            SendClientMessage(id, COLOR_GREEN, string);
            
            format(string, sizeof(string), "* [INFO] Le has dado a %s GOD MODE.", pName(id));
            SendClientMessage(playerid, -1, string);
            
            godPlayer[id] = 1;

            format(string, sizeof(string), " El administrador %s, le dio GOD MODE a %s con /allowgod", pName(playerid), pName(id));
            SaveLog("abuso.txt", string);
        }
        case 1:
        {
            format(string, sizeof(string), "[INFOADMINS] %s le ha quitado a %s GOD MODE (/allowgod)", pName(playerid), pName(id));
            SendAdminMessage(COLOR_RED, string);
            
            format(string, sizeof(string), "[ADMIN] %s te ha removido el GOD MODE.", pName(playerid));
            SendClientMessage(id, COLOR_RED, string);
            
            format(string, sizeof(string), "[INFO] Le has removido a %s su GOD MODE.", pName(id));
            SendClientMessage(playerid, -1, string);
            
            JBC_SetPlayerHealth(id, 100.0);
            godPlayer[id] = 0;

            format(string, sizeof(string), " El administrador %s, ha removido el GOD MODE a %s con /allowgod", pName(playerid), pName(id));
            SaveLog("abuso.txt", string);    
        }
    }
    return 1;
}

CMD:setonline(playerid, params[])
{
            	
    LevelCheck(playerid, 9);

    new 
        id, 
        hours, 
        minutes, 
        seconds, 
        string[128]
        ;

    if(sscanf(params, "uddd", id, hours, minutes, seconds))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setonline [playerid] [horas] [minutos] [segundos]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    if(hours < 0)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Las horas no pueden ser menor que 0.");

    if(minutes < 0 || minutes > 59)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Los minutos no pueden ser menor que 0 ni mayor a 59.");

    if(seconds < 0 || seconds > 59)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Los segundos no pueden ser menor que 0 ni mayor a 59.");

    format(string, sizeof(string), "[ADMIN] Tiempo total de juego modificado de %02d:%02d:%02d a %02d:%02d:%02d - Admin: %s.", User[id][accountGame][2], User[id][accountGame][1], User[id][accountGame][0], hours, minutes, seconds, pName(playerid));
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[INFO] Le has seteado a %s el tiempo de juego en: %02d:%02d:%02d.", pName(id), hours, minutes, seconds);
    SendClientMessage(playerid, -1, string);

    format(string, sizeof(string), " El admin %s ha seteado el tiempo de juego a %s en %02d:%02d:%02d.", pName(playerid), pName(id), hours, minutes, seconds);
    SaveLog("set.txt", string);

    User[id][accountGame][2] = hours;
    User[id][accountGame][1] = minutes;
    User[id][accountGame][0] = seconds;

    ActPlayerData(id,"hours");
    ActPlayerData(id,"minutes");
    ActPlayerData(id,"seconds");
    return 1;
}

CMD:explodeall(playerid, params[])
{
            	
    LevelCheck(playerid, 9);

    new
        string[92],
        Float:x,
        Float:y,
        Float:z
        ;

    foreach(new i : Player)
    {
        if(i != playerid)
        {
            GetPlayerPos(i, x, y, z);
            CreateExplosionForPlayer(i, x, y, z, 7, 1.00);
        }
    }

    format(string, sizeof(string), "[ADMIN] %s[ID:%d] ha explotado a todos los jugadores.", pName(playerid), playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    printf(string);
    SaveLog("abuso.txt", string);
    return 1;
}


CMD:slapall(playerid, params[])
{
            	
    LevelCheck(playerid, 9);

    new
        string[92],
        Float:x,
        Float:y,
        Float:z,
        Float:health
        ;

    foreach(new i : Player)
    {
        if(i != playerid)
        {
            GetPlayerPos(i, x, y, z);
            GetPlayerHealth(i, health);
            JBC_SetPlayerHealth(i, health-25);
            JBC_SetPlayerPos(i, x, y, z+5);
            PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
            PlayerPlaySound(i, 1190, 0.0, 0.0, 0.0);
        }
    }

    format(string, sizeof(string), "[ADMIN] %s[ID:%d] le ha dado un Slap a todos los jugadores.", pName(playerid), playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    printf(string);
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:cleardwindow(playerid, params[])
{
            	
    LevelCheck(playerid, 9);

    new string[128];

    format(string, sizeof(string), "[ADMIN] "orange"%s "white"ha limpiado la tabla de muertes.", pName(playerid));
    SendClientMessageToAll(-1, string);
    
    for(new i = 0; i < 20; i++) 
        SendDeathMessage(6000, 5005, 255);
    
    return 1;
}

CMD:fakecmd(playerid, params[])
{
            	
    LevelCheck(playerid, 9);
    
    new
        string[128],
        id,
        cmdtext[40]
        ;

    if(sscanf(params, "us[128]", id, cmdtext)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /fakecmd [playerid] [command]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(strfind(params, "/", false) != -1)
    {
        CallRemoteFunction("OnPlayerCommandText", "is", id, cmdtext);
        format(string, sizeof(string), "[INFO] Enviaste un comando falso a %s. Comando: %s", pName(id), cmdtext);
        SendClientMessage(playerid, COLOR_YELLOW, string);
    }
    
    else 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Debes agregar '/' para continuar.");
    
    return 1;
}
//ADM LVL 10
CMD:paintspray(playerid, params[])
{
            	
    LevelCheck(playerid, 10);
    
    JBC_SetPlayerPos(playerid, -2693.3899, 216.0182, 3.8851);
    SetPlayerFacingAngle(playerid, 82.9903);
    SetCameraBehindPlayer(playerid);
    ResetPlayerPos(playerid);
    return 1;
}

CMD:ps(playerid, params[])
{
    return cmd_paintspray(playerid, params);
}

CMD:oficina(playerid, params[])
 {
            	
    LevelCheck(playerid, 10);
    JBC_SetPlayerPos(playerid, 461.7018, -1500.7772, 31.0455);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}

CMD:conscesionaria(playerid, params[])
{
            	
    LevelCheck(playerid, 10);
    JBC_SetPlayerPos(playerid, -1953.3962, 291.3775, 35.4688);
    SetPlayerFacingAngle(playerid, 267.8954);
    SetCameraBehindPlayer(playerid);
    ResetPlayerPos(playerid);
    return 1;
}

CMD:cs(playerid, params[])
{
    return cmd_conscesionaria(playerid, params);
}

CMD:exportadora(playerid, params[])
{
            	
    LevelCheck(playerid, 10);
    JBC_SetPlayerPos(playerid, -1690.2321, 14.1789, 3.5547);
    SetPlayerFacingAngle(playerid, 228.1882);
    SetCameraBehindPlayer(playerid);
    ResetPlayerPos(playerid);
    return 1;
}

CMD:bloquear(playerid, params[])
{
            	
    LevelCheck(playerid, 10);

    new 
        Pass[20], 
        s[25],
        str[90];

    if(sscanf(params, "s[25]", Pass))
        return SendClientMessage(playerid, COLOR_RED, "Uso: /bloquear [password]");
      
    if(ServerLocked == true)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El servidor ya se encuentra bloqueado.");

    format(s, sizeof(s), "password %s", Pass);
    SendRconCommand(s);
    
    format(str, sizeof(str), "[GP]"white" Servidor bloqueado usaste la contraseña: "red"%s", Pass);
    SendClientMessage(playerid, COLOR_YELLOW, str);
    SaveLog("servidor.txt", str);
    
    ServerLocked = true;
    return 1;
}

CMD:desbloquear(playerid, params[])
{
            	
    LevelCheck(playerid, 10);

    if(ServerLocked == false)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El servidor no se encuentra bloqueado.");

    SendRconCommand("password 0");
    SendClientMessage(playerid, COLOR_RED, "[GP] Servidor desbloqueado. Ahora todos podrán ingresar.");
    ServerLocked = false;

    return 1;
}

CMD:colorhx(playerid, params[])
{
            	
    LevelCheck(playerid, 10);
    
    new 
        color, 
        s[25]
        ;
    
    if(sscanf(params, "h", color)) 
        return SendClientMessage(playerid, COLOR_RED, "Uso: /colorhx [color hexadecimal]");
    
    format(s, sizeof(s), "Color: %x", color);
    SendClientMessage(playerid, -1, s);
    return 1;
}

CMD:setlevel(playerid, params[])
{

            	
    if(!IsPlayerAdmin(playerid)) 
        return 0;

    new
        string[128],
        id,
        level
    ;
    
    if(sscanf(params, "ui", id, level)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setlevel [playerid] [level(0/10)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador no se encuentra| conectado.");
    
    if(level < 0 || level > 10) 
        return SendClientMessage(playerid, COLOR_RED, "[AYUDA] El nivel no puede ser menor que 0 ni mayor que 10.");
    
    if(level == User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador posee ese nivel administrativo.");
    
    if(User[id][accountLogged] == 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador aún no ha ingresado al juego.");

    if(User[id][accountAdmin] < level)
    {
        User[id][accountTemporary] = false;
        User[id][accountAdminEx] = 0;
        User[id][accountAdmin] = level;
        
        format(string, 128, "[STAFF] Has sido promovido al nivel %d por %s.", level, pName(playerid));
        SendClientMessage(id, COLOR_YELLOW, string);
        SendClientMessageToAll(COLOR_YELLOW, "<==================================================================================================>");
        
        GameTextForPlayer(id, "Has sido ascendido ¡Felicitaciones!", 4000, 3);

        format(string, 128, "[STAFF] %s ha ascendido a %s a %s(%d) ¡Felicitaciones!.",pName(playerid),pName(id),GetAdminRank(User[id][accountAdmin]), level);
        SendClientMessageToAll(COLOR_YELLOW, string);
        SendClientMessageToAll(COLOR_YELLOW, "<==================================================================================================>");
        
        format(string, 128, "[STAFF] Ahora %s ha sido ascendido al nivel: %d.", pName(id), level);
        SendClientMessage(playerid, COLOR_YELLOW, string);
        
        for(new i = 0; i < MAX_PLAYERS; i++) 
        {
            PlayerPlaySound(i,1057, 0.0, 0.0, 0.0); 
        }
    }
    
    else if(User[id][accountAdmin] > level)
    {
        User[id][accountTemporary] = false;
        User[id][accountAdminEx] = 0;
        User[id][accountAdmin] = level;
        
        format(string, 128, "[STAFF] Has sido degradado al nivel %d por %s.", level, pName(playerid));
        SendClientMessage(id, COLOR_YELLOW, string);
        
        format(string, 128, "[STAFF] Ahora %s ha sido degradado al nivel %d.", pName(id), level);
        SendClientMessage(playerid, COLOR_YELLOW, string);
        
        format(string, 128, "[STAFF] %s ha degradado a %s al nivel %s(%d).",pName(playerid),pName(id),GetAdminRank(User[id][accountAdmin]), level);
        SendClientMessageToAll(COLOR_YELLOW, string);
    }

    format(string, sizeof string, "[SETLEVEL] %s asignó a %s el nivel [%d]", pName(playerid), pName(id), level);
    SaveLog("cuentas.txt", string);
    ActPlayerData(id,"admin");
    return 1;
}
//===============================================================================================
#if VipSystem == true
CMD:setvip(playerid, params[])
{
            	
    LevelCheck(playerid, 10);
    
    new
        string[135],
        id,
        level
        ;

    if(sscanf(params, "ui", id, level)) 
        return SendClientMessage(playerid, COLOR_RED, "[USO] /setvip [playerid] [level(0/2)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador no se encuentra conectado.");
        
    if(level < 0 || level > 2) 
        return SendClientMessage(playerid, COLOR_RED, "[AYUDA] Sólo puedes quítar VIP, o asignar VIP1, O VIP2.");
        
    if(level == accountVip[id]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador  posee ese nivel vip.");
        
    if(User[id][accountLogged] == 0) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] El jugador aún no ha ingresado al juego.");

    if(accountVip[id] < level)
    {
        accountVip[id] = level;
        
        format(string, sizeof(string), "[VIP´S] %s te asignó membresia %s.",pName(playerid), GetVIPRank(accountVip[id]));
        SendClientMessage(id, COLOR_YELLOW, string);
        SendClientMessageToAll(COLOR_YELLOW, "<==================================================================================================>");
        
        format(string, sizeof(string), "[VIP´S] %s asignó membresia VIP a %s - %s ¡Felicitaciones!",pName(playerid),pName(id),GetVIPRank(accountVip[id]));
        SendClientMessageToAll(COLOR_YELLOW, string);
        SendClientMessageToAll(COLOR_YELLOW, "<==================================================================================================>");
    }
    
    else if(accountVip[id] > level)
    {
        accountVip[id] = level;
        format(string, sizeof(string), "[INFO]%s modificó tu membresia VIP a %s.", pName(playerid), GetVIPRank(accountVip[id]));
        SendClientMessage(id, COLOR_YELLOW, string);
        
        format(string, sizeof(string), "[INFO] %s modificó la membresia VIP de %s a %s.", pName(playerid), pName(id), GetVIPRank(accountVip[id]));
        SendClientMessageToAll(COLOR_YELLOW, string);
    }

    format(string, sizeof string, "[VIP] %s le dió %s a %s", pName(playerid), GetVIPRank(accountVip[id]), pName(id));
    SaveLog("cuentas.txt", string);

    ActPlayerData(id,"vip");
    return 1;
    }
#endif

CMD:kickall(playerid, params[])
{
            	
    if(!IsPlayerAdmin(playerid))
        return 0;

    new string[92];

    foreach(new i : Player)
    {
        if(i != playerid)
        {
            Kick(i);
        }
    }

    format(string, sizeof(string), "[KICKALL] %s[ID:%d] se ha vuelto loco y ha expulsado a todos.", pName(playerid), playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    printf(string);

    SaveLog("kick.txt", string);
    return 1;
}

CMD:gmx(playerid, params[])
{
    new
        string[128],
        time
        ;

            	
    LevelCheck(playerid, 10);

    if(sscanf(params, "I(0)", time)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /gmx [Restart Timer(optional)") &&
            SendClientMessage(playerid, -1, "Note: You can leave the parameter for a fast restart, no timers.");

    if(time < 10 && time !=0) 
        return SendClientMessage(playerid, COLOR_RED, "* Restart Time shouldn't go below ten.");

    if(time >= 10)
    {
        format(string, sizeof(string), "[ADMIN] %s[ID:%d]  has announced a server restart which will end in %d seconds.", pName(playerid), playerid, time);
        SendClientMessageToAll(COLOR_YELLOW, string);

        SetTimer("RestartTimer", 1000*time, false);
    }

    else
    {
        format(string, sizeof(string), "[ADMIN] %s[ID:%d]  has restarted the server.", pName(playerid), playerid);
        SendClientMessageToAll(COLOR_YELLOW, string);
        SendRconCommand("gmx");
    }
    return 1;
}
CMD:jsettings(playerid, params[])
{
            	
	if(!IsPlayerAdmin(playerid))
 	return 0;

    ShowSettings(playerid);
    return 1;
}

CMD:crash(playerid, params[])
{
            	
    LevelCheck(playerid, 10);

    new 
        id, 
        string[128], 
        str[64];

    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "USO: /crash [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin] && id != playerid)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    format(string, sizeof(string), "[INFO] Has crasheado a %s (ID: %d).", pName(id), id);
    SendClientMessage(playerid, -1, string);
    
    format(string, sizeof(string), "", pName(playerid));
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(str, 64, "[ADMIN] %s crasheo al jugador %s", pName(playerid), pName(id));
    SaveLog("abuso.txt", str);

    GameTextForPlayer(id, "Ã¢â‚¬Â¢Ã‚Â¤Ã‚Â¶Ã‚Â§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
    GameTextForPlayer(id, "Ã¢â‚¬Â¢Ã‚Â¤Ã‚Â¶Ã‚Â§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
    GameTextForPlayer(id, "Ã¢â‚¬Â¢Ã‚Â¤Ã‚Â¶Ã‚Â§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
    GameTextForPlayer(id, "Ã¢â‚¬Â¢Ã‚Â¤Ã‚Â¶Ã‚Â§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
    GameTextForPlayer(id, "Ã¢â‚¬Â¢Ã‚Â¤Ã‚Â¶Ã‚Â§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
    GameTextForPlayer(id, "Ã¢â‚¬Â¢Ã‚Â¤Ã‚Â¶Ã‚Â§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
    GameTextForPlayer(id, "Ã¢â‚¬Â¢Ã‚Â¤Ã‚Â¶Ã‚Â§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
    return 1;
}

CMD:akill(playerid, params[])
{
            	
    LevelCheck(playerid, 10);

    new
        string[150],
        reason[128],
        id
        ;

    if(sscanf(params, "uS(No Reason)[128]", id, reason)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /akill [playerid] [reason(Default: None)]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
    
    if(godPlayer[id] == 1)
    {
        godPlayer[id] = 0;
    }

    JBC_SetPlayerHealth(id, 0.0);
    format(string, sizeof(string), 
        "[INFO] %s[ID:%d] has been killed by [ADMIN] %s[ID:%d] [Razon: %s]", pName(id), id, pName(playerid), playerid, reason);
    
    SendClientMessageToAll(COLOR_GREY, string);
    return 1;
}
//RCON ADM CMDS
CMD:givealldinero(playerid, params[])
{
            	
    
    if(!IsPlayerAdmin(playerid)) 
        return 0;

    new 
        string[128], 
        amount
        ;

    if(sscanf(params, "d", amount))
        return SendClientMessage(playerid, COLOR_RED, "USO: /givealldinero [amount]");

    if(amount < 1)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Monto no valido.");
    
    if(amount >50000)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes dar más de $50.000.");

    foreach(new i : Player)
    {
        if(i != playerid)
        {
            User[i][accountChocolate] += amount;
        }
    }

    format(string, sizeof(string), 
        "[ADMIN] %s[ID:%d] le ha dado a todos los jugadores dinero - Cantidad: %d.", pName(playerid), playerid, amount);
    
    SendClientMessageToAll(COLOR_YELLOW, string);
    printf(string);
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:giveallscore(playerid, params[])
{
            	
    
    if(!IsPlayerAdmin(playerid)) 
        return 0;

    new
        id,
        string[130]
        ;

    if(sscanf(params, "i", id)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /giveallscore [score]");
    
    foreach(new i : Player)
    {
        if(i != playerid)
        {
            PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
            SetPlayerScore(i, GetPlayerScore(i) + id);
        }
    }

    format(string, sizeof(string), 
        "[ADMIN] %s[ID:%d] le dado Score a todos los jugadores - Cantidad: \"%d\"", pName(playerid), playerid, id);
    
    SendClientMessageToAll(COLOR_YELLOW, string);
    SaveLog("abuso.txt", string);
    return 1;
}

CMD:setscore(playerid, params[])
{
            	
    if(!IsPlayerAdmin(playerid)) return 0;
    new
        id,
        string[128],
        amount
        ;

    if(sscanf(params, "ui", id, amount)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /setscore [playerid] [score]");
    
    if(id == INVALID_PLAYER_ID) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");
    
    if(amount < 0 || amount > 250000) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Mínimo 0, máximo 250.000 score.");
    
    if(User[playerid][accountAdmin] < User[id][accountAdmin]) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    SetPlayerScore(id, amount);
    format(string, sizeof(string), "[INFO] Le has seteado a %s el Score en: %i.", pName(id), amount);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[ADMIN] %s te ha cambiado tu Score en: %i.", pName(playerid), amount);
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof string, "[SETSCORE] %s seteo el score de %s en: %i", pName(playerid), pName(id), amount);
    ActPlayerData(id,"score");
    SaveLog("set.txt", string);
    return 1;
}

CMD:setdinero(playerid, params[])
{
            	
    
    if(!IsPlayerAdmin(playerid)) 
        return 0;

    new 
        id, 
        string[128], 
        amount
        ;

    if(sscanf(params, "ud", id, amount))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setdinero [playerid] [monto]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(amount < -100000 || amount > 100000000)
       return SendClientMessage(playerid, COLOR_RED, "[ERROR] Mínimo -100.000 y máximo 100'000.000");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");

    format(string, sizeof(string), "[INFO] Tu Dinero ha sido seteados de %d a %d - Admin: %s.", User[id][accountChocolate], amount, pName(playerid));
    SendClientMessage(id, COLOR_YELLOW, string);
    
    format(string, sizeof(string), "[INFO] Le has seteado el dinero de %s, de %d a %d.", pName(id), User[id][accountChocolate], amount);
    SendClientMessage(playerid, -1, string);
    
    format(string, sizeof(string), "[DINERO] %s le ha seteado el dinero a %s en %d.", pName(playerid), pName(id), amount);
    SaveLog("set.txt", string);
    
    User[id][accountChocolate] = amount;
    
    ActPlayerData(id,"chocolate");
    return 1;
}

CMD:setalldinero(playerid, params[])
{
            	
    
    if(!IsPlayerAdmin(playerid)) 
        return 0;

    new 
        string[128], 
        amount
        ;

    if(sscanf(params, "d", amount))
        return SendClientMessage(playerid, COLOR_RED, "USO: /setalldinero [amount]");

    if(amount < 0)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Monto no valido.");

    foreach(new i : Player)
    {
        if(i != playerid)
        {
            User[i][accountChocolate] = amount;
        }
    }

    format(string, sizeof(string), "[ADMIN] %s[ID:%d] le ha seteado a todos los jugadores el dinero en: %d.", pName(playerid), playerid, amount);
    SendClientMessageToAll(COLOR_YELLOW, string);
    
    printf(string);
    SaveLog("set.txt", string);
    return 1;
}

//FALTA INDENTAR A PARTIR DE AQUÍ
CMD:top(playerid, params[])
{
    ShowPlayerDialog(playerid, TOP_DIALOG, DIALOG_STYLE_LIST, 
        "{00D372}TOP Historicos",
        "TOP 10 - Asesinos \n\
        TOP 10 - Noobs\n\
        TOP 10-  Advertencias\n\
        TOP 10 - Horas jugadas\n\
        TOP 10 - Cantidad de Score\n\
        TOP 10 - Cantidad de Dinero\n\
        TOP 10 - Ratio\n\
        TOP 10 - Rachas\n",
        "Seleccionar", "Cancelar");
    
    return 1;
}

CMD:scorelist(playerid)
{
    new array[MAX_PLAYERS][2];
    new count;
    
    for (new i, j = GetPlayerPoolSize(); i <= j; i++)
    {
        if (IsPlayerConnected(i))
        {
            array[count][0] = GetPlayerScore(i);
            array[count][1] = i;
            count++;
        }
    }

    QuickSort_Pair(array, true, 0, count);

    static string[150];

    SendClientMessage(playerid, COLOR_LIGHTBLUE, " ");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "- Top 5 con mas score -");
    
    for (new i, j = ((count > 5) ? (5) : (count)); i < j; i++)
    {
        format(string, sizeof (string), "%i. %s[%i] - %i score", (i + 1), pName(array[i][1]), array[i][1], array[i][0]);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    }
    return 1;
}

CMD:cc(playerid,params[])
{
            	
    
    if(User[playerid][accountChocolate] < 2500) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas $2500 para comprar una capa de pintura.");
    
    if(!IsPlayerInAnyVehicle(playerid)) 
        return SendClientMessage(playerid,COLOR_RED,"[ERROR] Debes estar dentro de un vehículo.!");
    
    new col1;
    new col2;
    new vehicle;
    
    if(sscanf(params, "dd", col1, col2)) 
        return SendClientMessage(playerid,0xFFFFFFFF,"USO: /carcolor(cc) [color 1] [color 2]") && SendClientMessage(playerid, COLOR_RED," Colors: [0]Black [1]White [2]Blue [3]Red [4]Grayish [5]Pink [6]Yellow [7]Blue    [16]Green!");
    
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        vehicle = GetPlayerVehicleID(playerid);
        User[playerid][accountChocolate] -= 2500;
        
        SendClientMessage(playerid, COLOR_ORANGE,"[INFO] Has recibido tu capa de pintura por $2500.");
        ChangeVehicleColor(vehicle, col1, col2);
        
        if(IsPlayerInVehicle(playerid, vehicleOwner[playerid]))
        {
            SaveModVehicle(playerid);
        }
    }
    return 1;
}

//alias:pm("mp");
CMD:pm(playerid, params[])
{
            	
        
    new texto[128];
        
    if(sscanf(params, "us[128]", params[0], params[1])) 
            return SendClientMessage(playerid, COLOR_RED, "USO /pm ID mensaje"),
                        SendClientMessage(params[0], COLOR_RED, "Puedes usar /r para responder rapidamente.");
        
    if(!IsPlayerConnected(params[0])) 
        return SendClientMessage(playerid, COLOR_RED, "¡Jugador no conectado!");
        
    if(params[0] == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "¡No puedes enviartelo a ti mismo!");
        
    format(texto, sizeof(texto), "%s (%d) ha desactivado los mensajes privados.", pName(params[0]), params[0]);
        
    if(pInfo[params[0]][NoPM] == 1) 
        return SendClientMessage(playerid, COLOR_RED, texto);
        
    format(texto, sizeof(texto), "[PM] a %s[%d]: %s", pName(params[0]),params[0], params[1]);
        
    SendClientMessage(playerid, 0xFFF500FF, texto);
        
    format(texto, sizeof(texto), "[PM] de %s[%d]: %s", pName(playerid),playerid, params[1]);
    SendClientMessage(params[0], 0xFFF500FF, texto);
        
    PlayerPlaySound(params[0],  1057, 0.0, 0.0, 10.0);
        
    pInfo[params[0]][LastPM] = playerid;
    return 1;
}

CMD:nopm(playerid, params[])
{        
            	
    #pragma unused params
    if(pInfo[playerid][NoPM] == 0)
    {
        pInfo[playerid][NoPM] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "[PM] Has desactivado los mensajes privados.");
    }
    
    else
    {
        pInfo[playerid][NoPM] = 0;
        SendClientMessage(playerid, COLOR_YELLOW, "[PM] Has activado los mensajes privados.");
    } 
    return 1;
}

//alias:reply("r");
CMD:reply(playerid, params[])
{
            	
    new 
        texto[128], 
        pID = pInfo[playerid][LastPM], 
        msg[25];
        
    if(sscanf(params, "s[25]", msg)) 
        return SendClientMessage(playerid, COLOR_RED, "Uso: /reply [mensaje]");
        
    if(!IsPlayerConnected(pID)) 
        return SendClientMessage(playerid, COLOR_RED, "El jugador no está conectado ahora.");
        
    if(pID == playerid) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes enviartelo a ti mismo.");
        
    format(texto, sizeof(texto), "%s (%d) ha desactivado los mensajes privados.", pName(pID), pID);
        
    if(pInfo[pID][NoPM] == 1) 
        return SendClientMessage(playerid, COLOR_RED, texto);
        
    format(texto, sizeof(texto), "[PM] a %s[%d]: %s", pName(pID),pID, msg);
    SendClientMessage(playerid, 0xFFF500FF, texto);
    PlayerPlaySound(pID, 1085, 0.0, 0.0, 10.0);

    format(texto, sizeof(texto), "[PM] de %s[%d]: %s", pName(playerid),playerid, msg);//params[0]
    SendClientMessage(pID, 0xFFF500FF, texto);
        
    pInfo[pID][LastPM] = playerid;
    return 1;
}



//alias:cc("carcolor");
//alias:acarcolor("acc");

//alias:car("v");

//flags:tiempo(CMD_TIEMPO);
CMD:tiempo(playerid, params[])
{
    if(User[playerid][accountJail] == 1)
    {
    
        new msg[132];
    
        format(msg, sizeof(msg), "[INFO] {FFFFFF}Te quedan {FF4000}%d{FF4000}{FFFFFF} segundo(s) para salir.", User[playerid][accountJailSec]);
        SendClientMessage(playerid, COLOR_ORANGE, msg);
        return 1;
    }
    return 1;
}


CMD:hora(playerid, params[])
{
    new msg[128];
     
    new day,
        month,
        year,hour,
        minute,
        second;
    
    gettime(hour, minute, second);
    getdate(day, month, year);
    
    format(msg, sizeof(msg),
        "{FFE200}Fecha y hora actual de GP: {FFFFFF}%02d/%02d/%02d %02d:%02d:%02d", day,month,year,hour,minute,second);
    
    SendClientMessage(playerid, -1, msg);
    return 1;
}

CMD:id(playerid, params[])
{
    new 
        string[140], 
        giveplayerid;
    
    new 
        day,
        month,
        year,
        hour,
        minute,
        second;
    
    gettime(hour,minute,second);
    getdate(day,month,year);
    
    if(sscanf(params, "r", giveplayerid)) 
        return SendClientMessage(playerid, COLOR_RED, "Uso: /ID Nick/parte del nick");
    
    else if (!IsPlayerConnected(giveplayerid)) 
        SendClientMessage(playerid,COLOR_WHITE,"El jugador no se encuentra conectado.");
    
    else
    {
        new ping = GetPlayerPing(giveplayerid),ping2 = GetPlayerPing(playerid), score = GetPlayerScore(giveplayerid);
        if(score == 0)
        {
            SendClientMessage(playerid, 0xFF0000FF, "El jugador aún no ha ingresado al servidor.");
        }
        else
        {
            if(giveplayerid == playerid)
            {
                format(string, sizeof(string),"{FFE200}Fecha y hora actual de GP: {FFFFFF}%02d/%02d/%02d %02d:%02d:%02d", day,month,year,hour,minute,second);
                SendClientMessage(playerid,-1,string);
                format(string, sizeof(string), "Nick: {9A2EFE}%s {FFFFFF}ID: {DF7401}%d", pName(playerid), playerid);
                SendClientMessage(playerid, -1, string);
                format(string, sizeof(string), "{FFFFFF}Estado de conexión (Ping: %s "white"| P: {A4A4A4}%.2f{FFFFFF})", GetColorPing(ping),NetStats_PacketLossPercent(playerid));
                SendClientMessage(playerid, -1, string);
            }
            else if( giveplayerid != playerid)
            {
                format(string, sizeof(string),"{FFE200}Fecha y hora actual de GP: {FFFFFF}%02d/%02d/%02d %02d:%02d:%02d", day,month,year,hour,minute,second);
                SendClientMessage(playerid,-1,string);
                format(string, sizeof(string), "Nick: {9A2EFE}%s {FFFFFF}ID: {DF7401}%d", pName(giveplayerid), giveplayerid);
                SendClientMessage(playerid, -1, string);
                format(string, sizeof(string), "{FFFFFF}Estado de conexión (Ping: %s "white"| P: {A4A4A4}%.2f | {FFFFFF}Ping propio: %s{FFFFFF})", GetColorPing(ping),NetStats_PacketLossPercent(giveplayerid),GetColorPing(ping2));
                SendClientMessage(playerid, -1, string);
            }
        }
    }
    return 1;
}

/*CMD:respawncars(playerid, params[])
{
            	
    LevelCheck(playerid, 2);
    SendClientMessage(playerid, COLOR_GREEN, "[INFO] Has respawneado todos los vehiculos!");
    GameTextForAll("~n~~n~~n~~n~~n~~n~~r~Vehiculos ~g~Respawneados!", 3000, 3);
    for(new cars=0; cars<MAX_VEHICLES; cars++)
    {
        if(!VehicleOccupied(cars))
        {
                    SetVehicleToRespawn(cars);
        }
    }
    return 1;
}*/

#if VipSystem == true
    CMD:vips(playerid, params[])
    {
        new string[128 * 10], count = 0;

        foreach(new i : Player)
        {
            if(User[i][accountLogged] && accountVip[i] == 1 || accountVip[i] == 1)
            {
                format(string, sizeof(string), "{ffffff}%s %s - "vip1_color"%s\n", string, pName(i), GetVIPRank(accountVip[i]));
                count++;
            }
            if(User[i][accountLogged] && accountVip[i] == 2)
            {
                format(string, sizeof(string), "{ffffff}%s %s - "vip2_color"%s\n", string, pName(i), GetVIPRank(accountVip[i]));
                count++;
            }
        }

        if(count == 0)
            return SendClientMessage(playerid, -1, "[INFO] No hay VIPS Online actualmente.");

        ShowPlayerDialog(playerid, DIALOG_3, DIALOG_STYLE_MSGBOX, "{ffffff}Usuarios VIPs", string, "{ffffff}Cerrar", "");
        return 1;
    }
#endif

CMD:admins(playerid, params[])
{
    new 
        Cuadro[2500],
        Linea[128],
        nn[22],
        aa[3],
        estado[22],
        rank[128],
        jc,
        jd,
        DBResult:resultado,rows
        ;
    
    resultado = db_query(DB_USERS, "SELECT `username`,`admin` FROM `users` WHERE `admin` > 0 ORDER BY `admin` ASC");
    rows = db_num_rows(resultado);
    
    if(rows == 0)
        return SendClientMessage(playerid,0xFF0000FF,"no hay jugadores registrados que sean administradores.");
    
    if(rows)
    {
        for(new i = 0; i < rows; i ++)
        {
            db_get_field_assoc(resultado, "username", nn, 22);
            db_get_field_assoc(resultado, "admin", aa, 3);
            switch(strval(aa))
            {
                case 1: format(rank,sizeof(rank),""COLOR_RANK1"%s",GetAdminRank(strval(aa)));
                case 2: format(rank,sizeof(rank),""COLOR_RANK2"%s",GetAdminRank(strval(aa)));
                case 3: format(rank,sizeof(rank),""COLOR_RANK3"%s",GetAdminRank(strval(aa)));
                case 4: format(rank,sizeof(rank),""COLOR_RANK4"%s",GetAdminRank(strval(aa)));
                case 5: format(rank,sizeof(rank),""COLOR_RANK5"%s",GetAdminRank(strval(aa)));
                case 6: format(rank,sizeof(rank),""COLOR_RANK6"%s",GetAdminRank(strval(aa)));
                case 7: format(rank,sizeof(rank),""COLOR_RANK7"%s",GetAdminRank(strval(aa)));
                case 8: format(rank,sizeof(rank),""COLOR_RANK8"%s",GetAdminRank(strval(aa)));
                case 9: format(rank,sizeof(rank),""COLOR_RANK9"%s",GetAdminRank(strval(aa)));
                case 10: format(rank,sizeof(rank),""COLOR_RANK10"%s",GetAdminRank(strval(aa)));
            }
    
            new id = IDJugador(nn);
        
            if(id != INVALID_PLAYER_ID)
            {
                estado = "{8FE08A}Conectado";
                jc++;
            } 
            
            else 
            {
                estado = "{EBEBEB}Desconectado";
                jd++;
            }
        
            format(Linea, sizeof(Linea), "%s\t%s [%d]\t%s\n",nn,rank,strval(aa), estado);
            strcat(Cuadro, Linea);
            db_next_row(resultado);
        }

        new t[59];
    
        format(t, sizeof(t), "Administración GP | total de admins: %d - conectados: %d",jc+jd,jc);
        ShowPlayerDialog(playerid,0, DIALOG_STYLE_TABLIST, t, Cuadro, "Cerrar", "");
    }
    db_free_result(resultado);
    return 1;
}

CMD:cquestion(playerid, params[])
{
            	

    new
        msg[128];

    if(isnull(params))
        return 
            SendClientMessage(playerid, COLOR_YELLOW, "[GP] Requerimos de la contraseña de tu cuenta. /cquestion [password]");

    WP_Hash(msg, sizeof(msg), params);

    if(!strcmp(msg, User[playerid][accountPassword], false))
    {
        SendClientMessage(playerid, COLOR_GREEN, "[GP] Ingresaste correctamente la contraseña.");
        
        ShowPlayerDialog(playerid, DIALOG_QUESTION2, DIALOG_STYLE_INPUT, 
            ""red"Pregunta de seguridad", ""white"Escribe la nueva pregunta:", "Guardar", "Cancelar");
    }

    else
    {
        format(msg, sizeof(msg), "[ERROR] La contraseña \"%s\" es incorrecta, vuelve a intentarlo.", params);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
    }
    return 1;
}

CMD:voto(playerid, params[])
{
    new 
        option[10], 
        string[128];

    if(sscanf(params, "s[10]", option))
       return SendClientMessage(playerid, COLOR_RED, "Uso: /voto [si - no]");

    if(!sscanf(params, "s[10]", option))
    {
        if(strcmp(option, "si", true) == 0)
        {
            if(!VoteKickHappening)
                return SendClientMessage(playerid, COLOR_RED, "[VOTEKICK] No hay un VoteKick iniciado actualmente.");

            if(HasAlreadyVoted{playerid})
                return SendClientMessage(playerid, COLOR_RED, "[VOTEKICK] Ya has votado!");

            svotes++;
            HasAlreadyVoted{playerid} = true;

            if(svotes < MaxVKICK)
            {
                format(string, sizeof(string), "[VOTEKICK] %s ha votado que SI para expulsar a %s [Razon: %s] (%d/%d)", pName(playerid), pName(VoteKickTarget), VoteKickReason, svotes, MaxVKICK);
                SendClientMessageToAll(COLOR_GREEN, string);
                SaveLog("votekick.txt", string);
            }
        
            else if(svotes >= MaxVKICK)
            {
                format(string, sizeof(string), "[VOTEKICK] Tiempo agotado - %s ha sido expulsado - Razon: %s.", pName(VoteKickTarget), VoteKickReason);
                SendClientMessageToAll(COLOR_ORANGE, string);
                SaveLog("votekick.txt", string);
                
                Kick(VoteKickTarget);
                format(VoteKickReason, sizeof(VoteKickReason), "N/D");
                
                VoteKickHappening = 0;
                avotes = 0;
                svotes = 0;
                VoteKickTarget = INVALID_PLAYER_ID;
                KillTimer(VoteTimer);
                foreach(new i : Player)
                {
                    HasAlreadyVoted{i} = false;
                }
            }
        }
    
        if(strcmp(option, "no", true) == 0)
        {
            if(!VoteKickHappening)
                return SendClientMessage(playerid, COLOR_RED, "[VOTEKICK] No hay una votacion iniciada actualmente...");

            if(HasAlreadyVoted{playerid})
                return SendClientMessage(playerid, COLOR_RED, "[VOTEKICK] Ya has votado");

            if(avotes < MaxVKICK)
            {
                if(!avotes)
                    return 
                        SendClientMessage(playerid, COLOR_RED, "[VOTEKICK] No hay jugadores que este votando que SI en este Votekick.");

                avotes++;
                svotes--;
                HasAlreadyVoted{playerid} = true;
        
                format(string, sizeof(string), "[VOTEKICK] %s ha votado que NO para expulsar a %s [Razon: %s] (%d/%d)", pName(playerid), pName(VoteKickTarget), VoteKickReason, svotes, MaxVKICK);
                SendClientMessageToAll(COLOR_GREEN, string);
                SaveLog("votekick.txt", string);
            }
    
            else if (avotes >= MaxVKICK)
            {
                format(string, sizeof(string), "[VOTEKICK] Tiempo agotado - %s se queda en el servidor.", pName(VoteKickTarget));
                SendClientMessageToAll(COLOR_ORANGE, string);
                SaveLog("votekick.txt", string);

                format(VoteKickReason, sizeof(VoteKickReason), "N/D");
                VoteKickHappening = 0;
                avotes = 0;
                svotes = 0;
                VoteKickTarget = INVALID_PLAYER_ID;
                KillTimer(VoteTimer);
                //////////////////////
                foreach(new i : Player)
                {
                    HasAlreadyVoted{i} = false;
                }
            }
        }
    }
    return 1;
}

CMD:votekick(playerid, params[])
{
    if(GetPlayerScore(playerid) < 2000)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas 2000 de score para usar este comando.");
    new
        count = 0,
        id,
        string[133],
        reason[64]
    ;

    if(User[playerid][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Eres Admin, usa tus poderes como tal.");

    if(GetPlayerPoolSize() < 3)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Debe haber por lo menos mas de 2 jugadores para usar este comando.");

    if(VoteKickHappening)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya hay una votacion en curso, aguarda a que termine.");

    if(sscanf(params, "us[64]", id, reason))
        return SendClientMessage(playerid, COLOR_RED, "USO: /votekick [playerid] [razon]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(id == playerid)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes postularte en el VoteKick tu mismo.");

    foreach(new i : Player) if(User[i][accountAdmin] >= 1)
    {
        count++;
    }

    if(count)
    {
        format(string, sizeof(string), "[VOTEKICK] Hay %d Administradores Online, ya han sido notificados.", count);
        SendClientMessage(playerid, -1, string);
        format(string, sizeof(string), "[INFOADMINS] Por Votekick %s desea expulsar a %s (ID: %d) [Razon: %s]", pName(playerid), pName(id), reason);
        SendAdminMessage(COLOR_YELLOW, string);
        SaveLog("votekick.txt", string);
    }
    else
    {
        format(string, sizeof(string), "[VOTEKICK] %s ha iniciado una votacion contra %s [Razon: %s]", pName(playerid), pName(id), reason);
        SendClientMessageToAll(COLOR_GREY, string);
        SaveLog("votekick.txt", string);
        format(string, sizeof(string), "[VOTEKICK] Usa /Yes o /No para votar | Limite de votos: %d | Resultados en: %d segundos.", MaxVKICK);
        SendClientMessageToAll(COLOR_YELLOW, string);
        format(VoteKickReason, sizeof(VoteKickReason), reason);
        VoteKickTarget = id;
        VoteKickHappening = 1;
        VoteTimer = SetTimer("EndVoteKick", KickTime*1000, false);
    }
    return 1;
}

CMD:report(playerid, params[])
{
    // Report has been re-worked on (01/27/17)

    new id, reason[20];

    if(User[playerid][accountAdmin] > 0)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Eres administrador, usa tus poderes como tal.");

    for(new c; c < MAX_REPORTS; c++)
    {
        if(rInfo[c][reportTaken])
        {
            if(rInfo[c][reporterID] == playerid)
            {
                if(rInfo[c][reportAccepted] == INVALID_PLAYER_ID)
                {
                    format(reason, sizeof(reason), "[INFO] Ya has reportado antes a %s [%s] - RID: %d - No ha sido recepcionado.", pName(rInfo[c][reportedID]), rInfo[c][reportReason], c);
                    SendClientMessage(playerid, COLOR_YELLOW, reason);
                    SendClientMessage(playerid, -1, "[INFO] Usa /CloseReport para cancelar el reporte enviado si lo deseas.");
                }
                else
                {
                    format(reason, sizeof(reason), "[INFO] Ya has reportado antes a %s [%s] - RID: %d - Recepcionado por: %s.", pName(rInfo[c][reportedID]), rInfo[c][reportReason], c, pName(rInfo[c][reportAccepted]));
                    SendClientMessage(playerid, COLOR_YELLOW, reason);
                    SendClientMessage(playerid, -1, "[INFO] Preguntale al Admin que lo ha recepcionado si deseas cerrarlo. Usa el Report Chat.");
                }
                return 1;
            }
        }
    }

    if(sscanf(params, "us[128]", id, reason))
        return SendClientMessage(playerid, COLOR_RED, "USO: /report [playerid] [razon]");

    if(strlen(reason) < 4 || strlen(reason) > 64)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Escribe la razon entre 4 y 64 caracteres.");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No esta conectado.");

    if(id == playerid)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes reportarte a ti mismo.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] ¡Es administrador!");

    InsertReport(playerid, id, reason);
    return 1;
}

//alias:report("reportar");

CMD:closereport(playerid, params[])
{
    new string[128];

    for(new c; c < MAX_REPORTS; c++)
    {
        if(rInfo[c][reportTaken])
        {
            if(rInfo[c][reporterID] == playerid)
            {
                if(rInfo[c][reportAccepted] != INVALID_PLAYER_ID)
                    return SendClientMessage(playerid, COLOR_RED, "[ERROR] Tu reporte ha sido recepcionado, ya no puedes cerrarlo.");

                format(string, sizeof(string), "[REPORTE] %s ha decidido cancelar su reporte contra %s [RID: %d].", pName(playerid), pName(rInfo[c][reportedID]), c);
                SendAdminMessage(COLOR_GREEN, string);

                ResetReport(c);
                return 1;
            }
        }
    }
    SendClientMessage(playerid, -1, "[ERROR] No esta reportando a nadie.");
    return 1;
}

CMD:rchat(playerid, params[])
{
    new string[500];

    if(isnull(params))
        return SendClientMessage(playerid, COLOR_RED, "USO: /rchat [mensaje]");

    if(User[playerid][accountAdmin] >= 1)
    {
        for(new i; i < MAX_REPORTS; i++)
        {
            if(rInfo[i][reportTaken] && rInfo[i][reporterID] == playerid && rInfo[i][reportAccepted] != INVALID_PLAYER_ID)
            {
                format(string, sizeof(string), "[R-CHAT] de %s: %s", pName(rInfo[i][reportAccepted]), params);
                SendClientMessage(playerid, COLOR_YELLOW, string);
                format(string, sizeof(string), "[R-CHAT] con %s: %s", pName(playerid), params);
                SendClientMessage(rInfo[i][reportAccepted], COLOR_YELLOW, string);
                return 1;
            }
            
            if(rInfo[i][reportTaken] && rInfo[i][reportAccepted] == playerid)
            {
                format(string, sizeof(string), "[R-CHAT] de %s: %s", pName(rInfo[i][reporterID]), params);
                SendClientMessage(playerid, COLOR_YELLOW, string);
                format(string, sizeof(string), "[R-CHAT] con %s: %s", pName(playerid), params);
                SendClientMessage(rInfo[i][reporterID], COLOR_YELLOW, string);
                return 1;
            }
        }
        SendClientMessage(playerid, -1, "[ERROR] No ha recepcionado ningun reporte.");
    }
    else
    {
        for(new i; i < MAX_REPORTS; i++)
        {
            if(rInfo[i][reportTaken] && rInfo[i][reporterID] == playerid && rInfo[i][reportAccepted] != INVALID_PLAYER_ID)
            {
                format(string, sizeof(string), "[R-CHAT] de %s: %s", pName(rInfo[i][reportAccepted]), params);
                SendClientMessage(playerid, -1, string);
                format(string, sizeof(string), "[R-CHAT] de %s: %s", pName(playerid), params);
                SendClientMessage(rInfo[i][reportAccepted], -1, string);
                return 1;
            }
        }
        SendClientMessage(playerid, -1, "[ERROR] No has reportado a nadie o un Admin ya lo ha recepcionado.");
    }
    return 1;
}

CMD:register(playerid, params[])
{
    if(User[playerid][accountLogged] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya estas logueado y registrado.");

    if(!DataExist(pName(playerid)))
    {
        new
            string[128],
            password[24],
            hashpass[129],
            oldname[24]
        ;

        if(sscanf(params, "s[24]", password)) 
            return SendClientMessage(playerid, COLOR_RED, "USO: /register [password]");
        
        if(!IsValidPassword(password)) 
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] Simbolos no validos.");
        
        if(strlen(password) < 4 || strlen(password) > 20) 
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] Cantidad de caracteres debe ser mayor a 4 y menor que 20.");

        GetPVarString(playerid, "old_name", oldname, sizeof(oldname));
        JBC_SetPlayerName(playerid, oldname);
        
        if(!isnull(oldname))
        {
            format(string, sizeof(string), "[ERROR] Su nombre ha sido revertido a %s desde tu registro.", pName(playerid));
            SendClientMessage(playerid, -1, string);
        }

        WP_Hash(hashpass, 129, password);
        RegisterPlayer(playerid, hashpass);
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya tienes una cuenta registrada, usa /Login.");
    }
    return 1;
}

CMD:login(playerid, params[])
{
    if(User[playerid][accountLogged] == 1) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya te encuentras logueado.");

    if(DataExist(pName(playerid)))
    {
        new
            hashp[129],
            string[900],
            password[24]
            ;

        if(sscanf(params, "s[24]", password)) 
            return SendClientMessage(playerid, COLOR_RED, "USO: /login [password]");

        if(strcmp(password, "forget", true) == 0)
        {
            if(strcmp(User[playerid][accountQuestion], "none", true) == 0)
                return SendClientMessage(playerid, COLOR_RED, "[INFO] No le has puesto una pregunta de seguridad a tu cuenta.");

            format(string, sizeof(string), ""grey"Si has olvidado tu password, utiliza la pregunta de seguridad para recuperarla.\n\n%s\n\nPregunta?\nPresiona Salir si estas intentando salir.", User[playerid][accountQuestion]);
            ShowPlayerDialog(playerid, DIALOG_FORGET, DIALOG_STYLE_INPUT, ""lightblue"Recuperacion de seguridad", string, "Pregunta", "Salir");
            return 1;
        }

        WP_Hash(hashp, 129, password);
        if(!strcmp(hashp, User[playerid][accountPassword], false))
        {
            LoginPlayer(playerid);
            playerLogued[playerid] = true;
        }

        else
        {
            User[playerid][WarnLog]++;

            if(User[playerid][WarnLog] >= ServerInfo[LoginWarn])
            {
                ShowPlayerDialog(playerid, DIALOG_4, DIALOG_STYLE_MSGBOX, 
                    ""lightblue"Kicked", ""grey"[INFO] Has sido expulsado del servidor por password incorrecta!\nIntentalo de nuevo, (Usa /Q y vuelve a entrar)", "Cerrar", "");
                
                Kick(playerid);
                return 1;
            }

            format(string, sizeof(string), "[ERROR] Password incorrecto. [%d/%d intentos]", User[playerid][WarnLog], ServerInfo[LoginWarn]);
            SendClientMessage(playerid, COLOR_RED, string);

            SendClientMessage(playerid, -1, "[INFO] Intentalo de nuevo, /login [password].");
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "[INFO] No tienes una cuenta registrado, usa /Register.");
    }
    return 1;
}

CMD:cpass(playerid, params[])
{
            	

    new 
        OldPass[24],
        NewPass[24], 
        string[128]
        ;
    if(sscanf(params, "s[24]s[24]", OldPass, NewPass)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /cpass [old pass] [new pass]");
    if(strlen(NewPass) < 4 || strlen(NewPass) > 20)
        return SendClientMessage(playerid, COLOR_RED, "[INFO] Tu nueva password no debe ser menor que 4 ni mayor que 20 caracteres.");

    new 
        Query[300], 
        DBResult:Result, 
        Buf[129];
    
    WP_Hash(Buf, 129, OldPass);
    format(Query, 300, "SELECT `userid` FROM `users` WHERE `username` = '%s' AND `password` = '%s'", DB_Escape(User[playerid][accountName]), Buf);
    Result = db_query(DB_USERS, Query);

    format(string, sizeof string, "[PASS] %s ha cambiado su password.", pName(playerid));
    SaveLog("cuentas.txt", string);

    if(db_num_rows(Result))
    {
        WP_Hash(Buf, 129, NewPass);
        format(User[playerid][accountPassword], 129, Buf);
        format(Query, 300, "UPDATE `users` SET `password` = '%s' WHERE `username` = '%s'", DB_Escape(Buf), DB_Escape(User[playerid][accountName]));
        db_query(DB_USERS, Query);

        format(string, 128, "[INFO] Tu password ha sido cambiada a '"orange"%s"white"'", NewPass);
        SendClientMessage(playerid, -1, string);
    }
    
    else 
        SendClientMessage(playerid, COLOR_RED, "[ERROR] Password antigua no coincide con la actual.");
    
    db_free_result(Result);
    return 1;
}

CMD:nombre(playerid, params[])
{
            	
    new 
        string[85],
        result = 0,
        newname[22];
    
    SendClientMessage(playerid,0x2DFF00FF,"Recuerda que tu nuevo nick no debe exceder el {FFFF00}LIMITE de (20) palabras!, NO LO OLVIDES! ");
    
    if(sscanf(params, "s[22]", newname)) 
        return SendClientMessage(playerid, COLOR_RED, "USO: /nombre [nuevo nombre]");
    
    if(User[playerid][accountChocolate] < 1000000) 
        return SendClientMessage(playerid,0xFF0000FF,"[ERROR] Necesitas $1.000.000 para poder cambiar el nick.");
    
    if(GetPlayerScore(playerid) < 500) 
        return SendClientMessage(playerid,0xFF0000FF,"[ERROR] Necesitas 500 score para poder cambiar el nick.");
    
    if(!CheckValidDigit(newname)) 
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] El nombre contiene dígitos inválidos.");

    if(strlen(newname) < 3 || strlen(newname) > MAX_PLAYER_NAME) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Cantidad de caracteres no validos.");
    
    if((result = CheckAccount(newname)) != 0)
    {
        format(string, sizeof(string), "[ERROR] Ese Nick ya esta en uso (#UserID %d)", result);
        SendClientMessage(playerid, COLOR_RED, string);
        return 1;
    }
    
    /*if(User[playerid][accountClan] != 0 && User[playerid][accountRango] == 4)
    {
    
        new q[88];
    
        for(new c=0;c<MAX_CLANES;c++)
        {
            if(Clans[c][CLAN_ID] == User[playerid][accountClan])
            {
                format(Clans[c][CLAN_LIDER], 22, newname);
                format(q, sizeof(q), "UPDATE `Clanes` SET `Lider`='%s' WHERE `ClanID`='%d' COLLATE NOCASE", DB_Escape(newname),DB_Escape(User[playerid][accountClan]));
                db_free_result(db_query(DB_CLANS, q));
            }
        }
    }*/
    format(string, sizeof string, "* Nombre: %s ha cambiado su nombre a %s.",pName(playerid),newname);
    SendClientMessageToAll(0x00FF00FF, string);
    SendClientMessage(playerid,0xFFFF00FF,"* Nombre: El cambio de nombre te costo $1000000 y 500 score.");
    
    SaveLog("cuentas.txt", string);
    
    User[playerid][accountChocolate]-=1000000;
    
    ActPlayerData(playerid,"chocolate");
    ActPlayerData(playerid,"score");
    
    SetPlayerScore(playerid, GetPlayerScore(playerid)-500);
    JBC_SetPlayerName(playerid, newname);
    
    format(string, sizeof(string), "UPDATE `users` SET `username` = '%s' WHERE `userid` = %d", DB_Escape(newname), User[playerid][accountID]);
    db_query(DB_USERS, string);
    return 1;
}

CMD:stats(playerid, params[])
{
            	

    if(User[playerid][accountAdmin] == 0)
        return ShowStatistics(playerid, playerid);

    if(User[playerid][accountAdmin] >1)
    {
    new id;
    if(sscanf(params, "u", id))
        return SendClientMessage(playerid, COLOR_RED, "Uso: /stats [playerid]");

    if(id == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No está| conectado.");

    if(User[playerid][accountAdmin] < User[id][accountAdmin])
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes usar este comando en un superior.");
        
    ShowStatistics(playerid, id);
        
    }
    return 1;
}

CMD:aceptarduelo(playerid, params[])
{
    new State=GetPlayerState(playerid);
    if(State == PLAYER_STATE_DRIVER) 
        return SendClientMessage(playerid, 0xFF0000FF, "No puedes usar este comando estando en un vehículo!");

    if(sscanf(params, "i", params[0])) 
        return SendClientMessage(playerid, 0x00FF00FF, "Usá /aceptarduelo (ID del desafiante)");

    if(playerid == params[0]) 
        return SendClientMessage(playerid,0xFF0000FF, "No te puedes aceptar un duelo a ti mismo.");

    if(!IsPlayerConnected(params[0])) 
        return SendClientMessage(playerid, 0xFF0000FF, "El jugador no está conectado.");

    if(Duel[params[0]][d_enduelo] == true) 
        return SendClientMessage(playerid, 0xFF0000FF, "El jugador está en un duelo.");

    if(playerid!=Duel[params[0]][d_desafiado])
        return SendClientMessage(playerid,0xFF0000FF, "ése jugador no te invito a un duelo o lo cancelo.");

    if(Duel[params[0]][d_apuesta] > User[params[0]][accountChocolate]) 
        return SendClientMessage(playerid,0xFF0000FF, "No puedes aceptar el duelo, porque no te alcanza para la apuesta.");

    ShowPlayerDialog(params[0],0, DIALOG_STYLE_MSGBOX, " ", "El duelo fue aceptado, éste comenzará en breve.", "Aceptar", "");
    ShowPlayerDialog(playerid,0, DIALOG_STYLE_MSGBOX, " ", "Aceptaste el duelo, éste comenzará en breve.", "Aceptar", "");

    new a[16];
    
    switch(Duel[params[0]][d_armas])
    {
        case 1: a = "Rapidas";
        case 2: a = "Lentas";
        case 3: a = "Lentas 2";
        case 4: a = "Desert Eagle";
        case 5: a = "9mm Silenciada";
        case 6: a = "9mm";
        case 7: a = "Shotgun";
        case 8: a = "Recortada";
        case 9: a = "Spas";
        case 10: a = "Tec9";
        case 11: a = "M4";
        case 12: a = "Sniper";
        case 13: a = "Rifle";
    }
    
    managerDuel++;
    Duel[playerid][d_id] = managerDuel;
    Duel[params[0]][d_id] = managerDuel;
    Duel[playerid][d_arena] = Duel[params[0]][d_arena];
    Duel[playerid][d_apuesta] = Duel[params[0]][d_apuesta];
    Duel[playerid][d_armas] = Duel[params[0]][d_armas];
    Duel[playerid][d_enduelo] = true;
    Duel[params[0]][d_enduelo] = true;
    Duel[params[0]][d_desafiado] = -1;
    Duel[playerid][d_desafiado] = -1;
    
    new msg[64],
        secondmsg[64];
    
    format(msg, sizeof(msg), "Duelo: {00FFFF}%s(%d) vs. %s(%d)",pName(params[0]), params[0], pName(playerid), playerid);
    format(secondmsg, sizeof(secondmsg), "Arena: %d - Armas: %s - Apuesta: $%s",Duel[params[0]][d_arena], a, SetFormatNumber(Duel[playerid][d_apuesta]));

    SendClientMessageToAll(0x00D4E6FF, "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
    SendClientMessageToAll(0x00D4E6FF, msg);
    SendClientMessageToAll(0xFFFFFFFF, secondmsg);
    SendClientMessageToAll(0x00D4E6FF, "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
    
    SendDuelToPlayer(playerid);
    SendDuelToOpponent(params[0]);
    return 1;
}

CMD:cancelarduelo(playerid, params[])
{
    #pragma unused params
    if(Duel[playerid][d_desafiado] == -1) 
        return SendClientMessage(playerid, 0xFF0000FF, "No has invitado a nadie a un duelo.");
    
    SendClientMessage(playerid, 0xFFFFFFFF, "Cancelaste el duelo, ahora puedes usar /duelo de nuevo.");
    Duel[playerid][d_desafiado] = -1;
    return 1;
}

CMD:dejarduelo(playerid, params[])
{
    #pragma unused params
    if(Duel[playerid][d_enduelo] == false) 
        return SendClientMessage(playerid, 0xFF0000FF, "No estás en un duelo.");
    
    if(Duel[playerid][d_id] == -1)
    {
        TogglePlayerSpectating(playerid, false);
        Duel[playerid][d_enduelo] = false;
        SpawnPlayer(playerid);
        return 1;
    }
    
    EndPlayerDuel(playerid);
    return 1;
}

CMD:duelo(playerid, params[])
{
    #pragma unused params
    if(Duel[playerid][d_desafiado] != -1) 
        return SendClientMessage(playerid, 0xFF0000FF, "Ya has invitado a alguien a un duelo, usá /cancelarduelo para crear otro.");
    
    new 
        d[71],
        r[71],
        status[24]
        ;
    
    switch(Duel[playerid][d_invitaciones])
    {
        case 0: status = "{FF0000}[desactivadas]";
        case 1: status = "{00FF00}[activadas]";
    }
    
    format(r, sizeof(r), "Desafiar a un jugador\nVer duelo\nInvitaciones %s",status);
    strcat(d,r);
    ShowPlayerDialog(playerid, DUELO_DIALOG, DIALOG_STYLE_LIST, "Menu de duelos", d, "Seleccionar", "Cancelar");
    return 1;
}

CMD:abrir(playerid, params[])
{
    if(personalVehicles[playerid][v_id] == -1) 
        return SendClientMessage(playerid, 0xFF0000FF, "ERROR: No tienes un vehículo.");
    
    new 
        Float:x, 
        Float:y, 
        Float:z
        ;
    
    GetVehiclePos(vehicleOwner[playerid], x, y, z);
    
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z)) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No estás cerca de tu vehículo.");
           
    if(VehicleClosed[playerid] == false)
    {
        VehicleClosed[playerid] = true;
    }

    SendClientMessage(playerid, 0x00FF00FF, "[INFO] {FFFFFF}Abriste tu vehículo.");
    CarDoor(playerid, 0);
    return 1;
}

CMD:cerrar(playerid, params[])
{
    if(personalVehicles[playerid][v_id] == -1) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No tienes un vehículo.");
	
    new 
        Float:x, 
        Float:y, 
        Float:z;
    
    GetVehiclePos(vehicleOwner[playerid], x, y, z);
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No estás cerca de tu vehículo.");

    if(VehicleClosed[playerid] == true)
    {
        VehicleClosed[playerid] = false;
    }

    SendClientMessage(playerid, 0x00FF00FF, "[INFO] {FFFFFF}Cerraste tu vehículo.");
    CarDoor(playerid, 1);
    return 1;
}

CMD:buscar(playerid, params[])
{
    if(personalVehicles[playerid][v_id] == -1) 
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] No tienes un vehículo.");
    
    new 
        Float:x, 
        Float:y, 
        Float:z
        ;
    
    GetVehiclePos(vehicleOwner[playerid], x, y, z);
    SetPlayerCheckpoint(playerid, x, y, z, 3.0);
    
    SendClientMessage(playerid, 0x00FF00FF, "[INFO]"white" Se ha marcado un punto "red"rojo"white" en el radar con la ubicación de tu vehículo.");
    foundVehicle[playerid] = false;
    return 1;
}

//alias:traervehiculo("traer");
CMD:traervehiculo(playerid, params[])
{
    if(User[playerid][accountJail] == 0)
    {
        if(personalVehicles[playerid][v_id] == -1) 
            return SendClientMessage(playerid, 0xFF0000FF, "[ERROR] No tienes un vehículo.");
        
        if(IsPlayerInVehicle(playerid, vehicleOwner[playerid])) 
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya estás en tu vehículo.");
        
        if(IsPlayerInAnyVehicle(playerid)) 
            return SendClientMessage(playerid, 0xFF0000FF, "[ERROR] No puedes usar este comando estando dentro de un vehiculo.");
        
        new 
            Float:x, 
            Float:y, 
            Float:z, 
            Float:a;
    
        GetPlayerPos(playerid,x,y,z);
        GetPlayerFacingAngle(playerid,a);
        
        JBC_SetVehiclePos(vehicleOwner[playerid], x+2, y+2, z);
        SetVehicleZAngle(vehicleOwner[playerid], a);
        LinkVehicleToInterior(vehicleOwner[playerid],0);
        SetVehicleVirtualWorld(vehicleOwner[playerid],0);
        
        User[playerid][accountChocolate] -= 350;
        
        SendClientMessage(playerid, 0xFF0000FF, "[GP] {FFFFFF}Se te cobró {04B404}$350{04B404} {FFFFFF}por traer tu vehículo.");
    }
    return 1;
}

CMD:traer(playerid, params[])
{
    return cmd_traervehiculo(playerid, params);
}

CMD:estacionar(playerid, params[])
{
    if(personalVehicles[playerid][v_id] == -1) 
        return SendClientMessage(playerid, 0xFF0000FF, "ERROR: No tienes un vehículo.");

    if(!IsPlayerInAnyVehicle(playerid)) return 
        SendClientMessage(playerid, 0xFF0000FF, "ERROR: No estás dentro de tu vehículo.");

    if(GetPlayerVehicleID(playerid) != vehicleOwner[playerid]) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR] este no es tu vehículo.");

    SendClientMessage(playerid, 0x00FF00FF, "[INFO]{FFFFFF} Estacionaste tu vehículo.");
    ParkCar(playerid);
    return 1;
}

/*CMD:comprarclan(playerid, params[])
{
            	
    if(IsPlayerInRangeOfPoint(playerid, 5.0, -2161.6348, 640.9294, 1057.5861) && GetPlayerInterior(playerid) == 1)
    {

        new 
            clanid, 
            tag[7]
            ;
        
        if(User[playerid][accountClan] != 0)
        	return SendClientMessage(playerid, COLOR_RED, "[ERROR] No puedes comprar un clan si ya posees uno.");

        if(User[playerid][accountGame][2] < 144)
        	return SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas 6 días (o 144 horas) dentro del juego para poder adquirir un clan");

        if(User[playerid][accountChocolate] < 3000000)
        	return SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas $3,000,000 para comprar un clan.");

        if(sscanf(params, "ds[7]", clanid, tag))
        	return SendClientMessage(playerid, COLOR_RED, "Uso: /comprarclan [clanid] [tag]");

        if(clanid < 1 || clanid > 200)
        	return SendClientMessage(playerid, COLOR_RED, "[ERROR] El ID del clan debe ser entre 1 y 200, mira la lista de /clanes para ver los ID disnponibles.");
        
        if(strlen(tag) < 1 || strlen(tag) > 3)
            return SendClientMessage(playerid, COLOR_RED, "[ERROR] El tag debe contener mínimo 1 caracter y máximo 3.");

        for(new c=0;c<MAX_CLANES;c++)
            if(Clans[c][CLAN_ID] == clanid)
            	return SendClientMessage(playerid, COLOR_RED, "[ERROR] El ID que escogiste ya lo tiene otro clan, vuelve a intentar con otro ID.");

        new query[63], DBResult:Resultado;

        format(query, sizeof(query), "SELECT * FROM `Clanes` WHERE `Tag` = '%s' COLLATE NOCASE", DB_Escape(tag));
        Resultado = db_query(DB_CLANS, query);

        if(db_num_rows(Resultado))
        	return SendClientMessage(playerid, COLOR_RED, "[ERROR] Ya existe un clan con el tag que escogiste, vuelve a intentar con otro tag.");

        if (strlen(tag) < 1 || strlen(tag) > 3)
       		return SendClientMessage(playerid, COLOR_RED, "[ERROR] El tag solo puede contener mínimo 1 y máximo 6 digitos.");
        
        if(!CheckValidTag(tag))
        	return SendClientMessage(playerid, COLOR_RED, "ERROR El tag contiene dígitos invalidos.");

        countClans ++;
        
        new 
            fecha[12], 
            year,
            month,
            day;  
        
        getdate(year, month, day);
        
        format(fecha, sizeof(fecha), "%i/%i/%i", day,month,year);
        new c[100];
        format(c, sizeof(c), "[Clanes]"white" El clan "red"[%s]"white" ahora es oficial. Líder "red"%s.", tag, pName(playerid));

        User[playerid][accountChocolate] -=3000000;
        SendClientMessageToAll(COLOR_YELLOW, c);
        
        new b[182];
        format(b, sizeof(b),"INSERT INTO Clanes (ClanID,Tag,Slogan,Color,Miembros,Asesinatos,Muertes,Lider,Fecha) VALUES ('%d','%s','Sin slogan','1','1','0','0','%s','%s')",clanid, tag, pName(playerid),fecha);
        db_free_result(db_query(DB_CLANS, b));
        
        Clans[playerid][CLAN_ID] = clanid;
        Clans[playerid][CLAN_COLOR] = 1;
        Clans[playerid][CLAN_MIEMBROS] = 1;
        Clans[playerid][CLAN_ASESINATOS] = 0;
        Clans[playerid][CLAN_MUERTES] = 0;
        
        format(Clans[playerid][CLAN_TAG], 7, tag);
        format(Clans[playerid][CLAN_FECHA], 12, fecha);
        format(Clans[playerid][CLAN_SLOGAN], 11, "Sin slogan");
        format(Clans[playerid][CLAN_LIDER], 22, pName(playerid));
        format(playerClan[playerid], 7, tag);
        format(clan_slogan[playerid], 11, "Sin slogan");
        
        clan_color[playerid] = 1;
        User[playerid][accountClan] = clanid;
        User[playerid][accountRango] = 4;
        
        ActPlayerData(playerid,"clan");
        ActPlayerData(playerid,"rango");
    }
    return 1;
}

CMD:clan(playerid, params[])
{
    if(sscanf(params, "s[7]", params[0])) 
        return SendClientMessage(playerid, 0xFFFF00FF, "* Cmd: /clan [tag del clan]");
    
    new 
        Query[63], 
        DBResult: Resultado;
    
    format(Query, sizeof(Query), "SELECT * FROM `Clanes` WHERE `Tag` = '%s' COLLATE NOCASE", DB_Escape(params[0]));
    
    Resultado = db_query(DB_CLANS, Query);
    
    new 
        ctag[7],
        cslogan[41],
        cc,
        cmiembros,
        ckill,
        cdeath,
        cfecha[20], 
        clider[22], 
        cuadro[273], 
        c1[34], 
        c2[68], 
        c3[34], 
        c4[39], 
        c5[36], 
        c6[35], 
        c7[47];
    
    if(db_num_rows(Resultado))
    {
        db_get_field_assoc(Resultado, "Tag", ctag, 7);
        db_get_field_assoc(Resultado, "Slogan", cslogan, 41);
        
        cc = db_get_field_assoc_int(Resultado, "Color");
        cmiembros = db_get_field_assoc_int(Resultado, "Miembros");
        ckill = db_get_field_assoc_int(Resultado, "Asesinatos");
        cdeath = db_get_field_assoc_int(Resultado, "Muertes");
        
        db_get_field_assoc(Resultado, "Fecha", cfecha, 20);
        db_get_field_assoc(Resultado, "Lider", clider, 22);
        
        format(c1, sizeof(c1), "{E6E6EB}Clan: {%s}[%s]\n",ccolor[cc],ctag);
        format(c2, sizeof(c2), "{E6E6EB}Slogan: {%s}%s\n",ccolor[cc],cslogan);
        format(c3, sizeof(c3), "{E6E6EB}Miembros: {FFFFFF}%d\n",cmiembros);
        format(c4, sizeof(c4), "{E6E6EB}Asesinatos: {FFFFFF}%d\n",ckill);
        format(c5, sizeof(c5), "{E6E6EB}Muertes: {FFFFFF}%d\n",cdeath);
        format(c6, sizeof(c6), "{E6E6EB}Fecha: {FFFFFF}%s\n",cfecha);
        format(c7, sizeof(c7), "{E6E6EB}Líder: {FFFFFF}%s\n",clider);
        strcat(cuadro,c1);
        strcat(cuadro,c2);
        strcat(cuadro,c3);
        strcat(cuadro,c4);
        strcat(cuadro,c5);
        strcat(cuadro,c6);
        strcat(cuadro,c7);
        ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX," ", cuadro, "Cerrar", "");
    }
    
    else
    {
        SendClientMessage(playerid, 0xFF0000FF, "* ERROR: El tag ingresado no es perteneciente a ningun clan.");
        db_free_result(Resultado);
    }
    return 1;
}

CMD:cmiembros(playerid, params[])
{
    if(User[playerid][accountClan] == 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan!");
    
    new 
        query[84],
        Cuadro[3700],
        Linea[59],
        Nick[22],
        Rango[2],
        estado[22],
        r[11],
        DBResult:resultado,rows;
    
    format(query,sizeof(query),
        "SELECT `username`,`rango` FROM `users` WHERE `clan` = '%d' ORDER BY `rango` DESC",User[playerid][accountClan]);
    
    resultado = db_query(DB_USERS, query);
    rows = db_num_rows(resultado);
    
    if(rows == 0) 
        return SendClientMessage(playerid, 0xFFFF00FF, "[ERROR]: No hay jugadores registrados en este clan");
    
    if(rows)
    {
        strcat(Cuadro, "{000000}.\t{000000}.\t{000000}.\n");
        for(new i = 0; i < rows; i ++)
        {
            db_get_field_assoc(resultado, "username", Nick, 22);
            db_get_field_assoc(resultado, "rango", Rango, 2);
            new id = IDJugador(Nick);
            
            if(id != INVALID_PLAYER_ID) 
            {
                estado = "{00ff00}Conectado";
            }       

            else 
            {
                estado = "{FF0000}Desconectado";
            }
        
            switch(strval(Rango))
            {
                case 1: r = "Miembro";
                case 2: r = "Reclutador";
                case 3: r = "Sub-Líder";
                case 4: r = "Líder";
            }

            format(Linea, sizeof(Linea), "%s\t%s\t%s\n",Nick, r, estado);
        
            strcat(Cuadro, Linea);
            db_next_row(resultado);
        }
     	ShowPlayerDialog(playerid,0, DIALOG_STYLE_TABLIST_HEADERS, "Miembros del clan", Cuadro, "Cerrar", "");
    }
    db_free_result(resultado);
    return 1;
}

CMD:ctag(playerid, params[])
{
    if(User[playerid][accountClan] == 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan");
    
    if(User[playerid][accountRango] != 4) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No eres el líder");
    
    if(sscanf(params, "s[41]", params[0])) 
        return SendClientMessage(playerid, 0xFFFF00FF, "Cmd: /ctag (tag)");
    
    if (strlen(params[0]) < 1 || strlen(params[0]) > 3) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: El tag debe contener entre 1 y 3 caracteres");
    
    if(!CheckValidTag(params[0])) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: El tag contiene digitos invalidos.");

    new 
        query[63], 
        DBResult:Resultado;
    
    format(query, sizeof(query), "SELECT * FROM `Clanes` WHERE `Tag` = '%s' COLLATE NOCASE", DB_Escape(params[2]));
    
    Resultado = db_query(DB_CLANS, query);
    
    if(db_num_rows(Resultado)) return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ya hay un clan con ese tag.");
    
    new ci[108],q[110];
    
    for(new c=0;c<MAX_CLANES;c++){if(Clans[c][CLAN_ID] == User[playerid][accountClan]){format(Clans[c][CLAN_TAG], 41, params[0]);}}
    
    format(q, sizeof(q), 
        "UPDATE `Clanes` SET `Tag`='%s' WHERE `ClanID`='%d' COLLATE NOCASE", DB_Escape(params[0]),DB_Escape(User[playerid][accountClan]));
    
    db_free_result(db_query(DB_CLANS, q));
    
    format(ci, sizeof(ci), "[Clan]: %s cambió el tag del clan. {%s}[%s]",pName(playerid),ccolor[clan_color[playerid]],params[0]);
    SendClanMessage(playerid, ci);
    SendAdminMessage(COLOR_CLAN,ci);
    
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(User[i][accountClan] == User[playerid][accountClan])
            {
                format(playerClan[i], 7, params[0]);
            }
        }
    
        new str[50];
        format(str,sizeof(str),
            ""white"Líder:"blue" %s\n"purple"(ID: %d)", clan_slogan[playerid], playerClan[playerid], pName(playerid));
    }
    return 1;
}

CMD:cslogan(playerid, params[])
{
    if(User[playerid][accountClan] == 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan");
    
    if(User[playerid][accountRango] != 4) return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No eres el líder");
    
    if(sscanf(params, "s[41]", params[0])) return SendClientMessage(playerid, 0xFFFF00FF, "Cmd: /cslogan (slogan)");
    
    if (strlen(params[0]) < 1 || strlen(params[0]) > 40) return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: El slogan no puede contener mas de 40 caracteres");
    
    new 
        ci[108],
        q[110]
        ;
    
    for(new c=0;c<MAX_CLANES;c++)
    {
        if(Clans[c][CLAN_ID] == User[playerid][accountClan])
        {
            format(Clans[c][CLAN_SLOGAN], 41, params[0]);
        }
    }
    
    format(q, sizeof(q), "UPDATE `Clanes` SET `Slogan`='%s' WHERE `ClanID`='%d' COLLATE NOCASE", DB_Escape(params[0]),DB_Escape(User[playerid][accountClan]));
    db_free_result(db_query(DB_CLANS, q));
    
    format(ci, sizeof(ci), "[Clan]: %s cambió el slogan del clan. {%s}(%s)", pName(playerid), ccolor[clan_color[playerid]],params[0]);
    SendClanMessage(playerid, ci);
    SendAdminMessage(COLOR_CLAN,ci);
    
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(User[i][accountClan] == User[playerid][accountClan])
   	        {
                format(clan_slogan[i], 42, params[0]);
            }
        }
    }
    return 1;
}

CMD:ctransferir(playerid, params[])
{
    if(User[playerid][accountClan] == 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan");
    
    if(User[playerid][accountRango] != 4) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No eres el líder");
    
    if(sscanf(params, "u", params[0])) 
        return SendClientMessage(playerid, 0xFFFF00FF, "Cmd: /ctransferir (jugador)");
    
    if(params[0] == playerid) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No puedes usar este comando en ti");
    
    if(!IsPlayerConnected(params[0])) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: El jugador no esta conectado");
    
    if(User[params[0]][accountClan] != User[playerid][accountClan]) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ese jugador no esta en tu clan");
    
    new 
        ci[87],
        q[89]
        ;

    for(new c=0;c<MAX_CLANES;c++)
    {
        if(Clans[c][CLAN_ID] == User[params[0]][accountClan])
        {
            format(Clans[c][CLAN_LIDER], 22, pName(params[0]));
        }
    }
    
    format(q, sizeof(q), "UPDATE `Clanes` SET `Lider`='%s' WHERE `ClanID`='%d' COLLATE NOCASE", DB_Escape(pName(params[0])),DB_Escape(User[params[0]][accountClan]));
    db_free_result(db_query(DB_CLANS, q));
    
    format(ci, sizeof(ci), "[Clan]: %s le entrego el liderazgo del clan a %s.", pName(playerid),pName(params[0]));
    SendClanMessage(playerid, ci);
    SendAdminMessage(COLOR_CLAN,ci);
    
    User[params[0]][accountRango] = 4;
    User[playerid][accountRango] = 3;
    
    ActPlayerData(playerid,"rango");
    ActPlayerData(params[0],"rango");
    return 1;
}

CMD:cexpulsar(playerid, params[])
{
    if(User[playerid][accountClan] == 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan");
    
    if(User[playerid][accountRango] < 2) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No eres reclutador");
    
    if(sscanf(params, "u", params[0])) 
        return SendClientMessage(playerid, 0xFFFF00FF, "Cmd: /cexpulsar (jugador)");
    
    if(params[0] == playerid) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No puedes usar este comando en ti");
    
    if(!IsPlayerConnected(params[0])) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: El jugador no esta conectado");
    
    if(User[params[0]][accountClan] != User[playerid][accountClan])
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ese jugador no esta en tu clan");
    
    if(User[params[0]][accountRango] == 4) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ese jugador es el líder");
    
    if(User[params[0]][accountRango] == 3 && User[playerid][accountRango] != 4) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Solo el líder puede expulsar a un sub-líder.");
    
    if(User[params[0]][accountRango] == 2 && User[playerid][accountRango] < 3) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No puedes expulsar a otro reclutador.");
    
    new ci[70],q[76];
    
    for(new c=0;c<MAX_CLANES;c++)
    {
        if(Clans[c][CLAN_ID] == User[params[0]][accountClan])
        {
            Clans[c][CLAN_MIEMBROS]--;
            format(q, sizeof(q), "UPDATE `Clanes` SET `Miembros`='%d' WHERE `ClanID`='%d' COLLATE NOCASE", DB_Escape(Clans[c][CLAN_MIEMBROS]),DB_Escape(User[params[0]][accountClan]));
            db_free_result(db_query(DB_CLANS, q));
        }
    }
    
    format(ci, sizeof(ci), "[Clan]: %s fue expulsado del clan {%s}[%s].", pName(params[0]),ccolor[clan_color[params[0]]],playerClan[params[0]]);
    SendClientMessageToAll(COLOR_CLAN, ci);
    
    jugador_invitado[params[0]] = -1;
    User[params[0]][accountRango] = 0;
    User[params[0]][accountClan] = 0;
    
    ActPlayerData(params[0],"clan");
    ActPlayerData(params[0],"rango");
    format(playerClan[params[0]], 3, "No");
    format(clan_slogan[params[0]], 3, "No");
    
    clan_color[params[0]] = 0;
    return 1;
}

CMD:ccolor(playerid, params[])
{
    if(User[playerid][accountClan] == 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan");
    
    if(User[playerid][accountRango] < 3) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No eres sub-lider");
    
    new 
        Cuadro[2250],
        Linea[50];
    
    for(new i = 0; i < 45; i ++)
    {
        format(Linea, sizeof(Linea), "{%s}Clan Color %d - %s\n",ccolor[i],i+1,pName(playerid));
        strcat(Cuadro, Linea);
    }
    
    ShowPlayerDialog(playerid,DIALOG_CCOLOR,DIALOG_STYLE_LIST, " ",Cuadro, "Cerrar", "");
    return 1;
}

CMD:crango(playerid, params[])
{
    if(User[playerid][accountClan] == 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan");
    
    if(User[playerid][accountRango] < 3) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No eres sub-lider");
    
    if(sscanf(params, "ui", params[0],params[1]))
        return SendClientMessage(playerid, 0xFFFF00FF, "Cmd: /crango (jugador) (rango)");
    
    if(!IsPlayerConnected(params[0])) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: El jugador no esta conectado");
    
    if(User[params[0]][accountClan] != User[playerid][accountClan]) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ese jugador no esta en tu clan");
    
    if(params[0] == playerid) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No puedes usar este comando en ti");
    

    if(params[1] < 1 || params[1] > 3) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Rangos: [1](Miembro) * [2](Reclutador) * [3](Sub-Líder)");
    
    if(params[1] == 3 && User[playerid][accountRango] != 4) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Solo el líder puede dar rango sub-líder.");
    
    if(User[params[0]][accountRango] == 4) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ese jugador es el líder");
    
    if(User[params[0]][accountRango] == 3 && User[playerid][accountRango] != 4) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Solo el líder puede degradar a un sub-líder.");
    
    User[params[0]][accountRango] = params[1];
    
    ActPlayerData(params[0],"rango");
    
    new rango[11];
    
    switch(params[1])
    {
        case 1: rango = "Miembro";
        case 2: rango = "Reclutador";
        case 3: rango = "Sub-Líder";
    }
    
    new c[83];
    
    format(c, sizeof(c), "[Clan]: %s cambió el rango de %s a %s.", pName(playerid),pName(params[0]),rango);
    SendClanMessage(playerid,c);
    SendAdminMessage(COLOR_CLAN,c);
    return 1;
}

CMD:csalir(playerid, params[])
{
    #pragma unused params
    if(User[playerid][accountRango] == 4) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No puedes dejar el clan porque eres el líder.");
    
    if(User[playerid][accountClan] == 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan");
    
    new 
        ci[61],
        q[76]
        ;
    
    for(new c=0;c<MAX_CLANES;c++)
    {
        if(Clans[c][CLAN_ID] == User[playerid][accountClan])
        {
            Clans[c][CLAN_MIEMBROS]--;
            format(q, sizeof(q), "UPDATE `Clanes` SET `Miembros`='%d' WHERE `ClanID`='%d' COLLATE NOCASE", DB_Escape(Clans[c][CLAN_MIEMBROS]),DB_Escape(User[playerid][accountClan]));
            db_free_result(db_query(DB_CLANS, q));
        }
    }
    
    format(ci, sizeof(ci), "[Clan]: %s salió del clan {%s}[%s].", pName(playerid),ccolor[clan_color[playerid]],playerClan[playerid]);
    SendClientMessageToAll(COLOR_CLAN, ci);
    
    jugador_invitado[playerid] = -1;
    User[playerid][accountClan] = 0;
    User[playerid][accountRango] = 0;
    
    format(playerClan[playerid], 3, "No");
    format(clan_slogan[playerid], 3, "No");
    
    clan_color[playerid] = 0;
    ActPlayerData(playerid,"clan");
    ActPlayerData(playerid,"rango");
    return 1;
}
//OPTMIZAR ESTO*/
new newplayername[20];
/*CMD:centrar(playerid, params[])
{
    if(User[playerid][accountClan] != 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ya estas en un clan");
 
    if(sscanf(params, "u", params[0])) 
        return SendClientMessage(playerid, COLOR_RED, "Uso: /centrar [id del que te invito]");
 
    if(User[playerid][accountChocolate] < 100000)
        return SendClientMessage(playerid, COLOR_RED, "[ERROR] Necesitas $100.000 para que se te coloque el tag al ingresar al clan.");
 
    if(!IsPlayerConnected(params[0])) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: El jugador no esta conectado");
 
    if(User[params[0]][accountClan] == 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ese jugador no tiene clan.");
 
    if(jugador_invitado[params[0]] != playerid) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ese jugador no te invito a su clan.");
 
    jugador_invitado[params[0]] = -1;
 
    format(playerClan[playerid], 7, playerClan[params[0]]);
    format(clan_slogan[playerid], 42, clan_slogan[params[0]]);
 
    clan_color[playerid] = clan_color[params[0]];
    User[playerid][accountClan] = User[params[0]][accountClan];
    User[playerid][accountRango] = 1;

    ActPlayerData(playerid,"clan");
    ActPlayerData(playerid,"rango");

    User[playerid][accountChocolate] -= 100000;

    new ci[62],q[76];

    format(ci, sizeof(ci), "[Clan]: %s entró al clan {%s}[%s].", pName(playerid),ccolor[clan_color[playerid]],playerClan[playerid]);
    SendClientMessageToAll(COLOR_CLAN, ci);
    SendClientMessage(playerid, COLOR_YELLOW,  "[Clan] "white"El costo por el ingreso y el tag es de "green"$100.000"white" dinero no destinado al líder.");

    for(new c=0;c<MAX_CLANES;c++)
    {
        if(Clans[c][CLAN_ID] == User[playerid][accountClan])
        {
            Clans[c][CLAN_MIEMBROS]++;
            format(q, sizeof(q), "UPDATE `Clanes` SET `Miembros`='%d' WHERE `ClanID`='%d' COLLATE NOCASE", DB_Escape(Clans[c][CLAN_MIEMBROS]),DB_Escape(User[playerid][accountClan]));
            db_free_result(db_query(DB_CLANS, q));
        }
    }
    return 1;
}

CMD:cinvitar(playerid, params[])
{
    if(User[playerid][accountClan] == 0)
		return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan");
		
    if(User[playerid][accountRango] < 2)
		return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No eres reclutador");
		
    if(sscanf(params, "u", params[0]))
		return SendClientMessage(playerid, 0xFFFF00FF, "Cmd: /cinvitar (Jugador)");
 
    if(params[0] == playerid)
		return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No puedes usar este comando en ti.");
 
    if(!IsPlayerConnected(params[0])) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: El jugador no está conectado.");
 
    if(User[params[0]][accountClan] != 0) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Ese jugador ya tiene clan.");
 
    jugador_invitado[playerid] = params[0];
 
    new c[116];
 
    format(c, sizeof(c), "[Clan]: {ffffff}%s[%d] te invito al clan {%s}[%s]. {ffffff}Usá: /centrar para unirte", pName(playerid),playerid,ccolor[clan_color[playerid]],playerClan[playerid]);
    SendClientMessage(params[0],COLOR_CLAN, c);
 
    format(c, sizeof(c), "[Clan]: {ffffff}Invitaste a %s al clan.", pName(params[0]),playerClan[playerid]);
    SendClientMessage(playerid,COLOR_CLAN, c);
    SendClientMessage(playerid,0xFF0000FF, "Recuerda que si invitaste a alguien y luego invitas a otro, la invitación anterior caducará.");
    return 1;
}

CMD:clanes(playerid, params[])
{
    #pragma unused params
    new 
        query[115],
        Cuadro[2500],
        Linea[79],
        Tag[7],
        Slogan[41],
        Miembros[7],
        Color[3],
        Lider[22],
        Id[4],
        DBResult:resultado,rows;
    
    format(query,sizeof(query),"SELECT `ClanID`,`Tag`,`Slogan`,`Miembros`,`Color`,`Lider` FROM `Clanes` WHERE `ClanID` > 0 ORDER BY `ClanID` ASC");
    resultado = db_query(DB_CLANS, query);
    rows = db_num_rows(resultado);

	if(rows == 0)
		return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No hay clanes.");

	if(rows)
    {
    	strcat(Cuadro, "ID\tClan\tMiembros\tLíder\n");
        for(new i = 0; i < rows; i ++)
        {
    	    db_get_field_assoc(resultado, "ClanID", Id, 4);
    	    db_get_field_assoc(resultado, "Tag", Tag, 7);
    	    db_get_field_assoc(resultado, "Slogan", Slogan, 41);
    	    db_get_field_assoc(resultado, "Miembros", Miembros, 7);
    	    db_get_field_assoc(resultado, "Color", Color, 3);
    	    db_get_field_assoc(resultado, "Lider", Lider, 22);

	        new slg[21];
	        strmid(slg,Slogan,0,20);
            format(Linea, sizeof(Linea), "%d\t{%s}[%s] - %s\t%d\t%s\n",strval(Id),ccolor[strval(Color)],Tag, slg, strval(Miembros), Lider);

	        strcat(Cuadro, Linea);
            db_next_row(resultado);
        }
        ShowPlayerDialog(playerid,0, DIALOG_STYLE_TABLIST_HEADERS, " ", Cuadro, "Cerrar", "");
    }
    db_free_result(resultado);
    return 1;
}

CMD:c(playerid, params[])
{
    if(User[playerid][accountClan] == 0)
		return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: No estas en un clan.");

	new t[128];

	if(sscanf(params, "s[128]", params[0]))
		return SendClientMessage(playerid, 0xFFFF00FF, "Cmd: /c (mensaje)");

	new rango[5];

	switch(User[playerid][accountRango])
    {
    	case 1: rango = "[M]";
    	case 2: rango = "[R]";
    	case 3: rango = "[SL]";
    	case 4: rango = "[L]";
    }

	format(t, sizeof(t), "{%s}[Clan %s]  %s(ID:%d): %s",ccolor[clan_color[playerid]],playerClan[playerid], pName(playerid), playerid, params[0]);
    SendClanMessage(playerid, t);
    SendAdminMessage(COLOR_CLAN, t);
    return 1;
}
*/
//CALLBACKS NO NATIVOS
//¿? REVISAR SU FUNCIÓN
JB_PUBLIC IsAdvertisement(szInput[])
{
    new
        iCount,
        iPeriod,
        iPos,
        iChar,
        iColon;

    while((iChar = szInput[iPos++])) {
        if('0' <= iChar <= '9') iCount++;
        else if(iChar == '.') iPeriod++;
        else if(iChar == ':') iColon++;
    }
    if(iCount >= 7 && iPeriod >= 3 && iColon >= 1) {
        return 1;
    }
    return 0;
}

//SANCIÓN CARCÉL
JB_PUBLIC JailPlayer(playerid)
{
    JBC_SetPlayerPos(playerid, 305.8537, 304.1868, 1003.3047);
    SetPlayerFacingAngle(playerid, 93.2811);
    SetPlayerInterior(playerid, 4);
    SetPlayerVirtualWorld(playerid, playerid);
    SetCameraBehindPlayer(playerid);
    JBC_ResetPlayerWeapons(playerid);

    return 1;
}
//CAMBIO DE NOMBRE
JB_PUBLIC OnPlayerNameChange(playerid)
{
    JBC_SetPlayerName(playerid, newplayername);
}
//RESTABLECER TIEMPO, ¿PARA? REVISAR.
JB_PUBLIC RestartTimer()
{
    SendClientMessageToAll(COLOR_YELLOW, "Restart Time has been reached, Restarting the server now.");
    return SendRconCommand("gmx");
}
//REVISAR.., PROBABLEMENTE INNECESARIO
JB_PUBLIC OnPlayerIsUnfreezed(playerid)
{
    JBC_TogglePlayerControllable(playerid, 1);
    return 1;
}
//PRIMER SPAWN, REVISAR, PROBALBLEMENTE INNECESARIO
JB_PUBLIC OnPlayerLogued(playerid)
{
    return firstspawn[playerid] = 1;
}
//FUNCIÓN VEHICULOS OCUPADOS
JB_PUBLIC IsSeatAvailable(vehicleid, seat)
{
    new carmodel = GetVehicleModel(vehicleid);

    new OneSeatVehicles[38] =
    {
        425, 430, 432, 441, 446, 448, 452, 453,
        454, 464, 465, 472, 473, 476, 481, 484,
        485, 486, 493, 501, 509, 510, 519, 520,
        530, 531, 532, 539, 553, 564, 568, 571,
        572, 574, 583, 592, 594, 595
    };

    for(new i = 0; i < sizeof(OneSeatVehicles); i++)
    {
        if(carmodel == OneSeatVehicles[i])
            return 0;
    }

    foreach(new i : Player)
    {
        if(GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) == seat)
            return 0;
    }
    return 1;
}


//FINALIZAR VOTEKICK
JB_PUBLIC EndVoteKick(playerid)
{
    new
        string[128]
    ;

    if(svotes > avotes)
    {
        format(string, sizeof(string), "[VOTEKICK] Tiempo para votar agotado. Votos afirmativos: %i | Votos negativos: %i.", svotes, avotes);
        SendClientMessageToAll(COLOR_ORANGE, string);
        format(string, sizeof(string), "[VOTEKICK] %s ha sido expulsado del servidor - Razon %s.", pName(VoteKickTarget), VoteKickReason);
        SendClientMessageToAll(COLOR_RED, string);
        Kick(VoteKickTarget);
    }
    else
    {
        format(string, sizeof(string), "[VOTEKICK] Tiempo para votar agotado. Votos afirmativos: %i | Votos negativos: %i.", svotes, avotes);
        SendClientMessageToAll(COLOR_ORANGE, string);
        format(string, sizeof(string), "[VOTEKICK] Votos insuficientes, %s se queda en el servidor.", pName(VoteKickTarget));
        SendClientMessageToAll(COLOR_RED, string);
    }

	//SIN VOTOS
    if(svotes == 0 && avotes == 0)
    {
        SendClientMessageToAll(COLOR_RED, "[VOTEKICK] Tiempo agotado, nadie ha votado.");
        format(string, sizeof(string), "[VOTEKICK] Votos insuficientes, %s se queda en el servidor.", pName(VoteKickTarget));
        SendClientMessageToAll(COLOR_RED, string);
    }

    format(VoteKickReason, sizeof(VoteKickReason), "N/D");
    VoteKickHappening = 0;
    avotes = 0;
    svotes = 0;
    VoteKickTarget = INVALID_PLAYER_ID;
    KillTimer(VoteTimer);

    foreach(new i : Player)
    {
        HasAlreadyVoted{i} = false;
    }
    return 1;
}

//CONTADOR EN SEGUNDOS DE SANCIONES
JB_PUBLIC PunishmentHandle()
{
    new string[128+50];

	//CARCÉL
    foreach(new i : Player)
    {
        if(User[i][accountJail] == 1)
        {
            if(User[i][accountJailSec] >= 1)
            {
                User[i][accountJailSec] --;
            }
            else if(User[i][accountJailSec] == 0)
            {
                User[i][accountJail] = 0;
                format(string, sizeof(string), "[INFO] %s[ID:%d] ha sido liberado, ha cumplido su sancion.", pName(i), i);
                SendClientMessageToAll(COLOR_GREY, string);
                SpawnPlayer(i);
                SetPlayerInterior(i, 0);
                SetPlayerVirtualWorld(i, 0);
            }
        }

		//MUTEO
		if(User[i][accountMuted] == 1)
        {
            if(User[i][accountMuteSec] >= 1)
            {
                User[i][accountMuteSec] --;
            }
			else if(User[i][accountMuteSec] == 0)
            {
                User[i][accountMuted] = 0;
                format(string, sizeof(string), "[INFO] %s[ID:%d] ha sido desmuteado, ha cumplido su sancion.", pName(i), i);
                SendClientMessageToAll(COLOR_GREY, string);
            }
        }

        if(User[i][accountCMuted] == 1)
        {
            if(User[i][accountCMuteSec] >= 1)
            {
                User[i][accountCMuteSec] --;
            }
            else if(User[i][accountCMuteSec] == 0)
            {
                User[i][accountCMuted] = 0;
                format(string, sizeof(string), "[INFO] %s[ID:%d] ha sido desmuteado(CMD), ha cumplido su sancion.", pName(i), i);
                SendClientMessageToAll(COLOR_GREY, string);
            }
        }
    }
    return 1;
}
//PENDIENTE.... REVISAR
JB_PUBLIC GamePlay()
{
    foreach(new playerid : Player)
    {
        if(User[playerid][accountLogged] == 1)
        {
            User[playerid][accountGame][0] += 1;
            
            if(User[playerid][accountGame][0] == 60)
            {
                User[playerid][accountGame][0] = 0;
                User[playerid][accountGame][1] += 1;
                
                if(User[playerid][accountGame][1] >= 59 && User[playerid][accountGame][0] == 0)
                {
                    User[playerid][accountGame][1] = 0;
                    User[playerid][accountGame][2] += 1;
                }
            }
        }
    }
    return 1;
}
//COUNTEO REGRESIVO
JB_PUBLIC CountDown()
{    
    new 
        countTime;

    if(countDisplay > 0)  
        countTime = SetTimer("CountDown", 1000, false);
    
    if(countDisplay == 0)
    {
        GameTextForAll("~w~Go ~y~Go ~g~Go]", 1000, 3);
        KillTimer(countTime);
        countDisplay = 5;
        SoundForAll(1058);
        return 1;
    }

    new 
        msg[24];
    
    format(msg, sizeof(msg), "~r~%d", countDisplay);
    GameTextForAll(msg, 5000, 3);
    SoundForAll(1056);
    return countDisplay--;
}
//MOSTRAR STATS
JB_PUBLIC ShowStatistics(playerid, playerid2)
{
    if(playerid2 == INVALID_PLAYER_ID) 
        return 1; //Do not proceed.

    new 
        string[750*2], 
        SecondString[128];
    
    new 
        temp, 
        hours, 
        minutes, 
        seconds;

	temp = (gettime()-User[playerid2][accountGameEx]) % 3600;
    hours = (gettime() - User[playerid2][accountGameEx] - temp) / 3600;
    minutes = (temp - (temp % 60)) / 60;
    seconds = temp % 60;

	new 
        FPS[MAX_PLAYERS],
        FPSS[MAX_PLAYERS],
        fps,
        FPSSS = GetPlayerDrunkLevel(playerid);

    if (FPSSS < 100) 
    {
        SetPlayerDrunkLevel(playerid, 2000);
    } 
        
    else if(FPSSS != FPSS[playerid]) 
    {
        fps = FPSS[playerid] - FPSSS; 

        if (fps > 0 && fps < 200) 
            FPS[playerid] = fps; 
        
        FPSS[playerid] = FPSSS; 
    }

	strcat(string, ""white"");
    
    format(SecondString, sizeof(SecondString), "-> "purple"Nick: "white"%s [ID: %d]\n", pName(playerid2), playerid2);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"UserID: "white"#%d\n", User[playerid2][accountID]);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"Fecha registro: "white"%s\n", User[playerid2][accountDate]);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"Tiempo Online: "white"%02d:%02d:%02d\n", hours, minutes, seconds);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"Tiempo total Online: "white"%02d:%02d:%02d\n", User[playerid2][accountGame][2], User[playerid2][accountGame][1], User[playerid2][accountGame][0]);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"Staff: "white"%s\n", GetAdminRank(User[playerid2][accountAdmin]));
    strcat(string, SecondString);

	#if VipSystem == true
        format(SecondString, sizeof(SecondString), "-> "purple"VIP: "white"%s\n", GetVIPRank(accountVip[playerid2]));
        strcat(string, SecondString);
    #endif

	format(SecondString, sizeof(SecondString), "-> "purple"Dinero: "white"$%d\n", User[playerid2][accountChocolate]);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"Score: "white"%d\n", GetPlayerScore(playerid2));
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"Duelos ganados: "white"%d\n", User[playerid2][accountDuelosg]);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"Duelos perdidos: "white"%d\n", User[playerid2][accountDuelosp]);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"Kills: "white"%d\n", User[playerid2][accountKills]);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"Deaths: "white"%d\n", User[playerid2][accountDeaths]);
    strcat(string, SecondString);
    
    new Float:ratio = (float(User[playerid2][accountKills])/float(User[playerid2][accountDeaths]));
    format(SecondString, sizeof(SecondString), "-> "purple"K/D (Ratio): "white"%.3f\n", ratio);
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"FPS: "white"%d\n", JBC_GetPlayerFPS(playerid2));
    strcat(string, SecondString);
    
    format(SecondString, sizeof(SecondString), "-> "purple"PacketLoss: "white"%.2f\n", NetStats_PacketLossPercent(playerid2));
    strcat(string, SecondString);

	format(SecondString, sizeof(SecondString), "-> "purple"Warns: "white"%d\n", User[playerid2][accountWarn]);
	strcat(string, SecondString);

	format(SecondString, sizeof(SecondString), "-> "purple"Racha record: "white"%d\n", User[playerid2][accountRacha]);
    strcat(string, SecondString);

	//format(SecondString, sizeof(SecondString), "-> "purple"Clan: {%s}[%s] - %s"white"\n", ccolor[clan_color[playerid2]],playerClan[playerid2], clan_slogan[playerid2]);
    //strcat(string, SecondString);

	if(personalVehicles[playerid2][v_id] != -1)
    {
    	format(SecondString, sizeof(SecondString), "-> "purple"Auto propio: "white"Sí\n");
    	strcat(string, SecondString);
    }

	format(SecondString, 556, ""lightblue"%s", pName(playerid2));
    ShowPlayerDialog(playerid, DIALOG_5, DIALOG_STYLE_MSGBOX, SecondString, string, "Cerrar", "");
    return 1;
}
//ANTIFAKEKILL, REVISAR
JB_PUBLIC OnFakeKillDetected(playerid)
{
    fake_kill[playerid]--;
    if(fake_kill[playerid] > 2) //si en menos de 1 seg, murio más de 2 veces, baneado.
    {
        new 
            msg[128];

        format(msg, sizeof(msg), "[GP.SEC] %s[%i] fue baneado. Fake Kill [Nivel 2]",pName(playerid), playerid);
        SaveLog("ban.txt", msg);
        
        SendClientMessageToAll(0xFF0000FF,msg);
        BanAccount(playerid, "GP.SEC", "Fake Kill");
        Ban(playerid);
    }
    return 1;
}

//ACTUALIZADO INDIVIDUAL DE DATOS
JB_PUBLIC ActPlayerData(playerid,stat[])
{
    if(User[playerid][accountLogged] != 1) return 1;

	new 
        query[128]
    ;

	//ACTUALIZADO DE IP
	if(!strcmp(stat,"ip"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `IP`='%s' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountIP],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE RANGO ADM
    if(!strcmp(stat,"admin"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `admin`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountAdmin],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE RANGO VIP
    if(!strcmp(stat,"vip"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `vip`='%d' WHERE `username`='%s' COLLATE NOCASE",accountVip[playerid],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE KILLS
    if(!strcmp(stat,"kills"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `kills`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountKills],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE MUERTES
    if(!strcmp(stat,"deaths"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `deaths`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountDeaths],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE SCORE
    if(!strcmp(stat,"score"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `score`='%d' WHERE `username`='%s' COLLATE NOCASE",GetPlayerScore(playerid),DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE DINERO ¿? USAMOS CHOCOLATE, BORRAR
    if(!strcmp(stat,"money"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `money`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountAdmin],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE ADVERTENCIAS
    if(!strcmp(stat,"warn"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `warn`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountWarn],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE SANCIÓN MUTE
    if(!strcmp(stat,"mute"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `mute`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountMuted],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE MUTEO EN EL CHAT SEG
    if(!strcmp(stat,"mutesec"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `mutesec`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountMuteSec],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE SANCIÓN MUTECMDS
    if(!strcmp(stat,"cmute"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `cmute`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountCMuted],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE MUTEO DE COMANDOS SEG
    if(!strcmp(stat,"cmutesec"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `cmutesec`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountCMuteSec],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO SANCIÓN JAIL
    if(!strcmp(stat,"jail"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `jail`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountJail],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE SANCIÓN JAIL SEG
    if(!strcmp(stat,"jailsec"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `jailsec`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountJailSec],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE TIEMPO DE JUGADOR ONLINE(HORA)
    if(!strcmp(stat,"hours"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `hours`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountGame][2],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE TIEMPO DE JUGADOR ONLINE(MINUTOS)
    if(!strcmp(stat,"minutes"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `minutes`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountGame][1],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE DE JUGADOR ONLINE(SEGUNDOS)
    if(!strcmp(stat,"seconds"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `seconds`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountGame][0],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE DE PREGUNTA DE SEGURIDAD
    if(!strcmp(stat,"question"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `question`='%s' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountQuestion],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE DE RESPUESTA DE SEGURIDAD
    if(!strcmp(stat,"answer"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `answer`='%s' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountAnswer],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE DE DINERO
    if(!strcmp(stat,"chocolate"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `chocolate`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountChocolate],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE DE SKINID
    if(!strcmp(stat,"skin"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `skin`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountSkin],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE DE ADMINSKIN
    if(!strcmp(stat,"useskin"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `useskin`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountUseSkin],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE DUELOS GANADOS
    if(!strcmp(stat,"duelosg"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `duelosg`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountDuelosg],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE DUELOS PERDIDOS
    if(!strcmp(stat,"duelosp"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `duelosp`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountDuelosp],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    /*//ACTUALIZADO DE CLAN
    if(!strcmp(stat,"clan"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `clan`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountClan],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    //ACTUALIZADO DE RANGO EN EL CLAN
    if(!strcmp(stat,"rango"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `rango`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountRango],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }*/
    //ACTUALIZADO DE RACHA
    if(!strcmp(stat,"racha"))
    {
    	format(query, sizeof(query), "UPDATE `users` SET `racha`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountRacha],DB_Escape(pName(playerid)));
    	db_free_result(db_query(DB_USERS, query));
    }
    return 1;
}

//GUARDADO DE DATOS
JB_PUBLIC SaveData(playerid)
{
    if(User[playerid][accountLogged] != 1) return 1;

	new query[128];

	format(query, sizeof(query), "UPDATE `users` SET `IP`='%s' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountIP],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));

	format(query, sizeof(query), "UPDATE `users` SET `admin`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountAdmin],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `vip`='%d' WHERE `username`='%s' COLLATE NOCASE",accountVip[playerid],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));

	format(query, sizeof(query), "UPDATE `users` SET `kills`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountKills],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `deaths`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountDeaths],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `score`='%d' WHERE `username`='%s' COLLATE NOCASE",GetPlayerScore(playerid),DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));

	format(query, sizeof(query), "UPDATE `users` SET `warn`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountWarn],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `mute`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountMuted],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `mutesec`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountMuteSec],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `cmute`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountCMuted],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `cmutesec`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountCMuteSec],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `jail`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountJail],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `jailsec`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountJailSec],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `hours`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountGame][2],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `minutes`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountGame][1],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `seconds`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountGame][0],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));

	format(query, sizeof(query), "UPDATE `users` SET `question`='%s' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountQuestion],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    
    format(query, sizeof(query), "UPDATE `users` SET `answer`='%s' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountAnswer],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));

	format(query, sizeof(query), "UPDATE `users` SET `chocolate`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountChocolate],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `skin`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountSkin],DB_Escape(pName(playerid)));

	db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `useskin`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountUseSkin],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));

	format(query, sizeof(query), "UPDATE `users` SET `duelosg`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountDuelosg],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `duelosp`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountDuelosp],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));

	/*format(query, sizeof(query), "UPDATE `users` SET `clan`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountClan],DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_USERS, query));*/
    //format(query, sizeof(query), "UPDATE `users` SET `rango`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountRango],DB_Escape(pName(playerid)));
    //db_free_result(db_query(DB_USERS, query));
    format(query, sizeof(query), "UPDATE `users` SET `racha`='%d' WHERE `username`='%s' COLLATE NOCASE",User[playerid][accountRacha],DB_Escape(pName(playerid)));

	db_free_result(db_query(DB_USERS, query));
    return 1;
}

//FUNCIÓN REGISTRO DE DEL JUGADOR
JB_PUBLIC RegisterPlayer(playerid, password[])
{
    SetPlayerScore(playerid, STARTING_SCORE);

    //Time = Hours, Time2 = Minutes, Time3 = Seconds
    new time, time2, time3;
    gettime(time, time2, time3);
    new date, date2, date3;
    //Date = Month, Date2 = Day, Date3 = Year
    getdate(date3, date, date2);

    format(User[playerid][accountDate], 150, "%02d/%02d/%d %02d:%02d:%02d", date, date2, date3, time, time2, time3);

    format(User[playerid][accountQuestion], 129, "N/D");
    format(User[playerid][accountAnswer], 129, "N/D");

    new
        query[128 * 3]
    ;

    format(query, sizeof(query),
        "INSERT INTO `users` (`username`, `IP`, `joindate`, `password`) VALUES ('%s', '%s', '%s', '%s')",\
            DB_Escape(pName(playerid)),
            DB_Escape(User[playerid][accountIP]),
            DB_Escape(User[playerid][accountDate]),
            DB_Escape(password)
    );
    db_query(DB_USERS, query);

    User[playerid][accountLogged] = 1;

    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);

    new DBResult: result;
    result = db_query(DB_USERS, "SELECT last_insert_rowid()");
    User[playerid][accountID] = db_get_field_int(result);
    db_free_result(result);

    SendClientMessage(playerid, COLOR_GREEN, "[BIENVENIDO] ¡Te has registrado correctamente!");
    playerLogued[playerid] = true;
    

    ShowPlayerDialog(playerid, DIALOG_WOULDYOU, DIALOG_STYLE_MSGBOX, "Recuperacion de seguridad", "Deseas ponerle a tu cuenta una pregunta de seguridad?\n\n* Podras usarla para recuperar tu cuenta en caso de olvidar tu password", "Si", "No");
    return 1;
}

//FUNCION LOGUEO DEL USUARIO
JB_PUBLIC LoginPlayer(playerid)
{

    new
        Query[900],
        DBResult:Result,
        string[128+40]
    	;

	format(Query, sizeof(Query), "SELECT * FROM `users` WHERE `username` = '%s'", DB_Escape(pName(playerid)));
    Result = db_query(DB_USERS, Query);
    if(db_num_rows(Result))
    {
        User[playerid][accountID] = db_get_field_assoc_int(Result, "userid");

        SetPlayerScore(playerid, db_get_field_assoc_int(Result, "score"));

        User[playerid][accountKills] = db_get_field_assoc_int(Result, "kills");
        User[playerid][accountDeaths] = db_get_field_assoc_int(Result, "deaths");
        User[playerid][accountAdmin] = db_get_field_assoc_int(Result, "admin");
        db_get_field_assoc(Result, "joindate", User[playerid][accountDate], 150);

        User[playerid][accountWarn] = db_get_field_assoc_int(Result, "warn");
        User[playerid][accountMuted] = db_get_field_assoc_int(Result, "mute");
        User[playerid][accountMuteSec] = db_get_field_assoc_int(Result, "mutesec");
        User[playerid][accountCMuted] = db_get_field_assoc_int(Result, "cmute");
        User[playerid][accountCMuteSec] = db_get_field_assoc_int(Result, "cmutesec");
        User[playerid][accountJail] = db_get_field_assoc_int(Result, "jail");
        User[playerid][accountJailSec] = db_get_field_assoc_int(Result, "jailsec");
        User[playerid][accountGame][2] = db_get_field_assoc_int(Result, "hours");
        User[playerid][accountGame][1] = db_get_field_assoc_int(Result, "minutes");
        User[playerid][accountGame][0] = db_get_field_assoc_int(Result, "seconds");

		User[playerid][accountChocolate] = db_get_field_assoc_int(Result, "chocolate");
        User[playerid][accountSkin] = db_get_field_assoc_int(Result, "skin");

		User[playerid][accountDuelosg] = db_get_field_assoc_int(Result, "duelosg");
        User[playerid][accountDuelosp] = db_get_field_assoc_int(Result, "duelosp");

		/*User[playerid][accountClan] = db_get_field_assoc_int(Result, "clan");
        User[playerid][accountRango] = db_get_field_assoc_int(Result, "rango");*/
        User[playerid][accountRacha] = db_get_field_assoc_int(Result, "racha");

		User[playerid][accountUseSkin] = db_get_field_assoc_int(Result, "useskin");

        #if VipSystem == true
            accountVip[playerid] = db_get_field_assoc_int(Result, "vip");
        #endif

	/*if(User[playerid][accountClan] == 0)
    {
    	format(playerClan[playerid], 3, "No");
    	format(clan_slogan[playerid], 2, " ");
    	clan_color[playerid] = 0;
    }
    else
    {
    	for(new c=0;c<MAX_CLANES;c++)
    	{

			if(Clans[c][CLAN_ID] == User[playerid][accountClan])
    		{
    			format(playerClan[playerid], 7, Clans[c][CLAN_TAG]);
    			format(clan_slogan[playerid], 42, Clans[c][CLAN_SLOGAN]);
    			clan_color[playerid] = Clans[c][CLAN_COLOR];
    		}
    	}
    }*/
    
    User[playerid][accountLogged] = 1;
    new stringe[130],stringe2[200],stringe3[150];

	SendClientMessage(playerid, -1, "{FFFFFF}<================== > {FFE769}Guerra de Pandillas Reborn - 2020 {FFFFFF}< =============== -l");
    format(stringe,sizeof(stringe),"{FFE769}>> ¡Hola de nuevo!  - Nick: {FFFFFF}%s{FFE769} - Cuenta ID: {FFFFFF}%i{FFE769}",pName(playerid),User[playerid][accountID]);
    SendClientMessage(playerid, -1, stringe);

	format(stringe2,sizeof(stringe2),"{FFE769}>> Fecha de registro:  {FFFFFF}%s{FFE769}- Dinero:{FFFFFF} $%d ", User[playerid][accountDate],User[playerid][accountChocolate]);
    SendClientMessage(playerid, -1, stringe2);

	format(stringe3,sizeof(stringe3),"{FFE769}>> Tiempo jugado: {FFFFFF}%02d:%02d:%02d{FFE769} - Advertencias:{FFE769} %d", User[playerid][accountGame][2], User[playerid][accountGame][1], User[playerid][accountGame][0],User[playerid][accountWarn]);
    SendClientMessage(playerid, -1, stringe3);
    SendClientMessage(playerid, -1, "{FFFFFF}|===========================================================================|");

	if(User[playerid][accountMuted] == 1)
    {
        format(string, 200, "[INFO] Has sido muteado del chat por %d segundos. Has sido muteado la ultima vez que te has ido.", User[playerid][accountMuteSec]);
        SendClientMessage(playerid, COLOR_RED, string);
    }
    
    if(User[playerid][accountCMuted] == 1)
    {
        format(string, 200, "** [INFO] Has sido muteado de usar CMD %d segundos. Has sido muteado la ultima vez que te has ido.", User[playerid][accountCMuteSec]);
        SendClientMessage(playerid, COLOR_RED, string);
    }

    SendClientMessage(playerid, COLOR_YELLOW, "[BIEVENIDO] ¡Te has logueado correctamente!");
    if(User[playerid][accountAdmin] >= 1)
    {
            format(string, sizeof(string), "[STAFF]{FFFFFF} Te has logueado correctamente como "lightblue"%s.", GetAdminRank(User[playerid][accountAdmin]));
            SendClientMessage(playerid, COLOR_YELLOW, string);

        }
        #if VipSystem == true

            switch(accountVip[playerid])
            {
                case 1:
                {
                    format(string, sizeof(string), "[VIP] %s {ffffff}se ha logueado en Guerra de Pandillas como "vip1_color"%s.", pName(playerid),GetVIPRank(accountVip[playerid]));
                    SendClientMessage(playerid, COLOR_YELLOW, string);
                }
                case 2:
                {
                    format(string, sizeof(string), "[VIP] %s {ffffff}se ha logueado en Guerra de Pandillas como "vip2_color"%s.", pName(playerid),GetVIPRank(accountVip[playerid]));
                    SendClientMessage(playerid, COLOR_YELLOW, string);
                }
            }
            
        #endif
        
        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
    }
    db_free_result(Result);
    return 1;
}

//CHEQUEO DE CONTRASEÑAS VÁLIDAS
JB_PUBLIC IsValidPassword( const password[ ] )
{
    for( new i = 0; password[ i ] != EOS; ++i )
    {
        switch( password[ i ] )
        {
            case '0'..'9', 'A'..'Z', 'a'..'z': continue;
            default: return 0;
        }
    }
    return 1;
}

//CHEQUEO DE ARMASID VÁLIDAS
JB_PUBLIC IsValidWeapon(weaponid)
{
    if (weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return 1;
    return 0;
}


//GUARDADO Y REGISTRO DE LOGS
JB_PUBLIC SaveLog(filename[], text[])
{
    if(!ServerInfo[SaveLogs])
        return 0;

    new string[256];

    if(!fexist(LOG_FOLDER))
    {
        printf("[JakAdmin3] Unable to overwrite '%s' at the '%s', '%s' missing.", filename, LOG_FOLDER, LOG_FOLDER);
        print("No logs has been saved to your server DB_USERS.");

        format(string, sizeof string, "JakAdmin3 has attempted to overwrite '%s' at the '%s' which is missing.", filename, LOG_FOLDER);
        SendAdminMessage(COLOR_RED, string);
        SendAdminMessage(-1, "No logs has been saved to the server DB_USERS, Check the console for further solution.");
        return 0;
    }

    new File:file,
        filepath[128+40]
    ;

    new year, month, day;
    new hour, minute, second;

    getdate(year, month, day);
    gettime(hour, minute, second);
    format(filepath, sizeof(filepath), ""LOG_FOLDER"%s", filename);
    file = fopen(filepath, io_append);
    format(string, sizeof(string),"[%02d/%02d/%02d | %02d:%02d:%02d] %s\r\n", month, day, year, hour, minute, second, text);
    fwrite(file, string);
    fclose(file);
    return 1;
}

//¿? ESTÁ DEMÁS, BORRAR
JB_PUBLIC EraseVeh(vehicleid)
{
    foreach(new i : Player)
    {
        new Float:X, Float:Y, Float:Z;
        if(IsPlayerInVehicle(i, vehicleid))
        {
            RemovePlayerFromVehicle(i);
            GetPlayerPos(i, X, Y, Z);
            JBC_SetPlayerPos(i, X, Y+3, Z);
        }
        SetVehicleParamsForPlayer(vehicleid, i, 0, 1);
    }
    SetTimerEx("VehRes", 1500, 0, "i", vehicleid);
}
//BORRADO DE VEHICULOS(CUALQUIERA)
JB_PUBLIC DelVehicle(vehicleid)
{
    foreach(new players : Player)
    {
        new Float:X, Float:Y, Float:Z;
        if(IsPlayerInVehicle(players, vehicleid))
        {
            GetPlayerPos(players, X, Y, Z);
            JBC_SetPlayerPos(players, X, Y, Z+2);
            SetVehicleToRespawn(vehicleid);
        }
        SetVehicleParamsForPlayer(vehicleid, players, 0, 1);
    }
    SetTimerEx("VehRes", 3000, 0, "d", vehicleid);
    return 1;
}
//LEER FUNCIONALIDAD, ELIMINAR SI ES POSIBLE
JB_PUBLIC VehRes(vehicleid)
{
    DestroyVehicle(vehicleid);
}
//REVISIÓN DE LA CARPETA JADMIN
JB_PUBLIC checkfolderEx()
{
    if(!fexist("JakAdmin3/"))
    {
        return 0;
    }
    if(!fexist("JakAdmin3/Logs/"))
    {
        return 0;
    }
    return 1;
}

//CONFIGURACIÓN DE LA CARPETA JADMIN
JB_PUBLIC checkfolder()
{
	//CREADO AUTOMÁTICO
    if(!fexist("JakAdmin3/"))
    {
        print("\n[JakAdmin3]: JakAdmin3 folder doesn't exist in scriptfiles, JakAdmin3 won't start.");
        print("Solution: Create the folder JakAdmin3 on the scriptfiles.");
        print("Continusly using the script with the missing file will not save the target script objective.\n");
        return 0;
    }//LOGS
    if(!fexist("JakAdmin3/Logs/"))
    {
        print("\n[JakAdmin3]: Logs folder doesn't exist in JakAdmin3 folder, JakAdmin3 won't start.");
        print("Solution: Create the folder Logs on the JakAdmin3 folder.");
        print("Continusly using the script with the missing file will not save the target script objective.\n");
        return 0;
    }
	//CONFIGURACIÓN
    new config[92];
    format(config, sizeof(config), "JakAdmin3/config.ini");

    if(!fexist("JakAdmin3/config.ini"))
    {
        print("\n[JakAdmin3]: config.ini doesn't exist, JakAdmin3 has created it for you.");
        print("[JakAdmin3]: config.ini has the default values setted on it, modify it your own.\n");

        dini_Create("JakAdmin3/config.ini");
        //OPCIONES DE REGISTRO
        dini_IntSet(config, "RegisterOption", 0);
        ServerInfo[RegisterOption] = 0;
        ///GUARDADO DE LOGS
        dini_IntSet(config, "SaveLog", 1);
        ServerInfo[SaveLogs] = 1;
        //ADVERTENCIAS POR LOGIN FALLIDOS
        dini_IntSet(config, "LoginWarn", 3);
        ServerInfo[LoginWarn] = 3;
        //ADVERTENCIAS POR PREGUNTA DE SEGURIDAD FALLIDA
        dini_IntSet(config, "SecureWarn", 3);
        ServerInfo[SecureWarn] = 3;
        //LOGUEO AUTOMÁTICO
        dini_IntSet(config, "AutoLogin", 0);
        ServerInfo[AutoLogin] = 0;
        ///LECTURA DE COMANDOS
        dini_IntSet(config, "ReadCmds", 1);
        ServerInfo[ReadCmds] = 1;
        ///LECTURA DE COMANDOS ¿?
        dini_IntSet(config, "ReadCmd", 0);
        ServerInfo[ReadCmd] = 0;
        //LÍMITE MÁXIMO DE PING
        dini_IntSet(config, "MaxPing", 0);
        ServerInfo[MaxPing] = 0;
        //ADVERTENCIAS POR PING EXCEDIDO
        dini_IntSet(config, "MaxPingWarn", 3);
        ServerInfo[MaxPingWarn] = 3;
        //¿?
        dini_IntSet(config, "AntiSwear", 1);
        ServerInfo[AntiSwear] = 1;
        //ANTI NOMBRES PROHIBIDOS
        dini_IntSet(config, "AntiName", 1);
        ServerInfo[AntiName] = 1;
        //ANTI PUBLICIDAD
        dini_IntSet(config, "AntiAd", 1);
        ServerInfo[AntiAd] = 1;
        //ANTI SPAM
        dini_IntSet(config, "AntiSpam", 0);
        ServerInfo[AntiSpam] = 0;
        //CONFIGURACIÓN DEL SISTEMA VIP
        #if VipSystem == true
            format(ServerInfo[VipRank1], 256, "VIP 1");
            dini_Set(config, "VipRank1", ServerInfo[VipRank1]);
            format(ServerInfo[VipRank2], 256, "VIP 2");
            dini_Set(config, "VipRank2", ServerInfo[VipRank2]);
        #endif
		//CONFIGURACIÓN DEL SISTEMA ADM
        format(ServerInfo[AdminRank1], 256, "Moderador a Prueba");
        dini_Set(config, "AdminRank1", ServerInfo[AdminRank1]);
        format(ServerInfo[AdminRank2], 256, "Moderador Iniciado");
        dini_Set(config, "AdminRank2", ServerInfo[AdminRank2]);
        format(ServerInfo[AdminRank3], 256, "Moderador global");
        dini_Set(config, "AdminRank3", ServerInfo[AdminRank3]);
        format(ServerInfo[AdminRank4], 256, "Administrador Iniciado");
        dini_Set(config, "AdminRank4", ServerInfo[AdminRank4]);
        format(ServerInfo[AdminRank5], 256, "Administrador global");
        dini_Set(config, "AdminRank5", ServerInfo[AdminRank5]);
        format(ServerInfo[AdminRank6], 256, "Director de Moderación");
        dini_Set(config, "AdminRank6", ServerInfo[AdminRank6]);
        format(ServerInfo[AdminRank7], 256, "Director de Administracion");
        dini_Set(config, "AdminRank7", ServerInfo[AdminRank7]);
        format(ServerInfo[AdminRank8], 256, "Director Global");
        dini_Set(config, "AdminRank8", ServerInfo[AdminRank8]);
        format(ServerInfo[AdminRank9], 256, "Sub-Owner");
        dini_Set(config, "AdminRank9", ServerInfo[AdminRank9]);
        format(ServerInfo[AdminRank10], 256, "Owner");
        dini_Set(config, "AdminRank10", ServerInfo[AdminRank10]);
    }
    else if(fexist("JakAdmin3/config.ini"))
    {
        ServerInfo[RegisterOption] = dini_Int(config, "RegisterOption");
        ServerInfo[SaveLogs] = dini_Int(config, "SaveLog");
        ServerInfo[LoginWarn] = dini_Int(config, "LoginWarn");
        ServerInfo[SecureWarn] = dini_Int(config, "SecureWarn");
        ServerInfo[AutoLogin] = dini_Int(config, "AutoLogin");
        ServerInfo[ReadCmds] = dini_Int(config, "ReadCmds");
        ServerInfo[ReadCmd] = dini_Int(config, "ReadCmd");
        ServerInfo[MaxPing] = dini_Int(config, "MaxPing");
        ServerInfo[MaxPingWarn] = dini_Int(config, "MaxPingWarn");
        ServerInfo[AntiSwear] = dini_Int(config, "AntiSwear");
        ServerInfo[AntiName] = dini_Int(config, "AntiName");
        ServerInfo[AntiAd] = dini_Int(config, "AntiAd");
        ServerInfo[AntiSpam] = dini_Int(config, "AntiSpam");
        /////
        #if VipSystem == true
            strmid(ServerInfo[VipRank1], dini_Get(config, "VipRank1"), false, strlen(dini_Get(config, "VipRank1")), 128);
            strmid(ServerInfo[VipRank2], dini_Get(config, "VipRank2"), false, strlen(dini_Get(config, "VipRank2")), 128);
        #endif
        /////
        strmid(ServerInfo[AdminRank1], dini_Get(config, "AdminRank1"), false, strlen(dini_Get(config, "AdminRank1")), 128);
        strmid(ServerInfo[AdminRank2], dini_Get(config, "AdminRank2"), false, strlen(dini_Get(config, "AdminRank2")), 128);
        strmid(ServerInfo[AdminRank3], dini_Get(config, "AdminRank3"), false, strlen(dini_Get(config, "AdminRank3")), 128);
        strmid(ServerInfo[AdminRank4], dini_Get(config, "AdminRank4"), false, strlen(dini_Get(config, "AdminRank4")), 128);
        strmid(ServerInfo[AdminRank5], dini_Get(config, "AdminRank5"), false, strlen(dini_Get(config, "AdminRank5")), 128);
        strmid(ServerInfo[AdminRank6], dini_Get(config, "AdminRank6"), false, strlen(dini_Get(config, "AdminRank6")), 128);
        strmid(ServerInfo[AdminRank7], dini_Get(config, "AdminRank7"), false, strlen(dini_Get(config, "AdminRank7")), 128);
        strmid(ServerInfo[AdminRank8], dini_Get(config, "AdminRank8"), false, strlen(dini_Get(config, "AdminRank8")), 128);
        strmid(ServerInfo[AdminRank9], dini_Get(config, "AdminRank9"), false, strlen(dini_Get(config, "AdminRank9")), 128);
        strmid(ServerInfo[AdminRank10], dini_Get(config, "AdminRank10"), false, strlen(dini_Get(config, "AdminRank10")), 128);
    }

    new File:file2, string[100];

    if(fexist("JakAdmin3/ForbiddenNames.cfg"))
    {
        if((file2 = fopen("JakAdmin3/ForbiddenNames.cfg",io_read)))
        {
            while(fread(file2,string))
            {
                for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
                BadNames[BadNameCount] = string;
                BadNameCount++;
            }
            fclose(file2);
        }
    }
    else
    {
        print("\n[JakAdmin3]: ForbiddenNames.cfg doesn't exist, JakAdmin3 has created it for you.\n");
        dini_Create("JakAdmin3/ForbiddenNames.cfg");
    }

    if(fexist("JakAdmin3/ForbiddenWords.cfg"))
    {
        if((file2 = fopen("JakAdmin3/ForbiddenWords.cfg",io_read)))
        {
            while(fread(file2,string))
            {
                for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
                ForbiddenWords[ForbiddenWordCount] = string;
                ForbiddenWordCount++;
            }
            fclose(file2);
        }
    }
    else
    {
        print("\n[JakAdmin3]: ForbiddenWords.cfg doesn't exist, JakAdmin3 has created it for you.\n");
        dini_Create("JakAdmin3/ForbiddenWords.cfg");
    }
    return 1;
}

//LISTA DE RANGOS GP
JB_PUBLIC ShowRanks(playerid)
{
    new string[128], combine[128 * 10];

    strcat(combine, ""red"Rango\t"green"Nombre\n");

    format(string, sizeof(string), "Rango administrativo #1\t"COLOR_RANK1"%s\n", ServerInfo[AdminRank1]);
    strcat(combine, string);
    format(string, sizeof(string), "Rango administrativo #2\t"COLOR_RANK2"%s\n", ServerInfo[AdminRank2]);
    strcat(combine, string);
    format(string, sizeof(string), "Rango administrativo #3\t"COLOR_RANK3"%s\n", ServerInfo[AdminRank3]);
    strcat(combine, string);
    format(string, sizeof(string), "Rango administrativo #4\t"COLOR_RANK4"%s\n", ServerInfo[AdminRank4]);
    strcat(combine, string);
    format(string, sizeof(string), "Rango administrativo #5\t"COLOR_RANK5"%s\n", ServerInfo[AdminRank5]);
    strcat(combine, string);
    format(string, sizeof(string), "Rango administrativo #6\t"COLOR_RANK6"%s\n", ServerInfo[AdminRank6]);
    strcat(combine, string);
    format(string, sizeof(string), "Rango administrativo #7\t"COLOR_RANK7"%s\n", ServerInfo[AdminRank7]);
    strcat(combine, string);
    format(string, sizeof(string), "Rango administrativo #8\t"COLOR_RANK8"%s\n", ServerInfo[AdminRank8]);
    strcat(combine, string);
    format(string, sizeof(string), "Rango administrativo #9\t"COLOR_RANK9"%s\n", ServerInfo[AdminRank9]);
    strcat(combine, string);
    format(string, sizeof(string), "Rango administrativo #10\t"COLOR_RANK10"%s\n", ServerInfo[AdminRank10]);
    strcat(combine, string);
    #if VipSystem == true
        format(string, sizeof(string), "Rango VIP #1\t"vip1_color"%s\n", ServerInfo[VipRank1]);
        strcat(combine, string);
        format(string, sizeof(string), "Rango VIP #2\t"vip2_color"%s\n", ServerInfo[VipRank2]);
        strcat(combine, string);
    #endif

    ShowPlayerDialog(playerid, DIALOG_RANKS, DIALOG_STYLE_TABLIST_HEADERS, "Configuración de rangos", combine, "Edit", "Volver");
    return 1;
}

//CONFIGURACIONES DE LA JADMIN
JB_PUBLIC ShowSettings(playerid)
{
    new string[140], combine[132 * 10];

    strcat(combine, ""blue"Nombre\t"orange"Estado\t"vip2_color"Descripción\n");
    format(string, sizeof(string), "Guardar logs\t%s\t"vip2_color"Guardar los registros logs\n", (ServerInfo[SaveLogs] == 1) ? (""green"ON"white"") : (""red"OFF"white""));
    strcat(combine, string);
    format(string, sizeof(string), "Intentos para loguear\t"grey"%d\t"vip2_color"Máximo intentos al ingresar al juego\n", ServerInfo[LoginWarn]);
    strcat(combine, string);
    format(string, sizeof(string), "Intentos para responder la pregunta de seguridad\t"grey"%d\t"vip2_color"Máximo intentos para responder la pregunta de seguridad\n", ServerInfo[SecureWarn]);
    strcat(combine, string);
    format(string, sizeof(string), "Ingreso automatico\t%s\t"vip2_color"Ingreso automatico al juego "red"(arriesgado)\n", (ServerInfo[AutoLogin] == 1) ? (""green"ON"white"") : (""red"OFF"white""));
    strcat(combine, string);
    format(string, sizeof(string), "Modo de leer comandos\t%s\t"vip2_color"Leer los comandos de todos, excepto /cpass\n", (ServerInfo[ReadCmds] == 1) ? (""green"ON"white"") : (""red"OFF"white""));
    strcat(combine, string);
    format(string, sizeof(string), "Chequeo de Ping\t"grey"%d"white"\t"vip2_color"Expulsar por ping excedido (No activar por favor)\n", ServerInfo[MaxPing]);
    strcat(combine, string);
    format(string, sizeof(string), "Ping máximo\t"grey"%d"white"\t"vip2_color"Advertencias máximas por ping excedido(No activar por favor)\n", ServerInfo[MaxPingWarn]);
    strcat(combine, string);
    format(string, sizeof(string), "Anti-juramento\t%s\t"vip2_color"Evita que los jugadores entren si el servidor está encendiendo\n", (ServerInfo[AntiSwear] == 1) ? (""green"ON"white"") : (""red"OFF"white""));
    strcat(combine, string);
    format(string, sizeof(string), "Nombres inapropiados\t%s\t"vip2_color"Expulsar a un jugador con nombre inapropiado\n", (ServerInfo[AntiName] == 1) ? (""green"ON"white"") : (""red"OFF"white""));
    strcat(combine, string);
    format(string, sizeof(string), "Anti-publicidad\t%s\t"vip2_color"Previene publicidad de spam (ej: 127.0.0.1:7777)\n", (ServerInfo[AntiAd] == 1) ? (""green"ON"white"") : (""red"OFF"white""));
    strcat(combine, string);
    format(string, sizeof(string), "Anti-flood\t%s\t"vip2_color"Evitar que un jugador haga flood (ej: asme akmin pls)\n", (ServerInfo[AntiSpam] == 1) ? (""green"ON"white"") : (""red"OFF"white""));
    strcat(combine, string);
    format(string, sizeof(string), "Tipo de lectura de comandos\t%s\t"vip2_color"Cambia el tipo de lectura de comandos\n", (ServerInfo[ReadCmd] == 1) ? (""green"Spectate"white"") : (""red"Normal"white""));
    strcat(combine, string);
    format(string, sizeof(string), "Registro(opcional)\t%s\t"vip2_color"Hace la función de registro opcional\n", (ServerInfo[RegisterOption] == 1) ? (""green"Yes"white"") : (""red"No"white""));
    strcat(combine, string);

    #if VipSystem == true
        strcat(combine, "Rangos\t"grey"13"white"\t"vip2_color"Editar rangos");
    #else
        strcat(combine, "Rangos administrativos\t"grey"10"white"\t"vip2_color"Editar rangos administrativos");
    #endif

    ShowPlayerDialog(playerid, DIALOG_SETTINGS, DIALOG_STYLE_TABLIST_HEADERS, "JakAdmin Configuration", combine, "Edit", "Cancelar");
    return 1;
}

//GUARDADO DE LA CONFIGURACIÓN JADMIN
JB_PUBLIC SaveConfig()
{
    new config[92];
    format(config, sizeof(config), "JakAdmin3/config.ini");
    dini_IntSet(config, "RegisterOption", ServerInfo[RegisterOption]);
    dini_IntSet(config, "SaveLog", ServerInfo[SaveLogs]);
    dini_IntSet(config, "LoginWarn", ServerInfo[LoginWarn]);
    dini_IntSet(config, "SecureWarn", ServerInfo[SecureWarn]);
    dini_IntSet(config, "AutoLogin", ServerInfo[AutoLogin]);
    dini_IntSet(config, "ReadCmds", ServerInfo[ReadCmds]);
    dini_IntSet(config, "ReadCmd", ServerInfo[ReadCmd]);
    dini_IntSet(config, "MaxPing", ServerInfo[MaxPing]);
    dini_IntSet(config, "MaxPingWarn", ServerInfo[MaxPingWarn]);
    dini_IntSet(config, "AntiSwear", ServerInfo[AntiSwear]);
    dini_IntSet(config, "AntiName", ServerInfo[AntiName]);
    dini_IntSet(config, "AntiAd", ServerInfo[AntiAd]);
    dini_IntSet(config, "AntiSpam", ServerInfo[AntiSpam]);
    #if VipSystem == true
        dini_Set(config, "VipRank1", ServerInfo[VipRank1]);
        dini_Set(config, "VipRank2", ServerInfo[VipRank2]);
    #endif
    dini_Set(config, "AdminRank1", ServerInfo[AdminRank1]);
    dini_Set(config, "AdminRank2", ServerInfo[AdminRank2]);
    dini_Set(config, "AdminRank3", ServerInfo[AdminRank3]);
    dini_Set(config, "AdminRank4", ServerInfo[AdminRank4]);
    dini_Set(config, "AdminRank5", ServerInfo[AdminRank5]);
    dini_Set(config, "AdminRank6", ServerInfo[AdminRank6]);
    dini_Set(config, "AdminRank7", ServerInfo[AdminRank7]);
    dini_Set(config, "AdminRank8", ServerInfo[AdminRank8]);
    dini_Set(config, "AdminRank9", ServerInfo[AdminRank9]);
    dini_Set(config, "AdminRank10", ServerInfo[AdminRank10]);
    return 1;
}

//ACTUALIZADO DE LA LISTA DE NOMBRES PROHIBIDOS
JB_PUBLIC UpdateForbidden()
{
    new File:file2, string[100];

    if((file2 = fopen("JakAdmin3/ForbiddenNames.cfg",io_read)))
    {
        while(fread(file2,string))
        {
            for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            BadNames[BadNameCount] = string;
            BadNameCount++;
        }
        fclose(file2);
        printf("\n-> %d forbidden names loaded from JakAdmin3", BadNameCount);
    }

    if((file2 = fopen("JakAdmin3/ForbiddenWords.cfg",io_read)))
    {
        while(fread(file2,string))
        {
            for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            ForbiddenWords[ForbiddenWordCount] = string;
            ForbiddenWordCount++;
        }
        fclose(file2);
        printf("-> %d forbidden words loaded from JakAdmin3", ForbiddenWordCount);
    }
    return 1;
}

JB_PUBLIC PosAfterSpec(playerid)
{
    JBC_SetPlayerPos(playerid, SpecPos[playerid][0], SpecPos[playerid][1], SpecPos[playerid][2]);
    SetPlayerFacingAngle(playerid, SpecPos[playerid][3]);
    SetPlayerInterior(playerid, SpecInt[playerid][0]);
    SetPlayerVirtualWorld(playerid, SpecInt[playerid][1]);
}

// LEER FUNCIONALIDAD....
JB_PUBLIC InsertReport(playerid, targetid, reason[])
{
    new 
        nextid = -1, 
        string[128], 
        r_hr, 
        r_min, 
        r_sec, 
        r_m, 
        r_d, 
        r_y;

    for(new i = 1; i < MAX_REPORTS; i++) // loops through MAX_REPORTs (exception for zero) to find the next unoccupied ID.
    {
        if(rInfo[i][reportTaken] == false)
        {
            nextid = i;
            break;
        }
    }

    if(nextid < 1) // failed to send the report to admins
    {
        SendClientMessage(playerid, COLOR_RED, "[REPORTE] No podemos procesarlo ahora, intenta mas tarde.");
        SendClientMessage(playerid, -1, "[REPORTE] Si no puedes hacerlo dentro de 5 minutos. Avisanos en nuestro /Facebook.");
    }
    else
    {
        getdate(r_y, r_m, r_d);
        gettime(r_hr, r_min, r_sec);

        rInfo[nextid][reportTaken] = true;
        rInfo[nextid][reporterID] = playerid;
        rInfo[nextid][reportedID] = targetid;
        rInfo[nextid][reportAccepted] = INVALID_PLAYER_ID;
        
        format(rInfo[nextid][reportTime], 32, "%02d-%02d-%d %02d:%02d:%02d", r_m, r_d, r_y, r_hr, r_min, r_sec);
        format(rInfo[nextid][reportReason], 64, reason);
        
        format(string, sizeof(string), "[REPORTE] %s[%d] reporto a %s[%d] por %s [RID: %d]", pName(playerid), playerid, pName(targetid), targetid, reason, nextid);
        SendAdminMessage(COLOR_LIGHTBLUE, string);

        foreach(new i : Player)
        {
            if(User[i][accountLogged] == 1)
            {
                if(User[i][accountAdmin] >= 1)
                {
                    PlayerPlaySound(i, 5201, 0.0, 0.0, 0.0);
                }
            }
        }

        format(string, sizeof(string), "[INFO] Tu reporte contra %s (%s) ha sido enviado - Reporte ID: %d. Ten paciencia.", pName(targetid), reason, nextid);
        SendClientMessage(playerid, COLOR_YELLOW, string);
    }
    return 1;
}

//LEER BIEN FUNCIONALIDAD
JB_PUBLIC HandleReport(playerid, reportid)
{
    new string[128];

    if(User[playerid][accountAdmin] >= 1)
    {
        if(rInfo[reportid][reportTaken] && rInfo[reportid][reportAccepted] == INVALID_PLAYER_ID)
        {
            format(string, sizeof(string), "[REPORTE] %s ha recepcionado tu reporte contra %s [Razón: %s]", pName(playerid), pName(rInfo[reportid][reportedID]), rInfo[reportid][reportReason]);
            SendClientMessage(rInfo[reportid][reporterID], COLOR_YELLOW, string);
            
            SendClientMessage(rInfo[reportid][reporterID], COLOR_ORANGE, "[INFO] Usa "white"/rchat + Mensaje "orange"para hablar con el Admin que lo ha recepcionado.");
            
            format(string, sizeof(string), "[REPORTE] %s recepcionó el reporte de %s contra %s[%d] - Razón: %s [RID: %d]", pName(playerid), pName(rInfo[reportid][reporterID]), pName(rInfo[reportid][reportedID]),rInfo[reportid][reportedID],rInfo[reportid][reportReason], reportid);
            
            StartSpectate(playerid, rInfo[reportid][reportedID]);
            ShowStatistics(playerid, rInfo[reportid][reportedID]);
            SendAdminMessage(COLOR_GREEN, string);

            rInfo[reportid][reportAccepted] = playerid;
        }
    }
    return 1;
}

//DENEGAR REPORTE
JB_PUBLIC DenyReport(playerid, reportid, reason[])
{
    new 
        string[500];

    if(User[playerid][accountAdmin] >= 1)
    {
        if(rInfo[reportid][reportTaken] && rInfo[reportid][reportAccepted] == INVALID_PLAYER_ID)
        {
            format(string, sizeof(string), "[INFO] %s ha invaldiado tu reporte contra %s (%s)", pName(playerid), pName(rInfo[reportid][reportedID]), rInfo[reportid][reportReason]);
            SendClientMessage(rInfo[reportid][reporterID], COLOR_YELLOW, string);
            
            format(string, sizeof(string), "[REPORTE] Admin: %s - Razon: %s", pName(playerid), reason);
            SendClientMessage(rInfo[reportid][reporterID], -1, string);

            format(string, sizeof(string), "[INFOADMINS] Reporte contra %s de %s rechazado por %s [%s] [RID: %d]", pName(rInfo[reportid][reportedID]), pName(rInfo[reportid][reporterID]), pName(playerid),reason, reportid);
            SendAdminMessage(COLOR_GREEN, string);

            ResetReport(reportid);
        }
    }
    return 1;
}

//FINALIZAR REPORTE
JB_PUBLIC EndReport(playerid, reportid, reason[])
{
    new 
        string[128];

    if(User[playerid][accountAdmin] >= 1)
    {
        if(rInfo[reportid][reportTaken] && rInfo[reportid][reportAccepted] == playerid)
        {
            format(string, sizeof(string), "[REPORTE] %s ha cerrado tu reporte contra %s[%s]", pName(playerid), pName(rInfo[reportid][reportedID]), rInfo[reportid][reportReason]);
            SendClientMessage(rInfo[reportid][reporterID], COLOR_YELLOW, string);
            
            format(string, sizeof(string), "[REPORTE] %s ha cerrado tu reporte - Razón: %s", pName(playerid), reason);
            SendClientMessage(rInfo[reportid][reporterID], COLOR_RED, string);

            format(string, sizeof(string), "[REPORTE] Reporte contra %s de %s cerrado por %s - Razón: %s [RID: %d]", pName(rInfo[reportid][reportedID]), pName(rInfo[reportid][reporterID]), pName(playerid),reason, reportid);
            SendAdminMessage(COLOR_ORANGE, string);
            
            StopSpectate(playerid);
            ResetReport(reportid);
        }
    }
    return 1;
}

//RESETEO DE REPORTES
JB_PUBLIC ResetReport(reportid)
{
    new 
        string[128];

    if(rInfo[reportid][reportTaken])
    {
        if(IsPlayerConnected(rInfo[reportid][reportAccepted]) && rInfo[reportid][reportAccepted] != INVALID_PLAYER_ID)
        {
            format(string, sizeof(string), "[REPORTE] RID %d recepcionado por ti, ha sido automaticamente cerrado.", reportid);
            StopSpectate(rInfo[reportid][reportAccepted]);
            SendClientMessage(rInfo[reportid][reportAccepted], -1, string);
        }

        rInfo[reportid][reportTaken] = false;
        rInfo[reportid][reporterID] = INVALID_PLAYER_ID;
        rInfo[reportid][reportedID] = INVALID_PLAYER_ID;
        rInfo[reportid][reportAccepted] = INVALID_PLAYER_ID;
        
        format(rInfo[reportid][reportTime], 32, "");
        format(rInfo[reportid][reportReason], 64, "");
    }
    return 1;
}

//DAR/RECIBIR DINERO, Y ACTUALIZADO DEL MISMO
JB_PUBLIC OnPlayerChocolateChange(playerid)
{
    if(JBC_GetPlayerMoney(playerid) != User[playerid][accountChocolate])
    {
        JBC_ResetPlayerMoney(playerid);
        JBC_GivePlayerMoney(playerid,User[playerid][accountChocolate]);
    }
    return 1;
}

//CERRAR/ABRIR PUERTAS, OPTIMIZAR, CAMBIAR Y LEER FUNCIONALIDAD..
JB_PUBLIC CarDoor(playerid, status)
{
    personalVehicles[playerid][a_puertas]=status;
    new motor, capo, luces, alarma, puertass, baul, objetivo;
    GetVehicleParamsEx(vehicleOwner[playerid],motor,luces,alarma,puertass,capo,baul,objetivo);
    SetVehicleParamsEx(vehicleOwner[playerid],motor,luces,alarma,status,capo,baul,objetivo);
    return 1;
}

//GUARDAR ÚLTIMA POSICIÓN DEL AUTO
JB_PUBLIC SavePosVehicle(playerid)
{
    new 
        string[128], 
        Float:x, 
        Float:y, 
        Float:z, 
        Float:anglez;
    
    GetVehiclePos(vehicleOwner[playerid], x, y, z);
    GetVehicleZAngle(vehicleOwner[playerid], anglez);

    CarDoor(playerid, personalVehicles[playerid][a_puertas]);

    format(string, sizeof(string), "UPDATE `Autos` SET `v_x`='%f' WHERE `Propietario`='%s' COLLATE NOCASE", x, DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));

    format(string, sizeof(string), "UPDATE `Autos` SET `v_y`='%f' WHERE `Propietario`='%s' COLLATE NOCASE", y, DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));

    format(string, sizeof(string), "UPDATE `Autos` SET `v_z`='%f' WHERE `Propietario`='%s' COLLATE NOCASE", z, DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));

    format(string, sizeof(string), "UPDATE `Autos` SET `v_angle`='%f' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][v_angle], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));

    format(string, sizeof(string), "UPDATE `Autos` SET `Puertas`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_puertas], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    return 1;
}

//GUARDADO DE DATOS DEL AUTO
JB_PUBLIC SaveModVehicle(playerid)
{
    if(personalVehicles[playerid][v_id] == -1) return 1;
    new string[128], color1, color2;
    
    if(GetVehicleColor(vehicleOwner[playerid], color1, color2))
    {
    personalVehicles[playerid][v_color1] = color1;
    personalVehicles[playerid][v_color2] = color2;
    }
    personalVehicles[playerid][a_aleron] = GetVehicleComponentInSlot(vehicleOwner[playerid], 0);
    personalVehicles[playerid][a_ven_techo] = GetVehicleComponentInSlot(vehicleOwner[playerid], 1);
    personalVehicles[playerid][a_techo] = GetVehicleComponentInSlot(vehicleOwner[playerid], 2);
    personalVehicles[playerid][a_laterales] = GetVehicleComponentInSlot(vehicleOwner[playerid], 3);
    personalVehicles[playerid][a_luces] = GetVehicleComponentInSlot(vehicleOwner[playerid], 4);
    personalVehicles[playerid][a_nitro] = GetVehicleComponentInSlot(vehicleOwner[playerid], 5);
    personalVehicles[playerid][a_escape] = GetVehicleComponentInSlot(vehicleOwner[playerid], 6);
    personalVehicles[playerid][a_ruedas] = GetVehicleComponentInSlot(vehicleOwner[playerid], 7);
    personalVehicles[playerid][a_hidraulica] = GetVehicleComponentInSlot(vehicleOwner[playerid], 9);
    personalVehicles[playerid][a_par_delantero] = GetVehicleComponentInSlot(vehicleOwner[playerid], 10);
    personalVehicles[playerid][a_par_trasero] = GetVehicleComponentInSlot(vehicleOwner[playerid], 11);
    personalVehicles[playerid][a_ven_derecha] = GetVehicleComponentInSlot(vehicleOwner[playerid], 12);
    personalVehicles[playerid][a_ven_izquierda] = GetVehicleComponentInSlot(vehicleOwner[playerid], 13);
    CarDoor(playerid, personalVehicles[playerid][a_puertas]);
    
    format(string, sizeof(string), "UPDATE `Autos` SET `Color1`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][v_color1], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Color2`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][v_color2], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Vinilo`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][v_vinyl], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Aleron`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_aleron], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Ven_techo`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_ven_techo], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Techo`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_techo], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Laterales`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_laterales], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Luces`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_luces], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Nitro`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_nitro], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Escape`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_escape], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Ruedas`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_ruedas], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Puertas`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_puertas], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Hidraulica`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_hidraulica], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Par_delantero`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_par_delantero], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Par_trasero`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_par_trasero], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Ven_derecha`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_ven_derecha], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `Ven_izquierda`='%d' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][a_ven_izquierda], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    return 1;
}

//ESTACIONAR AUTO, REVISAR SI SE PUEDE OPTIMIZAR
JB_PUBLIC ParkCar(playerid)
{
    if(personalVehicles[playerid][v_id] == -1) return 1;
    new string[128], Float:x, Float:y, Float:z;

    GetPlayerPos(playerid,x,y,z);
    GetVehicleZAngle(vehicleOwner[playerid], personalVehicles[playerid][v_angle]);

    format(string, sizeof(string), "UPDATE `Autos` SET `v_x`='%f' WHERE `Propietario`='%s' COLLATE NOCASE", x, DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `v_y`='%f' WHERE `Propietario`='%s' COLLATE NOCASE", y, DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `v_z`='%f' WHERE `Propietario`='%s' COLLATE NOCASE", z, DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    format(string, sizeof(string), "UPDATE `Autos` SET `v_angle`='%f' WHERE `Propietario`='%s' COLLATE NOCASE", personalVehicles[playerid][v_angle], DB_Escape(pName(playerid)));
    db_free_result(db_query(DB_VEHICLES, string));
    return 1;
}

//COMPRADO DE AUTO, OPTIMIZAR
JB_PUBLIC BuyCar(playerid, model, price)
{
    if(personalVehicles[playerid][v_id] != -1) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR] {FFFFFF}Ya tienes un auto.");
    
    if(User[playerid][accountChocolate] < price) 
        return SendClientMessage(playerid, 0xFF0000FF, "[ERROR] No tienes suficiente dinero para comprar este auto.");
    
    User[playerid][accountChocolate] -= price;
    
    new 
        Query[100],
        l[128],
        m[128];//PENDIENTE
    
    format(Query, sizeof(Query), "INSERT INTO `Autos` (`Propietario`,`Modelo`,`Precio`) VALUES ('%s','%d','%d')", DB_Escape(pName(playerid)), model, price);
    db_query(DB_VEHICLES, Query);
    
    format(l, sizeof(l), "[AUTOS] %s compro un(a) %s - Precio: %d", pName(playerid), VehicleNames[model - 400], price);
    SaveLog("gestion_autos.txt", l);

    format(m, sizeof(m), "[INFO] {FFFFFF}Compraste un(a) "grey"%s"white" por"green" $%d.", VehicleNames[model - 400], price);
    SendClientMessage(playerid, 0x00FF00FF, m);
    
    SendClientMessage(playerid, 0x00FF00FF, "[GP]{FFFFFF} Ahora tienes tu propio vehiculo. Lee tus "red"/comandos - sección autos.");
    GameTextForPlayer(playerid, "~h~Felicidades~n~ compraste tu vehiculo propio", 3000, 3);
    PlayerPlaySound(playerid, 1185, 0.0, 0.0, 0.0);
    SetTimerEx("StopSoundBuy", 10000, 0, "d", playerid);

    FindCar(playerid);
    JBC_SetVehiclePos(vehicleOwner[playerid], -1992.9872, 244.4187, 35.1650);
    JBC_PutPlayerInVehicle(playerid, vehicleOwner[playerid], 0);
    LinkVehicleToInterior(vehicleOwner[playerid], 0);
    SetVehicleVirtualWorld(vehicleOwner[playerid], 0);
    ParkCar(playerid);
    ActPlayerData(playerid, "chocolate");
    return 1;
}


//INNECESARIO, BORRAR
JB_PUBLIC StopSoundBuy(playerid)
{
	PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0);
	return 1;
}

//BORRADO DEL AUTO AL SALIR
JB_PUBLIC RemoveCar(playerid)
{
    if(vehicleOwner[playerid] != -1)
    {
        return DestroyVehicle(vehicleOwner[playerid]);
    }
    return 1;
}

//BUSCAR POSICIÓN DEL AUTO
JB_PUBLIC FindCar(playerid)
{
    new 
        Query[122], 
        DBResult:Resultado;
    
    format(Query, sizeof(Query), "SELECT * FROM `Autos` WHERE `Propietario` = '%s' COLLATE NOCASE", DB_Escape(pName(playerid)));
    Resultado = db_query(DB_VEHICLES, Query);
    
    if(db_num_rows(Resultado))
    {
        personalVehicles[playerid][v_id] = db_get_field_assoc_int(Resultado, "AutoID");
        personalVehicles[playerid][v_model] = db_get_field_assoc_int(Resultado, "Modelo");
        personalVehicles[playerid][v_price] = db_get_field_assoc_int(Resultado, "Precio");
        personalVehicles[playerid][v_vinyl] = db_get_field_assoc_int(Resultado, "Vinilo");
        personalVehicles[playerid][v_color1] = db_get_field_assoc_int(Resultado, "Color1");
        personalVehicles[playerid][v_color2] = db_get_field_assoc_int(Resultado, "Color2");

        personalVehicles[playerid][v_x] = db_get_field_assoc_float(Resultado, "v_x");
        personalVehicles[playerid][v_y] = db_get_field_assoc_float(Resultado, "v_y");
        personalVehicles[playerid][v_z] = db_get_field_assoc_float(Resultado, "v_z");
        personalVehicles[playerid][v_angle] = db_get_field_assoc_float(Resultado, "v_angle");

        personalVehicles[playerid][a_aleron] = db_get_field_assoc_int(Resultado, "Aleron");
        personalVehicles[playerid][a_ven_techo] = db_get_field_assoc_int(Resultado, "Ven_techo");
        personalVehicles[playerid][a_techo] = db_get_field_assoc_int(Resultado, "Techo");
        personalVehicles[playerid][a_laterales] = db_get_field_assoc_int(Resultado, "Laterales");
        personalVehicles[playerid][a_luces] = db_get_field_assoc_int(Resultado, "Luces");
        personalVehicles[playerid][a_nitro] = db_get_field_assoc_int(Resultado, "Nitro");
        personalVehicles[playerid][a_escape] = db_get_field_assoc_int(Resultado, "Escape");
        personalVehicles[playerid][a_ruedas] = db_get_field_assoc_int(Resultado, "Ruedas");
        personalVehicles[playerid][a_puertas] = db_get_field_assoc_int(Resultado, "Puertas");
        personalVehicles[playerid][a_hidraulica] = db_get_field_assoc_int(Resultado, "Hidraulica");
        personalVehicles[playerid][a_par_delantero] = db_get_field_assoc_int(Resultado, "Par_delantero");
        personalVehicles[playerid][a_par_trasero] = db_get_field_assoc_int(Resultado, "Par_trasero");
        personalVehicles[playerid][a_ven_derecha] = db_get_field_assoc_int(Resultado, "Ven_derecha");
        personalVehicles[playerid][a_ven_izquierda] = db_get_field_assoc_int(Resultado, "Ven_izquierda");
        SpawnOwnCar(playerid);
    }
    return 1;
}

//GENERA AUTO AL INGRESAR
JB_PUBLIC SpawnOwnCar(playerid)
{
    if(personalVehicles[playerid][v_id] == -1) return 1;
    
    vehicleOwner[playerid] = JBC_CreateVehicle(personalVehicles[playerid][v_model], personalVehicles[playerid][v_x], personalVehicles[playerid][v_y], personalVehicles[playerid][v_z], personalVehicles[playerid][v_angle], personalVehicles[playerid][v_color1], personalVehicles[playerid][v_color2], 100);
    
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_aleron]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_ven_techo]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_techo]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_laterales]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_luces]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_nitro]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_escape]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_ruedas]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_hidraulica]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_par_delantero]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_par_trasero]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_ven_derecha]);
    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_ven_izquierda]);
    CarDoor(playerid,personalVehicles[playerid][a_puertas]);
    ChangeVehiclePaintjob(vehicleOwner[playerid],personalVehicles[playerid][v_vinyl]);
    LinkVehicleToInterior(vehicleOwner[playerid],0);
    SetVehicleVirtualWorld(vehicleOwner[playerid],0);
    return 1;
}

//ENVIAR AUTO A ÚLTIMA POSICIÓN GUARDADA
JB_PUBLIC SendLastParking(playerid)
{
    new Query[122], DBResult: Resultado;
    format(Query, sizeof(Query), "SELECT * FROM `Autos` WHERE `Propietario` = '%s' COLLATE NOCASE", DB_Escape(pName(playerid)));

	Resultado = db_query(DB_VEHICLES, Query);
    if(db_num_rows(Resultado))
    {
	    personalVehicles[playerid][a_puertas] = db_get_field_assoc_int(Resultado, "Puertas");
	    personalVehicles[playerid][v_x] = db_get_field_assoc_float(Resultado, "v_x");
	    personalVehicles[playerid][v_y] = db_get_field_assoc_float(Resultado, "v_y");
	    personalVehicles[playerid][v_z] = db_get_field_assoc_float(Resultado, "v_z");
	    personalVehicles[playerid][v_angle] = db_get_field_assoc_float(Resultado, "v_angle");
	    JBC_SetVehiclePos(vehicleOwner[playerid], personalVehicles[playerid][v_x], personalVehicles[playerid][v_y], personalVehicles[playerid][v_z]);
	    CarDoor(playerid, personalVehicles[playerid][a_puertas]);
    }
    return 1;
}

//CARGAR AUTO
JB_PUBLIC LoadModVehicle(playerid)
{
    new Query[122], DBResult: Resultado;
    format(Query, sizeof(Query), "SELECT * FROM `Autos` WHERE `Propietario` = '%s' COLLATE NOCASE", DB_Escape(pName(playerid)));

	Resultado = db_query(DB_VEHICLES, Query);
    if(db_num_rows(Resultado))
    {
	    personalVehicles[playerid][v_id] = db_get_field_assoc_int(Resultado, "AutoID");
	    personalVehicles[playerid][v_model] = db_get_field_assoc_int(Resultado, "Modelo");
	    personalVehicles[playerid][v_price] = db_get_field_assoc_int(Resultado, "Precio");
	    personalVehicles[playerid][v_vinyl] = db_get_field_assoc_int(Resultado, "Vinilo");
	    personalVehicles[playerid][v_color1] = db_get_field_assoc_int(Resultado, "Color1");
	    personalVehicles[playerid][v_color2] = db_get_field_assoc_int(Resultado, "Color2");
	    personalVehicles[playerid][a_aleron] = db_get_field_assoc_int(Resultado, "Aleron");
	    personalVehicles[playerid][a_ven_techo] = db_get_field_assoc_int(Resultado, "Ven_techo");
	    personalVehicles[playerid][a_techo] = db_get_field_assoc_int(Resultado, "Techo");
	    personalVehicles[playerid][a_laterales] = db_get_field_assoc_int(Resultado, "Laterales");
	    personalVehicles[playerid][a_luces] = db_get_field_assoc_int(Resultado, "Luces");
	    personalVehicles[playerid][a_nitro] = db_get_field_assoc_int(Resultado, "Nitro");
	    personalVehicles[playerid][a_escape] = db_get_field_assoc_int(Resultado, "Escape");
	    personalVehicles[playerid][a_ruedas] = db_get_field_assoc_int(Resultado, "Ruedas");
	    personalVehicles[playerid][a_puertas] = db_get_field_assoc_int(Resultado, "Puertas");
	    personalVehicles[playerid][a_hidraulica] = db_get_field_assoc_int(Resultado, "Hidraulica");
	    personalVehicles[playerid][a_par_delantero] = db_get_field_assoc_int(Resultado, "Par_delantero");
	    personalVehicles[playerid][a_par_trasero] = db_get_field_assoc_int(Resultado, "Par_trasero");
	    personalVehicles[playerid][a_ven_derecha] = db_get_field_assoc_int(Resultado, "Ven_derecha");
	    personalVehicles[playerid][a_ven_izquierda] = db_get_field_assoc_int(Resultado, "Ven_izquierda");
	    vehicleOwner[playerid] = JBC_CreateVehicle(personalVehicles[playerid][v_model], personalVehicles[playerid][v_x], personalVehicles[playerid][v_y], personalVehicles[playerid][v_z], personalVehicles[playerid][v_angle], personalVehicles[playerid][v_color1], personalVehicles[playerid][v_color2], 100);
	    CarDoor(playerid, personalVehicles[playerid][a_puertas]);
	    ChangeVehicleColor(vehicleOwner[playerid], personalVehicles[playerid][v_color1], personalVehicles[playerid][v_color2]);
	    ChangeVehiclePaintjob(vehicleOwner[playerid], personalVehicles[playerid][v_vinyl]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_ven_techo]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_techo]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_laterales]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_luces]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_nitro]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_escape]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_ruedas]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_hidraulica]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_par_delantero]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_par_trasero]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_ven_derecha]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_ven_izquierda]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_aleron]);
	    JBC_AddVehicleComponent(vehicleOwner[playerid], personalVehicles[playerid][a_luces]);
    }
    return 1;
}

//CARGADO DE CLANES
/*JB_PUBLIC LoadClanesDB()
{
    new DBResult:qresult;
    qresult = db_query(DB_CLANS,  "SELECT * FROM `Clanes`");

	countClans = db_num_rows(qresult);
    new pr[31];format(pr,sizeof(pr),"[ADMIN] Clans loaded: %d.",db_num_rows(qresult));print(pr);

	if(countClans == 0)
	{
 		return print("[ADMIN] No clans in the DB_USERS.");
   	}

	for(new a=0;a<countClans;a++)
	{
		Clans[a][CLAN_ID] = db_get_field_assoc_int(qresult, "ClanID");
  		
        db_get_field_assoc(qresult, "Tag", Clans[a][CLAN_TAG], 7);
    	db_get_field_assoc(qresult, "Slogan", Clans[a][CLAN_SLOGAN], 41);
    	
        Clans[a][CLAN_COLOR] = db_get_field_assoc_int(qresult, "Color");
	    Clans[a][CLAN_MIEMBROS] = db_get_field_assoc_int(qresult, "Miembros");
	    Clans[a][CLAN_ASESINATOS] = db_get_field_assoc_int(qresult, "Asesinatos");
	    Clans[a][CLAN_MUERTES] = db_get_field_assoc_int(qresult, "Muertes");
	    
        db_get_field_assoc(qresult, "Lider", Clans[a][CLAN_LIDER], 22);
	    db_get_field_assoc(qresult, "Fecha", Clans[a][CLAN_FECHA], 12);
	    db_next_row(qresult);
    }
	db_free_result(qresult);
    return true;
}*/

/*//MENSAJE DE CLAN EN EL CHAT
JB_PUBLIC SendClanMessage(playerid, const string[])
{
    for(new i=0; i<MAX_PLAYERS; i++)
    {
    	if(IsPlayerConnected(i))
    	{
    		if(User[i][accountClan] == User[playerid][accountClan] && User[i][accountAdmin] == 0)
    		{
    			SendClientMessage(i, COLOR_CLAN,string);
    		}
    	}
    }
    return 1;
}*/
//REVISAR SU FUNCION
JB_PUBLIC SendAdminMessage(color, const string[])
{
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
        {
            if(User[i][accountAdmin] != 0)
            {
                if(firstspawn[i] != 0)
                {
                    SendClientMessage(i, color,string);
                }
            }   
        }
    }
    return 1;
}
//OPTIMIZAR ESTO
JB_PUBLIC EndPlayerDuel(playerid)
{
    if(Duel[playerid][d_enduelo] == true)
    {
        Duel[playerid][d_enduelo] = false;
        User[playerid][accountDuelosp]++;

        SpawnPlayer(playerid);
        KillTimer(timerDuel[playerid]);
        
        for(new i = 0; i < MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i) == 1)
            {
                if(Duel[i][d_id] == Duel[playerid][d_id] && Duel[i][d_enduelo] == true)
                {
                    new msg[128];
                    new log[50];
                    
                    format(msg, sizeof(msg),"Duelo: {00FFFF}%s(%d) es el ganador del duelo, porque %s(%d) se fue.",pName(i), i, pName(playerid), playerid);
                    SendClientMessageToAll(0x00D4E6FF, msg);
                    format(log, sizeof(log), "[DUELOS] %s ganó $%d en el duelo con %s", pName(i), Duel[i][d_apuesta]+Duel[i][d_apuesta], pName(playerid));
                    SaveLog("duelos.txt", log);
                    
                    Duel[i][d_enduelo] = false;
                    
                    KillTimer(timerDuel[i]);
                    
                    User[i][accountChocolate]+=Duel[i][d_apuesta]+Duel[i][d_apuesta];
                    Duel[i][d_id] = -1;
                    User[i][accountDuelosg]++;
                    
                    JBC_ResetPlayerWeapons(i);
                    SpawnPlayer(i);
                }
            }
        }
        Duel[playerid][d_id] = -1;
    }
    return 1;
}
//ENVIAR DDUELOS Y ASIGNACIÓN DE ARMAS, JUGADOR 2... OPTIMIZAR ESTO
JB_PUBLIC SendDuelToPlayer(playerid)
{
    Duel[playerid][d_conteo] = 6;
    User[playerid][accountChocolate]-=Duel[playerid][d_apuesta];
    timerDuel[playerid]  = SetTimerEx("duelo_conteo", 1000, 1, "i", playerid);
    switch(Duel[playerid][d_arena])
    {
    case 1: TP(playerid, 1414.8030,-21.8468,1000.9254,90.0215,1,Duel[playerid][d_id]);
    case 2: TP(playerid, -1391.0674,1217.2247,1039.8672,11.6718,7,Duel[playerid][d_id]);
    case 3: TP(playerid, 297.1362,-135.6223,1004.0625-3.0,88.3059,7,Duel[playerid][d_id]);
    case 4: TP(playerid, -1446.3085,994.3476,1024.1740,274.1066,7,Duel[playerid][d_id]);
    case 5: TP(playerid, -1113.2635,1060.0907,1342.8236,275.8692,7,Duel[playerid][d_id]);
    }
    switch(Duel[playerid][d_armas])
    {
    case 1: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 22,9999);JBC_GivePlayerWeapon(playerid, 26,9999);JBC_GivePlayerWeapon(playerid, 28,9999);}
    case 2: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 24,9999);JBC_GivePlayerWeapon(playerid, 27,9999);JBC_GivePlayerWeapon(playerid, 29,9999);JBC_GivePlayerWeapon(playerid, 31,9999);JBC_GivePlayerWeapon(playerid, 34,9999);}
    case 3: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 24,9999);JBC_GivePlayerWeapon(playerid, 25,9999);JBC_GivePlayerWeapon(playerid, 34,9999);}
    case 4: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 24,9999);}
    case 5: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 23,9999);}
    case 6: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 22,9999);}
    case 7: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 25,9999);}
    case 8: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 26,9999);}
    case 9: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 27,9999);}
    case 10: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 32,9999);}
    case 11: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 31,9999);}
    case 12: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 34,9999);}
    case 13: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 33,9999);}
    }
    JBC_SetPlayerHealth(playerid, 100);
    JBC_SetPlayerArmour(playerid, 100);
    SetCameraBehindPlayer(playerid);
    JBC_TogglePlayerControllable(playerid, 0);
    return 1;
}

//ENVIAR DUELO Y ASIGNACIÓN DE ARMAS JUGADOR 1... OPTIMIZAR ESTO
JB_PUBLIC SendDuelToOpponent(playerid)
{
    Duel[playerid][d_conteo] = 6;
    User[playerid][accountChocolate]-=Duel[playerid][d_apuesta];
    timerDuel[playerid]  = SetTimerEx("duelo_conteo", 1000, 1, "i", playerid);
    
    switch(Duel[playerid][d_arena])
    {
    case 1: TP(playerid, 1368.1542,-21.4281,1000.9219,269.0815,1,Duel[playerid][d_id]);
    case 2: TP(playerid, -1401.6309,1270.2854,1039.8672,190.1051,7,Duel[playerid][d_id]);
    case 3: TP(playerid, 274.7489,-135.1236,1004.0625-3.0,269.2459,7,Duel[playerid][d_id]);
    case 4: TP(playerid, -1351.8379,996.7326,1024.0472,87.3815,7,Duel[playerid][d_id]);
    case 5: TP(playerid, -998.1788,1064.2693,1342.8260,93.8441,7,Duel[playerid][d_id]);
    }
    switch(Duel[playerid][d_armas])
    {
    case 1: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 22,9999);JBC_GivePlayerWeapon(playerid, 26,9999);JBC_GivePlayerWeapon(playerid, 28,9999);}
    case 2: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 24,9999);JBC_GivePlayerWeapon(playerid, 27,9999);JBC_GivePlayerWeapon(playerid, 29,9999);JBC_GivePlayerWeapon(playerid, 31,9999);JBC_GivePlayerWeapon(playerid, 34,9999);}
    case 3: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 24,9999);JBC_GivePlayerWeapon(playerid, 25,9999);JBC_GivePlayerWeapon(playerid, 34,9999);}
    case 4: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 24,9999);}
    case 5: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 23,9999);}
    case 6: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 22,9999);}
    case 7: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 25,9999);}
    case 8: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 26,9999);}
    case 9: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 27,9999);}
    case 10: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 32,9999);}
    case 11: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 31,9999);}
    case 12: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 34,9999);}
    case 13: {JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 33,9999);}
    }
    JBC_SetPlayerHealth(playerid, 100);
    JBC_SetPlayerArmour(playerid, 100);
    SetCameraBehindPlayer(playerid);
    JBC_TogglePlayerControllable(playerid, 0);
    return 1;
}

//CONTADOR DE DUELOS Y ASIGNADO DE ARMAS... OPTIMIZAR ESTO
JB_PUBLIC CountPlayerDuel(playerid)
{
    new texto[15] ;
    Duel[playerid][d_conteo] --;
    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
    format(texto, sizeof(texto), "~n~~n~~n~~y~%d", Duel[playerid][d_conteo]);
    GameTextForPlayer(playerid, texto, 900, 3);
    if(Duel[playerid][d_conteo] == 0)
    {
	    KillTimer(timerDuel[playerid]);
	    JBC_TogglePlayerControllable(playerid,1);
	    GameTextForPlayer(playerid,"~n~~n~~n~~g~YA!", 900, 3);
	    Duel[playerid][d_tiempoa] = gettime();
	    switch(Duel[playerid][d_armas])
    	{
	    	case 1:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 22,9999),
				JBC_GivePlayerWeapon(playerid, 26,9999),
				JBC_GivePlayerWeapon(playerid, 28,9999)
				;
			}
			case 2:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 24,9999),
				JBC_GivePlayerWeapon(playerid, 27,9999);JBC_GivePlayerWeapon(playerid, 29,9999),
				JBC_GivePlayerWeapon(playerid, 31,9999);JBC_GivePlayerWeapon(playerid, 34,9999);
			}
			case 3:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 24,9999),
				JBC_GivePlayerWeapon(playerid, 25,9999),
				JBC_GivePlayerWeapon(playerid, 34,9999);
			}
		    case 4:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 24,9999);
			}
		    case 5:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 23,9999);
			}
		    case 6:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 22,9999);
			}
		    case 7:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 25,9999);
			}
		    case 8:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 26,9999);
			}
		    case 9:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 27,9999);
			}
		    case 10:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 32,9999);
			}
		    case 11:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 31,9999);
			}
		    case 12:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 34,9999);
			}
		    case 13:
			{
				JBC_ResetPlayerWeapons(playerid);JBC_GivePlayerWeapon(playerid, 33,9999);
            }
	    }
	    return 1;
	}
    return 1;
}

//REVISAR CUÁL ES SU FUNCIÓN
JB_PUBLIC OnPlayerVipRepairVehicle(playerid)
{
    TimeRepair[playerid] --;
    if(TimeRepair[playerid] == 0)
    {
        TimeRepair[playerid] = 30;
        VipCarRepaired[playerid] = false;
        //KillTimer(OnPlayerVipRepairVehicle(playerid));
    }
}

//SOPORTE DE INCLUDE JADMIN Y OTROS, NO BORRAR.

JB_PUBLIC check_playingtime(playerid)
{
    SetPVarInt(playerid, "account_hour", User[playerid][accountGame][2]);
    SetPVarInt(playerid, "account_minute", User[playerid][accountGame][1]);
    SetPVarInt(playerid, "account_second", User[playerid][accountGame][0]);
    return 1;
}
//REVISAR, PARA QUÉ SIRVE...
JB_PUBLIC set_playingtime(playerid, hour, minute, second)
{
    User[playerid][accountGame][2] = hour;
    User[playerid][accountGame][1] = minute;
    User[playerid][accountGame][0] = second;
    return 1;
}
JB_PUBLIC check_spawn(playerid)
{
    return pSpawned[playerid];
}
//CONSULTADO DE DINERO
JB_PUBLIC check_chocolate(playerid)
{
    return User[playerid][accountChocolate];
}
//ASIGNADOR DE DINERO
JB_PUBLIC set_chocolate(playerid, amount)
{
    User[playerid][accountChocolate] = amount;
    return 1;
}

//REVISADO DE NIVEL DE VIP
JB_PUBLIC vip_check()
{
    return vipsys;
}

#if VipSystem == true
	//REVISADO DE NIVEL VIP
    JB_PUBLIC check_vip(playerid)
    {
        return accountVip[playerid];
    }
	//GUARDAR VIP
	JB_PUBLIC save_vip(playerid)
	{
		return ActPlayerData(playerid, "vip");
	}
	//ASIGNADOR DE RANGO VIP
	JB_PUBLIC set_vip(playerid, level)
    {
        accountVip[playerid] = level;
        return 1;
    }
#endif

//GUARDAR DATOS DEL USUARIO
JB_PUBLIC save_player(playerid)
{
    return SaveData(playerid);
}

//CONSULTAR RANGO ADM
JB_PUBLIC check_admin(playerid)
{

    return User[playerid][accountAdmin];
}

//ASIGNADOR DE RANGO ADM
JB_PUBLIC set_admin(playerid, level)
{
    User[playerid][accountAdmin] = level;
    return 1;
}

//REVISADO DE LOGUEO
JB_PUBLIC check_login(playerid)
{
    return User[playerid][accountLogged];
}

//ASIGNADOR DE SI EL JUGADOR ESTÁ LOGUEADO O NO (INNECESARIO...)
JB_PUBLIC set_log(playerid, toggle)
{
    // Sets the accountLogged to toggle
    if(toggle == 0)
    {
        User[playerid][accountLogged] = 0;
    }
    else if(toggle >= 1)
    {
        User[playerid][accountLogged] = 1;
    }
    return 1;
}

//CHEQUEAR SI EL JUGADOR ESTÁ MUTEADO O NO
JB_PUBLIC check_mute(playerid)
{
    return User[playerid][accountMuted];
}

//CHQUEAR EL TIEMPO DE MUTEO EN EL CHAT
JB_PUBLIC check_mutesec(playerid)
{
    return User[playerid][accountMuteSec];
}

//CHEQUEAR SI UN JUGADOR ESTÁ MUTEADO O  NO
JB_PUBLIC check_cmute(playerid)
{
    return User[playerid][accountCMuted];
}

//CONSULTAR TIEMPO DE MUTEO DE COMANDOS
JB_PUBLIC check_cmutesec(playerid)
{
    return User[playerid][accountCMuteSec];
}

//¿? PENDIENTE CONSULTAR..
JB_PUBLIC set_mute(playerid, toggle)
{
    User[playerid][accountMuted] = toggle;
    return 1;
}

//ASIGNADOR DE MUTEO EN EL CHAT
JB_PUBLIC set_mutesec(playerid, sec)
{
    User[playerid][accountMuteSec] = sec;
    return 1;
}

//¿?PENDIENTE... CONSULTAR
JB_PUBLIC set_cmute(playerid, toggle)
{
    User[playerid][accountCMuted] = toggle;
    return 1;
}

//ASIGNADOR DE TIEMPO DE MUTEO DE COMANDOS
JB_PUBLIC set_cmutesec(playerid, sec)
{
    User[playerid][accountCMuteSec] = sec;
    return 1;
}
//REVISAR SI ESTÁ EN LA CARCÉL
JB_PUBLIC check_jail(playerid)
{
    return User[playerid][accountJail];
}

//CONSULTAR TIEMPO EN LA CARCÉL
JB_PUBLIC check_jailsec(playerid)
{
    // Check the player's jail seconds if there is any
    return User[playerid][accountJailSec];
}

//¿? PENDIENTE CONSULTAR...
JB_PUBLIC set_jail(playerid, toggle)
{
    User[playerid][accountJail] = toggle;
    return 1;
}

//ASIGNADOR DE TIEMPO EN LA CARCÉL
JB_PUBLIC set_jailsec(playerid, sec)
{
    User[playerid][accountJailSec] = sec;
    return 1;
}

//CONSULTAR ACCOUNTID
JB_PUBLIC check_id(playerid)
{
    return User[playerid][accountID];
}

//CONSULTAR ADVERTENCIAS
JB_PUBLIC check_warn(playerid)
{
    return User[playerid][accountWarn];
}

//MODIFICAR ADVERTENCIAS
JB_PUBLIC set_warn(playerid, warn)
{
    // Sets how many warns to the player
    User[playerid][accountWarn] = warn;
    return 1;
}

//CONSULTAR KILLS
JB_PUBLIC check_kills(playerid)
{
    return User[playerid][accountKills];
}
//MODIFICAR KILLS
JB_PUBLIC set_kill(playerid, kill)
{
    // Sets how many kills to the player
    User[playerid][accountKills] = kill;
    return 1;
}

//CONSULTAR MUERTES
JB_PUBLIC check_deaths(playerid)
{
    return User[playerid][accountDeaths];
}

//MODIFICAR MUERTES
JB_PUBLIC set_death(playerid, death)
{
    User[playerid][accountDeaths] = death;
    return 1;
}
//PRIMER SPAWN AL INGRESAR AL JUEGO
JB_PUBLIC first_spawn(playerid)
{
    return firstspawn[playerid];
}
//STOCKS
JB_Function:ResetPlayerData(playerid)
{
    playerLogued[playerid] = false;
    User[playerid][WarnLog] = 0;
    printf("Advertencias de logueo del cliente %d", User[playerid][WarnLog]); 
    User[playerid][SpecID] = INVALID_PLAYER_ID;

    User[playerid][accountSkin]    =   -1;

    User[playerid][accountDuelosg] = 0;
    User[playerid][accountDuelosp] = 0;

    //User[playerid][accountClan] = 0;
    //User[playerid][accountRango] = 0;
    User[playerid][accountAdmin] = 0;
    User[playerid][accountRacha] = 0;
    rachax[playerid] = 0;

    Duel[playerid][d_arena] = -1;
    Duel[playerid][d_armas] = -1;
    Duel[playerid][d_apuesta] = -1;
    Duel[playerid][d_desafiado] = -1;
    Duel[playerid][d_id] = -1;
    Duel[playerid][d_conteo] = -1;
    Duel[playerid][d_tiempoa] = 0;
    Duel[playerid][d_tiempob] = 0;
    Duel[playerid][d_invitaciones] = true;
    Duel[playerid][d_enduelo] = false;

    firstspawn[playerid] = 0;

    vipMessage[playerid] = false;

    vehicleOwner[playerid]=-1;
    personalVehicles[playerid][v_id]=-1;
    personalVehicles[playerid][v_model]=0;
    personalVehicles[playerid][v_price]=0;
    personalVehicles[playerid][v_color1]=0;
    personalVehicles[playerid][v_color2]=0;
    personalVehicles[playerid][v_vinyl]=255;
    personalVehicles[playerid][v_x]=0;
    personalVehicles[playerid][v_y]=0;
    personalVehicles[playerid][v_z]=0;
    personalVehicles[playerid][v_angle]=0;
    personalVehicles[playerid][a_aleron]=0;
    personalVehicles[playerid][a_ven_techo]=0;
    personalVehicles[playerid][a_techo]=0;
    personalVehicles[playerid][a_laterales]=0;
    personalVehicles[playerid][a_luces]=0;
    personalVehicles[playerid][a_nitro]=0;
    personalVehicles[playerid][a_escape]=0;
    personalVehicles[playerid][a_ruedas]=0;
    personalVehicles[playerid][a_puertas]=0;
    personalVehicles[playerid][a_hidraulica]=0;
    personalVehicles[playerid][a_par_delantero]=0;
    personalVehicles[playerid][a_par_trasero]=0;
    personalVehicles[playerid][a_ven_derecha]=0;
    personalVehicles[playerid][a_ven_izquierda] = 0;

    #if RconProtect == true
        _RCON[playerid] = false;
        _RCONwarn[playerid] = 0;
    #endif

    User[playerid][accountMarker] = false;
    User[playerid][pDuty] = 0;
    User[playerid][SpamCount] = 0;
    User[playerid][SpamTime] = 0;
    User[playerid][accountTemporary] = false;
    User[playerid][accountAdminEx] = 0;
    User[playerid][accountGameEx] = gettime();

    #if VipSystem == true
        accountVip[playerid] = 0;
    #endif

    User[playerid][accountChocolate] = 0;
    JBC_ResetPlayerMoney(playerid);
}
//¿? PENDIENTE CONSULTAR...
JB_Function:QuickSort_Pair(array[][2], bool:desc, left, right)
{
    #define PAIR_FIST (0)
    #define PAIR_SECOND (1)

    new
        tempLeft = left,
        tempRight = right,
        pivot = array[(left + right) / 2][PAIR_FIST],
        tempVar
    ;

    while (tempLeft <= tempRight)
    {
        if (desc)
        {
            while (array[tempLeft][PAIR_FIST] > pivot)
                tempLeft++;

            while (array[tempRight][PAIR_FIST] < pivot)
                tempRight--;
        }
        else
        {
            while (array[tempLeft][PAIR_FIST] < pivot)
                tempLeft++;

            while (array[tempRight][PAIR_FIST] > pivot)
                tempRight--;
        }

        if (tempLeft <= tempRight)
        {
            tempVar = array[tempLeft][PAIR_FIST];
            array[tempLeft][PAIR_FIST] = array[tempRight][PAIR_FIST];
            array[tempRight][PAIR_FIST] = tempVar;

            tempVar = array[tempLeft][PAIR_SECOND];
            array[tempLeft][PAIR_SECOND] = array[tempRight][PAIR_SECOND];
            array[tempRight][PAIR_SECOND] = tempVar;

            tempLeft++;
            tempRight--;
        }
    }

    if (left < tempRight)
        QuickSort_Pair(array, desc, left, tempRight);

    if (tempLeft < right)
        QuickSort_Pair(array, desc, tempLeft, right);

    #undef PAIR_FIST
    #undef PAIR_SECOND
}
//UTILIZAR PARA TODOS LOS COMANDOS, CALLBACKS, CADENAS... FUNCIÓN: OBTENER NOMBRE DEL USUARIO
JB_Function:pName(playerid)
{
    new GetName[24];
    GetPlayerName(playerid, GetName, 24);
    return GetName;
}

//CONSULTAR....
JB_Function:IDJugador(const String[]) {
    for(new i = 0; i < MAX_PLAYERS; i++) {
        if(IsPlayerConnected(i)) {
            if(strcmp(String, pName(i), true, strlen(String)) == 0) {
                if(strlen(String) != strlen(pName(i))) return INVALID_PLAYER_ID;
                return i;
            }
        }
    }
    return INVALID_PLAYER_ID;
}

//Y ESTA ESTA MAMADA  QUÉ WE :V
JB_Function:IsOwnerName(name[])
{
    new Names[3][15] = { {"Jefferson"}, {"Pablobl"}, {"Bryle"} };
    new i = -1;
    while(i < 3)
    {
        i += 1;
        if(strcmp(name,Names[i],true) == 0)return 1;
        else continue;
    }
    return 0;
}

//CLASIFICACIÓN DE PINGS POR COLORES
JB_Function:GetColorPing(ping)
{
    new 
        pingMessage[32];
    //BAJO
    if(ping >= 0 && ping < 150) 
        format(pingMessage, sizeof(pingMessage), ""COLOR_PING_A"%d", ping);
	//MEDIO
	if(ping >= 150 && ping < 200) 
        format(pingMessage, sizeof(pingMessage), ""COLOR_PING_B"%d", ping);
    //ALTO
    if(ping >= 200 && ping < 250) 
        format(pingMessage, sizeof(pingMessage), ""COLOR_PING_C"%d", ping);
	//MUY ALTO
	if(ping >= 250 && ping < 300) 
        format(pingMessage, sizeof(pingMessage), ""COLOR_PING_D"%d", ping);
	//EXCESIVO
	if(ping >= 300) 
        format(pingMessage, sizeof(pingMessage), ""COLOR_PING_E"%d", ping);
    return pingMessage;
}

//ANTE EXPULSIÓN
JB_Function:KickDelay(playerid)
{
    return SetTimerEx("KickMe", 800, false, "d", playerid);
}

//CONSULTAR....
JB_Function:ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
    new pos = 0;
    while (text[pos] < 0x21)
    {
        if (text[pos] == 0) return INVALID_PLAYER_ID;
        pos++;
    }

    new userid = INVALID_PLAYER_ID;
    if (isnumeric(text[pos]))
    {
        userid = strval(text[pos]);
        if (userid >=0 && userid < MAX_PLAYERS)
        {
            if(!IsPlayerConnected(userid))
            userid = INVALID_PLAYER_ID;
            else return userid;
        }
    }

    new len = strlen(text[pos]);
    new count = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (strcmp(pName(playerid), text[pos], true, len) == 0)
            {
                if (len == strlen(pName(playerid))) return i;
                else
                {
                    count++;
                    userid = i;
                }
            }
        }
    }

    if (count != 1)
    {
        if (playerid != INVALID_PLAYER_ID)
        {
            if (count) SendClientMessage(playerid, COLOR_WHITE, "[ERRPR] Escribe el nombre completo.");
            else SendClientMessage(playerid, COLOR_GREY, "[INFO] No se ha encontrado resultados.");
        }
        userid = INVALID_PLAYER_ID;
    }
    return userid;
}
JB_Function:CheckPlayerIps(playerid)
{
    //PROTECCIÓN ANTI MULTIPLES IP
    new
        ips;
    
    ips = GetNumberOfPlayersOnThisIP(GetIP(playerid));

    if(ips > 3)
    {
        new msg[64];
        format(msg, sizeof(msg), "%s[%i] fue expulsado. Posibles bots", pName(playerid), playerid);
        SendClientMessageToAll(0xFF0000FF, msg);
        print(msg);
        return Kick(playerid);
    }
    return 1;
}
//CUENTAS CON MISMAS IP´S
JB_Function:GetNumberOfPlayersOnThisIP(test_ip[])
{
    new 
        ip[32+1],
        x = 0,
        ipCount = 0;
    
    for(x=0; x<MAX_PLAYERS; x++) 
    {
        if(IsPlayerConnected(x)) 
        {
            GetPlayerIp(x, ip, sizeof(ip));
            if(!strcmp(ip, test_ip)) 
                ipCount++;
        }
    }
    return ipCount;
}

//CARGADO DE BASE DATOS
JB_Function:LoadUsersDB()
{
    new string[128 * 10];

    DB_USERS = db_open(JB_FOLDER);

    // TABLA DE DATOS USUARIOS
    strcat(string, "CREATE TABLE IF NOT EXISTS `users` ");
    strcat(string, "(");
    strcat(string, "`userid` INTEGER PRIMARY KEY AUTOINCREMENT, `username` STRING, `IP` STRING, `joindate` STRING, `password` STRING, `admin` INTEGER DEFAULT 0, `vip` INTEGER DEFAULT 0, ");
    strcat(string, "`kills` INTEGER DEFAULT 0, `deaths` INTEGER DEFAULT 0, `score` INTEGER DEFAULT 0, `money` INTEGER DEFAULT 0, `warn` INTEGER DEFAULT 0, ");
    strcat(string, "`mute` INTEGER DEFAULT 0, `mutesec` INTEGER DEFAULT 0, `cmute` INTEGER DEFAULT 0, `cmutesec` INTEGER DEFAULT 0, `jail` INTEGER DEFAULT 0, `jailsec` INTEGER DEFAULT 0, ");
    strcat(string, "`hours` INTEGER DEFAULT 0, `minutes` INTEGER DEFAULT 0, `seconds` INTEGER DEFAULT 0, `question` STRING DEFAULT 'none', `answer` STRING DEFAULT 'none'");
    strcat(string, ")");

	db_query(DB_USERS, string);
    
    db_query(DB_USERS, "ALTER TABLE `users` ADD COLUMN `chocolate` INTEGER DEFAULT 0");
    db_query(DB_USERS, "ALTER TABLE `users` ADD COLUMN `skin` INTEGER DEFAULT -1");
    db_query(DB_USERS, "ALTER TABLE `users` ADD COLUMN `useskin` INTEGER DEFAULT 0");
    db_query(DB_USERS, "ALTER TABLE `users` ADD COLUMN `duelosg` INTEGER DEFAULT 0");
    db_query(DB_USERS, "ALTER TABLE `users` ADD COLUMN `duelosp` INTEGER DEFAULT 0");
    db_query(DB_USERS, "ALTER TABLE `users` ADD COLUMN `clan` INTEGER DEFAULT 0");
    db_query(DB_USERS, "ALTER TABLE `users` ADD COLUMN `rango` INTEGER DEFAULT 0");
    db_query(DB_USERS, "ALTER TABLE `users` ADD COLUMN `racha` INTEGER DEFAULT 0");
    db_query(DB_USERS, "ALTER TABLE `users` ADD COLUMN `admin` INTEGER DEFAULT 0");
    //TABLA DE BANEOS
    db_query(DB_USERS, "CREATE TABLE IF NOT EXISTS `bans` (`banid` INTEGER PRIMARY KEY AUTOINCREMENT, `username` STRING, `ip` STRING, `banby` STRING, `banreason` STRING, `banwhen` STRING)");
    //TABLA DE IP´S
    db_query(DB_USERS, "CREATE TABLE IF NOT EXISTS `ips` (`username` STRING, `ip` STRING, `date` STRING, `time` STRING)");
    print("[JakAdmin3] "JB_FOLDER" loading...");
    return 1;
}

//CERRADO DE BASE DATOS
JB_Function:CloseUsersDB()
{
    print("[JakAdmin3] "JB_FOLDER" closing...");
    return db_close(DB_USERS);
}

//CHEQUEO DE CUENTA... CONSULTAR ESTO
JB_Function:CheckAccount(name[])
{
    new 
        query[128], DBResult:result, id;
    
    format(query, sizeof(query), "SELECT `userid` FROM `users` WHERE `username` = '%s'", DB_Escape(name));
    result = db_query(DB_USERS, query);

    if(db_num_rows(result))
    {
        id = db_get_field_assoc_int(result, "userid");
    }
    db_free_result(result);
    return id;
}

//LEER IP
JB_Function:GetIP(playerid)
{
    new 
        PlayerIp[32];
    
    GetPlayerIp(playerid, PlayerIp, sizeof(PlayerIp));
    return PlayerIp;
}

//REVISADO DE TEXTO, SÍ ES NÚMERICO
JB_Function:isnumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}

//BUSCAR NOMBRE DE ARMAID A PARTIR DEL NOMBRE
JB_Function:GetWeaponIDFromName(WeaponName[])
{
    if(strfind("molotov", WeaponName, true) != -1) return 18;
    for(new i = 0; i <= 46; i++)
    {
        switch(i)
        {
            case 0,19,20,21,44,45: continue;
            default:
            {
                new name[32]; GetWeaponName(i,name,32);
                if(strfind(name,WeaponName,true) != -1) return i;
            }
        }
    }
    return -1;
}

//¿? PENDIENTE, REVISAR...
JB_Function:DB_Escape(text[])
{
    new
        ret[80* 2],
        ch,
        i,
        j;
    while ((ch = text[i++]) && j < sizeof (ret))
    {
        if (ch == '\'')
        {
            if (j < sizeof (ret) - 2)
            {
                ret[j++] = '\'';
                ret[j++] = '\'';
            }
        }
        else if (j < sizeof (ret))
        {
            ret[j++] = ch;
        }
        else
        {
            j++;
        }
    }
    ret[sizeof (ret) - 1] = '\0';
    return ret;
}

//REVISADO DE LISTA DE BANEOS
JB_Function:CheckBan(ip[])
{
    new string[20],
        File: file = fopen("JakAdmin3/ban.ini", io_read);
    
    while(fread(file, string))
    {
        if (strcmp(ip, string, true, strlen(ip)) == 0)
        {
            fclose(file);
            return 1;
        }
    }
    fclose(file);
    return 0;
}

//BANEO POR IP
JB_Function:AddBan(ip[])
{
    if (!CheckBan(ip))
    {
        new File: file = fopen("JakAdmin3/ban.ini", io_append),
            string[300];

        format(string, sizeof(string), "\r\n%s", ip);
        fwrite(file, string);
        fclose(file);
        return 1;
    }
    return 0;
}

//DESBANEO OFFLINE
JB_Function:RemoveBan(ip[])
{
    if (CheckBan(ip))
    {
        new string[20],
            File:file = fopen("JakAdmin3/ban.ini", io_read);
        
        dini_Create("JakAdmin3/tempBan.ini");
        
        new File:file2 = fopen("JakAdmin3/tempBan.ini", io_append);
        
        while(fread(file, string))
        {
            if (strcmp(ip, string, true, strlen(ip)) != 0 && strcmp("\r\n", string) != 0)
            {
                fwrite(file2, string);
            }
        }
        fclose(file);
        fclose(file2);
        
        file = fopen("JakAdmin3/ban.ini", io_write);
        file2 = fopen("JakAdmin3/tempBan.ini", io_read);
        
        while(fread(file2, string))
        {
            fwrite(file, string);
        }
        fclose(file);
        fclose(file2);
        fremove("JakAdmin3/tempBan.ini");
        return 1;
    }
    return 0;
}

//TEXTO INFORMATIVO DE BANEO EN LA PANTALLA
JB_Function:ShowBan(playerid, banid = -1, admin[] = "GP.SEC", reason[] = "69 Sex", when[] = "01/01/1970 00:00:00")
{
    new string[256], SecondString[1500];

    for(new i=0; i<100; i++)
    {
        SendClientMessage(playerid, -1, " ");
    }

    format(string, sizeof(string), "Has sido baneado por %s, por las siguientes razones:", admin);
    SendClientMessage(playerid, COLOR_RED, string);
    
    format(string, sizeof(string), "(( %s ))", reason);
    SendClientMessage(playerid, -1, string);

    strcat(SecondString, ""grey"");
    strcat(SecondString, "Has sido baneado del servidor. Mostrando informacion relevante:\n\n");
    format(string, 256, ""white"BAN ID: "red"#%d\n", banid);
    strcat(SecondString, string);
    format(string, 256, ""white"NICK: "red"%s\n", pName(playerid));
    strcat(SecondString, string);
    format(string, 256, ""white"Baneado por: "red"%s\n", admin);
    strcat(SecondString, string);
    format(string, 256, ""white"Razon: "red"%s\n", reason);
    strcat(SecondString, string);
    format(string, 256, ""white"IP: "red"%s\n", User[playerid][accountIP]);
    strcat(SecondString, string);
    format(string, 256, ""white"Fecha: "red"%s\n\n", when);
    strcat(SecondString, string);
    strcat(SecondString, ""grey"");
    strcat(SecondString, "Si crees que fue abusivo o injustificado toma foto de tu pantalla con F8 o lo que sea.\n");
    strcat(SecondString, "Envia una foto con este cartel a "blue"fb.com/GuerradePandillasSAMP.");

    ShowPlayerDialog(playerid, DIALOG_6, DIALOG_STYLE_MSGBOX, ""blue"Has sido baneado del servidor.", SecondString, "Cerrar", "");
    return 1;
}

//BANEO OFFLINE
JB_Function:BanAccountEx(name[], ip[], admin[] = "Anticheat", reason[] = "None")
{
    new
        Query[500],
        DBResult:result,
        ban_hr, ban_min, ban_sec, ban_month, ban_days, ban_years, when[128]
    ;

    gettime(ban_hr, ban_min, ban_sec);
    getdate(ban_years, ban_month, ban_days);

    format(when, 140, "%02d/%02d/%d %02d:%02d:%02d", ban_month, ban_days, ban_years, ban_hr, ban_min, ban_sec);

    format(Query, 500, "INSERT INTO `bans` (`username`, `ip`, `banby`, `banreason`, `banwhen`) VALUES ('%s', '%s', '%s', '%s', '%s')", DB_Escape(name), DB_Escape(ip), DB_Escape(admin), DB_Escape(reason), DB_Escape(when));
    result = db_query(DB_USERS, Query);

    db_free_result(result);
    return 1;
}

//BANEO ONLINE
JB_Function:BanAccount(playerid, admin[] = "Anticheat", reason[] = "None")
{
    new
        Query[500],
        DBResult:result,
        ban_hr, ban_min, ban_sec, ban_month, ban_days, ban_years, when[128]
    ;

    gettime(ban_hr, ban_min, ban_sec);
    getdate(ban_years, ban_month, ban_days);

    format(when, 140, "%02d/%02d/%d %02d:%02d:%02d", ban_month, ban_days, ban_years, ban_hr, ban_min, ban_sec);

    AddBan(User[playerid][accountIP]);

    format(Query, 550, "INSERT INTO `bans` (`username`, `ip`, `banby`, `banreason`, `banwhen`) VALUES ('%s', '%s', '%s', '%s', '%s')", DB_Escape(pName(playerid)), DB_Escape(User[playerid][accountIP]), DB_Escape(admin), DB_Escape(reason), DB_Escape(when));
    db_query(DB_USERS, Query);

    result = db_query(DB_USERS, "SELECT last_insert_rowid()");
    SetPVarInt(playerid, "ban_id", db_get_field_int(result));
    db_free_result(result);
    return 1;
}

//REVISAR VEHICULO OCUPADO
JB_Function:VehicleOccupied(vehicleid)
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerInVehicle(i, vehicleid)) return 1;
    }
    return 0;
}

//BORRAR CUENTA A PARTIR DE USERNAME
JB_Function:DataExist(name[])
{
    new Buffer[180],
        Entry,
        DBResult:Result
    ;

    format(Buffer, sizeof(Buffer), "SELECT `userid` FROM `users` WHERE `username` = '%s'", name);
    Result = db_query(DB_USERS, Buffer);

    if(Result)
    {
        if(db_num_rows(Result))
        {
            Entry = 1;
            db_free_result(Result);
        }
        else Entry = 0;
    }
    return Entry;
}

//EMPEZAR SPEC
JB_Function:StartSpectate(playerid, specplayerid)
{
    foreach(new x : Player)
    {
        if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] == playerid)
        {
            AdvanceSpectate(x);
        }
    }

    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(specplayerid));
    SetPlayerInterior(playerid, GetPlayerInterior(specplayerid));
    JBC_TogglePlayerSpectating(playerid, 1);
    //SPEC EN VEHICULO
    if(IsPlayerInAnyVehicle(specplayerid))
    {
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
        User[playerid][SpecID] = specplayerid;
        User[playerid][SpecType] = SPEC_TYPE_VEHICLE;
    }
    else
    {
        PlayerSpectatePlayer(playerid, specplayerid);
        User[playerid][SpecID] = specplayerid;
        User[playerid][SpecType] = SPEC_TYPE_PLAYER;
    }
    return 1;
}

//DETENER SPEC
JB_Function:StopSpectate(playerid)
{
    JBC_TogglePlayerSpectating(playerid, 0);
    User[playerid][SpecID] = INVALID_PLAYER_ID;
    User[playerid][SpecType] = SPEC_TYPE_NONE;
    GameTextForPlayer(playerid,"~n~~n~~n~~w~Modo Spec terminado",1000,3);
    return 1;
}

//AVANZAR SPEC
JB_Function:AdvanceSpectate(playerid)
{
    if(Iter_Count(Player) == 2) { StopSpectate(playerid); return 1; }
    if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && User[playerid][SpecID] != INVALID_PLAYER_ID)
    {
        for(new x=User[playerid][SpecID]+1; x<=MAX_PLAYERS; x++)
        {
            if(x == MAX_PLAYERS) x = 0;
            if(IsPlayerConnected(x) && x != playerid)
            {
                if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
                {
                    continue;
                }
                else
                {
                    StartSpectate(playerid, x);
                    break;
                }
            }
        }
    }
    return 1;
}

//SPECTEO HACÍA ATRÁS
JB_Function:ReverseSpectate(playerid)
{
    if(Iter_Count(Player) == 2) { StopSpectate(playerid); return 1; }
    if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && User[playerid][SpecID] != INVALID_PLAYER_ID)
    {
        for(new x=User[playerid][SpecID]-1; x>=0; x--)
        {
            if(x == 0) x = MAX_PLAYERS;
            if(IsPlayerConnected(x) && x != playerid)
            {
                if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && User[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
                {
                    continue;
                }
                else
                {
                    StartSpectate(playerid, x);
                    break;
                }
            }
        }
    }
    return 1;
}

//OBTENER VEHICLEID EN BASE AL NOMBRE
JB_Function:GetVehicleModelIDFromName(vname[])
{
    for(new i = 0; i < 211; i++)
    {
        if ( strfind(VehicleNames[i], vname, true) != -1 )
        return i + 400;
    }
    return -1;
}

//CONFIGURACIÓN GENERAL: JADMIN
JB_Function:Config()
{
    print("\n");

    new
        dialog,
        rconpass
    ;

    #if REGISTER_DIALOG == true
        dialog = 1;
    #endif

    #if RconProtect == true
        rconpass = 1;
    #endif

    #if VipSystem == true
        vipsys = 1;
    #endif

	//CARGADO DE CONFIGURACIONES ADM
    print("\nJadmin settings\n\n");
    print("-> Config.ini");
    printf("[JADMIN] - AutoRegister: %s", (ServerInfo[RegisterOption]) ? ("Yes") : ("No"));
    printf("[JADMIN] - Save log: %s", (ServerInfo[SaveLogs]) ? ("Yes") : ("No"));
    printf("[JADMIN] - AutoLogin: %s", (ServerInfo[AutoLogin]) ? ("Yes") : ("No"));
    printf("[JADMIN] - Read commands: %s", (ServerInfo[ReadCmds]) ? ("Yes") : ("No"));
    printf("[JADMIN] - Way read commands: %s", (ServerInfo[ReadCmd]) ? ("Spectate") : ("Normal"));
    printf("[JADMIN] - LoginWarn: %d", ServerInfo[LoginWarn]);
    printf("[JADMIN] - SecureWarnQuestion: %d", ServerInfo[SecureWarn]);
    printf("[JADMIN] - HighPingKick: %s (Maximum Warnings; %d)", (ServerInfo[SaveLogs]) ? ("On") : ("Off"), ServerInfo[MaxPingWarn]);
    printf("[JADMIN] - Disable Player's Swear; %s", (ServerInfo[AntiSwear]) ? ("Yes") : ("No"));
    printf("[JADMIN] - Forbidden Name: %s", (ServerInfo[AntiName]) ? ("Yes") : ("No"));
    printf("[JADMIN] - AntiSponsored: %s", (ServerInfo[AntiAd]) ? ("Yes") : ("No"));
    printf("[JADMIN] - AntiSpam: %s", (ServerInfo[AntiSpam]) ? ("Yes") : ("No"));
    print("\n-> Others:");
    printf("[JADMIN] - Dialog register: %s", (dialog == 1) ? ("Yes") : ("No"));
    printf("[JADMIN] - Rcon security: %s", (rconpass == 1) ? ("Yes") : ("No"));
    printf("[JADMIN] - Vip system: %s", (vipsys == 1) ? ("Yes") : ("No"));
    print("\n-> Miscellaneous:");
    printf("[JADMIN] - Bad name: %d loaded", BadNameCount);
    printf("[JADMIN] - Bad words: %d loaded", ForbiddenWordCount);

	//CARGADO DE RANGOS VIP
    #if VipSystem == true
        print("\n-> VIP settings:");
        printf("VIP rango #1: %s", ServerInfo[VipRank1]);
        printf("VIP rango #2: %s", ServerInfo[VipRank2]);
    #endif

	//CARGADO DE RANGOS ADM
    print("\n-> Staff settings:");
    printf("[JADMIN] - Admin rank #1: %s", ServerInfo[AdminRank1]);
    printf("[JADMIN] - Admin rank #2: %s", ServerInfo[AdminRank2]);
    printf("[JADMIN] - Admin rank #3: %s", ServerInfo[AdminRank3]);
    printf("[JADMIN] - Admin rank #4: %s", ServerInfo[AdminRank4]);
    printf("[JADMIN] - Admin rank #5: %s", ServerInfo[AdminRank5]);
    printf("[JADMIN] - Admin rank #6: %s", ServerInfo[AdminRank6]);
    printf("[JADMIN] - Admin rank #7: %s", ServerInfo[AdminRank7]);
    printf("[JADMIN] - Admin rank #8: %s", ServerInfo[AdminRank8]);
    printf("[JADMIN] - Admin rank #9: %s", ServerInfo[AdminRank9]);
    printf("[JADMIN] - Admin rank #10: %s", ServerInfo[AdminRank10]);
    print("\n-> Jadmin settings end\n");
    return 1;
}

//¿? PENDIENTE, REVISAR.
JB_Function:TimeStamp()
{
    new time = GetTickCount() / 1000;
    return time;
}

//REVISAR NIVEL ADMIN
JB_Function:GetAdminRank(level)
{
    new name[30];

    switch(level)
    {
        case 1: format(name, 30, ServerInfo[AdminRank1]);
        case 2: format(name, 30, ServerInfo[AdminRank2]);
        case 3: format(name, 30, ServerInfo[AdminRank3]);
        case 4: format(name, 30, ServerInfo[AdminRank4]);
        case 5: format(name, 30, ServerInfo[AdminRank5]);
        case 6: format(name, 30, ServerInfo[AdminRank6]);
        case 7: format(name, 30, ServerInfo[AdminRank7]);
        case 8: format(name, 30, ServerInfo[AdminRank8]);
        case 9: format(name, 30, ServerInfo[AdminRank9]);
        case 10: format(name, 30, ServerInfo[AdminRank10]);
        default: format(name, 30, "Usuario");
    }
    return name;
}

//REVISAR NIVEL DE VIP
JB_Function:GetVIPRank(level)
{
    new name[64];

    switch(level)
    {
        case 1: format(name, 64, ServerInfo[VipRank1]);
        case 2: format(name, 64, ServerInfo[VipRank2]);
        default: format(name, 64, "Cuenta normal");
    }
    return name;
}

//REMOVER COLOR ALFA
JB_Function:RemoveAlpha(color)
{
    return (color & ~0xFF);
}

//AÑADIR COLOR ALFA
JB_Function:AddAlpha(color)
{
    new newcolor = color - (color & 0x000000FF) + 0xFF;
    return newcolor;
}

//FORMATEO DE NÚMERO
JB_Function:SetFormatNumber(Number, const Char[] = ",")
{
    new 
        GetSizeString[16];
    
    format(GetSizeString, sizeof(GetSizeString), "%d", Number);

	for(new l = strlen(GetSizeString)-3; l>0; l-=3)
    {
        strins(GetSizeString, Char, l);
    }
    return GetSizeString;
}

//AUDIO PARA TODOS(MÚSICA)
JB_Function:SoundForAll(soundid) 
{
    for(new i, t=GetMaxPlayers(); i<t; i++)
    {
        PlayerPlaySound(i, soundid, 0.0, 0.0, 0.0);
    }
}

//CHEQUEO DIGITO VÁLIDO
JB_Function:CheckValidDigit(string[])
{
    for(new i = 0, j = strlen(string); i < j; i++)
    {
        switch(string[i])
        {
            case '0' .. '9': continue;
            case 'a' .. 'z': continue;
            case 'A' .. 'Z': continue;
            case '_': continue;
            case '.': continue;
            case '=': continue;
            case '-': continue;
            case '+': continue;
            case '(': continue;
            case ')': continue;
            case '[': continue;
            case ']': continue;
            case ',': continue;
            case '?': continue;
            case ' ': continue;
            default: return 0;
        }
    }
    return 1;
}

//CHEQUEO DE TAG´S
JB_Function:CheckValidTag(string[])
{
    for(new i = 0, j = strlen(string); i < j; i++)
    {
        switch(string[i])
        {
            case '0' .. '9': continue;
            case 'a' .. 'z': continue;
            case 'A' .. 'Z': continue;
            case '.': continue;
            default: return 0;
        }
    }
    return 1;
}

//CONVERTOR DE TIEMPO SEC/MIN/HOUR
JB_Function:ConvertTime(seconds)
{
    new 
        tmp[16],
        minutes = floatround(seconds/60);
    
    seconds -= minutes*60;
    
    format(tmp, sizeof(tmp), "%d:%02d", minutes, seconds);
    return tmp;
}

JB_Function:TP(playerid, Float:x, Float:y, Float:z, Float:ang,interior,World)
{
    JBC_SetPlayerPos(playerid, x, y ,z+3.6);
    SetPlayerFacingAngle(playerid, ang);
    SetPlayerVirtualWorld(playerid,World);
    SetPlayerInterior(playerid,interior);
    SetCameraBehindPlayer(playerid);
    return 1;
}

#endif
//													GUERRA DE PANDILLAS REBORN ©
