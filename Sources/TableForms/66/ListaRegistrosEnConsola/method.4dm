  // [BBL_Registros].ListaEnConsola()
  // Por: Alberto Bachler K.: 19-02-14, 06:44:51
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_selected)

Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"Línea@";0x00CDE3F1;0x00DDEEFB)
		OBJECT SET VISIBLE:C603(*;"accion@";False:C215)
		OBJECT SET RGB COLORS:C628(*;"Rectangulo1";0x00D5E9FB;0x00D5E9FB)
		OBJECT SET RGB COLORS:C628(*;"imagen";0x00FFFFFF;0x00FFFFFF)
		
	: (Form event:C388=On Double Clicked:K2:5)
		
	: (Form event:C388=On Unload:K2:2)
		$l_selected:=Selected record number:C246([BBL_Prestamos:60])
		GOTO SELECTED RECORD:C245([BBL_Prestamos:60];$l_selected)
		
	: (Form event:C388=On Selection Change:K2:29)
		
	: (Form event:C388=On Display Detail:K2:22)
		C_POINTER:C301($y_variableImagen)
		
		OBJECT SET VISIBLE:C603(*;"rectangulo1";False:C215)
		OBJECT SET TITLE:C194(*;"numeroCopia";"")
		OBJECT SET TITLE:C194(*;"lugar";"")
		OBJECT SET TITLE:C194(*;"notaAlerta";"")
		ModernUI_SetTextAttributes ("numeroCopia";Plain:K14:1;12;0)
		ModernUI_SetTextAttributes ("lugar";Plain:K14:1;12;0)
		
		If (Record number:C243([BBL_Registros:66])>No current record:K29:2)
			
			$l_idxRefLugar:=Find in array:C230(<>aPlaceCode;[BBL_Registros:66]Lugar:13)
			Case of 
				: ($l_idxRefLugar>0)
					$t_lugar:=<>aPlace{$l_idxRefLugar}
				: (<>gBBL_NombreBiblioteca#"")
					$t_lugar:=<>gBBL_NombreBiblioteca
				Else 
					$t_lugar:=__ ("Ubicación desconocida")
			End case 
			
			OBJECT SET TITLE:C194(*;"l_recNumRegistro";String:C10(Record number:C243([BBL_Registros:66])))
			OBJECT SET TITLE:C194(*;"l_selectedRecord";String:C10(Selected record number:C246([BBL_Registros:66])))
			OBJECT SET TITLE:C194(*;"numeroCopia";__ ("Copia Nº ")+String:C10([BBL_Registros:66]Número_de_copia:2))
			OBJECT SET TITLE:C194(*;"lugar";__ ("Disponible en: ")+$t_lugar)
			OBJECT SET TITLE:C194(*;"notaAlerta";[BBL_Registros:66]NotaDeAlerta:29)
			$y_variableImagen:=OBJECT Get pointer:C1124(Object named:K67:5;"imagen")
			$y_variableImagen->:=[BBL_Registros:66]CodigoBarra_Imagen:24
			
		End if 
		
End case 

BBL_LeeConfiguracion 


