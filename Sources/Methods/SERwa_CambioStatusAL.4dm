//%attributes = {}
C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave;$t_useruuid)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
$t_useruuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"usuario")
$t_alumnouuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alumno")
$idAlumno:=KRL_GetNumericFieldData (->[Alumnos:2]auto_uuid:72;->$t_alumnouuid;->[Alumnos:2]numero:1)
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	$idProf:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_useruuid;->[Profesores:4]Numero:1)
	$idUser:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$idProf;->[xShell_Users:47]No:1)
	If (STWA2_Priv_GetMethodAccess ("AL_CambiaStatusAlumno";$idUser))
		If (KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno;True:C214)>-1)
			ARRAY TEXT:C222($at_status;0)
			For ($i;1;Size of array:C274(<>at_StatusAlumnoAlias))
				If (<>ab_StatusAlumnoVisible{$i})
					APPEND TO ARRAY:C911($at_status;<>at_StatusAlumnoAlias{$i})
				End if 
			End for 
			
			  //MONO 20180711 - Deshabilitación de status antes de pasar el array al string utilizado por "Pop up menu"
			If ([Alumnos:2]nivel_numero:29=Nivel_Egresados)
				For ($i;1;Size of array:C274($at_status))
					$at_status{$i}:="("+$at_status{$i}
				End for 
			Else 
				  //20150227 ASM  para no seleccionar dos el mismo estado. ya que producía un problema al retirar a los alumnos con o sin mantener en la lista (calculaba mal el numero de alumnos en el curso)
				$fia:=Find in array:C230(<>at_StatusAlumno;[Alumnos:2]Status:50)
				If ($fia>0)
					$t_estatusActual:=<>at_StatusAlumnoAlias{$fia}
					$fia:=Find in array:C230($at_status;$t_estatusActual)
					$l_itemSeleccionado:=$fia
					If ($fia>0)
						$at_status{$fia}:="("+$at_status{$fia}
					End if 
				End if 
				  //un alumno que no viene de admisión directa no puede egresarse manualmente debido a que esto para los alumnos "regulares" debe hacer un proceso de cierre
				If ([Alumnos:2]nivel_numero:29#Nivel_AdmisionDirecta)
					$fia:=Find in array:C230(<>at_StatusAlumno;"Egresado")
					If ($fia>0)
						$t_egresado:=<>at_StatusAlumnoAlias{$fia}
						$fia:=Find in array:C230($at_status;$t_egresado)
						If ($fia>0)
							$at_status{$fia}:="("+$at_status{$fia}
						End if 
					End if 
				End if 
			End if 
			
			$t_itemsMenu:=AT_array2text (->$at_status)
			If ($l_itemSeleccionado=-1)
				$l_itemSeleccionado:=0
			End if 
			C_OBJECT:C1216($obj)
			C_OBJECT:C1216($menu)
			C_OBJECT:C1216($menucolegios)
			OB SET:C1220($menu;"menudef";$t_itemsMenu)
			OB SET:C1220($menu;"seleccionado";$l_itemSeleccionado)
			OB SET:C1220($obj;"error";"0")
			OB SET:C1220($obj;"mensaje";"Autorizado")
			OB SET ARRAY:C1227($obj;"motivosretiro";<>aMotivosRetiro)
			C_BLOB:C604($x_blob)
			ARRAY TEXT:C222($aColegiosGrupo;0)
			SET BLOB SIZE:C606($x_blob;0)
			BLOB_Variables2Blob (->$x_blob;0;->$aColegiosGrupo)
			$x_blob:=PREF_fGetBlob (0;"colegiosgrupo";$x_blob)
			BLOB_Blob2Vars (->$x_blob;0;->$aColegiosGrupo)
			OB SET ARRAY:C1227($menucolegios;"colegiosgrupo";$aColegiosGrupo)
			OB SET ARRAY:C1227($menucolegios;"otrasinstituciones";<>APREVSCHOOL)
			OB SET:C1220($obj;"menu";$menu)
			OB SET:C1220($obj;"menucolegios";$menucolegios)
			$0:=OB_Object2Json ($obj)
		Else 
			$0:=SERwa_GeneraRespuesta ("-2";"Alumno no encontrado.")
		End if 
	Else 
		$0:=SERwa_GeneraRespuesta ("-1";"Lo siento, Ud. no está autorizado para utilizar esta función.")
	End if 
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 