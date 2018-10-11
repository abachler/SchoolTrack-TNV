C_LONGINT:C283($line;$col;$fia;$l_rn)
C_POINTER:C301($y_field)
C_TEXT:C284($value)
LISTBOX GET CELL POSITION:C971(LB_AluIdioma;$col;$line)

Case of 
	: ((Form event:C388=On Data Change:K2:15) & (($line>0) & ($line<=Size of array:C274(a_LB_AADIAP_asignatura))))
		
		Case of 
			: ($col=2)
				$y_field:=->[DIAP_AlumnosIdiomas:218]Codigo:3
				$value:=a_LB_Aidioma_Codigo{$line}
				
			: ($col=3)
				$y_field:=->[DIAP_AlumnosIdiomas:218]Descripcion_Aleman:4
				$value:=a_LB_Aidioma_DesAleman{$line}
				
			: ($col=4)
				$y_field:=->[DIAP_AlumnosIdiomas:218]Descripcion_Español:5
				$value:=a_LB_Aidioma_DesEspañol{$line}
				
			: ($col=5)
				$y_field:=->[DIAP_AlumnosIdiomas:218]NumeroNivel_Desde:6
				$value:=String:C10(a_LB_Aidioma_NivelDesde{$line})
				
			: ($col=6)
				$y_field:=->[DIAP_AlumnosIdiomas:218]NumeroNivel_Hasta:7
				$value:=String:C10(a_LB_Aidioma_NivelHasta{$line})
				
		End case 
		
		
		DIAP_GuardaInscripcionIdioma (a_LB_Aidioma_UUID{$line};$y_field;$value)
		
End case 