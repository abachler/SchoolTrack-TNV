//%attributes = {}
  //ADTcon_OnLoad

ARRAY TEXT:C222(atADT_NivName;0)
ARRAY LONGINT:C221(aiADT_NivNo;0)

READ ONLY:C145([xxSTR_Niveles:6])
QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesAdmissionTrack)

ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;atADT_NivName;[xxSTR_Niveles:6]NoNivel:5;aiADT_NivNo)

AT_Insert (1;2;->atADT_NivName;->aiADT_NivNo)
atADT_NivName{1}:="Sin información"
atADT_NivName{2}:="(-"
aiADT_NivNo{1}:=-999

vProsID:=-MAXLONG:K35:2
vProsApPaterno:=""
vProsApMaterno:=""
vProsNombres:=""
vProsNivel:="Sin información"
vProsNivelNum:=-999
vProsFdeNac:=!00-00-00!
vProsNota:=""
vProsSexo:=""
vProsRelacion:=""
vb_ProsModified:=False:C215

ARRAY TEXT:C222(aProsApPaterno;0)
ARRAY TEXT:C222(aProsApMaterno;0)
ARRAY TEXT:C222(aProsNombres;0)
ARRAY TEXT:C222(aProsNivel;0)
ARRAY TEXT:C222(aProsEdad;0)
ARRAY LONGINT:C221(aProsID;0)
ARRAY DATE:C224(aProsFechaNac;0)
ARRAY TEXT:C222(aProsNota;0)
_O_ARRAY STRING:C218(3;aProsSexo;0)
ARRAY INTEGER:C220(aProsNivelNum;0)
ARRAY BOOLEAN:C223(aProsMod;0)
ARRAY TEXT:C222(aProsRelacion;0)

ALP_DefaultColSettings (xALP_Prospectos;1;"aProsApPaterno";__ ("Apellido Paterno");175)
ALP_DefaultColSettings (xALP_Prospectos;2;"aProsApMaterno";__ ("Apellido Materno");174)
ALP_DefaultColSettings (xALP_Prospectos;3;"aProsNombres";__ ("Nombres");175)
ALP_DefaultColSettings (xALP_Prospectos;4;"aProsNivel";__ ("Nivel");75)
ALP_DefaultColSettings (xALP_Prospectos;5;"aProsEdad";__ ("Edad");100)
ALP_DefaultColSettings (xALP_Prospectos;6;"aProsID")
ALP_DefaultColSettings (xALP_Prospectos;7;"aProsFechaNac")
ALP_DefaultColSettings (xALP_Prospectos;8;"aProsNota")
ALP_DefaultColSettings (xALP_Prospectos;9;"aProsSexo")
ALP_DefaultColSettings (xALP_Prospectos;10;"aProsNivelNum")
ALP_DefaultColSettings (xALP_Prospectos;11;"aProsMod")
ALP_DefaultColSettings (xALP_Prospectos;12;"aProsRelacion")

ALP_SetDefaultAppareance (xALP_Prospectos;9;1;6;1;8)
AL_SetColOpts (xALP_Prospectos;1;1;1;7;0)
AL_SetRowOpts (xALP_Prospectos;0;1;0;0;0;0)
AL_SetScroll (xALP_Prospectos;0;-3)

_O_DISABLE BUTTON:C193(bDelProspecto)
_O_DISABLE BUTTON:C193(baADT)