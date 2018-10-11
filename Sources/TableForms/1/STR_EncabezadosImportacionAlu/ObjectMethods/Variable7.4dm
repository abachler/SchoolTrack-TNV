C_LONGINT:C283($i)
C_TEXT:C284($t_ruta;$t_rutaCarpetaDocumentos;$t_texto)

ARRAY TEXT:C222($at_ArrayPreferenciaAlu;0)
ARRAY TEXT:C222($at_ArrayPreferenciaApoAca;0)
ARRAY TEXT:C222($at_ArrayPreferenciaApoCta;0)
ARRAY TEXT:C222($at_ArrayPreferenciaFamilia;0)
ARRAY TEXT:C222($at_ArrayPreferenciaMadre;0)
ARRAY TEXT:C222($at_ArrayPreferenciaPadre;0)


If (SYS_IsWindows )
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";0)
End if 
  //ABC // 20180315//TKT201105
$t_rutaCarpetaDocumentos:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ST)+"Importacion de alumnos"+SYS_FolderDelimiter 
CREATE FOLDER:C475($t_rutaCarpetaDocumentos;*)
$t_ruta:=$t_rutaCarpetaDocumentos+"STR_ImportacionAlumnos_"+DTS_Get_GMT_TimeStamp +".txt"

$t_texto:=""
$h_ref:=Create document:C266($t_ruta;"txt")
If ($h_ref#?00:00:00?)
	  //exporto los datos seleccionados de Alumnos
	For ($i;1;Size of array:C274(ab_seleccionadoAlumno))
		If (ab_seleccionadoAlumno{$i})
			$t_texto:=$t_texto+at_nombreCampoAlumnotxt{$i}+"\t"
			APPEND TO ARRAY:C911($at_ArrayPreferenciaAlu;Field name:C257(ay_CampoAlumno{$i}))
		End if 
	End for 
	
	  //exporto los datos seleccionados de Padre
	For ($i;1;Size of array:C274(ab_seleccionadoPadre))
		If (ab_seleccionadoPadre{$i})
			$t_texto:=$t_texto+at_nombreCampoPadretxt{$i}+"\t"
			APPEND TO ARRAY:C911($at_ArrayPreferenciaPadre;Field name:C257(ay_CampoPadre{$i}))
		End if 
	End for 
	
	  //exporto los datos seleccionados de Madre
	For ($i;1;Size of array:C274(ab_seleccionadoMadre))
		If (ab_seleccionadoMadre{$i})
			$t_texto:=$t_texto+at_nombreCampoMadretxt{$i}+"\t"
			APPEND TO ARRAY:C911($at_ArrayPreferenciaMadre;Field name:C257(ay_CampoMadre{$i}))
		End if 
	End for 
	
	  //exporto los datos seleccionados de Apoderado cuentas
	For ($i;1;Size of array:C274(ab_seleccionadoApoCta))
		If (ab_seleccionadoApoCta{$i})
			$t_texto:=$t_texto+at_nombreCampoApoCtatxt{$i}+"\t"
			APPEND TO ARRAY:C911($at_ArrayPreferenciaApoCta;Field name:C257(ay_CampoApoCta{$i}))
		End if 
	End for 
	
	  //exporto los datos seleccionados de Apoderado Acadmemico
	For ($i;1;Size of array:C274(ab_seleccionadoApoAca))
		If (ab_seleccionadoApoAca{$i})
			$t_texto:=$t_texto+at_nombreCampoApoAcatxt{$i}+"\t"
			APPEND TO ARRAY:C911($at_ArrayPreferenciaApoAca;Field name:C257(ay_CampoApoAca{$i}))
		End if 
	End for 
	
	  //exporto los datos seleccionados de Apoderado familia
	For ($i;1;Size of array:C274(ab_seleccionadoFamilia))
		If (ab_seleccionadoFamilia{$i})
			$t_texto:=$t_texto+at_nombreCampoFamiliatxt{$i}+"\t"
			APPEND TO ARRAY:C911($at_ArrayPreferenciaFamilia;Field name:C257(ay_CampoFamilia{$i}))
		End if 
	End for 
End if 


IO_SendPacket ($h_ref;$t_texto+"\r")
USE CHARACTER SET:C205(*;0)
CLOSE DOCUMENT:C267($h_ref)
ACTcd_DlogWithShowOnDisk ($t_ruta;0;__ ("La exportación del archivo ha concluido.")+"\r\r"+__ ("La encontrará en: ")+"\r"+SYS_GetParentNme ($t_ruta)+"\r\r"+__ ("Le recomendamos abrirla con Microsoft Excel."))

C_OBJECT:C1216($ob_Raiz)
$ob_Raiz:=OB_Create 
OB_SET ($ob_Raiz;->$at_ArrayPreferenciaAlu;"alumno")
OB_SET ($ob_Raiz;->$at_ArrayPreferenciaApoAca;"apo_aca")
OB_SET ($ob_Raiz;->$at_ArrayPreferenciaApoCta;"apo_cta")
OB_SET ($ob_Raiz;->$at_ArrayPreferenciaFamilia;"familia")
OB_SET ($ob_Raiz;->$at_ArrayPreferenciaMadre;"padre")
OB_SET ($ob_Raiz;->$at_ArrayPreferenciaPadre;"madre")
PREF_SetObject (0;"PrefImportacionAlu";$ob_Raiz)

CANCEL:C270




