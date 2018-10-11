  // [Asignaturas].Input.$botonOrdenColumnas()
  // Por: Alberto Bachler K.: 02-02-14, 17:13:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_columnas;$l_BloqueoColumna;$l_posicionBloqueo;$l_colorConFoco;$l_ColorSinFoco)
C_TEXT:C284($t_items)

ARRAY LONGINT:C221($al_Ordenamientos;0)
ARRAY LONGINT:C221($al_visible;0)
ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_Items;0)
ARRAY LONGINT:C221($al_columnas;0)

$l_colorConFoco:=0x0000
$l_ColorSinFoco:=0x0000 | (120 << 16) | (120 << 8) | 120

AL_ExitCell (xALP_ASNotas)


Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET RGB COLORS:C628(*;OBJECT Get name:C1087(Object current:K67:2);$l_colorConFoco;Background color none:K23:10)
		
	: (Form event:C388=On Mouse Leave:K2:34)
		OBJECT SET RGB COLORS:C628(*;OBJECT Get name:C1087(Object current:K67:2);$l_ColorSinFoco;Background color none:K23:10)
		
	: (Form event:C388=On Clicked:K2:4)
		AL_GetObjects (xALP_ASNotas;ALP_Object_HeaderText;$at_encabezados)
		AL_GetObjects (xALP_ASNotas;ALP_Object_Visible;$al_visible)
		AL_GetObjects (xALP_ASNotas;ALP_Object_SortList;$al_Ordenamientos)
		$l_BloqueoColumna:=AL_GetAreaLongProperty (xALP_ASNotas;ALP_Area_ColsLocked)
		
		$t_items:=""
		$l_posicionBloqueo:=0
		  // 20181008 Patricio Aliaga Ticket N° 204363
		C_OBJECT:C1216($o_obj;$o_in)
		OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
		$o_obj:=STR_ordenNominas ("query";$o_in)
		  //If (<>viSTR_AgruparPorSexo=1)
		If (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
			APPEND TO ARRAY:C911($at_Items;"Sexo")
			APPEND TO ARRAY:C911($al_columnas;Size of array:C274($at_encabezados)-1)
		End if 
		
		For ($i_columnas;1;Size of array:C274($at_encabezados))
			If ($al_visible{$i_columnas}=1)
				APPEND TO ARRAY:C911($at_Items;$at_encabezados{$i_columnas})
				APPEND TO ARRAY:C911($al_columnas;$i_columnas)
			End if 
		End for 
		
		INSERT IN ARRAY:C227($al_columnas;$l_BloqueoColumna+1)
		INSERT IN ARRAY:C227($at_Items;$l_BloqueoColumna+1)
		$al_columnas{$l_BloqueoColumna+1}:=0
		$at_Items{$l_BloqueoColumna+1}:="(-"
		
		$l_primerOrdenamiento:=Find in array:C230($al_columnas;Abs:C99($al_Ordenamientos{1}))
		If ($l_primerOrdenamiento#-1)
			$at_Items{$l_primerOrdenamiento}:="!"+Char:C90(18)+$at_Items{$l_primerOrdenamiento}
		End if 
		APPEND TO ARRAY:C911($at_Items;"(-")
		APPEND TO ARRAY:C911($al_columnas;0)
		
		APPEND TO ARRAY:C911($al_columnas;0)
		If ($al_Ordenamientos{1}>0)
			APPEND TO ARRAY:C911($at_Items;"!"+Char:C90(18)+"Ascendente")
		Else 
			APPEND TO ARRAY:C911($at_Items;"Ascendente")
		End if 
		
		APPEND TO ARRAY:C911($al_columnas;0)
		If ($al_Ordenamientos{1}<0)
			APPEND TO ARRAY:C911($at_Items;"!"+Char:C90(18)+"Descendente")
		Else 
			APPEND TO ARRAY:C911($at_Items;"Descendente")
		End if 
		
		
		$l_resultado:=Pop up menu:C542(AT_array2text (->$at_Items;";"))
		
		Case of 
			: ($l_resultado=(Size of array:C274($at_Items)-1))
				$al_Ordenamientos{1}:=Abs:C99($al_Ordenamientos{1})
			: ($l_resultado=Size of array:C274($at_Items))
				$al_Ordenamientos{1}:=-Abs:C99($al_Ordenamientos{1})
			: ($l_resultado>0)
				$al_Ordenamientos{1}:=$al_columnas{$l_resultado}
		End case 
		
		
		AL_SetObjects (xALP_ASNotas;ALP_Object_SortList;$al_Ordenamientos)
		AS_OpcionesPaginaEvaluacion 
End case 



