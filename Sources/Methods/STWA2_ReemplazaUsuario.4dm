//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 10-08-16, 16:02:55
  // ----------------------------------------------------
  // Método: STWA2_ReemplazaUsuario
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

$t_accion:=$1
C_BOOLEAN:C305(<>b_STWA2_Reemplazo)
Case of 
	: (Count parameters:C259=2)
		$uuid:=$2
	: (Count parameters:C259=3)
		$uuid:=$2
		$y_arreglo:=$3
End case 

Case of 
	: ($t_accion="inicializa")
		ARRAY TEXT:C222(atSTWA2_Usuario;0)
		ARRAY DATE:C224(adSTWA2_fechadesde;0)
		ARRAY DATE:C224(adSTWA2_fechahasta;0)
		ARRAY TEXT:C222(atSTWA2_Asignaturas;0)
		ARRAY TEXT:C222(atSTWA2_Remplaza;0)
		ARRAY TEXT:C222(atSTWA2_IDReemplaza;0)
		ARRAY TEXT:C222(atSTWA2_IDUsuario;0)
		ARRAY TEXT:C222(at_login;0)
		ARRAY LONGINT:C221(al_NoUsers;0)
		ARRAY LONGINT:C221(al_NoProfesor;0)
		ARRAY TEXT:C222(atSTWA2_AsignaturasID;0)
		
		$blob:=PREF_fGetBlob (0;"STWA2_REEMPLAZO")
		If (BLOB size:C605($blob)>0)
			BLOB_Blob2Vars (->$blob;0;->atSTWA2_Usuario;->adSTWA2_fechadesde;->adSTWA2_fechahasta;->atSTWA2_Asignaturas;->atSTWA2_Remplaza;->atSTWA2_IDReemplaza;->atSTWA2_IDUsuario;->atSTWA2_AsignaturasID)
		End if 
		<>b_STWA2_Reemplazo:=Choose:C955(PREF_fGet (0;"STWA2_REEMPLAZO";"NO")="SI";True:C214;False:C215)
		cb_habilitarReemplazo:=Choose:C955(<>b_STWA2_Reemplazo;1;0)
		LISTBOX SET ROWS HEIGHT:C835(lb_reemplazo;2;1)
		STWA2_ReemplazaUsuario ("CargaDatos")
	: ($t_accion="GuardarConfiguracionBlob")
		C_BLOB:C604($xblob)
		BLOB_Variables2Blob (->$xblob;0;->atSTWA2_Usuario;->adSTWA2_fechadesde;->adSTWA2_fechahasta;->atSTWA2_Asignaturas;->atSTWA2_Remplaza;->atSTWA2_IDReemplaza;->atSTWA2_IDUsuario;->atSTWA2_AsignaturasID)
		PREF_SetBlob (0;"STWA2_REEMPLAZO";$xblob)
		PREF_Set (0;"STWA2_REEMPLAZO";Choose:C955(<>b_STWA2_Reemplazo;"SI";"NO"))
		
		
	: ($t_accion="CargaDatos")
		ALL RECORDS:C47([xShell_Users:47])
		ORDER BY:C49([xShell_Users:47];[xShell_Users:47]login:9;>)
		SELECTION TO ARRAY:C260([xShell_Users:47]login:9;at_login;[xShell_Users:47]No:1;al_NoUsers;[xShell_Users:47]NoEmployee:7;al_NoProfesor)
		
	: ($t_accion="CargaUsuarioReemplazo")
		C_BOOLEAN:C305($b_reemplazo)
		ARRAY TEXT:C222($at_loginUsuario;0)
		ARRAY TEXT:C222($at_loginUsuarioID;0)
		ARRAY TEXT:C222($at_login;0)
		ARRAY TEXT:C222($at_loginID;0)
		
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=$userID)
		$t_userLogin:=[xShell_Users:47]login:9
		$b_reemplazo:=Choose:C955(PREF_fGet (0;"STWA2_REEMPLAZO";"NO")="SI";True:C214;False:C215)
		
		If ($b_reemplazo)
			$blob:=PREF_fGetBlob (0;"STWA2_REEMPLAZO")
			If (BLOB size:C605($blob)>0)
				BLOB_Blob2Vars (->$blob;0;->atSTWA2_Usuario;->adSTWA2_fechadesde;->adSTWA2_fechahasta;->atSTWA2_Asignaturas;->atSTWA2_Remplaza;->atSTWA2_IDReemplaza;->atSTWA2_IDUsuario;->atSTWA2_AsignaturasID)
				
				For ($i;1;Size of array:C274(atSTWA2_Usuario))
					If (atSTWA2_Usuario{$i}=$t_userLogin)
						If (adSTWA2_fechadesde{$i}<=Current date:C33(*))
							If (Current date:C33(*)<=adSTWA2_fechahasta{$i})
								AT_Text2Array (->$at_loginUsuario;atSTWA2_Remplaza{$i};"\r")
								AT_Text2Array (->$at_loginUsuarioID;atSTWA2_IDReemplaza{$i};"\r")
								For ($x;1;Size of array:C274($at_loginUsuario))
									APPEND TO ARRAY:C911($at_login;$at_loginUsuario{$x})
									APPEND TO ARRAY:C911($at_loginID;$at_loginUsuarioID{$x})
								End for 
							End if 
						End if 
					End if 
				End for 
				
				C_OBJECT:C1216($ob_raiz)
				If (Size of array:C274($at_login)>0)
					$ob_raiz:=OB_Create 
					OB_SET ($ob_raiz;->$at_login;"UsuarioLogin")
					OB_SET ($ob_raiz;->$at_loginID;"UsuarioLoginID")
					$json:=OB_Object2Json ($ob_raiz)
					$0:=$json
				Else 
					$ob_raiz:=OB_Create 
					OB_SET_Text ($ob_raiz;"1";"ERROR")
					$json:=OB_Object2Json ($ob_raiz)
					$0:=$json
				End if 
			Else 
				$ob_raiz:=OB_Create 
				OB_SET_Text ($ob_raiz;"1";"ERROR")
				$json:=OB_Object2Json ($ob_raiz)
				$0:=$json
			End if 
		Else 
			$ob_raiz:=OB_Create 
			OB_SET_Text ($ob_raiz;"1";"ERROR")
			$json:=OB_Object2Json ($ob_raiz)
			$0:=$json
		End if 
	: ($t_accion="cargaAsignaturasReemplazo")
		$t_filtrarAsig:="False"
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=$userID)
		For ($i;1;Size of array:C274(atSTWA2_Usuario))
			If (atSTWA2_Usuario{$i}=[xShell_Users:47]login:9)
				If (atSTWA2_Asignaturas{$i}#"")
					ARRAY TEXT:C222($at_AsignaturasReemplazo;0)
					AT_Text2Array (->$at_AsignaturasReemplazo;atSTWA2_AsignaturasID{$i};"\r")
					For ($x;1;Size of array:C274($at_AsignaturasReemplazo))
						APPEND TO ARRAY:C911($y_arreglo->;Num:C11($at_AsignaturasReemplazo{$x}))
					End for 
				End if 
			End if 
		End for 
		If (Size of array:C274($y_arreglo->)>0)
			$t_filtrarAsig:="True"
		End if 
		$0:=$t_filtrarAsig
		
	: ($t_accion="verificaUsuarioReemplazo")
		ARRAY LONGINT:C221($al_idUsuarios;0)
		C_OBJECT:C1216($ob_json)
		C_TEXT:C284($t_json)
		$t_json:=STWA2_ReemplazaUsuario ("CargaUsuarioReemplazo";$uuid)
		$ob_json:=OB_JsonToObject ($t_json)
		OB_GET ($ob_json;->$al_idUsuarios;"UsuarioLoginID")
		$y_arreglo->:=(Find in array:C230($al_idUsuarios;[Asignaturas:18]profesor_numero:4)#-1)
End case 


