  // [xxSTR_Constants].STR_CFG_InformesEspeciales()
  // Por: Alberto Bachler K.: 25-03-14, 09:22:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($hl_nivelesActivos;$hl_nivelesOficiales;$hl_tiposInformeNotas;$i)

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetConfigInterface 
		
		C_LONGINT:C283(hl_CopiarDesdeNivel)
		$hl_nivelesInformeParciales:=New list:C375
		$hl_nivelesInformeFinPeriodo:=New list:C375
		$hl_nivelesInformeSintesis:=New list:C375
		For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
			APPEND TO LIST:C376($hl_nivelesInformeParciales;<>at_NombreNivelesActivos{$i};100+<>al_NumeroNivelesActivos{$i})
			APPEND TO LIST:C376($hl_nivelesInformeFinPeriodo;<>at_NombreNivelesActivos{$i};200+<>al_NumeroNivelesActivos{$i})
			APPEND TO LIST:C376($hl_nivelesInformeSintesis;<>at_NombreNivelesActivos{$i};300+<>al_NumeroNivelesActivos{$i})
		End for 
		
		$hl_nivelesOficiales:=New list:C375
		For ($i;1;Size of array:C274(<>al_NumeroNivelesOficiales))
			If ((<>al_NumeroNivelesOficiales{$i}>=1) & (<>al_NumeroNivelesOficiales{$i}<=12))
				APPEND TO LIST:C376($hl_nivelesOficiales;<>at_NombreNivelesOficiales{$i};400+<>al_NumeroNivelesOficiales{$i})
			End if 
		End for 
		
		$hl_tiposInformeNotas:=New list:C375
		APPEND TO LIST:C376($hl_tiposInformeNotas;__ ("Parcial");11;$hl_nivelesInformeParciales;False:C215)
		APPEND TO LIST:C376($hl_tiposInformeNotas;__ ("Fin de período");12;$hl_nivelesInformeFinPeriodo;False:C215)
		APPEND TO LIST:C376($hl_tiposInformeNotas;__ ("Síntesis Anual");13;$hl_nivelesInformeSintesis;False:C215)
		
		hl_informes:=New list:C375
		APPEND TO LIST:C376(hl_informes;"Informes de Notas";10;$hl_tiposInformeNotas;True:C214)
		APPEND TO LIST:C376(hl_informes;"Actas y Certificados";20;$hl_nivelesOficiales;False:C215)
		
		ARRAY TEXT:C222(popL;0)
		ARRAY TEXT:C222(popR;0)
		ARRAY TEXT:C222(popC;0)
		LIST TO ARRAY:C288("STR_InformesNotas_Modelos";popInformes)
		LIST TO ARRAY:C288("STR_InformesNotas_Idiomas";<>aLang)
		LIST TO ARRAY:C288("STR_InformesNotas_Firmas";popL)
		
		COPY ARRAY:C226(popL;popC)
		COPY ARRAY:C226(popL;popR)
		ARRAY TEXT:C222(aObjects;14)
		ARRAY INTEGER:C220(aBkgColor;0)
		ARRAY INTEGER:C220(aForColor;0)
		
		ARRAY TEXT:C222(aCopyFromNivel;0)
		COPY ARRAY:C226(<>at_NombreNivelesActivos;aCopyFromNivel)
		COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvPrintMode)
		vs_lastRCModel:=""
		
		Case of 
			: (<>vtXS_CountryCode="co")
				DELETE FROM LIST:C624(hl_informes;20)
			: (<>vtXS_CountryCode="mx")
				DELETE FROM LIST:C624(hl_informes;10)
				DELETE FROM LIST:C624(hl_informes;20)
		End case 
		
		
		vMessage:=__ ("Por favor seleccione un tipo de informe y un nivel")
		FORM GOTO PAGE:C247(5)
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
	: (Form event:C388=On Menu Selected:K2:14)
		
	: (Form event:C388=On Close Box:K2:21)
		
		  //20171013 RCH
		vi_PrintCodes:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.imprimirAbreviaturas"))->
		vi_UppercaseNames:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.apellidosEnAltas"))->
		vi_EtiquetasEnAltas:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.etiquetasEnAltas"))->
		vi_FirmaDirectorNivel:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorNivel"))->
		vi_FirmaDirectorColegio:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorColegio"))->
		ACTAS_GuardaConfiguracion ([xxSTR_Niveles:6]NoNivel:5)
		
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
		
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_Informes;hl_CopiarDesdeNivel)
End case 

