C_OBJECT:C1216($ob_raiz)

ARRAY TEXT:C222($at_ArrayPreferenciaAlu;0)
ARRAY TEXT:C222($at_ArrayPreferenciaApoAca;0)
ARRAY TEXT:C222($at_ArrayPreferenciaApoCta;0)
ARRAY TEXT:C222($at_ArrayPreferenciaFamilia;0)
ARRAY TEXT:C222($at_ArrayPreferenciaMadre;0)
ARRAY TEXT:C222($at_ArrayPreferenciaPadre;0)

Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET TITLE:C194(*;"Encabezado@";"")
		
		$ob_raiz:=OB_Create 
		$ob_raiz:=PREF_fGetObject (0;"PrefImportacionAlu")
		
		If (Not:C34(Undefined:C82($ob_raiz)))
			OB_GET ($ob_Raiz;->$at_ArrayPreferenciaAlu;"alumno")
			OB_GET ($ob_Raiz;->$at_ArrayPreferenciaApoAca;"apo_aca")
			OB_GET ($ob_Raiz;->$at_ArrayPreferenciaApoCta;"apo_cta")
			OB_GET ($ob_Raiz;->$at_ArrayPreferenciaFamilia;"familia")
			OB_GET ($ob_Raiz;->$at_ArrayPreferenciaMadre;"padre")
			OB_GET ($ob_Raiz;->$at_ArrayPreferenciaPadre;"madre")
		End if 
		
		  //cargo los datos seleccionados en una impresióna anterior
		
		
		For ($i;1;Size of array:C274(ay_CampoAlumno))
			$t_nombreCampo:=Field name:C257(ay_CampoAlumno{$i})
			$l_pos:=Find in array:C230($at_ArrayPreferenciaAlu;$t_nombreCampo)
			If ($l_pos#-1)
				ab_seleccionadoAlumno{$i}:=True:C214
			End if 
		End for 
		
		
		For ($i;1;Size of array:C274(ay_CampoApoAca))
			$t_nombreCampo:=Field name:C257(ay_CampoApoAca{$i})
			$l_pos:=Find in array:C230($at_ArrayPreferenciaApoAca;$t_nombreCampo)
			If ($l_pos#-1)
				ab_seleccionadoApoAca{$i}:=True:C214
			End if 
		End for 
		
		
		For ($i;1;Size of array:C274(ay_CampoApoCta))
			$t_nombreCampo:=Field name:C257(ay_CampoApoCta{$i})
			$l_pos:=Find in array:C230($at_ArrayPreferenciaApoCta;$t_nombreCampo)
			If ($l_pos#-1)
				ab_seleccionadoApoCta{$i}:=True:C214
			End if 
		End for 
		
		For ($i;1;Size of array:C274(ay_CampoPadre))
			$t_nombreCampo:=Field name:C257(ay_CampoPadre{$i})
			$l_pos:=Find in array:C230($at_ArrayPreferenciaPadre;$t_nombreCampo)
			If ($l_pos#-1)
				ab_seleccionadoPadre{$i}:=True:C214
			End if 
		End for 
		
		For ($i;1;Size of array:C274(ay_CampoMadre))
			$t_nombreCampo:=Field name:C257(ay_CampoMadre{$i})
			$l_pos:=Find in array:C230($at_ArrayPreferenciaMadre;$t_nombreCampo)
			If ($l_pos#-1)
				ab_seleccionadoMadre{$i}:=True:C214
			End if 
		End for 
		
		For ($i;1;Size of array:C274(ay_CampoFamilia))
			$t_nombreCampo:=Field name:C257(ay_CampoFamilia{$i})
			$l_pos:=Find in array:C230($at_ArrayPreferenciaFamilia;$t_nombreCampo)
			If ($l_pos#-1)
				ab_seleccionadoFamilia{$i}:=True:C214
			End if 
		End for 
End case 

