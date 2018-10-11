If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ (".\r\rNo se guardará ningún de cambio en estas propiedades."))
Else 
	C_REAL:C285($sum)
	$sum:=AT_GetSumArray (->arAS_EvalPropPercent)
	Case of 
		: (($sum=0) | ($sum=100))
			If (r2=1)
				  //AS_PropEval_Escritura ("Blob_ConfigNotas/"+String(lConsID)+"/P"+String(vL_LastPeriod))
				AS_PropEval_Escritura (vL_LastPeriod)  //MONO CAMBIO AS_PropEval_Escritura
			Else 
				  //AS_PropEval_Escritura ("Blob_ConfigNotas/"+String(lConsID))
				AS_PropEval_Escritura (0)  //MONO CAMBIO AS_PropEval_Escritura
			End if 
			
			ACCEPT:C269
		: ($sum<100)
			$r:=CD_Dlog (0;__ ("La suma de los pesos relativos de consolidación debe ser superior o igual a 100"))
		Else 
			  //$msg:=RP_GetIdxString (21113;36)+RP_GetIdxString (21113;37)
			$result:=CD_Dlog (0;__ ("La suma total de ponderaciones es superior a 100%.\rSi las ponderaciones de las evaluaciones registradas para un alumno superan el 100%, el promedio calculado es dividido por la suma de ponderaciones y multiplicado por 100.\r")+__ ("\rPuede utilizar esta forma de cálculo pero deberá asegurarse que la suma de ponderaciones para cada alumno no sea superior a 100%\r\r¿Desea continuar utilizando esta forma de cálculo?");__ ("");__ ("No");__ ("Si"))
			If ($result=2)
				If (r2=1)
					  //AS_PropEval_Escritura ("Blob_ConfigNotas/"+String(lConsID)+"/P"+String(vL_LastPeriod))
					AS_PropEval_Escritura (vL_LastPeriod)  //MONO CAMBIO AS_PropEval_Escritura
				Else 
					  //AS_PropEval_Escritura ("Blob_ConfigNotas/"+String(lConsID))
					AS_PropEval_Escritura (0)  //MONO CAMBIO AS_PropEval_Escritura
				End if 
				ACCEPT:C269
			End if 
	End case 
End if 

  //MONO Ticket 187315
If ((FORM Get current page:C276=3) & (vt_lastSelectedSA#""))
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