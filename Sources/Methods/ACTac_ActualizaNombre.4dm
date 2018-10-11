//%attributes = {}
  //ACTac_ActualizaNombre

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301($ptr1;$ptr2)
C_LONGINT:C283($vl_recNum;$vl_idAlumno;$pID;$vl_id)
C_TEXT:C284($vt_campo)
ARRAY LONGINT:C221($al_recNumAC;0)
C_TEXT:C284($0;$t_retorno)

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$2
End if 
If ($vt_accion="")
	$vt_accion:="ActualizaTodo"
End if 

Case of 
	: ($vt_accion="VerificaAvisos")  //20131105 RCH Verifica nombre...
		ARRAY LONGINT:C221($aQR_Longint1;0)
		C_LONGINT:C283($l_indice;$l_proc;$l_idAC)
		
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$l_idAC:=$ptr1->
		End if 
		$l_proc:=IT_UThermometer (1;0;"Verificando nombre en Avisos de Cobranza...")
		
		If ($l_idAC#0)
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$ptr1->)
		Else 
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]NombreRelacionado:27="")
		End if 
		
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aQR_Longint1;"")
		
		For ($l_indice;1;Size of array:C274($aQR_Longint1))
			ACTac_ActualizaNombre ("ActualizaAviso";->$aQR_Longint1{$l_indice})
		End for 
		
		IT_UThermometer (-2;$l_proc)
		
	: ($vt_accion="ActualizaTodo")
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_Terceros:138])
		READ ONLY:C145([Personas:7])
		
		C_LONGINT:C283($i)
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$vl_id:=$ptr1->
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$vl_id)
		Else 
			ALL RECORDS:C47([ACT_Avisos_de_Cobranza:124])
		End if 
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumAC;"")
		If ($vl_id=0)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando valor a campo de avisos de cobranza..."))
		End if 
		For ($i;1;Size of array:C274($al_recNumAC))
			$vl_recNum:=$al_recNumAC{$i}
			ACTac_ActualizaNombre ("ActualizaAviso";->$vl_recNum)
			If ($vl_id=0)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumAC);__ ("Asignando valor a campo de avisos de cobranza..."))
			End if 
		End for 
		If ($vl_id=0)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
	: ($vt_accion="ProcessTask")
		$vl_recNum:=Num:C11($ptr1->)
		$t_retorno:=ACTac_ActualizaNombre ("ActualizaAviso";->$vl_recNum)
		
	: ($vt_accion="ActualizaAviso")
		C_BOOLEAN:C305($b_readOnly)
		$vl_recNum:=$ptr1->
		  //READ WRITE([ACT_Avisos_de_Cobranza])
		  //GOTO RECORD([ACT_Avisos_de_Cobranza];$vl_recNum)
		REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
		KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$vl_recNum;True:C214)
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
			If (Not:C34(Locked:C147([ACT_Avisos_de_Cobranza:124])))
				$t_retorno:=ACTac_ActualizaNombre ("AsignaValorACampo")
				If ($t_retorno="1")
					SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
				Else 
					BM_CreateRequest ("ACT_ActualizaNombreAC";String:C10($vl_recNum);"AsignaNombreAC_RecNum_"+String:C10($vl_recNum))  //20130411 RCH  con la llave no se crea nuevamente la tarea si ya existe...
				End if 
			Else 
				BM_CreateRequest ("ACT_ActualizaNombreAC";String:C10($vl_recNum);"AsignaNombreAC_RecNum_"+String:C10($vl_recNum))  //20130411 RCH  con la llave no se crea nuevamente la tarea si ya existe...
			End if 
		Else 
			$t_retorno:="1"  //si no esta el registro se devuelve ok
		End if 
		KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
		
	: ($vt_accion="AsignaValorACampo")
		C_POINTER:C301($y_tablaATestear)
		C_LONGINT:C283($l_id;$l_recNum)
		C_BOOLEAN:C305($b_continuar)  //20130507 RCH. Puede que el AC haya sido borrado...
		  //20130411 RCH Se testea el registro para que no este siendo modificado cuando se intenta asignar el valor del campo
		$b_continuar:=True:C214
		Case of 
			: ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
				$l_id:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
				$l_recNum:=Find in field:C653([Alumnos:2]numero:1;$l_id)
				$y_tablaATestear:=->[Alumnos:2]
			: ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)
				$l_id:=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
				$l_recNum:=Find in field:C653([ACT_Terceros:138]Id:1;$l_id)
				$y_tablaATestear:=->[ACT_Terceros:138]
			: ([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#0)
				$l_id:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
				$l_recNum:=Find in field:C653([Personas:7]No:1;$l_id)
				$y_tablaATestear:=->[Personas:7]
			Else 
				$b_continuar:=False:C215
		End case 
		If ($b_continuar)
			  //es para evitar que se asigne un valor cuando el aun no se modifica el campo. Por ejemplo, esto se lanza antes que el trigger termine, por lo tanto, toma el valor anterior del campo
			$b_readOnly:=Read only state:C362($y_tablaATestear->)
			KRL_GotoRecord ($y_tablaATestear;$l_recNum;True:C214)
			If (ok=1)
				Case of 
					: ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
						$vl_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
						[ACT_Avisos_de_Cobranza:124]NombreRelacionado:27:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$vl_idAlumno;->[Alumnos:2]apellidos_y_nombres:40)
						
					: ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)
						[ACT_Avisos_de_Cobranza:124]NombreRelacionado:27:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26;->[ACT_Terceros:138]Nombre_Completo:9)
						
					: ([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#0)
						[ACT_Avisos_de_Cobranza:124]NombreRelacionado:27:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]Apellidos_y_nombres:30)
						
				End case 
				$t_retorno:="1"
			Else 
				If (Records in selection:C76($y_tablaATestear->)=0)  // si el registro no existe se retorna como ejecutado correctamente
					$t_retorno:="1"
				End if 
			End if 
			KRL_ResetPreviousRWMode ($y_tablaATestear;$b_readOnly)  //libero porque lo cargo en 
		Else 
			$t_retorno:="1"
		End if 
		
		
	: ($vt_accion="DesdeAlumnos")
		$vl_id:=$ptr1->
		$vt_accion:="ActualizaRegistro"+"."+"1"+"."+String:C10($vl_id)
		$pID:=Execute on server:C373(Current method name:C684;Pila_256K;"Recalculo de avisos de cobranza";$vt_accion)
		
	: ($vt_accion="ActualizaRegistro@")
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		
		$vt_campo:=ST_GetWord ($vt_accion;2;".")
		$vl_id:=Num:C11(ST_GetWord ($vt_accion;3;"."))
		
		Case of 
			: ($vt_campo="1")
				$vl_id:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->$vl_id;->[ACT_CuentasCorrientes:175]ID:1)
				$ptr1:=->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2
				
			: ($vt_campo="2")
				$ptr1:=->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
				
			: ($vt_campo="3")
				$ptr1:=->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
				
		End case 
		
		QUERY:C277([ACT_Avisos_de_Cobranza:124];$ptr1->=$vl_id)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumAC;"")
		For ($i;1;Size of array:C274($al_recNumAC))
			$vl_recNum:=$al_recNumAC{$i}
			ACTac_ActualizaNombre ("ActualizaAviso";->$vl_recNum)
		End for 
		
	: ($vt_accion="DesdeApoderados")
		$vl_id:=$ptr1->
		$vt_accion:="ActualizaRegistro"+"."+"2"+"."+String:C10($vl_id)
		$pID:=Execute on server:C373(Current method name:C684;Pila_256K;"Recalculo de avisos de cobranza";$vt_accion)
		
	: ($vt_accion="DesdeTerceros")
		$vl_id:=$ptr1->
		$vt_accion:="ActualizaRegistro"+"."+"3"+"."+String:C10($vl_id)
		$pID:=Execute on server:C373(Current method name:C684;Pila_256K;"Recalculo de avisos de cobranza";$vt_accion)
		
	: ($vt_accion="NombreRelacionadoVacio")
		  //ACTac_ActualizaNombre("ActualizaRegistrosConCamposVacios")
		C_LONGINT:C283($i;$vl_recNum)
		ARRAY LONGINT:C221($al_recNumAC;0)
		
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]NombreRelacionado:27="")
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumAC;"")
		For ($i;1;Size of array:C274($al_recNumAC))
			$vl_recNum:=$al_recNumAC{$i}
			ACTac_ActualizaNombre ("ActualizaAviso";->$vl_recNum)
		End for 
		
End case 

$0:=$t_retorno