//%attributes = {}
  //SOPORTE_STR_GeneraDatosDemo
ST_LoadModuleFormatExceptions ("SchoolTrack")

<>vb_AvoidTriggerExecution:=True:C214
ALL RECORDS:C47([Familia:78])
SELECTION TO ARRAY:C260([Familia:78]Nombre_de_la_familia:3;$names;[Familia:78];$id)
KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Madre_Número:6)
SELECTION TO ARRAY:C260([Personas:7]Apellido_paterno:3;$aMaternoRef)
KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Padre_Número:5)
SELECTION TO ARRAY:C260([Personas:7]Apellido_paterno:3;$aPaternoRef)


ARRAY TEXT:C222($aPaterno;Size of array:C274($id))
ARRAY TEXT:C222($aMaterno;Size of array:C274($id))
For ($i;1;Size of array:C274($id))
	$apaterno{$i}:=$apaternoRef{MATH_RandomLongint (1;Size of array:C274($apaternoRef))}
	$amaterno{$i}:=$amaternoRef{MATH_RandomLongint (1;Size of array:C274($amaternoRef))}
End for 

$s:=1
$e:=Size of array:C274($apaterno)

READ WRITE:C146(*)
For ($i;1;Size of array:C274($id))
	GOTO RECORD:C242([Familia:78];$id{$i})
	$names{$i}:=$apaterno{$i}+" "+$amaterno{$i}
	[Familia:78]Nombre_de_la_familia:3:=$names{$i}
	[Familia:78]Telefono:10:=""
	[Familia:78]Celular:32:=""
	[Familia:78]eMail:21:=""
	SAVE RECORD:C53([Familia:78])
	$idMadre:=[Familia:78]Madre_Número:6
	$idPadre:=[Familia:78]Padre_Número:5
	QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
	APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apellido_paterno:3:=$apaterno{$i})
	APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apellido_materno:4:=$amaterno{$i})
	
	APPLY TO SELECTION:C70([Alumnos:2];AL_ProcesaNombres )  //20170913 RCH
	
	ARRAY TEXT:C222($aTEmpty;Records in selection:C76([Alumnos:2]))
	ARRAY TO SELECTION:C261($aTEmpty;[Alumnos:2]Telefono:17;$aTEmpty;[Alumnos:2]Celular:95;$aTEmpty;[Alumnos:2]eMAIL:68)
	
	REDUCE SELECTION:C351([Alumnos:2];0)
	
	READ WRITE:C146([Personas:7])  //el método replicar cambios puede dejar la tabla en solo lectura
	QUERY:C277([Personas:7];[Personas:7]No:1=$idMadre)
	[Personas:7]Apellido_paterno:3:=$amaterno{$i}
	[Personas:7]Apellido_materno:4:=$apaterno{MATH_RandomLongint (1;Size of array:C274($apaterno))}
	[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
	[Personas:7]eMail:34:=""
	[Personas:7]Telefono_domicilio:19:=""
	[Personas:7]Telefono_profesional:29:=""
	[Personas:7]Celular:24:=""
	SAVE RECORD:C53([Personas:7])
	
	READ WRITE:C146([Personas:7])  //el método replicar cambios puede dejar la tabla en solo lectura
	QUERY:C277([Personas:7];[Personas:7]No:1=$idPadre)
	[Personas:7]Apellido_paterno:3:=$apaterno{$i}
	[Personas:7]Apellido_materno:4:=$amaterno{MATH_RandomLongint (1;Size of array:C274($amaterno))}
	[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
	[Personas:7]eMail:34:=""
	[Personas:7]Telefono_domicilio:19:=""
	[Personas:7]Telefono_profesional:29:=""
	[Personas:7]Celular:24:=""
	SAVE RECORD:C53([Personas:7])
End for 

ALL RECORDS:C47([Alumnos_FichaMedica:13])
ARRAY TEXT:C222($aTEmpty;Records in selection:C76([Alumnos_FichaMedica:13]))
ARRAY TO SELECTION:C261($aTEmpty;[Alumnos_FichaMedica:13]Urgencia_Fonos:5;$aTEmpty;[Alumnos_FichaMedica:13]Urgencia_Contacto:4)

  //  `cambio de nombres de profesores
ALL RECORDS:C47([Profesores:4])
SELECTION TO ARRAY:C260([Profesores:4]Apellido_paterno:3;$paterno;[Profesores:4]Apellido_materno:4;$materno;[Profesores:4];$rec;[Profesores:4]Nombres:2;$aNombres)
$s:=1
$e:=Size of array:C274($paterno)
ARRAY TEXT:C222($aMail;$e)
ARRAY TEXT:C222($aCompleto;$e)
ARRAY TEXT:C222($aComun;$e)
ARRAY TEXT:C222($n;$e)
ARRAY TEXT:C222($p;$e)
ARRAY TEXT:C222($m;$e)
For ($i;1;Size of array:C274($p))
	$n{$i}:=$aNombres{MATH_RandomLongint ($s;$e)}
	$p{$i}:=$paterno{MATH_RandomLongint ($s;$e)}
	$m{$i}:=$materno{MATH_RandomLongint ($s;$e)}
	$aCompleto{$i}:=ST_ClearSpaces ($p{$i}+" "+$m{$i}+" "+$n{$i})
	$aComun{$i}:=ST_ClearSpaces (ST_GetWord ($n{$i};1)+" "+$p{$i})
End for 
ARRAY TO SELECTION:C261($n;[Profesores:4]Nombres:2;$p;[Profesores:4]Apellido_paterno:3;$m;[Profesores:4]Apellido_materno:4;$aMail;[Profesores:4]eMail_profesional:38;$aCompleto;[Profesores:4]Apellidos_y_nombres:28;$aComun;[Profesores:4]Nombre_comun:21)
APPLY TO SELECTION:C70([Profesores:4];[Profesores:4]Apellidos_y_nombres:28:=Replace string:C233([Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4+" "+[Profesores:4]Nombres:2;"  ";" "))
APPLY TO SELECTION:C70([Profesores:4];[Profesores:4]Iniciales:29:=ST_Uppercase (Substring:C12([Profesores:4]Nombres:2;1;1)+Substring:C12([Profesores:4]Apellido_paterno:3;1;1)+Substring:C12([Profesores:4]Apellido_materno:4;1;1)))
APPLY TO SELECTION:C70([Profesores:4];[Profesores:4]Nombre_comun:21:=ST_GetWord ([Profesores:4]Nombres:2;1)+" "+[Profesores:4]Apellido_paterno:3)
ALL RECORDS:C47([Asignaturas:18])
While (Not:C34(End selection:C36([Asignaturas:18])))
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Asignaturas:18]profesor_numero:4)
	[Asignaturas:18]profesor_nombre:13:=[Profesores:4]Apellidos_y_nombres:28
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Asignaturas:18]profesor_firmante_numero:33)
	[Asignaturas:18]profesor_firmante_Nombre:34:=[Profesores:4]Apellidos_y_nombres:28
	SAVE RECORD:C53([Asignaturas:18])
	NEXT RECORD:C51([Asignaturas:18])
End while 
FLUSH CACHE:C297


USR_CreateDefaultGroups 
USR_LoadPasswordTables 
ALL RECORDS:C47([Profesores:4])
SELECTION TO ARRAY:C260([Profesores:4]Nombre_comun:21;$aComun;[Profesores:4]Numero:1;$aID)
USR_GetGroupMemberList (-15002)
READ WRITE:C146([xShell_Users:47])
QRY_QueryWithArray (->[xShell_Users:47]No:1;-><>aMembersID)
DELETE SELECTION:C66([xShell_Users:47])
CREATE EMPTY SET:C140([xShell_Users:47];"members")
For ($i;1;Size of array:C274($aComun))
	CREATE RECORD:C68([xShell_Users:47])
	[xShell_Users:47]Name:2:=$aComun{$i}
	[xShell_Users:47]login:9:=ST_ReplaceAccentedChars (ST_Lowercase ($aComun{$i}[[1]]+ST_GetWord ($aComun{$i};2)))
	$password:=[xShell_Users:47]login:9
	[xShell_Users:47]xPass:13:=USR_EncryptPassWord ($password)
	[xShell_Users:47]No:1:=SQ_SeqNumber (->[xShell_Users:47]No:1)
	[xShell_Users:47]NoEmployee:7:=$aID{$i}
	[xShell_Users:47]PasswordVersion:10:=3
	SAVE RECORD:C53([xShell_Users:47])
	$userID:=[xShell_Users:47]No:1
	ADD TO SET:C119([xShell_Users:47];"members")
	USR_LoadPasswordTables 
	USR_AddUserMembership ($userID;-15002)
End for 
0xDev_DeleteDuplicates (->[xShell_Users:47]login:9)


USE SET:C118("members")
ARRAY LONGINT:C221($tempLongArray;0)
SELECTION TO ARRAY:C260([xShell_Users:47]No:1;$tempLongArray)
USR_GetGroupMemberList (-15002;<>aMembersID)
For ($i;1;Size of array:C274($tempLongArray))
	If (Find in array:C230(<>aMembersID;$tempLongArray{$i})=-1)
		INSERT IN ARRAY:C227(<>aMembersID;Size of array:C274(<>aMembersID)+1)
		<>aMembersID{Size of array:C274(<>aMembersID)}:=$tempLongArray{$i}
	End if 
End for 
USR_SetGroupMemberList (-15002;-><>aMembersID)

USR_LoadPasswordTables 

  //modifica uuids registros
QA_ModificaUUIDTablas 

KRL_UnloadAll 
READ ONLY:C145(*)


<>vb_AvoidTriggerExecution:=False:C215