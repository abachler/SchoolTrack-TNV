//%attributes = {}
  //ADTcdd_LoadEducacionAnterior

$id:=$1
$tipo:=$2  //el tipo puede ser "al", "pe" o "pr" (alumno, persona o profesor)

READ ONLY:C145([STR_EducacionAnterior:87])
QUERY:C277([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]Tipo_Persona:8=$tipo)
Case of 
	: ($tipo="al")
		QUERY SELECTION:C341([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]ID_Alumno:5=$id)
	: ($tipo="pe")
		QUERY SELECTION:C341([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]ID_Persona:6=$id)
	: ($tipo="pr")
		QUERY SELECTION:C341([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]ID_Profesor:7=$id)
End case 

AL_RemoveArrays (xALP_EducAnterior;1;512)

ARRAY TEXT:C222(atADT_ColAnt_Nombre;0)
ARRAY TEXT:C222(atADT_ColAnt_Pais;0)
ARRAY TEXT:C222(atADT_ColAnt_Nivel;0)
ARRAY LONGINT:C221(alADT_ColAnt_Año;0)
ARRAY LONGINT:C221(alADT_ColAnt_RecNums;0)

SELECTION TO ARRAY:C260([STR_EducacionAnterior:87]Nombre_Colegio:1;atADT_ColAnt_Nombre;[STR_EducacionAnterior:87]País:2;atADT_ColAnt_Pais;[STR_EducacionAnterior:87]Nivel:3;atADT_ColAnt_Nivel;[STR_EducacionAnterior:87]Año:4;alADT_ColAnt_Año;[STR_EducacionAnterior:87];alADT_ColAnt_RecNums)

IT_SetButtonState ((Size of array:C274(atADT_ColAnt_Nombre)>0);->bDelColAnt)

$err:=ALP_DefaultColSettings (xALP_EducAnterior;1;"atADT_ColAnt_Nombre";__ ("Colegio");128)
$err:=ALP_DefaultColSettings (xALP_EducAnterior;2;"atADT_ColAnt_Pais";__ ("País");80;"";0;0;1)
$err:=ALP_DefaultColSettings (xALP_EducAnterior;3;"atADT_ColAnt_Nivel";__ ("Nivel");80)
$err:=ALP_DefaultColSettings (xALP_EducAnterior;4;"alADT_ColAnt_Año";__ ("Año");40;"####";0;0;1)
$err:=ALP_DefaultColSettings (xALP_EducAnterior;5;"alADT_ColAnt_RecNums";"")

AL_SetEnterable (xALP_EducAnterior;1;1)

AL_SetEnterable (xALP_EducAnterior;3;2;<>aNivel)

ALP_SetDefaultAppareance (xALP_EducAnterior;9;1;6;1;8)
AL_SetColOpts (xALP_EducAnterior;1;1;0;1;0)
AL_SetRowOpts (xALP_EducAnterior;0;1;0;0;1;0)
AL_SetCellOpts (xALP_EducAnterior;0;1;1)
AL_SetMiscOpts (xALP_EducAnterior;0;0;"\\";0;1)
AL_SetMainCalls (xALP_EducAnterior;"";"")
AL_SetCallbacks (xALP_EducAnterior;"";"xALCB_ADT_EX_EducAnterior")
AL_SetScroll (xALP_EducAnterior;0;-3)
AL_SetEntryOpts (xALP_EducAnterior;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_EducAnterior;0;30;0)