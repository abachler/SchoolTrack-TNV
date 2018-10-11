//%attributes = {"executedOnServer":true}
  // UD_v20131220_VerificaUUID()
  // Por: Alberto Bachler K.: 20-12-13, 17:46:28
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_campos;$i_registros)
C_LONGINT:C283($l_idTermometro;$l_PosicionUUIDNulo;$l_recNum)
C_POINTER:C301($y_tabla)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY POINTER:C280($y_campos;0)
ARRAY TEXT:C222($at_UUID;0)
<>vb_ImportHistoricos_STX:=True:C214

APPEND TO ARRAY:C911($y_campos;->[xxSTR_Constants:1]Auto_UUID:1)
APPEND TO ARRAY:C911($y_campos;->[Alumnos:2]auto_uuid:72)
APPEND TO ARRAY:C911($y_campos;->[Profesores:4]Auto_UUID:41)
APPEND TO ARRAY:C911($y_campos;->[Personas:7]Auto_UUID:36)
APPEND TO ARRAY:C911($y_campos;->[BBL_Lectores:72]Auto_UUID:46)
APPEND TO ARRAY:C911($y_campos;->[Asignaturas_Eventos:170]Auto_UUID:18)
APPEND TO ARRAY:C911($y_campos;->[XShell_ReportObjLib_Clases:274]Auto_UUID:6)
APPEND TO ARRAY:C911($y_campos;->[xShell_Queries:53]AUTO_UUID:4)
APPEND TO ARRAY:C911($y_campos;->[Familia:78]Auto_UUID:23)
APPEND TO ARRAY:C911($y_campos;->[NTC_Notificaciones:190]Auto_UUID:1)
APPEND TO ARRAY:C911($y_campos;->[DocumentLibrary:234]Auto_UUID:2)
APPEND TO ARRAY:C911($y_campos;->[XShell_ReportObjLib_Objects:275]Auto_UUID:11)
APPEND TO ARRAY:C911($y_campos;->[STWA2_SessionManager:290]Auto_UUID:1)
APPEND TO ARRAY:C911($y_campos;->[xShell_Reports:54]UUID:47)

<>vb_ImportHistoricos_STX:=True:C214
$l_idTermometro:=IT_Progress (1;0;0;"Verificando Llaves primarias...")

For ($i_campos;1;Size of array:C274($y_campos))
	$y_tabla:=Table:C252(Table:C252($y_campos{$i_campos}))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_campos/Size of array:C274($y_campos);"Verificando Llaves primarias..."+Table name:C256($y_tabla))
	
	  // FASE 1: DETECCION DE UUID INVALIDOS Y REGENERACION
	ALL RECORDS:C47($y_tabla->)
	SELECTION TO ARRAY:C260($y_tabla->;$al_RecNums;$y_campos{$i_campos}->;$at_UUID)
	  // 1.1 busco los UUID iguales a con 00000000...
	$l_PosicionUUIDNulo:=Find in array:C230($at_UUID;"000000@")
	While ($l_PosicionUUIDNulo>0)
		$l_recNum:=$al_RecNums{$l_PosicionUUIDNulo}
		READ WRITE:C146($y_tabla->)
		GOTO RECORD:C242($y_tabla->;$l_recNum)
		$y_campos{$i_campos}->:=Generate UUID:C1066
		SAVE RECORD:C53($y_tabla->)
		$l_PosicionUUIDNulo:=Find in array:C230($at_UUID;"000000@";$l_PosicionUUIDNulo+1)
	End while 
	
	  // 1.2 busco los UUID iguales a 20202020....
	$l_PosicionUUIDNulo:=Find in array:C230($at_UUID;"20202020@")
	While ($l_PosicionUUIDNulo>0)
		$l_recNum:=$al_RecNums{$l_PosicionUUIDNulo}
		READ WRITE:C146($y_tabla->)
		GOTO RECORD:C242($y_tabla->;$l_recNum)
		$y_campos{$i_campos}->:=Generate UUID:C1066
		SAVE RECORD:C53($y_tabla->)
		$l_PosicionUUIDNulo:=Find in array:C230($at_UUID;"20202020@";$l_PosicionUUIDNulo+1)
	End while 
	
	  // 1.3 busco los UUID vacios
	$l_PosicionUUIDNulo:=Find in array:C230($at_UUID;"")
	While ($l_PosicionUUIDNulo>0)
		$l_recNum:=$al_RecNums{$l_PosicionUUIDNulo}
		READ WRITE:C146($y_tabla->)
		GOTO RECORD:C242($y_tabla->;$l_recNum)
		$y_campos{$i_campos}->:=Generate UUID:C1066
		SAVE RECORD:C53($y_tabla->)
		$l_PosicionUUIDNulo:=Find in array:C230($at_UUID;"";$l_PosicionUUIDNulo+1)
	End while 
	
	  // 1.4 busco los UUID que contienen guiones
	$l_PosicionUUIDNulo:=Find in array:C230($at_UUID;"@-@")
	While ($l_PosicionUUIDNulo>0)
		$l_recNum:=$al_RecNums{$l_PosicionUUIDNulo}
		READ WRITE:C146($y_tabla->)
		GOTO RECORD:C242($y_tabla->;$l_recNum)
		$y_campos{$i_campos}->:=Replace string:C233($y_campos{$i_campos}->;"-";"")
		SAVE RECORD:C53($y_tabla->)
		$l_PosicionUUIDNulo:=Find in array:C230($at_UUID;"@-@";$l_PosicionUUIDNulo+1)
	End while 
	
	  //FASE 2:  DETECCION DE UUID DUPLICADOS
	If (Table:C252($y_Tabla)=Table:C252(->[xShell_Reports:54]))
		  // en la tabla xShell reports solo considero los reportes no estandar
		  // (los UUID de los informes estandar son asignados en la Intranet)
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]IsStandard:38=False:C215)
		0xDev_DetectaDuplicados (->[xShell_Reports:54]UUID:47;False:C215)
	Else 
		ALL RECORDS:C47($y_tabla->)
		0xDev_DetectaDuplicados ($y_campos{$i_campos})
	End if 
	LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_RecNums;"")
	
	  // genero nuevos UUID en los registros para evitar duplicaciones
	For ($i_registros;1;Size of array:C274($al_RecNums))
		READ WRITE:C146($y_tabla->)
		GOTO RECORD:C242($y_tabla->;$al_RecNums{$i_registros})
		$y_campos{$i_campos}->:=Generate UUID:C1066
		SAVE RECORD:C53($y_tabla->)
	End for 
	
	KRL_UnloadReadOnly ($y_tabla)
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)

<>vb_ImportHistoricos_STX:=False:C215

