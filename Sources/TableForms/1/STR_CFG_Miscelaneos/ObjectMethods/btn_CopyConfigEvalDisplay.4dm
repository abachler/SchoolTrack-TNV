  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
If (Form event:C388=On Clicked:K2:4)
	C_LONGINT:C283($l_resp;$i;$l_idTermometro)
	C_POINTER:C301($y_NivelesEvaGral;$y_displayEvaGral)
	If (l_lbNivPosSel#0)
		
		$y_NivelesEvaGral:=OBJECT Get pointer:C1124(Object named:K67:5;"SelAsigNiveles")
		$y_displayEvaGral:=OBJECT Get pointer:C1124(Object named:K67:5;"displayEvaGral")
		
		$l_resp:=CD_Dlog (1;__ ("¿Desea copiar la configuración de ")+$y_NivelesEvaGral->{$y_NivelesEvaGral->}+__ (" a los demás niveles?");"";"No";"Si")
		If ($l_resp=2)  //si
			
			$l_idTermometro:=IT_Progress (1;0;0;__ ("Copiando Configuración ..."))
			
			ARRAY TEXT:C222($at_configcopy;0)
			OB_GET (o_nomEvaGral;->$at_configcopy;String:C10(<>al_NumeroNivelesActivos{l_lbNivPosSel})+".display")
			
			For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
				OB_SET (o_nomEvaGral;->$at_configcopy;String:C10(<>al_NumeroNivelesActivos{$i})+".display")
				$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274(<>al_NumeroNivelesActivos);__ ("Copiando Configuración ..."))
			End for 
			$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
		End if 
	End if 
	
End if 