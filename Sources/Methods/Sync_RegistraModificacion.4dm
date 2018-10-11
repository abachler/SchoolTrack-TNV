//%attributes = {"executedOnServer":true}
  // Sync_RegistraModificacion()
  // Por: Alberto Bachler K.: 19-01-15, 17:30:26
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_BLOB:C604($x_Blob;$x_blobAnterior)
C_BOOLEAN:C305($b_RegistrarCambio;$b_SincronizarTodo)
_O_C_INTEGER:C282($i_campos)
C_LONGINT:C283($l_Campo;$l_recNum;$l_tabla;$l_tipo;$l_tipoCampo)
C_PICTURE:C286($p_diferencia;$p_imagenAnterior)
C_POINTER:C301($y_Campo;$y_uuid)
C_TEXT:C284($t_codificacion;$t_primaryKey;$t_uuid;$t_valor)

C_BOOLEAN:C305(<>b_sincronizar)
If (False:C215)
	C_POINTER:C301(Sync_RegistraModificacion ;$1)
	C_TEXT:C284(Sync_RegistraModificacion ;$2)
End if 

If (Size of array:C274(<>ay_syncronizacion)<Get last table number:C254)
	Sync_LeeRefSincronizacion 
End if 

While (Test semaphore:C652("LecturaRefSincronizacion"))
	DELAY PROCESS:C323(Current process:C322;10)
End while 

$b_semaforoPuesto:=Semaphore:C143("Sync_RegistrandoModificacion")

  //Mono 25-05-16, esta preferencia se llena al finalizar la ejecucion de CONDOR_ExportData
  //también se marca esta preferencia en la actualización UD_v20160525_SyncPrefRegCambios
  // si el colegio cuenta con algún módulo Condor licenciado 
If (PREF_fGet (0;"SYNC_RegistrarCambios";"False")="True")
	$y_uuid:=$1
	Case of 
		: (Count parameters:C259=2)
			$t_uuid:=$2
		: (Count parameters:C259=3)
			$t_uuid:=$2
			$b_SincronizarTodo:=$3
	End case 
	If ($t_uuid="")
		$t_uuid:=$y_uuid->
	End if 
	$l_tabla:=Table:C252($y_uuid)
	
	$b_SincronizarTodo:=$b_SincronizarTodo | (Trigger event:C369=On Saving New Record Event:K3:1)  //Mandamos todo solo cuando son registros nuevos o forzado desde afuera
	$l_camposSincronizables:=Size of array:C274(<>ay_syncronizacion{$l_tabla})
	If (Trigger event:C369=On Deleting Record Event:K3:3)
		READ WRITE:C146([sync_Modificaciones:284])
		  //MONO 162358
		  //$t_primaryKey:=<>t_nombreBDCondor+"."+String($l_tabla)+".0"+"."+$t_uuid
		$t_primaryKey:=String:C10($l_tabla)+".0"+"."+$t_uuid
		$l_recNum:=Find in field:C653([sync_Modificaciones:284]st_pkey:17;$t_primaryKey)
		If ($l_recNum=No current record:K29:2)
			CREATE RECORD:C68([sync_Modificaciones:284])
			[sync_Modificaciones:284]uuid_colegio:21:=<>GUUID
			[sync_Modificaciones:284]st_tabla:6:=$l_tabla
			[sync_Modificaciones:284]st_campo:7:=0
			[sync_Modificaciones:284]st_tipo4d:10:=0
			[sync_Modificaciones:284]uuid_registro:11:=$t_uuid
			[sync_Modificaciones:284]st_pkey:17:=$t_primaryKey
		Else 
			GOTO RECORD:C242([sync_Modificaciones:284];$l_recNum)
		End if 
		[sync_Modificaciones:284]modificadost:15:=True:C214
		[sync_Modificaciones:284]version:13:=[sync_Modificaciones:284]version:13+1
		[sync_Modificaciones:284]dts:16:=String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178)
		[sync_Modificaciones:284]nuevoValor:12:="TRUE"
		Case of 
			: ($l_tabla=Table:C252(->[Personas:7]))
				[sync_Modificaciones:284]uuid_persona:22:=$t_uuid
				If ([Personas:7]RUT:6#"")
					[sync_Modificaciones:284]uuid_profesor:23:=KRL_GetTextFieldData (->[Profesores:4]RUT:27;->[Personas:7]RUT:6;->[Profesores:4]Auto_UUID:41)
					[sync_Modificaciones:284]uuid_alumno:24:=KRL_GetTextFieldData (->[Alumnos:2]RUT:5;->[Personas:7]RUT:6;->[Alumnos:2]auto_uuid:72)
				Else 
					[sync_Modificaciones:284]uuid_profesor:23:=""
					[sync_Modificaciones:284]uuid_alumno:24:=""
				End if 
			: ($l_tabla=Table:C252(->[Profesores:4]))
				[sync_Modificaciones:284]uuid_profesor:23:=$t_uuid
				If ([Profesores:4]RUT:27#"")
					[sync_Modificaciones:284]uuid_persona:22:=KRL_GetTextFieldData (->[Personas:7]RUT:6;->[Profesores:4]RUT:27;->[Personas:7]Auto_UUID:36)
					[sync_Modificaciones:284]uuid_alumno:24:=KRL_GetTextFieldData (->[Alumnos:2]RUT:5;->[Profesores:4]RUT:27;->[Alumnos:2]auto_uuid:72)
				Else 
					[sync_Modificaciones:284]uuid_persona:22:=""
					[sync_Modificaciones:284]uuid_alumno:24:=""
				End if 
			: ($l_tabla=Table:C252(->[Alumnos:2]))
				[sync_Modificaciones:284]uuid_alumno:24:=$t_uuid
				If ([Alumnos:2]RUT:5#"")
					[sync_Modificaciones:284]uuid_persona:22:=KRL_GetTextFieldData (->[Personas:7]RUT:6;->[Alumnos:2]RUT:5;->[Personas:7]Auto_UUID:36)
					[sync_Modificaciones:284]uuid_profesor:23:=KRL_GetTextFieldData (->[Profesores:4]RUT:27;->[Alumnos:2]RUT:5;->[Profesores:4]Auto_UUID:41)
				Else 
					[sync_Modificaciones:284]uuid_persona:22:=""
					[sync_Modificaciones:284]uuid_profesor:23:=""
				End if 
		End case 
		Sync_GuardaRegistro 
		KRL_UnloadReadOnly (->[sync_Modificaciones:284])
	Else 
		For ($i_campos;1;$l_camposSincronizables)
			$y_campo:=<>ay_syncronizacion{$l_tabla}{$i_campos}
			$l_campo:=Field:C253($y_campo)
			$l_tipoCampo:=Type:C295($y_campo->)
			$b_RegistrarCambio:=False:C215
			Case of 
				: ($l_tipoCampo=Is picture:K8:10)
					$p_imagenAnterior:=Old:C35($y_campo->)
					If ($b_SincronizarTodo)
						$b_RegistrarCambio:=True:C214
					Else 
						If ((Picture size:C356($p_imagenAnterior)#0) | (Picture size:C356($y_campo->)#0))
							If (Not:C34(Equal pictures:C1196($p_imagenAnterior;$y_campo->;$p_diferencia)))
								$b_RegistrarCambio:=True:C214
							End if 
						End if 
					End if 
					
				: ($l_tipoCampo=Is BLOB:K8:12)
					$x_blobAnterior:=Old:C35($y_campo->)
					If ((API Compare Blobs ($x_blobAnterior;$y_campo->)=0) | ($b_SincronizarTodo))
						$b_RegistrarCambio:=True:C214
					End if 
					
				: (($l_tipoCampo=Is alpha field:K8:1) | ($l_tipoCampo=Is text:K8:3))
					If ((Not:C34(ST_SonTextosIdenticos (Old:C35($y_Campo->);$y_Campo->))) | ($b_SincronizarTodo))
						$b_RegistrarCambio:=True:C214
					End if 
					
				: ((Old:C35($y_Campo->)#$y_campo->) | ($b_SincronizarTodo))
					$b_RegistrarCambio:=True:C214
					
				Else 
					$b_RegistrarCambio:=False:C215
			End case 
			
			If ($b_RegistrarCambio)
				READ WRITE:C146([sync_Modificaciones:284])
				  //MONO 162358
				  //$t_primaryKey:=<>t_nombreBDCondor+"."+String($l_tabla)+"."+String($l_Campo)+"."+$t_uuid
				$t_primaryKey:=String:C10($l_tabla)+"."+String:C10($l_Campo)+"."+$t_uuid
				$l_recNum:=Find in field:C653([sync_Modificaciones:284]st_pkey:17;$t_primaryKey)
				If ($l_recNum=No current record:K29:2)
					CREATE RECORD:C68([sync_Modificaciones:284])
					[sync_Modificaciones:284]st_tabla:6:=$l_tabla
					[sync_Modificaciones:284]st_campo:7:=$l_campo
					[sync_Modificaciones:284]st_tipo4d:10:=$l_tipoCampo
					[sync_Modificaciones:284]uuid_registro:11:=$t_uuid
					[sync_Modificaciones:284]st_pkey:17:=$t_primaryKey
				Else 
					GOTO RECORD:C242([sync_Modificaciones:284];$l_recNum)
				End if 
				Case of 
					: ($l_tabla=Table:C252(->[Personas:7]))
						[sync_Modificaciones:284]uuid_persona:22:=$t_uuid
						If ([Personas:7]RUT:6#"")
							[sync_Modificaciones:284]uuid_profesor:23:=KRL_GetTextFieldData (->[Profesores:4]RUT:27;->[Personas:7]RUT:6;->[Profesores:4]Auto_UUID:41)
							[sync_Modificaciones:284]uuid_alumno:24:=KRL_GetTextFieldData (->[Alumnos:2]RUT:5;->[Personas:7]RUT:6;->[Alumnos:2]auto_uuid:72)
						Else 
							[sync_Modificaciones:284]uuid_profesor:23:=""
							[sync_Modificaciones:284]uuid_alumno:24:=""
						End if 
					: ($l_tabla=Table:C252(->[Profesores:4]))
						[sync_Modificaciones:284]uuid_profesor:23:=$t_uuid
						If ([Profesores:4]RUT:27#"")
							[sync_Modificaciones:284]uuid_persona:22:=KRL_GetTextFieldData (->[Personas:7]RUT:6;->[Profesores:4]RUT:27;->[Personas:7]Auto_UUID:36)
							[sync_Modificaciones:284]uuid_alumno:24:=KRL_GetTextFieldData (->[Alumnos:2]RUT:5;->[Profesores:4]RUT:27;->[Alumnos:2]auto_uuid:72)
						Else 
							[sync_Modificaciones:284]uuid_persona:22:=""
							[sync_Modificaciones:284]uuid_alumno:24:=""
						End if 
					: ($l_tabla=Table:C252(->[Alumnos:2]))
						[sync_Modificaciones:284]uuid_alumno:24:=$t_uuid
						If ([Alumnos:2]RUT:5#"")
							[sync_Modificaciones:284]uuid_persona:22:=KRL_GetTextFieldData (->[Personas:7]RUT:6;->[Alumnos:2]RUT:5;->[Personas:7]Auto_UUID:36)
							[sync_Modificaciones:284]uuid_profesor:23:=KRL_GetTextFieldData (->[Profesores:4]RUT:27;->[Alumnos:2]RUT:5;->[Profesores:4]Auto_UUID:41)
						Else 
							[sync_Modificaciones:284]uuid_persona:22:=""
							[sync_Modificaciones:284]uuid_profesor:23:=""
						End if 
				End case 
				[sync_Modificaciones:284]modificadost:15:=True:C214
				[sync_Modificaciones:284]version:13:=[sync_Modificaciones:284]version:13+1
				[sync_Modificaciones:284]dts:16:=String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178)
				$nuevovalor:=""
				$modificado:=dhSync_HandleSendingChanges ($y_Campo;->$nuevovalor)
				If (Not:C34($modificado))
					Case of 
						: ($l_tipoCampo=Is picture:K8:10)
							PICTURE TO BLOB:C692($y_campo->;$x_Blob;".jpg")
							BASE64 ENCODE:C895($x_blob;$t_codificacion)
							[sync_Modificaciones:284]nuevoValor:12:=$t_codificacion
							
						: ($l_tipoCampo=Is BLOB:K8:12)
							BASE64 ENCODE:C895($y_campo->;$t_codificacion)
							[sync_Modificaciones:284]nuevoValor:12:=$t_codificacion
							
						: ($l_tipoCampo=Is boolean:K8:9)
							[sync_Modificaciones:284]nuevoValor:12:=String:C10(Num:C11($y_Campo->))
							
						: ($l_tipoCampo=Is date:K8:7)
							[sync_Modificaciones:284]nuevoValor:12:=SN3_MakeDateInmune2LocalFormat ($y_Campo->)
							
						: (($l_tipoCampo#Is alpha field:K8:1) & ($l_tipoCampo#Is text:K8:3))
							[sync_Modificaciones:284]nuevoValor:12:=String:C10($y_Campo->)
							
						Else 
							[sync_Modificaciones:284]nuevoValor:12:=$y_Campo->
					End case 
				Else 
					[sync_Modificaciones:284]nuevoValor:12:=$nuevovalor
				End if 
				If ([sync_Modificaciones:284]nuevoValor:12#Old:C35([sync_Modificaciones:284]nuevoValor:12))
					Sync_GuardaRegistro 
				End if 
			End if 
		End for 
		KRL_UnloadReadOnly (->[sync_Modificaciones:284])
	End if 
End if 

CLEAR SEMAPHORE:C144("Sync_RegistrandoModificacion")