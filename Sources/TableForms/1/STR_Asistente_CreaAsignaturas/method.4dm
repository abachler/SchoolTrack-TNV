Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		xALSet_STR_AsistenteAsignaturas 
		
		C_LONGINT:C283(hl_CopiarDesdeNivel)
		HL_ClearList (hl_CopiarDesdeNivel)
		hl_CopiarDesdeNivel:=New list:C375
		APPEND TO LIST:C376(hl_CopiarDesdeNivel;"Seleccionar...";-MAXLONG:K35:2)
		For ($i;1;Size of array:C274(<>al_NumeroNivelesOficiales))
			  //If ((<>al_NumeroNivelesOficiales{$i}>=1) & (<>al_NumeroNivelesOficiales{$i}<=12)) Ticket 168331 ASM 20160929
			APPEND TO LIST:C376(hl_CopiarDesdeNivel;<>at_NombreNivelesOficiales{$i};<>al_NumeroNivelesOficiales{$i})
			  //End if 
		End for 
		SELECT LIST ITEMS BY POSITION:C381(hl_CopiarDesdeNivel;1)
		
		If (vb_FirstInstall)
		Else 
		End if 
		  //For ($i;1;Size of array(<>al_NumeroNivelesOficiales))
		  //If (<>al_NumeroNivelesOficiales{$i}>=1)
		  //<>al_NumeroNivelesOficiales:=$i-1
		  //<>at_NombreNivelesOficiales:=$i-1
		  //vl_FirstNivel:=$i
		  //$i:=Size of array(<>al_NumeroNivelesOficiales)
		  //End if 
		  //End for 
		  //Ticket 168331 ASM 20160929
		<>al_NumeroNivelesOficiales:=0
		vl_FirstNivel:=0
		POST KEY:C465(Character code:C91("+");256)
	: (Form event:C388=On Clicked:K2:4)
		
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_CopiarDesdeNivel)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
