//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 16-06-18, 13:41:34
  // ----------------------------------------------------
  // Método: STWA2_CreaImagenAlumnosEnDisco
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------


C_BLOB:C604($x_blob)
C_LONGINT:C283($l_indice;$l_ok;$l_progress)
C_TEXT:C284($t_accion;$t_rutaArchivo;$t_rutaCarpeta;$t_rutaEstructura;$t_uuidALumno)

ARRAY PICTURE:C279($ap_fotografias;0)
ARRAY TEXT:C222($at_UUIDAlumnos;0)

READ ONLY:C145([Alumnos:2])

$t_accion:=$1
$t_uuidALumno:=""

If (Count parameters:C259=2)
	$t_uuidALumno:=$2
End if 

Case of 
	: ($t_accion="ExportarTodo")
		C_BLOB:C604($x_blob)
		
		$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaCarpeta:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images"+SYS_FolderDelimiterOnServer +"alumnos"
		SYS_CreaCarpetaServidor ($t_rutaCarpeta)
		
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
		KRL_RelateSelection (->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]NoNivel:5;"")
		SELECTION TO ARRAY:C260([Alumnos:2]Fotografía:78;$ap_fotografias;[Alumnos:2]auto_uuid:72;$at_UUIDAlumnos)
		KRL_UnloadReadOnly (->[Alumnos:2])
		
		$l_progress:=IT_Progress (1;0;0;"Exportando fotografías de alumnos para STWA")
		For ($l_indice;1;Size of array:C274($ap_fotografias))
			$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($ap_fotografias);"Exportando fotografías de alumnos para STWA")
			If (Picture size:C356($ap_fotografias{$l_indice})>0)
				$t_rutaArchivo:=$t_rutaCarpeta+SYS_FolderDelimiterOnServer +$at_UUIDAlumnos{$l_indice}+".jpg"
				PICTURE TO BLOB:C692($ap_fotografias{$l_indice};$x_blob;".jpg")
				KRL_SendFileToServer ($t_rutaArchivo;$x_blob;True:C214)
			End if 
		End for 
		$l_progress:=IT_Progress (-1;$l_progress)
		
	: ($t_accion="creaUrlImagenAlumno")
		
		$l_ok:=0
		If (Picture size:C356([Alumnos:2]Fotografía:78)>0)
			$0:="images/alumnos/"+$t_uuidALumno+".jpg"
		Else 
			$0:="images_mobile/user-no-picture.png"
		End if 
		
	: ($t_accion="actualizaImagen")
		$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaCarpeta:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images"+SYS_FolderDelimiterOnServer +"alumnos"
		$t_rutaArchivo:=$t_rutaCarpeta+SYS_FolderDelimiterOnServer +$t_uuidALumno+".jpg"
		If (Picture size:C356([Alumnos:2]Fotografía:78)>0)
			PICTURE TO BLOB:C692([Alumnos:2]Fotografía:78;$x_blob;".jpg")
			KRL_SendFileToServer ($t_rutaArchivo;$x_blob;True:C214)
		End if 
		
	: ($t_accion="eliminaCarpeta")
		$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaCarpeta:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images"+SYS_FolderDelimiterOnServer +"alumnos"
		$l_OK:=1
		If (Test path name:C476($t_rutaCarpeta)=Is a folder:K24:2)
			SYS_DeleteFolderOnServer ($t_rutaCarpeta;1)
			$l_OK:=1
		End if 
		$0:=String:C10($l_OK)
		
	: ($t_accion="eliminaImagen")
		$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaCarpeta:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images"+SYS_FolderDelimiterOnServer +"alumnos"
		$t_rutaArchivo:=$t_rutaCarpeta+SYS_FolderDelimiterOnServer +$t_uuidALumno+".jpg"
		If (Test path name:C476($t_rutaArchivo)=Is a document:K24:1)
			SYS_DeleteFolderOnServer ($t_rutaArchivo;1)
		End if 
		
	: ($t_accion="VerificaDirectorio")  //20180817 RCH Para verificar en caso que cambien de server sin actualizar ST
		If (Application type:C494#4D Remote mode:K5:5)
			$t_rutaEstructura:=SYS_CarpetaAplicacion (CLG_Estructura)
			$t_rutaCarpeta:=$t_rutaEstructura+"Carpeta Web"+SYS_FolderDelimiterOnServer +"stwa"+SYS_FolderDelimiterOnServer +"images"+SYS_FolderDelimiterOnServer +"alumnos"
			If (Test path name:C476($t_rutaCarpeta)#Is a folder:K24:2)
				STWA2_CreaImagenAlumnosEnDisco ("ExportarTodo")
			End if 
		End if 
End case 


