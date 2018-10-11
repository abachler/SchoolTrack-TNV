  // [xxSTR_Constants].STR_CFG_InformesEspeciales.hl_Informes()
  // Por: Alberto Bachler K.: 28-02-14, 21:03:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_refClaseSeleccionada;$l_refItemSeleccionado;$l_refSublista)
C_TEXT:C284($itemText)
C_LONGINT:C283(vi_NoNivel)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		aCopyFromNivel:=0
		
		GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$l_refItemSeleccionado;$itemText;$l_refSublista)
		$l_refClaseSeleccionada:=List item parent:C633(hl_informes;$l_refItemSeleccionado)
		
		Case of 
			: ((vs_lastRCModel="Actas") & (Record number:C243([xxSTR_Niveles:6])>No current record:K29:2))
				vi_PrintCodes:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.imprimirAbreviaturas"))->
				vi_UppercaseNames:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.apellidosEnAltas"))->
				vi_EtiquetasEnAltas:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.etiquetasEnAltas"))->
				vi_FirmaDirectorNivel:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorNivel"))->
				vi_FirmaDirectorColegio:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorColegio"))->
				ACTAS_GuardaConfiguracion ([xxSTR_Niveles:6]NoNivel:5)
				
			: ((vs_lastRCModel#"") & (vs_lastRCModel#"Actas") & (vi_NoNivel#0))
				NIVrc_SaveSettings 
				
		End case 
		
		
		Case of 
			: ($l_refItemSeleccionado=10)
				REDUCE SELECTION:C351([xxSTR_Niveles:6];0)
				vMessage:=__ ("Por favor seleccione un tipo de informe y un nivel")
				FORM GOTO PAGE:C247(4)
				
			: ($l_refItemSeleccionado<=20)
				REDUCE SELECTION:C351([xxSTR_Niveles:6];0)
				vMessage:=__ ("Por favor seleccione un nivel")
				FORM GOTO PAGE:C247(4)
				
			: (($l_refClaseSeleccionada=11) | ($l_refClaseSeleccionada=12) | ($l_refClaseSeleccionada=13))
				HL_ClearList (hl_CopiarDesdeNivel)
				hl_CopiarDesdeNivel:=AT_Array2ReferencedList (-><>at_NombreNivelesActivos;-><>al_NumeroNivelesActivos;hl_CopiarDesdeNivel)
				COPY ARRAY:C226(<>at_NombreNivelesActivos;aCopyFromNivel)
				<>LangPtr:=Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);<>aLang+3)
				FORM GOTO PAGE:C247(1)
				
				Case of 
					: ($l_refClaseSeleccionada=11)
						vi_NoNivel:=$l_refItemSeleccionado-100
						vs_lastRCModel:="Informe parcial"+"/"+String:C10(vi_NoNivel)
					: ($l_refClaseSeleccionada=12)
						vi_NoNivel:=$l_refItemSeleccionado-200
						vs_lastRCModel:="Informe de fin de período"+"/"+String:C10(vi_NoNivel)
						
					: ($l_refClaseSeleccionada=13)
						vi_NoNivel:=$l_refItemSeleccionado-300
						vs_lastRCModel:="Sintesis anual"+"/"+String:C10(vi_NoNivel)
				End case 
				
				PERIODOS_LoadData (vi_NoNivel)
				NIVrc_GetSettings 
				<>LangPtr:=Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);<>aLang+3)
				If (USR_GetMethodAcces ("Lenguaje_Manager";0)=False:C215)
					_O_DISABLE BUTTON:C193(bModLang)
				End if 
				aObjects:=1
				pBkgColor:=aBkgColor{aObjects}
				pForColor:=aForColor{aObjects}
				
				
			: (($l_refClaseSeleccionada=20) & ($l_refItemSeleccionado>400))
				HL_ClearList (hl_CopiarDesdeNivel)
				hl_CopiarDesdeNivel:=New list:C375
				For ($i;1;Size of array:C274(<>al_NumeroNivelesOficiales))
					If ((<>al_NumeroNivelesOficiales{$i}>=1) & (<>al_NumeroNivelesOficiales{$i}<=12))
						APPEND TO LIST:C376(hl_CopiarDesdeNivel;<>at_NombreNivelesOficiales{$i};<>al_NumeroNivelesOficiales{$i})
					End if 
				End for 
				
				
				vi_NoNivel:=$l_refItemSeleccionado-400
				vs_lastRCModel:="Actas"
				READ ONLY:C145([xxSTR_Niveles:6])
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=vi_NoNivel)
				ACTAS_LeeConfiguracion ([xxSTR_Niveles:6]NoNivel:5)
				
				REDUCE SELECTION:C351([Cursos:3];0)
				ACTAS_ConfiguraFormActa (True:C214)
				FORM GOTO PAGE:C247(2)
				
				
			Else 
				OBJECT SET VISIBLE:C603(*;"Mask@";True:C214)
		End case 
		
End case 