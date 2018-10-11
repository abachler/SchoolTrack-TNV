//%attributes = {}
  //dbuACT_VerificaAvisosXMatriz

If (Application type:C494#4D Server:K5:6)
	If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		If (Count parameters:C259=2)
			C_LONGINT:C283($i;$vl_mes;$vl_year)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			$vl_mes:=$1
			$vl_year:=$2
			
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]ID_Matriz:7#0)
			
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;aQR_Longint1)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando avisos para el mes ")+String:C10($vl_mes)+__ (" para todas las cuentas activas y con matriz asignada."))
			For ($i;1;Size of array:C274(aQR_Longint1))
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=aQR_Longint1{$i};*)
				QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]ID_Matriz:2>0;*)
				QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Mes:13=$vl_mes;*)
				QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Año:14=$vl_year)
				If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0)
					APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$i})
				Else 
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
					If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=0)
						APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$i})
					End if 
				End if 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1);__ ("Verificando avisos para el mes ")+String:C10($vl_mes)+__ (" para todas las cuentas activas y con matriz asignada."))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			If (Size of array:C274(aQR_Longint2)>0)
				QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;aQR_Longint2)
				CREATE SET:C116(yBWR_CurrentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_CurrentTable)))
				If (brLastDim>0)
					AL_RemoveArrays (xALP_Browser;1;brLastDim)
				End if 
				  //BWR_SelectTableData  `en algunos casos se caía el sistema en compilado
				BWR_LoadData 
			Else 
				CD_Dlog (0;__ ("Todas las cuentas activas y con matriz tienen avisos generados para el mes :")+String:C10($vl_mes))
			End if 
			
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
		Else 
			CD_Dlog (0;__ ("Indique el mes y año a verificar."))
		End if 
	Else 
		CD_Dlog (0;__ ("Este comando sólo puede ser ejecutado desde la lengüeta Cuentas Corrientes."))
	End if 
End if 