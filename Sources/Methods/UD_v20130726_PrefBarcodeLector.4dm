//%attributes = {}
  // UD_v20130726_PrefBarcodeLector()
  // Por: Alberto Bachler: 26/07/13, 11:15:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_procesoProgreso)

ARRAY LONGINT:C221($al_RecNums;0)
ALL RECORDS:C47([xxBBL_Preferencias:65])

LONGINT ARRAY FROM SELECTION:C647([xxBBL_Preferencias:65];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([xxBBL_Preferencias:65])
	GOTO RECORD:C242([xxBBL_Preferencias:65];$al_RecNums{$i_registros})
	If ([xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33=0)
		If ([xxBBL_Preferencias:65]PatronBCode_UseRut:37)
			[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33:=Field:C253(->[BBL_Lectores:72]RUT:7)
		Else 
			[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33:=Field:C253(->[BBL_Lectores:72]ID:1)
		End if 
	End if 
	SAVE RECORD:C53([xxBBL_Preferencias:65])
End for 
KRL_UnloadReadOnly (->[xxBBL_Preferencias:65])

ALL RECORDS:C47([BBL_Lectores:72])

LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$al_RecNums;"")
$l_procesoProgreso:=IT_Progress (1;$l_procesoProgreso;0;__ ("Actualizando identificadores nacionales en registros de lectores MediaTrack…"))
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Lectores:72])
	GOTO RECORD:C242([BBL_Lectores:72];$al_RecNums{$i_registros})
	Case of 
		: (([BBL_Lectores:72]ID_GrupoLectores:37=-1) | ([BBL_Lectores:72]ID_GrupoLectores:37=-4))  // lector es alumno
			[BBL_Lectores:72]RUT:7:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[BBL_Lectores:72]Número_de_alumno:6;->[Alumnos:2]RUT:5)
			[BBL_Lectores:72]IDNacional_2:33:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[BBL_Lectores:72]Número_de_alumno:6;->[Alumnos:2]IDNacional_2:71)
			[BBL_Lectores:72]IDNacional_3:34:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[BBL_Lectores:72]Número_de_alumno:6;->[Alumnos:2]IDNacional_3:70)
		: ([BBL_Lectores:72]ID_GrupoLectores:37=-2)  // lector es profesor
			[BBL_Lectores:72]RUT:7:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[BBL_Lectores:72]Número_de_Profesor:30;->[Profesores:4]RUT:27)
			[BBL_Lectores:72]IDNacional_2:33:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[BBL_Lectores:72]Número_de_Profesor:30;->[Profesores:4]IDNacional_2:42)
			[BBL_Lectores:72]IDNacional_3:34:=KRL_GetTextFieldData (->[Personas:7]No:1;->[BBL_Lectores:72]Número_de_Profesor:30;->[Profesores:4]IDNacional_3:43)
		: ([BBL_Lectores:72]ID_GrupoLectores:37=-3)  // lector es relacion familiaR
			[BBL_Lectores:72]RUT:7:=KRL_GetTextFieldData (->[Personas:7]No:1;->[BBL_Lectores:72]Número_de_Persona:31;->[Personas:7]RUT:6)
			[BBL_Lectores:72]IDNacional_2:33:=KRL_GetTextFieldData (->[Personas:7]No:1;->[BBL_Lectores:72]Número_de_Persona:31;->[Personas:7]IDNacional_2:37)
			[BBL_Lectores:72]IDNacional_3:34:=KRL_GetTextFieldData (->[Personas:7]No:1;->[BBL_Lectores:72]Número_de_Persona:31;->[Personas:7]IDNacional_3:38)
	End case 
	If (([BBL_Lectores:72]Número_de_alumno:6=0) & ([BBL_Lectores:72]Número_de_Profesor:30=0) & ([BBL_Lectores:72]Número_de_Persona:31=0) & ([BBL_Lectores:72]ID:1>0))
		[BBL_Lectores:72]ID_GrupoLectores:37:=-5
		[BBL_Lectores:72]Grupo:2:=__ ("Usuarios Externos")
	End if 
	SAVE RECORD:C53([BBL_Lectores:72])
	$l_procesoProgreso:=IT_Progress (0;$l_procesoProgreso;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_procesoProgreso:=IT_Progress (-1;$l_procesoProgreso)
KRL_UnloadReadOnly (->[BBL_Lectores:72])
