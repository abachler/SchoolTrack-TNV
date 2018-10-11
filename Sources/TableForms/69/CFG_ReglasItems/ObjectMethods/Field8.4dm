If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script Codigo regla
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 18:04
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
$l_posicionEnLista:=Find in array:C230(<>aPrefDoc;[xxBBL_ReglasParaItems:69]Codigo_regla:1)
Case of 
	: ([xxBBL_ReglasParaItems:69]Codigo_regla:1="")
		[xxBBL_ReglasParaItems:69]Codigo_regla:1:=Old:C35([xxBBL_ReglasParaItems:69]Codigo_regla:1)
		CD_Dlog (0;__ ("El código de una regla no puede ser vacío.\r\rPor favor ingrese un código válido"))
		GOTO OBJECT:C206([xxBBL_ReglasParaItems:69]Codigo_regla:1)
	: (($l_posicionEnLista>0) & ($l_posicionEnLista#<>aPrefDoc))
		CD_Dlog (0;__ ("Esta regla ya existe."))
		[xxBBL_ReglasParaItems:69]Codigo_regla:1:=Old:C35([xxBBL_ReglasParaItems:69]Codigo_regla:1)
		GOTO OBJECT:C206([xxBBL_ReglasParaItems:69]Codigo_regla:1)
	Else 
		If (([xxBBL_ReglasParaItems:69]Codigo_regla:1#Old:C35([xxBBL_ReglasParaItems:69]Codigo_regla:1)) & ([xxBBL_ReglasParaItems:69]Codigo_regla:1#""))
			MESSAGES ON:C181
			$pID:=IT_UThermometer (1;0;__ ("Actualizando el código de la regla…\rPor favor espere que termine."))
			QUERY:C277([BBL_Items:61];[BBL_Items:61]Regla:20=Old:C35([xxBBL_ReglasParaItems:69]Codigo_regla:1))
			MESSAGES OFF:C175
			$records:=Records in selection:C76([BBL_Items:61])
			If ($Records>0)
				$q:=Replace string:C233(__ ("Esta regla esta asignada a ^0 items.\r¿Desea realmente cambiar el código que la identifica?");"^0";String:C10($records))
				$r:=CD_Dlog (0;$q;__ ("");__ ("No");__ ("Sí"))
				If ($r=2)
					$pID2:=IT_UThermometer (1;0;__ ("Esta regla esta asignada a ^0 items.\r¿Desea realmente cambiar el código que la identifica?");-1)
					_O_ARRAY STRING:C218(3;aString_3;$Records)
					vs_string:=[xxBBL_ReglasParaItems:69]Codigo_regla:1
					AT_Populate (->aString_3;->vs_string)
					OK:=KRL_Array2Selection (->aString_3;->[BBL_Items:61]Regla:20)
					IT_UThermometer (-2;$pID2)
					_O_ARRAY STRING:C218(3;aString_3;0)
					If (OK=0)
						CANCEL:C270
					End if 
				Else 
					[xxBBL_ReglasParaItems:69]Codigo_regla:1:=Old:C35([xxBBL_ReglasParaItems:69]Codigo_regla:1)
				End if 
			End if 
			IT_UThermometer (-2;$pID)
		End if 
		<>aPrefDoc{<>aPrefDoc}:=[xxBBL_ReglasParaItems:69]Codigo_regla:1
End case 