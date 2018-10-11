  // [xxBBL_ReglasParaUsuarios].CFG_ReglasLectores.Field15()
  // Por: Alberto Bachler K.: 18-03-14, 19:36:24
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_posicionEnLista:=Find in array:C230(<>aPrefUsr;[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
Case of 
	: ([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1="")
		[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1:=Old:C35([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
		CD_Dlog (0;__ ("El código de una regla no puede ser vacío.\r\rPor favor ingrese un código válido"))
		GOTO OBJECT:C206([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
	: (($l_posicionEnLista>0) & ($l_posicionEnLista#<>aPrefUsr))
		CD_Dlog (0;__ ("Esta regla ya existe."))
		[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1:=Old:C35([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
		GOTO OBJECT:C206([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
	Else 
		If (([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1#Old:C35([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)) & ([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1#""))
			QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4=Old:C35([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1))
			$records:=Records in selection:C76([BBL_Lectores:72])
			If ($Records>0)
				$q:=Replace string:C233(__ ("Esta regla esta asignada a ^0 usuarios.\r¿Desea realmente cambiar el código que la identifica?");"^0";String:C10($records))
				$r:=CD_Dlog (0;$q;__ ("");__ ("No");__ ("Sí"))
				If ($r=2)
					$pID2:=IT_UThermometer (1;0;__ ("Actualizando el código de la regla…\rPor favor espere que termine."))
					_O_ARRAY STRING:C218(3;aString_3;$Records)
					vs_string:=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1
					AT_Populate (->aString_3;->vs_string)
					OK:=KRL_Array2Selection (->aString_3;->[BBL_Lectores:72]Regla:4)
					IT_UThermometer (-2;$pID2)
					_O_ARRAY STRING:C218(3;aString_3;0)
					If (OK=0)
						CANCEL:C270
					Else 
						SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
					End if 
				Else 
					[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1:=Old:C35([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1)
				End if 
			End if 
		End if 
		<>aPrefUsr{<>aPrefUsr}:=[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1
End case 