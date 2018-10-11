  //MONO Ticket 187315
ARRAY TEXT:C222($at_moreOpt;0)
C_TEXT:C284($t_moreOptions)
C_LONGINT:C283($l_optSel;$i)

$l_paginaActual:=FORM Get current page:C276

APPEND TO ARRAY:C911($at_moreOpt;__ ("Propiedades de Evaluación"))
APPEND TO ARRAY:C911($at_moreOpt;__ ("Bloquear Parciales"))
APPEND TO ARRAY:C911($at_moreOpt;__ ("Configurar Parciales SubAsignaturas"))

For ($i;1;Size of array:C274($at_moreOpt))
	
	If ($l_paginaActual=$i)
		$t_moreOptions:=$t_moreOptions+"("
	End if 
	$t_moreOptions:=$t_moreOptions+$at_moreOpt{$i}+";"
End for 

$l_optSel:=Pop up menu:C542($t_moreOptions;0)
If ($l_optSel>0)
	If ($l_optSel=3)  //opcione de parciales de subasignaturas
		READ ONLY:C145([xxSTR_Subasignaturas:83])
		QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1)
		If (Records in selection:C76([xxSTR_Subasignaturas:83])>0)
			OBJECT SET TITLE:C194(*;"t_selectorSubasig";__ ("Seleccione Subasignatura"))
		Else 
			OBJECT SET TITLE:C194(*;"t_selectorSubasig";__ ("Sin configuración para subasignaturas"))
		End if 
	End if 
	
	If (($l_paginaActual=3) & (vt_lastSelectedSA#""))
		C_OBJECT:C1216($o_obj)
		C_POINTER:C301($y_arrayLB)
		$y_arrayLB:=(OBJECT Get pointer:C1124(Object named:K67:5;"SA_nameDisplay"))
		READ WRITE:C146([xxSTR_Subasignaturas:83])
		QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Auto_UUID:20=vt_lastSelectedSA)
		$o_obj:=[xxSTR_Subasignaturas:83]o_Data:21
		OB_SET ($o_obj;$y_arrayLB;"aSubEvalNombreParciales")
		[xxSTR_Subasignaturas:83]o_Data:21:=$o_obj
		SAVE RECORD:C53([xxSTR_Subasignaturas:83])
		KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
	End if 
	
	
	FORM GOTO PAGE:C247($l_optSel)
End if 