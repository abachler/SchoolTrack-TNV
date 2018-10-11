//%attributes = {"executedOnServer":true}
  // BBLpat_SchoolTrack2Patrons()
  // Por: Alberto Bachler: 02/08/13, 17:10:47
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_IDProcesoProgreso;$l_registrosProcesados;$l_totalRegistros)

ARRAY LONGINT:C221($al_RecNums;0)

READ WRITE:C146([BBL_Lectores:72])
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4="")
DELETE SELECTION:C66([BBL_Lectores:72])

QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4="PRF";*)
QUERY:C277([BBL_Lectores:72]; & [BBL_Lectores:72]Número_de_Profesor:30=0;*)
QUERY:C277([BBL_Lectores:72]; & [BBL_Lectores:72]Total_de_préstamos:8=0)
DELETE SELECTION:C66([BBL_Lectores:72])

QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4="FAM";*)
QUERY:C277([BBL_Lectores:72]; & [BBL_Lectores:72]Número_de_Persona:31=0;*)
QUERY:C277([BBL_Lectores:72]; & [BBL_Lectores:72]Total_de_préstamos:8=0)
DELETE SELECTION:C66([BBL_Lectores:72])

ALL RECORDS:C47([BBL_Lectores:72])

$l_totalRegistros:=0

MESSAGES ON:C181
READ WRITE:C146([Alumnos:2])
QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
$l_totalRegistros:=Records in selection:C76([Alumnos:2])+Records in table:C83([Profesores:4])+Records in table:C83([Personas:7])

$l_IDProcesoProgreso:=IT_Progress (1;$l_IDProcesoProgreso;0;"Actualizando registros de lectores desde SchoolTrack...")
$l_registrosProcesados:=0
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Alumnos:2];$al_RecNums{$i_registros})
	BBL_CreateUserRecord (Table:C252(->[Alumnos:2]))
	$l_registrosProcesados:=$l_registrosProcesados+1
	IT_Progress (0;$l_IDProcesoProgreso;$l_registrosProcesados/$l_totalRegistros;"Actualizando registros de lectores desde SchoolTrack...";$i_registros/Size of array:C274($al_RecNums);"Alumnos...\r"+[Alumnos:2]apellidos_y_nombres:40)
End for 

READ WRITE:C146([Profesores:4])
ALL RECORDS:C47([Profesores:4])
LONGINT ARRAY FROM SELECTION:C647([Profesores:4];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Profesores:4];$al_RecNums{$i_registros})
	BBL_CreateUserRecord (Table:C252(->[Profesores:4]))
	$l_registrosProcesados:=$l_registrosProcesados+1
	IT_Progress (0;$l_IDProcesoProgreso;$l_registrosProcesados/$l_totalRegistros;"Actualizando registros de lectores desde SchoolTrack...";$i_registros/Size of array:C274($al_RecNums);"Profesores...\r"+[Profesores:4]Apellidos_y_nombres:28)
End for 

READ WRITE:C146([Personas:7])
ALL RECORDS:C47([Personas:7])

LONGINT ARRAY FROM SELECTION:C647([Personas:7];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Personas:7];$al_RecNums{$i_registros})
	BBL_CreateUserRecord (Table:C252(->[Personas:7]))
	$l_registrosProcesados:=$l_registrosProcesados+1
	IT_Progress (0;$l_IDProcesoProgreso;$l_registrosProcesados/$l_totalRegistros;"Actualizando registros de lectores desde SchoolTrack...";$i_registros/Size of array:C274($al_RecNums);"Relaciones familiares...\r"+[Personas:7]Apellidos_y_nombres:30)
End for 

IT_Progress (-1;$l_IDProcesoProgreso)

MESSAGES OFF:C175
