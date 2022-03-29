/*====================================== GENERAL MAP ====== ================================================
									última actualización: desconocido
	Creditos:
			» pablobl[X]

                                                                                            GP 2017 - 2020 ©   
=============================================================================================================                                               */

/*------------------------------------------------------------------------------------------------------------------------------------->
																																	   |
                                  *MAPS GP 2019   (05/12/2018)*                 By: pablobl[X]                                         |
                                  *EDIT: 22/03/2019*                                                                                   |
																																	   |
										 Contenido:                                                                                    |
										 -Puertas Semi-Automaticas                                                                     |
										 -Bases Teams                                                                                  |
										 -Base VIP                                                                                     |
										 -Plaza ADM                                                                                    |
                                         -Maps LS, Country y Chilliad                                                                  |
                                         -Maps Boliche y Aeropuerto abandonado << Creditos a Luz por crear estos 2 mapeos              |
										 -Maps eventos (cazeria, supervivencia, retadores) << Creditos a Jefferson por el sistema      |
																																	   |
																																	   |
																																	   |
																																	   |
																																	   |
--------------------------------------------------------------------------------------------------------------------------------------->
*/
#include <a_samp>
#include <streamer>
#include <Junkbuster>
#include <jadmin3>
#include <zcmd>
//#include <pawn.cmd>
#include <a_actor>
#include <core>
#include <float>
//#include "../include/gl_common.inc"
#include <crashdetect>
//Colores.
#define RED      0xEB0042FE
#define blueSA   "{00BFFF}"
#define whiteA   "{FFFFFF}"
#define greenG   "{A5DF00}"
#define purpleB  "{BF00FF}"
#define yellowV  "{D7DF01}"
#define blueA    "{00BFFF}"
#define redN     "{FF4000}"
#define orangeB  "{FFBF00}"
#define blueP    "{2E2EFE}"
#define greenC   "{298A08}"
#define brownM   "{B45F04}"
#define blueHM   "{00FFFF}"
#define grayM    "{BDBDBD}"
#define blueF    "{01DFA5}"
#define brownS   "{FACC2E}"
#define purpleT  "{DA81F5}"
#define blueM    "{DBA901}"
#define pinkV    "{F5A9D0}"

//Directivas tipo macro

#define JB_PUBLIC%0(%1) forward %0(%1);\
					    public %0(%1)

#define ResetPos(%0); SetPlayerInterior(%0, 0);\
					 SetPlayerVirtualWorld(%0, 0);
					 
#define HealthCheck(%0,%1);\
		new Float:Health, s_[128]; GetPlayerHealth(%0, health);\
		format(s_, sizeof(s_), "[ERROR] Necesitas %s de vida para continuar.");\
		if(Health < %1)return SendClientMessage(%0, RED, s_);

//SISTEMA DE AUTOS - ACTORES
#define SALESMAN_ACT      	-1952.3247,291.2063,35.4688
#define SALESMAN_ANG        	90.8235
#define PURCHASER_ACT     	-1688.9515,13.0076,3.5547
#define PURCHASER_ANG        	50.4641
#define SALESMAN_TEXT      	-1952.3247, 291.2063, 35.4688+1.3
#define SALESMAN_DISTANC       	5.0

#pragma tabsize 0
native IsValidVehicle(vehicleid);

new bool:InHouse[MAX_PLAYERS];

new bool:dooropened[MAX_PLAYERS];
//NEWS ACTORES CASA GUÍA
new Vagabundo[2];
new Groove[2];
new Bleiscg[2];
new Fercg[2];
new Cescg[2];
new Pablocg[2];
new Brail[2];
new Smoke[2];
new nVagabundo[2];
//Actores de oficina de compra de clanes
new Empresario[2];
//new CompradorOficina[2];
//NEWS BASE VIP/////////////////////////////////////////////
new RejaAutomatica[1];
new PuertaMuelle;
new PuertaMuelle2;
new PuertaHangar1;
new PuertaHangar2;
new PuertaHangar3;
new PuertaHangar4;
new EntradaRoca[3];
new Pilar[1];
new CalleDeRoca[12];
new MuelleRoca[2];
new Estacionamiento[3];
new Luces[9];
new PastoIsla[2];
new Letrero[3];
new LetreroM[3];
new ParteDeLetrero[3];
new Taller[2];
new Hangar[3];
new Plataforma[6];
new Aviones[2];
new Reja[17];
new Reja1[4];
new Reja2[2];
new Puente[3];
new Rampa[2];
///----------------------------------------------------------
///NEWS PLAZA/////////////////////////////////////////////////
new M1[3];
new AltarA[2];
new MS[4];
new L[4];
new Plaza[2];
new GPC[2];
new Estatua[2];
new DarkKiller[2];
new Party[2];
new Frescoleit[2];
new Cesar[2];
new Yack[2];
new Santiago[2];
new Renegado[2];
new Saso[2];
new Blaze[2];
new Kayn[2];
new ArTema[2];
new sustancs[2];
new pablobl[2];
new Anticheat[3];
new Ice_Cube[2];
//-----------------------------------------------------------
//NEWS MAP LS////////////////////////////////////////////////
new CasaTienda[2];
///----------------------------------------------------------

//NEWS BASES/////////////////////////////////////////////////

//**Base Grove////
new PuertaGrove[2];
new RejaGrove[37];
new TorreGrove[3];
new H;
new Piso;
new EstatuaG[3];
new Escalera;

//**Base Balla////
new PuertaBalla;
new RejasBallas[7];
new Fuente;
new TorreB[2];
new ConcretoB;
new EscaleraB;

//**Base Vagos////
new PuertaRejaV[1];
new RejaV[14];
new ConcretoV[1];
new EscaleraV[4];
new TorreV[2];

//**Base Azteca////
new PuertaAzteca[1];
new RejasAztecas[13];
new concretoE[3];
new concretoA[1];
new concretoH[1];
new EscaleraA[5];
new TorreA[2];
new PilarA[2];

//**Base Bikers////
new RejaBK[10];
new PuertaBK[2];
new TorreBK[2];
new EscaleraBK[6];

//**Base DaNang////
new RejasDN[16];
new PuertasDN[2];
new TorresDN[3];

//**Base Vagabundos////
new RejaVG1[3];
new RejaVG2[5];
new RejaVG3[13];
new ConcretoVG[15];
new TorreVG[2];
new PisoVG[1];
new PuertasVG[3];

//**Base Policia////
new RejaP[13];
new PuertaP[1];
new EntradaP[1];
new TorreP[1];
new EscaleraP[4];

//**Base CIA////
new RejaCIA[53];
new RejaCIAG[1];
new PuertaCIA[2];
new TorreCIA[2];
new EntradaCIA[2];
new ConcretoCIAP[13];
new HangarCIA[1];
new PHangarCIA[2];
new CIAB[1];
new CIABC[2];
new PCIA[2];
new MCIA[4];
new MesaCIA[1];

//**Base Militar////
new RejaM[15];
new TorreM[3];
new ConcretoM[4];
new TorreA51M[2];
new PuertasM[2];

//**Base Mafia Rusa////
new RejasMR[37];
new TorreMR[3];
new EntradaMR[1];
new PuertaMR[1];

//**Base Traficantes////
new RejaTr[12];
new ParedT[1];
new TorreT[2];
new EscaleraT[2];
new PlataformaT[2];
new ConcretoT[3];
new PuertaT[2];
new EntradaT[1];
new LuzT[6];
new FuentesT[2];

//**Base Forelli////
new RejaF1[3];
new RejaF2[9];
new PuertaF[2];
new PilarF[3];
new TorreF[2];
new EscaleraF[6];
new SombrillaF[4];
new ParedF[47];
new MADDOGF[1];
new MADDOGRF[1];

//**Base Sindacco////
new RejaS[19];
new Reja2S[8];
new PuertaS[3];
new TorreS[3];
new EscaleraS[3];
new EstatuaS[1];
new DineroEstatuaS[1];
///----------------------------------------------------------

//NEWS AEROPUERTO ABANDONADO/////////////////////////////////////////////////
new ParedAA[28];
///----------------------------------------------------------

//new timer_vcoords[MAX_PLAYERS];
new bool:First_Spawn[MAX_PLAYERS] = true;

//CALLBACKS//////////////////////////////////////////////////////////////////////////////////////////////////////////

JB_PUBLIC TimerDoor(playerid)
{
dooropened[playerid] = false;
}

//Base vip**
JB_PUBLIC cerrar2(playerid)
{
   MoveDynamicObject(RejaAutomatica[0], 2900.54395, -1964.95886, 12.85459,2, 0.00000, 0.00000, 90.00000);
   return 1;
}

//Base grove**
JB_PUBLIC BaseGrove(playerid)
{
 MoveDynamicObject(PuertaGrove[0], 2424.18970, -1652.25110, 15.21864, 3, 0.00000, 0.00000, 90.00000);
 return 1;
}

JB_PUBLIC BaseGrove1(playerid)
{
 MoveDynamicObject(PuertaGrove[1], 2487.34180, -1721.88818, 15.18232, 3,  0.00000, 0.00000, 0.00000);
 return 1;
}

//Base balla**
JB_PUBLIC BaseBalla(playerid)
{
 MoveDynamicObject(PuertaBalla,  2225.61914, -1145.27698, 27.41272,3, 0.00000, 0.00000, -17.40000);
 return 1;
}

//Base vagos**
JB_PUBLIC BaseVago(playerid)
{
 MoveDynamicObject(PuertaRejaV[0], 2835.83350, -1189.11377, 26.20540, 3,    0.00000, 0.00000, -85.91997);
 return 1;
}

//Base azteca**
JB_PUBLIC BaseAztecas(playerid)
{
 MoveDynamicObject(PuertaAzteca[0], 1811.75439, -1883.62085, 15.18475, 3, 0.00000, 0.00000, 90.00000);
 return 1;
}

//Base bikers**
JB_PUBLIC BaseBK1(playerid)
{
MoveDynamicObject(PuertaBK[0],  1807.71960, -1342.01233, 16.95375, 3, 0.00000, 0.00000, 90.00000);
return 1;
}

JB_PUBLIC BaseBK2(playerid)
{
MoveDynamicObject(PuertaBK[1], 1817.74524, -1407.39233, 15.13323, 3, 0.00000, 0.00000, 0.00000);
return 1;
}

//Base danang**
JB_PUBLIC BaseDN1(playerid)
{
MoveDynamicObject(PuertasDN[0], 1275.68982, -1844.55432, 15.17112, 3, 0.00000, 0.00000, 0.00000);
return 1;
}

JB_PUBLIC BaseDN2(playerid)
{
MoveDynamicObject(PuertasDN[1], 1219.42822, -1844.73877, 15.21087, 3, 0.00000, 0.00000, 0.00000);
return 1;
}

//Base vagabundos**
JB_PUBLIC BaseVG1(playerid)
{
 MoveDynamicObject(PuertasVG[0], 2207.15649, -1905.31702, 15.55213, 3, 0.00000, 0.00000, 0.00000);
 return 1;
}

JB_PUBLIC BaseVG2(playerid)
{
 MoveDynamicObject(PuertasVG[1], 2204.15210, -1971.32007, 15.55590, 3, 0.00000, 0.00000, 90.00000);
 return 1;
}

JB_PUBLIC BaseVG3(playerid)
{
 MoveDynamicObject(PuertasVG[2], 2067.63867, -1948.73816, 15.31451, 3, 0.00000, 0.00000, 90.00000);
 return 1;
}

//Base policia**
JB_PUBLIC BasePolicia(playerid)
{
MoveDynamicObject(PuertaP[0], 1542.83459, -1621.96863, 15.20534, 3, 0.00000, 0.00000, 90.00000);
return 1;
}

//Base cia**
JB_PUBLIC BaseCIA1(playerid)
{
 MoveDynamicObject(PuertaCIA[0], 1283.65674, -2051.24634, 60.52392, 3, 0.00000, 0.00000, 90.00000);
 return 1;
}

JB_PUBLIC BaseCIA2(playerid)
{
 MoveDynamicObject(PuertaCIA[1], 1132.70679, -2082.58691, 69.72026, 3, 0.00000, 0.00000, 193.67984);
 return 1;
}

//Base militar**
JB_PUBLIC BaseM1(playerid)
{
MoveDynamicObject(PuertasM[0], 2720.05396, -2400.05884, 15.46723, 3,  0.00000, 0.00000, 90.00000);
return 1;
}
JB_PUBLIC BaseM2(playerid)
{
MoveDynamicObject(PuertasM[1], 2720.38354, -2498.67139, 15.32000, 3,   0.00000, 0.00000, 90.00000);
return 1;
}

//Base mafia rusa**
JB_PUBLIC MafiaRusa(playerid)
{
MoveDynamicObject(PuertaMR[0],2230.32104, -2211.53052, 15.41264, 3, 0.00000, 0.00000, 134.93996);
return 1;
}

//Base traficantes**
JB_PUBLIC BaseT1(playerid)
{
 MoveDynamicObject(PuertaT[0],  1134.20007, -1424.06287, 17.58656, 3, 0.00000, 0.00000, 0.00000);
 return 1;
}

JB_PUBLIC BaseT2(playerid)
{
 MoveDynamicObject(PuertaT[1],1176.06921, -1484.18115, 16.01622, 3, 0.00000, 0.00000, 90.00000);
 return 1;
}

//Base Forelli**
JB_PUBLIC BaseF1(playerid)
{
 MoveDynamicObject(PuertaF[0], 1252.12964, -768.10156, 93.83135, 3,  0.00000, 0.00000, 0.00000);
 return 1;
}

JB_PUBLIC BaseF2(playerid)
{
 MoveDynamicObject(PuertaF[1], 1322.54871, -814.33185, 73.89875, 3,  0.00000, 0.00000, 90.00000);
 return 1;
}

//Base sindacco**
JB_PUBLIC BaseS1(playerid)
{
 MoveDynamicObject(PuertaS[0], 670.73492, -1310.06665, 15.32916, 3, 0.00000, 0.00000, 0.00000);
 return 1;
}

JB_PUBLIC BaseS2(playerid)
{
 MoveDynamicObject(PuertaS[1], 786.40363, -1146.68579, 25.53655, 3, 0.00000, 0.00000, 90.00000);
 return 1;
}

JB_PUBLIC BaseS3(playerid)
{
 MoveDynamicObject(PuertaS[2], 663.28766, -1222.56018, 17.63250, 3, 0.00000, 0.00000, 61.13999);
 return 1;
}


///WARNING: SI SIGUES BAJANDO, PROCURA ESCUCHAR MUSICA PARA NO MAREARTE......////////////////////////////////////
public OnFilterScriptInit()
{
//-------------------------------------------------------------------------M A P---------------------------------------------------------------------------------------
print("\n[FILTERSCRIPT] General map loading...");

CreateDynamicObject(16061, 1479.86536, -1724.18042, 12.64622,   0.00000, 0.00000, -90.54002);
CreateDynamicObject(869, 1459.78113, -1624.21765, 14.19390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(869, 1499.75098, -1617.08557, 14.19390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(869, 1459.64355, -1617.35815, 14.19390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(869, 1499.40015, -1624.78943, 14.19390,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(869, 1487.62561, -1666.42224, 13.9307,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(869, 1471.01685, -1666.43445, 13.9479,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8991, 1479.77100, -1669.68689, 14.01311,   0.00000, 0.00000, 1.26000);
CreateDynamicObject(8991, 1479.22241, -1662.66736, 14.01311,   0.00000, 0.00000, 1.26000);
CreateDynamicObject(3515, 1510.22058, -1669.94019, 12.15167,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1450.21545, -1653.06604, 12.18408,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(9833, 1478.94727, -1638.94470, 16.58778,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1490.84204, -1681.19006, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1503.27820, -1681.25549, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1490.74597, -1714.76563, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1502.94592, -1714.90088, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1490.92896, -1670.77844, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1467.91016, -1670.91455, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1467.96387, -1661.17236, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1490.88525, -1660.90637, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1465.96228, -1681.29626, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1454.00256, -1681.32300, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1466.29773, -1714.83008, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1453.95544, -1714.84131, 13.54414,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1453.17896, -1626.89539, 13.32789,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19943, 1505.78821, -1626.81079, 13.32789,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1454.04065, -1620.99023, 23.86958,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1504.67053, -1620.06836, 23.86958,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3462, 1512.58704, -1643.59302, 14.37580,   0.00000, 0.00000, -40.61998);
CreateDynamicObject(3462, 1446.38879, -1637.04968, 14.37580,   0.00000, 0.00000, -137.04001);
CreateDynamicObject(3525, 1467.53503, -1671.32312, 19.34386,   0.00000, 0.00000, -38.76001);
CreateDynamicObject(3525, 1491.33569, -1671.20374, 19.34386,   0.00000, 0.00000, 51.29998);
CreateDynamicObject(3525, 1491.28235, -1660.51465, 19.34386,   0.00000, 0.00000, 136.49997);
CreateDynamicObject(3525, 1467.53821, -1660.75830, 19.34386,   0.00000, 0.00000, 224.69994);
CreateDynamicObject(736, 1496.32568, -1707.93799, 24.58166,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1496.28638, -1687.89709, 24.58166,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1459.42017, -1686.90405, 24.58166,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1459.32031, -1709.30774, 24.58166,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1469.87927, -1631.40027, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1467.67517, -1635.21094, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1466.80554, -1639.58093, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1467.56799, -1643.91895, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1469.78711, -1647.77966, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1473.14929, -1650.62378, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1477.33142, -1652.09375, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1481.75183, -1652.13806, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1485.85571, -1650.63708, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1489.22961, -1647.82153, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1491.39600, -1644.03345, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1492.18140, -1639.70081, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1491.46509, -1635.27307, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1489.22583, -1631.47217, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1485.93115, -1628.66699, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1481.76965, -1627.13171, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1477.31128, -1627.15222, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, 1473.22046, -1628.75830, 14.04844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2639, 1444.62317, -1620.34412, 13.76790,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2639, 1444.58264, -1617.14954, 13.76790,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2639, 1444.58875, -1623.47498, 13.76790,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2639, 1444.61255, -1626.54541, 13.76790,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2639, 1449.61377, -1626.51111, 13.76790,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2639, 1449.62744, -1623.56995, 13.76790,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2639, 1449.56531, -1620.46875, 13.76790,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2639, 1449.52283, -1617.26965, 13.76790,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(715, 1520.67322, -1609.45581, 20.85073,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 1521.92566, -1630.11438, 20.85073,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 1521.64880, -1693.79443, 20.85073,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 1522.05115, -1715.00769, 20.85073,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 1437.52747, -1610.74182, 20.85073,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 1436.67310, -1628.18408, 20.85073,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 1437.47046, -1689.59155, 20.85073,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 1437.25476, -1711.69873, 20.85073,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11691, 1447.16150, -1626.50719, 13.04830,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11691, 1447.14392, -1623.55578, 13.04830,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11691, 1447.08008, -1620.43896, 13.04890,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11691, 1447.07251, -1617.24022, 13.04755,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19617, 1480.58423, -1716.00305, 16.24599,   0.00000, 0.00000, -180.29997);
CreateDynamicObject(19617, 1479.70178, -1715.98572, 16.24599,   0.00000, 0.00000, -180.29997);
CreateDynamicObject(19617, 1478.78052, -1715.98694, 16.24599,   0.00000, 0.00000, -180.29997);
CreateDynamicObject(19617, 1478.80042, -1715.96753, 14.68704,   0.00000, 0.00000, -180.29997);
CreateDynamicObject(19617, 1479.70142, -1715.98572, 14.68901,   0.00000, 0.00000, -180.29997);
CreateDynamicObject(19617, 1480.60461, -1715.98340, 14.67954,   0.00000, 0.00000, -180.29997);

//----T E X T U R A S------------------------------------------------------------------


///////Altar///////////////////////////////////////////////////////////////////////////////////////////////
M1[0] = CreateDynamicObject(18763, 1484.01514, -1665.87537, 13.73325,   0.00000, 0.00000, 0.00000);
M1[1] = CreateDynamicObject(18763, 1478.79199, -1665.80457, 15.17569,   0.00000, 0.00000, 0.00000);
M1[2] = CreateDynamicObject(18763, 1474.25134, -1665.79199, 13.73325,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(M1[TexturizarID], 0, 13813, "vinewood01_lahills", "pavetilealley256128");}

//////AltarActual//////////////////////////////////////////////////////////////////////////////////////////
AltarA[0] = CreateDynamicObject(18765, 1460.04871, -1698.07361, 11.94534,   0.00000, 0.00000, 0.00000);
AltarA[1] = CreateDynamicObject(18765, 1497.04041, -1697.62012, 12.00638,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(AltarA[TexturizarID], 0, 13813, "vinewood01_lahills", "pavetilealley256128");}

//////AltarScripter////////////////////////////////////////////////////////////////////////////////////////
MS[0] = CreateDynamicObject(18763, 1501.83154, -1620.59631, 12.81256,   0.00000, 0.00000, 0.00000);
MS[1] = CreateDynamicObject(18763, 1457.18628, -1620.96350, 12.81256,   0.00000, 0.00000, 0.00000);
MS[2] = CreateDynamicObject(18763, 1479.77356, -1715.35205, 10.56954,   0.00000, 0.00000, 0.00000);
MS[3] = CreateDynamicObject(18763, 1479.75671, -1717.49060, 14.69011,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 4; TexturizarID++){SetDynamicObjectMaterial(MS[TexturizarID], 0, 13813, "vinewood01_lahills", "pavetilealley256128");}


//////Luces///////////////////////////////////////////////////////////////////////////////////////////////
L[0] = CreateDynamicObject(3437, 1510.65063, -1672.89685, 18.75300,   0.00000, 0.00000, 0.00000);
L[1] = CreateDynamicObject(3437, 1510.61584, -1667.12463, 18.75300,   0.00000, 0.00000, 0.00000);
L[2] = CreateDynamicObject(3437, 1450.27112, -1650.34558, 18.27901,   0.00000, 0.00000, 0.00000);
L[3] = CreateDynamicObject(3437, 1450.22998, -1655.87646, 18.27901,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 4; TexturizarID++){SetDynamicObjectMaterial(L[TexturizarID], 0, 10357, "tvtower_sfs", "ws_carshowwin1");}


//ACTORES DE LA VENTA DE AUTOS
CreateActor(171, SALESMAN_ACT, SALESMAN_ANG); 
CreateActor(32,  PURCHASER_ACT, PURCHASER_ANG);

//////Plaza/////////////////////////////////////////////////////////////////////////////////////////////
Plaza[0] = CreateDynamicObject(3985, 1479.56250, -1631.45313, 12.07813,   0.0, 0.00000, 0.0);
Plaza[1] = CreateDynamicObject(4186, 1479.55469, -1693.14063, 19.57813,   0.0, 0.00000, 0.0);

SetDynamicObjectMaterial(Plaza[0], 0, 5743, "lawngrn", "Grass_128HV");
SetDynamicObjectMaterial(Plaza[0], 1, 18202, "w_towncs_t", "hatwall256hi");
SetDynamicObjectMaterial(Plaza[0], 2, 9169, "vgslowbuild", "ws_white_wall1");
SetDynamicObjectMaterial(Plaza[0], 3, 10938, "skyscrap_sfse", "ws_floortiles2");

SetDynamicObjectMaterial(Plaza[1], 0, 5743, "lawngrn", "Grass_128HV");
SetDynamicObjectMaterial(Plaza[1], 1, 18202, "w_towncs_t", "hatwall256hi");
SetDynamicObjectMaterial(Plaza[1], 2, 9169, "vgslowbuild", "ws_white_wall1");
SetDynamicObjectMaterial(Plaza[1], 3, 10938, "skyscrap_sfse", "ws_floortiles2");
SetDynamicObjectMaterial(Plaza[1], 4, 8463, "vgseland", "tiadbuddhagold");

//////GP////////////////////////////////////////////////////////////////////////////////////////////////
GPC[1] = CreateObject(19353, 1479.34473, -1615.00916, 14.6012,   0.00000, 0.00000, 90.12001);
SetObjectMaterialText(GPC[1],"GP",0, 40, "Algerian", 35, 0, -16778888 , 0, 1);
//////Estatua/////////////////////////////////////////////////////////////////////////////////////////
Estatua[1] = CreateDynamicObject(11489, 1479.27539, -1615.98914, 13.04040,   0.00000, 0.00000, 180.00002);

SetDynamicObjectMaterial(Estatua[1], 0, 13813, "vinewood01_lahills", "pavetilealley256128");

/////Actors///////////////////////////////////////////////////////////////////////////////////////////
DarkKiller[1] = CreateActor(240, 1478.7573, -1666.8820, 18.6858, 180);//DARK_KILLER
ApplyActorAnimation(DarkKiller[1],"PED","IDLE_chat", 4.1 , 1 , 0 , 0, 0, 0);

Party[1] = CreateActor(294, 1484.24829, -1666.83752, 17.22054, 180);//Party_Rock
ApplyActorAnimation(Party[1],"GANGS", "Invite_Yes", 4.1 , 1 , 0 , 0, 0, 0);

Frescoleit[1] = CreateActor(186, 1474.39148, -1666.81677, 17.25180, 180);//[KX]Frescoleit..
ApplyActorAnimation(Frescoleit[1],"benchpress","gym_bp_celebrate", 4.1, 1, 0, 0, 0, 0);

Cesar[1] = CreateActor(171, 1464.12793, -1695.31274, 15.49610, 270);//Cesar_Smith
ApplyActorAnimation(Cesar[1],"GANGS", "Invite_Yes", 4.1 , 1 , 0 , 0, 0, 0);


Yack[1] = CreateActor(101, 1464.1571, -1697.5159, 15.4212, 270);//[KX]Yack
ApplyActorAnimation(Yack[1],"GHANDS","gsign1LH", 4.1 , 1 , 0 , 0, 0, 0);


Santiago[1] = CreateActor(167, 1464.16663, -1699.37793, 15.40378, 270);//[KX]Santiago_.
ApplyActorAnimation(Santiago[1],"benchpress","gym_bp_celebrate", 4.1 , 1 , 0 , 0, 0, 0);


Renegado[1] = CreateActor(72, 1464.18213, -1701.18091, 15.41313, 270);//Renegado[GP]
ApplyActorAnimation(Renegado[1],"PED","IDLE_chat", 4.1 , 1, 0 , 0, 0, 0);


Saso[1] = CreateActor(261, 1492.56555, -1694.14709, 15.42221, 90);//[CB]Saso______.
ApplyActorAnimation(Saso[1],"GHANDS","gsign1LH", 4.1 , 1 , 0 , 0, 0, 0);

Blaze[1] = CreateActor(32, 1492.55859, -1696.14368, 15.40860, 90);//BlaZe[X]
ApplyActorAnimation(Blaze[1],"PED","IDLE_chat", 4.1 , 1 , 0 , 0, 0, 0);

Kayn[1] = CreateActor(101, 1492.64893, -1697.94983, 15.4886, 90); //[GP]Kayn
ApplyActorAnimation(Kayn[1],"DANCING","dnce_M_b", 4.1, 1, 0, 0, 0, 0);

ArTema[1] = CreateActor(117, 1492.45105, -1700.18176, 15.48220, 90); //ArTema...
ApplyActorAnimation(ArTema[1], "GANGS", "Invite_Yes", 4.1, 1, 0, 0, 0, 0);

sustancs[1] = CreateActor(170, 1457.52710, -1621.06189, 16.29910, 270); //sustancs[x]
ApplyActorAnimation(sustancs[1],"COP_AMBIENT", "Coplook_loop", 4.1, 1, 0, 0, 0, 0);

pablobl[1] = CreateActor(295, 1501.15149, -1620.54626, 16.30852, 90); //pablobl[X]
ApplyActorAnimation(pablobl[1], "DANCING","dnce_M_b", 4.1, 1, 0, 0, 0, 0);

Anticheat[1] = CreateActor(217, 1510.29578, -1669.97839, 14.03100, 270); //Bot
ApplyActorAnimation(Anticheat[1],"DANCING","dnce_M_d",4.1, 1, 0, 0, 0, 0);

Anticheat[2] = CreateActor(217, 1450.18274, -1653.03833, 14.06167, 90); //Bot 2
ApplyActorAnimation(Anticheat[2],"DANCING","dnce_M_d",4.1, 1, 0, 0, 0, 0);

Ice_Cube[1] = CreateActor(297, 1479.62598, -1715.31580, 14.02043, 0);//IceCube
ApplyActorAnimation(Ice_Cube[1], "RAPPING","RAP_B_Loop", 4.1, 1, 0, 0, 0, 0);

/////TextLabel/////////////////////////////////////////////////////////////////////////////////////
Create3DTextLabel("pablobl[X]\n" "Mapper de GP\n" "Activo", 0xBFB100FF, 1501.11462, -1620.56726, 15.31070, 25.0, 0);
Create3DTextLabel("[x]sustancs\n" "Scripter de GP\n" "Retirado", 0x408080FF, 1457.81763, -1621.03589, 15.44946, 25.0, 0);
Create3DTextLabel("[Og]Ice_Cube\n" "Admin Creador de la intro de GP\n" "Retirado", 0x408080FF, 1479.71509, -1714.19861, 15.87762, 40.0, 0);
Create3DTextLabel("Party_Rock\n" "Admin Reconocido 1era GEN\n" "Retirado", 0xFFFF80FF, 1484.24829, -1666.83752, 17.22054, 25.0, 0);
Create3DTextLabel("Frescoleit...\n" "Admin Reconocido 1era GEN\n" "Retirado", 0xFFFF80FF, 1474.39148, -1666.81677, 17.25180, 25.0, 0);
Create3DTextLabel("DARK_KILLER\n" "Fundador de GP\n" "Retirado", 0xFF0000FF, 1478.7573, -1666.8820, 18.6858, 20.0, 0);
Create3DTextLabel("BlaZe[X]\n" "Actual Owner de GP", 0xBFB100FF, 1492.5586, -1696.1437, 15.4286, 25.0, 0);
Create3DTextLabel("Saso_______[CB]\n" "Ex-Owner de GP", 0x408080FF, 1492.5656, -1694.1471, 15.4822, 25.0, 0);
Create3DTextLabel("]cB[ArTema...\n" "Ex-Owner de GP", 0x408080FF, 1492.4510, -1700.1818, 15.4822, 25.0, 0);
Create3DTextLabel("Kayn[GP]\n" "Ex-Owner de GP\n" "Retirado", 0x408080FF,1492.6489, -1697.9498, 15.4886, 25.0, 0);
Create3DTextLabel("[KX]Yack\n" "Ex-Owner de GP\n" "Activo", 0xBFB100FF,1464.1571, -1697.5159, 15.4212, 25.0, 0);
Create3DTextLabel("[KX]Santiago\n" "Ex-Owner de GP\n" "Activo", 0xBFB100FF,1464.1666, -1699.3779, 15.4038, 25.0, 0);
Create3DTextLabel("Renegado[GP]\n" "Ex-Owner de GP\n" "Retirado", 0x408080FF,1464.1821, -1701.1809, 15.4131, 25.0, 0);
Create3DTextLabel("Cesar_Smith\n" "Ex-Owner de GP\n" "Retirado", 0x408080FF,1464.12793, -1695.31274, 15.49610, 25.0, 0);

Create3DTextLabel("Anti-cheat\n" "Si tienes dudas usa /ayuda", 0xFFFFFFFF,1510.2958, -1669.9784, 14.0310, 25.0, 0);
Create3DTextLabel("Anti-cheat\n" "Recuerda siempre hechar un vistazo a /reglas para evitar problemas", 0xFFFFFFFF,1450.1827, -1653.0383, 14.0617, 25.0, 0);


Create3DTextLabel("::3RA GEN GP::", 0xFF8000FF,1487.89795, -1697.22449, 13.88490, 30.0, 0);
Create3DTextLabel("::2DA GEN GP::", 0xFF8000FF,1468.22766, -1698.29541, 13.88490, 30.0, 0);
/////////////////////////-----------------------------------FIN PLAZA-----------------------------///////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////BASE GROVE///////////////////////////////////////////////////////////////////////////////////////////////
CreateDynamicObject(1225, 2487.44287, -1666.57092, 12.90070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2487.46802, -1667.79858, 12.90070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2487.69336, -1670.94653, 12.90070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2491.14624, -1672.18396, 12.90070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2493.77222, -1667.22900, 12.90070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2493.76855, -1670.56543, 12.90070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2492.54077, -1665.74561, 12.90070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3749, 2424.79321, -1659.08032, 17.90250,   0.00000, 0.00000, 89.63998);
CreateDynamicObject(17969, 2430.08838, -1680.85400, 14.58496,   0.00000, 0.00000, -90.53999);
CreateDynamicObject(18659, 2435.54443, -1680.92566, 15.27376,   0.00000, 0.00000, -89.15999);
CreateDynamicObject(3385, 2438.92505, -1679.20129, 12.76053,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3385, 2426.81812, -1679.12463, 12.76053,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18659, 2422.58447, -1666.28589, 15.66227,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(14467, 2490.66064, -1669.05542, 17.43081,   0.00000, 0.00000, -90.12000);
CreateDynamicObject(18659, 2489.18237, -1668.78674, 14.48785,   0.00000, 0.00000, 0.00000);

///Texturas
RejaGrove[0] = CreateDynamicObject(987, 2423.85913, -1669.64160, 12.60647,   0.00000, 0.00000, 270.00000);
RejaGrove[1] = CreateDynamicObject(987, 2423.93628, -1663.54504, 12.60650,   0.00000, 0.00000, 270.00000);
RejaGrove[2] = CreateDynamicObject(987, 2424.36719, -1642.38123, 12.60650,   0.00000, 0.00000, 270.00000);
RejaGrove[3] = CreateDynamicObject(987, 2424.35034, -1633.41956, 12.60650,   0.00000, 0.00000, 270.00000);
RejaGrove[4] = CreateDynamicObject(987, 2436.22217, -1629.52795, 12.60650,   0.00000, 0.00000, 180.00000);
RejaGrove[5] = CreateDynamicObject(987, 2446.53882, -1629.53088, 13.42999,   0.00000, 0.00000, 180.00000);
RejaGrove[6] = CreateDynamicObject(987, 2424.33911, -1629.42566, 12.60650,   0.00000, 0.00000, 270.00000);
RejaGrove[7] = CreateDynamicObject(987, 2458.49146, -1629.52100, 14.54476,   0.00000, 0.00000, 180.00000);
RejaGrove[8] = CreateDynamicObject(987, 2470.35815, -1629.50952, 15.17528,   0.00000, 0.00000, 180.00000);
RejaGrove[9] = CreateDynamicObject(987, 2482.18213, -1629.51111, 15.31893,   0.00000, 0.00000, 180.00000);
RejaGrove[10] = CreateDynamicObject(987, 2491.26587, -1629.69873, 17.90541,   0.00000, 0.00000, 180.00000);
RejaGrove[11] = CreateDynamicObject(987, 2502.95264, -1629.11609, 16.87216,   0.00000, 0.00000, 180.00000);
RejaGrove[12] = CreateDynamicObject(987, 2498.49072, -1629.74426, 17.90541,   0.00000, 0.00000, 180.00000);
RejaGrove[13] = CreateDynamicObject(987, 2514.73462, -1629.13586, 16.87216,   0.00000, 0.00000, 180.00000);
RejaGrove[14] = CreateDynamicObject(987, 2526.64258, -1629.04675, 16.87216,   0.00000, 0.00000, 180.00000);
RejaGrove[15] = CreateDynamicObject(987, 2538.33813, -1629.18323, 16.87216,   0.00000, 0.00000, 180.00000);
RejaGrove[16] = CreateDynamicObject(987, 2541.39087, -1629.21375, 16.87216,   0.00000, 0.00000, 180.00000);
RejaGrove[17] = CreateDynamicObject(987, 2537.46436, -1722.89526, 12.31821,   0.00000, 0.00000, 180.00000);
RejaGrove[18] = CreateDynamicObject(987, 2525.55591, -1722.80139, 12.31821,   0.00000, 0.00000, 180.00000);
RejaGrove[19] = CreateDynamicObject(987, 2541.09131, -1717.45374, 12.31820,   0.00000, 0.00000, 90.00000);
RejaGrove[20] = CreateDynamicObject(987, 2541.07251, -1705.43262, 12.31820,   0.00000, 0.00000, 90.00000);
RejaGrove[21] = CreateDynamicObject(987, 2541.09253, -1693.45178, 12.31820,   0.00000, 0.00000, 90.00000);
RejaGrove[22] = CreateDynamicObject(987, 2541.04077, -1681.48413, 12.31820,   0.00000, 0.00000, 90.00000);
RejaGrove[23] = CreateDynamicObject(987, 2541.03052, -1669.53320, 12.31820,   0.00000, 0.00000, 90.00000);
RejaGrove[24] = CreateDynamicObject(987, 2540.98755, -1657.59631, 12.31820,   0.00000, 0.00000, 90.00000);
RejaGrove[25] = CreateDynamicObject(987, 2540.97534, -1645.65527, 12.31820,   0.00000, 0.00000, 90.00000);
RejaGrove[26] = CreateDynamicObject(987, 2541.01514, -1722.87219, 12.31821,   0.00000, 0.00000, 180.00000);
RejaGrove[27] = CreateDynamicObject(987, 2540.99268, -1722.83691, 12.31820,   0.00000, 0.00000, 90.00000);
RejaGrove[28] = CreateDynamicObject(987, 2520.69531, -1722.58691, 17.43036,   0.00000, 0.00000, 180.00000);
RejaGrove[29] = CreateDynamicObject(987, 2508.77417, -1722.69543, 17.43036,   0.00000, 0.00000, 180.00000);
RejaGrove[30] = CreateDynamicObject(987, 2496.86353, -1722.52686, 17.43036,   0.00000, 0.00000, 180.00000);
RejaGrove[31] = CreateDynamicObject(987, 2493.95508, -1721.93079, 17.43036,   0.00000, 0.00000, 180.00000);
RejaGrove[32] = CreateDynamicObject(987, 2475.73779, -1721.82532, 13.90621,   0.00000, 0.00000, 180.00000);
RejaGrove[33] = CreateDynamicObject(987, 2463.80469, -1721.73047, 13.90621,   0.00000, 0.00000, 180.00000);
RejaGrove[34] = CreateDynamicObject(987, 2452.09302, -1721.67957, 13.90621,   0.00000, 0.00000, 180.00000);
RejaGrove[35] = CreateDynamicObject(987, 2441.37549, -1722.74341, 13.90621,   0.00000, 0.00000, 81.83997);
RejaGrove[36] = CreateDynamicObject(987, 2443.04297, -1711.32971, 13.90621,   0.00000, 0.00000, 92.75997);
for(new TexturizarID; TexturizarID < 37; TexturizarID++){SetDynamicObjectMaterial(RejaGrove[TexturizarID], 0, 5154, "dkcargoshp_las2", "green_64");}

Piso = CreateDynamicObject(17613, 2489.29688, -1668.50000, 12.29688,   0.0, 0.00000, 0.0);
SetDynamicObjectMaterial(Piso, 1, 12959, "sw_library", "sw_brick05");
SetDynamicObjectMaterial(Piso, 2, 9743, "rock_coastsfw", "pavetilealley256128");

TorreGrove[0] = CreateDynamicObject(3279, 2457.89819, -1678.57019, 12.49598,   0.00000, 0.00000, 0.00000);
TorreGrove[1] = CreateDynamicObject(3279, 2511.64307, -1716.46777, 17.56874,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreGrove[TexturizarID], 0,  6351, "rodeo02_law2", "LAgreenwall"),SetDynamicObjectMaterial(TorreGrove[TexturizarID], 2,  6351, "rodeo02_law2", "LAgreenwall"),SetDynamicObjectMaterial(TorreGrove[TexturizarID], 8,  6351, "rodeo02_law2", "LAgreenwall");}

H = CreateDynamicObject(3934, 2531.84375, -1714.19360, 12.51100,   0.00000, 0.00000, 0.06000);
SetDynamicObjectMaterial(H, 0, 5154, "dkcargoshp_las2", "green_64");

EstatuaG[0] = CreateDynamicObject(18764, 2490.80884, -1668.79944, 11.24260,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(EstatuaG[0], 0, 5154, "dkcargoshp_las2", "green_64");

EstatuaG[1] = CreateDynamicObject(18763, 2490.72314, -1668.78064, 12.91268,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(EstatuaG[1], 0, 1273, "icons3", "greengrad32");

PuertaGrove[0] = CreateDynamicObject(19912, 2424.18970, -1652.25110, 15.21864,   0.00000, 0.00000, 90.00000);
PuertaGrove[1] = CreateDynamicObject(19912, 2487.34180, -1721.88818, 15.18232,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(PuertaGrove[TexturizarID], 0,  5154, "dkcargoshp_las2", "green_64"), SetDynamicObjectMaterial(PuertaGrove[TexturizarID], 2, 5154, "dkcargoshp_las2", "green_64");}

Escalera = CreateDynamicObject(8613, 2523.69336, -1717.33594, 14.12396,   0.00000, 0.00000, -270.36011);
SetDynamicObjectMaterial(Escalera, 1, 6351, "rodeo02_law2", "LAgreenwall");
SetDynamicObjectMaterial(Escalera, 2, 3906, "libertyhi5", "ledgegreen_64H");
//===================================================================================================
Create3DTextLabel("Toca el "greenG"claxón"whiteA" o presiona la tecla "greenG"'H' "whiteA"para abrir la puerta", -1, 2424.30518, -1659.07605, 13.64155, 25.0, 0);
Create3DTextLabel("Toca el "greenG"claxón"whiteA" o presiona la tecla "greenG"'H' "whiteA"para abrir la puerta", -1, 2480.72217, -1722.04016, 14.83893, 25.0, 0);
//-----------------Casa guía en la base groove street-------------------------
Create3DTextLabel("{40FF00}Casa guía\n {FFFFFF}Pulsa "blueSA"'F' {FFFFFF}para entrar.", -1, 1837.0383, -1682.3982, 13.3229, 13.0, 0);
Create3DTextLabel("{40FF00}Casa guía\n {FFFFFF}Pulsa "blueSA"'F' {FFFFFF} para salir.", -1, 756.1611, -16.4897, 1000.5859, 13.0, 3);
//===================textos de ayuda==================================
Create3DTextLabel("{BFFF00}GP: {FFFFFF}Guerra de pandillas es un servidor\n TDM, fundado por {FE2E2E}Dark Killer {FFFFFF}en el año 2011\ncuatro años después {FE2E2E}César Smith {FFFFFF}hizo de GP un servidor totalmente diferente\n conoce más en la plaza de {0080FF}LSPD. ", -1, 754.0984,-26.4103,1000.5905, 5.0, 3);
Create3DTextLabel("{BFFF00}GP: {FFFFFF}Puedes recuperar {FE2E2E}vida{FFFFFF} comprando comida en {0080FF}GP SHOP\n{FFFFFF}las máquinas de sodas regalan {04B431}sprunk\n{FFFFFF}el ícono de {FE2E2E}corazón{FFFFFF} en el radar es especial.", -1, 754.0911, -40.1833, 1000.5905, 5.0, 3);
Create3DTextLabel("{BFFF00}GP: {FFFFFF}¿Haz visto los íconos del mapa en el radar?\n son paquetes de {DBA901}armas{FFFFFF} con munición límitada\npuedes comprar {DBA901}armadura {FFFFFF}en la tienda o ir al ícono de armas(encontrarás chaleco ahí también).", -1, 756.4933, -47.3866, 1000.7802, 5.0, 3);
Create3DTextLabel("{BFFF00}GP: {FFFFFF}Los jugadores con membresía {66FFFF}VIP {FFFFFF}tienen un sinnumero\nde beneficios, entre ellos descuento del {FE2E2E}25% {FFFFFF}de descuento en la tienda(cualquier sección)\n{FE2E2E}¿conoces su base?{FFFFFF} es el ícono de {BF00FF}diamante{FFFFFF} en el radar\n conoce más en /ayuda - vip, /vcmds.", -1, 763.4298, -48.7971, 1000.5859, 5.0, 3);
Create3DTextLabel("{BFFF00}GP: {FFFFFF}No olvides leer las {CC0066}/reglas {FFFFFF}para evitar sanciones\nsi vez a un {FE2E2E}adminitrador {FFFFFF}abusando de su poder puedes repórtarlo en {CC0066}/facebook(privado)\n{FFFFFF}los reportes como post públicos son ignorados.", -1, 774.2713, -49.1636, 1000.5859, 5.0, 3);
Create3DTextLabel("{BFFF00}GP: {FFFFFF}Puedes ganar {04B431}dinero{FFFFFF} matando a los miembros de otro equipo, también\nparticipando en {0080FF}carreras{FFFFFF} y {0080FF}eventos\n{FFFFFF}en paintball obtendrás kills rápido, un tiro, un kill, todos los minijuegos están en {FFBF00}/cmds.", -1, 777.8135,-43.2602,1000.5859, 5.0, 3);
Create3DTextLabel("{BFFF00}GP: {FFFFFF}Por cada {FE2E2E}asesinato{FE2E2E} {FFFFFF}se tu suma {04B431}+250{FFFFFF} al precio de tu cabeza, puedes\nponer {FE2E2E}recompensa{FE2E2E}{FFFFFF} a la cabeza de los demás usando {FE2E2E}/recompensa\n{ffffff}mira la lista de buscados en {FE2E2E}/recompensas.", -1, 777.6804,-37.9257,1000.5927, 5.0, 3);
Create3DTextLabel("{BFFF00}GP: {FFFFFF}Hay más de una {CC0066}zona{FFFFFF} allá a afuera, los {04B431}premios {FFFFFF}por conquista con increíbles\nsi te organizas con tu {F7819F}equipo{ffffff} podrás obtener grandes {FE2E2E}premios{ffffff} por conquistar {F7819F}territorios.", -1, 774.1652, -29.5922, 1000.5927, 5.0, 3);
Create3DTextLabel("{BFFF00}GP: {FFFFFF}Puedes tener tú {0080FF}auto propio{0080FF} {FFFFFF}comprandolo en la conscesionaria de César, en {04B431}San Fierro{04B431}\n{FFFFFF}podrás modificarlo y traerlo a tu posición cuando quieras, {FFBF00}/cmds - sistema de autos", -1, 768.1797, -29.8599, 1000.5859, 5.0, 3);
/////////////////////////////////////////////////////
CreateObject(1253, 754.0984, -26.4103, 1000.5905, 0.0, 0.0, 96.0);
CreateObject(1240, 754.0911, -40.1833, 1000.5905, 0.0, 0.0, 96.0);
CreateObject(1242, 756.4933, -47.3866, 1000.7802, 0.0, 0.0, 96.0);
CreateObject(1276, 763.4298, -48.7971, 1000.5859, 0.0, 0.0, 0);
CreateObject(1314, 774.2713, -49.1636, 1000.5859, 0.0, 0.0, 0);
CreateObject(1550, 777.8135, -43.2602, 1000.5859, 0.0, 0.0, 0);
CreateObject(1279, 777.6804, -37.9257, 1000.5927, 0.0, 0.0, 0);
CreateObject(1274, 774.1652, -29.5922, 1000.5927, 0.0, 0.0, 0);
CreateObject(1210, 768.1797, -29.8599, 1000.5859, 0.0, 0.0, 0);
//Actores en la casa guía
Bleiscg[1] = CreateActor(32,  758.1064, -22.0590, 1000.5859, 12.2753);
ApplyActorAnimation(Bleiscg[1],"ON_LOOKERS","shout_02",4.1, 1, 5, 1, 1, 1);
SetActorVirtualWorld(Bleiscg[1], 3);
Vagabundo[1] = CreateActor(230, 767.9907,-37.4686,1000.6865,358.6503);//actor vagabundo
ApplyActorAnimation(Vagabundo[1], "FIGHT_B", "FightB_1",  4.1, 1, 5, 1, 1, 1);
SetActorVirtualWorld(Vagabundo[1], 3);
Groove[1] = CreateActor(107, 767.7922,-36.5249,1000.6865,176.6019);//actor groove street
ApplyActorAnimation(Groove[1], "FIGHT_D", "FightD_1",  4.1, 1, 5, 1, 1, 1);
SetActorVirtualWorld(Groove[1], 3);
Cescg[1] = CreateActor(171,  763.4722, -50.1834, 1000.5859, 353.5540);
ApplyActorAnimation(Cescg[1],"COP_AMBIENT","Coplook_think",4.1, 1, 5, 1, 1, 1);
SetActorVirtualWorld(Cescg[1], 3);
Fercg[1] = CreateActor(261,  765.1318, -49.7941, 1000.5859, 46.1945);
ApplyActorAnimation(Fercg[1], "RAPPING", "Laugh_01", 4.1, 1, 5, 1, 1, 1);
SetActorVirtualWorld(Fercg[1], 3);
Pablocg[1] = CreateActor(295, 764.6312, -40.9150, 1000.6865, 311.5905);
ApplyActorAnimation(Pablocg[1],"ON_LOOKERS","shout_02",4.1, 1, 5, 1, 1, 1);
SetActorVirtualWorld(Pablocg[1], 3);
Brail[1] = CreateActor(307, 775.1513, -49.7375, 1000.5859, 52.1768);
ApplyActorAnimation(Brail[1], "DANCING","dnce_M_d",4.1, 1, 5, 1, 1, 1);
SetActorVirtualWorld(Brail[1], 3);
//Pickup GP SHOP
//actores de bienvenida tem

Smoke[1] = CreateActor(149, 1835.3773, -1315.5908, 131.7344, 358.6201);
ApplyActorAnimation(Smoke[1], "PED","handscower",4.1, 1, 5, 1, 1, 1);
nVagabundo[1] = CreateActor(212, 1835.4637, -1314.6899, 131.7344, 165.6050);
ApplyActorAnimation(nVagabundo[1], "SHOP", "ROB_Loop_Threat",4.1, 1, 5, 1, 1, 1);

CreateDynamicPickup(1254, 1, 2285.7854, -1681.1276, 14.1323, -1,0); // NewTienda1
CreateDynamicPickup(1254, 1, 1875.1498, -1883.6227, 13.4598, -1,0); // New Tienda2
CreateDynamicPickup(1254, 1, 2033.0740, -1402.9579, 17.2843, -1,0); // New Tienda 3
CreateDynamicPickup(1254, 1, 1257.1116, -1237.0879, 18.1491, -1,0); // New Tienda 4
CreateDynamicPickup(1254, 1, 1489.0989, -1720.3221, 8.2355, -1,0); // New Tienda 5
CreateDynamicPickup(1254, 1, 3249.6118, -1904.9523, 28.2086, -1,0);//new Tienda VIP
//Texto INFO ingreso al lugar donde se compran clanes

Create3DTextLabel("{FFFFFF}Pulsa  "blueSA"'F' {FFFFFF}para ingresar", -1, 461.7018, -1500.7772, 31.0455, 10.0, 0);//entrada
Create3DTextLabel("{FFFFFF}Pulsa  "blueSA"'F' {FFFFFF}para salir", -1, -2168.6575, 642.1989, 1057.5938, 10.0, 1);//salida

//Sanciones
CreateObject(1495, 308.64, 312.20, 1002.29,   0.00, 0.00, 358.93);
//Compra de clanes
CreateObject(1649, -2169.03, 642.17, 1057.91,   0.00, 0.00, 271.26);
//actores de la oficina donde se compran clanes
Empresario[1] = CreateActor(20, -2158.9395, 641.0452, 1057.5938, 95.9299);
SetActorVirtualWorld(Empresario[1], 1);
ApplyActorAnimation(Empresario[1], "PED","null",4.1,7,5,1,1,1);
ApplyActorAnimation(Empresario[1], "PED","IDLE_chat",4.1,7,5,1,1,1);
Create3DTextLabel("{66FF99}Oficina de compra\n{FFFFFF}Usa  "blueSA"/comprarclan {FFFFFF}para comprar un clan", -1, -2158.9395, 641.0452, 1057.5938+1.1, 5.0, 1);
//comprador de oficina
/*SetActorVirtualWorld(CompradorOficina[1], 1);
ApplyActorAnimation(CompradorOficina[1], "PED","null",4.1,7,5,1,1,1);
ApplyActorAnimation(CompradorOficina[1], "PED","IDLE_chat",4.1,7,5,1,1,1);
Create3DTextLabel("{66FF99}Sala de venta\n{FFFFFF}Usa  "blueSA"'Y' {FFFFFF}para vender tu clan", -1, -2166.9524, 645.2972, 1057.5938+1.1, 5.0, 1);*/
////////////////////////////////////////////////////////////////BASE BALLA///////////////////////////////////////////////////////////////////////////////////////////////
CreateDynamicObject(18667, 2217.11768, -1172.35034, 27.64310,   0.00000, 0.00000, 270.06000);
CreateDynamicObject(3014, 2208.22778, -1179.60620, 24.89116,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3796, 2205.68213, -1178.44763, 24.88929,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3796, 2211.30249, -1178.10461, 24.88929,   0.00000, 0.00000, -114.42004);
CreateDynamicObject(3796, 2223.13208, -1177.79480, 24.88929,   0.00000, 0.00000, -47.10005);
CreateDynamicObject(3796, 2229.42651, -1178.06421, 24.88929,   0.00000, 0.00000, -124.74005);
CreateDynamicObject(1575, 2204.94043, -1179.49390, 24.98947,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1575, 2204.68970, -1178.13940, 24.98947,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1575, 2205.27905, -1178.40027, 24.98947,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1575, 2205.63184, -1177.74512, 24.98947,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2044, 2211.45630, -1179.38940, 24.99072,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18963, 2211.28003, -1179.84436, 25.12590,   0.00000, 0.00000, 72.06002);
CreateDynamicObject(362, 2211.25732, -1178.65942, 25.23907,   0.00000, 20.00000, -197.22000);
CreateDynamicObject(1636, 2211.80151, -1177.32385, 25.26610,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2976, 2210.72339, -1177.60022, 24.99089,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2901, 2222.87915, -1178.65723, 24.98993,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2901, 2222.86304, -1177.30786, 24.98993,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 2228.35010, -1179.13037, 25.38572,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 2228.53271, -1178.10339, 25.38572,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 2230.08789, -1178.52136, 25.38572,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 2229.55884, -1177.19690, 25.38572,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3749, 2219.82715, -1144.48962, 29.85083,   0.00000, 0.00000, -17.52000);
CreateDynamicObject(1225, 2217.96216, -1148.92102, 25.16229,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2216.83447, -1148.55151, 25.16229,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2218.15747, -1150.03442, 25.16229,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2217.08789, -1149.92639, 25.16229,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3934, 2192.38794, -1187.48828, 32.52730,   0.00000, 0.00000, 90.00000);


///RejasBallas
RejasBallas[0] = CreateDynamicObject(987, 2212.42017, -1140.80579, 24.63653,   0.00000, 0.00000, 163.74002);
RejasBallas[1] = CreateDynamicObject(987, 2245.34033, -1150.78271, 24.63653,   0.00000, 0.00000, 163.74002);
RejasBallas[2] = CreateDynamicObject(987, 2227.18579, -1192.69482, 32.42197,   0.00000, 0.00000, -18.72000);
RejasBallas[3] = CreateDynamicObject(987, 2221.66895, -1190.69495, 29.56145,   0.00000, 0.00000, -18.72000);
RejasBallas[4] = CreateDynamicObject(987, 2237.22021, -1148.38354, 24.63653,   0.00000, 0.00000, 163.74002);
RejasBallas[5] = CreateDynamicObject(987, 2212.42017, -1140.80579, 24.63653,   0.00000, 0.00000, 163.74002);
RejasBallas[6] = CreateDynamicObject(987, 2245.34033, -1150.78271, 24.63653,   0.00000, 0.00000, 163.74002);
for(new TexturizarID; TexturizarID < 7; TexturizarID++){SetDynamicObjectMaterial(RejasBallas[TexturizarID], 0, 10969, "scum_sfse", "ws_apartmentblue2");}

//Fuente
Fuente = CreateDynamicObject(9833, 2216.85889, -1152.76208, 25.72166,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(Fuente, 0,5729, "melrose19_lawn", "melrpurp2_law");

//Torres
TorreB[0] = CreateDynamicObject(3279, 2239.48047, -1154.18665, 32.52821,   0.00000, 0.00000, 0.00000);
TorreB[1] = CreateDynamicObject(3279, 2205.23804, -1141.53125, 32.52790,   0.00000, 0.00000, 270.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreB[TexturizarID], 0,5729, "melrose19_lawn", "melrpurp2_law"), SetDynamicObjectMaterial(TorreB[TexturizarID], 2,5729, "melrose19_lawn", "melrpurp2_law"), SetDynamicObjectMaterial(TorreB[TexturizarID], 8,5729, "melrose19_lawn", "melrpurp2_law");}

//Concreto
ConcretoB = CreateDynamicObject(18764, 2217.14380, -1174.87817, 27.04250,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(ConcretoB, 0,10969, "scum_sfse", "ws_apartmentblue2");

//Escalera
EscaleraB = CreateDynamicObject(3361, 2232.25708, -1159.80884, 30.61820,   0.00000, 0.00000, 92.40000);
SetDynamicObjectMaterial(EscaleraB, 0, 10969, "scum_sfse", "ws_apartmentblue2");
SetDynamicObjectMaterial(EscaleraB, 1, 10969, "scum_sfse", "ws_apartmentblue2");
SetDynamicObjectMaterial(EscaleraB, 2, 10969, "scum_sfse", "ws_apartmentblue2");
SetDynamicObjectMaterial(EscaleraB, 3, 10969, "scum_sfse", "ws_apartmentblue2");

//PuertaBalla
PuertaBalla = CreateDynamicObject(19912, 2225.61914, -1145.27698, 27.41272,   0.00000, 0.00000, -17.40000);
SetDynamicObjectMaterial(PuertaBalla, 0,10969, "scum_sfse", "ws_apartmentblue2");
SetDynamicObjectMaterial(PuertaBalla, 2,10969, "scum_sfse", "ws_apartmentblue2");

//Text
Create3DTextLabel("Toca el "purpleB"claxón"whiteA" o presiona la tecla "purpleB"'H' "whiteA"para abrir la puerta", -1,  2220.21582, -1143.58496, 26.32172, 30.0, 0);



////////////////////////////////////////////////////////////////BASE VAGOS///////////////////////////////////////////////////////////////////////////////////////////////
CreateDynamicObject(3749, 2835.01587, -1183.38123, 29.17982,   0.00000, 0.00000, 92.52001);
CreateDynamicObject(3934, 2818.17285, -1195.00513, 31.65672,   0.00000, 0.00000, 0.54000);
CreateDynamicObject(1503, 2823.64136, -1164.14380, 31.86319,   0.00000, 0.00000, -91.85999);
CreateDynamicObject(1503, 2823.34619, -1166.73315, 31.86319,   0.00000, 0.00000, -91.85999);
CreateDynamicObject(620, 2798.00366, -1186.41211, 22.56250,   356.85840, 0.00000, -1.39626);
CreateDynamicObject(620, 2798.12866, -1180.00024, 23.64844,   356.85840, 0.00000, -1.39626);
CreateDynamicObject(18665, 2803.08960, -1182.60742, 26.94919,   0.00000, 0.00000, 179.82001);
CreateDynamicObject(1225, 2833.24976, -1234.29163, 23.14261,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2834.16162, -1233.55591, 22.95320,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2834.20190, -1234.83606, 22.94356,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2835.10181, -1234.04749, 22.89932,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2818.43018, -1176.07190, 24.65286,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2817.32568, -1176.05066, 24.65286,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2817.65479, -1177.16345, 24.65286,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2810.26392, -1178.23071, 32.10441,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2819.86133, -1189.16199, 32.06012,   0.00000, 0.00000, 0.00000);

//REJAS
RejaV[0] = CreateDynamicObject(987, 2838.43286, -1215.74316, 22.52658,   0.00000, 0.00000, 97.97996);
RejaV[1] = CreateDynamicObject(987, 2836.95215, -1204.98499, 22.75413,   0.00000, 0.00000, 97.97996);
RejaV[2] = CreateDynamicObject(987, 2834.72192, -1176.01331, 23.75408,   0.00000, 0.00000, 97.97996);
RejaV[3] = CreateDynamicObject(987, 2833.33325, -1166.29065, 23.75408,   0.00000, 0.00000, 97.97996);
RejaV[4] = CreateDynamicObject(987, 2828.27026, -1155.46631, 23.75408,   0.00000, 0.00000, 187.80000);
RejaV[5] = CreateDynamicObject(987, 2816.45679, -1157.07751, 23.75408,   0.00000, 0.00000, 188.87997);
RejaV[6] = CreateDynamicObject(987, 2804.64233, -1158.93433, 23.75408,   0.00000, 0.00000, 188.87997);
RejaV[7] = CreateDynamicObject(987, 2831.85742, -1154.96985, 23.75408,   0.00000, 0.00000, 187.80000);
RejaV[8] = CreateDynamicObject(987, 2840.13745, -1227.62292, 21.60807,   0.00000, 0.00000, 97.97996);
RejaV[9] = CreateDynamicObject(987, 2841.31982, -1238.74573, 21.18953,   0.00000, 0.00000, 97.97996);
RejaV[10] = CreateDynamicObject(987, 2842.99561, -1250.65991, 20.94206,   0.00000, 0.00000, 97.97996);
RejaV[11] = CreateDynamicObject(987, 2844.36963, -1261.16199, 20.47485,   0.00000, 0.00000, 97.97996);
RejaV[12] = CreateDynamicObject(987, 2832.71484, -1262.83142, 20.47485,   0.00000, 0.00000, 8.93995);
RejaV[13] = CreateDynamicObject(987, 2820.94263, -1264.71375, 20.47485,   0.00000, 0.00000, 8.93995);
PuertaRejaV[0] = CreateDynamicObject(19912, 2835.83350, -1189.11377, 26.20540,   0.00000, 0.00000, -85.91997);
SetDynamicObjectMaterial(PuertaRejaV[0], 0, 8538, "vgsrailroad", "concreteyellow256 copy");
SetDynamicObjectMaterial(PuertaRejaV[0], 2, 8538, "vgsrailroad", "concreteyellow256 copy");
for(new TexturizarID; TexturizarID < 14; TexturizarID++){SetDynamicObjectMaterial(RejaV[TexturizarID], 0, 8538, "vgsrailroad", "concreteyellow256 copy");}


//CONCRETO
ConcretoV[0] = CreateDynamicObject(18764, 2800.47925, -1182.60791, 25.71071,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(ConcretoV[0], 0, 8538, "vgsrailroad", "concreteyellow256 copy");

//ESCALERAS
EscaleraV[0] = CreateDynamicObject(3399, 2813.28101, -1189.23279, 29.42037,   0.00000, 0.00000, 0.00002);
EscaleraV[1] = CreateDynamicObject(3399, 2807.65918, -1189.22827, 27.04869,   0.00000, 0.00000, 0.00002);
EscaleraV[2] = CreateDynamicObject(3399, 2816.18188, -1177.46179, 29.42037,   0.00000, 0.00000, -177.35992);
EscaleraV[3] = CreateDynamicObject(3399, 2823.10718, -1177.13794, 26.21308,   0.00000, 0.00000, -177.35992);
for(new TexturizarID; TexturizarID < 4; TexturizarID++){SetDynamicObjectMaterial(EscaleraV[TexturizarID], 0,  8883, "vgsefreight", "frate64_yellow");}

//TORRES
TorreV[0] = CreateDynamicObject(3279, 2834.47070, -1255.45667, 20.98271,   0.00000, 0.00000, 9.60000);
TorreV[1] = CreateDynamicObject(3279, 2819.41724, -1173.04675, 31.66457,   0.00000, 0.00000, -181.67999);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreV[TexturizarID], 0,  8883, "vgsefreight", "frate64_yellow"),SetDynamicObjectMaterial(TorreV[TexturizarID], 2,  8883, "vgsefreight", "frate64_yellow"),SetDynamicObjectMaterial(TorreV[TexturizarID], 8,  8883, "vgsefreight", "frate64_yellow");}

//Text
Create3DTextLabel("Toca el "yellowV"claxón"whiteA" o presiona la tecla "yellowV"'H' "whiteA"para abrir la puerta", -1,  2835.58984, -1185.68860, 24.13769, 30.0, 0);




///////////////////////////////////////////////////////////////BASE AZTECA///////////////////////////////////////////////////////////////////////////////////////////////
//MAP
CreateDynamicObject(3934, 1767.66858, -1874.95911, 29.76086,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18661, 1791.27661, -1906.25610, 15.35390,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3524, 1788.87231, -1905.90234, 12.39290,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3524, 1793.74524, -1906.00696, 12.39290,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(1225, 1810.45996, -1895.83020, 13.07739,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1809.81323, -1896.77136, 13.07739,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1809.32776, -1895.67773, 13.07739,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1810.30603, -1898.00415, 13.07739,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1808.18359, -1898.04871, 13.07739,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1788.10938, -1906.50745, 13.07739,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1787.25439, -1907.32971, 13.07739,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1787.89514, -1907.87317, 13.07739,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1794.31616, -1907.18018, 12.82242,   0.00000, 0.00000, 0.00000);

//REJAS
RejasAztecas[0] = CreateDynamicObject(987, 1799.47693, -1942.47449, 14.72765,   0.00000, 0.00000, 0.00000);
RejasAztecas[1] = CreateDynamicObject(987, 1787.53650, -1942.47656, 14.72765,   0.00000, 0.00000, 0.00000);
RejasAztecas[2] = CreateDynamicObject(987, 1775.59741, -1942.42432, 14.72765,   0.00000, 0.00000, 0.00000);
RejasAztecas[3] = CreateDynamicObject(987, 1775.59741, -1942.42432, 11.81069,   0.00000, 0.00000, 0.00000);
RejasAztecas[4] = CreateDynamicObject(987, 1763.75317, -1942.31323, 12.54332,   0.00000, 0.00000, 0.00000);
RejasAztecas[5] = CreateDynamicObject(987, 1751.77222, -1942.35669, 12.54332,   0.00000, 0.00000, 0.00000);
RejasAztecas[6] = CreateDynamicObject(987, 1811.29138, -1942.60974, 14.72770,   0.00000, 0.00000, 90.00000);
RejasAztecas[7] = CreateDynamicObject(987, 1811.24158, -1930.81299, 14.72770,   0.00000, 0.00000, 90.00000);
RejasAztecas[8] = CreateDynamicObject(987, 1811.23926, -1918.87988, 14.72770,   0.00000, 0.00000, 90.00000);
RejasAztecas[9] = CreateDynamicObject(987, 1811.25024, -1911.50659, 14.72770,   0.00000, 0.00000, 90.00000);
RejasAztecas[10] = CreateDynamicObject(987, 1811.34082, -1907.81067, 14.72770,   0.00000, 0.00000, 90.00000);
RejasAztecas[11] = CreateDynamicObject(987, 1811.65063, -1883.71643, 12.33751,   0.00000, 0.00000, 117.17996);
RejasAztecas[12] = CreateDynamicObject(987, 1811.34082, -1907.81067, 11.67782,   0.00000, 0.00000, 90.00000);
PuertaAzteca[0] = CreateDynamicObject(19912, 1811.75439, -1883.62085, 15.18475,   0.00000, 0.00000, 90.00000);
for(new TexturizarID; TexturizarID < 13; TexturizarID++){SetDynamicObjectMaterial(RejasAztecas[TexturizarID], 0, 5532, "paynspray_lae", "bigblue2");}
SetDynamicObjectMaterial(PuertaAzteca[0], 0, 5532, "paynspray_lae", "bigblue2");

//CONCRETO ENTRADA
concretoE[0] = CreateDynamicObject(18763, 1811.57227, -1885.28430, 21.85425,   90.00000, 0.00000, 0.00000);
concretoE[1] = CreateDynamicObject(18763, 1811.56714, -1890.18604, 21.85425,   90.00000, 0.00000, 0.00000);
concretoE[2] = CreateDynamicObject(18763, 1811.56348, -1894.37769, 21.85425,   90.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(concretoE[TexturizarID], 0, 5532, "paynspray_lae", "bigblue2");}

//CONCRETO AZTECA
concretoA[0] = CreateDynamicObject(18764, 1791.34033, -1908.79492, 14.38190,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(concretoA[0], 0, 5532, "paynspray_lae", "bigblue2");
//CONCRETO HELI
concretoH[0] = CreateDynamicObject(18765, 1767.86011, -1874.92908, 27.26351,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(concretoH[0], 0, 5532, "paynspray_lae", "bigblue2");

//ESCALERAS
EscaleraA[0] = CreateDynamicObject(3361, 1785.02576, -1885.44067, 15.98959,   0.00000, 0.00000, 0.00000);
EscaleraA[1] = CreateDynamicObject(3361, 1788.24707, -1885.42273, 14.19103,   0.00000, 0.00000, 0.00000);
EscaleraA[2] = CreateDynamicObject(3361, 1779.15723, -1885.43164, 19.96338,   0.00000, 0.00000, 0.00000);
EscaleraA[3] = CreateDynamicObject(3361, 1774.29883, -1885.43640, 23.24253,   0.00000, 0.00000, 0.00000);
EscaleraA[4] = CreateDynamicObject(3361, 1769.52209, -1885.50964, 26.40673,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 5; TexturizarID++){SetDynamicObjectMaterial(EscaleraA[TexturizarID], 0, 5532, "paynspray_lae", "bigblue2"),SetDynamicObjectMaterial(EscaleraA[TexturizarID], 1, 5532, "paynspray_lae", "bigblue2"),SetDynamicObjectMaterial(EscaleraA[TexturizarID], 2, 5532, "paynspray_lae", "bigblue2"), SetDynamicObjectMaterial(EscaleraA[TexturizarID], 3, 5532, "paynspray_lae", "bigblue2");}

//Torres
TorreA[0] = CreateDynamicObject(3279, 1806.11182, -1907.06396, 12.17142,   0.00000, 0.00000, 269.22003);
TorreA[1] = CreateDynamicObject(3279, 1742.39880, -1901.95142, 28.91430,   0.00000, 0.00000, 270.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreA[TexturizarID], 0,  5532, "paynspray_lae", "bigblue2"),SetDynamicObjectMaterial(TorreA[TexturizarID], 2,  5532, "paynspray_lae", "bigblue2"),SetDynamicObjectMaterial(TorreA[TexturizarID], 8,  5532, "paynspray_lae", "bigblue2");}

//PILARES
PilarA[0] = CreateDynamicObject(3494, 1811.66565, -1895.66284, 16.39002,   0.00000, 0.00000, 0.00000);
PilarA[1] = CreateDynamicObject(3494, 1811.54321, -1883.80212, 16.39002,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(PilarA[TexturizarID], 0, 5532, "paynspray_lae", "bigblue2");}

//LABEL
Create3DTextLabel("Toca el "blueA"claxón"whiteA" o presiona la tecla "blueA"'H' "whiteA"para abrir la puerta", -1,  1811.63892, -1888.91431, 13.23624, 30.0, 0);


///////////////////////////////////////////////////////////////BASE BIKERS///////////////////////////////////////////////////////////////////////////////////////////////
//MAP
CreateDynamicObject(3524, 1810.76465, -1407.37268, 18.21323,   900.00000, 90.00000, 0.00000);
CreateDynamicObject(3524, 1814.31274, -1407.29346, 18.21320,   900.00000, 270.00000, 0.00000);
CreateDynamicObject(3524, 1807.72656, -1353.72559, 16.78371,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3524, 1807.74841, -1342.01978, 16.78371,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(6865, 1810.37769, -1348.04797, 21.81791,   18.00000, -18.30000, 135.47998);
CreateDynamicObject(16151, 1770.88696, -1376.46619, 15.06416,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(8483, 1766.45959, -1334.06970, 24.29323,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(1114, 1762.63806, -1342.43445, 18.41493,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(1114, 1762.63806, -1342.43445, 17.25896,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(1114, 1762.56250, -1342.49951, 16.22966,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(1114, 1762.58374, -1342.51807, 17.29525,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(1114, 1762.36365, -1342.52893, 18.42910,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(1114, 1763.41626, -1342.39392, 18.41493,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(1114, 1763.64050, -1342.46265, 17.34688,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(1114, 1765.15234, -1342.27271, 18.41493,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(1114, 1765.15234, -1342.27271, 17.27231,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(1114, 1765.32239, -1342.35486, 17.08634,   50.00000, 90.00000, 90.00000);
CreateDynamicObject(1114, 1765.32239, -1342.35486, 17.33429,   -50.00000, 90.00000, 90.00000);
CreateDynamicObject(1114, 1766.97522, -1342.05676, 16.40696,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1114, 1767.01660, -1342.04004, 16.51035,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1114, 1766.97522, -1342.05676, 16.74521,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1114, 1767.01660, -1342.04004, 16.64267,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1114, 1766.83655, -1342.04565, 16.93276,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1114, 1766.83655, -1342.04565, 17.07394,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1114, 1766.97522, -1342.05676, 17.13660,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3934, 1761.74683, -1327.20325, 28.99084,   0.00000, 0.00000, -2.46000);
CreateDynamicObject(1225, 1813.81519, -1383.62537, 14.29478,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1767.50891, -1342.37976, 15.20912,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1768.36560, -1342.83948, 15.20912,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1768.34375, -1342.08118, 15.20912,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1783.10510, -1423.62720, 15.16025,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1781.86780, -1423.48218, 15.16025,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1781.60779, -1424.77832, 15.16025,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3378, 1774.84680, -1411.90222, 14.79244,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2977, 1776.29407, -1421.10889, 15.97230,   0.00000, 0.00000, 59.16000);
CreateDynamicObject(3015, 1776.76917, -1413.00293, 16.05989,   0.00000, 0.00000, 59.10000);
CreateDynamicObject(3014, 1776.23828, -1411.97253, 16.13124,   0.00000, 0.00000, -52.92000);
CreateDynamicObject(964, 1776.63843, -1410.12097, 15.97201,   0.00000, 0.00000, -53.76000);
CreateDynamicObject(19609, 1732.01648, -1385.13318, 12.54105,   0.00000, 0.00000, 139.07999);
CreateDynamicObject(16151, 1744.30261, -1381.30322, 13.47311,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19613, 1730.44482, -1383.49744, 12.53474,   0.00000, 0.00000, 103.02000);
CreateDynamicObject(19317, 1730.16333, -1382.33411, 13.66688,   -14.04000, 70.31995, 79.68002);
CreateDynamicObject(19613, 1729.98694, -1381.20166, 12.53474,   0.00000, 0.00000, 73.02001);
CreateDynamicObject(19317, 1730.36914, -1380.03479, 13.66688,   -14.04000, 70.31995, 53.34000);
CreateDynamicObject(6865, 1725.69348, -1381.39221, 15.54597,   6.42000, -8.88001, 131.33990);
CreateDynamicObject(1805, 1731.04675, -1386.16748, 12.80012,   0.00000, 0.00000, -48.36001);
CreateDynamicObject(14565, 1748.93799, -1379.27466, 17.32716,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2637, 1742.24146, -1385.67139, 13.63361,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2637, 1754.47021, -1385.99634, 14.39139,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2637, 1735.77563, -1386.70801, 12.89819,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1486, 1736.52124, -1386.95374, 13.47163,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1486, 1734.98450, -1386.47363, 13.47163,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1486, 1734.34473, -1384.15588, 12.61969,   -22.20000, -86.70000, 0.00000);
CreateDynamicObject(1486, 1734.71790, -1382.93164, 12.61969,   -22.20000, -86.70000, -128.99998);
CreateDynamicObject(1486, 1735.42322, -1384.71753, 12.61969,   -22.20000, -86.70000, -195.83989);
CreateDynamicObject(1543, 1741.66614, -1385.77490, 14.05927,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 1741.83130, -1385.43103, 14.05927,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 1741.52600, -1385.57605, 14.05927,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 1741.61401, -1385.28589, 14.05927,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 1742.95056, -1385.79248, 14.03452,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1486, 1742.70715, -1385.45715, 14.19904,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19812, 1754.37646, -1386.03601, 15.30621,   0.00000, 0.00000, 197.87987);
CreateDynamicObject(1805, 1756.16150, -1386.11792, 14.35292,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1805, 1752.86926, -1385.95911, 14.35292,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1805, 1743.79028, -1385.91211, 13.45632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1805, 1740.67493, -1385.70789, 13.45632,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1805, 1737.31763, -1386.62817, 12.96869,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1805, 1734.23828, -1386.57947, 12.96869,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2056, 1736.01111, -1380.42468, 15.19157,   0.00000, 0.00000, 0.00000);

//REJAS
RejaBK[0] = CreateDynamicObject(987, 1774.78772, -1425.08435, 14.50115,   0.00000, 0.00000, -59.09999);
RejaBK[1] = CreateDynamicObject(987, 1777.86365, -1430.16614, 12.51301,   0.00000, 0.00000, -59.09999);
RejaBK[2] = CreateDynamicObject(987, 1783.93250, -1440.28320, 12.48965,   0.00000, 0.00000, -14.33998);
RejaBK[3] = CreateDynamicObject(987, 1795.49377, -1443.32727, 12.48965,   0.00000, 0.00000, -14.33998);
RejaBK[4] = CreateDynamicObject(987, 1795.49377, -1443.32727, 17.20184,   0.00000, 0.00000, -14.33998);
RejaBK[5] = CreateDynamicObject(987, 1807.06726, -1446.29272, 17.20184,   0.00000, 0.00000, -14.33998);
RejaBK[6] = CreateDynamicObject(987, 1725.90149, -1375.27100, 12.53293,   0.00000, 0.00000, -91.50002);
RejaBK[7] = CreateDynamicObject(987, 1730.44495, -1390.84583, 14.60486,   0.00000, 0.00000, -49.26001);
RejaBK[8] = CreateDynamicObject(987, 1737.97473, -1400.02673, 14.60486,   0.00000, 0.00000, -49.26001);
RejaBK[9] = CreateDynamicObject(987, 1739.09631, -1342.19434, 14.75143,   0.00000, 0.00000, -179.34007);
for(new TexturizarID; TexturizarID < 10; TexturizarID++){SetDynamicObjectMaterial(RejaBK[TexturizarID], 0,  8883, "vgsefreight", "frate64_yellow");}

//PUERTAS
PuertaBK[0] = CreateDynamicObject(19912, 1807.71960, -1342.01233, 16.95375,   0.00000, 0.00000, 90.00000);
PuertaBK[1] = CreateDynamicObject(19912, 1817.74524, -1407.39233, 15.13323,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(PuertaBK[TexturizarID], 0,  8883, "vgsefreight", "frate64_yellow");}

//TORRES
TorreBK[0] = CreateDynamicObject(3279, 1812.70337, -1334.88403, 28.79634,   0.00000, 0.00000, 180.23999);
TorreBK[1] = CreateDynamicObject(3279, 1808.00671, -1440.77014, 17.82409,   0.00000, 0.00000, 89.88000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreBK[TexturizarID], 0,  8883, "vgsefreight", "frate64_yellow"), SetDynamicObjectMaterial(TorreBK[TexturizarID], 2,  8883, "vgsefreight", "frate64_yellow"), SetDynamicObjectMaterial(TorreBK[TexturizarID], 8,  8883, "vgsefreight", "frate64_yellow");}


//ESCALERAS
EscaleraBK[0] = CreateDynamicObject(3361, 1805.49060, -1435.57056, 14.54515,   0.00000, 0.00000, 182.15988);
EscaleraBK[1] = CreateDynamicObject(3361, 1807.08032, -1435.32117, 15.87799,   0.00000, 0.00000, 182.15988);
EscaleraBK[2] = CreateDynamicObject(3361, 1741.12402, -1343.02185, 16.62004,   0.00000, 0.00000, 180.00000);
EscaleraBK[3] = CreateDynamicObject(3361, 1745.62842, -1342.98779, 19.62338,   0.00000, 0.00000, 180.00000);
EscaleraBK[4] = CreateDynamicObject(3361, 1750.91406, -1343.03076, 23.14097,   0.00000, 0.00000, 180.00000);
EscaleraBK[5] = CreateDynamicObject(3361, 1755.84412, -1342.91907, 26.53195,   0.00000, 0.00000, 180.00000);
for(new TexturizarID; TexturizarID < 6; TexturizarID++){SetDynamicObjectMaterial(EscaleraBK[TexturizarID], 0,  8883, "vgsefreight", "frate64_yellow"), SetDynamicObjectMaterial(EscaleraBK[TexturizarID], 1,  8883, "vgsefreight", "frate64_yellow"), SetDynamicObjectMaterial(EscaleraBK[TexturizarID], 2,  8883, "vgsefreight", "frate64_yellow"), SetDynamicObjectMaterial(EscaleraBK[TexturizarID], 3,  8883, "vgsefreight", "frate64_yellow");}

//TEXTO
Create3DTextLabel("Toca el "orangeB"claxón"whiteA" o presiona la tecla "orangeB"'H' "whiteA"para abrir la puerta", -1, 1807.65759, -1348.21875, 14.83265, 25.0, 0);
Create3DTextLabel("Toca el "orangeB"claxón"whiteA" o presiona la tecla "orangeB"'H' "whiteA"para abrir la puerta", -1, 1812.30530, -1407.36511, 13.04358, 25.0, 0);

///////////////////////////////////////////////////////////////BASE DANANG///////////////////////////////////////////////////////////////////////////////////////////////
CreateDynamicObject(8640, 1213.56702, -1844.30603, 18.31086,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(8640, 1269.56299, -1844.51843, 18.31086,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1568, 1234.50793, -1845.89099, 12.25322,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 1241.12231, -1845.80310, 12.25322,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 1248.11975, -1845.78040, 12.25322,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3471, 1282.38062, -1845.97632, 13.60829,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3471, 1256.70667, -1846.14355, 13.60829,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3471, 1226.06702, -1846.01196, 13.60829,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3471, 1200.82764, -1846.07605, 13.60829,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3533, 1219.51086, -1823.19299, 16.59995,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3533, 1233.92578, -1822.85510, 16.59995,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3533, 1234.22351, -1811.04553, 16.59995,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3533, 1276.04639, -1844.42834, 16.35257,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3533, 1263.47021, -1844.45349, 16.35257,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3533, 1207.54297, -1844.74243, 16.36726,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3533, 1220.03333, -1844.52759, 16.36726,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3528, 1212.37073, -1847.39087, 22.59910,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3528, 1269.30151, -1847.64941, 22.59910,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3528, 1203.34497, -1821.20764, 24.32280,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2098, 1192.43518, -1819.84814, 14.49071,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(339, 1192.14478, -1811.43323, 14.17730,   0.00000, 30.00000, 0.00000);
CreateDynamicObject(339, 1192.69067, -1811.40295, 14.17730,   0.00000, 30.00000, 180.00000);
CreateDynamicObject(2631, 1192.53711, -1813.15356, 12.60620,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3461, 1190.64966, -1812.26331, 12.65623,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3461, 1194.47449, -1812.19922, 12.65623,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3533, 1195.42432, -1811.52490, 12.75982,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3533, 1189.90112, -1811.21350, 12.75982,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3471, 1190.09253, -1816.20081, 13.78920,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3471, 1194.84802, -1816.19983, 13.78920,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3934, 1269.93799, -1804.40979, 12.40114,   0.00000, 0.00000, 0.00000);

//REJAS
RejasDN[0] = CreateDynamicObject(987, 1288.85681, -1785.10657, 12.52946,   0.00000, 0.00000, 180.00000);
RejasDN[1] = CreateDynamicObject(987, 1288.79846, -1796.91858, 12.52950,   0.00000, 0.00000, 90.00000);
RejasDN[2] = CreateDynamicObject(987, 1288.80688, -1808.84167, 12.52950,   0.00000, 0.00000, 90.00000);
RejasDN[3] = CreateDynamicObject(987, 1288.84106, -1820.79102, 12.52950,   0.00000, 0.00000, 90.00000);
RejasDN[4] = CreateDynamicObject(987, 1288.82971, -1832.70483, 12.52950,   0.00000, 0.00000, 90.00000);
RejasDN[5] = CreateDynamicObject(987, 1288.82959, -1844.65662, 12.52950,   0.00000, 0.00000, 90.00000);
RejasDN[6] = CreateDynamicObject(987, 1276.66833, -1844.60522, 12.52950,   0.00000, 0.00000, 0.00000);
RejasDN[7] = CreateDynamicObject(987, 1251.24023, -1844.62219, 12.52950,   0.00000, 0.00000, 0.00000);
RejasDN[8] = CreateDynamicObject(987, 1239.60840, -1844.60852, 12.52950,   0.00000, 0.00000, 0.00000);
RejasDN[9] = CreateDynamicObject(987, 1227.74268, -1844.63696, 12.52950,   0.00000, 0.00000, 0.00000);
RejasDN[10] = CreateDynamicObject(987, 1220.56519, -1844.46387, 12.52950,   0.00000, 0.00000, 0.00000);
RejasDN[11] = CreateDynamicObject(987, 1195.00708, -1844.78320, 12.52950,   0.00000, 0.00000, 0.00000);
RejasDN[12] = CreateDynamicObject(987, 1189.07104, -1844.70081, 12.52950,   0.00000, 0.00000, 0.00000);
RejasDN[13] = CreateDynamicObject(987, 1189.16785, -1832.91284, 12.52950,   0.00000, 0.00000, 270.00000);
RejasDN[14] = CreateDynamicObject(987, 1189.16101, -1820.95251, 12.52950,   0.00000, 0.00000, 270.00000);
RejasDN[15] = CreateDynamicObject(987, 1189.22546, -1809.10962, 12.52950,   0.00000, 0.00000, 270.00000);
for(new TexturizarID; TexturizarID < 16; TexturizarID++){SetDynamicObjectMaterial(RejasDN[TexturizarID], 0, 8463, "vgseland", "triadcarpet2");}

//PUERTAS
PuertasDN[0] = CreateDynamicObject(19912, 1275.68982, -1844.55432, 15.17112,   0.00000, 0.00000, 0.00000);
PuertasDN[1] = CreateDynamicObject(19912, 1219.42822, -1844.73877, 15.21087,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(PuertasDN[TexturizarID], 0, 8463, "vgseland", "triadcarpet2");}

//TORRES
TorresDN[0] = CreateDynamicObject(3279, 1284.51733, -1835.75330, 12.69550,   0.00000, 0.00000, 270.00000);
TorresDN[1] = CreateDynamicObject(3279, 1193.36169, -1839.25708, 12.85210,   0.00000, 0.00000, 90.00000);
TorresDN[2] = CreateDynamicObject(3279, 1283.46570, -1790.74133, 12.54440,   0.00000, 0.00000, 270.00000);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(TorresDN[TexturizarID], 0, 8463, "vgseland", "triadcarpet2"), SetDynamicObjectMaterial(TorresDN[TexturizarID], 2,  8463, "vgseland", "triadcarpet2"), SetDynamicObjectMaterial(TorresDN[TexturizarID], 8,  8463, "vgseland", "triadcarpet2");}

//TEXT
Create3DTextLabel("Toca el "redN"claxón"whiteA" o presiona la tecla "redN"'H' "whiteA"para abrir la puerta", -1,  1270.00305, -1844.74487, 13.13761, 40.0, 0);
Create3DTextLabel("Toca el "redN"claxón"whiteA" o presiona la tecla "redN"'H' "whiteA"para abrir la puerta", -1,  1213.82019, -1844.81482, 13.40973, 40.0, 0);

///////////////////////////////////////////////////////////////BASE VAGABUNDOS///////////////////////////////////////////////////////////////////////////////////////////////
//MAPS
CreateDynamicObject(3722, 2125.85107, -2003.56335, 16.88518,   356.85840, 0.00000, -49.69081);
CreateDynamicObject(3722, 2127.14258, -2000.86755, 22.85905,   356.85840, 0.00000, -49.69081);
CreateDynamicObject(19772, 2113.83203, -2018.54456, 16.59392,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2113.83203, -2018.54456, 15.47551,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2113.83203, -2018.54456, 14.34764,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2113.83203, -2018.54456, 13.16339,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2113.83203, -2018.54456, 17.78978,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2114.19385, -2018.22925, 18.99726,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2113.87695, -2018.62439, 20.22191,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(5291, 2132.71558, -1945.02112, 23.28910,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(5291, 2083.02197, -1944.70471, 23.20235,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1225, 2070.14917, -1933.82617, 12.74927,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2068.89282, -1934.15942, 12.74927,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2069.34229, -1933.04773, 12.74927,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19772, 2083.75757, -1989.98962, 22.68319,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2084.79541, -1991.06470, 22.06323,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2084.79541, -1991.06470, 23.24061,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2083.74097, -1990.00073, 23.81378,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2082.17822, -1989.83301, 21.40295,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2080.61279, -1987.88049, 21.40295,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2081.41626, -1988.98938, 22.32714,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2080.23438, -1986.26794, 22.29333,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2079.68018, -1984.88916, 22.29333,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2080.21045, -1983.53809, 20.33795,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2080.61279, -1987.88049, 22.46680,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2081.41626, -1988.98938, 23.28960,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2080.61279, -1987.88049, 23.67460,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2080.23438, -1986.26794, 23.48225,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2079.68018, -1984.88916, 23.46845,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2080.21045, -1983.53809, 21.53017,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2080.21045, -1983.53809, 22.70690,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2082.17822, -1989.83301, 22.64019,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2086.28027, -1991.20801, 22.06323,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(19772, 2086.13257, -1991.68726, 23.24061,   0.00000, 0.00000, 42.12000);
CreateDynamicObject(3722, 2172.11890, -1937.94373, 14.59480,   356.85840, 0.00000, -54.23765);
CreateDynamicObject(3722, 2166.28076, -1942.25085, 20.79303,   356.85840, 0.00000, -54.23765);
CreateDynamicObject(3722, 2165.71387, -1942.59253, 16.08785,   356.85840, 0.00000, -54.23765);
CreateDynamicObject(3722, 2172.80127, -1937.76025, 20.79303,   356.85840, 0.00000, -54.23765);
CreateDynamicObject(3722, 2121.72803, -2006.00012, 22.85905,   356.85840, 0.00000, -49.69081);
CreateDynamicObject(3722, 2118.73657, -2007.96399, 16.86719,   356.85840, 0.00000, -49.69081);
CreateDynamicObject(3722, 2118.68188, -2007.95959, 22.85905,   356.85840, 0.00000, -49.69081);
CreateDynamicObject(18451, 2059.29028, -1939.78577, 12.97602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3110, 2201.64478, -1904.97095, 16.87998,   0.00000, 0.00000, 201.25996);
CreateDynamicObject(2064, 2198.19141, -1905.36401, 20.31356,   0.00000, 0.00000, 178.43994);
CreateDynamicObject(2064, 2199.92261, -1905.52844, 20.31356,   0.00000, 0.00000, 178.43994);
CreateDynamicObject(18250, 2187.99756, -1998.49451, 18.87275,   0.00000, 0.00000, -91.26005);
CreateDynamicObject(16446, 2196.94189, -2018.21533, 17.68844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2639, 2200.35864, -1999.18604, 13.25886,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(13591, 2108.76050, -2000.83765, 12.90423,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(13590, 2126.53516, -1989.05530, 13.80220,   0.00000, 0.00000, 71.16000);
CreateDynamicObject(18862, 2138.41968, -1993.64465, 14.67060,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1327, 2197.67114, -1996.38245, 12.29521,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(2639, 2200.37305, -1997.12073, 13.25886,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2908, 2196.97705, -2018.99915, 19.99864,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1025, 2196.46729, -2018.26111, 20.26532,   164.64043, -306.29929, 1.92000);
CreateDynamicObject(18862, 2197.66846, -2018.64526, 13.75496,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19903, 2171.51221, -1965.45032, 13.04759,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19903, 2172.86890, -1966.81653, 13.04759,   0.00000, 0.00000, 59.09999);
CreateDynamicObject(929, 2169.23340, -1965.72180, 14.01587,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3593, 2182.77222, -1963.89990, 13.40711,   0.00000, 0.00000, 21.24000);
CreateDynamicObject(3593, 2179.00659, -1957.70239, 12.88483,   0.00000, 0.00000, -70.56001);
CreateDynamicObject(19917, 2179.58301, -1963.09497, 13.01137,   0.00000, 0.00000, 37.86000);
CreateDynamicObject(5822, 2148.40210, -1967.40417, 14.04749,   0.00000, 0.00000, 183.17996);
CreateDynamicObject(5822, 2119.88379, -1957.59204, 23.98906,   0.00000, 0.00000, 455.87997);
CreateDynamicObject(19772, 2125.02905, -1950.15002, 29.85820,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19772, 2127.12207, -1950.36914, 29.85820,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19772, 2126.08594, -1950.22083, 29.85820,   0.00000, 0.00000, 0.00000);

//REJAS
RejaVG1[0] = CreateDynamicObject(19913, 2085.06689, -1989.19397, 15.59561,   0.00000, 0.00000, -46.55998);
RejaVG1[1] = CreateDynamicObject(19913, 2103.40796, -2008.48376, 15.59561,   0.00000, 0.00000, -46.55998);
RejaVG1[2] = CreateDynamicObject(19913, 2067.77734, -1965.73865, -3.83528,   0.00000, 90.00000, -88.61998);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(RejaVG1[TexturizarID], 0, 10926, "shops_sfse", "ws_fancywallpink");}

RejaVG2[0] = CreateDynamicObject(974, 2183.57593, -1930.72656, 17.16396,   0.00000, 0.00000, 55.91999);
RejaVG2[1] = CreateDynamicObject(974, 2187.30127, -1925.22815, 17.16396,   0.00000, 0.00000, 55.91999);
RejaVG2[2] = CreateDynamicObject(974, 2190.21655, -1919.35181, 17.16396,   0.00000, 0.00000, 71.46000);
RejaVG2[3] = CreateDynamicObject(974, 2192.40869, -1913.01367, 17.16396,   0.00000, 0.00000, 71.46000);
RejaVG2[4] = CreateDynamicObject(974, 2194.01587, -1908.19336, 17.16396,   0.00000, 0.00000, 71.46000);
for(new TexturizarID; TexturizarID < 5; TexturizarID++){SetDynamicObjectMaterial(RejaVG2[TexturizarID], 0, 10926, "shops_sfse", "ws_fancywallpink"), SetDynamicObjectMaterial(RejaVG2[TexturizarID], 1, 18364, "cs_scrapyard", "Was_scrpyd_bale_exh");}

RejaVG3[0] = CreateDynamicObject(987, 2211.22119, -2022.36243, 14.59481,   0.00000, 0.00000, 113.04002);
RejaVG3[1] = CreateDynamicObject(987, 2208.28101, -2015.02966, 14.59481,   0.00000, 0.00000, 113.04002);
RejaVG3[2] = CreateDynamicObject(987, 2206.42212, -2033.45349, 14.59481,   0.00000, 0.00000, 68.04001);
RejaVG3[3] = CreateDynamicObject(987, 2196.50415, -2044.13220, 12.33886,   0.00000, 0.00000, 404.03989);
RejaVG3[4] = CreateDynamicObject(987, 2192.21191, -2048.33252, 12.33886,   0.00000, 0.00000, 404.03989);
RejaVG3[5] = CreateDynamicObject(987, 2203.74170, -2003.97498, 14.59481,   0.00000, 0.00000, 90.24000);
RejaVG3[6] = CreateDynamicObject(987, 2203.74438, -1994.03723, 14.59481,   0.00000, 0.00000, 90.24000);
RejaVG3[7] = CreateDynamicObject(987, 2203.88501, -1971.56653, 14.59481,   0.00000, 0.00000, 90.24000);
RejaVG3[8] = CreateDynamicObject(987, 2202.80884, -1961.09619, 14.59481,   0.00000, 0.00000, 86.87998);
RejaVG3[9] = CreateDynamicObject(987, 2203.50122, -1949.13501, 14.59481,   0.00000, 0.00000, 86.87998);
RejaVG3[10] = CreateDynamicObject(987, 2204.05908, -1938.62756, 14.59481,   0.00000, 0.00000, 83.99998);
RejaVG3[11] = CreateDynamicObject(987, 2205.27832, -1928.10425, 14.59481,   0.00000, 0.00000, 83.99998);
RejaVG3[12] = CreateDynamicObject(987, 2206.53760, -1916.47754, 14.59481,   0.00000, 0.00000, 83.99998);
for(new TexturizarID; TexturizarID < 13; TexturizarID++){SetDynamicObjectMaterial(RejaVG3[TexturizarID], 0, 18364, "cs_scrapyard", "Was_scrpyd_bale_exh");}


//Concreto
ConcretoVG[0] = CreateDynamicObject(18763, 2203.33008, -1970.42285, 17.45021,   0.00000, 0.00000, 0.00000);
ConcretoVG[1] = CreateDynamicObject(18763, 2203.33008, -1970.42285, 12.54816,   0.00000, 0.00000, 0.00000);
ConcretoVG[2] = CreateDynamicObject(18763, 2203.72949, -1982.93262, 12.54816,   0.00000, 0.00000, 0.00000);
ConcretoVG[3] = CreateDynamicObject(18763, 2203.72949, -1982.93262, 17.51912,   0.00000, 0.00000, 0.00000);
ConcretoVG[4] = CreateDynamicObject(18862, 2111.22607, -1940.39636, 13.89524,   0.00000, 0.00000, 0.00000);
ConcretoVG[5] = CreateDynamicObject(18862, 2107.33252, -1940.55212, 13.89524,   0.00000, 0.00000, 0.00000);
ConcretoVG[6] = CreateDynamicObject(18862, 2102.37036, -1939.02075, 13.89524,   0.00000, 0.00000, 0.00000);
ConcretoVG[7] = CreateDynamicObject(18862, 2086.42188, -1939.36499, 16.18821,   0.00000, 0.00000, 0.00000);
ConcretoVG[8] = CreateDynamicObject(18862, 2074.17969, -1941.91663, 16.18821,   0.00000, 0.00000, 0.00000);
ConcretoVG[9] = CreateDynamicObject(18862, 2065.08008, -1943.63916, 16.18821,   0.00000, 0.00000, 0.00000);
ConcretoVG[10] = CreateDynamicObject(18862, 2058.12964, -1944.95398, 16.18821,   0.00000, 0.00000, 0.00000);
ConcretoVG[11] = CreateDynamicObject(18762, 2195.54297, -1905.44373, 14.58208,   0.00000, 0.00000, 0.00000);
ConcretoVG[12] = CreateDynamicObject(18762, 2195.54688, -1905.50354, 17.10405,   0.00000, 0.00000, 0.00000);
ConcretoVG[13] = CreateDynamicObject(18762, 2207.16577, -1905.35303, 14.42436,   0.00000, 0.00000, 0.00000);
ConcretoVG[14] = CreateDynamicObject(18762, 2207.18506, -1905.56079, 17.13159,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 15; TexturizarID++){SetDynamicObjectMaterial(ConcretoVG[TexturizarID], 0, 18364, "cs_scrapyard", "Was_scrpyd_bale_exh");}

//TORRES
TorreVG[0] = CreateDynamicObject(3279, 2072.75317, -1962.74622, 12.56473,   0.00000, 0.00000, 0.00000);
TorreVG[1] = CreateDynamicObject(3279, 2198.82715, -1965.49573, 13.04192,   0.00000, 0.00000, -90.00005);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreVG[TexturizarID], 0, 16051, "oldwest", "ws_corr_metal1"), SetDynamicObjectMaterial(TorreVG[TexturizarID], 2,  16051, "oldwest", "ws_corr_metal1"), SetDynamicObjectMaterial(TorreVG[TexturizarID], 8,  16051, "oldwest", "ws_corr_metal1");}

//PISO
PisoVG[0] = CreateDynamicObject(19376, 2124.21558, -1949.72327, 29.21406,   0.00000, 90.00000, 0.00000);
SetDynamicObjectMaterial(PisoVG[0], 0, 18364, "cs_scrapyard", "Was_scrpyd_bale_exh");

//PUERTAS
PuertasVG[0] = CreateDynamicObject(19912, 2207.15649, -1905.31702, 15.55213,   0.00000, 0.00000, 0.00000);
PuertasVG[1] = CreateDynamicObject(19912, 2204.15210, -1971.32007, 15.55590,   0.00000, 0.00000, 90.00000);
PuertasVG[2] = CreateDynamicObject(19912, 2067.63867, -1948.73816, 15.31451,   0.00000, 0.00000, 90.00000);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(PuertasVG[TexturizarID], 0, 18364, "cs_scrapyard", "Was_scrpyd_bale_exh");}

//TEXT
Create3DTextLabel("Toca el "pinkV"claxón"whiteA" o presiona la tecla "pinkV"'H'"whiteA" para abrir la puerta", -1,  2200.55981, -1905.49451, 14.03372, 40.0, 0);
Create3DTextLabel("Toca el "pinkV"claxón"whiteA" o presiona la tecla "pinkV"'H'"whiteA" para abrir la puerta", -1,  2204.15674, -1976.65198, 14.43433, 40.0, 0);
Create3DTextLabel("Toca el "pinkV"claxón"whiteA" o presiona la tecla "pinkV"'H'"whiteA" para abrir la puerta", -1,  2067.63916, -1955.83813, 13.51761, 40.0, 0);


///////////////////////////////////////////////////////////////BASE POLICIA///////////////////////////////////////////////////////////////////////////////////////////////
//MAP
CreateDynamicObject(3934, 1563.51758, -1652.46436, 27.39025,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19143, 1541.19055, -1620.21301, 19.16559,   0.00000, 0.00000, 111.53999);
CreateDynamicObject(19143, 1541.21924, -1627.56421, 19.16559,   0.00000, 0.00000, 89.64001);
CreateDynamicObject(19143, 1541.25281, -1635.57544, 19.16559,   0.00000, 0.00000, 58.62001);
CreateDynamicObject(19834, 1539.50330, -1624.00623, 12.38900,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(19834, 1539.50696, -1626.32568, 12.38900,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(19834, 1539.49451, -1628.65613, 12.38900,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(19834, 1539.48596, -1630.97974, 12.38900,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(19834, 1539.49207, -1633.32104, 12.38900,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(18646, 1581.70239, -1632.81299, 16.50870,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(18646, 1580.61523, -1632.76929, 16.50870,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(18646, 1579.77161, -1632.75635, 16.50870,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(19893, 1579.58118, -1633.64233, 13.66023,   0.00000, 0.00000, 33.84000);
CreateDynamicObject(19893, 1580.17468, -1633.58118, 13.66023,   0.00000, 0.00000, -16.02001);
CreateDynamicObject(1491, 1577.35645, -1635.81653, 12.55491,   0.00000, 0.00000, 269.64020);
CreateDynamicObject(11725, 1579.23962, -1633.27075, 12.78462,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1580.01648, -1633.34119, 12.86332,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1581.15784, -1633.35254, 12.86697,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1550.59949, -1620.82056, 13.04512,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1551.24902, -1621.36633, 13.04512,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1551.93628, -1620.08691, 13.04512,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1552.43835, -1621.32166, 13.04512,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1546.79492, -1634.48767, 13.08242,   0.00000, 0.00000, 0.00000);

//REJAS
RejaP[0] = CreateDynamicObject(987, 1539.84021, -1606.00757, 15.69560,   0.00000, 0.00000, 270.00000);
RejaP[1] = CreateDynamicObject(987, 1539.77332, -1602.63171, 15.69560,   0.00000, 0.00000, 270.00000);
RejaP[2] = CreateDynamicObject(987, 1551.41565, -1602.61450, 15.69560,   0.00000, 0.00000, 180.00000);
RejaP[3] = CreateDynamicObject(987, 1563.12756, -1602.61646, 15.69560,   0.00000, 0.00000, 180.00000);
RejaP[4] = CreateDynamicObject(987, 1575.06726, -1602.59290, 15.69560,   0.00000, 0.00000, 180.00000);
RejaP[5] = CreateDynamicObject(987, 1587.04614, -1602.60669, 15.69560,   0.00000, 0.00000, 180.00000);
RejaP[6] = CreateDynamicObject(987, 1599.00476, -1602.61438, 15.69560,   0.00000, 0.00000, 180.00000);
RejaP[7] = CreateDynamicObject(987, 1607.93542, -1602.57886, 15.69560,   0.00000, 0.00000, 180.00000);
RejaP[8] = CreateDynamicObject(987, 1607.76038, -1614.34790, 15.69560,   0.00000, 0.00000, 90.00000);
RejaP[9] = CreateDynamicObject(987, 1607.68445, -1626.06335, 15.69560,   0.00000, 0.00000, 90.00000);
RejaP[10] = CreateDynamicObject(987, 1607.68628, -1637.71985, 15.69560,   0.00000, 0.00000, 90.00000);
RejaP[11] = CreateDynamicObject(987, 1596.27368, -1637.71741, 15.69560,   0.00000, 0.00000, 0.00000);
RejaP[12] = CreateDynamicObject(987, 1539.66150, -1617.62146, 15.69560,   0.00000, 0.00000, 0.00000);
PuertaP[0] = CreateDynamicObject(19912, 1542.83459, -1621.96863, 15.20534,   0.00000, 0.00000, 90.00000);
for(new TexturizarID; TexturizarID < 13; TexturizarID++){SetDynamicObjectMaterial(RejaP[TexturizarID], 0, 9098, "vgesvhouse01", "ws_garagedoor2_blue");}
SetDynamicObjectMaterial(PuertaP[0], 0, 9098, "vgesvhouse01", "ws_garagedoor2_blue");

//ENTRADA
EntradaP[0] = CreateDynamicObject(3749, 1543.81421, -1627.75867, 18.36817,   0.00000, 0.00000, 90.00000);
SetDynamicObjectMaterial(EntradaP[0], 0, 9098, "vgesvhouse01", "ws_garagedoor2_blue");
SetDynamicObjectMaterial(EntradaP[0], 2, 9098, "vgesvhouse01", "ws_garagedoor2_blue");
SetDynamicObjectMaterial(EntradaP[0], 3, 9098, "vgesvhouse01", "ws_garagedoor2_blue");
SetDynamicObjectMaterial(EntradaP[0], 1, 9106, "vgeamun", "blueroof_64");

//TORRE
TorreP[0] = CreateDynamicObject(3279, 1545.42468, -1609.03186, 12.28544,   0.00000, 0.00000, -1.26000);
SetDynamicObjectMaterial(TorreP[0], 0, 9098, "vgesvhouse01", "ws_garagedoor2_blue");
SetDynamicObjectMaterial(TorreP[0], 2,  9098, "vgesvhouse01", "ws_garagedoor2_blue");
SetDynamicObjectMaterial(TorreP[0], 8,  9098, "vgesvhouse01", "ws_garagedoor2_blue");

//ESCALERAS
EscaleraP[0] = CreateDynamicObject(3361, 1552.50623, -1636.09436, 14.34490,   0.00000, 0.00000, 180.00000);
EscaleraP[1] = CreateDynamicObject(3361, 1558.17224, -1636.13977, 18.14490,   0.00000, 0.00000, 180.00000);
EscaleraP[2] = CreateDynamicObject(3361, 1564.19287, -1636.14099, 21.96349,   0.00000, 0.00000, 180.00000);
EscaleraP[3] = CreateDynamicObject(3361, 1569.12195, -1636.09485, 25.32131,   0.00000, 0.00000, 180.00000);
for(new TexturizarID; TexturizarID < 4; TexturizarID++){SetDynamicObjectMaterial(EscaleraP[TexturizarID], 0, 9098, "vgesvhouse01", "ws_garagedoor2_blue"), SetDynamicObjectMaterial(EscaleraP[TexturizarID], 1, 9098, "vgesvhouse01", "ws_garagedoor2_blue"), SetDynamicObjectMaterial(EscaleraP[TexturizarID], 2, 9098, "vgesvhouse01", "ws_garagedoor2_blue"), SetDynamicObjectMaterial(EscaleraP[TexturizarID], 3, 9098, "vgesvhouse01", "ws_garagedoor2_blue");}

//TEXT
Create3DTextLabel("Toca el "blueP"claxón"whiteA" o presiona la tecla "blueP"'H' "whiteA"para abrir la puerta", -1,  1542.67883, -1628.67322, 13.37236, 30.0, 0);

///////////////////////////////////////////////////////////////BASE CIA///////////////////////////////////////////////////////////////////////////////////////////////
//MAP
CreateDynamicObject(2921, 1291.24060, -2051.99194, 61.43643,   0.00000, 0.00000, -186.17993);
CreateDynamicObject(1491, 1153.31543, -2048.50439, 68.07211,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1491, 1157.22510, -2048.51416, 68.07211,   0.00000, 0.00000, 178.19997);
CreateDynamicObject(3440, 1155.41492, -2048.57593, 68.23609,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3440, 1155.09424, -2048.55981, 68.23609,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2921, 1152.99573, -2047.91357, 70.75170,   0.00000, 0.00000, -102.36000);
CreateDynamicObject(3273, 1155.68054, -2064.83862, 65.70354,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3384, 1157.00366, -2062.30444, 68.57059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19903, 1153.85120, -2062.00293, 67.77478,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2976, 1156.51343, -2064.02563, 69.35290,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(2976, 1155.66577, -2064.02686, 69.35290,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(2976, 1154.82288, -2064.06323, 69.35290,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(18647, 1155.70386, -2064.02515, 68.54670,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3384, 1157.06787, -2063.34473, 68.57059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19917, 1154.00928, -2062.92773, 67.91125,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19917, 1154.00476, -2063.95215, 67.91125,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16782, 1160.98596, -2054.90503, 71.17670,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3277, 1115.97119, -2069.69019, 80.75623,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3277, 1116.22534, -2003.78589, 80.65000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2921, 1125.76990, -2032.22217, 73.43089,   0.00000, 0.00000, 185.16002);
CreateDynamicObject(3397, 1149.79529, -2051.71606, 68.04930,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3396, 1160.73010, -2059.26465, 68.04292,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3387, 1149.58374, -2049.33765, 68.04705,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3383, 1151.14160, -2059.91895, 68.00024,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1682, 1156.65015, -2053.32910, 79.34676,   0.00000, 0.00000, -60.36000);
CreateDynamicObject(2894, 1152.39160, -2059.65845, 69.05416,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(9819, 1159.96521, -2053.07349, 68.97356,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(9822, 1158.42249, -2053.55396, 68.74521,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3386, 1157.88391, -2048.42847, 68.06107,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19808, 1157.85657, -2048.98438, 69.24937,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2922, 1157.42358, -2047.76465, 69.61422,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2922, 1122.33093, -2039.58154, 70.67336,   0.00000, 0.00000, -88.97997);
CreateDynamicObject(19164, 1154.89966, -2054.63403, 68.74714,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(19515, 1147.47131, -2055.04443, 69.03033,   0.00000, 270.00000, 270.00000);
CreateDynamicObject(19141, 1147.40161, -2055.04419, 69.51160,   0.00000, 270.00000, 270.00000);
CreateDynamicObject(19036, 1147.56335, -2055.04663, 69.42464,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18637, 1147.44336, -2055.79810, 69.18020,   90.00000, 90.00000, 0.00000);
CreateDynamicObject(370, 1147.40820, -2055.03076, 69.21680,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(362, 1147.21057, -2054.53296, 69.33781,   0.00000, 30.00000, 0.00000);
CreateDynamicObject(19466, 1149.15308, -2055.00439, 68.72913,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(363, 1147.40332, -2055.28491, 69.26373,   0.00000, 0.00000, 91.44000);
CreateDynamicObject(14775, 1149.37000, -2056.43335, 70.14584,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(14775, 1149.27185, -2053.42920, 70.14584,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19466, 1149.15308, -2055.00439, 70.62365,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1147.54126, -2054.41211, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1147.54053, -2054.95264, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1147.54333, -2055.42480, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1147.55359, -2055.97363, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1147.54602, -2053.87769, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1147.54492, -2056.51563, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1146.57874, -2054.40967, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1146.57556, -2053.85889, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1146.58447, -2054.94995, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1146.59106, -2055.49048, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1146.57861, -2056.03101, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(14775, 1146.56714, -2056.53149, 68.00700,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(3385, 1150.39026, -2055.87549, 68.07456,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3385, 1150.35693, -2054.05200, 68.07456,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19903, 1149.43652, -2056.35254, 68.07372,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3267, 1116.06592, -2069.58569, 80.75072,   0.00000, 0.00000, -80.52000);
CreateDynamicObject(3267, 1116.44641, -2003.55701, 80.75072,   0.00000, 0.00000, -104.57999);
CreateDynamicObject(18846, 1117.63049, -2036.96277, 76.28916,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16663, 1152.32397, -2019.20557, 72.27299,   0.00000, 0.00000, -135.17996);
CreateDynamicObject(18846, 1152.15161, -2016.60388, 69.17647,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1697, 1158.56116, -2018.04187, 76.84835,   0.00000, 0.00000, -91.08001);
CreateDynamicObject(1697, 1145.23206, -2018.13647, 76.84835,   0.00000, 0.00000, -270.95969);
CreateDynamicObject(3385, 1150.36743, -2016.17651, 70.80752,   -68.10004, 128.45998, 0.00000);
CreateDynamicObject(3385, 1154.20691, -2017.06873, 70.88278,   41.64000, -71.46001, 0.00000);
CreateDynamicObject(2921, 1208.81885, -2012.46753, 73.58913,   0.00000, 0.00000, -125.94001);
CreateDynamicObject(2921, 1129.54053, -2086.38574, 72.01546,   0.00000, 0.00000, 192.42000);
CreateDynamicObject(1491, 1167.42786, -2025.39026, 68.02341,   0.00000, 0.00000, 89.45998);
CreateDynamicObject(2921, 1167.48682, -2023.18518, 70.12312,   0.00000, 0.00000, -190.08006);
CreateDynamicObject(2922, 1167.50391, -2025.62292, 69.43721,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2985, 1122.12085, -2036.87866, 74.51820,   0.00000, 170.00000, 180.00000);
CreateDynamicObject(16782, 1167.04919, -2020.34485, 71.22581,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3397, 1138.23962, -2025.34985, 67.91624,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3397, 1138.30090, -2021.55298, 67.99554,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3396, 1138.24817, -2017.55493, 67.99657,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3384, 1141.26270, -2008.69019, 69.19390,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3384, 1142.36694, -2008.66687, 69.19390,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3386, 1143.54944, -2008.42786, 68.00940,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(16322, 1161.29492, -2008.97278, 71.89260,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(929, 1149.29614, -2010.04016, 68.85306,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(929, 1151.22717, -2010.09412, 68.85306,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3394, 1138.24683, -2013.68164, 68.03455,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(19903, 1155.31616, -2019.02612, 67.97733,   0.00000, 0.00000, -64.55995);
CreateDynamicObject(339, 1167.06030, -2011.83386, 68.75750,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(18648, 1167.04028, -2010.75500, 68.67216,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3012, 1166.59436, -2013.83569, 68.28889,   -7.92000, -22.92000, 98.70000);
CreateDynamicObject(957, 1166.93347, -2014.12537, 68.77328,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2976, 1166.98694, -2016.99707, 68.64271,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(2034, 1167.03625, -2017.13110, 68.57101,   90.00000, 90.00000, 0.00000);
CreateDynamicObject(958, 1158.07068, -2008.59766, 68.86845,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(958, 1160.85400, -2008.58557, 68.86845,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2750, 1166.71509, -2020.28345, 68.39817,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2238, 1166.70544, -2020.76648, 68.65820,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(2610, 1142.73022, -2027.41748, 68.87150,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2610, 1142.22449, -2027.41870, 68.87150,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2610, 1141.72974, -2027.43884, 68.87150,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2610, 1141.24866, -2027.41357, 68.87150,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2610, 1140.74817, -2027.40796, 68.87150,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2610, 1140.26794, -2027.38245, 68.87150,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2606, 1161.09949, -2051.78442, 71.31993,   10.00000, 0.00000, 270.00000);
CreateDynamicObject(2606, 1161.09949, -2051.78442, 71.85822,   10.00000, 0.00000, 270.00000);
CreateDynamicObject(2606, 1161.09949, -2051.78442, 72.37390,   10.00000, 0.00000, 270.00000);
CreateDynamicObject(2606, 1160.99915, -2058.15991, 71.31993,   10.00000, 0.00000, 270.00000);
CreateDynamicObject(2606, 1160.99915, -2058.15991, 71.79646,   10.00000, 0.00000, 270.00000);
CreateDynamicObject(2606, 1160.99915, -2058.15991, 72.29316,   10.00000, 0.00000, 270.00000);
CreateDynamicObject(19966, 1311.95520, -2062.16406, 57.14241,   0.00000, 0.00000, 106.14000);
CreateDynamicObject(19967, 1326.84338, -2051.30786, 56.70045,   0.00000, 0.00000, 88.98000);
CreateDynamicObject(19950, 1347.98462, -2060.30298, 56.03263,   0.00000, 0.00000, 97.56001);
CreateDynamicObject(3934, 1115.56104, -2019.99219, 73.42100,   0.00000, 0.00000, 0.00000);

//REJAS
RejaCIA[0] = CreateDynamicObject(987, 1123.44214, -1993.43665, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[1] = CreateDynamicObject(987, 1135.40344, -1993.44727, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[2] = CreateDynamicObject(987, 1147.28296, -1993.51990, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[3] = CreateDynamicObject(987, 1159.15125, -1993.59314, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[4] = CreateDynamicObject(987, 1170.97778, -1993.60291, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[5] = CreateDynamicObject(987, 1182.96191, -1993.61646, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[6] = CreateDynamicObject(987, 1194.68726, -1993.55737, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[7] = CreateDynamicObject(987, 1206.35095, -1993.57275, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[8] = CreateDynamicObject(987, 1218.45972, -1993.56067, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[9] = CreateDynamicObject(987, 1218.45972, -1993.56067, 64.65450,   0.00000, 0.00000, 180.00000);
RejaCIA[10] = CreateDynamicObject(987, 1230.26196, -1993.69360, 64.65450,   0.00000, 0.00000, 180.00000);
RejaCIA[11] = CreateDynamicObject(987, 1230.24377, -1993.70190, 60.48306,   0.00000, 0.00000, 180.00000);
RejaCIA[12] = CreateDynamicObject(987, 1242.16260, -1993.85999, 60.48306,   0.00000, 0.00000, 180.00000);
RejaCIA[13] = CreateDynamicObject(987, 1242.17749, -1993.84656, 57.07599,   0.00000, 0.00000, 180.00000);
RejaCIA[14] = CreateDynamicObject(987, 1242.31165, -2002.57922, 58.42361,   0.00000, 0.00000, 90.00000);
RejaCIA[15] = CreateDynamicObject(987, 1242.31165, -2002.57922, 54.75801,   0.00000, 0.00000, 90.00000);
RejaCIA[16] = CreateDynamicObject(987, 1254.06897, -2002.75964, 58.70840,   0.00000, 0.00000, 180.00000);
RejaCIA[17] = CreateDynamicObject(987, 1265.99915, -2002.86108, 58.34380,   0.00000, 0.00000, 180.00000);
RejaCIA[18] = CreateDynamicObject(987, 1277.81787, -2002.88464, 57.89824,   0.00000, 0.00000, 180.00000);
RejaCIA[19] = CreateDynamicObject(987, 1283.72119, -2002.87634, 57.79004,   0.00000, 0.00000, 180.00000);
RejaCIA[20] = CreateDynamicObject(987, 1283.70435, -2015.01367, 57.79000,   0.00000, 0.00000, 90.00000);
RejaCIA[21] = CreateDynamicObject(987, 1283.73315, -2026.98669, 57.79000,   0.00000, 0.00000, 90.00000);
RejaCIA[22] = CreateDynamicObject(987, 1283.69800, -2038.35645, 57.79000,   0.00000, 0.00000, 90.00000);
RejaCIA[23] = CreateDynamicObject(987, 1283.68652, -2050.30493, 57.79000,   0.00000, 0.00000, 90.00000);
RejaCIA[24] = CreateDynamicObject(987, 1114.49329, -1993.42517, 67.98381,   0.00000, 0.00000, 180.00000);
RejaCIA[25] = CreateDynamicObject(987, 1103.82410, -1993.17847, 67.98380,   0.00000, 0.00000, 270.00000);
RejaCIA[26] = CreateDynamicObject(987, 1103.80774, -2005.09363, 67.98380,   0.00000, 0.00000, 270.00000);
RejaCIA[27] = CreateDynamicObject(987, 1103.66309, -2012.47693, 67.98380,   0.00000, 0.00000, 270.00000);
RejaCIA[28] = CreateDynamicObject(987, 1103.62000, -2024.42639, 67.95493,   0.00000, 0.00000, 180.00000);
RejaCIA[29] = CreateDynamicObject(987, 1283.70215, -2052.02051, 57.79000,   0.00000, 0.00000, 90.00000);
RejaCIA[30] = CreateDynamicObject(987, 1283.68274, -2073.09961, 57.79000,   0.00000, 0.00000, 90.00000);
RejaCIA[31] = CreateDynamicObject(987, 1283.60547, -2073.18579, 53.97399,   0.00000, 0.00000, 90.00000);
RejaCIA[32] = CreateDynamicObject(987, 1247.67822, -2073.36841, 59.65541,   0.00000, 0.00000, 0.00000);
RejaCIA[33] = CreateDynamicObject(987, 1259.63391, -2073.39063, 59.65541,   0.00000, 0.00000, 0.00000);
RejaCIA[34] = CreateDynamicObject(987, 1238.56116, -2073.36499, 60.88675,   0.00000, 0.00000, 0.00000);
RejaCIA[35] = CreateDynamicObject(987, 1229.55005, -2073.39355, 62.08315,   0.00000, 0.00000, 0.00000);
RejaCIA[36] = CreateDynamicObject(987, 1217.60156, -2073.40894, 62.08315,   0.00000, 0.00000, 0.00000);
RejaCIA[37] = CreateDynamicObject(987, 1217.60156, -2073.40894, 65.87697,   0.00000, 0.00000, 0.00000);
RejaCIA[38] = CreateDynamicObject(987, 1205.59924, -2073.39014, 66.91040,   0.00000, 0.00000, 0.00000);
RejaCIA[39] = CreateDynamicObject(987, 1194.07617, -2073.39526, 67.75560,   0.00000, 0.00000, 0.00000);
RejaCIA[40] = CreateDynamicObject(987, 1182.33801, -2073.47192, 67.77538,   0.00000, 0.00000, 0.00000);
RejaCIA[41] = CreateDynamicObject(987, 1170.38831, -2073.36792, 67.82079,   0.00000, 0.00000, 0.00000);
RejaCIA[42] = CreateDynamicObject(987, 1158.51074, -2073.21777, 67.82079,   0.00000, 0.00000, 0.00000);
RejaCIA[43] = CreateDynamicObject(987, 1146.63623, -2073.17651, 67.82079,   0.00000, 0.00000, 0.00000);
RejaCIA[44] = CreateDynamicObject(987, 1134.94922, -2073.22559, 67.82079,   0.00000, 0.00000, 0.00000);
RejaCIA[45] = CreateDynamicObject(987, 1137.53357, -2084.76392, 67.82080,   0.00000, 0.00000, 102.48000);
RejaCIA[46] = CreateDynamicObject(987, 1126.96838, -2077.88696, 67.82080,   0.00000, 0.00000, -73.62004);
RejaCIA[47] = CreateDynamicObject(987, 1115.36584, -2080.55762, 67.82080,   0.00000, 0.00000, 12.72002);
RejaCIA[48] = CreateDynamicObject(987, 1103.37402, -2080.55762, 67.82080,   0.00000, 0.00000, 0.00000);
RejaCIA[49] = CreateDynamicObject(987, 1103.45386, -2068.49390, 67.82080,   0.00000, 0.00000, 270.00000);
RejaCIA[50] = CreateDynamicObject(987, 1103.48535, -2056.95117, 67.82080,   0.00000, 0.00000, 270.00000);
RejaCIA[51] = CreateDynamicObject(987, 1103.58179, -2049.89014, 67.82080,   0.00000, 0.00000, 270.00000);
RejaCIA[52] = CreateDynamicObject(987, 1091.81763, -2049.56250, 67.82080,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 53; TexturizarID++){SetDynamicObjectMaterial(RejaCIA[TexturizarID], 0, 10377, "cityhall_sfs", "grn_window2_16");}

RejaCIAG[0] = CreateDynamicObject(8148, 1202.83948, -2072.90918, 58.27659,   0.00000, 0.00000, 270.00000);
SetDynamicObjectMaterial(RejaCIAG[0], 0, 10377, "cityhall_sfs", "grn_window2_16");

//PUERTAS
PuertaCIA[0] = CreateDynamicObject(19912, 1283.65674, -2051.24634, 60.52392,   0.00000, 0.00000, 90.00000);
PuertaCIA[1] = CreateDynamicObject(986, 1132.70679, -2082.58691, 69.72026,   0.00000, 0.00000, 193.67984);
SetDynamicObjectMaterial(PuertaCIA[0], 0, 10377, "cityhall_sfs", "grn_window2_16");
SetDynamicObjectMaterial(PuertaCIA[1], 3, 10377, "cityhall_sfs", "grn_window2_16");

//TORRES
TorreCIA[0] = CreateDynamicObject(3279, 1274.93042, -2065.88550, 57.63116,   0.00000, 0.00000, -181.01997);
TorreCIA[1] = CreateDynamicObject(3279, 1273.70776, -2008.19495, 57.62672,   0.00000, 0.00000, -2.40000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreCIA[TexturizarID], 0,   10377, "cityhall_sfs", "grn_window2_16"), SetDynamicObjectMaterial(TorreCIA[TexturizarID], 2, 10377, "cityhall_sfs", "grn_window2_16"), SetDynamicObjectMaterial(TorreCIA[TexturizarID], 8, 10377, "cityhall_sfs", "grn_window2_16");}

//ENTRADA
EntradaCIA[0] = CreateDynamicObject(11505, 1286.80750, -2056.58008, 61.98425,   1.50000, 0.00000, 90.00000);
EntradaCIA[1] = CreateDynamicObject(3749, 1132.40222, -2081.72485, 73.99947,   0.00000, 0.00000, 13.13999);

SetDynamicObjectMaterial(EntradaCIA[0], 0, 10941, "silicon2_sfse", "ws_stationfloor");
SetDynamicObjectMaterial(EntradaCIA[0], 1, 10941, "silicon2_sfse", "ws_stationfloor");
SetDynamicObjectMaterial(EntradaCIA[0], 2, 3267, "milbase", "aluminiumbands256");
SetDynamicObjectMaterial(EntradaCIA[0], 3, 3267, "milbase", "aluminiumbands256");
SetDynamicObjectMaterial(EntradaCIA[0], 4, 3267, "milbase", "aluminiumbands256");

SetDynamicObjectMaterial(EntradaCIA[1], 0, 10941, "silicon2_sfse", "ws_stationfloor");
SetDynamicObjectMaterial(EntradaCIA[1], 2,  10941, "silicon2_sfse", "ws_stationfloor");
SetDynamicObjectMaterial(EntradaCIA[1], 3,  10941, "silicon2_sfse", "ws_stationfloor");
SetDynamicObjectMaterial(EntradaCIA[1], 1,  10941, "silicon2_sfse", "ws_stationfloor");

//MUESTRA
MCIA[0] = CreateDynamicObject(2460, 1166.84180, -2011.67297, 67.92560,   0.00000, 0.00000, 90.00000);
MCIA[1] = CreateDynamicObject(2460, 1166.79565, -2014.87915, 67.91467,   0.00000, 0.00000, 90.00000);
MCIA[2] = CreateDynamicObject(2460, 1166.78333, -2017.81653, 67.91467,   0.00000, 0.00000, 90.00000);
MCIA[3] = CreateDynamicObject(2460, 1166.82959, -2021.01001, 67.91467,   0.00000, 0.00000, 90.00000);
for(new TexturizarID; TexturizarID < 4; TexturizarID++){SetDynamicObjectMaterial(MCIA[TexturizarID], 0, 16093, "a51_ext", "a51_metal1");}

//MESA
MesaCIA[0] = CreateDynamicObject(2370, 1154.60291, -2054.99951, 67.87732,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(MesaCIA[0], 0, 16093, "a51_ext", "a51_metal1");


//CONCRETO PISO
ConcretoCIAP[0] = CreateDynamicObject(18764, 1146.47217, -2054.57666, 65.51152,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[1] = CreateDynamicObject(18764, 1146.45801, -2055.41455, 65.53151,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[2] = CreateDynamicObject(18764, 1145.71704, -2055.38354, 65.53151,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[3] = CreateDynamicObject(18764, 1145.68359, -2054.47119, 65.53151,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[4] = CreateDynamicObject(18764, 1155.81689, -2062.73779, 65.57086,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[5] = CreateDynamicObject(18764, 1155.51807, -2064.05859, 65.56308,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[6] = CreateDynamicObject(18764, 1156.40259, -2063.02515, 65.54102,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[7] = CreateDynamicObject(18765, 1162.53137, -2022.92566, 65.52587,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[8] = CreateDynamicObject(18765, 1162.48975, -2012.93188, 65.52587,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[9] = CreateDynamicObject(18765, 1152.56165, -2022.92432, 65.52587,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[10] = CreateDynamicObject(18765, 1152.51514, -2012.92761, 65.52587,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[11] = CreateDynamicObject(18765, 1142.55029, -2012.96606, 65.52587,   0.00000, 0.00000, 0.00000);
ConcretoCIAP[12] = CreateDynamicObject(18765, 1142.59766, -2022.96411, 65.52587,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 13; TexturizarID++){SetDynamicObjectMaterial(ConcretoCIAP[TexturizarID], 0, 16640, "a51", "a51_floorpanel1");}

//HANGAR
HangarCIA[0] = CreateDynamicObject(3268, 1152.51611, -2017.89929, 67.98800,   0.00000, 0.00000, 90.00000);
SetDynamicObjectMaterial(HangarCIA[0], 1, 4810, "griffobs_las", "sjmlahus21");

//PCIA
PCIA[0] = CreateDynamicObject(3117, 1165.77893, -2007.94641, 69.70876,   0.00000, 90.00000, 90.00000);
PCIA[1] = CreateDynamicObject(3117, 1139.32458, -2008.00952, 69.49702,   0.00000, 90.00000, 90.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(PCIA[TexturizarID], 0, 4810, "griffobs_las", "sjmlahus21");}

//PUERTAS HANGAR
PHangarCIA[0] = CreateDynamicObject(16773, 1150.55713, -2027.68921, 70.50649,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(PHangarCIA[0], 0, 4810, "griffobs_las", "sjmlahus21");

PHangarCIA[1] = CreateDynamicObject(16773, 1158.08618, -2027.67883, 70.50649,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(PHangarCIA[1], 0, 4810, "griffobs_las", "sjmlahus21");

//BASE
CIAB[0] = CreateDynamicObject(19909, 1155.05530, -2054.95776, 68.07506,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(CIAB[0], 1, 4810, "griffobs_las", "sjmlahus21");
SetDynamicObjectMaterial(CIAB[0], 2, 4810, "griffobs_las", "sjmlahus21");
SetDynamicObjectMaterial(CIAB[0], 3, 4810, "griffobs_las", "sjmlahus21");
SetDynamicObjectMaterial(CIAB[0], 4, 4810, "griffobs_las", "sjmlahus21");

CIABC[0] = CreateDynamicObject(3939, 1155.98523, -2063.76147, 69.35200,   0.00000, 0.00000, 90.00000);
CIABC[1] = CreateDynamicObject(3939, 1146.03113, -2054.94629, 69.35200,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(CIABC[TexturizarID], 0, 4810, "griffobs_las", "sjmlahus21"), SetDynamicObjectMaterial(CIABC[TexturizarID], 1, 4810, "griffobs_las", "sjmlahus21");}

//TEXTO
Create3DTextLabel("Toca el "greenC"claxón"whiteA" o presiona la tecla "greenC"'H' "whiteA"para abrir la puerta", -1,  1283.66797, -2056.24268, 59.11295, 40.0, 0);
Create3DTextLabel("Toca el "greenC"claxón"whiteA" o presiona la tecla "greenC"'H' "whiteA"para abrir la puerta", -1,  1132.93823, -2082.67822, 69.37118, 40.0, 0);

///////////////////////////////////////////////////////////////BASE MILITAR///////////////////////////////////////////////////////////////////////////////////////////////
//MAP
CreateDynamicObject(2921, 2719.80005, -2409.70459, 18.76657,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2921, 2719.51733, -2508.28467, 18.61147,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2064, 2725.95459, -2510.79688, 13.27423,   0.00000, 0.00000, -139.85997);
CreateDynamicObject(2064, 2729.61768, -2510.73193, 13.27423,   0.00000, 0.00000, -139.85997);
CreateDynamicObject(2064, 2732.15674, -2510.65601, 13.27423,   0.00000, 0.00000, -139.85997);
CreateDynamicObject(2985, 2728.81396, -2411.22607, 12.62967,   0.00000, 0.00000, 135.24001);
CreateDynamicObject(2985, 2728.77881, -2400.11548, 12.62967,   0.00000, 0.00000, 214.79997);
CreateDynamicObject(3014, 2729.96802, -2472.56201, 16.75409,   0.00000, 0.00000, 23.28000);
CreateDynamicObject(964, 2730.14160, -2470.56567, 16.65317,   0.00000, 0.00000, 40.32000);
CreateDynamicObject(2977, 2730.74365, -2471.74561, 16.44423,   0.00000, 0.00000, 18.84001);
CreateDynamicObject(3015, 2729.22461, -2473.91943, 16.77705,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18257, 2747.26367, -2396.38867, 12.65030,   0.00000, 0.00000, -48.90000);
CreateDynamicObject(16401, 2680.49585, -2529.88232, 12.42313,   0.00000, 0.00000, 89.52000);
CreateDynamicObject(16401, 2680.98975, -2521.81177, 12.42313,   0.00000, 0.00000, -97.67995);
CreateDynamicObject(16638, 2742.05664, -2418.81323, 14.55105,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(16401, 2720.95947, -2342.72241, 12.62207,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16401, 2729.20068, -2342.64233, 12.62210,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(16638, 2742.31641, -2480.49438, 14.56148,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19907, 2783.74390, -2457.10498, 12.58559,   0.00000, 0.00000, -1.86000);
CreateDynamicObject(16641, 2742.31274, -2453.86865, 14.15160,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3796, 2744.81909, -2437.22510, 12.64007,   0.00000, 0.00000, 52.26000);
CreateDynamicObject(3796, 2741.91382, -2429.13135, 12.64007,   0.00000, 0.00000, 169.86000);
CreateDynamicObject(3069, 2822.71338, -2438.21362, 10.60623,   4.00000, 0.00000, 90.00000);
CreateDynamicObject(16782, 2775.21240, -2466.64209, 15.29998,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19164, 2777.80640, -2466.76978, 13.71187,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1826, 2777.25098, -2467.15088, 12.85228,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1826, 2777.24316, -2466.26563, 12.85228,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3383, 2785.17847, -2470.44873, 12.60649,   0.00000, 0.00000, -3.00000);
CreateDynamicObject(3383, 2781.27197, -2470.21362, 12.60649,   0.00000, 0.00000, -3.00000);
CreateDynamicObject(3383, 2777.33081, -2470.07446, 12.60649,   0.00000, 0.00000, -3.00000);
CreateDynamicObject(3395, 2785.02271, -2470.35083, 12.80161,   0.00000, 0.00000, -91.74001);
CreateDynamicObject(3396, 2781.14111, -2470.13330, 12.77474,   0.00000, 0.00000, -93.17998);
CreateDynamicObject(3397, 2777.39795, -2463.52490, 12.70937,   0.00000, 0.00000, 86.46000);
CreateDynamicObject(3397, 2780.80493, -2463.71484, 12.70937,   0.00000, 0.00000, 86.46000);
CreateDynamicObject(3387, 2783.20142, -2463.63428, 12.72890,   0.00000, 0.00000, 85.62003);
CreateDynamicObject(3386, 2784.14380, -2463.71216, 12.60213,   0.00000, 0.00000, 86.93998);
CreateDynamicObject(2894, 2778.46924, -2470.08618, 13.66108,   0.00000, 0.00000, 36.96001);
CreateDynamicObject(2894, 2777.62207, -2469.90259, 13.66108,   0.00000, 0.00000, -8.87999);
CreateDynamicObject(2976, 2777.46899, -2470.43140, 13.72551,   90.84002, 7.32000, 72.47998);
CreateDynamicObject(2055, 2780.93091, -2462.98193, 14.91621,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2894, 2776.72998, -2470.17676, 13.66108,   0.00000, 0.00000, -57.71999);
CreateDynamicObject(1271, 2787.47119, -2444.10547, 13.09498,   0.00000, 0.00000, -17.10000);
CreateDynamicObject(1271, 2787.34058, -2445.79028, 13.09498,   0.00000, 0.00000, 43.08000);
CreateDynamicObject(3932, 2757.16211, -2393.02393, 14.23578,   0.00000, 0.00000, -119.52000);
CreateDynamicObject(3932, 2761.83447, -2398.89282, 14.23578,   0.00000, 0.00000, -164.39998);
CreateDynamicObject(19903, 2755.31006, -2392.06396, 12.55892,   0.00000, 0.00000, -30.66000);
CreateDynamicObject(11738, 2758.86035, -2395.63330, 12.64789,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11738, 2758.92139, -2394.98242, 12.64789,   0.00000, 0.00000, 119.04001);
CreateDynamicObject(11736, 2758.98853, -2394.55054, 12.67489,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11736, 2754.58960, -2392.80664, 13.34044,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19903, 2762.41479, -2401.02246, 12.67434,   0.00000, 0.00000, 105.35999);
CreateDynamicObject(2068, 2756.40454, -2397.58862, 16.28300,   0.00000, 0.00000, 20.52000);
CreateDynamicObject(3440, 2752.12915, -2394.66602, 14.39744,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3440, 2754.74146, -2402.45923, 14.36341,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3267, 2834.71802, -2365.28418, 29.48882,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3267, 2843.50488, -2365.64185, 29.48882,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19641, 2847.57959, -2432.74976, 9.92433,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19641, 2847.43823, -2425.96191, 9.92433,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19641, 2847.33936, -2419.56250, 9.92433,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19641, 2847.64209, -2412.92944, 9.92433,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1583, 2850.67603, -2401.45557, 10.96628,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1583, 2848.46875, -2401.51953, 10.96628,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1583, 2846.10767, -2401.47461, 10.96628,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16327, 2838.53711, -2385.71387, 10.99835,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1583, 2838.38599, -2387.08569, 21.04040,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2849.23926, -2382.51196, 11.44007,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2849.97290, -2383.03149, 11.44007,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1583, 2848.47729, -2383.33228, 10.86765,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1583, 2848.53516, -2381.73730, 10.86765,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1583, 2850.16919, -2381.77173, 10.86765,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1583, 2849.35767, -2380.88354, 10.86765,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3794, 2780.21191, -2475.75830, 13.27864,   0.00000, 0.00000, 64.80000);
CreateDynamicObject(3794, 2782.39551, -2476.83252, 13.27864,   0.00000, 0.00000, 217.49983);
CreateDynamicObject(3440, 2830.20068, -2453.25024, 16.96933,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3440, 2830.20068, -2453.25024, 12.24645,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3440, 2830.31055, -2442.28076, 16.96933,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3440, 2830.31055, -2442.28076, 12.28005,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3440, 2846.64185, -2442.36890, 16.96933,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3440, 2846.64185, -2442.36890, 12.22540,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3440, 2846.31836, -2453.34985, 16.83526,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3440, 2846.31836, -2453.34985, 12.18549,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3934, 2837.59595, -2466.47632, 11.03569,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3796, 2835.64331, -2444.19385, 10.98728,   0.00000, 0.00000, -45.42000);
CreateDynamicObject(2935, 2842.08716, -2442.71753, 12.33825,   0.00000, 0.00000, -58.56000);
CreateDynamicObject(3073, 2839.59619, -2450.61572, 12.66342,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2935, 2842.08716, -2442.71753, 15.22812,   0.00000, 0.00000, -58.56000);
CreateDynamicObject(1800, 2757.10815, -2394.85083, 12.54369,   0.00000, 0.00000, 58.79998);
CreateDynamicObject(1800, 2758.62231, -2392.33057, 12.54369,   0.00000, 0.00000, 58.79998);
CreateDynamicObject(1800, 2760.26367, -2398.18994, 12.54369,   0.00000, 0.00000, -165.95984);
CreateDynamicObject(1800, 2763.13745, -2397.51367, 12.54369,   0.00000, 0.00000, -165.95984);

//REJAS
RejaM[0] = CreateDynamicObject(987, 2685.70947, -2514.25098, 12.11670,   0.00000, 0.00000, 180.00000);
RejaM[1] = CreateDynamicObject(987, 2677.69727, -2514.26709, 12.11670,   0.00000, 0.00000, 180.00000);
RejaM[2] = CreateDynamicObject(987, 2665.78320, -2514.06128, 12.11670,   0.00000, 0.00000, 180.00000);
RejaM[3] = CreateDynamicObject(987, 2719.98828, -2508.36353, 15.27047,   0.00000, 0.00000, 270.00000);
RejaM[4] = CreateDynamicObject(987, 2720.04541, -2487.83545, 15.27047,   0.00000, 0.00000, 270.00000);
RejaM[5] = CreateDynamicObject(987, 2719.97900, -2409.59790, 14.78461,   0.00000, 0.00000, 270.00000);
RejaM[6] = CreateDynamicObject(987, 2720.25269, -2389.30933, 14.78461,   0.00000, 0.00000, 270.00000);
RejaM[7] = CreateDynamicObject(987, 2720.22192, -2378.02124, 14.78461,   0.00000, 0.00000, 270.00000);
RejaM[8] = CreateDynamicObject(987, 2727.27637, -2565.63599, 12.57160,   0.00000, 0.00000, 0.00000);
RejaM[9] = CreateDynamicObject(987, 2739.27856, -2565.66113, 12.57160,   0.00000, 0.00000, 0.00000);
RejaM[10] = CreateDynamicObject(987, 2751.28857, -2565.71069, 12.57160,   0.00000, 0.00000, 0.00000);
RejaM[11] = CreateDynamicObject(987, 2763.15723, -2565.77734, 12.57160,   0.00000, 0.00000, 0.00000);
RejaM[12] = CreateDynamicObject(987, 2739.48120, -2348.05835, 16.10167,   0.00000, 0.00000, 270.00000);
RejaM[13] = CreateDynamicObject(987, 2739.55640, -2336.73145, 12.52181,   0.00000, 0.00000, 270.00000);
RejaM[14] = CreateDynamicObject(987, 2739.22485, -2330.19873, 12.52181,   0.00000, 0.00000, 270.00000);
for(new TexturizarID; TexturizarID < 15; TexturizarID++){SetDynamicObjectMaterial(RejaM[TexturizarID], 0, 10631, "queensammo_sfs", "ammu_camo1");}

PuertasM[0] = CreateDynamicObject(19912, 2720.05396, -2400.05884, 15.46723,   0.00000, 0.00000, 90.00000);
PuertasM[1] = CreateDynamicObject(19912, 2720.38354, -2498.67139, 15.32000,   0.00000, 0.00000, 90.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(PuertasM[TexturizarID], 0, 10631, "queensammo_sfs", "ammu_camo1");}


//TORRES
TorreM[0] = CreateDynamicObject(3279, 2724.07275, -2494.13208, 12.25622,   0.00000, 0.00000, 0.00000);
TorreM[1] = CreateDynamicObject(3279, 2726.07446, -2395.44043, 12.36832,   0.00000, 0.00000, 0.12000);
TorreM[2] = CreateDynamicObject(3279, 2725.60352, -2413.77759, 12.36832,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(TorreM[TexturizarID], 0,  10631, "queensammo_sfs", "ammu_camo1"), SetDynamicObjectMaterial(TorreM[TexturizarID], 2,  10631, "queensammo_sfs", "ammu_camo1"), SetDynamicObjectMaterial(TorreM[TexturizarID], 8,  10631, "queensammo_sfs", "ammu_camo1");}

//CONCRETO
ConcretoM[0] = CreateDynamicObject(18762, 2720.33618, -2403.57568, 18.80888,   90.00000, 0.00000, 0.00000);
ConcretoM[1] = CreateDynamicObject(18762, 2720.35791, -2407.23926, 18.80888,   90.00000, 0.00000, 0.00000);
ConcretoM[2] = CreateDynamicObject(18762, 2719.97632, -2505.88501, 18.64800,   90.00000, 0.00000, 0.00000);
ConcretoM[3] = CreateDynamicObject(18762, 2719.98462, -2502.11499, 18.64800,   90.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 4; TexturizarID++){SetDynamicObjectMaterial(ConcretoM[TexturizarID], 0, 10631, "queensammo_sfs", "ammu_camo1");}

//TORRESA51
TorreA51M[0] = CreateDynamicObject(16093, 2742.22925, -2479.53125, 16.31380,   0.00000, 0.00000, 0.00000);
TorreA51M[1] = CreateDynamicObject(16093, 2742.20190, -2419.85767, 16.31380,   0.00000, 0.00000, 180.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreA51M[TexturizarID], 0,  10631, "queensammo_sfs", "ammu_camo1"), SetDynamicObjectMaterial(TorreA51M[TexturizarID], 1,  10631, "queensammo_sfs", "ammu_camo1"), SetDynamicObjectMaterial(TorreA51M[TexturizarID], 6,  10631, "queensammo_sfs", "ammu_camo1"),SetDynamicObjectMaterial(TorreA51M[TexturizarID], 7,  10631, "queensammo_sfs", "ammu_camo1");}

//TEXT
Create3DTextLabel("Toca el "brownM"claxón"whiteA" o presiona la tecla "brownM"'H' "whiteA"para abrir la puerta", -1,  2720.05640, -2405.32520, 13.28415, 40.0, 0);
Create3DTextLabel("Toca el "brownM"claxón"whiteA" o presiona la tecla "brownM"'H' "whiteA"para abrir la puerta", -1,  2719.96411, -2503.99585, 13.38592, 40.0, 0);

///////////////////////////////////////////////////////////////BASE MAFIA RUSA///////////////////////////////////////////////////////////////////////////////////////////////
//MAP
CreateDynamicObject(17951, 2266.32715, -2256.87085, 14.29134,   0.00000, 0.00000, 44.16002);
CreateDynamicObject(17951, 2262.09106, -2252.62354, 14.32154,   0.00000, 0.00000, 44.46002);
CreateDynamicObject(8613, 2158.41797, -2313.38770, 16.24726,   0.00000, 0.00000, 45.47998);
CreateDynamicObject(934, 2135.29688, -2259.49951, 13.50214,   0.00000, 0.00000, 45.59999);
CreateDynamicObject(16641, 2157.85449, -2244.76001, 13.86475,   0.00000, 0.00000, 45.36002);
CreateDynamicObject(3797, 2141.60083, -2260.66772, 17.49426,   0.00000, 0.00000, 191.22005);
CreateDynamicObject(3797, 2140.19458, -2259.26929, 17.49426,   0.00000, 0.00000, 68.46005);
CreateDynamicObject(934, 2138.34033, -2256.75708, 13.50214,   0.00000, 0.00000, 45.59999);
CreateDynamicObject(934, 2141.18896, -2253.54443, 13.50214,   0.00000, 0.00000, 45.59999);
CreateDynamicObject(3066, 2147.21851, -2244.26465, 13.19207,   0.00000, 0.00000, -45.30000);
CreateDynamicObject(5269, 2137.18140, -2290.54443, 16.06057,   0.00000, 0.00000, 45.18000);
CreateDynamicObject(3632, 2133.27222, -2287.16431, 14.24187,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3632, 2133.45874, -2286.19995, 14.24187,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3632, 2132.41919, -2286.44946, 14.24187,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3794, 2132.05249, -2283.88599, 14.27075,   0.00000, 0.00000, 46.07999);
CreateDynamicObject(3794, 2130.65186, -2282.54419, 14.27075,   0.00000, 0.00000, 46.07999);
CreateDynamicObject(3794, 2129.23755, -2281.15869, 14.27075,   0.00000, 0.00000, 46.07999);
CreateDynamicObject(3794, 2127.67114, -2279.49902, 14.27075,   0.00000, 0.00000, 46.07999);
CreateDynamicObject(3794, 2126.02075, -2277.80835, 14.27075,   0.00000, 0.00000, 46.07999);
CreateDynamicObject(3794, 2124.24146, -2276.07007, 14.27075,   0.00000, 0.00000, 46.07999);
CreateDynamicObject(3794, 2122.35107, -2274.34839, 14.27075,   0.00000, 0.00000, 46.07999);
CreateDynamicObject(3795, 2119.21069, -2271.07056, 14.11371,   0.00000, 0.00000, 44.58001);
CreateDynamicObject(3795, 2120.30078, -2272.12500, 14.11371,   0.00000, 0.00000, 44.58001);
CreateDynamicObject(3795, 2121.19971, -2273.29102, 14.11371,   0.00000, 0.00000, 44.58001);
CreateDynamicObject(3273, 2142.35913, -2251.56616, 11.75710,   0.00000, 0.00000, 46.00000);
CreateDynamicObject(3273, 2139.42603, -2254.87817, 11.75710,   0.00000, 0.00000, 46.00000);
CreateDynamicObject(3273, 2136.04712, -2257.45190, 11.75710,   0.00000, 0.00000, 46.00000);
CreateDynamicObject(920, 2131.92163, -2259.37329, 14.12381,   0.00000, 0.00000, -43.61998);
CreateDynamicObject(920, 2130.72778, -2260.53882, 14.12381,   0.00000, 0.00000, -43.61998);
CreateDynamicObject(920, 2129.67944, -2261.76440, 14.12381,   0.00000, 0.00000, -43.61998);
CreateDynamicObject(2056, 2120.48218, -2270.14697, 21.99968,   0.00000, 0.00000, 40.92001);
CreateDynamicObject(2056, 2120.84351, -2269.78564, 21.99968,   3.06000, -43.44001, 43.26000);
CreateDynamicObject(14455, 2127.46045, -2281.63013, 21.36563,   0.00000, 0.00000, -45.11998);
CreateDynamicObject(14455, 2123.46167, -2277.62305, 21.36563,   0.00000, 0.00000, -45.11998);
CreateDynamicObject(2055, 2121.44849, -2269.17456, 22.12865,   0.00000, 0.00000, 45.17999);
CreateDynamicObject(19848, 2121.40771, -2276.00562, 22.49393,   0.00000, 0.00000, 224.21991);
CreateDynamicObject(1636, 2122.50171, -2276.13330, 22.57313,   0.00000, 0.00000, 40.74000);
CreateDynamicObject(1636, 2121.81274, -2275.32593, 22.59013,   0.00000, 0.00000, 40.74000);
CreateDynamicObject(1636, 2121.12793, -2274.62598, 22.59013,   0.00000, 0.00000, 40.74000);
CreateDynamicObject(355, 2122.78174, -2273.84888, 20.53814,   -93.42004, -373.25882, -114.53998);
CreateDynamicObject(2894, 2122.09839, -2274.55054, 20.48864,   0.00000, 0.00000, 209.16005);
CreateDynamicObject(1668, 2121.80908, -2275.15747, 20.64539,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1668, 2122.00635, -2275.15869, 20.64539,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1668, 2121.73413, -2274.94141, 20.64539,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1668, 2121.59668, -2275.06958, 20.64539,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1668, 2121.96558, -2275.00317, 20.64539,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2976, 2128.24341, -2276.68042, 20.73771,   10.44001, 91.20002, 94.74000);
CreateDynamicObject(2894, 2128.67920, -2275.28784, 20.48888,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2894, 2128.73584, -2275.95679, 20.48888,   0.00000, 0.00000, 35.45998);
CreateDynamicObject(19893, 2127.95361, -2276.83179, 20.48849,   0.00000, 0.00000, 77.69999);
CreateDynamicObject(1895, 2133.15942, -2283.14282, 21.61673,   0.00000, 0.00000, -137.40016);
CreateDynamicObject(3092, 2132.95825, -2283.03735, 21.73649,   0.00000, 0.00000, 33.96000);
CreateDynamicObject(2034, 2128.17627, -2276.69800, 20.69457,   90.00000, 0.00000, 90.71994);
CreateDynamicObject(2033, 2128.16772, -2275.93994, 20.71846,   90.00000, 0.00000, 94.68002);
CreateDynamicObject(2033, 2128.16772, -2275.93994, 20.76827,   90.00000, 0.00000, 94.68002);
CreateDynamicObject(2033, 2128.16772, -2275.93994, 20.68145,   90.00000, 0.00000, 94.68002);
CreateDynamicObject(920, 2127.28467, -2275.16577, 20.05024,   0.00000, 0.00000, 226.62010);
CreateDynamicObject(18654, 2126.91675, -2274.41919, 18.82322,   -10.44000, -30.59999, 139.31993);
CreateDynamicObject(18644, 2128.46558, -2276.35254, 20.60150,   0.00000, 90.00000, 78.90004);
CreateDynamicObject(18644, 2128.42676, -2276.00659, 20.60150,   0.00000, 90.00000, 78.90004);
CreateDynamicObject(2619, 2119.78613, -2270.84277, 22.09041,   -6.24000, -1.26000, 134.82018);
CreateDynamicObject(1491, 2133.23755, -2278.86206, 19.67293,   0.00000, 0.00000, 134.16010);
CreateDynamicObject(1491, 2119.73047, -2275.15112, 19.67350,   0.00000, 0.00000, 134.64006);
CreateDynamicObject(3934, 2147.09375, -2303.75317, 19.67822,   0.00000, 0.00000, 45.47996);
CreateDynamicObject(3796, 2233.70923, -2268.23730, 13.76079,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3796, 2228.65430, -2275.13550, 13.76079,   0.00000, 0.00000, 114.35998);
CreateDynamicObject(3796, 2222.83057, -2281.97461, 13.76079,   0.00000, 0.00000, 181.67996);
CreateDynamicObject(355, 2221.85498, -2281.68262, 13.93897,   90.00000, 0.00000, -39.60002);
CreateDynamicObject(355, 2223.06543, -2281.78516, 13.93897,   90.00000, 0.00000, -214.32002);
CreateDynamicObject(355, 2222.65503, -2282.96362, 13.93897,   90.00000, 0.00000, -163.92004);
CreateDynamicObject(355, 2223.58521, -2282.53662, 13.93897,   90.00000, 0.00000, -163.92004);
CreateDynamicObject(355, 2222.11499, -2280.90723, 13.93897,   90.00000, 0.00000, -163.92004);
CreateDynamicObject(342, 2222.51611, -2282.26367, 14.02821,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(342, 2222.43774, -2282.49146, 14.02821,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(342, 2222.69189, -2282.01318, 14.02821,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(342, 2222.70947, -2282.37061, 14.02821,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(342, 2222.64941, -2282.06006, 14.02821,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(342, 2222.41357, -2282.00000, 14.02821,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1636, 2227.65454, -2274.46362, 13.92024,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1636, 2227.36450, -2274.84595, 13.92024,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1636, 2228.22266, -2274.48682, 13.92024,   0.00000, 0.00000, -104.81999);
CreateDynamicObject(1636, 2228.50049, -2275.33618, 13.92024,   0.00000, 0.00000, -104.81999);
CreateDynamicObject(3016, 2234.02661, -2268.16919, 14.09206,   0.00000, 0.00000, -48.77999);
CreateDynamicObject(3016, 2233.50171, -2267.94873, 14.09206,   0.00000, 0.00000, -105.72000);
CreateDynamicObject(3016, 2234.51782, -2268.81226, 14.09206,   0.00000, 0.00000, -105.72000);
CreateDynamicObject(3016, 2233.56689, -2269.17993, 14.09206,   0.00000, 0.00000, -141.11996);
CreateDynamicObject(3016, 2233.14331, -2268.57935, 14.09206,   0.00000, 0.00000, -141.11996);
CreateDynamicObject(3016, 2234.11084, -2267.37793, 14.09206,   0.00000, 0.00000, -141.11996);
CreateDynamicObject(355, 2147.19751, -2268.79932, 13.31530,   86.70003, -2.10000, 49.80003);
CreateDynamicObject(355, 2144.70703, -2266.26978, 13.27310,   90.00000, 0.00000, 44.94001);
CreateDynamicObject(355, 2145.34375, -2266.95044, 13.27310,   90.00000, 0.00000, 44.94001);
CreateDynamicObject(355, 2145.90015, -2267.60889, 13.27310,   90.00000, 0.00000, 44.94001);
CreateDynamicObject(355, 2146.47510, -2268.04517, 13.27310,   90.00000, 0.00000, 44.94001);
CreateDynamicObject(355, 2148.15283, -2269.54126, 13.31530,   86.70003, -2.10000, 49.80003);
CreateDynamicObject(19903, 2144.58154, -2254.34473, 12.23357,   0.00000, 0.00000, 9.84000);
CreateDynamicObject(19903, 2144.22461, -2253.24609, 12.20094,   0.00000, 0.00000, 40.62000);
CreateDynamicObject(1271, 2148.48657, -2262.74780, 12.67337,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1271, 2150.08057, -2264.03223, 12.67337,   0.00000, 0.00000, -46.62000);
CreateDynamicObject(1271, 2149.92407, -2262.87793, 12.67337,   0.00000, 0.00000, -46.62000);
CreateDynamicObject(1271, 2148.60107, -2264.18994, 12.67337,   0.00000, 0.00000, -82.92001);
CreateDynamicObject(1668, 2187.57324, -2250.98389, 13.88848,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1668, 2187.44263, -2251.19751, 13.88848,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1668, 2187.35596, -2250.92456, 13.88848,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1668, 2187.82715, -2250.86182, 13.88848,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1668, 2187.59106, -2250.81299, 13.88848,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3564, 2207.13184, -2308.79346, 14.10655,   0.00000, 0.00000, 44.27997);
CreateDynamicObject(3564, 2210.00171, -2311.67847, 14.10655,   0.00000, 0.00000, 44.27997);
CreateDynamicObject(3585, 2231.38354, -2284.23584, 14.16118,   0.00000, 0.00000, 45.18001);
CreateDynamicObject(1271, 2229.78735, -2286.66675, 13.72239,   0.00000, 0.00000, -43.26000);
CreateDynamicObject(1271, 2229.11450, -2285.96924, 13.72239,   0.00000, 0.00000, -43.26000);
CreateDynamicObject(1271, 2229.33081, -2286.30347, 14.40431,   0.00000, 0.00000, -43.26000);
CreateDynamicObject(355, 2232.99194, -2281.35718, 13.75584,   0.00000, 270.00000, -45.90001);
CreateDynamicObject(355, 2233.25317, -2281.67700, 13.75584,   0.00000, 270.00000, -45.90001);
CreateDynamicObject(355, 2233.52222, -2281.95264, 13.75584,   0.00000, 270.00000, -45.90001);
CreateDynamicObject(355, 2233.80688, -2282.24023, 13.75584,   0.00000, 270.00000, -45.90001);
CreateDynamicObject(355, 2234.08008, -2282.54370, 13.75584,   0.00000, 270.00000, -45.90001);
CreateDynamicObject(1271, 2188.93823, -2227.08057, 14.50849,   0.00000, 0.00000, 35.34000);
CreateDynamicObject(1271, 2189.27173, -2225.86743, 14.50849,   0.00000, 0.00000, 35.34000);
CreateDynamicObject(1271, 2190.49170, -2225.77832, 14.50849,   0.00000, 0.00000, 35.34000);
CreateDynamicObject(1271, 2189.85791, -2226.88965, 14.50849,   0.00000, 0.00000, 35.34000);
CreateDynamicObject(1271, 2189.28613, -2226.62891, 15.19035,   0.00000, 0.00000, 35.34000);
CreateDynamicObject(355, 2194.94019, -2218.58618, 14.42723,   -18.72000, 277.67972, 39.60000);
CreateDynamicObject(355, 2195.31079, -2218.31250, 14.42723,   -18.72000, 277.67972, 39.60000);
CreateDynamicObject(355, 2195.68140, -2218.03906, 14.42723,   -18.72000, 277.67972, 39.60000);
CreateDynamicObject(355, 2196.04834, -2217.69336, 14.42723,   -18.72000, 277.67972, 39.60000);
CreateDynamicObject(355, 2196.42725, -2217.36353, 14.42723,   -18.72000, 277.67972, 39.60000);
CreateDynamicObject(355, 2196.74170, -2217.04468, 14.42723,   -18.72000, 277.67972, 39.60000);
CreateDynamicObject(3794, 2196.99292, -2220.11230, 14.68385,   0.00000, 0.00000, -46.50001);
CreateDynamicObject(3794, 2197.95752, -2219.21021, 14.68385,   0.00000, 0.00000, -46.50001);
CreateDynamicObject(10773, 2173.38696, -2326.94019, 15.25126,   0.00000, 0.00000, -44.10002);
CreateDynamicObject(5269, 2155.29175, -2296.06494, 12.39045,   0.00000, 0.00000, 45.60003);
CreateDynamicObject(5269, 2155.93311, -2296.69824, 13.51360,   0.00000, 0.00000, 45.60003);
CreateDynamicObject(1841, 2188.43262, -2250.21021, 13.74843,   0.00000, 0.00000, 86.09998);

//REJAS
RejasMR[0] = CreateDynamicObject(987, 2229.25659, -2210.50586, 15.99120,   0.00000, 0.00000, 134.81998);
RejasMR[1] = CreateDynamicObject(987, 2220.90039, -2202.05908, 15.99120,   0.00000, 0.00000, 134.81998);
RejasMR[2] = CreateDynamicObject(987, 2212.72876, -2193.84155, 15.99120,   0.00000, 0.00000, 134.81998);
RejasMR[3] = CreateDynamicObject(987, 2207.08936, -2187.96558, 15.99120,   0.00000, 0.00000, 134.81998);
RejasMR[4] = CreateDynamicObject(987, 2198.86841, -2179.66357, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[5] = CreateDynamicObject(987, 2190.47363, -2188.17090, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[6] = CreateDynamicObject(987, 2181.98438, -2196.61133, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[7] = CreateDynamicObject(987, 2173.56299, -2205.07642, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[8] = CreateDynamicObject(987, 2165.12280, -2213.51245, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[9] = CreateDynamicObject(987, 2156.70068, -2221.92700, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[10] = CreateDynamicObject(987, 2148.30518, -2230.36060, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[11] = CreateDynamicObject(987, 2139.93848, -2238.77832, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[12] = CreateDynamicObject(987, 2131.48145, -2247.22266, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[13] = CreateDynamicObject(987, 2123.41113, -2255.24536, 15.99120,   0.00000, 0.00000, 225.17990);
RejasMR[14] = CreateDynamicObject(987, 2115.27832, -2263.28149, 15.99120,   0.00000, 0.00000, 248.09985);
RejasMR[15] = CreateDynamicObject(987, 2110.97803, -2274.26172, 15.99120,   0.00000, 0.00000, -89.88002);
RejasMR[16] = CreateDynamicObject(987, 2111.04028, -2286.02393, 15.99120,   0.00000, 0.00000, -89.88002);
RejasMR[17] = CreateDynamicObject(987, 2111.04272, -2295.00903, 15.99120,   0.00000, 0.00000, -89.88002);
RejasMR[18] = CreateDynamicObject(987, 2111.05908, -2300.15356, 15.99120,   0.00000, 0.00000, -89.88002);
RejasMR[19] = CreateDynamicObject(987, 2111.01807, -2311.88232, 15.99120,   0.00000, 0.00000, -10.68000);
RejasMR[20] = CreateDynamicObject(987, 2121.42871, -2313.79736, 15.99120,   0.00000, 0.00000, -10.68000);
RejasMR[21] = CreateDynamicObject(987, 2131.63696, -2315.59546, 15.99120,   0.00000, 0.00000, -26.04000);
RejasMR[22] = CreateDynamicObject(987, 2138.59717, -2319.04468, 15.99120,   0.00000, 0.00000, -26.04000);
RejasMR[23] = CreateDynamicObject(987, 2149.07031, -2324.24927, 15.99120,   0.00000, 0.00000, -37.19999);
RejasMR[24] = CreateDynamicObject(987, 2158.48438, -2331.53491, 15.99120,   0.00000, 0.00000, -38.64001);
RejasMR[25] = CreateDynamicObject(987, 2167.77393, -2339.03101, 15.99120,   0.00000, 0.00000, -38.64001);
RejasMR[26] = CreateDynamicObject(987, 2176.83008, -2346.19141, 15.99120,   0.00000, 0.00000, -37.86000);
RejasMR[27] = CreateDynamicObject(987, 2186.03833, -2353.37476, 15.99120,   0.00000, 0.00000, 45.00000);
RejasMR[28] = CreateDynamicObject(987, 2194.49316, -2344.98071, 15.99120,   0.00000, 0.00000, 45.00000);
RejasMR[29] = CreateDynamicObject(987, 2202.94312, -2336.55640, 15.99120,   0.00000, 0.00000, 45.00000);
RejasMR[30] = CreateDynamicObject(987, 2211.38574, -2328.16187, 15.99120,   0.00000, 0.00000, 45.00000);
RejasMR[31] = CreateDynamicObject(987, 2219.85815, -2319.76636, 15.97516,   0.00000, 0.00000, 45.00000);
RejasMR[32] = CreateDynamicObject(987, 2223.43677, -2316.22729, 15.99120,   0.00000, 0.00000, 45.00000);
RejasMR[33] = CreateDynamicObject(987, 2247.56519, -2228.86890, 15.99120,   0.00000, 0.00000, 134.81998);
RejasMR[34] = CreateDynamicObject(987, 2255.86694, -2237.20850, 15.99120,   0.00000, 0.00000, 134.81998);
RejasMR[35] = CreateDynamicObject(987, 2257.73218, -2239.09521, 15.99120,   0.00000, 0.00000, 134.81998);
RejasMR[36] = CreateDynamicObject(987, 2248.33276, -2248.77734, 15.99120,   0.00000, 0.00000, 45.42000);
PuertaMR[0] = CreateDynamicObject(19912, 2230.32104, -2211.53052, 15.41264,   0.00000, 0.00000, 134.93996);
for(new TexturizarID; TexturizarID < 37; TexturizarID++){SetDynamicObjectMaterial(RejasMR[TexturizarID], 0, 11391, "hubprops2_sfse", "blackbag");}
SetDynamicObjectMaterial(PuertaMR[0], 0, 11391, "hubprops2_sfse", "blackbag");

//TORRES
TorreMR[0] = CreateDynamicObject(3279, 2243.77246, -2233.62256, 12.53524,   0.00000, 0.00000, -135.24008);
TorreMR[1] = CreateDynamicObject(3279, 2117.71924, -2303.97534, 12.29718,   0.00000, 0.00000, 86.25617);
TorreMR[2] = CreateDynamicObject(3279, 2188.31104, -2345.95825, 12.54718,   0.00000, 0.00000, 134.33998);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(TorreMR[TexturizarID], 0, 11391, "hubprops2_sfse", "blackbag"),SetDynamicObjectMaterial(TorreMR[TexturizarID], 2, 11391, "hubprops2_sfse", "blackbag"),SetDynamicObjectMaterial(TorreMR[TexturizarID], 8, 11391, "hubprops2_sfse", "blackbag");}

//ENTRADA
EntradaMR[0] = CreateDynamicObject(3749, 2235.07593, -2214.97485, 17.77680,   0.00000, 0.00000, -45.00000);
SetDynamicObjectMaterial(EntradaMR[0], 0, 11100, "bendytunnel_sfse", "blackmetal");
SetDynamicObjectMaterial(EntradaMR[0], 2, 11100, "bendytunnel_sfse", "blackmetal");
SetDynamicObjectMaterial(EntradaMR[0], 3, 10932, "station_sfse", "girder2_grey_64HV");

//TEXT
Create3DTextLabel("Toca el "grayM"claxón"whiteA" o presiona la tecla "grayM"'H' "whiteA"para abrir la puerta", -1,  2233.98901, -2214.96558, 13.34346, 30.0, 0);

///////////////////////////////////////////////////////////////BASE TRAFICANTES///////////////////////////////////////////////////////////////////////////////////////////////

//MAPS
CreateDynamicObject(11090, 1140.75415, -1532.42371, 22.31045,   0.00000, 0.00000, -65.45999);
CreateDynamicObject(11090, 1114.45605, -1532.32153, 22.31045,   0.00000, 0.00000, -116.16005);
CreateDynamicObject(11090, 1134.68750, -1551.97632, 22.41356,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11090, 1119.71887, -1551.86975, 22.41356,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3643, 1134.28235, -1540.68140, 27.04435,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3643, 1120.55640, -1540.34814, 27.04435,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2991, 1132.92517, -1543.91479, 13.01714,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2991, 1132.92517, -1543.91479, 14.24046,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2991, 1132.92517, -1543.91479, 15.47047,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3796, 1129.16370, -1532.68457, 21.74795,   0.00000, 0.00000, 46.80000);
CreateDynamicObject(3796, 1122.45605, -1531.42749, 21.74795,   0.00000, 0.00000, 132.72000);
CreateDynamicObject(3630, 1124.29565, -1547.01685, 14.94310,   0.00000, -4.00000, 90.00000);
CreateDynamicObject(3796, 1125.12854, -1538.50403, 13.99680,   0.00000, 1.40000, -54.06000);
CreateDynamicObject(1575, 1125.51306, -1536.43176, 14.12429,   0.00000, 0.00000, -59.04000);
CreateDynamicObject(1575, 1125.13586, -1536.73120, 14.12429,   0.00000, 0.00000, -59.04000);
CreateDynamicObject(1575, 1124.70325, -1537.09192, 14.12429,   0.00000, 0.00000, -59.04000);
CreateDynamicObject(1575, 1124.06567, -1537.54163, 14.12429,   0.00000, 0.00000, -59.04000);
CreateDynamicObject(1575, 1123.39087, -1538.01648, 14.12429,   0.00000, 0.00000, -59.04000);
CreateDynamicObject(1575, 1123.74915, -1537.81726, 14.12429,   0.00000, 0.00000, -59.04000);
CreateDynamicObject(1575, 1124.39941, -1537.35474, 14.12429,   0.00000, 0.00000, -59.04000);
CreateDynamicObject(1577, 1125.16565, -1536.76099, 14.29590,   0.00000, 0.00000, -61.55999);
CreateDynamicObject(1577, 1124.71680, -1537.10022, 14.29590,   0.00000, 0.00000, -61.55999);
CreateDynamicObject(1577, 1124.42664, -1537.34546, 14.29590,   0.00000, 0.00000, -61.55999);
CreateDynamicObject(1577, 1124.18164, -1537.55969, 14.29590,   0.00000, 0.00000, -61.55999);
CreateDynamicObject(2901, 1125.36011, -1539.83362, 14.35939,   0.00000, 0.00000, 36.29999);
CreateDynamicObject(2901, 1124.92773, -1539.24023, 14.35939,   0.00000, 0.00000, 36.29999);
CreateDynamicObject(741, 1082.58020, -1495.04199, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1080.83594, -1495.39856, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1078.87646, -1495.88794, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1076.58984, -1496.27209, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1073.99255, -1496.87891, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1071.41724, -1497.30847, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1068.92969, -1497.75354, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1066.93201, -1498.14636, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1082.28796, -1493.84033, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1080.46545, -1494.30884, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1078.61133, -1494.63635, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1076.36572, -1495.13660, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1073.56104, -1495.70593, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1071.05627, -1496.06152, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1068.66357, -1496.63916, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1066.65637, -1496.94006, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1081.60596, -1489.23291, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1079.39551, -1489.59143, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1077.45264, -1489.81091, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1075.40881, -1490.31165, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1072.26367, -1490.86230, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1069.65271, -1491.26721, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1067.36865, -1491.62634, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1065.43677, -1492.04700, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1081.40735, -1488.02673, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1079.07324, -1488.26794, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1077.20850, -1488.49170, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1075.11572, -1489.01099, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1072.02637, -1489.59827, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1069.46643, -1490.00500, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1067.15430, -1490.34082, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(741, 1065.09534, -1490.63965, 21.99168,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1065.47375, -1493.67004, 22.17806,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1065.07239, -1492.36292, 22.17806,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1067.34802, -1493.26831, 22.17243,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1067.22461, -1492.01379, 22.17243,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1069.73352, -1492.91687, 22.17320,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1069.48877, -1491.69971, 22.17320,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1072.31677, -1492.50427, 22.17242,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1072.09045, -1491.24792, 22.17242,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1075.47729, -1491.90710, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1075.29968, -1490.61755, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1077.56323, -1491.38806, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1077.39246, -1490.19739, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1079.63123, -1491.25256, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1079.29358, -1489.98425, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1081.83374, -1490.84119, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1081.52527, -1489.68518, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1082.20618, -1495.51318, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1082.51917, -1496.77686, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1080.46191, -1495.99316, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1080.83643, -1497.10193, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1078.57153, -1496.34094, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1076.41748, -1496.73584, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1078.86438, -1497.56604, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1076.68774, -1497.65491, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1073.45544, -1497.40479, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1073.95300, -1498.50537, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1071.58887, -1498.87976, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1071.24622, -1497.58984, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1068.94287, -1498.17444, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1069.15820, -1499.35571, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1066.90173, -1498.45337, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19473, 1067.18591, -1499.84888, 22.01999,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3934, 1079.32690, -1478.10339, 28.90656,   0.00000, 0.00000, -8.10000);
CreateDynamicObject(1225, 1123.40125, -1425.88074, 15.27465,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1124.27319, -1425.52454, 15.27465,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1122.72705, -1426.88782, 15.27465,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1150.59082, -1414.63904, 13.39833,   0.00000, 0.00000, 0.00000);

//REJAS
RejaTr[0] = CreateDynamicObject(987, 1122.57373, -1559.12244, 12.76755,   0.00000, 0.00000, 0.00000);
RejaTr[1] = CreateDynamicObject(987, 1122.37646, -1561.58923, 21.40369,   0.00000, 0.00000, 0.00000);
RejaTr[2] = CreateDynamicObject(987, 1113.53162, -1561.66028, 21.40369,   0.00000, 0.00000, 0.00000);
RejaTr[3] = CreateDynamicObject(987, 1134.28015, -1561.52795, 21.40369,   0.00000, 0.00000, 0.00000);
RejaTr[4] = CreateDynamicObject(987, 1113.04028, -1424.26892, 14.78850,   0.00000, 0.00000, 180.00000);
RejaTr[5] = CreateDynamicObject(987, 1119.21216, -1424.29358, 14.78850,   0.00000, 0.00000, 180.00000);
RejaTr[6] = CreateDynamicObject(987, 1148.39722, -1424.38330, 14.78850,   0.00000, 0.00000, 180.00000);
RejaTr[7] = CreateDynamicObject(987, 1160.35522, -1424.41357, 14.78850,   0.00000, 0.00000, 180.00000);
RejaTr[8] = CreateDynamicObject(987, 1077.54065, -1489.07141, 13.57470,   0.00000, 0.00000, 270.00000);
RejaTr[9] = CreateDynamicObject(987, 1062.73267, -1491.79749, 21.64441,   0.00000, 0.00000, 253.80054);
RejaTr[10] = CreateDynamicObject(987, 1122.27283, -1424.29456, 14.78850,   0.00000, 0.00000, 180.00000);
RejaTr[11] = CreateDynamicObject(987, 1145.83521, -1424.30164, 14.78850,   0.00000, 0.00000, 180.00000);
for(new TexturizarID; TexturizarID < 12; TexturizarID++){SetDynamicObjectMaterial(RejaTr[TexturizarID], 0, 16109, "des_se1", "des_crackeddirt1");}

//PUERTAS
PuertaT[0] = CreateDynamicObject(19912, 1134.20007, -1424.06287, 17.58656,   0.00000, 0.00000, 0.00000);
PuertaT[1] = CreateDynamicObject(19912, 1176.06921, -1484.18115, 16.01622,   0.00000, 0.00000, 90.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(PuertaT[TexturizarID], 0, 4887, "downtown_las", "pershing1_LAn");}

//PARED
ParedT[0] = CreateDynamicObject(11353, 1128.48083, -1423.70618, 24.68830,   0.00000, 0.00000, 90.00000);
SetDynamicObjectMaterial(ParedT[0], 0, 16109, "des_sel", "des_crackeddirt1");
SetDynamicObjectMaterial(ParedT[0], 1, 16109, "des_sel", "des_crackeddirt1");

//TORRES
TorreT[0] = CreateDynamicObject(3279, 1087.84998, -1426.90820, 28.75386,   0.00000, 0.00000, 0.00000);
TorreT[1] = CreateDynamicObject(3279, 1170.45435, -1430.85046, 28.86463,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreT[TexturizarID], 0,   16109, "des_se1", "des_crackeddirt1"), SetDynamicObjectMaterial(TorreT[TexturizarID], 2,  16109, "des_se1", "des_crackeddirt1"), SetDynamicObjectMaterial(TorreT[TexturizarID], 8, 16109, "des_se1", "des_crackeddirt1");}

//ESCALERAS
EscaleraT[0] = CreateDynamicObject(3586, 1091.71631, -1482.73877, 25.34904,   0.00000, 0.00000, 180.00000);
EscaleraT[1] = CreateDynamicObject(3586, 1164.65991, -1479.32104, 25.34904,   0.00000, 0.00000, 179.78490);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(EscaleraT[TexturizarID], 0, 4887, "downtown_las", "pershing1_LAn");}

//LUZ
LuzT[0] = CreateDynamicObject(3437, 1176.07983, -1483.65417, 13.20800,   0.00000, 0.00000, 90.00000);
LuzT[1] = CreateDynamicObject(3437, 1176.13269, -1495.93237, 13.20800,   0.00000, 0.00000, 90.00000);
LuzT[2] = CreateDynamicObject(3437, 1122.46948, -1424.36243, 14.78890,   0.00000, 0.00000, 90.00000);
LuzT[3] = CreateDynamicObject(3437, 1134.26807, -1424.37805, 14.78890,   0.00000, 0.00000, 90.00000);
LuzT[4] = CreateDynamicObject(3437, 1134.26807, -1424.37805, 14.78890,   0.00000, 0.00000, 0.00000);
LuzT[5] = CreateDynamicObject(3437, 1122.46948, -1424.36243, 14.78890,   0.00000, 0.00000, 900.00000);
for(new TexturizarID; TexturizarID < 6; TexturizarID++){SetDynamicObjectMaterial(LuzT[TexturizarID], 0, 4887, "downtown_las", "pershing1_LAn");}

//PLATAFORMAS
PlataformaT[0] = CreateDynamicObject(19464, 1091.11401, -1473.28821, 28.51670,   0.00000, 90.00000, 0.00000);
PlataformaT[1] = CreateDynamicObject(19464, 1165.27966, -1469.91687, 28.51670,   0.00000, 90.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(PlataformaT[TexturizarID], 0, 4887, "downtown_las", "pershing1_LAn");}

//CONCRETO
ConcretoT[0] = CreateDynamicObject(18763, 1127.39087, -1554.87073, 21.36578,   0.00000, 90.00000, 90.00000);
ConcretoT[1] = CreateDynamicObject(18763, 1127.38977, -1549.88159, 21.36578,   0.00000, 90.00000, 90.00000);
ConcretoT[2] = CreateDynamicObject(18763, 1127.39917, -1545.05774, 21.36578,   0.00000, 90.00000, 90.00000);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(ConcretoT[TexturizarID], 0, 12925, "sw_sheds", "Metal3_128");}

//ENTRADA
EntradaT[0] = CreateDynamicObject(7586, 1129.58691, -1443.82361, 9.25372,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(EntradaT[0], 1, 4887, "downtown_las", "pershing1_LAn");

//FUENTES
FuentesT[0] = CreateDynamicObject(9833, 1150.22363, -1419.14661, 18.02466,   0.00000, 0.00000, 0.00000);
FuentesT[1] = CreateDynamicObject(9833, 1106.49377, -1419.58826, 18.03784,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(FuentesT[TexturizarID], 0, 4887, "downtown_las", "pershing1_LAn");}

//TEXTO
Create3DTextLabel("Toca el "purpleT"claxón"whiteA" o presiona la tecla "purpleT"'H' "whiteA"para abrir la puerta", -1, 1128.57410, -1423.94519, 15.68583, 30.0, 0);
Create3DTextLabel("Toca el "purpleT"claxón"whiteA" o presiona la tecla "purpleT"'H' "whiteA"para abrir la puerta", -1, 1175.96155, -1489.62683, 14.28355, 30.0, 0);

///////////////////////////////////////////////////////////////BASE FORELLI///////////////////////////////////////////////////////////////////////////////////////////////
//MAPS
CreateDynamicObject(2985, 1269.61450, -833.29071, 82.12932,   0.00000, 0.00000, -90.66000);
CreateDynamicObject(2985, 1293.34656, -833.28876, 82.12932,   0.00000, 0.00000, -90.66000);
CreateDynamicObject(3794, 1270.41772, -774.69189, 95.45609,   0.00000, 0.00000, -65.52000);
CreateDynamicObject(3794, 1268.57642, -779.53510, 95.45609,   0.00000, 0.00000, -89.22001);
CreateDynamicObject(3794, 1268.01062, -775.84814, 95.45609,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3794, 1272.07117, -778.74121, 95.45609,   0.00000, 0.00000, 59.76000);
CreateDynamicObject(2043, 1274.47778, -776.20544, 95.07330,   1.20002, 86.87994, -143.40001);
CreateDynamicObject(1577, 1293.66772, -768.21521, 94.93903,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1577, 1293.67224, -768.69678, 94.93903,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1577, 1294.66199, -768.32318, 94.93903,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1577, 1294.05200, -769.54504, 94.93903,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1577, 1292.84521, -768.65289, 94.93903,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1577, 1294.87341, -769.08618, 94.93903,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1577, 1292.97852, -769.22284, 94.93903,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2064, 1285.65649, -831.48334, 82.85432,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2064, 1282.81323, -831.45386, 82.85432,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2064, 1279.08472, -831.43176, 82.85432,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2064, 1276.01318, -831.45044, 82.85432,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 1291.33911, -824.25275, 82.41853,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 1291.62671, -824.24274, 82.41853,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 1291.62415, -823.99866, 82.41853,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 1291.34106, -823.98071, 82.41853,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 1291.35291, -823.61243, 82.41853,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 1291.65540, -823.63525, 82.41853,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 1291.68652, -823.33679, 82.41853,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 1291.38391, -823.34576, 82.41853,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1248.97852, -801.68781, 88.17081,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1249.98706, -799.17621, 88.34904,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1259.30554, -789.12463, 91.41618,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2908, 1287.36035, -802.02374, 84.36362,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1646, 1263.71753, -798.05518, 87.55264,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1646, 1263.68213, -806.62274, 87.55264,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1646, 1271.12512, -797.84705, 87.55264,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1646, 1278.58960, -798.09479, 87.55264,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2931, 1291.74707, -832.76678, 81.99206,   0.00000, 0.00000, 233.09987);
CreateDynamicObject(1421, 1292.13171, -822.39325, 82.81705,   0.00000, 0.00000, -52.68002);
CreateDynamicObject(2358, 1292.89905, -824.28436, 82.29868,   0.00000, 0.00000, -129.66002);
CreateDynamicObject(1271, 1293.34546, -826.01923, 82.49127,   0.00000, 0.00000, -53.27999);
CreateDynamicObject(13673, 1285.76660, -676.59351, 81.37500,   0.00000, 0.00000, 0.00000);

//REJAS
RejaF1[0] = CreateDynamicObject(19913, 1274.59473, -767.20947, 96.21542,   0.00000, 0.00000, 0.00000);
RejaF1[1] = CreateDynamicObject(19913, 1312.90845, -788.37122, 86.11324,   0.00000, 15.00000, -65.78000);
RejaF1[2] = CreateDynamicObject(19913, 1278.99548, -767.22162, 96.21542,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(RejaF1[TexturizarID], 0, 8401, "vgshpground", "greenwall2");}


RejaF2[0] = CreateDynamicObject(974, 1322.57336, -811.29480, 80.42341,   0.00000, 0.00000, 90.30001);
RejaF2[1] =CreateDynamicObject(974, 1322.55139, -811.31213, 77.28423,   0.00000, 0.00000, 90.30001);
RejaF2[2] =CreateDynamicObject(974, 1322.72839, -817.75732, 80.40692,   0.00000, 0.00000, 90.30001);
RejaF2[3] =CreateDynamicObject(974, 1322.68433, -823.80652, 80.40692,   0.00000, 0.00000, 90.30001);
RejaF2[4] =CreateDynamicObject(974, 1324.57800, -826.42285, 74.79763,   0.00000, 0.00000, 0.00000);
RejaF2[5] =CreateDynamicObject(974, 1318.14124, -825.75397, 76.34978,   0.00000, 0.00000, -10.44000);
RejaF2[6] =CreateDynamicObject(974, 1311.56104, -824.53772, 77.16018,   0.00000, 0.00000, -10.44000);
RejaF2[7] =CreateDynamicObject(974, 1305.09851, -823.34454, 77.58825,   0.00000, 0.00000, -10.44000);
RejaF2[8] =CreateDynamicObject(974, 1298.89709, -822.17151, 78.62720,   0.00000, 0.00000, -10.44000);
for(new TexturizarID; TexturizarID < 9; TexturizarID++){SetDynamicObjectMaterial(RejaF2[TexturizarID], 0, 8401, "vgshpground", "greenwall2"),SetDynamicObjectMaterial(RejaF2[TexturizarID], 1, 8401, "vgshpground", "greenwall2");}



//PUERTAS REJAS
PuertaF[0] = CreateDynamicObject(19912, 1252.12964, -768.10156, 93.83135,   0.00000, 0.00000, 0.00000);
PuertaF[1] = CreateDynamicObject(19912, 1322.54871, -814.33185, 73.89875,   0.00000, 0.00000, 90.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(PuertaF[TexturizarID], 0, 8401, "vgshpground", "greenwall2");}

//PILARES
PilarF[0] = CreateDynamicObject(8397, 1230.76501, -820.12512, 43.81399,   0.00000, 0.00000, 0.00000);
PilarF[1] = CreateDynamicObject(8397, 1239.50037, -768.07001, 44.84454,   0.00000, 0.00000, 0.00000);
PilarF[2] = CreateDynamicObject(8397, 1251.31531, -767.88409, 44.84454,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(PilarF[TexturizarID], 0, 8401, "vgshpground", "greenwall2");}

//TORRES
TorreF[0] = CreateDynamicObject(3279, 1315.44495, -809.01953, 77.10852,   0.00000, 0.00000, -91.44003);
TorreF[1] = CreateDynamicObject(3279, 1264.37781, -782.29016, 94.41813,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(TorreF[TexturizarID], 0, 8401, "vgshpground", "greenwall2"), SetDynamicObjectMaterial(TorreF[TexturizarID], 2,  8401, "vgshpground", "greenwall2"), SetDynamicObjectMaterial(TorreF[TexturizarID], 8, 8401, "vgshpground", "greenwall2");}

//ESCALERAS
EscaleraF[0] = CreateDynamicObject(3361, 1295.49390, -814.55975, 85.18227,   0.00000, 0.00000, 0.00000);
EscaleraF[1] = CreateDynamicObject(3361, 1293.12463, -814.44513, 86.75507,   0.00000, 0.00000, 0.00000);
EscaleraF[2] = CreateDynamicObject(3361, 1260.14258, -793.59125, 89.23511,   0.00000, 0.00000, 0.00000);
EscaleraF[3] = CreateDynamicObject(3361, 1258.18274, -793.54517, 90.46467,   0.00000, 0.00000, 0.00000);
EscaleraF[4] = CreateDynamicObject(3361, 1257.54541, -780.38971, 93.03848,   0.00000, 0.00000, -89.57996);
EscaleraF[5] = CreateDynamicObject(3361, 1257.52893, -779.08368, 93.91257,   0.00000, 0.00000, -89.57996);
for(new TexturizarID; TexturizarID < 6; TexturizarID++){SetDynamicObjectMaterial(EscaleraF[TexturizarID], 0, 8401, "vgshpground", "greenwall2"),SetDynamicObjectMaterial(EscaleraF[TexturizarID], 1, 8401, "vgshpground", "greenwall2"),SetDynamicObjectMaterial(EscaleraF[TexturizarID], 2, 8401, "vgshpground", "greenwall2"), SetDynamicObjectMaterial(EscaleraF[TexturizarID], 3, 8401, "vgshpground", "greenwall2");}

//SOMBRILLAS
SombrillaF[0] = CreateDynamicObject(642, 1262.77551, -806.50092, 88.67447,   0.00000, 0.00000, 0.00000);
SombrillaF[1] = CreateDynamicObject(642, 1262.74646, -797.75800, 88.67447,   0.00000, 0.00000, 0.00000);
SombrillaF[2] = CreateDynamicObject(642, 1270.30310, -797.69745, 88.67447,   0.00000, 0.00000, 0.00000);
SombrillaF[3] = CreateDynamicObject(642, 1277.91614, -797.79401, 88.67447,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 4; TexturizarID++){SetDynamicObjectMaterial(SombrillaF[TexturizarID], 0, 16271, "des_factory", "corr_2_plaintiledblue");}


//PARED
ParedF[0] = CreateDynamicObject(19407, 1239.39270, -769.46783, 92.15686,   0.00000, 0.00000, 0.00000);
ParedF[1] = CreateDynamicObject(19407, 1239.41187, -772.56586, 91.80474,   0.00000, 0.00000, 0.00000);
ParedF[2] = CreateDynamicObject(19407, 1239.42249, -775.70953, 91.47017,   0.00000, 0.00000, 0.00000);
ParedF[3] = CreateDynamicObject(19407, 1239.41638, -778.77844, 91.27139,   0.00000, 0.00000, 0.00000);
ParedF[4] = CreateDynamicObject(19407, 1239.38416, -781.81451, 90.74239,   0.00000, 0.00000, 0.00000);
ParedF[5] = CreateDynamicObject(19407, 1239.40454, -785.03973, 90.37635,   0.00000, 0.00000, 0.00000);
ParedF[6] = CreateDynamicObject(19407, 1239.42871, -788.24353, 90.11549,   0.00000, 0.00000, 0.00000);
ParedF[7] = CreateDynamicObject(19407, 1239.44434, -791.42590, 89.79676,   0.00000, 0.00000, 0.00000);
ParedF[8] = CreateDynamicObject(19407, 1239.44434, -794.61664, 89.57882,   0.00000, 0.00000, 0.00000);
ParedF[9] = CreateDynamicObject(19407, 1239.05652, -797.65253, 89.34384,   0.00000, 0.00000, -15.66001);
ParedF[10] = CreateDynamicObject(19407, 1237.18665, -800.00647, 89.12396,   0.00000, 0.00000, -62.40002);
ParedF[11] = CreateDynamicObject(19407, 1234.19092, -800.86908, 89.12396,   0.00000, 0.00000, -85.26001);
ParedF[12] = CreateDynamicObject(19407, 1231.04907, -801.05725, 89.12396,   0.00000, 0.00000, -87.48001);
ParedF[13] = CreateDynamicObject(19407, 1227.82935, -801.20197, 89.12396,   0.00000, 0.00000, -87.48001);
ParedF[14] = CreateDynamicObject(19407, 1224.62073, -801.33777, 89.12396,   0.00000, 0.00000, -87.72000);
ParedF[15] = CreateDynamicObject(19407, 1221.43811, -801.44330, 89.12396,   0.00000, 0.00000, -87.72000);
ParedF[16] = CreateDynamicObject(19407, 1218.29346, -801.56305, 89.12396,   0.00000, 0.00000, -87.72000);
ParedF[17] = CreateDynamicObject(19407, 1215.25891, -802.30011, 89.03030,   0.00000, 0.00000, -66.00000);
ParedF[18] = CreateDynamicObject(19407, 1212.40906, -803.56116, 88.77793,   0.00000, 0.00000, -63.12000);
ParedF[19] = CreateDynamicObject(19407, 1209.85718, -805.17828, 88.62708,   0.00000, 0.00000, -46.13997);
ParedF[20] = CreateDynamicObject(19407, 1207.83936, -807.39862, 88.32578,   0.00000, 0.00000, -38.81998);
ParedF[21] = CreateDynamicObject(19407, 1205.92358, -809.79889, 88.05346,   0.00000, 0.00000, -30.65997);
ParedF[22] = CreateDynamicObject(19407, 1204.82568, -812.27502, 87.73796,   0.00000, 0.00000, -17.03996);
ParedF[23] = CreateDynamicObject(19407, 1204.02637, -815.23724, 87.22147,   0.00000, 0.00000, -10.85995);
ParedF[24] = CreateDynamicObject(19407, 1204.01868, -818.17535, 86.86180,   0.00000, 0.00000, 9.18003);
ParedF[25] = CreateDynamicObject(19407, 1204.45276, -821.36926, 86.41133,   0.00000, 0.00000, 7.38003);
ParedF[26] = CreateDynamicObject(19407, 1205.44055, -824.32904, 86.22192,   0.00000, 0.00000, 26.22003);
ParedF[27] = CreateDynamicObject(19407, 1206.84192, -826.76019, 85.79168,   0.00000, 0.00000, 31.92002);
ParedF[28] = CreateDynamicObject(19407, 1208.79480, -829.18793, 85.45601,   0.00000, 0.00000, 43.20004);
ParedF[29] = CreateDynamicObject(19407, 1211.10144, -831.30951, 85.03640,   0.00000, 0.00000, 50.16005);
ParedF[30] = CreateDynamicObject(19407, 1213.55652, -833.00684, 84.94454,   0.00000, 0.00000, 61.14005);
ParedF[31] = CreateDynamicObject(19407, 1216.24854, -834.57855, 84.80582,   0.00000, 0.00000, 62.70005);
ParedF[32] = CreateDynamicObject(19407, 1219.10364, -836.02338, 84.77008,   0.00000, 0.00000, 66.36005);
ParedF[33] = CreateDynamicObject(19407, 1222.11816, -837.10205, 84.65761,   0.00000, 0.00000, 72.30004);
ParedF[34] = CreateDynamicObject(19407, 1225.14124, -837.95526, 84.65761,   0.00000, 0.00000, 78.24004);
ParedF[35] = CreateDynamicObject(19407, 1228.22974, -838.47015, 84.65761,   0.00000, 0.00000, 80.70001);
ParedF[36] = CreateDynamicObject(19407, 1231.35938, -838.67957, 84.65761,   0.00000, 0.00000, 90.23999);
ParedF[37] = CreateDynamicObject(19407, 1234.42896, -838.46802, 84.65761,   0.00000, 0.00000, 97.49998);
ParedF[38] = CreateDynamicObject(19407, 1237.48279, -837.71393, 84.57981,   0.00000, 0.00000, 108.53998);
ParedF[39] = CreateDynamicObject(19407, 1240.41724, -836.54230, 84.57981,   0.00000, 0.00000, 117.23998);
ParedF[40] = CreateDynamicObject(19407, 1243.13562, -834.90057, 84.57981,   0.00000, 0.00000, 124.19999);
ParedF[41] = CreateDynamicObject(19407, 1245.56958, -832.87836, 84.57981,   0.00000, 0.00000, 133.43997);
ParedF[42] = CreateDynamicObject(19407, 1247.66846, -830.70361, 84.57981,   0.00000, 0.00000, 137.39992);
ParedF[43] = CreateDynamicObject(19407, 1249.38892, -828.27563, 84.57981,   0.00000, 0.00000, 149.81990);
ParedF[44] = CreateDynamicObject(19407, 1250.64087, -825.45453, 84.57981,   0.00000, 0.00000, 162.59981);
ParedF[45] = CreateDynamicObject(19407, 1251.60278, -822.47571, 84.57981,   0.00000, 0.00000, 167.51979);
ParedF[46] = CreateDynamicObject(19407, 1252.11365, -819.39282, 84.57981,   0.00000, 0.00000, 173.27975);
for(new TexturizarID; TexturizarID < 47; TexturizarID++){SetDynamicObjectMaterial(ParedF[TexturizarID], 0, 8401, "vgshpground", "greenwall2");}


//MADDOG MAP
MADDOGF[0] = CreateDynamicObject(13724, 1254.39844, -803.17188, 85.96094,   0.0, 0.00000, 0.0);
SetDynamicObjectMaterial(MADDOGF[0], 1, 1257, "bustopm", "CJ_GREENMETAL");
SetDynamicObjectMaterial(MADDOGF[0], 5, 16434, "des_stwnsigns1", "dustyjade_128");
SetDynamicObjectMaterial(MADDOGF[0], 6, 17562, "coast_apts", "ws_garagedoor2_green");
SetDynamicObjectMaterial(MADDOGF[0], 9, 3698, "comedbarrio1_la", "greenwall2");
SetDynamicObjectMaterial(MADDOGF[0], 12, 1257, "bustopm", "CJ_GREENMETAL");

MADDOGRF[0] = CreateDynamicObject(13744, 1272.5938, -803.1094, 86.3594,  0.0, 0.0, 0.0);
SetDynamicObjectMaterial(MADDOGF[0], 0, 3698, "comedbarrio1_la", "greenwall2");



//TEXTOS
Create3DTextLabel("Toca el "blueF"claxón"whiteA" o presiona la tecla "blueF"'H' "whiteA"para abrir la puerta", -1, 1245.62427, -767.81311, 92.35355, 30.0, 0);
Create3DTextLabel("Toca el "blueF"claxón"whiteA" o presiona la tecla "blueF"'H' "whiteA"para abrir la puerta", -1, 1322.55273, -820.16614, 72.19093, 30.0, 0);

///////////////////////////////////////////////////////////////BASE SINDACCO///////////////////////////////////////////////////////////////////////////////////////////////
//MAP/////////////////
CreateDynamicObject(3934, 681.09985, -1205.79810, 25.29722,   0.00000, 0.00000, 38.82002);
CreateDynamicObject(726, 679.77557, -1247.53723, 13.25878,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(726, 723.62848, -1217.26489, 16.36852,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(726, 751.28070, -1179.61780, 19.59695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(726, 777.55682, -1164.28223, 21.21730,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 717.78174, -1284.23950, 17.10248,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 718.19891, -1284.37524, 17.10248,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 718.10999, -1285.06909, 17.10248,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 718.73767, -1284.82202, 17.10248,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1824, 724.79913, -1282.72510, 17.13215,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1824, 724.87866, -1269.85803, 17.13215,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 720.88977, -1258.80957, 17.06017,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 725.49854, -1262.77722, 17.06017,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 720.84540, -1296.10474, 17.09126,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 725.59021, -1289.61145, 17.09126,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1369, 718.64423, -1283.24475, 17.31002,   0.00000, 0.00000, 132.12001);
CreateDynamicObject(3092, 723.25055, -1275.97546, 20.93523,   0.00000, 90.00000, -45.18000);
CreateDynamicObject(3092, 721.84930, -1277.23779, 20.93523,   0.00000, 90.00000, -121.62006);
CreateDynamicObject(2908, 721.66046, -1281.42029, 20.71490,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18963, 723.48120, -1279.72278, 20.71969,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3012, 723.49579, -1280.71387, 20.10488,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19944, 721.59595, -1269.98425, 20.61534,   0.00000, 0.00000, -33.12000);
CreateDynamicObject(2907, 722.18335, -1273.48511, 20.77818,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19474, 730.82501, -1276.05920, 17.51230,   0.00000, 80.00000, 0.00000);
CreateDynamicObject(1739, 730.33661, -1278.34045, 17.49956,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(1739, 730.12048, -1274.07861, 17.49960,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(348, 729.54559, -1275.10693, 16.68900,   90.00000, 0.00000, -42.48001);
CreateDynamicObject(19352, 730.12256, -1274.13696, 17.21217,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 729.76422, -1278.45862, 16.66251,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 729.63763, -1278.29858, 16.66251,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 729.56708, -1278.42419, 16.66251,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 729.62201, -1278.57568, 16.66251,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19348, 729.77435, -1273.85950, 17.51280,   2.00000, 180.00000, 100.32004);
CreateDynamicObject(1281, 735.87347, -1303.17664, 13.35773,   0.00000, 0.00000, -19.56000);
CreateDynamicObject(1281, 738.71686, -1298.18103, 13.35773,   0.00000, 0.00000, 50.40001);
CreateDynamicObject(1281, 732.61786, -1298.90894, 13.35773,   0.00000, 0.00000, 102.90006);
CreateDynamicObject(1281, 733.64246, -1293.39319, 13.35773,   0.00000, 0.00000, 158.28011);
CreateDynamicObject(1216, 740.49268, -1188.75659, 19.71445,   0.00000, 0.00000, -125.10005);
CreateDynamicObject(1256, 783.58051, -1269.25891, 13.12509,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1256, 783.61072, -1274.51990, 13.12509,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2005, 756.54816, -1258.59595, 12.46660,   0.00000, 0.00000, 179.94009);
CreateDynamicObject(2005, 756.02313, -1258.59363, 12.46660,   0.00000, 0.00000, 179.94009);
CreateDynamicObject(2005, 755.40308, -1258.58472, 12.46660,   0.00000, 0.00000, 179.94009);
CreateDynamicObject(2005, 755.26300, -1258.56470, 12.46660,   0.00000, 0.00000, 179.94009);
CreateDynamicObject(1225, 673.18793, -1311.82898, 13.05055,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 672.36194, -1312.48938, 13.05055,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 673.87811, -1312.75073, 13.05055,   0.00000, 0.00000, 0.00000);


//REJAS///////////////////////7
RejaS[0] = CreateDynamicObject(987, 673.09106, -1211.49744, 15.15307,   0.00000, 0.00000, -142.56003);
RejaS[1] = CreateDynamicObject(987, 673.09106, -1211.49744, 19.93241,   0.00000, 0.00000, -142.56003);
RejaS[2] = CreateDynamicObject(987, 655.08282, -1235.24658, 16.48940,   0.00000, 0.00000, 169.86014);
RejaS[3] = CreateDynamicObject(987, 643.61218, -1232.94250, 16.48940,   0.00000, 0.00000, 276.84003);
RejaS[4] = CreateDynamicObject(987, 645.10229, -1244.76697, 16.48940,   0.00000, 0.00000, 275.94006);
RejaS[5] = CreateDynamicObject(987, 646.58191, -1258.67883, 16.48940,   0.00000, 0.00000, 275.94006);
RejaS[6] = CreateDynamicObject(987, 647.52161, -1270.10095, 16.48940,   0.00000, 0.00000, 275.94006);
RejaS[7] = CreateDynamicObject(987, 648.64532, -1280.71021, 15.18305,   0.00000, 0.00000, 268.08020);
RejaS[8] = CreateDynamicObject(987, 648.43915, -1291.70117, 14.55296,   0.00000, 0.00000, 265.74023);
RejaS[9] = CreateDynamicObject(987, 648.33673, -1297.47717, 13.35472,   0.00000, 0.00000, 265.74023);
RejaS[10] = CreateDynamicObject(987, 647.47607, -1309.19080, 13.24146,   0.00000, 0.00000, 354.95914);
RejaS[11] = CreateDynamicObject(987, 645.69122, -1250.65503, 16.48940,   0.00000, 0.00000, 275.94006);
RejaS[12] = CreateDynamicObject(987, 702.28522, -1206.84070, 17.97496,   0.00000, 0.00000, 149.10013);
RejaS[13] = CreateDynamicObject(987, 702.28522, -1206.84070, 20.71092,   0.00000, 0.00000, 149.10013);
RejaS[14] = CreateDynamicObject(987, 702.28522, -1206.84070, 25.49072,   0.00000, 0.00000, 149.10013);
RejaS[15] = CreateDynamicObject(987, 692.42163, -1200.90466, 25.19465,   0.00000, 0.00000, 149.10013);
RejaS[16] = CreateDynamicObject(987, 683.05072, -1195.00476, 25.26686,   0.00000, 0.00000, 217.86002);
RejaS[17] = CreateDynamicObject(987, 673.65210, -1202.31958, 25.17312,   0.00000, 0.00000, 217.86002);
RejaS[18] = CreateDynamicObject(987, 665.91888, -1207.70898, 25.21282,   0.00000, 0.00000, 307.79977);
for(new TexturizarID; TexturizarID < 19; TexturizarID++){SetDynamicObjectMaterial(RejaS[TexturizarID], 0, 10977, "mission_sfse", "ws_apartmentbrown2");}


Reja2S[0] = CreateDynamicObject(8210, 702.24951, -1309.79822, 15.49761,   0.00000, 0.00000, 0.00000);
Reja2S[1] = CreateDynamicObject(8210, 787.25098, -1252.55750, 15.70815,   0.00000, 0.00000, 90.00000);
Reja2S[2] = CreateDynamicObject(8210, 787.33282, -1197.54346, 19.70585,   0.00000, -5.00000, 90.00000);
Reja2S[3] = CreateDynamicObject(8210, 787.04529, -1186.53333, 22.21913,   0.00000, -5.00000, 90.00000);
Reja2S[4] = CreateDynamicObject(8210, 759.57526, -1142.61267, 25.17430,   0.00000, 0.00000, 180.00000);
Reja2S[5] = CreateDynamicObject(8210, 725.83661, -1166.46716, 23.91211,   0.00000, 0.00000, 241.01952);
Reja2S[6] = CreateDynamicObject(8210, 716.26282, -1183.51685, 22.27393,   0.00000, 0.00000, 239.09958);
Reja2S[7] = CreateDynamicObject(8369, 747.50568, -1295.16626, 16.67370,   0.00000, 0.00000, 90.00000);
for(new TexturizarID; TexturizarID < 8; TexturizarID++){SetDynamicObjectMaterial(Reja2S[TexturizarID], 0, 10977, "mission_sfse", "ws_apartmentbrown2");}

//PUERTAS//////////////////////////////////////
PuertaS[0] = CreateDynamicObject(19912, 670.73492, -1310.06665, 15.32916,   0.00000, 0.00000, 0.00000);
PuertaS[1] = CreateDynamicObject(19912, 786.40363, -1146.68579, 25.53655,   0.00000, 0.00000, 90.00000);
PuertaS[2] = CreateDynamicObject(19912, 663.28766, -1222.56018, 17.63250,   0.00000, 0.00000, 61.13999);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(PuertaS[TexturizarID], 0, 10977, "mission_sfse", "ws_apartmentbrown2");}

//TORRES//////////////////////////////////////
TorreS[0] = CreateDynamicObject(3279, 783.96582, -1173.52612, 19.13782,   0.00000, 0.00000, -91.01999);
TorreS[1] = CreateDynamicObject(3279, 776.96527, -1305.68396, 12.54987,   0.00000, 0.00000, -180.71997);
TorreS[2] = CreateDynamicObject(3279, 656.89178, -1243.39124, 13.16934,   0.00000, 0.00000, -5.94002);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(TorreS[TexturizarID], 0, 10977, "mission_sfse", "ws_apartmentbrown2"),SetDynamicObjectMaterial(TorreS[TexturizarID], 2, 10977, "mission_sfse", "ws_apartmentbrown2"),SetDynamicObjectMaterial(TorreS[TexturizarID], 8, 10977, "mission_sfse", "ws_apartmentbrown2");}

//ESCALERAS////////////////////////////////////
EscaleraS[0] = CreateDynamicObject(3361, 689.84253, -1207.53052, 16.55485,   0.00000, 0.00000, 37.02002);
EscaleraS[1] = CreateDynamicObject(3361, 685.06506, -1211.13367, 20.59868,   0.00000, 0.00000, 37.02002);
EscaleraS[2] = CreateDynamicObject(3361, 682.05579, -1213.58362, 23.21957,   0.00000, 0.00000, 37.02002);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetDynamicObjectMaterial(EscaleraS[TexturizarID], 0, 10977, "mission_sfse", "ws_apartmentbrown2"),SetDynamicObjectMaterial(EscaleraS[TexturizarID], 1, 10977, "mission_sfse", "ws_apartmentbrown2"),SetDynamicObjectMaterial(EscaleraS[TexturizarID], 2, 10977, "mission_sfse", "ws_apartmentbrown2"), SetDynamicObjectMaterial(EscaleraS[TexturizarID], 3, 10977, "mission_sfse", "ws_apartmentbrown2");}


//ESTATUA////////////////////////////////////77
EstatuaS[0] = CreateDynamicObject(14467, 755.66406, -1259.15503, 15.20383,   0.00000, 0.00000, -179.88002);
SetDynamicObjectMaterial(EstatuaS[0], 0, 8463, "vgseland", "tiadbuddhagold");
SetDynamicObjectMaterial(EstatuaS[0], 1, 8463, "vgseland", "tiadbuddhagold");
DineroEstatuaS[0] = CreateDynamicObject(1550, 756.75769, -1259.46057, 16.48253,   0.00000, 0.00000, 0.00000);
SetDynamicObjectMaterial(DineroEstatuaS[0], 0, 8463, "vgseland", "tiadbuddhagold");
SetDynamicObjectMaterial(DineroEstatuaS[0], 1, 8463, "vgseland", "tiadbuddhagold");

//TEXT
Create3DTextLabel("Toca el "brownS"claxón"whiteA" o presiona la tecla "brownS"'H' "whiteA"para abrir la puerta", -1,  664.84869, -1310.05334, 13.36430, 40.0, 0);
Create3DTextLabel("Toca el "brownS"claxón"whiteA" o presiona la tecla "brownS"'H' "whiteA"para abrir la puerta", -1,  786.29547, -1151.59583, 23.45992, 40.0, 0);
Create3DTextLabel("Toca el "brownS"claxón"whiteA" o presiona la tecla "brownS"'H' "whiteA"para abrir la puerta", -1,  660.77594, -1228.03735, 16.06856, 40.0, 0);

///////////////////////////////////////////////////////////MAPS EVENTO SUPERVIVENCIA (VIRTUALWORLD 2)/////////////////////////////////////////////////////////////
CreateDynamicObject(19531, 1161.49841, 287.64569, 17.82080,   90.00000, 66.00000, 0.00000, 2);
CreateDynamicObject(19531, 1212.16821, 401.44836, 17.82080,   90.00000, 66.00000, 0.00000, 2);
CreateDynamicObject(19531, 1262.68164, 514.97809, 17.82080,   90.00000, 66.00000, 0.00000, 2);
CreateDynamicObject(19531, 1332.35583, 518.61688, 17.82080,   90.00000, -30.00000, 0.00000, 2);
CreateDynamicObject(19531, 1440.19531, 456.40509, 17.82080,   90.00000, -30.00000, 0.00000, 2);
CreateDynamicObject(19531, 1190.28076, 201.41826, 17.82080,   90.00000, -30.00000, 0.00000, 2);
CreateDynamicObject(19531, 1298.15637, 139.09329, 17.82080,   90.00000, -30.00000, 0.00000, 2);
CreateDynamicObject(19531, 1373.51575, 167.28355, 17.82080,   90.00000, 66.00000, 0.00000, 2);
CreateDynamicObject(19531, 1423.91284, 280.50665, 17.82080,   90.00000, 66.00000, 0.00000, 2);
CreateDynamicObject(19531, 1474.44324, 394.02878, 17.82080,   90.00000, 66.00000, 0.00000, 2);

///////////////////////////////////////////////////////////MAPS EVENTO CACERIA (VIRTUALWORLD 2)////////////////////////////////////////////////////////////////////
CreateDynamicObject(19531, -2595.23291, 2070.91699, 15.17262,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2470.77979, 2070.93286, 15.17262,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2470.62402, 2070.72241, -109.38195,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2638.57471, 2132.64526, 15.17260,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2638.56104, 2248.61694, 15.17260,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2638.72705, 2370.81836, 15.17260,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2638.74243, 2494.25928, 15.17260,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2638.95190, 2556.88745, 55.51740,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2578.36768, 2546.36426, 55.51740,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2454.64282, 2546.45239, 55.51740,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2332.07373, 2546.42798, 55.51740,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2217.63989, 2546.41138, 55.51740,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2155.66626, 2485.33081, 55.51740,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2155.55029, 2362.11426, 55.51740,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2155.52832, 2237.95972, 55.51740,   90.00000, 90.00000, 0.00000,2 );
CreateDynamicObject(19531, -2155.48218, 2113.35938, 55.51740,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2155.66626, 2485.33081, -69.40572,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2217.63989, 2546.41138, -69.43821,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2155.55029, 2362.11426, -69.16942,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2155.52832, 2237.95972, -69.41833,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2155.48218, 2113.35938, -69.31721,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, -2346.12378, 2070.91113, 15.17262,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2346.06348, 2070.88232, -109.38195,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2221.64429, 2070.83813, 15.17262,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2221.41260, 2070.80859, -109.38195,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, -2097.54639, 2070.77734, 15.17262,   90.00000, 0.00000, 0.00000, 2);

////////////////////////////////////////////////////////////MAPS EVENTO RETADORES (VIRTUALWORLD 2)/////////////////////////////////////////////////////////////////
CreateDynamicObject(19531, 2179.99683, 56.51504, 23.72610,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, 2200.96606, 176.58144, 23.72610,   90.00000, 70.00000, 0.00000, 2);
CreateDynamicObject(19531, 2283.02295, 235.09050, 23.72610,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, 2407.31079, 235.07332, 23.72610,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, 2481.20483, 206.02490, 23.72610,   90.00000, -60.00000, 0.00000, 2);
CreateDynamicObject(19531, 2574.26196, 152.59169, 23.72610,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, 2573.86987, 91.05861, 23.72610,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, 2574.02637, -32.82045, 23.72610,   90.00000, 90.00000, 0.00000, 2);
CreateDynamicObject(19531, 2511.93311, -95.17126, 23.72610,   90.00000, 90.00000, 90.00000, 2);
CreateDynamicObject(19531, 2395.83545, -123.57494, 23.72610,   90.00000, -80.00000, 107.22004, 2);
CreateDynamicObject(19531, 2292.13062, -147.11343, 23.72610,   90.00000, 0.00000, 0.00000, 2);
CreateDynamicObject(19531, 2196.65308, -110.72694, 23.72610,   90.00000, 0.00000, -44.87997, 2);
CreateDynamicObject(19531, 2179.67407, -66.95901, 23.72610,   90.00000, 90.00000, 0.00000, 2);
//MAP PLATAFORMA (Anti /kill) - Minijuegos
CreateDynamicObject(19531, -923.47, 1055.53, 809.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -861.66, 1216.87, 811.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -3237.25, 1657.68, -8575.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -1198.00, 1059.73, 811.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -1087.27, 1111.10, 812.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -1035.54, 1005.05, 811.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -975.43, 1164.11, 811.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -2447.90, -390.37, 809.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -3258.40, -21.83, -1.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -3258.40, -21.83, -1.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -1144.06, 954.91, 812.00, 4.00, 0.00, 25.00);
CreateDynamicObject(19531, -809.65, 1109.54, 811.00, 4.00, 0.00, 25.00);

CreateDynamicObject(1497, 2263.96875, 1675.03125, 1089.42969 + 40.0000,   3.14159, 0.00000, 1.57080, -1, 1);
CreateDynamicObject(14488, 37.66592, 1674.68945, 421.15155 + 40.0000,   0.00000, 0.00000, 267.89929, -1, 1);
CreateDynamicObject(1739, 6.14332, 1630.89575, 424.73898 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1739, -7.85754, 1631.41858, 424.75000 + 40.0000,   0.00000, 0.00000, 177.78009, -1, 1);
CreateDynamicObject(1739, 3.72440, 1629.16101, 424.73901 + 40.0000,   0.00000, 0.00000, 270.00000, -1, 1);
CreateDynamicObject(1739, 0.76497, 1629.33936, 424.73901 + 40.0000,   0.00000, 0.00000, 270.00000, -1, 1);
CreateDynamicObject(1739, -2.17499, 1629.42358, 424.73901 + 40.0000,   0.00000, 0.00000, 270.00000, -1, 1);
CreateDynamicObject(1739, -5.21324, 1629.49500, 424.73901 + 40.0000,   0.00000, 0.00000, 270.00000, -1, 1);
CreateDynamicObject(1739, -5.32313, 1633.08276, 424.73901 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(1739, -2.09026, 1633.08386, 424.73901 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(1739, 0.66585, 1632.90308, 424.73901 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(1739, 3.76405, 1632.82971, 424.73901 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(16782, -11.05159, 1633.67542, 426.33408 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19168, -1.05160, 1626.58997, 426.71210 + 40.0000,   90.00000, 90.00000, 88.20010, -1, 1);
CreateDynamicObject(19171, -2.54612, 1626.63477, 425.21271 + 40.0000,   90.00000, 90.00000, 88.26007, -1, 1);
CreateDynamicObject(19169, -2.54299, 1626.63586, 426.71283 + 40.0000,   90.00000, 90.00000, 88.20007, -1, 1);
CreateDynamicObject(19170, -1.05160, 1626.58997, 425.20840 + 40.0000,   90.00000, 90.00000, 88.26010, -1, 1);
CreateDynamicObject(19173, 2.66050, 1626.49939, 426.37363 + 40.0000,   0.00000, 0.00000, -0.90000, -1, 1);
CreateDynamicObject(19175, -6.82463, 1626.84521, 426.40479 + 40.0000,   0.00000, 0.00000, 180.00000, -1, 1);
CreateDynamicObject(1742, 26.29943, 1658.86548, 418.78363 + 40.0000,   0.00000, 0.00000, 269.70001, -1, 1);
CreateDynamicObject(1742, 26.36429, 1658.86694, 420.81735 + 40.0000,   0.00000, 0.00000, 267.84009, -1, 1);
CreateDynamicObject(1742, 26.28196, 1657.41589, 418.78363 + 40.0000,   0.00000, 0.00000, 270.00000, -1, 1);
CreateDynamicObject(1742, 26.27940, 1657.45715, 420.80768 + 40.0000,   0.00000, 0.00000, 270.00000, -1, 1);
CreateDynamicObject(14455, 26.71622, 1674.36365, 420.37177 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(14455, 26.67154, 1672.87769, 420.37177 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(14455, 26.71622, 1674.36365, 423.79794 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(14455, 26.67154, 1672.87769, 423.75507 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(640, 9.22054, 1636.83679, 419.43961 + 40.0000,   0.00000, 0.00000, 87.72009, -1, 1);
CreateDynamicObject(640, -0.12287, 1637.15894, 419.43961 + 40.0000,   0.00000, 0.00000, 87.78011, -1, 1);
CreateDynamicObject(1491, 23.49711, 1649.32019, 418.78790 + 40.0000,   0.00000, 0.00000, -180.29971, -1, 1);
CreateDynamicObject(1491, 5.45551, 1625.90918, 423.93491 + 40.0000,   0.00000, 0.00000, -1.26000, -1, 1);
CreateDynamicObject(3440, 5.16371, 1625.89429, 424.67688 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3440, 7.24159, 1625.81116, 424.67688 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2921, 7.20302, 1625.73132, 426.67273 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(14467, -47.58016, 1633.81531, 424.91010 + 40.0000,   0.00000, 0.00000, 130.00000, -1, 1);
CreateDynamicObject(14467, -20.44616, 1632.23413, 424.93710 + 40.0000,   0.00000, 0.00000, -130.00000, -1, 1);
CreateDynamicObject(2164, -4.11231, 1626.71021, 423.90424 + 40.0000,   0.00000, 0.00000, 177.84009, -1, 1);
CreateDynamicObject(2164, 1.44229, 1626.51013, 423.90424 + 40.0000,   0.00000, 0.00000, 177.84009, -1, 1);
CreateDynamicObject(19841, -18.30223, 1654.50830, 423.43088 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -18.92990, 1649.01843, 423.72794 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -20.46832, 1649.02600, 423.80499 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -21.12184, 1649.56702, 423.82257 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -21.57315, 1650.56750, 423.80307 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -22.01305, 1651.94116, 423.80307 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -19.85073, 1648.39380, 423.80499 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -19.19935, 1647.85767, 423.81866 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -18.25414, 1647.54211, 423.78424 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -14.77006, 1651.16394, 423.78424 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -15.17573, 1650.23254, 423.71927 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -15.76078, 1649.40845, 423.75235 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -16.34748, 1648.82886, 423.79218 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -17.00550, 1648.24353, 423.77890 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19603, -17.56543, 1647.87952, 423.79800 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(14449, 42.05489, 1674.43176, 417.91214 + 40.0000,   0.00000, 0.00000, 87.72009, -1, 1);
CreateDynamicObject(14449, 32.47122, 1674.80701, 417.91214 + 40.0000,   0.00000, 0.00000, 87.72009, -1, 1);
CreateDynamicObject(3515, -20.11677, 1656.76465, 425.02448 + 40.0000,   270.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1709, -47.25576, 1639.34497, 422.89615 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1709, -42.36362, 1636.95239, 422.89609 + 40.0000,   0.00000, 0.00000, 180.00000, -1, 1);
CreateDynamicObject(2315, -45.35357, 1638.01855, 422.93411 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(16151, -33.16586, 1632.76270, 423.24622 + 40.0000,   0.00000, 0.00000, 268.56006, -1, 1);
CreateDynamicObject(2193, -46.42596, 1648.83350, 422.83221 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2193, -41.77195, 1648.59766, 422.83221 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2193, -40.92982, 1645.36694, 422.83221 + 40.0000,   0.00000, 0.00000, 180.00000, -1, 1);
CreateDynamicObject(2193, -45.43280, 1645.46606, 422.83221 + 40.0000,   0.00000, 0.00000, 180.00000, -1, 1);
CreateDynamicObject(2162, -48.29674, 1644.62158, 422.93530 + 40.0000,   0.00000, 0.00000, 88.56005, -1, 1);
CreateDynamicObject(2162, -48.25063, 1646.37622, 422.93530 + 40.0000,   0.00000, 0.00000, 88.56005, -1, 1);
CreateDynamicObject(2164, -48.20010, 1648.12378, 422.93835 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(2161, -48.20445, 1649.89319, 422.91922 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(2161, -48.20445, 1649.89319, 424.24994 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(2069, -47.37463, 1651.34607, 422.97504 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19172, -48.05430, 1648.48657, 426.62241 + 40.0000,   0.00000, 0.00000, 88.08013, -1, 1);
CreateDynamicObject(1739, -41.78202, 1645.86755, 423.80688 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(1739, -46.23641, 1645.99487, 423.80688 + 40.0000,   0.00000, 0.00000, 90.00000, -1, 1);
CreateDynamicObject(1739, -40.91147, 1648.03613, 423.77240 + 40.0000,   0.00000, 0.00000, 270.00000, -1, 1);
CreateDynamicObject(1739, -45.36264, 1648.33069, 423.77240 + 40.0000,   0.00000, 0.00000, 270.00000, -1, 1);
CreateDynamicObject(362, -39.32246, 1652.06396, 426.11191 + 40.0000,   -26.64002, 34.31996, 1.92000, -1, 1);
CreateDynamicObject(2921, -39.13148, 1651.77856, 425.88739 + 40.0000,   0.00000, 0.00000, 213.65982, -1, 1);
CreateDynamicObject(14455, -48.43263, 1640.70703, 424.40381 + 40.0000,   0.00000, 0.00000, 268.86008, -1, 1);
CreateDynamicObject(19325, -10.19250, 1637.05969, 425.95639 + 40.0000,   0.00000, 0.00000, 88.02007, -1, 1);
CreateDynamicObject(19325, 1.51894, 1636.53870, 425.95642 + 40.0000,   0.00000, 0.00000, 88.00000, -1, 1);
CreateDynamicObject(19325, 7.52106, 1636.34448, 425.95642 + 40.0000,   0.00000, 0.00000, 88.00000, -1, 1);
CreateDynamicObject(19325, -4.06720, 1636.80408, 425.95639 + 40.0000,   0.00000, 0.00000, 87.42006, -1, 1);
CreateDynamicObject(3440, -11.59044, 1628.17261, 424.67688 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3440, -11.49448, 1630.25000, 424.67688 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1491, -11.54161, 1629.97131, 423.95462 + 40.0000,   0.00000, 0.00000, -92.27997, -1, 1);
CreateDynamicObject(3440, 26.72741, 1668.63782, 419.29807 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2120, 18.29000, 1666.80005, 414.11331 + 40.0000,   0.00000, 0.00000, 270.00000, -1, 1);
CreateDynamicObject(335, 16.63583, 1668.82385, 414.26352 + 40.0000,   88.20001, -60.96003, 0.00000, -1, 1);
CreateDynamicObject(19631, 16.63092, 1668.14795, 414.33167 + 40.0000,   -0.90001, -87.84000, 0.00000, -1, 1);
CreateDynamicObject(347, 16.15676, 1668.36816, 414.30487 + 40.0000,   93.41984, -94.44003, 0.00000, -1, 1);
CreateDynamicObject(2680, 18.60514, 1666.63684, 414.07205 + 40.0000,   123.71998, -27.17998, 6.95993, -1, 1);
CreateDynamicObject(19836, 18.13275, 1667.76929, 413.54471 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1491, 15.35269, 1681.25269, 414.51822 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3440, 15.80926, 1681.20471, 417.32080 + 40.0000,   90.00000, 90.00000, 0.00000, -1, 1);
CreateDynamicObject(2922, 17.19096, 1681.35803, 416.24030 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2921, 12.02640, 1671.81152, 416.50482 + 40.0000,   0.00000, 0.00000, 176.04005, -1, 1);
CreateDynamicObject(18642, 16.45025, 1668.04895, 414.29239 + 40.0000,   86.33987, -113.93998, 0.00000, -1, 1);
CreateDynamicObject(18634, 15.76109, 1668.65869, 414.29211 + 40.0000,   1.32000, 92.28000, -88.74000, -1, 1);
CreateDynamicObject(18633, 15.74190, 1668.16321, 414.29211 + 40.0000,   0.00000, 90.00000, 14.27999, -1, 1);
CreateDynamicObject(14608, 31.90176, 1661.76892, 407.68674 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(14608, 8.15558, 1661.87854, 407.68671 + 40.0000,   0.00000, 0.00000, -90.00000, -1, 1);
CreateDynamicObject(1550, 6.03767, 1678.60852, 406.47263 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1550, 6.47530, 1678.39441, 406.47263 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1550, 5.83084, 1678.14453, 406.47263 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1550, 6.72305, 1678.79150, 406.47263 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1550, 8.31052, 1678.44385, 406.47263 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1550, 6.43571, 1677.87585, 406.47263 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1550, 6.93643, 1678.33875, 406.47263 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1550, 6.67445, 1677.12915, 406.47263 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1550, 7.28262, 1678.70789, 406.47263 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1491, 20.83048, 1658.91394, 406.31870 + 40.0000,   0.00000, 0.00000, -180.53976, -1, 1);
CreateDynamicObject(3440, 21.08551, 1658.82544, 407.80408 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3440, 19.06610, 1658.84668, 407.80408 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3440, 20.17564, 1658.85107, 409.06119 + 40.0000,   0.00000, 90.00000, -0.36000, -1, 1);
CreateDynamicObject(14782, -40.95903, 1628.94263, 423.93460 + 40.0000,   0.00000, 0.00000, 178.20007, -1, 1);
CreateDynamicObject(14455, 26.55906, 1667.22803, 423.75507 + 40.0000,   0.00000, 0.00000, 88.80006, -1, 1);
CreateDynamicObject(14455, 26.35402, 1661.55444, 423.75507 + 40.0000,   0.00000, 0.00000, 87.72010, -1, 1);
CreateDynamicObject(3386, 26.50601, 1670.28674, 418.75729 + 40.0000,   0.00000, 0.00000, -1.02000, -1, 1);
CreateDynamicObject(19808, 25.92270, 1670.39771, 420.03909 + 40.0000,   0.00000, 0.00000, 270.35999, -1, 1);
CreateDynamicObject(1742, 26.35838, 1660.29395, 418.78363 + 40.0000,   0.00000, 0.00000, 269.70001, -1, 1);
CreateDynamicObject(1742, 26.35838, 1660.29395, 420.81628 + 40.0000,   0.00000, 0.00000, 269.70001, -1, 1);
CreateDynamicObject(14455, 26.35402, 1661.55444, 420.33862 + 40.0000,   0.00000, 0.00000, 87.72010, -1, 1);
CreateDynamicObject(348, 26.46553, 1667.69971, 421.65219 + 40.0000,   3.95999, -36.36002, -99.65996, -1, 1);
CreateDynamicObject(348, 26.51313, 1667.73499, 421.65219 + 40.0000,   3.95999, -36.36002, -277.07990, -1, 1);
CreateDynamicObject(3761, 28.25662, 1645.78320, 420.71628 + 40.0000,   0.00000, 0.00000, 0.36000, -1, 1);
CreateDynamicObject(3761, 28.29033, 1637.32190, 420.75009 + 40.0000,   0.00000, 0.00000, 0.12000, -1, 1);
CreateDynamicObject(3761, 28.32096, 1629.54407, 420.75009 + 40.0000,   0.00000, 0.00000, 0.18000, -1, 1);
CreateDynamicObject(2619, 22.60210, 1627.23621, 421.24039 + 40.0000,   0.00000, 0.00000, 268.92004, -1, 1);
CreateDynamicObject(3797, 35.95230, 1644.22473, 421.05661 + 40.0000,   0.00000, 0.00000, 52.79994, -1, 1);
CreateDynamicObject(3066, 38.57114, 1643.72302, 419.45587 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3066, 38.46169, 1631.10889, 419.45587 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3016, 26.17557, 1642.97363, 418.83295 + 40.0000,   0.00000, 0.00000, -62.09999, -1, 1);
CreateDynamicObject(2991, 32.42982, 1647.84155, 419.34067 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2991, 32.42982, 1647.84155, 420.52039 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3794, 32.06973, 1628.49243, 419.24246 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3794, 32.25956, 1630.61584, 419.24246 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3794, 32.11922, 1632.47852, 419.24246 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2068, 23.13381, 1643.48779, 422.54849 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2068, 22.98442, 1634.07617, 422.69424 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2985, 37.28287, 1638.14343, 418.79669 + 40.0000,   0.00000, 0.00000, 154.56021, -1, 1);
CreateDynamicObject(2985, 36.91549, 1637.11914, 418.79669 + 40.0000,   0.00000, 0.00000, 184.44017, -1, 1);
CreateDynamicObject(1583, 5.96349, 1661.11584, 419.40146 + 40.0000,   0.00000, 0.00000, 86.82005, -1, 1);
CreateDynamicObject(1583, 5.96349, 1661.11584, 422.15851 + 40.0000,   0.00000, 0.00000, 86.82005, -1, 1);
CreateDynamicObject(1583, 6.13170, 1663.57727, 422.15851 + 40.0000,   0.00000, 0.00000, 86.82005, -1, 1);
CreateDynamicObject(1583, 6.36366, 1665.94507, 422.15851 + 40.0000,   0.00000, 0.00000, 86.82005, -1, 1);
CreateDynamicObject(1583, 6.36366, 1665.94507, 419.52582 + 40.0000,   0.00000, 0.00000, 86.82005, -1, 1);
CreateDynamicObject(1583, 6.22094, 1658.34998, 422.15851 + 40.0000,   0.00000, 0.00000, 86.82005, -1, 1);
CreateDynamicObject(1583, 5.41977, 1655.79565, 422.15851 + 40.0000,   0.00000, 0.00000, 86.82005, -1, 1);
CreateDynamicObject(1583, 5.41977, 1655.79565, 419.15942 + 40.0000,   0.00000, 0.00000, 86.82005, -1, 1);
CreateDynamicObject(2977, 21.29711, 1628.58130, 418.62015 + 40.0000,   0.00000, 0.00000, -42.35999, -1, 1);
CreateDynamicObject(2927, -34.32682, 1654.85791, 424.61472 + 40.0000,   0.00000, 0.00000, -1.44000, -1, 1);
CreateDynamicObject(19799, -35.33165, 1654.70691, 424.14490 + 40.0000,   0.00000, 0.00000, 178.86005, -1, 1);
CreateDynamicObject(1829, 6.08402, 1666.63330, 406.57590 + 40.0000,   0.00000, 0.00000, 90.78009, -1, 1);
CreateDynamicObject(2991, 33.57502, 1677.56580, 406.64886 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2991, 33.57502, 1677.56580, 407.84824 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2991, 33.60325, 1675.55786, 406.64886 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2991, 33.60325, 1675.55786, 407.78918 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3630, 7.06948, 1672.04578, 407.46249 + 40.0000,   0.00000, 0.00000, 89.76012, -1, 1);
CreateDynamicObject(3796, 32.16889, 1670.95813, 406.11737 + 40.0000,   0.00000, 0.00000, 30.84000, -1, 1);
CreateDynamicObject(1491, 20.77743, 1679.19299, 406.11758 + 40.0000,   0.00000, 0.00000, -180.83951, -1, 1);
CreateDynamicObject(3440, 19.05910, 1679.20667, 406.58282 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3440, 21.02160, 1679.18958, 406.58282 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3440, 19.81099, 1679.21790, 408.91180 + 40.0000,   0.00000, 90.00000, 0.00000, -1, 1);
CreateDynamicObject(2922, 21.74997, 1679.35315, 407.86575 + 40.0000,   0.00000, 0.00000, -1.50000, -1, 1);
CreateDynamicObject(2921, 22.32722, 1680.51575, 409.45093 + 40.0000,   -38.94004, -22.26003, 4.73993, -1, 1);
CreateDynamicObject(2985, 17.85204, 1681.60339, 408.31732 + 40.0000,   0.00000, 30.00000, -7.44000, -1, 1);
CreateDynamicObject(18643, 22.19316, 1682.51929, 407.41544 + 40.0000,   0.00000, 0.00000, 179.22006, -1, 1);
CreateDynamicObject(18643, 22.25476, 1683.25427, 407.39651 + 40.0000,   0.00000, 0.00000, 179.22006, -1, 1);
CreateDynamicObject(18643, 22.19526, 1684.04407, 407.29611 + 40.0000,   0.00000, 0.00000, 179.22006, -1, 1);
CreateDynamicObject(5837, -27.91838, 1651.35925, 424.50717 + 40.0000,   0.00000, 0.00000, 90.24001, -1, 1);
CreateDynamicObject(1491, -29.25017, 1649.54688, 423.07367 + 40.0000,   0.00000, 0.00000, -269.16028, -1, 1);
CreateDynamicObject(3386, -27.26827, 1651.61780, 423.07452 + 40.0000,   0.00000, 0.00000, 86.22002, -1, 1);
CreateDynamicObject(3386, -28.42737, 1651.69202, 423.07452 + 40.0000,   0.00000, 0.00000, 86.22002, -1, 1);
CreateDynamicObject(2008, -27.28406, 1648.41724, 423.07397 + 40.0000,   0.00000, 0.00000, 176.22000, -1, 1);
CreateDynamicObject(2777, -28.03351, 1649.93457, 423.52426 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(348, -27.76161, 1648.35608, 423.88574 + 40.0000,   89.39999, -224.51949, 273.83987, -1, 1);
CreateDynamicObject(1491, 15.81247, 1681.12097, 418.78711 + 40.0000,   0.00000, 0.00000, -1.62000, -1, 1);
CreateDynamicObject(2064, 20.53235, 1650.35657, 419.30740 + 40.0000,   0.00000, 0.00000, -180.89978, -1, 1);
CreateDynamicObject(2055, 20.04190, 1641.97656, 421.02783 + 40.0000,   0.00000, 0.00000, 90.30003, -1, 1);
CreateDynamicObject(2894, -43.80082, 1637.92224, 423.42908 + 40.0000,   0.00000, 0.00000, 128.94012, -1, 1);
CreateDynamicObject(1668, -44.25080, 1638.09045, 423.59232 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1668, -44.50790, 1638.12366, 423.59232 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1668, -44.34246, 1637.80505, 423.59232 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1668, -45.17014, 1638.16516, 423.59232 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19580, -44.84795, 1638.11279, 423.42853 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19893, -45.48851, 1637.75391, 423.42841 + 40.0000,   0.00000, 0.00000, -45.18001, -1, 1);
CreateDynamicObject(3044, -45.44386, 1638.21191, 423.46240 + 40.0000,   0.00000, 0.00000, 110.27998, -1, 1);
CreateDynamicObject(2921, 17.91791, 1681.03601, 422.21057 + 40.0000,   0.00000, 0.00000, 94.13997, -1, 1);
CreateDynamicObject(19943, 26.68781, 1668.74255, 415.27771 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19943, 26.58906, 1666.49854, 415.27771 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3920, -5.14299, 1650.69141, 423.05341 + 40.0000,   0.00000, 0.00000, 177.66010, -1, 1);
CreateDynamicObject(3920, -1.11131, 1650.54480, 423.05341 + 40.0000,   0.00000, 0.00000, 177.66010, -1, 1);
CreateDynamicObject(3921, -8.50143, 1650.14453, 419.28043 + 40.0000,   0.00000, 0.00000, 88.26006, -1, 1);
CreateDynamicObject(640, -7.94918, 1650.97754, 420.08850 + 40.0000,   0.00000, 0.00000, 88.74007, -1, 1);
CreateDynamicObject(3921, -1.60191, 1649.91211, 419.28043 + 40.0000,   0.00000, 0.00000, 88.26006, -1, 1);
CreateDynamicObject(640, -2.80962, 1650.79724, 420.08850 + 40.0000,   0.00000, 0.00000, 88.74007, -1, 1);
CreateDynamicObject(3921, 0.66458, 1649.80896, 419.27786 + 40.0000,   0.00000, 0.00000, 88.26006, -1, 1);
CreateDynamicObject(640, 1.94059, 1650.65955, 420.08850 + 40.0000,   0.00000, 0.00000, 88.74007, -1, 1);
CreateDynamicObject(19356, 4.17357, 1650.76404, 417.97067 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3439, 5.36154, 1649.69202, 422.80750 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(3439, 18.44300, 1636.75085, 422.80750 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(1703, 5.47677, 1637.09180, 418.78821 + 40.0000,   0.00000, 0.00000, 178.38007, -1, 1);
CreateDynamicObject(1703, -4.20710, 1637.49121, 418.78821 + 40.0000,   0.00000, 0.00000, 178.38007, -1, 1);
CreateDynamicObject(2616, -48.23064, 1643.18347, 424.87756 + 40.0000,   0.00000, 0.00000, 88.38021, -1, 1);
CreateDynamicObject(1491, -13.13522, 1631.33899, 423.79694 + 40.0000,   0.00000, 0.00000, -1.85998, -1, 1);
CreateDynamicObject(3440, -13.32106, 1631.33105, 424.67688 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19325, -13.46818, 1631.26782, 429.58914 + 40.0000,   90.00000, 0.00000, 87.66004, -1, 1);
CreateDynamicObject(3397, -17.04401, 1633.27209, 423.91544 + 40.0000,   0.00000, 0.00000, -183.17966, -1, 1);
CreateDynamicObject(3386, -17.00400, 1636.55347, 423.83850 + 40.0000,   0.00000, 0.00000, -226.02026, -1, 1);
CreateDynamicObject(3396, -14.09511, 1636.31055, 423.91714 + 40.0000,   0.00000, 0.00000, 88.26002, -1, 1);
CreateDynamicObject(2777, -15.63304, 1633.52258, 424.31158 + 40.0000,   0.00000, 0.00000, -94.44001, -1, 1);
CreateDynamicObject(2777, -13.84683, 1635.03333, 424.31158 + 40.0000,   0.00000, 0.00000, -184.26016, -1, 1);
CreateDynamicObject(2606, -12.65147, 1636.69409, 426.23431 + 40.0000,   0.00000, 0.00000, -2.40000, -1, 1);
CreateDynamicObject(2606, -12.65147, 1636.69409, 426.66583 + 40.0000,   0.00000, 0.00000, -2.40000, -1, 1);
CreateDynamicObject(2606, -15.34516, 1636.74500, 426.23431 + 40.0000,   0.00000, 0.00000, -1.74000, -1, 1);
CreateDynamicObject(2606, -15.34516, 1636.74500, 426.69452 + 40.0000,   0.00000, 0.00000, -1.74000, -1, 1);
CreateDynamicObject(18766, -15.68433, 1631.69934, 427.11441 + 40.0000,   0.00000, 90.00000, -2.04000, -1, 1);
CreateDynamicObject(2922, -13.69277, 1631.14783, 425.15070 + 40.0000,   0.00000, 0.00000, 180.83992, -1, 1);
CreateDynamicObject(2922, -11.75961, 1627.58862, 425.34213 + 40.0000,   0.00000, 0.00000, 93.60004, -1, 1);
CreateDynamicObject(1491, 26.71337, 1668.38135, 418.72693 + 40.0000,   0.00000, 0.00000, -91.61991, -1, 1);
CreateDynamicObject(19943, 23.79002, 1649.12708, 415.39053 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(19943, 21.62767, 1649.19446, 415.40906 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2064, 24.96316, 1650.31226, 419.30740 + 40.0000,   0.00000, 0.00000, -178.49988, -1, 1);
CreateDynamicObject(19825, -41.33422, 1651.61780, 425.81787 + 40.0000,   0.00000, 0.00000, 0.00000, -1, 1);
CreateDynamicObject(2922, 15.58914, 1681.05383, 419.96432 + 40.0000,   0.00000, 0.00000, 178.98042, -1, 1);
CreateDynamicObject(2283, 6.02717, 1621.72681, 425.86166 + 40.0000,   0.00000, 0.00000, 178.26042, -1, 1);
CreateDynamicObject(2281, -1.96070, 1622.44727, 425.89691 + 40.0000,   0.00000, 0.00000, 179.51920, -1, 1);
CreateDynamicObject(2257, -10.18037, 1622.29553, 426.23529 + 40.0000,   0.00000, 0.00000, 177.53909, -1, 1);
CreateDynamicObject(2921, -47.37593, 1628.66748, 425.59265 + 40.0000,   0.00000, 0.00000, 231.54024, -1, 1);

///////////////////////////////////////////////////////////MAP LS & AEROPUERTOS////////////////////////////////////////////////////////////////////////////////////


//OBJETOS///////////////***
CreateDynamicObject(1597, 2395.34473, -1742.64380, 15.14833,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1256, 2386.67163, -1743.32922, 13.15671,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1256, 2386.68384, -1741.76697, 13.15670,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(1597, 2377.63208, -1742.58594, 15.14833,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1256, 2368.16528, -1741.65454, 13.15670,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(1256, 2368.25391, -1743.35388, 13.15671,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1597, 2358.29175, -1742.51050, 15.14833,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1256, 2349.73315, -1743.37061, 13.15671,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1256, 2349.70898, -1741.68689, 13.15670,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(1597, 2340.43213, -1742.49146, 15.14833,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(12991, 2371.24194, -1702.49353, 12.59416,   0.00000, 0.00000, 175.20000);
CreateDynamicObject(1225, 2355.65381, -1710.86084, 13.06735,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2354.93970, -1712.13342, 13.06735,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16061, 2268.39355, -1741.08875, 12.54641,   0.00000, 0.00000, 88.80000);
CreateDynamicObject(620, 2201.41431, -1659.92175, 12.09375,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(620, 2195.39453, -1686.18201, 12.09375,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(620, 2193.25757, -1714.69299, 12.09375,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(19869, 1805.65417, -1720.12476, 12.51759,   0.00000, 0.00000, -38.40002);
CreateDynamicObject(19869, 1801.12122, -1719.26477, 12.51759,   0.00000, 0.00000, 16.98000);
CreateDynamicObject(19590, 1805.03589, -1721.77661, 12.60974,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19590, 1804.35168, -1723.10120, 12.60974,   0.00000, 90.00000, -89.09996);
CreateDynamicObject(356, 1805.11218, -1723.46851, 12.60800,   90.00000, 0.00000, -117.18003);
CreateDynamicObject(2905, 1805.73376, -1723.11145, 12.62150,   0.00000, 90.00000, -9.18000);
CreateDynamicObject(2907, 1805.56091, -1723.85571, 12.63613,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2908, 1805.55847, -1724.47595, 12.76634,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2905, 1805.30273, -1723.07959, 12.62155,   0.00000, 0.00000, 22.92000);
CreateDynamicObject(2906, 1806.02734, -1724.05420, 12.59051,   0.00000, 0.00000, -85.38003);
CreateDynamicObject(2906, 1805.16187, -1724.21533, 12.59051,   0.00000, 0.00000, -232.20009);
CreateDynamicObject(19836, 1806.42932, -1723.53198, 12.57810,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1804.83362, -1723.11011, 12.57810,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1804.65845, -1722.56152, 12.57810,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1804.06055, -1722.61853, 12.57810,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.63513, -1693.41455, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.63684, -1691.41577, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.63135, -1689.42908, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.63489, -1687.45898, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.63123, -1685.49780, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.63428, -1683.51599, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.64392, -1681.53015, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.64929, -1679.52930, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.65588, -1677.58887, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.66370, -1675.60693, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.65295, -1673.66650, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.64124, -1671.72546, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18648, 1931.63867, -1671.14868, 12.56150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3437, 1919.13086, -1694.05737, 17.85866,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3437, 1919.24341, -1668.42908, 17.85866,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1908.57776, -1742.26355, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1903.24719, -1742.10461, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1892.41357, -1742.20691, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1887.01807, -1742.13770, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1881.68994, -1741.97290, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1898.15942, -1742.15369, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1876.45056, -1742.12268, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1870.96375, -1742.11877, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1866.11926, -1742.11487, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1860.79517, -1741.90149, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1856.21228, -1742.02747, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1851.10083, -1741.86694, 13.05957,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1905.11548, -1622.25049, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1899.16602, -1622.32251, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1893.19080, -1622.38660, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1888.43103, -1622.40710, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1883.17212, -1622.56885, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1877.04089, -1622.44836, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1871.83582, -1622.39551, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1866.83582, -1622.47717, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1862.39624, -1622.51050, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1857.85498, -1622.46497, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1853.25293, -1622.40015, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1849.01331, -1622.45776, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(9833, 1918.99854, -1629.95911, 14.99212,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(9833, 1918.78625, -1735.00635, 14.99212,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19126, 1909.92175, -1622.50586, 13.02650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19345, 1480.91907, -1790.58545, 156.27922,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3066, 2350.91357, -1248.73315, 22.45761,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3066, 2350.78760, -1259.18567, 22.45761,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2358, 2323.42847, -1263.46252, 21.66453,   0.00000, 0.00000, 76.55999);
CreateDynamicObject(2358, 2324.04053, -1261.23584, 21.66453,   0.00000, 0.00000, 131.15999);
CreateDynamicObject(2358, 2325.11182, -1261.88562, 21.66453,   0.00000, 0.00000, 97.01997);
CreateDynamicObject(2060, 2352.05811, -1269.21606, 21.64527,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2351.94385, -1270.24219, 21.64527,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2352.00439, -1269.81885, 21.84509,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2351.77466, -1271.27979, 21.66142,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2351.78809, -1271.00989, 21.84509,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2351.88354, -1270.43408, 22.02478,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2351.97070, -1269.31812, 22.02478,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2352.04004, -1269.86023, 22.24413,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2351.78809, -1271.00989, 22.12337,   1.91999, -20.34000, 82.25999);
CreateDynamicObject(2060, 2351.88354, -1270.43408, 22.42234,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2351.97070, -1269.31812, 22.44379,   0.00000, 0.00000, 82.25999);
CreateDynamicObject(2060, 2350.61328, -1270.90149, 21.66142,   0.00000, 0.00000, 17.81998);
CreateDynamicObject(2060, 2349.69507, -1270.31458, 21.66142,   0.00000, 0.00000, 54.95998);
CreateDynamicObject(2060, 2348.98242, -1269.21460, 21.66142,   0.00000, 0.00000, -50.28001);
CreateDynamicObject(2060, 2348.36255, -1271.23962, 21.66142,   0.00000, 0.00000, -103.26001);
CreateDynamicObject(2985, 2348.00122, -1269.27063, 21.61257,   75.60001, -54.30001, 0.00000);
CreateDynamicObject(3524, 2347.10889, -1269.87366, 18.39887,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1422, 2313.02100, -1221.79407, 23.43442,   0.00000, 0.00000, 99.53999);
CreateDynamicObject(1422, 2314.35498, -1219.77515, 23.18736,   6.42000, 6.24000, 43.67999);
CreateDynamicObject(1421, 2338.74194, -1247.90356, 22.21572,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1421, 2339.16113, -1249.95935, 22.21572,   0.00000, 0.00000, -111.00003);
CreateDynamicObject(1421, 2335.24609, -1250.24280, 22.21572,   0.00000, 0.00000, -58.02003);
CreateDynamicObject(1550, 2350.22729, -1231.06042, 21.87856,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 2350.03955, -1230.44275, 21.87856,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 2350.70190, -1230.57483, 21.87856,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 2350.14429, -1229.18164, 21.87856,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1550, 2350.64746, -1229.41577, 21.87856,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3092, 2348.58740, -1229.17603, 21.73730,   74.93999, -49.92000, 0.00000);
CreateDynamicObject(1422, 2312.83838, -1214.50183, 23.43442,   0.00000, 0.00000, 139.86000);
CreateDynamicObject(3091, 2363.68945, -1270.39209, 23.54310,   0.00000, 0.00000, 114.84001);
CreateDynamicObject(3091, 2364.48511, -1275.12964, 23.54310,   0.00000, 0.00000, 44.88002);
CreateDynamicObject(1225, 2346.64648, -1254.64734, 21.99491,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2346.02124, -1255.68420, 21.99491,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2345.25879, -1257.31580, 21.99491,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1131, 2261.76709, -1440.53418, 23.44198,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1115, 2261.74292, -1437.86462, 23.36571,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1114, 2261.17603, -1444.53979, 23.06372,   -22.62000, 5.16000, 0.00000);
CreateDynamicObject(1114, 2262.31152, -1444.53857, 23.06372,   -22.62000, 5.16000, 0.00000);
CreateDynamicObject(1025, 2260.49902, -1439.03430, 23.13909,   0.00000, 0.00000, -177.83997);
CreateDynamicObject(1025, 2260.49854, -1443.17590, 23.13909,   0.00000, 0.00000, -177.83997);
CreateDynamicObject(1025, 2263.06616, -1439.09717, 23.13909,   0.00000, 0.00000, -363.00006);
CreateDynamicObject(1025, 2263.05176, -1443.19507, 23.13909,   0.00000, 0.00000, -363.00006);
CreateDynamicObject(19314, 2261.76733, -1437.90881, 23.87980,   39.11995, 89.94001, 0.00000);
CreateDynamicObject(18963, 2261.77930, -1437.88599, 23.93157,   0.00000, 0.00000, 89.39999);
CreateDynamicObject(1369, 2261.36206, -1440.50366, 23.53975,   0.00000, 0.00000, -178.13998);
CreateDynamicObject(1369, 2262.10962, -1440.50110, 23.53975,   0.00000, 0.00000, -178.13998);
CreateDynamicObject(1550, 2262.13965, -1441.53125, 23.45985,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19941, 2261.54517, -1441.77710, 23.21015,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19941, 2261.41895, -1441.55627, 23.21015,   0.00000, 0.00000, -57.89999);
CreateDynamicObject(19941, 2261.56299, -1441.40894, 23.21015,   0.00000, 0.00000, -20.04000);
CreateDynamicObject(19941, 2261.24170, -1441.67297, 23.21015,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18646, 2260.66602, -1444.39368, 23.66973,   56.94000, 2.94000, 0.00000);
CreateDynamicObject(18646, 2262.92554, -1444.38184, 23.66973,   56.94000, 2.94000, 0.00000);
CreateDynamicObject(19466, 2261.75244, -1439.54651, 23.61677,   -0.90000, 45.12000, -88.74000);
CreateDynamicObject(1231, 2225.15894, -1447.28979, 25.56850,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2235.78711, -1447.29504, 25.46602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2242.96143, -1447.29736, 25.46602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2250.35522, -1447.22339, 25.46602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2256.95264, -1447.30090, 25.46602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2258.60767, -1420.18823, 25.46602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2251.31592, -1420.24072, 25.46602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2243.23975, -1420.20837, 25.46602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2236.31372, -1420.26794, 25.46602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2227.35938, -1420.17700, 25.46602,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(700, 2226.89331, -1441.42261, 23.11719,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(673, 2227.15308, -1423.49963, 22.96094,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(11489, 2229.11035, -1434.03772, 22.20083,   0.00000, 0.00000, -89.22002);
CreateDynamicObject(3515, 2237.18481, -1440.55542, 23.98847,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 2237.25513, -1427.77808, 23.98847,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11442, 1876.10925, -1872.19495, 12.02648,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1305, 1898.52112, -1874.40515, 13.79679,   -106.91995, -38.75999, 0.00000);
CreateDynamicObject(1305, 1894.01648, -1867.51038, 13.10531,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1305, 1897.78198, -1859.62366, 12.54864,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11443, 1885.78882, -1870.29956, 12.53137,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11441, 1871.55554, -1858.50134, 12.44196,   0.00000, 0.00000, 89.82001);
CreateDynamicObject(11446, 1878.85718, -1858.02869, 12.62325,   0.00000, 0.00000, -182.45998);
CreateDynamicObject(1225, 1888.37061, -1855.16650, 12.93743,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1890.41858, -1854.52991, 12.93743,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1888.58496, -1853.23572, 12.93743,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1888.73608, -1857.65234, 12.93743,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1889.93677, -1856.71326, 12.93743,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1887.92578, -1856.12256, 12.93743,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1893.74060, -1869.86230, 12.96116,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1898.36865, -1876.18115, 12.87877,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1305, 1891.75354, -1871.66223, 12.54864,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3091, 1898.77246, -1880.21167, 13.02737,   0.00000, 0.00000, 17.34000);
CreateDynamicObject(3091, 1894.97998, -1880.79382, 13.03645,   0.00000, 0.00000, -4.92001);
CreateDynamicObject(3267, 1875.11157, -1858.58801, 12.52690,   -35.00000, 0.00000, 0.00000);
CreateDynamicObject(1305, 1875.39160, -1858.50916, 12.00354,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11441, 1881.22156, -1852.75366, 12.44196,   0.00000, 0.00000, 89.82001);
CreateDynamicObject(11443, 1888.83582, -1853.81238, 12.53137,   0.00000, 0.00000, -183.77997);
CreateDynamicObject(11733, 1883.63049, -1872.27283, 12.52025,   0.00000, 0.00000, 88.14000);
CreateDynamicObject(359, 1882.58545, -1870.64417, 12.53269,   74.76000, 11.58000, 0.00000);
CreateDynamicObject(3279, 1865.87109, -1858.21289, 12.16864,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(6865, 2317.86792, -1644.82275, 18.41984,   0.00000, 0.00000, 44.76000);
CreateDynamicObject(3524, 2306.80713, -1648.60547, 16.14424,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3524, 2327.96875, -1648.42859, 16.14424,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19314, 2326.03467, -1645.57202, 15.85390,   150.00000, 90.00000, 0.00000);
CreateDynamicObject(964, 1549.64587, -1362.11609, 328.45621,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(964, 1547.60547, -1362.22266, 328.45621,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(964, 1545.36377, -1362.23743, 328.45621,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(964, 1538.59351, -1359.83789, 328.45621,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(964, 1549.11658, -1359.58179, 328.45621,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(964, 1545.85010, -1359.66223, 328.45621,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(964, 1543.27808, -1361.21204, 328.45621,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3794, 1536.51379, -1362.99292, 329.01520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3794, 1536.33875, -1364.96167, 329.01520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3794, 1536.45142, -1366.78601, 329.01520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1555.91028, -1356.06128, 328.56085,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1556.30774, -1356.06873, 328.56085,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1556.17859, -1355.76428, 328.56085,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1556.94617, -1355.53992, 328.56085,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1557.09595, -1356.21338, 328.56085,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1555.86743, -1355.09692, 328.56085,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1554.42065, -1355.22046, 328.56085,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1552.86401, -1354.22095, 328.56085,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1551.58203, -1355.14734, 328.56085,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(356, 1547.56787, -1354.46936, 328.48477,   -79.37999, 16.20000, 0.00000);
CreateDynamicObject(356, 1546.46558, -1356.14441, 328.48477,   -79.37999, 16.20000, 121.67994);
CreateDynamicObject(2043, 1547.23059, -1357.03503, 328.51364,   -3.84001, -80.63998, 0.00000);
CreateDynamicObject(1224, 1548.66528, -1356.82825, 328.98520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2906, 1550.02759, -1355.39038, 328.50937,   -3.78000, 73.98001, -143.28000);
CreateDynamicObject(352, 1550.04248, -1355.65979, 328.50250,   -273.71976, 155.93991, -197.27998);
CreateDynamicObject(348, 1555.72424, -1357.44336, 328.49509,   -82.14001, 12.00000, 0.00000);
CreateDynamicObject(348, 1555.79932, -1357.97437, 328.49509,   -82.14001, 12.00000, -130.68001);
CreateDynamicObject(2908, 1556.51172, -1358.18066, 328.45599,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1987.73083, -1199.08997, 17.99191,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1952.83203, -1200.50464, 17.99190,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(673, 2243.31836, -1444.11743, 22.96094,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(673, 2237.10571, -1434.44165, 22.96094,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(673, 2250.66724, -1433.99255, 22.96094,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(620, 2256.99707, -1424.55042, 23.10156,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(715, 1879.45532, -1147.59375, 31.15269,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 1862.58411, -1191.60303, 30.85088,   0.00000, 0.00000, 217.62001);
CreateDynamicObject(715, 1864.67700, -1249.36548, 21.08497,   0.00000, 0.00000, -46.32000);
CreateDynamicObject(715, 2056.30322, -1249.92468, 31.21381,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 2055.79736, -1146.03308, 30.92234,   0.00000, 0.00000, 115.43999);
CreateDynamicObject(710, 1957.96765, -1147.60352, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1957.95264, -1154.27576, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1957.98401, -1160.85327, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1957.78259, -1168.15369, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1957.41235, -1174.50366, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1980.79260, -1173.93958, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1981.00122, -1167.23132, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1981.20935, -1160.42444, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1981.27136, -1153.94861, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1981.41162, -1147.36194, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1960.58167, -1227.82446, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1961.40930, -1233.09741, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1962.63770, -1240.49805, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1963.52600, -1245.39172, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1964.17395, -1249.25818, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1987.47852, -1249.20044, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1986.72412, -1243.22803, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1986.09583, -1236.85901, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1985.20166, -1229.89246, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 1984.66174, -1224.64014, 33.54688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 1944.51025, -1180.12927, 19.38935,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 1958.70117, -1225.08374, 19.38935,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 1931.87805, -1187.85486, 19.38935,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 1926.11877, -1198.67639, 19.38935,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 1929.82288, -1209.21338, 19.38935,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 1941.07507, -1217.64832, 19.38935,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 1988.24255, -1222.21338, 19.42854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 2003.88330, -1215.82031, 19.42854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 2013.52307, -1206.55762, 19.42854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 2014.46021, -1195.41003, 19.42854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 2006.70679, -1185.49036, 19.42854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 1992.17261, -1178.64355, 19.42854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 2049.17944, -1184.25269, 25.16176,   0.00000, 0.00000, 110.27999);
CreateDynamicObject(1231, 2038.40393, -1170.37109, 24.16928,   0.00000, 0.00000, 134.64008);
CreateDynamicObject(1231, 2017.18811, -1159.13464, 23.10439,   0.00000, 0.00000, 163.20007);
CreateDynamicObject(1231, 1991.34985, -1154.54761, 23.10439,   0.00000, 0.00000, 180.78003);
CreateDynamicObject(1231, 2048.42334, -1204.84924, 25.02960,   0.00000, 0.00000, 68.03997);
CreateDynamicObject(1231, 2040.63892, -1218.52698, 24.42794,   0.00000, 0.00000, 43.25999);
CreateDynamicObject(1231, 2019.46558, -1229.40015, 23.15023,   0.00000, 0.00000, 17.09999);
CreateDynamicObject(1231, 1998.72668, -1233.97119, 22.20889,   0.00000, 0.00000, 14.33999);
CreateDynamicObject(1231, 1948.28528, -1155.74634, 22.63181,   0.00000, 0.00000, 180.78003);
CreateDynamicObject(1231, 1923.90710, -1157.85962, 23.85650,   0.00000, 0.00000, 187.92000);
CreateDynamicObject(1231, 1904.23682, -1165.64966, 25.46153,   0.00000, 0.00000, 219.17996);
CreateDynamicObject(1231, 1892.23840, -1181.53992, 24.97893,   0.00000, 0.00000, 245.57997);
CreateDynamicObject(1231, 1882.76758, -1206.62244, 20.65400,   0.00000, 0.00000, 254.57996);
CreateDynamicObject(1231, 1887.75598, -1232.32458, 16.83720,   0.00000, 0.00000, 311.40018);
CreateDynamicObject(1231, 1917.39636, -1241.51074, 18.17896,   0.00000, 0.00000, 357.18018);
CreateDynamicObject(1231, 1944.63672, -1240.20264, 19.96704,   0.00000, 0.00000, 367.62021);
CreateDynamicObject(736, 2032.24805, -1249.14697, 33.67369,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 2055.70093, -1221.27197, 33.67369,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 2055.49316, -1193.98438, 33.67369,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 2055.29639, -1170.61902, 33.67369,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 2027.91663, -1147.02954, 33.92118,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 2008.16858, -1146.84583, 33.92118,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 2011.87769, -1249.54468, 33.92118,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1940.79565, -1148.29065, 33.25840,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1915.95251, -1147.93030, 33.25840,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1891.39893, -1147.22778, 33.25840,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1877.36316, -1166.97571, 33.25840,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1874.07483, -1181.80103, 33.25840,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1862.43030, -1207.86975, 30.80315,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1862.06677, -1219.80884, 28.88781,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1862.04895, -1232.01416, 26.69937,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1879.85474, -1250.02039, 23.41775,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1907.30713, -1250.40723, 23.41775,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1929.62781, -1250.14294, 27.43803,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(736, 1950.23718, -1248.22949, 27.43803,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1688.41321, -1463.91040, 12.95512,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3361, 1691.46375, -1460.30188, 14.62564,   0.00000, 0.00000, 87.36002);
CreateDynamicObject(19458, 1687.57056, -1464.70178, 16.61693,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19458, 1680.15125, -1464.70459, 16.62041,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19439, 1674.34106, -1459.01465, 13.17354,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(2001, 1675.85510, -1458.36841, 13.26102,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2241, 1675.80676, -1459.64233, 13.72105,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3811, 1678.27869, -1456.37659, 13.15339,   0.00000, 0.00000, -90.59998);
CreateDynamicObject(1598, 1685.49316, -1461.22595, 12.77020,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2988, 1692.80029, -1452.46667, 12.50390,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2988, 1684.44739, -1452.46533, 12.50390,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19123, 1987.74463, -1199.15198, 19.35598,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, 1952.76770, -1200.43616, 19.34713,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1597, 2325.60547, -1742.62634, 15.14833,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1257, 1736.81348, -1825.85132, 13.78807,   0.00000, 0.00000, -104.99998);
CreateDynamicObject(1437, 1694.22180, -1464.18457, 20.04737,   -34.26001, 1.26000, -90.48002);
CreateDynamicObject(1437, 1698.07410, -1464.32996, 24.00873,   -34.26001, 1.26000, -90.48002);
CreateDynamicObject(1437, 1702.18384, -1464.50476, 28.20937,   -34.26001, 1.26000, -90.48002);
CreateDynamicObject(1437, 1703.66736, -1464.57532, 29.75772,   -34.26001, 1.26000, -90.48002);
CreateDynamicObject(1437, 1708.16736, -1464.76147, 32.91268,   -96.84003, 2.40000, -90.48002);
CreateDynamicObject(1437, 1703.24817, -1464.52039, 28.20940,   90.00000, 90.00000, 0.00000);
CreateDynamicObject(1437, 1707.30249, -1464.54114, 28.91059,   90.00000, 90.00000, 0.00000);
CreateDynamicObject(1503, 2235.48340, -1610.70520, 15.30572,   0.00000, 0.00000, -24.54000);
CreateDynamicObject(1503, 2237.93652, -1611.80432, 15.30572,   0.00000, 0.00000, -24.54000);
CreateDynamicObject(1225, 2236.35938, -1618.77856, 15.23546,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2230.14771, -1620.00366, 15.34503,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2230.80859, -1618.64673, 15.39210,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 2375.97437, -1640.86450, 12.35705,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2457.60913, -1957.10059, 12.93327,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2456.68286, -1958.05725, 12.93327,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2459.05835, -1960.74280, 12.93327,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2454.66577, -1986.03418, 12.90951,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2452.65259, -1984.80640, 12.90951,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3887, 2139.07690, -1732.80164, 19.46730,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19146, 822.06146, -1966.24365, 15.32177,   -22.62000, -8.46000, -22.37999);
CreateDynamicObject(19146, 851.44165, -1968.51526, 15.32177,   -22.62000, -8.46000, 57.90003);
CreateDynamicObject(12843, 490.41849, -1815.35217, 4.95311,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(19376, 490.66769, -1815.15601, 4.91140,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19376, 495.32190, -1815.15759, 4.91240,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19376, 490.64661, -1815.61597, 4.91040,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19376, 495.36530, -1815.63953, 4.91073,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18762, 485.89597, -1819.90833, 2.31439,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18762, 500.12292, -1819.93652, 2.31439,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16151, 493.86050, -1819.19678, 5.19570,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3015, 485.57837, -1819.94873, 5.09495,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3015, 486.05536, -1819.58484, 5.09495,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3015, 486.14761, -1819.11206, 5.09495,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(964, 486.41229, -1818.18530, 5.06035,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(964, 488.17148, -1818.42322, 5.06035,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2977, 486.35202, -1816.22290, 4.81745,   0.00000, 0.00000, -43.91999);
CreateDynamicObject(2747, 498.26416, -1811.79150, 5.40610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2639, 496.61551, -1811.80725, 5.59880,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2639, 499.76291, -1811.79565, 5.59880,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2639, 495.95731, -1811.82642, 5.59880,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2747, 494.61844, -1811.95056, 5.40610,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2639, 493.28311, -1811.81018, 5.59880,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2747, 491.75781, -1812.90222, 5.40610,   70.00000, 0.00000, 0.00000);
CreateDynamicObject(2639, 492.62308, -1811.84973, 5.59880,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2639, 490.29578, -1811.75305, 5.59880,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(19836, 491.42767, -1811.79919, 5.01044,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 491.62775, -1812.02673, 5.01044,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 491.67368, -1811.70605, 5.01044,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 491.63455, -1813.60229, 5.00503,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 491.25793, -1813.92310, 5.00503,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(348, 490.41971, -1812.45630, 5.53950,   90.00000, 0.00000, 106.56001);
CreateDynamicObject(1594, 493.73932, -1826.58545, 4.89793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 491.11334, -1824.07568, 4.89793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 495.74124, -1823.72327, 4.89793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 497.83646, -1826.42896, 4.89793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 488.10049, -1826.46350, 4.89793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 485.84784, -1823.54565, 4.89793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, 500.58078, -1823.94092, 4.89793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(642, 455.50833, -1874.54382, 3.32910,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(643, 465.26117, -1874.47888, 2.47242,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(642, 465.22406, -1874.57007, 3.34881,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(643, 455.54755, -1874.51575, 2.47242,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(642, 474.99356, -1874.61621, 3.44207,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(642, 485.20395, -1873.95898, 3.48350,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(643, 475.04504, -1874.56628, 2.47242,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(643, 485.22461, -1873.97778, 2.58474,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1445, 493.12595, -1807.40356, 5.56076,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(4824, 696.76257, -1894.37390, -1.26941,   -5.00000, 0.00000, 180.00000);
CreateDynamicObject(19793, 219.70442, -1876.44263, 1.10840,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19793, 219.70442, -1876.44263, 1.10840,   0.00000, 0.00000, -70.74001);
CreateDynamicObject(19793, 219.70442, -1876.44263, 1.10840,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19793, 219.70442, -1876.44263, 1.10840,   0.00000, 0.00000, -125.40000);
CreateDynamicObject(19793, 219.70442, -1876.44263, 1.10840,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19793, 219.70442, -1876.44263, 1.10840,   0.00000, 0.00000, -70.74001);
CreateDynamicObject(19793, 219.70442, -1876.44263, 1.10840,   0.00000, 0.00000, -207.30000);
CreateDynamicObject(19317, 221.02295, -1876.77881, 1.10420,   270.12000, -0.06000, 142.92001);
CreateDynamicObject(2901, 215.93153, -1877.83276, 1.37252,   0.00000, 0.00000, 46.44000);
CreateDynamicObject(2232, 223.06076, -1878.41785, 1.43103,   0.00000, 0.00000, -87.29994);
CreateDynamicObject(2232, 223.10741, -1879.17078, 1.43103,   0.00000, 0.00000, -87.29994);
CreateDynamicObject(2232, 223.11592, -1879.99402, 1.43103,   0.00000, 0.00000, -87.29994);
CreateDynamicObject(1225, 365.71054, -1879.78857, 2.10486,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 366.65256, -1880.36523, 2.10486,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 367.73041, -1879.78101, 2.10486,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 367.18463, -1881.47473, 2.10486,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 372.60254, -1888.40015, 2.10486,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 706.16168, -1845.00952, 6.91906,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 695.23468, -1844.95020, 6.18807,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 684.57257, -1844.92798, 5.38871,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 676.06403, -1844.71021, 4.93913,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1281, 664.63062, -1838.95483, 5.82031,   356.85840, 0.00000, -175.89272);
CreateDynamicObject(1281, 659.66980, -1837.15894, 5.82031,   356.85840, 0.00000, 122.42734);
CreateDynamicObject(6965, 578.39899, -1814.10840, 8.71124,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(6964, 578.45941, -1814.22095, 4.48398,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 706.65161, -1854.61633, 6.58835,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 695.81506, -1854.55261, 5.65758,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 684.52545, -1854.53320, 4.80563,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1568, 676.27832, -1854.57117, 4.44790,   0.00000, 3.00000, 0.00000);
CreateDynamicObject(10984, 2167.94751, -1731.42139, 12.52794,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10985, 2147.06421, -1736.40833, 12.14885,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10984, 2119.37427, -1728.57764, 12.55005,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3887, 2139.07690, -1732.80164, 19.46730,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(358, 2158.72144, -1725.81250, 22.53765,   84.42000, -28.86000, 0.00000);
CreateDynamicObject(19836, 2156.96313, -1726.89319, 22.66736,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 2157.79492, -1726.86902, 22.66736,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 2158.10742, -1726.06592, 22.66736,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2164.26563, -1737.53699, 12.88913,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2162.91187, -1737.24536, 12.88913,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19793, 1790.04089, -1802.82764, 3.03083,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19793, 1790.04089, -1802.82764, 3.03083,   0.00000, 0.00000, -58.02002);
CreateDynamicObject(19793, 1790.04089, -1802.82764, 3.03083,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19793, 1790.04089, -1802.82764, 3.03083,   0.00000, 0.00000, -111.30003);
CreateDynamicObject(1793, 1787.28076, -1804.35828, 2.68395,   0.00000, 0.00000, -13.98000);
CreateDynamicObject(1225, 1791.14270, -1801.99683, 3.35600,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1790.81238, -1800.52942, 3.35600,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1791.97473, -1800.88818, 3.35600,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1136, 1788.26855, -1801.30542, 3.47245,   -91.08002, -52.56002, 0.00000);
CreateDynamicObject(19360, 1787.61084, -1802.03101, 4.21910,   0.64000, 50.12000, -13.98000);
CreateDynamicObject(714, 1275.41113, -2408.00391, 11.08003,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(714, 1207.82056, -2406.29883, 9.59682,   0.00000, 0.00000, -141.17999);
CreateDynamicObject(714, 1244.31995, -2419.39209, 9.41308,   0.00000, 0.00000, -76.62000);
CreateDynamicObject(714, 1193.64771, -2379.05273, 10.43221,   0.00000, 0.00000, -141.17999);
CreateDynamicObject(714, 1209.13049, -2348.98682, 12.38530,   0.00000, 0.00000, -141.17999);
CreateDynamicObject(11414, 1298.61853, -2228.87549, 13.92345,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11414, 1296.27393, -2342.28271, 13.92345,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(714, 1239.72925, -2338.87817, 12.38530,   0.00000, 0.00000, -141.17999);
CreateDynamicObject(16771, 2028.14783, -2257.23022, 18.75910,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(16771, 2026.84570, -2318.91138, 18.75910,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(16771, 2025.99927, -2387.34863, 18.75910,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3279, 1977.81348, -2180.23511, 12.28900,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 1948.37988, -2184.08325, 12.28900,   0.00000, 0.00000, -91.68001);
CreateDynamicObject(14553, 1797.78699, -2539.29492, 12.51810,   19.98001, -48.36009, 90.00000);
CreateDynamicObject(14548, 1795.68103, -2539.05615, 13.07573,   19.98000, -48.36010, 90.00000);
CreateDynamicObject(2969, 1788.66003, -2539.81372, 12.76158,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1224, 1790.25098, -2538.49487, 13.18770,   0.00000, 0.00000, -21.12000);
CreateDynamicObject(1224, 1790.26782, -2540.21509, 13.18770,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1224, 1793.25342, -2537.42432, 13.24411,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3271, 1836.44116, -2549.63818, -1.07120,   34.38008, 129.00002, 56.94001);
CreateDynamicObject(3796, 1748.97363, -2522.39648, 12.53718,   0.00000, 0.00000, 46.98000);
CreateDynamicObject(1271, 1745.11377, -2528.17944, 12.89430,   0.00000, 0.00000, -25.98000);
CreateDynamicObject(2985, 1739.72778, -2526.20386, 12.41539,   -63.84010, 32.63995, 0.00000);
CreateDynamicObject(1685, 1709.41589, -2532.45679, 13.18940,   0.00000, 0.00000, -33.54000);
CreateDynamicObject(1685, 1711.70630, -2530.02783, 13.18940,   0.00000, 0.00000, -5.88000);
CreateDynamicObject(1685, 1704.72559, -2531.73486, 13.18940,   0.00000, 0.00000, -5.88000);
CreateDynamicObject(1685, 1711.47144, -2536.75708, 13.18940,   0.00000, 0.00000, -27.12001);
CreateDynamicObject(1225, 1696.45862, -2535.34790, 12.96523,   -15.42001, -87.59998, 0.00000);
CreateDynamicObject(1225, 1697.61401, -2533.94727, 12.96523,   -15.42001, -87.59998, -54.59999);
CreateDynamicObject(1225, 1700.05969, -2535.49487, 12.96523,   -15.42001, -87.59998, 53.58000);
CreateDynamicObject(3271, 1822.89026, -2568.19531, -1.07120,   34.38008, 129.00002, 125.51994);
CreateDynamicObject(3795, 1749.07495, -2522.29248, 12.72108,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3794, 1783.94629, -2538.25513, 13.17001,   0.00000, 0.00000, -17.34000);
CreateDynamicObject(1224, 1790.13782, -2539.23535, 14.37918,   0.00000, 0.00000, 30.72000);
CreateDynamicObject(2044, 1791.90112, -2540.05835, 12.62142,   0.00000, 0.00000, -47.94000);
CreateDynamicObject(3722, 1789.72437, -1790.60498, 0.44093,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1136, 1787.85217, -1802.81042, 3.47245,   -91.08002, -52.56002, 0.00000);
CreateDynamicObject(11011, 1933.62061, -1807.92590, 15.44841,   0.00000, 0.00000, 88.37997);
CreateDynamicObject(3279, 2066.02563, -1874.56812, 11.96845,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 2095.39722, -1626.29626, 12.54542,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 2535.22437, -1815.46655, 12.53884,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10763, 1459.98901, -2437.27637, 45.25011,   0.00000, 0.00000, -136.44003);
CreateDynamicObject(3574, 2073.28076, -2210.11841, 14.97656,   3.14159, 0.00000, -89.86921);
CreateDynamicObject(17020, 2065.68042, -2243.86255, 15.99242,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18780, 1907.38110, -1444.01672, 14.79830,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(13641, 1906.89478, -1362.26465, 13.80210,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(18780, 1931.88953, -1443.70996, 14.79832,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(13638, 1936.81348, -1400.60852, 14.69897,   0.00000, 0.00000, 3.60015);
CreateDynamicObject(13637, 1872.71936, -1390.86755, 14.40887,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2893, 1941.42212, -1393.64844, 21.90203,   0.00000, 0.00000, -82.91999);
CreateDynamicObject(2960, 1941.84717, -1391.34863, 21.83451,   0.00000, 0.00000, 77.34000);
CreateDynamicObject(2960, 1944.39099, -1388.10522, 21.83451,   0.00000, 0.00000, 26.28000);
CreateDynamicObject(2960, 1944.62988, -1387.88306, 19.20627,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(2960, 1944.62988, -1387.88306, 14.62290,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(2960, 1947.22632, -1384.98608, 21.83451,   0.00000, 0.00000, 66.78000);
CreateDynamicObject(2960, 1948.57690, -1386.78503, 21.83451,   0.00000, 0.00000, 10.26000);
CreateDynamicObject(2960, 1943.57703, -1393.28235, 21.83451,   0.00000, 0.00000, 10.68000);
CreateDynamicObject(2960, 1946.91528, -1391.05798, 21.83451,   0.00000, 0.00000, 61.44001);
CreateDynamicObject(2960, 1949.08643, -1387.03650, 21.83451,   0.00000, 0.00000, 61.44001);
CreateDynamicObject(2960, 1945.76050, -1392.70105, 19.20627,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(2960, 1945.76050, -1392.70105, 14.97133,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(2960, 1943.02942, -1391.98218, 21.83451,   0.00000, 0.00000, 48.00002);
CreateDynamicObject(2960, 1944.72607, -1390.51538, 21.83451,   0.00000, 0.00000, 123.90002);
CreateDynamicObject(2960, 1945.65625, -1388.43701, 21.83451,   0.00000, 0.00000, 60.83994);
CreateDynamicObject(2960, 1946.44714, -1389.23840, 21.83451,   0.00000, 0.00000, 27.95994);
CreateDynamicObject(3279, 1867.97522, -1404.01367, 12.49578,   0.00000, 0.00000, -4.38000);
CreateDynamicObject(3279, 2462.97632, -1886.27356, 12.54117,   0.00000, 0.00000, -87.06001);
CreateDynamicObject(3066, 2453.64966, -1885.08179, 13.45630,   0.00000, 0.00000, 91.20002);
CreateDynamicObject(18862, 2479.54419, -1900.64868, 14.06464,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1599.04761, -1668.22864, 27.97123,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1597.39111, -1669.06018, 27.97123,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 1600.20227, -1671.21887, 27.97123,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2114, 2317.09888, -1527.46301, 24.50748,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2114, 2290.63135, -1528.27258, 26.07559,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18259, 2522.31592, -1531.63672, 24.03036,   0.00000, 0.00000, 267.42010);
CreateDynamicObject(1225, 2511.63989, -1531.23853, 23.27467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2510.30664, -1530.48120, 23.27467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2511.30029, -1528.88330, 23.27467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2510.03540, -1528.64478, 23.27467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2511.04932, -1527.19263, 23.27467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 2510.09326, -1526.56470, 23.27467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2370, 2521.56592, -1534.62427, 23.99809,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3794, 2527.64746, -1534.02759, 24.67215,   0.00000, 0.00000, 44.16001);
CreateDynamicObject(3794, 2526.75806, -1530.23645, 24.67215,   0.00000, 0.00000, 109.20002);
CreateDynamicObject(356, 2516.35767, -1531.58643, 24.11132,   76.43998, -42.66003, 0.00000);
CreateDynamicObject(356, 2516.37524, -1530.63135, 24.11132,   76.43998, -42.66003, 82.68000);
CreateDynamicObject(2043, 2522.59082, -1534.06714, 24.84467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2043, 2522.38452, -1534.04517, 24.84467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2043, 2521.40625, -1534.00464, 24.84467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2043, 2521.22485, -1534.03613, 24.84467,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2985, 2519.91895, -1528.27112, 24.11070,   0.00000, 0.00000, 37.02000);
CreateDynamicObject(2985, 2519.39063, -1528.30579, 24.11070,   0.00000, 0.00000, 146.16002);
CreateDynamicObject(1213, 2526.30273, -1531.53674, 24.18000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1213, 2526.01050, -1531.96729, 24.18000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1213, 2526.00854, -1531.13989, 24.18000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1502, 2521.29175, -1526.57739, 24.10780,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2370, 2359.33252, -1710.00269, 12.76057,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(348, 2359.51709, -1710.14661, 13.64563,   -71.63999, -0.36000, 131.69998);
CreateDynamicObject(348, 2359.87964, -1709.74524, 13.64563,   -82.26000, -3.06000, -89.39999);
CreateDynamicObject(2061, 2356.76563, -1719.92297, 13.09627,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 2356.41577, -1719.93359, 13.09627,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 2356.41309, -1719.64734, 13.09627,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2061, 2356.65527, -1719.61926, 13.09627,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2064, 2355.26514, -1719.45313, 13.25978,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3014, 2358.27515, -1709.04834, 12.92452,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3014, 2357.60205, -1709.74927, 12.92452,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3014, 2358.09058, -1710.26929, 12.92452,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3014, 2360.92480, -1710.56165, 12.92452,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3014, 2361.60522, -1709.72791, 12.92452,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3014, 2360.88940, -1708.85986, 12.92452,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11092, 1649.14038, -2135.60474, 15.12724,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(11011, 1615.79236, -2135.08472, 16.56527,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11292, 1645.43298, -2111.91211, 13.96635,   0.00000, 0.00000, -43.32000);
CreateDynamicObject(1503, 1587.53259, -1934.15393, 27.33173,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1503, 1584.19873, -1934.58069, 27.33173,   0.00000, 0.00000, 24.12000);
CreateDynamicObject(10984, 1639.27905, -2126.69385, 12.54309,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10985, 1622.28125, -2148.99536, 13.10884,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 637.00513, -1823.90479, 9.12960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 631.86151, -1823.89905, 9.12960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 627.02039, -1823.89807, 9.12960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 622.64728, -1823.90112, 9.12960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 617.88940, -1823.90479, 9.12960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 613.01318, -1823.94836, 9.12960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 608.04834, -1823.89026, 9.12960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 642.19403, -1824.00378, 9.12960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1364, 492.39661, -1782.35156, 5.61047,   0.00000, 0.00000, -95.15999);
CreateDynamicObject(1364, 487.95367, -1781.98975, 5.61047,   0.00000, 0.00000, -274.97989);
CreateDynamicObject(804, 499.70990, -1782.69238, 5.93419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 493.00208, -1788.17261, 5.93419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 494.71216, -1789.53357, 5.93419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 495.63208, -1792.14807, 5.93419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 494.83536, -1794.79688, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 484.11621, -1782.71179, 5.93419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 493.37582, -1796.75122, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 488.65140, -1798.10596, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 490.80185, -1798.10986, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 486.86798, -1797.64197, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 485.84811, -1796.06531, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 484.43845, -1794.07556, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 484.33371, -1792.28149, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 484.99982, -1790.43237, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 485.90051, -1788.85706, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 487.48108, -1788.03894, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 494.06903, -1788.86914, 5.93419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 495.08325, -1790.91748, 5.93419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 495.51950, -1793.50183, 5.93419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 494.22900, -1795.65540, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 492.19229, -1797.36414, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 489.86786, -1797.90576, 6.37854,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(804, 491.58472, -1787.47034, 5.93419,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(9915, 489.08936, -1802.26794, -8.32264,   0.00000, 0.00000, 91.86002);
CreateDynamicObject(1369, 489.43420, -1806.79810, -16.19391,   0.00000, 0.00000, 160.73997);
CreateDynamicObject(18963, 489.34241, -1807.08533, -15.77476,   0.00000, 0.00000, 66.06000);
CreateDynamicObject(19314, 489.36697, -1806.95557, -15.66281,   50.00000, 90.00000, -12.42000);
CreateDynamicObject(19833, 489.14163, -1807.17786, -16.55769,   -30.00000, 0.00000, -185.27969);
CreateDynamicObject(19941, 489.47638, -1806.74878, -16.24003,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1639, 527.51196, -1868.37292, 2.65120,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1639, 527.52612, -1874.39929, 2.65120,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(1598, 524.62213, -1870.79370, 3.35620,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(718, 536.50500, -1877.70520, 2.57060,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(718, 537.23535, -1866.13660, 3.02473,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(718, 518.10181, -1866.10767, 3.02473,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(718, 518.02521, -1877.45239, 2.45189,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 535.30170, -1866.10168, 4.59293,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 531.64081, -1866.10864, 4.59811,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 527.94012, -1866.09753, 4.59644,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 524.20013, -1866.08081, 4.60721,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 520.45959, -1866.08313, 4.58823,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 534.56451, -1877.67224, 4.12768,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 530.86542, -1877.65796, 4.12768,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 527.14539, -1877.65210, 4.12768,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 523.41565, -1877.62720, 4.12768,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 519.88538, -1877.64600, 4.12768,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2945, 517.87402, -1868.09436, 4.73786,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2945, 517.91193, -1875.26245, 4.73786,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2945, 536.90613, -1875.07129, 4.73786,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2945, 537.17249, -1867.89050, 4.73786,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3439, 537.00397, -1869.83875, 7.07157,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 536.84503, -1873.46887, 7.07157,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 518.02698, -1873.44604, 6.79433,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 517.95844, -1870.13989, 6.79433,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19833, 2316.77832, -654.46802, 129.64407,   7.20000, 8.04000, 0.00000);
CreateDynamicObject(19833, 2320.24023, -655.42474, 129.64407,   7.20000, 8.04000, 0.00000);
CreateDynamicObject(19833, 2315.82690, -651.84454, 129.94371,   7.20000, 8.04000, 0.00000);
CreateDynamicObject(19833, 2316.48779, -658.88751, 129.23172,   7.20000, 8.04000, 0.00000);
CreateDynamicObject(19833, 941.53107, -298.82132, 55.33681,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19833, 943.81335, -303.00400, 56.16565,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19833, 940.99493, -304.19379, 55.29217,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19833, 937.87006, -308.37689, 54.71258,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16442, 933.43921, -311.26804, 55.03471,   0.00000, 0.00000, 78.42000);
CreateDynamicObject(11470, 957.04395, -313.11057, 63.28556,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19833, 931.60229, -317.55295, 52.91498,   11.82000, -12.42000, -60.12000);
CreateDynamicObject(19833, 935.31537, -332.38626, 55.45358,   -6.60000, -18.42000, 0.00000);
CreateDynamicObject(16442, 934.53217, -340.96674, 57.58986,   -27.06001, 1.98000, 84.24001);
CreateDynamicObject(19833, 929.30505, -325.37128, 52.64252,   17.81999, -62.16005, -181.07993);
CreateDynamicObject(16442, 915.03375, -329.18552, 49.75850,   -27.06001, 1.98000, 84.24001);
CreateDynamicObject(11470, 953.39636, -334.61929, 63.64149,   -10.56000, 11.70000, 104.52000);
CreateDynamicObject(16776, 1086.68616, -225.83028, 70.29856,   18.24000, -1.98000, 166.25999);
CreateDynamicObject(18846, 1077.77002, -354.67917, 79.26353,   0.48000, -71.93998, 0.00000);
CreateDynamicObject(19833, 1067.33728, -353.53561, 76.90597,   -2.04000, 15.42000, 0.00000);
CreateDynamicObject(18643, 1067.69690, -354.02463, 78.11050,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(18643, 1067.50525, -354.10818, 78.15713,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2976, 1073.36780, -355.13586, 76.94743,   -36.06002, -82.56008, 0.00000);
CreateDynamicObject(2976, 1067.44446, -353.57590, 77.60816,   90.72000, 18.30001, -16.32001);
CreateDynamicObject(2908, 1101.62756, -340.17853, 73.06139,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18963, 1107.76245, -352.53159, 73.03754,   0.47999, -30.24001, 0.00000);
CreateDynamicObject(19836, 1274.38342, 293.88193, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1274.58301, 293.20621, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1275.30518, 293.50211, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1275.63257, 293.05609, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1276.24353, 293.58209, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1276.71729, 293.09445, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1277.34033, 293.65765, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1277.78943, 293.08737, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1278.29114, 293.75143, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1279.06824, 293.49243, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1279.30823, 294.21375, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.12585, 293.98950, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.22241, 294.11871, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.36414, 294.12146, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.46118, 294.08942, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.28503, 293.97006, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.44177, 293.93069, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.35767, 293.73962, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.11951, 293.60770, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.14392, 293.80612, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.30774, 293.82626, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.24841, 293.67249, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2906, 1281.38245, 293.84250, 19.53320,   -69.90002, -351.59991, -13.56000);
CreateDynamicObject(330, 1281.40015, 293.87292, 19.31302,   -1.38000, 63.12003, 72.89999);
CreateDynamicObject(19590, 1280.82605, 294.09668, 19.62333,   -175.44016, -209.45970, -114.90001);
CreateDynamicObject(19836, 1281.75281, 294.62241, 20.02030,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.75281, 294.62241, 19.80413,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.75281, 294.62241, 19.60597,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.73474, 294.63089, 19.60597,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.73474, 294.63089, 19.40668,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.73474, 294.63089, 19.18927,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.80249, 294.77582, 20.02030,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.86890, 294.96552, 20.02030,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.77563, 294.74371, 19.60597,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.66113, 294.48734, 19.60597,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.22546, 293.38049, 19.60597,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.22546, 293.38049, 19.81338,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.22546, 293.38049, 19.97019,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.22546, 293.38049, 20.09311,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.22546, 293.38049, 19.38340,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.23523, 293.39795, 19.19508,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.10742, 293.13843, 19.35259,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.04382, 293.03442, 19.53150,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.06165, 293.02057, 19.72777,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.09888, 293.15909, 20.05895,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1281.05115, 293.01956, 19.92231,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.94336, 292.74429, 19.19508,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.94348, 292.74429, 19.34478,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.91296, 292.71152, 19.56934,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.90747, 292.68939, 19.75302,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.90747, 292.68942, 19.93670,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.83862, 292.54416, 20.18378,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.76147, 292.38037, 20.27881,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.71252, 292.32214, 19.26605,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.72107, 292.28955, 19.43101,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.64819, 292.22366, 19.66542,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.62256, 292.12708, 19.87789,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.53687, 291.98615, 20.03113,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.47205, 291.77612, 19.87789,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.44373, 291.64795, 19.63662,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.40320, 291.57901, 19.46429,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.40320, 291.57901, 19.29493,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.60681, 292.10925, 19.56707,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.51160, 291.92340, 19.56707,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.48242, 291.76596, 19.56707,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.58569, 293.10910, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.72021, 292.73389, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.44214, 292.47202, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.51843, 291.99765, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.16992, 291.88113, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.31494, 291.36432, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1281.04431, 293.45248, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.90857, 293.98459, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1281.48694, 294.44940, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1281.24878, 294.86844, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1280.21082, 291.11493, 19.29493,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.11768, 290.97968, 19.36387,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.09473, 290.86035, 19.50175,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.09473, 290.86035, 19.69945,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.14282, 290.98639, 19.83784,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.15405, 291.00500, 20.01577,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.09473, 290.86035, 20.11461,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1280.47009, 291.83932, 20.03113,   0.00000, 90.00000, -24.06000);
CreateDynamicObject(19836, 1279.65674, 291.28568, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, 1279.84998, 290.72418, 18.55849,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10763, -1255.89844, 47.17969, 45.90625,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19944, 2397.72827, 285.13947, 19.15385,   5.04000, -3.48000, 0.00000);
CreateDynamicObject(19793, 996.47864, -54.88680, 80.18453,   6.96000, -6.72000, 12.72000);
CreateDynamicObject(19793, 996.47864, -54.88680, 80.18453,   6.96000, -6.72000, -49.56000);
CreateDynamicObject(19793, 996.47864, -54.88680, 80.18453,   -31.44000, 10.56000, -109.62003);
CreateDynamicObject(19793, 996.47864, -54.88680, 80.18453,   6.96000, -6.72000, -49.56000);
CreateDynamicObject(790, 1010.14063, -66.54688, 78.12500,   3.14159, 0.00000, 0.50186);
CreateDynamicObject(2120, 998.57660, -53.79686, 80.99425,   0.00000, 0.00000, 19.26000);
CreateDynamicObject(2931, -303.47552, 1599.89880, 74.11806,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(6965, 1325.53699, 1319.70813, 13.77457,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(6964, 1325.59094, 1319.68921, 9.77248,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(6965, 1325.53699, 1319.70813, 13.38862,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(6965, 1325.53699, 1319.70813, 13.03623,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(718, 1337.91089, 1320.43750, 9.71664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(718, 1312.97705, 1319.90344, 9.71664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1314.15955, 1294.40076, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1318.10815, 1294.54480, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1321.94055, 1294.52722, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1321.85266, 1290.66016, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1318.69263, 1288.72754, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1314.89490, 1288.58899, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1311.40186, 1289.43884, 8.95355,   0.00000, 0.00000, -0.06000);
CreateDynamicObject(3515, 1309.24780, 1292.49695, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1309.27100, 1296.17883, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1310.07471, 1299.63342, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1312.77185, 1302.43506, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1316.28406, 1303.17188, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1319.96252, 1303.31958, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1330.87231, 1288.95569, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1330.75354, 1292.85669, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1330.77405, 1296.61719, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1330.57605, 1300.69885, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1333.17273, 1303.70447, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1337.26917, 1302.96179, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1339.39148, 1299.64917, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1338.90918, 1295.77100, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 1334.86035, 1296.16455, 8.95355,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1597, 1282.62048, 1340.82947, 12.29260,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(718, 1289.36694, 1341.04468, 9.71664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1597, 1296.18701, 1340.78870, 12.29260,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(718, 1303.44128, 1340.87280, 9.71664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1597, 1310.56848, 1340.69409, 12.29260,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(718, 1317.83777, 1340.81641, 9.71664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1597, 1324.89783, 1340.57800, 12.29260,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(718, 1332.07996, 1340.58240, 9.71664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1597, 1338.74463, 1340.43030, 12.29260,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(718, 1345.61072, 1340.70227, 9.71664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1597, 1352.13196, 1340.43640, 12.29260,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(718, 1358.19507, 1340.63464, 9.71664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1597, 1364.77734, 1340.44617, 12.29260,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19123, -1508.20349, -1248.87646, 101.16395,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1522.77991, -1234.15466, 101.36052,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1537.02576, -1220.45251, 101.65493,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1554.43701, -1203.23767, 101.99077,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1568.61938, -1188.92285, 101.99077,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1582.34766, -1174.58862, 101.99077,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1596.09070, -1156.67578, 102.19350,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1610.46191, -1137.79285, 102.48526,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1619.41870, -1122.29285, 102.48526,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1627.60449, -1105.04675, 102.48526,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1635.90796, -1084.99048, 102.48526,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1643.11292, -1059.56763, 102.21146,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1647.05664, -1035.88611, 101.83912,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1648.24194, -1010.12976, 101.41320,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1647.25305, -985.55743, 100.86243,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1644.04150, -959.36115, 100.17098,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1640.95923, -939.23584, 99.70591,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1636.91992, -919.36365, 98.85594,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1633.45532, -893.66357, 97.84449,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1631.94666, -870.84485, 96.67870,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1633.74609, -844.20758, 94.91070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1628.60962, -814.99420, 92.52217,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1630.59253, -810.91937, 92.00878,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1633.36316, -807.94751, 91.56451,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1636.69141, -804.01349, 91.03020,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1641.92859, -799.74304, 90.09805,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1647.43030, -796.48138, 89.35624,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1652.35583, -794.56024, 88.73650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1658.77844, -793.02063, 87.83326,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1663.92786, -792.57935, 87.07423,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1669.47900, -792.87598, 86.38218,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1674.07788, -793.31342, 85.87437,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1678.30444, -794.35938, 85.24480,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1683.32361, -795.73364, 84.75332,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1687.93103, -797.42407, 84.24258,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1692.11292, -799.15118, 83.69699,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1695.61584, -800.61609, 83.13239,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1698.82898, -802.36981, 82.89376,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1702.88806, -804.61517, 82.45987,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1706.95020, -806.92035, 81.98439,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1711.27844, -809.95520, 81.40006,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1714.74890, -812.39056, 81.00704,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1718.12048, -815.14258, 80.61169,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1721.76270, -818.38666, 80.20794,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1726.14819, -822.17114, 79.54420,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1729.50476, -825.35120, 79.25063,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1732.26086, -828.11243, 78.91724,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1735.66479, -831.31586, 78.74585,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1638.07178, -828.76416, 93.62974,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1646.65942, -814.35931, 90.91979,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1664.35107, -806.97986, 87.03600,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1681.71191, -809.78375, 84.07878,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1698.23267, -818.38184, 81.84251,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1717.96594, -834.28009, 79.59020,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1731.15247, -847.67780, 78.11007,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1742.32800, -838.18378, 78.20258,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1761.18420, -870.02325, 76.27614,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1761.73438, -913.56628, 75.84222,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1755.72559, -958.67297, 75.47283,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1746.89856, -1005.87115, 74.77476,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1733.43604, -1057.42322, 74.21197,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1720.77405, -1092.20300, 73.51923,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1710.30872, -1115.49390, 72.97234,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1694.95874, -1141.67322, 72.52428,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1675.32776, -1162.88000, 71.88404,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1649.27136, -1178.02930, 71.02901,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1633.85852, -1185.88354, 70.36203,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1615.08789, -1199.53552, 68.61927,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1603.27576, -1210.96704, 67.10588,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1588.90125, -1229.12744, 64.63255,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1577.58472, -1246.25024, 62.61464,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1566.15405, -1266.96692, 59.80054,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1557.61890, -1285.81555, 57.46206,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1548.24915, -1311.29810, 54.22463,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1540.36816, -1336.53845, 50.98369,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1532.69177, -1378.71472, 45.57976,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1532.45630, -1401.68127, 43.01500,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1532.87500, -1410.74890, 41.87349,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1534.15979, -1417.73340, 41.31469,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1535.70569, -1422.76428, 40.74408,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1537.94702, -1427.75061, 40.27922,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1540.55725, -1432.57666, 39.76792,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1544.91003, -1436.23572, 39.47047,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1548.69666, -1437.65833, 39.58006,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1552.52319, -1437.56958, 39.94539,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1556.47754, -1436.60657, 40.25469,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19125, -1561.08057, -1434.98975, 40.25469,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3175, -1558.82727, -1484.78943, 37.16328,   0.00000, 0.00000, -113.88000);
CreateDynamicObject(18761, -1489.84619, -1257.82996, 105.11076,   0.00000, 0.00000, 42.24001);
CreateDynamicObject(18761, -1740.44629, -1175.35767, 58.66187,   0.00000, 0.00000, 21.12000);
CreateDynamicObject(19123, -1742.52625, -860.75458, 78.11007,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1749.12012, -883.30597, 75.91307,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1746.68848, -911.91431, 75.72065,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1740.35352, -957.63794, 75.40083,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1732.40808, -1001.70074, 74.93917,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1718.33923, -1052.77454, 74.50368,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1707.25134, -1087.07312, 73.63753,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1697.67334, -1109.29224, 73.14268,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1684.58862, -1132.64099, 72.87507,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1527.62708, -1439.82874, 39.98820,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1533.90002, -1446.46924, 39.70900,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1542.29407, -1451.02380, 39.65083,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1550.40552, -1452.32397, 39.71040,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1561.04565, -1450.59656, 39.95952,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1569.00806, -1447.15161, 40.37345,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, -1575.38879, -1443.35010, 40.76540,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1582.15808, -1438.31665, 41.12933,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1591.70496, -1429.55493, 41.82417,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1650.60779, -1350.30481, 46.70620,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1635.95691, -1373.46619, 45.46571,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1608.89050, -1410.36951, 43.13823,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1623.42078, -1390.86426, 44.29803,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1663.81311, -1329.50537, 48.00508,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1675.55347, -1309.84546, 48.91370,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1684.42114, -1294.72034, 49.55055,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1693.72266, -1278.25903, 50.41084,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1703.74475, -1259.19348, 51.26072,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1722.92700, -1223.09033, 52.99692,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1732.54150, -1204.61169, 53.66886,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1713.51807, -1240.49634, 52.14382,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, -1740.84485, -1187.81311, 54.00070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1573.83875, -1426.62146, 41.11097,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1581.65125, -1419.29675, 41.74492,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1598.53723, -1400.80920, 43.10489,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1612.95483, -1382.10461, 44.42895,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1625.03516, -1365.29565, 45.33136,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1640.41797, -1342.22290, 46.67968,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19122, -1652.62378, -1321.93042, 48.05555,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(358, -1618.68677, -1424.15051, 58.78654,   -81.71996, 24.35999, 0.00000);
CreateDynamicObject(330, -1618.48938, -1424.58887, 58.79769,   -17.82001, -82.49996, 0.00000);
CreateDynamicObject(19944, -1706.48389, -949.45575, 69.91871,   4.62000, 30.60000, 42.18001);
CreateDynamicObject(18880, -1705.32922, -824.34076, 78.58089,   0.00000, 0.00000, -144.47992);
CreateDynamicObject(18880, -1536.07971, -1448.82410, 36.72498,   0.00000, 0.00000, -197.04004);
CreateDynamicObject(3819, -1744.87146, -1187.92358, 54.76183,   0.00000, 0.00000, -153.59996);
CreateDynamicObject(3819, -1740.85596, -1196.07996, 54.69906,   0.00000, 0.00000, -153.65994);
CreateDynamicObject(3819, -1736.89111, -1204.11328, 54.31727,   0.00000, 0.00000, -153.65994);
CreateDynamicObject(3819, -1723.99451, -1228.00488, 53.35955,   0.00000, 0.00000, -153.65994);
CreateDynamicObject(3819, -1720.08057, -1235.82349, 53.14975,   0.00000, 0.00000, -153.65994);
CreateDynamicObject(1632, -2284.30664, -1634.36975, 483.73361,   0.00000, 0.00000, -89.22000);
CreateDynamicObject(19833, -2432.20288, -1620.56641, 526.08112,   -50.00000, 0.00000, 0.00000);
CreateDynamicObject(19307, -2432.11572, -1620.66125, 526.27203,   0.00000, 0.00000, -67.38002);
CreateDynamicObject(1225, -2432.43872, -1620.05859, 527.88110,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11733, -2583.46558, -1548.98279, 433.63931,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1632, -2287.91797, -1619.23730, 483.84854,   0.00000, 0.00000, -58.62000);
CreateDynamicObject(1632, -2298.31445, -1598.37061, 482.98871,   0.00000, 0.00000, -37.13998);
CreateDynamicObject(1632, -2298.31445, -1598.37061, 480.96051,   0.00000, 180.00000, -37.14000);
CreateDynamicObject(1632, -2287.91797, -1619.23730, 481.68463,   0.00000, 180.00000, -58.62000);
CreateDynamicObject(2931, -2642.37524, -2172.03857, 69.58331,   0.00000, 0.00000, -190.37990);
CreateDynamicObject(2931, -2641.45410, -2172.26563, 69.58331,   0.00000, 0.00000, -190.37990);
CreateDynamicObject(2931, -2640.42749, -2172.51147, 69.58331,   0.00000, 0.00000, -190.37990);
CreateDynamicObject(2370, -2816.76929, -1528.89343, 139.74208,   0.00000, 0.00000, -0.60000);
CreateDynamicObject(19527, -2818.18506, -1528.25073, 139.92265,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19320, -2810.45215, -1524.99463, 140.10388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19320, -2810.45215, -1524.99463, 140.56375,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2894, -2816.05444, -1528.32373, 140.58815,   0.00000, 0.00000, 41.64001);
CreateDynamicObject(2894, -2816.67773, -1528.02002, 140.58815,   0.00000, 0.00000, 2.28000);
CreateDynamicObject(14455, -2820.93262, -1521.86841, 141.47720,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(2908, -2816.44922, -1531.03088, 142.46640,   270.00000, 0.00000, 270.00000);
CreateDynamicObject(1736, -2815.23267, -1530.81873, 142.57602,   0.00000, 0.00000, 176.03979);
CreateDynamicObject(18963, -2820.86499, -1530.02917, 142.44812,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3012, -2820.47119, -1527.57019, 141.83411,   0.00000, 0.00000, -66.12010);
CreateDynamicObject(19833, -2816.08618, -1528.17542, 143.19673,   0.00000, 0.00000, 179.33998);
CreateDynamicObject(19528, -2816.43018, -1528.79956, 140.59930,   0.00000, 270.00000, 0.00000);
CreateDynamicObject(2976, -2816.05859, -1527.95642, 143.93690,   -91.62003, 4.98000, 0.00000);
CreateDynamicObject(11704, -2815.98877, -1527.26099, 144.46100,   0.00000, 0.00000, -186.30002);
CreateDynamicObject(11704, -2815.81396, -1527.55359, 144.46100,   0.00000, 0.00000, -286.19965);
CreateDynamicObject(11704, -2816.25952, -1527.52100, 144.46100,   0.00000, 0.00000, -106.08010);
CreateDynamicObject(11704, -2816.22949, -1515.19507, 142.57333,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, -2814.20898, -1514.08740, 138.69792,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, -2813.88940, -1513.36560, 138.64029,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, -2814.53613, -1512.84473, 138.67871,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11733, -2809.08228, -1517.05579, 139.84363,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1997, -2839.97705, -1560.37915, 139.99074,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1369, -2814.27881, -1511.72681, 138.92226,   0.00000, 0.00000, 26.46000);
CreateDynamicObject(2485, -2829.29028, -1491.25513, 137.70233,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.55347, -1523.92773, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.67554, -1523.82605, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.86401, -1523.72009, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.99268, -1523.60962, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.04614, -1523.43335, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.24878, -1523.57019, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.21777, -1523.13452, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.03833, -1523.10791, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.85718, -1523.02380, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.64526, -1522.98682, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.45581, -1522.86365, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.23193, -1522.76843, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.15625, -1523.03687, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.31201, -1523.17004, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.44580, -1523.29553, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.56128, -1523.45508, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.64966, -1523.57935, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.78467, -1523.73499, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.90430, -1523.91394, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.02881, -1524.09570, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.18066, -1523.77332, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.09595, -1523.56653, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.09595, -1523.56653, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.00464, -1523.23792, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.95898, -1523.02307, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.95752, -1522.92102, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.95215, -1522.79944, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.43774, -1523.48145, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.59570, -1523.41724, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.38403, -1523.10486, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.16260, -1523.97754, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.94775, -1522.61865, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.79492, -1522.67981, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.66992, -1522.79749, 139.86816,   0.00000, 0.00000, -95.21997);
CreateDynamicObject(19836, -2816.37280, -1523.93213, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.21021, -1523.70532, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.44019, -1523.52136, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.36914, -1523.61011, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.55811, -1523.22156, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.59863, -1523.07495, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19315, -2816.74097, -1523.52490, 139.89743,   -73.61997, 15.00001, 0.00000);
CreateDynamicObject(19836, -2815.98560, -1522.91003, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.98926, -1522.68945, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.51392, -1523.23462, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19590, -2815.96558, -1522.68127, 140.38870,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(19590, -2816.92578, -1522.61206, 140.38870,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(19590, -2817.59009, -1523.32813, 140.38870,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(19590, -2817.04761, -1524.11328, 140.38870,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(19590, -2815.98853, -1523.86218, 140.38870,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.03296, -1523.75830, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.90039, -1523.86804, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.19434, -1523.96521, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.03125, -1523.93726, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.64087, -1523.80481, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.74585, -1523.94824, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.58813, -1523.59424, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.60132, -1523.41370, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.65332, -1523.24023, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.75977, -1523.09656, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.79639, -1522.90002, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.84912, -1522.72681, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.10107, -1522.53528, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.27368, -1522.44055, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.48926, -1522.45422, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.67334, -1522.44360, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.82642, -1522.47437, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.01025, -1522.49646, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.18579, -1522.63989, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.35718, -1522.74341, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.48999, -1522.89331, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.60352, -1523.03882, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.66577, -1523.23547, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.72681, -1523.42590, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.68652, -1523.62781, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.61499, -1523.79761, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.48657, -1523.95630, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.33203, -1524.07886, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2817.14282, -1524.13806, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.93921, -1524.26990, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.72363, -1524.27600, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.53467, -1524.29248, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.39258, -1524.26685, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2816.18701, -1524.24670, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.99219, -1524.20020, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19836, -2815.87866, -1524.09814, 139.86816,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18963, -2815.94385, -1528.80225, 140.65265,   1.02000, -31.02001, 117.66000);
CreateDynamicObject(1025, -2809.41992, -1528.92249, 143.14073,   -7.67999, -86.88000, 0.00000);
CreateDynamicObject(19088, -2816.99634, -1401.35425, 146.77415,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3092, -2817.01831, -1401.62683, 143.16032,   0.00000, 0.00000, 164.21985);
CreateDynamicObject(11712, -2820.83936, -1518.72607, 142.78169,   180.00000, 0.00000, 0.00000);
CreateDynamicObject(3524, -2799.89355, -1543.70972, 137.94254,   0.00000, 0.00000, 169.49998);
CreateDynamicObject(2907, -2799.83179, -1543.17200, 138.75381,   0.00000, 0.00000, -53.40001);
CreateDynamicObject(3524, -2828.02563, -1538.74634, 137.94254,   0.00000, 0.00000, 132.72006);
CreateDynamicObject(2906, -2827.79224, -1538.58948, 138.61586,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3524, -2830.11475, -1494.95532, 137.94254,   0.00000, 0.00000, 52.32005);
CreateDynamicObject(2905, -2829.81421, -1495.25769, 137.95647,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3524, -2806.94873, -1488.74194, 137.94254,   0.00000, 0.00000, -35.63997);
CreateDynamicObject(2908, -2807.26880, -1488.94739, 138.14790,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(330, -2789.77173, -1603.65149, 140.41069,   78.60009, 125.75998, 0.00000);

//OBJETOS TEXTURIZADOS//***
CasaTienda[0] = CreateDynamicObject(19505, 2359.28076, -1714.21460, 14.60249,   0.00000, 0.00000, 88.98000);
CasaTienda[1] = CreateDynamicObject(19506, 2359.28076, -1714.21460, 14.60250,   0.00000, 0.00000, 88.98000);
SetDynamicObjectMaterial(CasaTienda[0], 0, 11088, "crackfactdem_sfs", "ws_altz_wall7burn");
SetDynamicObjectMaterial(CasaTienda[0], 1, 12962, "sw_apartflat", "floor_tileone_256");
SetDynamicObjectMaterial(CasaTienda[0], 2, 11088, "crackfactdem_sfs", "ws_altz_wall7burn");
SetDynamicObjectMaterial(CasaTienda[0], 6, 11088, "crackfactdem_sfs", "ws_altz_wall7burn");
SetDynamicObjectMaterial(CasaTienda[1], 0, 3899, "hospital2", "burnt_faggots64");
SetDynamicObjectMaterial(CasaTienda[1], 1, 18364, "cs_scrapyard", "Was_scrpyd_bale_exh");
SetDynamicObjectMaterial(CasaTienda[1], 2, 3899, "hospital2", "burnt_faggots64");

//armas en el radar
JBC_AddStaticPickup(358, 3, 2651.7129, -1612.3940, 10.8782, 0); //sniper 1
JBC_AddStaticPickup(358, 3, 2529.5300, -1953.6107, 13.1038, 0); //sniper 2
JBC_AddStaticPickup(356, 3, 2283.3276, -1764.1542, 13.1142, 0); //m4 1
JBC_AddStaticPickup(356, 3, 2155.7539, -1735.0403, 13.54, 0); //m4 2
JBC_AddStaticPickup(356, 3, 2063.4399, -1830.4712, 22.4399, 0); //m4 3
JBC_AddStaticPickup(356, 3, 1947.3213, -1814.1241, 13.5594, 0); //m4 4
JBC_AddStaticPickup(351, 3, 1696.0792, -1970.2991, 8.8248, 0); //EDC 1
JBC_AddStaticPickup(351, 3, 1926.3446, -1977.7560, 13.5544, 0); //EDC2
JBC_AddStaticPickup(353, 3, 1934.2136, -2148.2947, 21.6484, 0); //MP5 1
JBC_AddStaticPickup(353, 3, 1808.5038, -2063.5244, 13.5575, 0); //MP5 2
JBC_AddStaticPickup(348, 3, 1735.5729, -2082.9912, 13.5469, 0); //Desert 1
JBC_AddStaticPickup(348, 3, 1612.5863, -1847.5470, 20.5500, 0); //Desert 2
JBC_AddStaticPickup(350, 3, 1567.6331, -1751.0980, 4.5536, 0); //Recortadas 1
JBC_AddStaticPickup(350, 3, 1410.5897, -1719.3512, 31.8672, 0); //Recortadas 2
JBC_AddStaticPickup(352, 3, 1540.8846, -1759.0508, 33.4297, 0); //UZI 1
JBC_AddStaticPickup(352, 3, 1395.6238, -1680.8816, 39.5469, 0); //UZI 2
JBC_AddStaticPickup(361, 3, 1518.5640, -1467.1398, 63.8594, 0); //Quemador
JBC_AddStaticPickup(342, 3, 1875.2709, -1310.1980, 49.4141, 0); //Granadas
JBC_AddStaticPickup(359, 3, 1541.8138, -1365.7275, 326.2109, 0); //Rocket
JBC_AddStaticPickup(355, 3, 1681.3928, -1951.2161, 13.5469, 0); //AK-47

//Pickup de armadura
	//Chalecos
JBC_AddStaticPickup(1242,3,2688.4221,-2114.6604,13.5488, -1);
JBC_AddStaticPickup(1242,3,2821.4761,-1214.6162,25.8815, -1);
JBC_AddStaticPickup(1242,3,2458.6235, -1678.8450, 29.8287, -1);

/////////////////////////////////////////////////////////////////////////////////////////////

///MAPEO VIP GP-------------------------------------------------------------------------------------------------------------------------
CreateDynamicObject(621, 2990.68262, -2014.24585, 11.44474,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(621, 2987.83154, -1929.65332, 10.93004,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(621, 2976.33594, -1950.50049, 11.26798,   0.00000, 0.00001, 28.62000);
CreateDynamicObject(621, 2972.24805, -1993.91138, 10.85935,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(621, 2985.83594, -2042.55737, 11.61542,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(621, 2983.55664, -2064.57324, 11.48368,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(621, 3006.34814, -1925.54517, 11.38333,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(621, 3034.62793, -1925.97888, 10.79943,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(621, 3063.60254, -1926.73413, 10.82368,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(621, 3114.38403, -1981.87097, 11.51749,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(621, 3124.56787, -2048.17188, 11.33937,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(10378, 3051.01587, -1979.47937, 11.67730,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 3051.12646, -1978.93286, 11.54437,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3515, 3029.13818, -2002.67017, 12.01512,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3515, 3028.99609, -1956.74292, 12.01512,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3515, 3073.58740, -1956.64563, 12.01511,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3515, 3073.22754, -2002.74292, 12.01511,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3462, 3073.40137, -1956.55640, 14.34804,   -0.00001, 0.00000, -123.95995);
CreateDynamicObject(3462, 3028.97217, -1956.79126, 14.34805,   0.00000, 0.00000, -45.41998);
CreateDynamicObject(3462, 3029.26660, -2002.60254, 14.34805,   0.00000, 0.00000, 39.47998);
CreateDynamicObject(3462, 3073.27002, -2002.71216, 14.34804,   0.00000, 0.00000, 132.11995);
CreateDynamicObject(17029, 3127.60254, -1933.55884, 4.76731,   0.00000, -0.00001, 157.61995);
CreateDynamicObject(17029, 3121.65625, -1938.42480, 4.76731,   0.00000, -0.00001, 157.61995);
CreateDynamicObject(17071, 3114.13281, -1925.51660, 28.04185,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(19841, 3109.32520, -1942.55078, 12.88416,   0.00000, 0.00000, -41.81999);
CreateDynamicObject(19841, 3098.12402, -1930.16553, 11.49785,   0.00000, 0.00000, -47.21994);
CreateDynamicObject(19840, 3118.68604, -1950.74219, 16.19698,   0.00000, 0.00001, -19.61998);
CreateDynamicObject(4206, 3107.72656, -1941.72266, 12.35046,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(14467, 3110.79053, -1934.72888, 36.67902,   0.00000, 0.00000, -50.76000);
CreateDynamicObject(14467, 3106.96631, -1929.01599, 34.62173,   0.00000, 0.00001, -0.00001);
CreateDynamicObject(11489, 3054.00586, -1978.59668, 11.67116,   0.00001, 0.00000, 90.59999);
CreateDynamicObject(11489, 3051.00342, -1982.04126, 11.67116,   0.00000, 0.00001, 0.60000);
CreateDynamicObject(11489, 3051.05078, -1975.62085, 11.67116,   0.00000, -0.00001, -179.39995);
CreateDynamicObject(11489, 3048.21582, -1978.83765, 11.67116,   -0.00001, 0.00000, -89.39997);
CreateDynamicObject(3935, 3049.26074, -1977.00391, 21.36407,   0.00001, 0.00000, 89.81998);
CreateDynamicObject(3935, 3049.28955, -1980.72205, 18.47585,   0.00000, -0.00001, 179.93991);
CreateDynamicObject(3935, 3052.74438, -1980.82080, 18.47585,   0.00001, 0.00000, 92.57993);
CreateDynamicObject(3935, 3052.85205, -1976.85059, 20.08271,   0.00000, -0.00001, 177.71994);
CreateDynamicObject(18963, 3049.21826, -1976.99146, 23.81387,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(18368, 3250.88623, -1902.09180, 22.77733,   0.00000, -0.00001, 169.07999);
CreateDynamicObject(4206, 3117.18701, -1948.87646, 12.34046,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(4206, 3098.93750, -1933.39429, 12.34046,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3471, 3107.31006, -2009.18286, 12.67308,   0.00000, -0.00001, 179.99995);
CreateDynamicObject(3471, 3107.84106, -2042.80688, 12.67308,   0.00000, -0.00001, 179.99995);
CreateDynamicObject(1280, 3072.10303, -2011.81116, 11.99996,   0.00001, 0.00000, 89.99998);
CreateDynamicObject(1280, 3028.56982, -2011.79956, 11.99997,   0.00001, 0.00000, 89.99998);
CreateDynamicObject(1280, 3015.36230, -2002.05713, 11.99997,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1280, 3015.37671, -1956.54065, 11.99997,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1280, 3029.10400, -1947.19360, 11.99997,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1280, 3073.61670, -1947.43726, 11.99996,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1280, 3086.30859, -1956.64551, 11.99996,   0.00000, -0.00001, 179.99995);
CreateDynamicObject(1280, 3086.58398, -2002.94971, 11.99996,   0.00000, -0.00001, 179.99995);
CreateDynamicObject(1231, 3091.51025, -2056.99023, 14.11330,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3047.44580, -2057.97192, 14.15406,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3126.89502, -2057.52075, 14.09496,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(16770, 3369.55225, -1965.72742, 28.90716,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1583, 3394.00098, -1960.53064, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(3515, 3113.00488, -1929.32471, 16.85156,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3515, 3120.49121, -1933.11230, 12.85120,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(11490, 3269.17432, -1916.36816, 27.35890,   -0.00001, 0.00000, -122.92007);
CreateDynamicObject(11491, 3259.87256, -1910.42285, 28.72153,   -0.00001, 0.00000, -122.92008);
CreateDynamicObject(1703, 3267.35107, -1912.31641, 28.86166,   0.00000, 0.00001, -32.39998);
CreateDynamicObject(1704, 3270.53027, -1915.16516, 28.82392,   -0.00001, 0.00000, -73.50003);
CreateDynamicObject(1704, 3269.52832, -1918.07166, 28.82392,   0.00000, -0.00001, -157.91995);
CreateDynamicObject(1703, 3266.17236, -1917.59424, 28.86166,   0.00000, -0.00001, 147.24017);
CreateDynamicObject(19590, 3272.93506, -1918.31543, 31.35294,   -30.00000, 0.00001, -32.99999);
CreateDynamicObject(19590, 3272.49805, -1918.99536, 31.35294,   -29.99999, -0.00001, 149.99995);
CreateDynamicObject(3525, 3262.95068, -1912.44580, 28.09998,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3525, 3263.12891, -1912.03101, 28.09998,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(357, 3264.23242, -1910.66260, 31.14334,   0.00001, 9.00000, 60.95999);
CreateDynamicObject(357, 3261.81104, -1914.31201, 31.14334,   -0.00001, 9.00000, -115.31995);
CreateDynamicObject(1736, 3263.37646, -1912.60425, 32.34196,   0.00001, 0.00000, 60.47999);
CreateDynamicObject(1828, 3266.98145, -1915.02344, 28.86135,   0.00000, 0.00001, -32.28000);
CreateDynamicObject(19174, 3267.43896, -1920.64832, 31.14684,   0.00000, -0.00001, 147.89993);
CreateDynamicObject(19175, 3263.73096, -1918.25806, 31.12613,   0.00000, -0.00001, 147.41988);
CreateDynamicObject(19172, 3272.61963, -1913.18213, 30.90664,   0.00000, 0.00001, -33.23999);
CreateDynamicObject(19173, 3269.61523, -1911.23389, 30.67704,   0.00000, 0.00001, -33.23999);
CreateDynamicObject(2069, 3265.66602, -1919.11890, 28.90223,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(2001, 3270.75732, -1912.25171, 28.86104,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(736, 3286.37891, -1907.89453, 38.32800,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(736, 3266.06104, -1938.95630, 38.42923,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3749, 3232.91138, -2017.94421, 31.41066,   0.00001, 0.00000, 89.99998);
CreateDynamicObject(3749, 3232.90210, -2033.54285, 31.41066,   0.00001, 0.00000, 89.99998);
CreateDynamicObject(18368, 3244.20215, -1890.79883, 16.35371,   0.00000, -0.00001, 170.22014);
CreateDynamicObject(18368, 3246.33008, -1880.65674, 9.55477,   0.00000, -0.00001, 160.20015);
CreateDynamicObject(1583, 3394.08838, -1963.46350, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3394.00635, -1966.54138, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3390.88086, -1961.91431, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3391.01123, -1964.39258, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3387.45654, -1963.07410, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3391.74072, -1958.20935, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3393.50049, -1955.69824, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3391.46240, -1953.51294, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3386.58252, -1957.15723, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3389.14844, -1966.02148, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3391.00537, -1968.54492, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3393.02148, -1970.18091, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3390.67627, -1971.44312, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3393.55811, -1973.24060, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3390.06592, -1974.45105, 28.76372,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3394.01660, -1960.40271, 32.99593,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3393.78320, -1963.50452, 32.99593,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3393.73389, -1966.62134, 32.99593,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3382.03906, -1958.81812, 26.67114,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3379.71826, -1961.24829, 26.67114,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3381.60889, -1962.91162, 26.67114,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3380.02393, -1965.65210, 26.67114,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3381.50586, -1967.03210, 26.67114,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3380.38184, -1969.88159, 26.67114,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(1583, 3380.24707, -1956.89185, 26.67114,   -0.00001, 0.00000, -89.99998);
CreateDynamicObject(3361, 3255.59790, -1879.64185, 25.32506,   0.00000, -0.00001, 166.31998);
CreateDynamicObject(3361, 3251.97314, -1878.84668, 22.79233,   0.00000, -0.00001, 166.31998);
CreateDynamicObject(3361, 3249.31860, -1878.09680, 22.71322,   0.00000, -0.00001, 165.84000);
CreateDynamicObject(3361, 3258.09717, -1871.13110, 23.35154,   0.00000, 0.00000, 136.32007);
CreateDynamicObject(3361, 3254.31104, -1867.44922, 20.73084,   0.00000, 0.00000, 136.32007);
CreateDynamicObject(3361, 3249.11475, -1867.87158, 16.77437,   0.00000, 0.00000, -128.16002);
CreateDynamicObject(3361, 3248.76318, -1868.33374, 16.38218,   0.00000, 0.00000, -128.16002);
CreateDynamicObject(19842, 3327.70117, -1886.29810, 27.39790,   0.00000, 0.00000, -216.35989);
CreateDynamicObject(19841, 3337.02979, -1869.10425, 14.34260,   0.00000, -0.00001, 145.67995);
CreateDynamicObject(19841, 3340.51025, -1871.79785, 14.26371,   0.00000, -0.00001, 145.67995);
CreateDynamicObject(17029, 3260.99170, -1986.66919, 17.45061,   0.00001, 0.00000, 85.91999);
CreateDynamicObject(19840, 3275.13281, -1958.31763, 30.43710,   0.00000, -0.00001, 145.01997);
CreateDynamicObject(19588, 3292.97559, -1933.79150, 28.26958,   0.00000, 0.00001, -37.14001);
CreateDynamicObject(19841, 3337.01001, -1869.10718, 14.48059,   0.00000, -0.00001, 145.67995);
CreateDynamicObject(19841, 3341.12012, -1871.89551, 14.78106,   0.00000, -0.00001, 145.67995);
CreateDynamicObject(19840, 3332.56885, -1877.09961, 25.73812,   -29.99999, -0.00001, 144.23985);
CreateDynamicObject(19840, 3335.08398, -1879.35083, 25.73812,   -29.99999, -0.00001, 144.23985);
CreateDynamicObject(8483, 3398.36328, -1890.82776, 16.62213,   1.08000, 5.34000, 46.62002);
CreateDynamicObject(3361, 3397.24902, -1878.77393, 5.53758,   0.00000, 0.00001, -19.31999);
CreateDynamicObject(3361, 3391.59521, -1876.77905, 9.52688,   0.00000, 0.00001, -19.31999);
CreateDynamicObject(3361, 3387.07471, -1875.13354, 12.85999,   0.00000, 0.00001, -19.31999);
CreateDynamicObject(3361, 3381.38525, -1873.12671, 16.84389,   0.00000, 0.00001, -19.31999);
CreateDynamicObject(3361, 3377.42041, -1871.71899, 19.70488,   0.00000, 0.00001, -19.31999);
CreateDynamicObject(3361, 3372.66650, -1870.05579, 23.09234,   0.00000, 0.00001, -19.31999);
CreateDynamicObject(3361, 3369.42920, -1868.90784, 25.34555,   0.00000, 0.00001, -19.31999);
CreateDynamicObject(3406, 3364.41504, -1872.18188, 25.38547,   0.00001, 0.00000, 73.56001);
CreateDynamicObject(3406, 3361.94482, -1880.53369, 25.38823,   0.00001, 0.00000, 73.56001);
CreateDynamicObject(3406, 3359.46875, -1888.94922, 25.37300,   0.00001, 0.00000, 73.56001);
CreateDynamicObject(11496, 3410.12280, -1883.74487, 2.80696,   0.00000, 0.00000, 44.57998);
CreateDynamicObject(3279, 2954.38525, -1985.80334, 10.01136,   0.00000, 0.00000, -2.64000);
CreateDynamicObject(19842, 3298.21265, -1926.51965, 27.39790,   0.00000, 0.00000, -216.30000);
CreateDynamicObject(19842, 3312.98560, -1906.37988, 27.39790,   0.00000, 0.00000, -216.23990);
CreateDynamicObject(19842, 3283.44214, -1946.67969, 27.39790,   0.00000, 0.00000, -216.17999);
CreateDynamicObject(19841, 3337.02979, -1869.10425, 11.41409,   0.00000, -0.00001, 145.67995);
CreateDynamicObject(19841, 3341.12012, -1871.89551, 12.13080,   0.00000, -0.00001, 145.67995);
CreateDynamicObject(11496, 3421.29517, -1895.13208, 2.77421,   0.00000, 0.00000, 44.57998);
CreateDynamicObject(11496, 3428.17383, -1902.11145, 2.80062,   0.00000, 0.00000, 44.57998);
CreateDynamicObject(11496, 3433.14282, -1897.20239, 2.58978,   0.00000, 0.00000, 44.57998);
CreateDynamicObject(11496, 3426.26172, -1890.21411, 2.58813,   0.00000, 0.00000, 44.57998);
CreateDynamicObject(11496, 3415.31860, -1879.13916, 2.59648,   0.00000, 0.00000, 44.57998);
CreateDynamicObject(715, 3331.36719, -1900.39075, 35.54860,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 3320.36523, -1914.01746, 35.54860,   0.00000, 0.00000, -37.14000);
CreateDynamicObject(715, 3309.81909, -1927.14673, 35.54860,   0.00000, 0.00000, 50.70001);
CreateDynamicObject(715, 3294.07520, -1950.10889, 35.54860,   0.00000, 0.00000, -35.64000);
CreateDynamicObject(715, 3316.06763, -1889.49060, 35.54860,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(715, 3305.59546, -1903.58215, 35.54860,   0.00000, 0.00000, -37.14000);
CreateDynamicObject(715, 3295.10229, -1917.79834, 35.54860,   0.00000, 0.00000, 50.70001);
CreateDynamicObject(715, 3278.79297, -1939.30652, 35.54860,   0.00000, 0.00000, -35.64000);
CreateDynamicObject(18367, 3267.47559, -2004.57703, 27.35720,   -4.62000, 181.99994, 141.72009);
CreateDynamicObject(18367, 3276.55298, -2012.47363, 27.35720,   -4.62000, 181.99994, 141.72009);
CreateDynamicObject(18367, 3315.01953, -1963.92334, 27.35720,   -4.62000, 181.99994, -37.97990);
CreateDynamicObject(18367, 3305.79468, -1956.10925, 27.35720,   -4.62000, 181.99994, -37.97990);
CreateDynamicObject(18367, 3327.23804, -1948.77014, 27.35720,   -4.62000, 181.99994, 141.72009);
CreateDynamicObject(18367, 3317.83179, -1941.40356, 27.35720,   -4.62000, 181.99994, 141.72009);
CreateDynamicObject(18367, 3365.70313, -1900.16638, 27.35720,   -4.62000, 181.99994, -37.97990);
CreateDynamicObject(18367, 3355.75317, -1893.45642, 27.35720,   -4.62000, 181.99994, -37.97990);
CreateDynamicObject(17071, 3372.30981, -1890.46863, 28.45868,   0.00000, 0.00000, -34.86000);
CreateDynamicObject(17071, 3396.37158, -1897.94507, 27.09044,   0.00000, 0.00000, 46.74000);
CreateDynamicObject(17071, 3409.00952, -1909.29846, 27.09044,   0.00000, 0.00000, 40.73999);
CreateDynamicObject(17071, 3407.09033, -1923.65405, 27.09044,   0.00000, 0.00000, 40.73999);
CreateDynamicObject(17071, 3383.62061, -1891.73376, 27.09044,   0.00000, 0.00000, -2.82001);
CreateDynamicObject(17029, 3389.84961, -1911.47021, 16.63850,   0.00000, 0.00000, -36.48001);
CreateDynamicObject(16061, 3282.26978, -2045.91504, 27.18253,   0.00000, 0.00000, 89.28001);
CreateDynamicObject(16061, 3395.78589, -2016.62964, 27.18253,   0.00000, 0.00000, -5.22000);
CreateDynamicObject(3434, 3357.79639, -1896.61230, 37.40285,   0.00000, 0.00000, -11.46000);
CreateDynamicObject(3434, 3358.36548, -1892.73315, 37.40285,   0.00000, 0.00000, -189.35982);
CreateDynamicObject(3066, 3385.83398, -1985.75769, 28.21793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3066, 3385.69556, -1997.07849, 28.21793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3066, 3385.63794, -2008.73218, 28.21793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3066, 3385.67090, -2021.43567, 28.21793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3066, 3385.76904, -2033.64075, 28.21793,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1583, 3385.49072, -1985.20007, 29.02032,   0.00000, 0.00000, -91.68000);
CreateDynamicObject(1583, 3385.70386, -1996.57874, 29.02032,   0.00000, 0.00000, -91.68000);
CreateDynamicObject(1583, 3385.52661, -2008.07214, 29.02032,   0.00000, 0.00000, -91.68000);
CreateDynamicObject(1583, 3385.40771, -2020.74487, 29.02032,   0.00000, 0.00000, -91.68000);
CreateDynamicObject(1583, 3385.49097, -2032.93433, 29.02032,   0.00000, 0.00000, -91.68000);
CreateDynamicObject(2985, 3383.43140, -2039.78040, 27.35335,   0.00000, 0.00000, 147.36006);
CreateDynamicObject(2985, 3382.70972, -2040.66248, 27.35335,   0.00000, 0.00000, 202.73999);
CreateDynamicObject(2985, 3383.66846, -2041.06775, 27.35335,   0.00000, 0.00000, 241.79994);
CreateDynamicObject(1231, 3082.46753, -2057.05762, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3038.80029, -2057.86792, 14.15610,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3003.95605, -2059.24951, 14.12876,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(16061, 3320.87476, -2078.76318, 26.00347,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16061, 3318.52417, -2147.81250, 26.00347,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16061, 3318.74463, -2215.85327, 26.00347,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16061, 3318.29272, -2276.60669, 26.00347,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18367, 3276.59082, -2011.89294, 27.35720,   -4.62000, 181.99994, 90.30010);
CreateDynamicObject(18367, 3336.89307, -2011.43408, 27.35720,   -4.62000, 181.99994, -88.91993);
CreateDynamicObject(18367, 3235.05298, -2042.25159, 27.35720,   -4.62000, 181.99994, 90.30010);
CreateDynamicObject(18367, 3297.23340, -2041.72961, 27.35720,   -4.62000, 181.99994, -88.91993);
CreateDynamicObject(3524, 3304.75146, -1998.55823, 83.86079,   0.00000, 0.00000, -89.34000);
CreateDynamicObject(3515, 3288.28638, -1939.24194, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3283.00195, -1947.06372, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3271.90137, -1962.75391, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3274.57520, -1957.38684, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3293.45825, -1931.67859, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3298.01416, -1924.47900, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3303.17847, -1918.11987, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3308.63257, -1911.41467, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3313.04224, -1905.92468, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3319.34497, -1897.74268, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3322.64990, -1893.30615, 25.15095,   -91.74001, 29.88000, 0.00000);
CreateDynamicObject(3515, 3329.29712, -1873.99500, 18.42373,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3515, 3339.39063, -1872.04480, 1.74047,   -94.1400, 116.8800, 0.0000);
CreateDynamicObject(3515, 3335.68652, -1870.13074, 1.74047,   77.4000, 48.9000, 3.3000);
CreateDynamicObject(621, 3112.63965, -2001.46887, 11.51749,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(18367, 3297.18530, -2041.73694, 27.35720,   -4.62000, 181.99994, 90.30010);
CreateDynamicObject(9019, 3306.11914, -1998.60840, 28.50864,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(728, 3309.62598, -1982.10840, 28.00539,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(728, 3319.80615, -2007.66223, 28.00539,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(728, 3287.75269, -2007.43848, 28.00539,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(869, 3325.84961, -1995.26599, 27.78811,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(869, 3321.67773, -1985.29785, 27.78811,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(869, 3329.00488, -1987.25293, 27.78811,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(869, 3318.66968, -1992.72021, 27.78811,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18367, 3234.56958, -2008.38354, 27.35720,   -4.62000, 181.99994, 90.30010);
CreateDynamicObject(18367, 3336.97412, -2012.00378, 27.35720,   -4.62000, 181.99994, -180.41994);
CreateDynamicObject(19125, 3112.91797, -1948.75439, 11.31754,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19124, 3101.72534, -1943.60144, 12.91945,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19123, 3095.32617, -1937.10034, 11.37997,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 3008.02881, -1956.50159, 14.40724,   0.00000, 0.00000, -38.64001);
CreateDynamicObject(1231, 3008.14258, -1968.36121, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 3008.24414, -1981.07410, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 3008.33423, -1993.17371, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 3008.24219, -2005.21655, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 3008.32251, -2017.33325, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 3008.30933, -2029.38635, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 2993.43164, -2029.48486, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 2993.52783, -2017.24048, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 2993.36255, -2005.16992, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 2993.39819, -1993.20581, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 2993.34790, -1981.04602, 14.00785,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1231, 3018.35571, -2033.21863, 14.15610,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3038.65088, -2033.28613, 14.15610,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(3472, 3337.26538, -1981.33606, 27.57059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3472, 3336.89087, -2011.78821, 27.57059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3472, 3277.44580, -2012.08875, 27.57059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3472, 3334.57715, -2041.77087, 27.57059,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1231, 3085.90283, -2033.53882, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3085.80786, -2047.67517, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3100.09546, -2047.66589, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3100.09131, -2033.57861, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3085.89355, -2019.30969, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3100.09131, -2019.27026, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3070.89941, -2019.08252, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3056.50464, -2019.20410, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3056.70923, -2033.71216, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(1231, 3070.76489, -2033.56995, 14.16728,   0.00000, 0.00001, 0.00000);
CreateDynamicObject(18367, 3308.55029, -1923.30518, 27.46360,   7.00000, 0.00000, -36.66000);
CreateDynamicObject(18367, 3271.04199, -1972.87927, 27.46360,   7.00000, 0.00000, 142.44012);
CreateDynamicObject(18367, 3261.24658, -1965.97180, 27.46360,   7.00000, 0.00000, 142.44012);
CreateDynamicObject(18367, 3298.74634, -1916.34973, 27.46360,   7.00000, 0.00000, -36.66000);
CreateDynamicObject(18367, 3308.55249, -1923.34863, 27.46360,   7.00000, 0.00000, 142.44012);
CreateDynamicObject(18367, 3298.74707, -1916.36438, 27.46360,   7.00000, 0.00000, 143.88016);
CreateDynamicObject(18367, 3342.22192, -1879.00391, 27.46360,   7.06000, 0.12000, -36.90000);
CreateDynamicObject(18367, 3332.51807, -1870.61511, 27.46360,   7.06000, 0.12000, -36.90000);
CreateDynamicObject(3525, 2869.78662, -1970.11401, 15.52885,   0.00000, 0.00000, -79.19999);
CreateDynamicObject(3525, 2869.74536, -1959.38879, 15.52885,   0.00000, 0.00000, -79.19999);
CreateObject(897, 3092.43896, -1924.36670, 8.48469,   -0.00001, 0.00000, -100.38004, 300);
CreateObject(897, 3087.29419, -1928.87183, 8.31724,   -0.00001, 0.00000, -76.67999, 300);
CreateObject(897, 3084.68359, -1934.41479, 7.64671,   0.00000, 0.00001, -29.45999, 300);
CreateObject(897, 3087.64893, -1939.07422, 8.05592,   0.00000, 0.00001, 10.91999, 300);
CreateObject(897, 3091.61768, -1943.19043, 7.64686,   0.00000, 0.00001, -1.32000, 300);
CreateObject(897, 3096.01416, -1947.96191, 7.91779,   0.00000, -0.00001, -174.35982, 300);
CreateObject(897, 3100.90479, -1952.39368, 7.85874,   0.00000, -0.00001, -166.61987, 300);
CreateObject(897, 3106.28076, -1956.74585, 8.34748,   0.00000, -0.00001, -162.35986, 300);
CreateObject(897, 3112.19775, -1960.67456, 8.18275,   0.00000, 0.00001, 27.96048, 300);
CreateObject(897, 3118.61230, -1961.29419, 8.60042,   0.00001, 0.00000, 62.10051, 300);
CreateObject(897, 3125.24658, -1956.83521, 8.25513,   0.00001, 0.00000, 96.12025, 300);
CreateObject(897, 3097.64111, -1920.63330, 8.48469,   -0.00001, 0.00000, -100.38004, 300);
CreateObject(897, 3278.01465, -1966.49597, 30.64372,   0.00000, 0.00001, 0.00000, 300);
CreateObject(897, 3279.47705, -1962.95691, 27.32512,   0.00000, 0.00001, 0.00000, 300);
CreateObject(897, 3265.78516, -1957.80042, 30.64373,   0.00000, 0.00000, -38.58001, 300);
CreateObject(897, 3267.83154, -1954.25464, 28.05145,   0.00000, 0.00000, -38.58001, 300);
CreateObject(897, 3330.22217, -1877.18872, 20.44439,   0.00000, 0.00000, 0.00000, 300);
CreateObject(897, 3335.42261, -1878.53137, 20.44439,   0.00000, 0.00000, 0.00000, 300);
CreateObject(897, 3259.25391, -1999.01184, 29.72224,   0.00000, 0.00000, 0.00000, 300);
CreateObject(897, 3263.13477, -2001.02698, 29.72224,   0.00000, 0.00000, 0.00000, 300);

//Text Labels***************************************************************************************************************
Create3DTextLabel("Toca el "blueHM"claxón"whiteA" o presiona la tecla "blueHM"'H' "whiteA"para abrir la puerta", -1,2897.4124, -1964.7104, 10.9382, 35, 0, 0);
Create3DTextLabel("BASE VIP, /APMV para abrir, /CPMV para cerrar", 0xD5AF31FF, 3388.65845, -1875.78015, 11.93305, 5, 0, 0);
Create3DTextLabel("BASE VIP, /abrirhangar para acceder a vehiculos militares, /cerrarhangar para cerrar",0xD5AF31FF, 3364.74951, -2245.40381, 27.06715, 5, 0, 0);
Create3DTextLabel("{66FF99}Conscesionaria Smith\n"whiteA"Presiona la tecla "blueSA"'Y'"whiteA" para mostrar el catálogo de compra\n", -1, SALESMAN_TEXT, SALESMAN_DISTANC, 0, 0);//         X           Y        Z
Create3DTextLabel("{66FF99}Exportadora\n"whiteA"Si tienes algún vehículo que no te sirva vendemelo\n Presiona la tecla "blueSA"'Y'"whiteA" para realizar la transacción\n", -1, -1688.9515, 13.0076, 3.5547+1.5, 5, 0, 0);
//texto label de GP SHOP
Create3DTextLabel("{01DF74}GP SHOP\n"whiteA"Presiona la tecla "blueSA"'Y'"whiteA" para acceder al menú de compra.",0x008EFFFF, 2285.7854, -1681.1276, 14.1323+1.1, 3.0,0,1); //TiendaBallas
Create3DTextLabel("{01DF74}GP SHOP\n"whiteA"Presiona la tecla "blueSA"'Y'"whiteA" para acceder al menú de compra.",0x008EFFFF, 1875.1498, -1883.6227, 13.4598+1.1, 3.0,0,1); //TiendaAztecas
Create3DTextLabel("{01DF74}GP SHOP\n{"whiteA"Presiona la tecla "blueSA"'Y'"whiteA" para acceder al menú de compra.",0x008EFFFF, 2033.0740, -1402.9579, 17.2843+1.1, 3.0,0,1); //TiendaNangsyTRafis
Create3DTextLabel("{01DF74}GP SHOP\n"whiteA"Presiona la tecla "blueSA"'Y'"whiteA" para acceder al menú de compra.",0x008EFFFF, 1257.1116, -1237.0879, 18.1491+1.1, 3.0,0,1); //TiendaVagos
Create3DTextLabel("{01DF74}GP SHOP\n"whiteA"Presiona la tecla "blueSA"'Y'"whiteA" para acceder al menú de compra.",0x008EFFFF, 1489.0989, -1720.3221, 8.2355+1.1, 3.0,0,1); //TiendaPolicias
Create3DTextLabel("{01DF74}GP SHOP VIP\n"whiteA"Presiona la tecla "blueSA"'Y'"whiteA" para acceder al menú de compra.",0x008EFFFF, 3249.6118, -1904.9523, 28.2086+1.1, 3.0,0,1); //TiendaBasevip

//Texturas******************************************************************************************************************

//ENTRADA---------------------------------------------------------------------------------------------------
EntradaRoca[0] = CreateObject(8620, 2872.40601, -1964.66833, 32.16122,   0.00001, 0.00000, 90.05997, 300);
EntradaRoca[1] = CreateObject(8620, 2899.90405, -1964.83325, 32.16122,   0.00001, 0.00000, 90.05997, 300);
EntradaRoca[2] = CreateObject(8620, 2925.88672, -1964.79761, 32.16122,   0.00001, 0.00000, 90.05997, 300);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetObjectMaterial(EntradaRoca[TexturizarID], 0, 9743, "rock_coastsfw", "cst_rock_coast_sfw"),SetObjectMaterial(EntradaRoca[TexturizarID], 1, 9743, "rock_coastsfw", "pavetilealley256128"),SetObjectMaterial(EntradaRoca[TexturizarID], 2, 9743, "rock_coastsfw", "pavetilealley256128"), SetObjectMaterial(EntradaRoca[TexturizarID], 3, 9743, "rock_coastsfw", "pavetilealley256128");}
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetObjectMaterial(EntradaRoca[TexturizarID], 4, 9743, "rock_coastsfw", "pavetilealley256128"),SetObjectMaterial(EntradaRoca[TexturizarID], 5, 9743, "rock_coastsfw", "pavetilealley256128");}


//MUELLE DE ROCA-----------------------------------------------------------------------------------------
MuelleRoca[1] = CreateObject(9078, 3458.75269, -1947.31506, 5.19394,   0.00000, 0.00000, -175.19987, 300);
SetObjectMaterial(MuelleRoca[1], 0,9743, "rock_coastsfw", "cst_rock_coast_sfw", 0);
SetObjectMaterial(MuelleRoca[1], 1,9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(MuelleRoca[1], 2,9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(MuelleRoca[1], 3,9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(MuelleRoca[1], 4,9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(MuelleRoca[1], 5,9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(MuelleRoca[1], 6,9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(MuelleRoca[1], 7,9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(MuelleRoca[1], 8,9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(MuelleRoca[1], 9,9743, "rock_coastsfw", "pavetilealley256128", 0);


//PILAR 2DA ISLA---------------------------------------------------------------------------------------------------
Pilar[0] = CreateObject(8397, 3304.77612, -1998.61511, 27.32438,   0.00000, 0.00000, 0.00000, 300);
SetObjectMaterial(Pilar[0], 0, 11429, "des_nw", "des_yelrock");

//RAMPAS 2DA ISLA--------------------------------------------------------------------------------------------------
Rampa[0] = CreateDynamicObject(3069, 3353.95581, -2068.42407, 25.99905,   0.00000, 0.00000, 0.00000);
Rampa[1] = CreateDynamicObject(3069, 3347.91162, -2068.37842, 25.99905,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(Rampa[TexturizarID], 0, 9743, "rock_coastsfw", "pavetilealley256128");}


//ENTRENAMIENTO 2DA ISLA-------------------------------------------------------------------------------------------
Taller[1] = CreateObject(3624, 3380.46924, -1963.61060, 31.73626,   0.00000, 0.00001, 0.42000, 300);
SetObjectMaterial(Taller[1], 0, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 1, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 2, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 3, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 4, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 5, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 6, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 7, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 8, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 9, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 10, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 11, 9743, "rock_coastsfw", "pavetilealley256128", 0);
SetObjectMaterial(Taller[1], 12, 9743, "rock_coastsfw", "pavetilealley256128", 0);

//HANGAR 2DA ISLA--------------------------------------------------------------------------------------------------
Hangar[1] = CreateObject(3816, 3399.22583, -2092.66650, 34.58459,   -0.00001, 0.00000, -91.68005, 300);
SetObjectMaterial(Hangar[1], 0,9743, "griffobs_las", "adeta", 0);
SetObjectMaterial(Hangar[1], 1,9743, "griffobs_las", "adeta", 0);
SetObjectMaterial(Hangar[1], 2,9743, "griffobs_las", "adeta", 0);
SetObjectMaterial(Hangar[1], 3,9743, "griffobs_las", "adeta", 0);
SetObjectMaterial(Hangar[1], 4,9743, "griffobs_las", "adeta", 0);
SetObjectMaterial(Hangar[1], 5,9743, "griffobs_las", "adeta", 0);
SetObjectMaterial(Hangar[1], 6,9743, "griffobs_las", "adeta", 0);
SetObjectMaterial(Hangar[1], 7,9743, "griffobs_las", "adeta", 0);
SetObjectMaterial(Hangar[1], 8,9743, "griffobs_las", "adeta", 0);
SetObjectMaterial(Hangar[1], 10, 8463, "vgseland", "tiadbuddhagold", 0);

Hangar[2] = CreateObject(3816, 3396.98560, -2241.66040, 34.58459,   -0.00001, 0.00000, -91.68005, 300);
SetObjectMaterial(Hangar[2], 0,3267, "milbase", "sam_camo", 0);
SetObjectMaterial(Hangar[2], 1,3267, "milbase", "sam_camo", 0);
SetObjectMaterial(Hangar[2], 2,3267, "milbase", "sam_camo", 0);
SetObjectMaterial(Hangar[2], 3,3267, "milbase", "sam_camo", 0);
SetObjectMaterial(Hangar[2], 4,3267, "milbase", "sam_camo", 0);
SetObjectMaterial(Hangar[2], 5,3267, "milbase", "sam_camo", 0);
SetObjectMaterial(Hangar[2], 6,3267, "milbase", "sam_camo", 0);
SetObjectMaterial(Hangar[2], 7,3267, "milbase", "sam_camo", 0);
SetObjectMaterial(Hangar[2], 8,3267, "milbase", "sam_camo", 0);
SetObjectMaterial(Hangar[2], 10,3267, "milbase", "sam_camobits", 0);

PuertaHangar1 = CreateObject(16773, 3368.88721, -2233.52930, 29.78182,   0.00000, 0.00000, -91.68010, 300);/// mover a 3369.1797, -2222.2744, 29.7818
SetObjectMaterial(PuertaHangar1, 0,3267, "milbase", "sam_camobits", 0);

PuertaHangar2 = CreateObject(16773, 3368.49927, -2248.14087, 29.78182,   0.00000, 0.00000, -91.68010, 300);/// mover a 3368.0361, -2259.1587, 29.7818
SetObjectMaterial(PuertaHangar2, 0,3267, "milbase", "sam_camobits", 0);

PuertaHangar3 = CreateObject(16773, 3368.98730, -2233.52930, 32.82139,   0.00000, 0.00000, -91.68010, 300);/// mover a 3369.1987, -2222.2712, 32.8214
SetObjectMaterial(PuertaHangar3, 0,3267, "milbase", "sam_camobits", 0);

PuertaHangar4 = CreateObject(16773, 3368.55908, -2248.06714, 32.80074,   0.00000, 0.00000, -91.68010, 300);/// mover a 3368.0439, -2259.1931, 32.8007
SetObjectMaterial(PuertaHangar4, 0,3267, "milbase", "sam_camobits", 0);

Plataforma[0] = CreateObject(6300, 3400.81934, -2124.89404, 17.83593,   0.00000, 0.00001, -3.42000, 300);
Plataforma[1] = CreateObject(6300, 3403.61084, -2082.84058, 17.95788,   0.00000, 0.00000, -3.42000, 300);
Plataforma[2] = CreateObject(6300, 3403.59106, -2082.84253, 17.96672,   -0.02000, 0.00000, -180.42000, 300);
Plataforma[3] = CreateObject(6300, 3398.22021, -2166.38135, 17.82590,   0.00000, 0.00000, -3.42000, 300);
Plataforma[4] = CreateObject(6300, 3393.14502, -2247.18408, 17.75556,   0.00000, 0.00000, -3.42000, 300);
Plataforma[5] = CreateObject(6300, 3395.54565, -2206.57544, 17.81186,   0.00000, 0.00000, -3.42000, 300);
for(new TexturizarID; TexturizarID < 6; TexturizarID++){SetObjectMaterial(Plataforma[TexturizarID], 0, 9743, "rock_coastsfw", "pavetilealley256128"), SetObjectMaterial(Plataforma[TexturizarID], 1, 9743, "rock_coastsfw", "cst_rock_coast_sfw"),SetObjectMaterial(Plataforma[TexturizarID], 2, 9743, "rock_coastsfw", "cst_rock_coast_sfw"), SetObjectMaterial(Plataforma[TexturizarID], 3, 9743, "rock_coastsfw", "cst_rock_coast_sfw");}
for(new TexturizarID; TexturizarID < 6; TexturizarID++){SetObjectMaterial(Plataforma[TexturizarID], 4, 9743, "rock_coastsfw", "pavetilealley256128"), SetObjectMaterial(Plataforma[TexturizarID], 5, 9743, "rock_coastsfw", "cst_rock_coast_sfw");}

Aviones[0] = CreateObject(10766, 3340.05835, -2243.18384, 24.08543,   0.00000, -0.00001, 178.70006, 300);
Aviones[1] = CreateObject(10767, 3342.28711, -2119.41406, 11.43403,   0.00000, 0.00000, 44.00000, 300);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetObjectMaterial(Aviones[TexturizarID], 1,  8463, "vgseland", "tiadbuddhagold"), SetDynamicObjectMaterial(Aviones[TexturizarID], 2, 8463, "vgseland", "Grass_128HV");}

//CALLES-----------------------------------------------------------------------------------------------------------
CalleDeRoca[0] = CreateObject(6450, 2934.68750, -1974.73621, 2.04759,   0.00000, 0.00001, -90.24001, 300);
CalleDeRoca[1] = CreateObject(18802, 2945.2031, -1963.9050, 9.7674,  0.0000, 4.0000, 0.0000, 300);
CalleDeRoca[2] = CreateObject(18788, 2973.31909, -1963.89990, 10.72784,   0.00000, 0.00000, 0.00000, 300);
CalleDeRoca[3] = CreateObject(19788, 3000.92529, -2040.96570, 11.65340,   0.00000, 0.00000, 270.00000);
CalleDeRoca[4] = CreateObject(19533, 3039.64917, -2040.96814, 11.65340,   0.00000, 0.00000, 90.00000);
CalleDeRoca[5] = CreateObject(19788, 3000.79053, -1963.70508, 11.65340,   0.00000, 0.00000, 90.00000);
CalleDeRoca[6] = CreateObject(19533, 3000.84741, -2002.23950, 11.64819,   0.00000, 0.00000, 0.00000);
CalleDeRoca[7] = CreateObject(19534, 3078.39990, -2040.96924, 11.65340,   0.00000, 0.00000, 0.00000);
CalleDeRoca[8] = CreateObject(19534, 3078.37476, -2026.08008, 11.65340,   0.00000, 0.00000, 0.00000);
CalleDeRoca[9] = CreateObject(19534, 3093.40601, -2026.10828, 11.65340,   0.00000, 0.00000, 0.00000);
CalleDeRoca[10] = CreateObject(19534, 3093.30249, -2040.97217, 11.65340,   0.00000, 0.00000, 0.00000);
CalleDeRoca[11] = CreateObject(19534, 3063.43994, -2026.14771, 11.65340,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 12; TexturizarID++){SetObjectMaterial(CalleDeRoca[TexturizarID], 0,  12853, "cunte_gas01", "sw_floor1"), SetObjectMaterial(CalleDeRoca[TexturizarID], 2, 10368, "cathedral_sfs", "ws_floortiles4");}


//ESTACIONAMIENTOS--------------------------------------------------------------------------------------------------
Estacionamiento[0] = CreateObject(19905, 3021.61182, -2068.87988, 11.44472,   0.00000, -0.00001, -178.97995, 300);
Estacionamiento[1] = CreateObject(19905, 3065.02637, -2068.10059, 11.44471,   0.00000, -0.00001, -178.97995, 300);
Estacionamiento[2] = CreateObject(19905, 3109.73535, -2067.27124, 11.44471,   0.00000, -0.00001, -178.97995, 300);
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetObjectMaterial(Estacionamiento[TexturizarID], 0,  896, "underwater", "rocktb128"),SetObjectMaterial(Estacionamiento[TexturizarID], 1, 896, "underwater", "rocktb128"),SetObjectMaterial(Estacionamiento[TexturizarID], 2, 896, "underwater", "rocktb128"), SetObjectMaterial(Estacionamiento[TexturizarID], 3, 896, "underwater", "rocktb128");}
for(new TexturizarID; TexturizarID < 3; TexturizarID++){SetObjectMaterial(Estacionamiento[TexturizarID], 4, 896, "underwater", "rocktb128"),SetObjectMaterial(Estacionamiento[TexturizarID], 5, 896, "underwater", "rocktb128");}


//LUCES-------------------------------------------------------------------------------------------------------------
Luces[0] = CreateObject(3437, 2964.07300, -1993.89624, 16.04243,   0.00000, 0.00001, 0.00000, 300);
Luces[1] = CreateObject(3437, 2965.12280, -1955.54016, 16.36645,   0.00000, 0.00001, 0.00000, 300);
Luces[2] = CreateObject(3437, 2925.08301, -1974.42981, 15.83406,   0.00000, 0.00001, 0.00000, 300);
Luces[3] = CreateObject(3437, 2925.54224, -1955.99927, 15.83406,   0.00000, 0.00001, 0.00000, 300);
Luces[4] = CreateObject(3437, 2899.36963, -1955.96179, 15.83406,   0.00000, 0.00001, 0.00000, 300);
Luces[5] = CreateObject(3437, 2899.25024, -1974.25647, 15.83406,   0.00000, 0.00001, 0.00000, 300);
Luces[6] = CreateObject(3437, 2965.55957, -1973.28577, 16.36645,   0.00000, 0.00001, 0.00000, 300);
Luces[7] = CreateObject(3437 ,2872.2930, -1974.1215, 15.8341,   0.00000, 0.00000, 0.00000, 300);
Luces[8] = CreateObject(3437 ,2872.4609, -1955.4182, 15.8341,   0.00000, 0.00000, 0.00000, 300);
for(new TexturizarID; TexturizarID < 9; TexturizarID++){SetObjectMaterial(Luces[TexturizarID], 0, 8463, "vgseland", "tiadbuddhagold");}

//PASTO------------------------------------------------------------------------------------------------------------
PastoIsla[0] = CreateObject(11695, 3046.29028, -2007.23169, -20.90773,   0.00000, -0.00001, 177.83995, 300);
PastoIsla[1] = CreateObject(11695, 3327.92944, -1967.30103, -5.23478,   0.00000, 0.00001, -11.57959, 300);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetObjectMaterial(PastoIsla[TexturizarID], 0, 8463, "vgseland", "Grass_128HV");}

//CARTELES---------------------------------------------------------------------------------------------------------
Letrero[1] = CreateObject(19464, 2869.0371, -1964.8225, 33.6247,   0.00000, 0.00000, 0.00000);
SetObjectMaterialText(Letrero[1], "GP VIPS", 0, 130, "Colonna", 150 , 1, -16778888 , 0, 1);

ParteDeLetrero[1] = CreateObject(19464, 2869.91724, -1964.64539, 18.92434,   0.00000, 0.00000, 0.00000);
SetObjectMaterial(ParteDeLetrero[1], 0,9743, "griffobs_las", "adeta", 0);


Letrero[2] = CreateObject(19464, 2869.8540, -1964.6227, 18.9243,   0.00000, 0.00000, 0.00000);
SetObjectMaterialText(Letrero[2], "V I P S", 0, 130, "Algerian", 100, 1, -16778888 , 0, 1);

ParteDeLetrero[2] = CreateObject(19464, 2869.14233, -1964.82568, 33.62471,   0.00000, 0.00000, 0.00000);
SetObjectMaterial(ParteDeLetrero[2], 0,9743, "griffobs_las", "adeta", 0);


LetreroM[1] = CreateObject(19353, 3356.6113, -1895.1107, 48.2741,   0.00000, 0.00000, 78.42011);
SetObjectMaterialText(LetreroM[1], "MUELLE", 0, 40, "Algerian", 35, 1, -16778888 , 0, 1);

LetreroM[2] = CreateObject(19353, 3359.45605, -1895.69556, 48.27407,   0.00000, 0.00000, 78.42011);
SetObjectMaterialText(LetreroM[2], "VIP", 0, 40, "Algerian", 35, 1, -16778888 , 0, 1);
///REJAS----------------------------------------------------------------------------------------------------------
Reja1[0] = CreateDynamicObject(987, 2947.49707, -1972.81470, 9.93588,   0.00000, 0.00000, 270.00000);
Reja1[1] = CreateDynamicObject(987, 2947.51221, -1982.56531, 9.93588,   0.00000, 0.00000, 270.00000);
Reja1[2] = CreateDynamicObject(987, 2947.35229, -1994.29309, 10.09968,   0.00000, 0.00000, 0.00000);
Reja1[3] = CreateDynamicObject(987, 2959.08032, -1994.01440, 10.09968,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 4; TexturizarID++){SetDynamicObjectMaterial(Reja1[TexturizarID], 0, 8463, "vgseland", "tiadbuddhagold"), SetDynamicObjectMaterial(Reja1[TexturizarID], 3, 8463, "vgseland", "tiadbuddhagold");}

Reja[0] = CreateDynamicObject(19913, 2975.14722, -2018.72974, 13.84114,   0.00000, 0.00000, 100.00000);
Reja[1] = CreateDynamicObject(19913, 2979.53223, -2067.98877, 13.64725,   0.00000, 0.00000, 90.00000);
Reja[2] = CreateDynamicObject(19913, 3004.36011, -2088.15723, 13.64730,   0.00000, 0.00000, 0.00000);
Reja[3] = CreateDynamicObject(19913, 3054.26953, -2088.11743, 13.64730,   0.00000, 0.00000, 0.00000);
Reja[4] = CreateDynamicObject(19913, 3103.55786, -2088.20972, 13.64730,   0.00000, 0.00000, 0.00000);
Reja[5] = CreateDynamicObject(19913, 3128.34888, -2067.02417, 13.64730,   0.00000, 0.00000, 90.00000);
Reja[6] = CreateDynamicObject(19913, 3123.80566, -1986.08691, 13.64730,   0.00000, 0.00000, 70.00000);
Reja[7] = CreateDynamicObject(19913, 3131.85034, -1963.88843, 13.64730,   0.00000, 0.00000, 70.00000);
Reja[8] = CreateDynamicObject(19912, 3267.82910, -1858.16479, 12.91660,   0.00000, 0.00000, 90.00000);
Reja[9] = CreateDynamicObject(19913, 3069.58179, -1920.07471, 14.06283,   0.00000, 0.00000, 0.00000);
Reja[10] = CreateDynamicObject(19913, 3019.62598, -1920.07166, 14.06283,   0.00000, 0.00000, 0.00000);
Reja[11] = CreateDynamicObject(19913, 3084.51611, -1920.03442, 17.7020,   0.00000, 0.00000, 0.00000);
Reja[12] = CreateDynamicObject(19913, 2977.96826, -1938.28479, 14.06280,   0.00000, 0.00000, 47.00000);
Reja[13] = CreateDynamicObject(19913, 2935.91138, -1956.49207, 14.06283,   0.00000, 0.00000, 0.00000);
Reja[14] = CreateDynamicObject(19913, 2896.06079, -1956.40039, 14.06283,   0.00000, 0.00000, 0.00000);
Reja[15] = CreateDynamicObject(19913, 2895.80273, -1972.71338, 14.06283,   0.00000, 0.00000, 0.00000);
Reja[16] = CreateDynamicObject(19913, 2922.32935, -1972.70276, 14.06283,   0.00000, 0.00000, 0.00000);
for(new TexturizarID; TexturizarID < 17; TexturizarID++){SetDynamicObjectMaterial(Reja[TexturizarID], 0, 8463, "vgseland", "tiadbuddhagold");}

Reja2[0] = CreateDynamicObject(19912, 3139.97900, -2042.65088, 17.77033,   0.00000, -7.79000, 0.00000);
Reja2[1] = CreateDynamicObject(19912, 3126.43604, -2009.19543, 16.99391,   0.00000, -7.79000, 0.00000);
for(new TexturizarID; TexturizarID < 2; TexturizarID++){SetDynamicObjectMaterial(Reja2[TexturizarID], 0, 8463, "vgseland", "tiadbuddhagold"), SetDynamicObjectMaterial(Reja1[TexturizarID], 2, 8463, "vgseland", "tiadbuddhagold");}

PuertaMuelle = CreateDynamicObject(19458, 3386.87012, -1875.02673, 17.53830,   90.00000, 0.00000, -18.90000);
PuertaMuelle2 = CreateDynamicObject(3524, 3386.83765, -1874.94910, 14.34694,   0.00000, 0.00000, 76.32000);



Puente[1] = CreateDynamicObject(6189, 3170.14478, -2025.96033, 4.65875,   -7.78999, 0.00000, 89.99998);
SetDynamicObjectMaterial(Puente[1], 5, 5998, "sunstr_lawn", "sunneon02", 0);
SetDynamicObjectMaterial(Puente[1], 2, 18234, "cuntwbtxcs_t", "offwhitebrix", 0);

Puente[2] = CreateDynamicObject(6189, 3295.89819, -2026.03735, 4.49148,   7.79001, 0.00000, 89.99998);
SetDynamicObjectMaterial(Puente[2], 5, 5998, "sunstr_lawn", "sunneon02", 0);
SetDynamicObjectMaterial(Puente[2], 2, 18234, "cuntwbtxcs_t", "offwhitebrix", 0);




RejaAutomatica[0] = CreateDynamicObject(980, 2900.54395, -1964.95886, 12.85459,   0.00000, 0.00000, 90.00000);
SetDynamicObjectMaterial(RejaAutomatica[0], 2, 8463, "vgseland", "tiadbuddhagold",0);
//////////////////////////////////////////////////////////////////////AEROPUERTO ABANDONADO///////////////////////////////////////
CreateDynamicObject(4866, 252.23958, 2539.71411, 15.81356,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10305, 299.56924, 2603.33545, 0.51930,   0.00000, 0.00000, 269.88406);
CreateDynamicObject(4816, 337.35812, 2643.13354, 11.96799,   0.00000, 0.00000, 194.42664);
CreateDynamicObject(10301, 97.38898, 2616.80933, -2.65122,   0.00000, 0.00000, 270.40503);
CreateDynamicObject(4816, 205.44171, 2655.65283, 11.96799,   0.00000, 0.00000, 204.36066);
CreateDynamicObject(10301, 138.89311, 2653.05249, -2.84913,   0.00000, 0.00000, 271.15308);
CreateDynamicObject(16112, 230.64977, 2658.22290, 13.58743,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16112, 260.39395, 2658.24878, 13.58743,   0.00000, 0.00000, 189.14731);
CreateDynamicObject(8148, 419.09610, 2607.91162, 22.81451,   0.00000, 0.00000, 237.13684);
CreateDynamicObject(8148, 270.00406, 2657.36938, 25.37003,   0.00000, 0.00000, 266.18033);
CreateDynamicObject(8148, 108.54244, 2652.96191, 25.37003,   0.00000, 0.00000, 276.91650);
CreateDynamicObject(8148, 419.09610, 2607.91162, 29.85892,   0.00000, 0.00000, 237.13684);
CreateDynamicObject(8148, 270.00406, 2657.36938, 32.48062,   0.00000, 0.00000, 266.18033);
CreateDynamicObject(8148, 108.54244, 2652.96191, 32.49014,   0.00000, 0.00000, 276.91650);
CreateDynamicObject(4874, 154.43333, 2629.26880, 23.44596,   0.00000, 0.00000, 0.59526);
CreateDynamicObject(4874, 231.96786, 2630.03979, 23.44596,   0.00000, 0.00000, 0.59526);
CreateDynamicObject(4874, 309.69235, 2630.26831, 23.44596,   0.00000, 0.00000, 0.59526);
CreateDynamicObject(8038, 324.65482, 2588.03784, 31.34662,   0.00000, 0.00000, 350.32773);
CreateDynamicObject(3279, 253.32932, 2532.47729, 20.32781,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 253.27591, 2546.41235, 20.32781,   0.00000, 0.00000, 359.59393);
CreateDynamicObject(3279, 253.32365, 2563.00952, 20.32781,   0.00000, 0.00000, 359.59393);
CreateDynamicObject(3279, 253.49217, 2578.93994, 20.32781,   0.00000, 0.00000, 359.59393);
CreateDynamicObject(18848, 253.85605, 2532.38916, 35.88770,   0.00000, 0.00000, 216.05779);
CreateDynamicObject(18848, 253.48306, 2546.34082, 35.88770,   0.00000, 0.00000, 216.05779);
CreateDynamicObject(18848, 253.62524, 2563.17578, 35.88770,   0.00000, 0.00000, 216.05779);
CreateDynamicObject(18848, 253.66342, 2578.88818, 35.88770,   0.00000, 0.00000, 216.05779);
CreateDynamicObject(4832, 357.37363, 2609.91406, 34.46480,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1256, 310.46140, 2528.53979, 21.18091,   0.00000, 0.00000, 269.43039);
CreateDynamicObject(3877, 307.89038, 2528.43701, 21.93507,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3877, 313.49295, 2528.36255, 21.93507,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1256, 315.97830, 2528.45996, 21.18091,   0.00000, 0.00000, 269.43039);
CreateDynamicObject(3877, 318.48004, 2528.37842, 21.93507,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1256, 321.00732, 2528.44360, 21.18091,   0.00000, 0.00000, 269.43039);
CreateDynamicObject(3877, 323.64883, 2528.37134, 21.93507,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1256, 327.01065, 2528.41064, 21.18091,   0.00000, 0.00000, 269.43039);
CreateDynamicObject(3877, 330.25714, 2528.32642, 21.93507,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1683, 342.24405, 2406.62769, 21.63408,   0.00000, 0.00000, 42.94796);
CreateDynamicObject(16599, 289.12851, 2546.42773, 20.02344,   356.89331, 0.00000, 1.08911);
CreateDynamicObject(16599, 275.67795, 2546.07178, 20.02344,   356.89331, 0.00000, 1.08911);
CreateDynamicObject(16599, 282.32263, 2535.37451, 20.02344,   356.89331, 0.00000, 1.08911);
CreateDynamicObject(3491, 437.13571, 2518.88062, 23.40613,   0.00000, 0.00000, 269.88428);
CreateDynamicObject(14576, 435.76138, 2522.65015, 10.84756,   0.00000, 0.00000, 180.44536);
CreateDynamicObject(13603, 463.55627, 2563.11523, 8.52328,   0.00000, 0.00000, 0.51010);
CreateDynamicObject(3761, 438.98450, 2524.45630, 12.01827,   0.00000, 0.00000, 0.53819);
CreateDynamicObject(3761, 438.91730, 2531.43896, 12.01827,   0.00000, 0.00000, 0.44537);
CreateDynamicObject(1279, 438.89072, 2522.13306, 11.74276,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1279, 438.97211, 2525.09497, 11.64673,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1279, 438.95465, 2526.66870, 11.64559,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1279, 438.58044, 2533.49072, 11.74374,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1279, 438.81067, 2530.69751, 11.63997,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(931, 433.06036, 2523.70728, 11.07434,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(931, 433.03177, 2526.89648, 11.07434,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(931, 433.09814, 2530.69946, 11.07434,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(944, 428.99490, 2524.97949, 10.97945,   0.00000, 0.00000, 274.28162);
CreateDynamicObject(944, 428.80240, 2529.28271, 10.97945,   0.00000, 0.00000, 274.28162);
CreateDynamicObject(14556, 422.02100, 2526.38989, 4.11080,   0.00000, 0.00000, 270.79282);
CreateDynamicObject(14556, 422.06317, 2531.22461, 4.11080,   0.00000, 0.00000, 270.79282);
CreateDynamicObject(14556, 422.09564, 2520.89771, 4.11080,   0.00000, 0.00000, 270.79282);
CreateDynamicObject(2901, 432.99664, 2523.87964, 11.51499,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2901, 432.79269, 2524.23438, 10.49923,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2901, 433.05280, 2526.78711, 11.61907,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2901, 432.77661, 2526.81250, 10.55282,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2901, 433.32553, 2530.60010, 11.51477,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2901, 433.30191, 2530.69067, 10.45736,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2589, 448.03806, 2523.04834, 8.31871,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2589, 448.03806, 2523.04834, 8.31871,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2589, 442.15945, 2521.59375, 8.31871,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2589, 442.65399, 2526.38525, 8.21465,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2589, 447.22342, 2527.69556, 8.31871,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2589, 447.77390, 2531.43994, 8.31871,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2803, 421.50476, 2526.70239, 3.11965,   0.00000, 0.00000, 8.34863);
CreateDynamicObject(2803, 421.65295, 2531.50684, 3.11965,   0.00000, 0.00000, 8.34863);
CreateDynamicObject(2906, 421.65393, 2520.90381, 2.71636,   0.00000, 0.00000, 334.96567);
CreateDynamicObject(3007, 421.66080, 2521.34912, 2.70844,   0.00000, 0.00000, 329.11475);
CreateDynamicObject(3092, 421.82349, 2520.43140, 3.83392,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16782, 435.56396, 2499.06543, 5.38456,   0.00000, 0.00000, 90.28484);
CreateDynamicObject(2589, 444.46722, 2516.92114, 8.31871,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1536, 429.98083, 2538.38159, 10.34913,   0.00000, 0.00000, 90.74764);
CreateDynamicObject(1536, 429.98083, 2538.38159, 12.77827,   0.00000, 0.00000, 90.74764);
CreateDynamicObject(1523, 434.28622, 2535.28320, 2.45363,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1523, 436.86234, 2535.37085, 2.45363,   0.00000, 0.00000, 198.05145);
CreateDynamicObject(1523, 431.23404, 2537.36182, 15.26335,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16098, 292.07883, 2453.79395, 20.41894,   0.00000, 0.00000, 269.78979);
CreateDynamicObject(16098, 230.57542, 2453.44678, 20.41894,   0.00000, 0.00000, 269.78979);
CreateDynamicObject(7981, 373.07727, 2540.51831, 20.70420,   0.00000, 0.00000, 269.82855);
CreateDynamicObject(17953, 90.04063, 2616.77783, 31.40483,   0.00000, 0.00000, 234.51918);
CreateDynamicObject(17953, 85.10178, 2609.76782, 31.40483,   0.00000, 0.00000, 234.51918);
CreateDynamicObject(8148, 57.99102, 2475.90698, 18.22457,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10838, 58.14956, 2549.28247, 32.01016,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8038, 155.76407, 2462.97998, 35.31277,   0.00000, 0.00000, 270.19412);
CreateDynamicObject(8148, 138.76767, 2390.48901, 18.27829,   0.00000, 0.00000, 87.15257);
CreateDynamicObject(8148, 300.47452, 2384.77734, 18.27829,   0.00000, 0.00000, 88.82010);
CreateDynamicObject(17953, 418.53387, 2385.24927, 29.38772,   0.00000, 0.00000, 180.73489);
CreateDynamicObject(17953, 475.31104, 2431.77808, 32.07729,   0.00000, 0.00000, 264.17355);
CreateDynamicObject(987, 395.68417, 2382.44189, 23.19209,   0.00000, 0.00000, 3.56269);
CreateDynamicObject(987, 431.44324, 2383.64331, 25.42718,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, 473.66159, 2408.92700, 24.84570,   0.00000, 0.00000, 83.63185);
CreateDynamicObject(987, 478.28491, 2445.24341, 26.14603,   0.00000, 0.00000, 93.80875);
CreateDynamicObject(17953, 485.50476, 2530.19678, 42.30001,   0.00000, 4.00000, 264.00000);
CreateDynamicObject(987, 485.99280, 2507.88086, 29.52733,   0.00000, 0.00000, 89.74816);
CreateDynamicObject(987, 488.59189, 2543.36182, 38.50305,   0.00000, 0.00000, 89.74816);
CreateDynamicObject(3271, 159.55417, 2411.87329, 16.71234,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3271, 266.86398, 2414.53662, 16.09776,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3271, 212.15906, 2414.54297, 15.41933,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3461, 55.83362, 2566.09912, 16.59374,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8168, 55.89381, 2553.08740, 16.77966,   0.00000, 0.00000, 286.85764);
CreateDynamicObject(1237, 45.59403, 2557.75952, 15.35664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1237, 50.62088, 2557.69043, 15.46070,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1237, 40.66586, 2557.67651, 15.35664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1237, 36.56028, 2557.73828, 15.35664,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8841, 84.82055, 2434.31323, 18.83467,   0.00000, 0.00000, 359.66339);
CreateDynamicObject(3268, 218.85704, 2562.32813, 15.82999,   0.00000, 0.00000, 89.70324);
CreateDynamicObject(3268, 178.80611, 2561.72021, 15.82999,   0.00000, 0.00000, 89.70324);
CreateDynamicObject(17953, 439.04688, 2606.41113, 57.93062,   0.00000, 0.00000, 144.14081);
CreateDynamicObject(700, 148.32512, 2652.68042, 21.86151,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(700, 166.87506, 2653.78857, 21.86151,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(700, 185.66885, 2655.39160, 21.86151,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(700, 206.19316, 2656.21704, 21.86151,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(700, 319.83710, 2648.80811, 21.69688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(700, 338.56528, 2647.68091, 21.69688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(700, 363.65793, 2637.04004, 21.69688,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8041, 57.05282, 2557.42871, 21.30124,   0.00000, 0.00000, 179.10478);
CreateDynamicObject(2921, 433.39572, 2537.30347, 18.03011,   0.00000, 0.00000, 84.72000);

ParedAA[0] = CreateDynamicObject(19360, 434.35324, 2537.41992, 16.99075,   0.00000, 0.00000, 90.00000);
ParedAA[1] = CreateDynamicObject(19360, 435.90900, 2537.44971, 16.99075,   0.00000, 0.00000, 90.00000);
ParedAA[2] = CreateDynamicObject(19360, 437.47891, 2538.89624, 16.99070,   0.00000, 0.00000, 0.00000);
ParedAA[3] = CreateDynamicObject(19360, 437.46002, 2542.09399, 16.99070,   0.00000, 0.00000, 0.00000);
ParedAA[4] = CreateDynamicObject(19360, 437.45572, 2545.30151, 16.99070,   0.00000, 0.00000, 0.00000);
ParedAA[5] = CreateDynamicObject(19360, 434.33710, 2537.43164, 17.71552,   0.00000, 0.00000, 90.00000);
ParedAA[6] = CreateDynamicObject(19360, 435.92081, 2537.46582, 17.70954,   0.00000, 0.00000, 90.00000);
ParedAA[7] = CreateDynamicObject(19360, 437.47992, 2538.89600, 17.70076,   0.00000, 0.00000, 0.00000);
ParedAA[8] = CreateDynamicObject(19360, 437.46280, 2542.06763, 17.71060,   0.00000, 0.00000, 0.00000);
ParedAA[9] = CreateDynamicObject(19360, 437.46570, 2545.30151, 17.71770,   0.00000, 0.00000, 0.00000);
ParedAA[10] = CreateDynamicObject(19360, 434.34479, 2539.14966, 19.46110,   0.00000, 90.00000, 90.00000);
ParedAA[11] = CreateDynamicObject(19360, 435.93729, 2539.14722, 19.45110,   0.00000, 90.00000, 90.00000);
ParedAA[12] = CreateDynamicObject(19360, 435.94226, 2542.61646, 19.45110,   0.00000, 90.00000, 90.00000);
ParedAA[13] = CreateDynamicObject(19360, 435.94748, 2546.10132, 19.45110,   0.00000, 90.00000, 90.00000);
ParedAA[14] = CreateDynamicObject(19360, 432.71561, 2542.63184, 19.45110,   0.00000, 90.00000, 90.00000);
ParedAA[15] = CreateDynamicObject(19360, 432.75455, 2546.12793, 19.45110,   0.00000, 90.00000, 90.00000);
ParedAA[16] = CreateDynamicObject(19360, 431.16422, 2539.16382, 19.46110,   0.00000, 90.00000, 90.00000);
ParedAA[17] = CreateDynamicObject(19360, 431.15704, 2542.66650, 19.45110,   0.00000, 90.00000, 90.00000);
ParedAA[18] = CreateDynamicObject(19360, 431.16931, 2546.15674, 19.45110,   0.00000, 90.00000, 90.00000);
ParedAA[19] = CreateDynamicObject(19360, 429.65991, 2537.45093, 16.99075,   0.00000, 0.00000, 90.00000);
ParedAA[20] = CreateDynamicObject(19360, 429.84201, 2539.13867, 16.99070,   0.00000, 0.00000, 0.00000);
ParedAA[21] = CreateDynamicObject(19360, 429.85199, 2539.13867, 17.73330,   0.00000, 0.00000, 0.00000);
ParedAA[22] = CreateDynamicObject(19360, 429.65991, 2537.45093, 17.79965,   0.00000, 0.00000, 90.00000);
ParedAA[23] = CreateDynamicObject(19360, 429.78082, 2542.34033, 16.99070,   0.00000, 0.00000, 0.00000);
ParedAA[24] = CreateDynamicObject(19360, 429.84076, 2542.30029, 17.71070,   0.00000, 0.00000, 0.00000);
ParedAA[25] = CreateDynamicObject(19360, 429.77338, 2545.52661, 16.99070,   0.00000, 0.00000, 0.00000);
ParedAA[26] = CreateDynamicObject(19360, 429.79318, 2545.52930, 17.62438,   0.00000, 0.00000, 0.00000);
ParedAA[27] = CreateDynamicObject(19360, 432.02682, 2537.47729, 19.50883,   0.00000, 0.00000, 90.00000);
for(new TexturizarID; TexturizarID < 28; TexturizarID++){SetDynamicObjectMaterial(ParedAA[TexturizarID], 0, 16076, "des_quarrybits", "airportmetalwall256");}



///////////////////////////////////////////////////////////////////////BOLICHE/////////////////////////////////////////////////////////////////////
CreateDynamicObject(16151, 381.82419, -1843.13721, 7.17830,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(18783, 390.76505, -1861.79163, 5.81922,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(14820, 387.85413, -1856.45215, 9.22225,   0.00000, 0.00000, 40.00000);
CreateDynamicObject(2372, 398.42068, -1848.76416, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2290, 399.00784, -1848.03479, 6.82040,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1823, 383.46631, -1825.78149, 6.82123,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 404.65335, -1831.88794, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2350, 398.47672, -1826.87036, 7.13949,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19157, 383.91302, -1858.89197, 9.30850,   0.00000, 0.00000, -20.00000);
CreateDynamicObject(19446, 385.40021, -1814.27747, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 401.24530, -1814.29285, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 405.97400, -1819.02686, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1828.63879, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1838.25793, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1847.86560, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1857.47827, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1867.09912, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1867.09912, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1857.47827, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1847.86560, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1838.25793, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1828.63879, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 405.97400, -1819.01367, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 400.92169, -1871.83411, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 391.31351, -1871.83411, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 385.39981, -1871.82471, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 380.66840, -1867.09912, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 400.92169, -1871.83411, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 391.31351, -1871.83411, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 385.39981, -1871.82471, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 380.66840, -1867.09912, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 380.66840, -1857.47827, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 380.66840, -1847.86560, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 380.66840, -1838.25793, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 380.66840, -1828.63879, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 380.66840, -1819.01367, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 385.40021, -1814.27747, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 380.66840, -1819.01367, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 380.66840, -1828.63879, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 380.66840, -1838.25793, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 380.66840, -1847.86560, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 380.66840, -1857.47827, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 392.87790, -1814.27930, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2773, 384.51242, -1812.92871, 7.34180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 385.40021, -1822.28259, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1523, 390.13770, -1822.31250, 6.83090,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1523, 393.17661, -1822.25720, 6.83090,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(19446, 401.09369, -1822.28259, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19354, 394.67700, -1822.30139, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19384, 396.44031, -1820.63953, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 394.83231, -1814.29285, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19354, 396.42685, -1817.44373, 6.28254,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 401.22430, -1871.84509, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 401.22430, -1871.84509, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 401.24088, -1814.27332, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1533, 390.25549, -1814.23425, 6.83070,   0.00000, 0.00000, 160.00000);
CreateDynamicObject(1537, 393.19284, -1814.24268, 6.83120,   0.00000, 0.00000, 200.00000);
CreateDynamicObject(1649, 391.56653, -1814.29724, 10.98851,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1649, 391.56650, -1814.29724, 10.98850,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(1649, 391.58179, -1822.30115, 10.99947,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1649, 391.58179, -1822.30115, 10.99950,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3361, 401.71439, -1857.27588, 6.23720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18090, 401.25479, -1824.25745, 9.37970,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2350, 400.48090, -1826.88245, 7.13949,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2350, 402.56479, -1826.93115, 7.13949,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2350, 404.79025, -1826.90149, 7.13949,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2350, 395.65179, -1823.00513, 7.13949,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2350, 395.87360, -1824.53345, 7.13949,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 395.88708, -1847.41772, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 391.90149, -1847.41772, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 387.92529, -1847.41772, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 387.92529, -1843.44067, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 387.92529, -1839.44409, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 387.92529, -1835.45203, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 391.90149, -1843.44067, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 395.90207, -1843.45398, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 391.90149, -1839.44409, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 395.90210, -1839.44409, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 391.90149, -1835.45203, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19128, 395.90210, -1835.45203, 6.83010,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2372, 398.42068, -1846.52930, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2372, 398.42068, -1837.47791, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2372, 398.42068, -1835.20850, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 394.80875, -1809.22034, 7.34180,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2773, 388.36700, -1809.29810, 7.34180,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2773, 389.71191, -1807.92639, 7.34180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 385.95486, -1809.29810, 7.34180,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2773, 384.51239, -1810.59204, 7.34180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 389.71191, -1805.56848, 7.34180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 393.40701, -1807.92639, 7.34180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 393.42578, -1805.57788, 7.34180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 395.86066, -1813.08521, 7.34180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 397.18893, -1809.26038, 7.34180,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2773, 397.36392, -1811.90527, 7.34180,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2773, 401.93790, -1852.01184, 7.34180,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2001, 381.15427, -1822.72620, 6.82953,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 389.70862, -1821.86682, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 393.31219, -1821.89258, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 393.70483, -1814.71277, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 389.79843, -1814.71692, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06036, -1828.57349, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1829.26111, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1829.94312, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1830.62476, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1831.32910, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1832.00183, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1832.67505, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56616, -1834.86353, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1835.54761, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1836.24683, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1836.94763, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1837.63672, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1838.30835, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1838.96680, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1839.62512, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1840.25659, 6.88740,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2372, 398.42068, -1841.98206, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2372, 397.34949, -1832.93726, 6.82030,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2372, 395.11090, -1832.93726, 6.82030,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2372, 387.62680, -1832.93726, 6.82030,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2372, 385.84006, -1848.82117, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2372, 385.84009, -1846.49841, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2372, 385.84009, -1844.28210, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2372, 385.84009, -1835.11926, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2372, 385.84009, -1839.47791, 6.82030,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2290, 398.97861, -1836.76135, 6.82040,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2290, 396.59631, -1832.50769, 6.82040,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2290, 381.32443, -1836.41602, 6.82040,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2290, 381.30258, -1826.44275, 6.82040,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2290, 382.55194, -1822.93152, 6.82040,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2290, 385.66364, -1822.96216, 6.82040,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2290, 405.38303, -1842.63916, 6.82040,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2290, 405.37567, -1845.70313, 6.82040,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(1823, 386.12436, -1825.95667, 6.82120,   0.00000, 0.00000, 10.00000);
CreateDynamicObject(1823, 399.54651, -1841.82593, 6.82120,   0.00000, 0.00000, 95.00000);
CreateDynamicObject(1823, 404.72552, -1833.65430, 6.82120,   0.00000, 0.00000, 75.00000);
CreateDynamicObject(1823, 404.78625, -1830.29236, 6.82120,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1823, 386.64963, -1832.74414, 6.82120,   0.00000, 0.00000, 10.00000);
CreateDynamicObject(2125, 405.50128, -1833.39856, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 403.95389, -1834.27222, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 403.07678, -1832.81433, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 405.46970, -1829.76660, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 402.97086, -1829.79688, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 404.13809, -1830.94519, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 404.16757, -1828.45532, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 383.89557, -1826.59802, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 388.02792, -1825.03540, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 386.77496, -1826.66638, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 385.79999, -1832.24609, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 399.55356, -1842.68323, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 399.96808, -1840.76855, 7.13858,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 385.40021, -1822.28259, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 401.24530, -1822.28003, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 392.87790, -1822.28259, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 400.67441, -1867.01306, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 399.60571, -1862.27539, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1523, 405.94189, -1862.23767, 6.83390,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(1523, 394.82379, -1862.22681, 8.14540,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(19446, 388.49371, -1862.27539, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 385.53589, -1862.27759, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 399.60571, -1862.27539, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 401.09909, -1862.27734, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 388.49371, -1862.27539, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 385.53589, -1862.27759, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 403.78757, -1862.24524, 10.99950,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(1649, 403.78760, -1862.24524, 10.99950,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1649, 394.20630, -1862.25073, 12.31560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1649, 394.20630, -1862.25073, 12.31560,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2179, 389.79840, -1814.71692, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 393.70480, -1814.71277, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1828.57349, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1829.26111, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1829.94312, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1830.62476, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1831.32910, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1832.00183, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 381.06039, -1832.67505, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1834.86353, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1835.54761, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1836.24683, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1836.94763, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1837.63672, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1838.30835, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1838.96680, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1839.62512, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 405.56619, -1840.25659, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 405.57990, -1851.87366, 6.82953,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 403.51294, -1861.73096, 6.82953,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 389.70859, -1821.86682, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2179, 393.31219, -1821.89258, 11.19520,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 402.89465, -1853.40149, 7.34180,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 398.86621, -1841.32996, 7.31519,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 398.79239, -1841.03223, 7.31523,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 399.12732, -1841.31824, 7.31521,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 398.87741, -1840.86670, 7.31526,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 399.10727, -1841.18225, 7.31523,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 404.03488, -1833.25635, 7.31246,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 404.36252, -1833.27856, 7.31239,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 404.22318, -1833.23608, 7.31240,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 404.19138, -1833.35852, 7.31246,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 404.15503, -1832.68530, 7.31220,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 404.49020, -1832.64282, 7.31569,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 404.31683, -1832.90222, 7.31571,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 404.28333, -1829.71667, 7.31476,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 404.37155, -1829.83679, 7.31479,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 403.98563, -1830.16150, 7.31486,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 404.25534, -1830.00171, 7.31479,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 403.95392, -1829.57617, 7.31474,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 387.38248, -1831.81140, 7.31379,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 386.67374, -1832.55933, 7.31348,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 387.19882, -1831.79639, 7.31378,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 387.37891, -1832.12012, 7.31374,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 386.46326, -1825.31274, 7.31455,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 386.64551, -1825.50903, 7.31455,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 386.84735, -1825.20093, 7.31455,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 386.27994, -1825.47021, 7.31455,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 386.51736, -1825.71338, 7.31455,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 384.31845, -1825.56909, 7.31373,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 384.39987, -1825.44202, 7.31371,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 383.45660, -1825.30664, 7.31344,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 383.64453, -1825.50037, 7.31356,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 383.53369, -1825.61768, 7.31358,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 397.07410, -1827.56152, 6.87810,   0.00000, 90.00000, 10.00000);
CreateDynamicObject(1543, 396.69339, -1827.41516, 6.87810,   0.00000, 90.00000, 50.00000);
CreateDynamicObject(1543, 387.52228, -1826.12622, 6.87810,   0.00000, 90.00000, 50.00000);
CreateDynamicObject(1544, 403.37460, -1830.61804, 6.87810,   0.00000, 90.00000, 10.00000);
CreateDynamicObject(1543, 403.38928, -1831.15588, 6.87810,   0.00000, 90.00000, 60.00000);
CreateDynamicObject(1543, 398.58310, -1840.16516, 6.87810,   0.00000, 90.00000, 60.00000);
CreateDynamicObject(1544, 399.07309, -1840.23645, 6.87810,   0.00000, 90.00000, 180.00000);
CreateDynamicObject(1543, 399.01016, -1839.93848, 6.87810,   0.00000, 90.00000, 120.00000);
CreateDynamicObject(1545, 380.82300, -1841.60815, 8.23220,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1545, 399.46060, -1823.31665, 8.42810,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1545, 405.81271, -1824.18921, 8.42810,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2232, 382.13849, -1852.82959, 8.90170,   0.00000, 0.00000, 150.00000);
CreateDynamicObject(2232, 383.33426, -1853.15723, 8.90170,   0.00000, 0.00000, 170.00000);
CreateDynamicObject(1541, 380.81369, -1840.48059, 8.28340,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2425, 403.81433, -1825.57861, 7.85830,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2429, 403.42984, -1823.01318, 8.06975,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1541, 405.82709, -1823.18542, 8.35582,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2771, 399.79584, -1825.45056, 8.02622,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(14391, 392.04050, -1854.78845, 9.22435,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2232, 394.59070, -1853.55579, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 393.88031, -1853.55579, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 393.17651, -1853.55579, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 392.47379, -1853.55579, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 391.75821, -1853.55579, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 391.05261, -1853.55579, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 390.35229, -1853.55591, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 389.66690, -1853.55579, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 398.45050, -1853.08057, 8.90170,   0.00000, 0.00000, 190.00000);
CreateDynamicObject(2232, 399.68793, -1852.52747, 8.90170,   0.00000, 0.00000, 220.00000);
CreateDynamicObject(2232, 382.45377, -1861.14941, 8.90170,   0.00000, 0.00000, 150.00000);
CreateDynamicObject(2232, 384.43585, -1861.51465, 8.90170,   0.00000, 0.00000, 170.00000);
CreateDynamicObject(2232, 381.41791, -1859.04297, 8.90170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2232, 381.78122, -1856.81873, 8.90170,   0.00000, 0.00000, 70.00000);
CreateDynamicObject(2725, 394.11926, -1822.93005, 7.22334,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2725, 405.20197, -1849.61072, 7.22334,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2725, 382.15860, -1837.71399, 7.22334,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2725, 398.60297, -1832.87366, 7.22334,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2670, 403.68494, -1860.01697, 6.93170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2670, 400.12006, -1842.96375, 6.93170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2670, 405.01358, -1831.42432, 6.93170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2670, 396.67908, -1827.56335, 6.93170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2670, 385.41531, -1826.65869, 6.93170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2670, 381.73166, -1848.34485, 6.93170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2671, 387.76764, -1831.31628, 6.84280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2673, 382.73779, -1824.22449, 6.92650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2673, 399.34653, -1833.48389, 6.92650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2673, 403.04013, -1827.13708, 6.92650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2673, 404.89664, -1841.38635, 6.92650,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2673, 397.85266, -1850.45410, 6.92650,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2673, 381.94421, -1833.87195, 6.92650,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2232, 397.92764, -1861.64722, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 396.98727, -1861.60449, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 391.35489, -1861.71814, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 390.47443, -1861.65198, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 389.51410, -1861.70715, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 388.56329, -1861.59753, 8.90170,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2671, 382.44525, -1855.18274, 8.32290,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 383.03033, -1844.66724, 7.80404,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 382.65295, -1843.11450, 7.80404,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 382.93411, -1844.86597, 7.80404,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 382.99683, -1841.23596, 7.80404,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 382.36212, -1840.05737, 7.80404,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 382.63724, -1842.80481, 7.80404,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 382.41080, -1846.25171, 7.80404,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 382.77753, -1841.74695, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 381.42700, -1846.39612, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 381.17719, -1846.63342, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 382.47058, -1846.47510, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 382.58255, -1846.10901, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 382.95148, -1844.46985, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 382.77570, -1844.59644, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 382.82715, -1842.92627, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 382.90656, -1841.35352, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 382.68774, -1840.28809, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 382.51727, -1839.94604, 7.80388,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 398.41534, -1825.80286, 7.85813,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 397.35764, -1823.18567, 7.85813,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 402.70020, -1825.61084, 7.85813,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 402.99622, -1825.47534, 7.85813,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 400.75323, -1825.78113, 7.85813,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1544, 405.25693, -1825.63403, 7.85813,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 397.26456, -1824.57971, 7.85695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 398.04996, -1825.51379, 7.85695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 397.14105, -1824.92615, 7.85695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 400.47479, -1825.70911, 7.85695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 400.95117, -1825.47778, 7.85695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 405.59689, -1825.51477, 7.85695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 397.90317, -1825.39075, 7.85695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 397.33044, -1823.53333, 7.85695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1543, 397.10638, -1823.13916, 7.85695,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19446, 400.67441, -1867.01306, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18102, 396.35437, -1855.41675, 13.51650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18102, 394.06494, -1837.07715, 13.51650,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19354, 396.43271, -1815.98230, 6.28250,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 396.43271, -1815.98230, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 396.42679, -1817.44373, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 396.44031, -1820.63953, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19384, 387.91559, -1820.64844, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 387.91559, -1817.45886, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 387.90939, -1815.92773, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 387.90939, -1815.92773, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 387.91559, -1817.45886, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(0, 387.91559, -1820.64844, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1523, 387.96841, -1821.39246, 6.83090,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1523, 396.45859, -1821.39124, 6.83090,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2290, 381.28690, -1869.48535, 8.31500,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2290, 381.28690, -1866.40540, 8.31500,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2290, 383.15784, -1862.84583, 8.31500,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2290, 384.95929, -1871.22400, 8.31500,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(1823, 384.42056, -1868.90198, 8.31560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1823, 384.39566, -1866.14075, 8.31560,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2001, 381.32315, -1863.07581, 8.31644,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 381.35080, -1871.31335, 8.31643,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2592, 389.57175, -1871.46692, 9.19230,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2371, 400.18399, -1821.66626, 6.82950,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2394, 405.46851, -1815.34131, 7.70680,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 405.48251, -1817.19409, 7.70680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 404.07901, -1815.29810, 7.70680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 402.59091, -1815.27637, 7.70680,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 404.09195, -1817.15369, 7.70680,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 402.59189, -1817.16833, 7.70680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 405.44147, -1821.16589, 7.70680,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 404.00061, -1821.30347, 7.70680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 402.53775, -1821.25903, 7.70680,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 401.14551, -1821.26868, 7.70680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 401.02216, -1815.28650, 7.70680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 401.04648, -1817.16711, 7.72634,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2371, 400.26746, -1816.12378, 6.82950,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 400.10001, -1815.90735, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2394, 405.48251, -1817.19409, 8.99802,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 405.46851, -1815.34131, 8.99800,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 404.09189, -1817.15369, 8.99800,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 404.07901, -1815.29810, 8.99800,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 402.59091, -1815.27637, 8.99800,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 402.59189, -1817.16833, 8.99800,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 401.02219, -1815.28650, 8.99800,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 401.04651, -1817.16711, 8.99800,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 405.44150, -1821.16589, 8.99800,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 404.00061, -1821.30347, 8.99800,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2394, 402.53781, -1821.25903, 8.99800,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2394, 401.14551, -1821.26868, 8.99800,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19354, 400.15579, -1817.44373, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 400.15579, -1820.63953, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2671, 384.63782, -1870.32068, 8.32290,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19151, 3405.84497, -1845.66870, 12.71090,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2232, 399.68793, -1852.52747, 10.06676,   0.00000, 0.00000, 220.00000);
CreateDynamicObject(2232, 398.45050, -1853.08057, 10.06680,   0.00000, 0.00000, 190.00000);
CreateDynamicObject(2232, 382.13849, -1852.82959, 10.06680,   0.00000, 0.00000, 150.00000);
CreateDynamicObject(2232, 383.33429, -1853.15723, 10.06680,   0.00000, 0.00000, 170.00000);
CreateDynamicObject(2232, 397.92761, -1861.64722, 10.06680,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 396.98730, -1861.60449, 10.06680,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 391.35489, -1861.71814, 10.06680,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 390.47440, -1861.65198, 10.06680,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 389.51410, -1861.70715, 10.06680,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 388.56329, -1861.59753, 10.06680,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 397.14771, -1855.20679, 8.57400,   0.00000, 90.00000, 180.00000);
CreateDynamicObject(2232, 398.33231, -1855.20642, 8.56119,   0.00000, -90.00000, 180.00000);
CreateDynamicObject(2232, 398.32999, -1855.20642, 9.08820,   0.00000, -90.00000, 180.00000);
CreateDynamicObject(2232, 397.14771, -1855.20679, 9.10515,   0.00000, 90.00000, 180.00000);
CreateDynamicObject(1826, 387.35464, -1856.77783, 8.30370,   0.00000, 0.00000, 40.00000);
CreateDynamicObject(19378, 400.70129, -1867.09912, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19377, 390.20630, -1867.09912, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 385.95279, -1867.09912, 6.75000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 400.70129, -1857.47827, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 390.20630, -1857.47827, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(0, 385.95239, -1857.47827, 6.75000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 400.70129, -1847.86560, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 390.20630, -1847.86560, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 385.95239, -1847.86560, 6.75000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 400.70129, -1838.25793, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 390.20630, -1838.25793, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 385.95239, -1838.25793, 6.75000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 400.70129, -1828.63879, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 390.20630, -1828.63879, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 385.95239, -1828.63879, 6.75000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 400.70129, -1819.02686, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 390.20630, -1819.02686, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 385.95239, -1819.02686, 6.75000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19378, 390.20630, -1867.09912, 6.75500,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19129, 390.58850, -1851.95715, -1.69190,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19129, 400.53961, -1861.91052, -1.69190,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1867.12305, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1867.12305, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1857.49036, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1857.49036, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1847.86560, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1847.86560, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1838.25793, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1838.25793, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1828.63879, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1828.63879, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 405.99799, -1819.01367, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 405.98599, -1819.02686, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 401.22430, -1871.85706, 12.06630,   0.00000, 180.00000, 90.00000);
CreateDynamicObject(19447, 401.22430, -1871.85706, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, 391.31351, -1871.84607, 12.06630,   0.00000, 180.00000, 90.00000);
CreateDynamicObject(19447, 391.31351, -1871.84607, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, 385.39981, -1871.83667, 12.06630,   0.00000, 180.00000, 90.00000);
CreateDynamicObject(19447, 385.39981, -1871.83667, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, 400.92169, -1871.84607, 12.06630,   0.00000, 180.00000, 90.00000);
CreateDynamicObject(19447, 400.92169, -1871.84607, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, 401.24091, -1814.26135, 12.06630,   0.00000, 180.00000, 90.00000);
CreateDynamicObject(19447, 401.24530, -1814.28076, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19355, 394.83231, -1814.28076, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19447, 392.90549, -1814.26099, 12.06630,   0.00000, 180.00000, 90.00000);
CreateDynamicObject(19447, 385.40021, -1814.26550, 12.06630,   0.00000, 180.00000, 90.00000);
CreateDynamicObject(19447, 385.40021, -1814.26550, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19446, 380.68039, -1819.00171, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1819.00171, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1819.00171, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1828.63879, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1828.63879, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1838.25793, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1838.25793, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1847.86560, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1847.86560, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1857.47827, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1857.47827, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1867.09912, 12.06630,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19447, 380.65640, -1867.09912, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3034, 380.55911, -1858.64099, 8.75080,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3034, 380.55911, -1839.85266, 8.75080,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3034, 380.55911, -1823.67102, 8.75080,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3034, 388.04910, -1871.93994, 8.75080,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3034, 399.67410, -1871.95203, 8.75080,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3034, 400.38260, -1814.18945, 8.75080,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3034, 384.74231, -1814.17004, 8.75080,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3034, 406.08871, -1842.53833, 8.75080,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3034, 406.08871, -1859.21851, 8.75080,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3034, 406.08871, -1825.40820, 8.75080,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19377, 385.39981, -1866.66943, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 401.22430, -1866.66943, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 401.22430, -1856.18909, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 401.22430, -1845.68750, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 401.22430, -1835.21265, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 401.22430, -1824.72351, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 401.22430, -1819.44165, 13.89500,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 385.39981, -1856.18909, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 385.39981, -1845.68750, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 385.39981, -1835.21265, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 385.39981, -1824.72351, 13.89240,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 385.39981, -1819.44165, 13.89500,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 393.65140, -1819.45276, 13.90440,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 393.65140, -1866.64978, 13.90440,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 393.65140, -1856.15710, 13.90440,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(19377, 393.65140, -1829.93530, 13.90440,   0.00000, 90.00000, 90.00000);
CreateDynamicObject(1649, 391.63739, -1848.70117, 13.92920,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 394.94931, -1848.70117, 13.92920,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 391.63739, -1844.30481, 13.92920,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 391.63739, -1839.89294, 13.92920,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 391.63739, -1835.46277, 13.92920,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 394.94931, -1844.30481, 13.92920,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 394.94931, -1839.89294, 13.92920,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 394.94931, -1835.46277, 13.92920,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 391.63739, -1835.46277, 13.92920,   -90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 394.94931, -1835.46277, 13.92920,   -90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 391.63739, -1839.89294, 13.92920,   -90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 394.94931, -1839.89294, 13.92920,   -90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 391.63739, -1844.30481, 13.92920,   -90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 394.94931, -1844.30481, 13.92920,   -90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 391.63739, -1848.70117, 13.92920,   -90.00000, 0.00000, 90.00000);
CreateDynamicObject(1649, 394.94931, -1848.70117, 13.92920,   -90.00000, 0.00000, 90.00000);
CreateDynamicObject(2075, 391.27838, -1816.21350, 13.57360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2075, 391.27841, -1818.34241, 13.57360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2075, 391.27841, -1820.54321, 13.57360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2075, 398.20105, -1819.67297, 13.57360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2075, 398.20099, -1816.95374, 13.57360,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1935, 387.90359, -1817.45886, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19389, 387.90359, -1820.64844, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 387.90359, -1817.45886, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 387.89740, -1815.92773, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19354, 387.90939, -1815.92773, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 386.32272, -1814.31702, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 382.36511, -1814.31702, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 384.78195, -1814.31665, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 382.18286, -1822.26392, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 386.30417, -1822.27930, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 384.24625, -1822.27454, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 386.21109, -1815.82019, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1523, 386.27621, -1817.39099, 6.83090,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1523, 384.59891, -1817.39099, 6.83090,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1523, 382.92529, -1817.39099, 6.83090,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1523, 381.25159, -1817.39099, 6.83090,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 384.53281, -1815.82019, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 382.85730, -1815.82019, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 381.17880, -1815.82019, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 381.17880, -1820.67358, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 381.17691, -1818.18152, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 387.89740, -1815.92773, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 387.90359, -1820.64844, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 387.90359, -1817.45886, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 386.30420, -1822.27930, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 384.24619, -1822.27454, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 382.19211, -1822.28162, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 381.17880, -1820.67358, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 381.17691, -1818.18152, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 381.17880, -1815.82019, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 382.36511, -1814.31702, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 384.78201, -1814.31665, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 386.32269, -1814.31702, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2738, 385.40869, -1814.86682, 7.44350,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2738, 383.70331, -1814.86682, 7.44350,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2738, 382.07629, -1814.86682, 7.44350,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2738, 387.07040, -1814.86682, 7.44350,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18761, 390.84290, -1854.30640, 8.82397,   0.00000, 180.00000, 0.00000);
CreateDynamicObject(19421, 387.11880, -1856.92395, 9.29920,   0.00000, -10.00000, 0.00000);
CreateDynamicObject(19424, 394.43011, -1854.68677, 9.44370,   0.00000, 0.00000, 20.00000);
CreateDynamicObject(19423, 391.82336, -1854.82117, 9.44430,   0.00000, 0.00000, -10.00000);
CreateDynamicObject(2524, 382.66800, -1821.70911, 6.84200,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2524, 384.15350, -1821.70911, 6.84200,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2524, 385.73041, -1821.70911, 6.84200,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(14680, 386.56357, -1820.86414, 12.15079,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 402.81839, -1862.28223, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 402.30020, -1862.29761, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 402.30020, -1863.93262, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1523, 403.84131, -1863.89685, 6.83390,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1523, 403.84131, -1865.56226, 6.83390,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1523, 403.84131, -1867.21606, 6.83390,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 402.30020, -1865.62793, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 402.30020, -1867.28662, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1523, 403.84131, -1868.88452, 6.83390,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1523, 403.84131, -1870.55176, 6.83390,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 402.30020, -1868.94080, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 404.29074, -1870.61877, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 402.21909, -1870.62439, 8.58170,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 400.69220, -1863.96313, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 400.70749, -1867.25134, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 400.68002, -1870.20020, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 405.96320, -1863.85205, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 405.96320, -1867.03430, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 405.96320, -1870.18909, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 400.69220, -1863.96313, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 400.70749, 12.06630, 8.58170,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 400.70749, -1867.15527, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 402.21909, -1870.62439, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 404.29071, -1870.61877, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 400.67999, -1870.20020, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 405.96320, -1870.18909, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 405.96320, -1867.03430, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 405.96320, -1863.85205, 12.06630,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19359, 402.30020, -1862.29761, 12.06630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(19359, 404.29160, -1862.28223, 12.05440,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2738, 401.23141, -1869.77820, 7.42250,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2738, 401.23141, -1868.12732, 7.42250,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2738, 401.23141, -1866.41260, 7.42250,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2738, 401.23141, -1864.75122, 7.42250,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2738, 401.23141, -1863.09399, 7.42250,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2524, 405.37851, -1868.58972, 6.84280,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2524, 405.37851, -1867.05530, 6.84280,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2524, 405.37851, -1865.02917, 6.84280,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(18102, 396.03671, -1831.46436, 13.51650,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 392.09320, -1860.95093, 8.82551,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2773, 393.37320, -1859.54504, 8.82550,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2773, 395.74060, -1859.54333, 8.82550,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2670, 405.19128, -1869.54871, 6.93810,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2671, 403.44452, -1863.74243, 6.85520,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2671, 383.01465, -1820.65137, 6.83810,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2673, 386.90073, -1818.63098, 6.93880,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2673, 407.94290, -1802.90076, 6.90960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2671, 394.42026, -1804.14270, 6.83960,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2670, 401.41806, -1813.47729, 6.92580,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2670, 379.82358, -1810.11047, 6.91520,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2673, 381.19266, -1797.92273, 6.91440,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1687, 386.94299, -1866.51868, 14.77651,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1687, 386.89560, -1862.97437, 14.77651,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1687, 392.59668, -1866.39392, 14.77651,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1687, 392.60291, -1862.97754, 14.77651,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1687, 400.47113, -1817.97437, 14.77651,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1687, 400.50107, -1820.64502, 14.77651,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2186, 398.12048, -1862.87805, 8.31577,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1663, 397.33566, -1863.95886, 8.76633,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 379.91382, -1802.92505, 10.90643,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3439, 409.06174, -1807.71155, 10.89409,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2606, 400.35590, -1865.41492, 10.74350,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(1808, 400.35373, -1869.67859, 8.31520,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(1670, 383.97809, -1865.63159, 8.84510,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2230, 392.40308, -1871.62000, 8.31580,   0.00000, 0.00000, 170.00000);
CreateDynamicObject(2225, 393.56516, -1871.78198, 8.31570,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2232, 389.94989, -1862.81287, 8.88086,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1520, 384.03421, -1868.71167, 8.87223,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1520, 383.78098, -1868.57849, 8.87223,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1340, 418.27771, -1788.40100, 5.79910,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(1341, 418.45099, -1795.97290, 5.61460,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(1342, 418.23874, -1792.33301, 5.75400,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(1820, 391.06204, -1865.51624, 8.31626,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2816, 391.48819, -1865.07190, 8.81901,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2368, 389.78043, -1815.85632, 6.84150,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2357, 397.18549, -1867.13770, 8.71272,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2894, 397.13019, -1868.94592, 9.12646,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1742, 398.94342, -1871.81665, 8.31560,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2615, 391.34503, -1862.41760, 9.94155,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2163, 386.45044, -1862.28369, 9.40036,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 400.23474, -1871.33325, 8.31643,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 400.10800, -1862.92273, 8.31643,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 395.33926, -1862.77844, 8.31643,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 392.78897, -1862.72083, 8.31643,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2232, 388.64133, -1862.80457, 8.88090,   0.00000, 0.00000, -10.00000);
CreateDynamicObject(2230, 394.48801, -1871.77759, 8.31580,   0.00000, 0.00000, 190.00000);
CreateDynamicObject(1663, 397.21729, -1870.38586, 8.75430,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(2606, 400.35590, -1867.43604, 10.74350,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2606, 400.35590, -1867.43604, 10.28070,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2606, 400.35590, -1865.41492, 10.28070,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2894, 397.36475, -1866.22278, 9.12650,   0.00000, 0.00000, 80.00000);
CreateDynamicObject(1663, 398.92090, -1865.64172, 8.76630,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(1663, 395.72055, -1865.66345, 8.76630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1663, 395.58163, -1867.12219, 8.76630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1663, 395.61221, -1868.50635, 8.76630,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1663, 398.91843, -1868.54968, 8.76630,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(1663, 399.00500, -1867.06519, 8.76630,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(2125, 391.66321, -1863.51367, 8.62300,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 390.06525, -1864.93628, 8.62300,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 392.65948, -1865.03723, 8.62300,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2125, 391.05182, -1866.28064, 8.62300,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2771, 389.73721, -1815.81946, 8.08550,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2001, 388.52960, -1814.85522, 6.84253,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 395.93384, -1821.85522, 6.84167,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 388.42215, -1821.79651, 6.84167,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2001, 396.08029, -1814.71741, 6.84167,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16780, 386.30759, -1867.04883, 13.78620,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16780, 393.72107, -1867.01721, 13.78620,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1520, 405.27277, -1849.54504, 7.70840,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1520, 405.12540, -1849.40808, 7.70840,   0.00000, 0.00000, 0.00000);

print("\n[FILTERSCRIPT] generalmap loaded");

return 1;
}

public OnPlayerSpawn(playerid)
{
	if(InHouse[playerid] == true)
	{
	ResetPos(playerid);
	InHouse[playerid] = false;
	SetPlayerTeam(playerid, GetPlayerTeam(playerid));
	}
	if(First_Spawn[playerid] == true)
	{
	//timer_vcoords[playerid] = SetTimerEx("VerificarCoords",1000,true,"i", playerid);
	First_Spawn[playerid] = false;
	}
	SetPlayerMapIcon(playerid, 7, 1765.1345,-1910.8057,13.5699, 58, 0 );//EquipoEquipoAztecaas
	SetPlayerMapIcon(playerid, 8, 2221.2820, -1173.9700, 25.7266, 58, 0 );//EquipoBallas
	SetPlayerMapIcon(playerid, 9, 2810.3608, -1177.2137, 25.3201, 58, 0 );//EquipoVagos
 	SetPlayerMapIcon(playerid, 10, 2495.2053, -1687.1837, 13.5149, 58, 0 );//EquipoGroove
	SetPlayerMapIcon(playerid, 11, 2119.3276, -1963.8212, 14.0469, 58, 0);//vagabundos
//-----------------------icono de casa guía------------------------------
	SetPlayerMapIcon( playerid, 57,1833.8469, -1682.7408, 13.4562, 17, 0);
//---TIENDAS---------
	SetPlayerMapIcon( playerid, 58,2285.7854,-1681.1276,14.1323, 23, 0);
	SetPlayerMapIcon( playerid, 59,1875.1498,-1883.6227,13.4598, 23, 0);
	SetPlayerMapIcon( playerid, 60,2033.0740,-1402.9579,17.2843, 23, 0);
	SetPlayerMapIcon( playerid, 61,1257.1116,-1237.0879,18.1491, 23, 0);
	SetPlayerMapIcon( playerid, 62,3249.6118, -1904.9523, 28.2086, 23, 0);
//---base vip---------
	SetPlayerMapIcon(playerid, 63, 2866.3958,-1965.1401, 11.1094, 25, 0, MAPICON_GLOBAL);
//---Conscenioanria---
	SetPlayerMapIcon(playerid, 64, SALESMAN_ACT, 55, 0, MAPICON_GLOBAL);
//---Importadora------
	SetPlayerMapIcon(playerid, 65, -1688.9515, 13.0076, 3.5547, 11, -1, 0);
//Icono donde se compran clanes
	SetPlayerMapIcon(playerid, 68, 461.7018, -1500.7772, 31.0455, 12, -1, 0);
	return 1;
 }
public OnFilterScriptExit()
{
	//destroy all vehicles when this filterscript is out!
	for(new i; i < MAX_VEHICLES; i++)
    {
	    if(IsValidVehicle(i))
     	{
			DestroyVehicle(i);
	    }
	}
 return 1;
}

public OnPlayerConnect(playerid)
{
First_Spawn[playerid] = true;
return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
KillTimer(cerrar2(playerid));
KillTimer(BaseGrove(playerid));
KillTimer(BaseGrove1(playerid));
KillTimer(BaseBalla(playerid));
KillTimer(BaseVago(playerid));
KillTimer(BaseAztecas(playerid));
KillTimer(BaseBK1(playerid));
KillTimer(BaseBK2(playerid));
KillTimer(BaseDN1(playerid));
KillTimer(BaseDN2(playerid));
KillTimer(BaseVG1(playerid));
KillTimer(BaseVG2(playerid));
KillTimer(BaseVG3(playerid));
KillTimer(BasePolicia(playerid));
KillTimer(BaseCIA1(playerid));
KillTimer(BaseCIA2(playerid));
KillTimer(BaseM1(playerid));
KillTimer(BaseM2(playerid));
KillTimer(MafiaRusa(playerid));
KillTimer(BaseT1(playerid));
KillTimer(BaseT2(playerid));
KillTimer(BaseF1(playerid));
KillTimer(BaseF2(playerid));
KillTimer(BaseS1(playerid));
KillTimer(BaseS2(playerid));
KillTimer(BaseS3(playerid));

return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_CROUCH || newkeys == KEY_CTRL_BACK)
    {//Team: Groove street.
       if(GetPlayerTeam(playerid) == 0 || CheckPlayerAdmin(playerid) > 1)
       {
         if(IsPlayerInRangeOfPoint(playerid, 15, 2424.18970, -1652.25110, 15.21864))
         {
               if(dooropened[playerid] == true) return 0;
               MoveDynamicObject(PuertaGrove[0], 2424.18970, -1652.25110, 9.29920, 3, 0.00000, 0.00000, 90.00000);
               SetTimerEx("BaseGrove", 7000, 0, "d", playerid);
               dooropened[playerid] = true;
               SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
         }
	   }//team Groove street.
	   if(GetPlayerTeam(playerid) == 0 || CheckPlayerAdmin(playerid) > 1)
       {
          if(IsPlayerInRangeOfPoint(playerid, 15, 2480.72217, -1722.04016, 14.83893))
          {
	            if(dooropened[playerid] == true) return 0;
	            MoveDynamicObject(PuertaGrove[1], 2495.81934, -1721.88196, 15.18232, 3,  0.00000, 0.00000, 0.00000);
	            SetTimerEx("BaseGrove1", 7000, 0, "d", playerid);
	            dooropened[playerid] = true;
                SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
             }
          }//Team: Ballas
       if(GetPlayerTeam(playerid) == 1 || CheckPlayerAdmin(playerid) > 1)
       {
          if(IsPlayerInRangeOfPoint(playerid, 25, 2220.21582, -1143.58496, 26.32172))
          {
          if(dooropened[playerid] == true) return 0;
          MoveDynamicObject(PuertaBalla, 2225.61914, -1145.27698, 21.70730, 3, 0.00000, 0.00000, -17.40000);
          SetTimerEx("BaseBalla", 7000, 0, "d", playerid);
          dooropened[playerid] = true;
          SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
          }
       }//Team: Vagos
       if(GetPlayerTeam(playerid) == 3 || CheckPlayerAdmin(playerid) > 1)
       {
          if(IsPlayerInRangeOfPoint(playerid, 25, 2835.22852, -1183.39453, 24.08125))
          {
          if(dooropened[playerid] == true) return 0;
          MoveDynamicObject(PuertaRejaV[0], 2835.83350, -1189.11377, 19.85760, 3, 0.00000, 0.00000, -85.91997);
          SetTimerEx("BaseVago", 7000, 0, "d", playerid);
          dooropened[playerid] = true;
          SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
          }
	   }//team aztecas
	   if(GetPlayerTeam(playerid) == 2 || CheckPlayerAdmin(playerid) > 1)
       {
          if(IsPlayerInRangeOfPoint(playerid, 25, 1811.63892, -1888.91431, 13.23624))
          {
          if(dooropened[playerid] == true) return 0;
          MoveDynamicObject(PuertaAzteca[0], 1811.75439, -1883.62085, 9.57495, 3,  0.00000, 0.00000, 90.00000);
          SetTimerEx("BaseAztecas", 7000, 0, "d", playerid);
          dooropened[playerid] = true;
          SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
          }
       }//team bikers
       if(GetPlayerTeam(playerid) == 5 || CheckPlayerAdmin(playerid) > 1)
       {
          if(IsPlayerInRangeOfPoint(playerid, 25, 1807.65759, -1348.21875, 14.83265))
          {
          if(dooropened[playerid] == true) return 0;
          MoveDynamicObject(PuertaBK[0], 1807.71960, -1342.01233, 11.01894, 3, 0.00000, 0.00000, 90.00000);
          SetTimerEx("BaseBK1", 7000, 0, "d", playerid);
          dooropened[playerid] = true;
          SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
          }
	   }
	   if(GetPlayerTeam(playerid) == 5 || CheckPlayerAdmin(playerid) > 1)
	   {//team bikers
	      if(IsPlayerInRangeOfPoint(playerid, 25, 1812.30530, -1407.36511, 13.04358))
	      {
	      if(dooropened[playerid] == true) return 0;
	      MoveDynamicObject(PuertaBK[1], 1817.74524, -1407.39233, 9.33995, 3, 0.00000, 0.00000, 0.00000);
	      SetTimerEx("BaseBK2", 7000, 0, "d", playerid);
	      dooropened[playerid] = true;
          SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
	      }
	   }//team Nang
	   if(GetPlayerTeam(playerid) == 4 || CheckPlayerAdmin(playerid) > 1)
	   {
	      if(IsPlayerInRangeOfPoint(playerid, 25,   1270.00305, -1844.74487, 13.13761))
	      {
	      if(dooropened[playerid] == true) return 0;
	      MoveDynamicObject(PuertasDN[0], 1275.68982, -1844.55432, 9.23610, 3,  0.00000, 0.00000, 0.00000);
	      SetTimerEx("BaseDN1", 7000, 0, "d", playerid);
	      dooropened[playerid] = true;
          SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
	      }
	    }//team Nang
	    if(GetPlayerTeam(playerid) == 4|| CheckPlayerAdmin(playerid) > 1)
	    {
           if(IsPlayerInRangeOfPoint(playerid, 25, 1213.82019, -1844.81482, 13.40973))
           {
           if(dooropened[playerid] == true) return 0;
	       MoveDynamicObject(PuertasDN[1], 1219.42822, -1844.73877, 8.91002, 3, 0.00000, 0.00000, 0.00000);
	       SetTimerEx("BaseDN2", 7000, 0, "d", playerid);
	       dooropened[playerid] = true;
           SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
           }
		}//vagabundos
		if(GetPlayerTeam(playerid) == 14|| CheckPlayerAdmin(playerid) > 1)
		{
		   if(IsPlayerInRangeOfPoint(playerid, 25,  2200.55981, -1905.49451, 14.03372))
		   {
		   if(dooropened[playerid] == true) return 0;
		   MoveDynamicObject(PuertasVG[0], 2207.15649, -1905.31702, 9.70690, 3, 0.00000, 0.00000, 0.00000);
		   SetTimerEx("BaseVG1", 7000, 0, "d", playerid);
		   dooropened[playerid] = true;
		   SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
		   }
		 }//vagabundos
		 if(GetPlayerTeam(playerid) == 14|| CheckPlayerAdmin(playerid) > 1)
		 {
		    if(IsPlayerInRangeOfPoint(playerid, 25, 2204.15674, -1976.65198, 14.43433))
		    {
		    if(dooropened[playerid] == true) return 0;
		    MoveDynamicObject(PuertasVG[1], 2204.15210, -1971.32007, 9.65338, 3, 0.00000, 0.00000, 90.00000);
		    SetTimerEx("BaseVG2", 7000, 0, "d", playerid);
		    dooropened[playerid] = true;
		    SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
		    }
         }//vagabundos
         if(GetPlayerTeam(playerid) == 14|| CheckPlayerAdmin(playerid) > 1)
         {
            if(IsPlayerInRangeOfPoint(playerid, 25, 2067.63916, -1955.83813, 13.51761))
            {
            if(dooropened[playerid] == true) return 0;
            MoveDynamicObject(PuertasVG[2], 2067.66138, -1940.42151, 15.31451, 3,  0.00000, 0.00000, 90.00000);
            SetTimerEx("BaseVG3", 7000, 0, "d", playerid);
            dooropened[playerid] = true;
		    SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
		    }
          }//policia
          if(GetPlayerTeam(playerid) == 6|| CheckPlayerAdmin(playerid) > 1)
          {
             if(IsPlayerInRangeOfPoint(playerid, 25, 1542.83459, -1621.96863, 15.20534))
             {
             if(dooropened[playerid] == true) return 0;
             MoveDynamicObject(PuertaP[0], 1542.83459, -1621.96863, 9.22641, 3, 0.00000, 0.00000, 90.00000);
             SetTimerEx("BasePolicia", 7000, 0, "d", playerid);
             dooropened[playerid] = true;
		     SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
             }
           }//CIA
           if(GetPlayerTeam(playerid) == 7|| CheckPlayerAdmin(playerid) > 1)
           {
              if(IsPlayerInRangeOfPoint(playerid, 25,  1283.66797, -2056.24268, 59.11295))
              {
              if(dooropened[playerid] == true) return 0;
              MoveDynamicObject(PuertaCIA[0], 1283.65674, -2051.24634, 54.90451, 3, 0.00000, 0.00000, 90.00000);
              SetTimerEx("BaseCIA1", 7000, 0, "d", playerid);
              dooropened[playerid] = true;
		      SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
		      }
		    }//cia
		    if(GetPlayerTeam(playerid) == 7|| CheckPlayerAdmin(playerid) > 1)
		    {
		       if(IsPlayerInRangeOfPoint(playerid, 25, 1132.93823, -2082.67822, 69.37118))
		       {
		       if(dooropened[playerid] == true) return 0;
		       MoveDynamicObject(PuertaCIA[1], 1132.70679, -2082.58691, 62.63710, 3, 0.00000, 0.00000, 193.67979);
		       SetTimerEx("BaseCIA2", 7000, 0, "d", playerid);
		       dooropened[playerid] = true;
		       SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
		       }
			 }//militares
			 if(GetPlayerTeam(playerid) == 8|| CheckPlayerAdmin(playerid) > 1)
			 {
			    if(IsPlayerInRangeOfPoint(playerid, 25,  2720.05640, -2405.32520, 13.28415))
			    {
			    if(dooropened[playerid] == true) return 0;
			    MoveDynamicObject(PuertasM[0], 2720.05396, -2400.05884, 9.25077, 3, 0.00000, 0.00000, 90.00000);
			    SetTimerEx("BaseM1", 7000, 0, "d", playerid);
			    dooropened[playerid] = true;
		        SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
		        }
			  }//militares
			  if(GetPlayerTeam(playerid) == 8|| CheckPlayerAdmin(playerid) > 1)
			  {
			     if(IsPlayerInRangeOfPoint(playerid, 25, 2719.96411, -2503.99585, 13.38592))
			     {
			     if(dooropened[playerid] == true) return 0;
			     MoveDynamicObject(PuertasM[1], 2720.38354, -2498.67139, 9.02465, 3, 0.00000, 0.00000, 90.00000);
			     SetTimerEx("BaseM2", 7000, 0, "d", playerid);
			     dooropened[playerid] = true;
		         SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
			     }
			   }//mafia rusa
			   if(GetPlayerTeam(playerid) == 9|| CheckPlayerAdmin(playerid) > 1)
			   {
			      if(IsPlayerInRangeOfPoint(playerid, 25, 2233.98901, -2214.96558, 13.34346))
			      {
			      if(dooropened[playerid] == true) return 0;
			      MoveDynamicObject(PuertaMR[0], 2230.32104, -2211.53052, 8.62076, 3 , 0.00000, 0.00000, 134.93996);
			      SetTimerEx("MafiaRusa", 7000, 0, "d", playerid);
			      dooropened[playerid] = true;
		          SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
			      }
                }//traficantes
                if(GetPlayerTeam(playerid) == 12|| CheckPlayerAdmin(playerid) > 1)
                {
                   if(IsPlayerInRangeOfPoint(playerid, 25, 1128.57410, -1423.94519, 15.68583))
                   {
                   if(dooropened[playerid] == true) return 0;
                   MoveDynamicObject(PuertaT[0], 1134.20007, -1424.06287, 11.54410, 3, 0.00000, 0.00000, 0.00000);
                   SetTimerEx("BaseT1", 7000, 0, "d", playerid);
                   dooropened[playerid] = true;
   		           SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
   		           }
		         }//traficantes
		         if(GetPlayerTeam(playerid) == 12|| CheckPlayerAdmin(playerid) > 1)
		         {
		            if(IsPlayerInRangeOfPoint(playerid, 25,  1175.96155, -1489.62683, 14.28355))
		            {
		            if(dooropened[playerid] == true) return 0;
		            MoveDynamicObject(PuertaT[1], 1176.06921, -1484.18115, 10.07665, 3, 0.00000, 0.00000, 90.00000);
		            SetTimerEx("BaseT2", 7000, 0, "d", playerid);
		            dooropened[playerid] = true;
   		            SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
   		            }
				  }
				  if(GetPlayerTeam(playerid) == 10|| CheckPlayerAdmin(playerid) > 1)
				  {//forelli
				     if(IsPlayerInRangeOfPoint(playerid, 25,  1245.62427, -767.81311, 92.35355))
				     {
				     if(dooropened[playerid] == true) return 0;
				     MoveDynamicObject(PuertaF[0], 1252.12964, -768.10156, 87.53966, 3, 0.00000, 0.00000, 0.00000);
				     SetTimerEx("BaseF1", 7000, 0, "d", playerid);
				     dooropened[playerid] = true;
   		             SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
				     }
				   }//forelli
				   if(GetPlayerTeam(playerid) == 10|| CheckPlayerAdmin(playerid) > 1)
				   {
				      if(IsPlayerInRangeOfPoint(playerid, 25,   1322.55273, -820.16614, 72.19093))
				      {
				      if(dooropened[playerid] == true) return 0;
				      MoveDynamicObject(PuertaF[1], 1322.54871, -814.33185, 67.50728, 3, 0.00000, 0.00000, 90.00000);
				      SetTimerEx("BaseF2", 7000, 0, "d", playerid);
				      dooropened[playerid] = true;
   		              SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
				      }
					}//sindacco
					if(GetPlayerTeam(playerid) == 11|| CheckPlayerAdmin(playerid) > 1)
					{
					   if(IsPlayerInRangeOfPoint(playerid, 25,  664.84869, -1310.05334, 13.36430))
					   {
					   if(dooropened[playerid] == true) return 0;
					   MoveDynamicObject(PuertaS[0],  670.73492, -1310.06665, 9.17500, 3, 0.00000, 0.00000, 0.00000);
					   SetTimerEx("BaseS1", 7000, 0, "d", playerid);
					   dooropened[playerid] = true;
   		               SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
					   }
					}//sindacco
					if(GetPlayerTeam(playerid) == 11|| CheckPlayerAdmin(playerid) > 1)
					{
					   if(IsPlayerInRangeOfPoint(playerid, 25, 786.29547, -1151.59583, 23.45992))
					   {
					   if(dooropened[playerid] == true) return 0;
					   MoveDynamicObject(PuertaS[1], 786.40363, -1146.68579, 19.81029, 3, 0.00000, 0.00000, 90.00000);
					   SetTimerEx("BaseS2", 7000, 0, "d", playerid);
					   dooropened[playerid] = true;
   		               SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
   		               }
                     }//sindacco
                     if(GetPlayerTeam(playerid) == 11|| CheckPlayerAdmin(playerid) > 1)
                     {
                        if(IsPlayerInRangeOfPoint(playerid, 25,  660.77594, -1228.03735, 16.06856))
                        {
                        if(dooropened[playerid] == true) return 0;
                        MoveDynamicObject(PuertaS[2], 663.28766, -1222.56018, 11.99187, 3, 0.00000, 0.00000, 61.13999);
                        SetTimerEx("BaseS3", 7000, 0, "d", playerid);
                        dooropened[playerid] = true;
   		                SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
                        }
                     }
                     if(CheckVip(playerid) >= 2)// return SendClientMessage(playerid, 0xFF0000FF, "ERROR: Debes ser VIP para abrir la puerta de la base VIP.");
					 {
					    if(IsPlayerInRangeOfPoint(playerid, 10.0, 2900.9414,-1964.8022,10.9382))
                        {
                        if(dooropened[playerid] == true) return 0;
                        MoveDynamicObject(RejaAutomatica[0], 2900.54395, -1964.95886, 19.85460, 2, 0.00000, 0.00000, 90.00000);
                        SetTimerEx("cerrar2", 7000, 0, "d", playerid);
                        dooropened[playerid] = true;
                        SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
                        }
					 }
					 /*if(CheckVip(playerid) >= 2)
					 {
					    if(IsPlayerInRangeOfPoint(playerid, 15.0, 3366.9087, -2245.5557, 27.0671))
					    {
					    //if(dooropened[playerid] == true) return 0;
					    MoveObject(PuertaHangar1, 3369.1797, -2222.2744, 29.7818, 2, 0.00000, 0.00000, -91.68010);
					    MoveObject(PuertaHangar2, 3368.0361, -2259.1587, 29.7818, 2, 0.00000, 0.00000, -91.68010);
					    MoveObject(PuertaHangar3, 3369.1987, -2222.2712, 32.8214, 2, 0.00000, 0.00000, -91.68010);
					    MoveObject(PuertaHangar4, 3368.0439, -2259.1931, 32.8007, 2, 0.00000, 0.00000, -91.68010);
					    //dooropened[playerid] = true;
                        //SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
                        return 1;
						}

					}
					if(CheckVip(playerid) >= 2) 
					{
					   if(IsPlayerInRangeOfPoint(playerid, 15.0, 3366.9087, -2245.5557, 27.0671))
					   {
					   //if(dooropened[playerid] == true) return 0;
					   MoveObject(PuertaHangar1, 3368.88721, -2233.52930, 29.78182, 2, 0.00000, 0.00000, -91.68010);
					   MoveObject(PuertaHangar2, 3368.49927, -2248.14087, 29.78182, 2, 0.00000, 0.00000, -91.68010);
					   MoveObject(PuertaHangar3, 3368.98730, -2233.52930, 32.82139, 2, 0.00000, 0.00000, -91.68010);
					   MoveObject(PuertaHangar4, 3368.55908, -2248.06714, 32.80074, 2, 0.00000, 0.00000, -91.68010);
					   //dooropened[playerid] = true;
                       //SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
                       return 1;
                       }

					}
					if(CheckVip(playerid) >= 2)
					{
					   if(IsPlayerInRangeOfPoint(playerid, 15.0,  3386.8701, -1875.0267, 8.0024))
					   {
					   //if(dooropened[playerid] == true) return 0;
					   MoveDynamicObject(PuertaMuelle, 3386.87012, -1875.02673, 8.00239, 2, 90.00000, 0.00000, -18.90000);
					   MoveDynamicObject(PuertaMuelle2,  3386.83765, -1874.94910, 6.99298, 2, 0.00000, 0.00000, 76.32000);
					   //dooropened[playerid] = true;
                       //SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
                       return 1;
                       }

				     }
				     if(CheckVip(playerid) >= 2)
				     {
				       if(IsPlayerInRangeOfPoint(playerid, 10.0, 3386.8701, -1875.0267, 8.0024))
					   {
				       //if(dooropened[playerid] == true) return 0;
			           MoveDynamicObject(PuertaMuelle, 3386.87012, -1875.02673, 17.53830, 2, 90.00000, 0.00000, -18.90000);
				       MoveDynamicObject(PuertaMuelle2, 3386.83765, -1874.94910, 14.34694, 2, 0.00000, 0.00000, 76.32000);
				       //dooropened[playerid] = true;
                       //SetTimerEx("TimerDoor", 11000, 0, "d", playerid);
                       return 1;
                       }
                     }*/
	          }

   return 1;
}

CMD:abrirhangar(playerid, params[])
{
   if(CheckVip(playerid) == 0) return SendClientMessage(playerid, 0xFF0000FF, "ERROR: Debes ser VIP para abrir el hangar.");
      if(IsPlayerInRangeOfPoint(playerid, 15.0, 3366.9087, -2245.5557, 27.0671))
      {
      MoveObject(PuertaHangar1, 3369.1797, -2222.2744, 29.7818, 2, 0.00000, 0.00000, -91.68010);
      MoveObject(PuertaHangar2, 3368.0361, -2259.1587, 29.7818, 2, 0.00000, 0.00000, -91.68010);
      MoveObject(PuertaHangar3, 3369.1987, -2222.2712, 32.8214, 2, 0.00000, 0.00000, -91.68010);
      MoveObject(PuertaHangar4, 3368.0439, -2259.1931, 32.8007, 2, 0.00000, 0.00000, -91.68010);
      return SendClientMessage(playerid, 0xD5AF31FF, "Has abierto el hangar militar VIP");
      }
   else return SendClientMessage(playerid, 0xFF0000FF, "ERROR: Debes estar cerca del Hangar militar VIP para usar este comando");
}

CMD:cerrarhangar(playerid, params[])
{
   if(CheckVip(playerid) == 0) return SendClientMessage(playerid, 0xFF0000FF, "ERROR: Debes ser VIP para cerrar el hangar.");
      if(IsPlayerInRangeOfPoint(playerid, 15.0, 3366.9087, -2245.5557, 27.0671))
      {
      MoveObject(PuertaHangar1, 3368.88721, -2233.52930, 29.78182, 2, 0.00000, 0.00000, -91.68010);
      MoveObject(PuertaHangar2, 3368.49927, -2248.14087, 29.78182, 2, 0.00000, 0.00000, -91.68010);
      MoveObject(PuertaHangar3, 3368.98730, -2233.52930, 32.82139, 2, 0.00000, 0.00000, -91.68010);
      MoveObject(PuertaHangar4, 3368.55908, -2248.06714, 32.80074, 2, 0.00000, 0.00000, -91.68010);
      return SendClientMessage(playerid, 0xD5AF31FF, "Has cerrado el hangar militar VIP");
      }
   else return SendClientMessage(playerid, 0xFF0000FF, "ERROR: Debes estar cerca del Hangar militar VIP para usar este comando");
}

CMD:apmv(playerid, params[])
{
   if(CheckVip(playerid) == 0) return SendClientMessage(playerid, 0xFF0000FF, "ERROR: Debes ser VIP para abrir esta puerta.");
      if(IsPlayerInRangeOfPoint(playerid, 15.0,  3386.8701, -1875.0267, 8.0024))
      {
      MoveDynamicObject(PuertaMuelle, 3386.87012, -1875.02673, 8.00239, 2, 90.00000, 0.00000, -18.90000);
      MoveDynamicObject(PuertaMuelle2,  3386.83765, -1874.94910, 6.99298, 2, 0.00000, 0.00000, 76.32000);
      return SendClientMessage(playerid, 0xD5AF31FF, "Has abierto la puerta del muelle VIP");
      }
   else return SendClientMessage(playerid, 0xFF0000FF, "ERROR: Debes estar cerca de la puerta del muelle VIP para usar este comando");
}

CMD:cpmv(playerid, params[])
{
   if(CheckVip(playerid) == 0) return SendClientMessage(playerid, 0xFF0000FF, "ERROR: Debes ser VIP para cerrar esta puerta.");
      if(IsPlayerInRangeOfPoint(playerid, 10.0, 3386.8701, -1875.0267, 8.0024))
      {
      MoveDynamicObject(PuertaMuelle, 3386.87012, -1875.02673, 17.53830, 2, 90.00000, 0.00000, -18.90000);
      MoveDynamicObject(PuertaMuelle2, 3386.83765, -1874.94910, 14.34694, 2, 0.00000, 0.00000, 76.32000);
      return SendClientMessage(playerid, 0xD5AF31FF, "Has cerrado la puerta del muelle VIP");
      }
   else return SendClientMessage(playerid, 0xFF0000FF, "ERROR: Debes estar cerca de la puerta del muelle VIP para usar este comando");
}

//Nota: Sí deciden eliminar los mapeos se ahorrarán todo el código de OnPlayerKeyState, y este fs quedaría casi vacio.. Jeff
