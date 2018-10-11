//%attributes = {}
  //ACTqry_CtasSinAvisosEmtXMatriz

If (Application type:C494#4D Server:K5:6)
	If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		C_LONGINT:C283($i;$vl_mes;$vl_year;$resp)
		ARRAY LONGINT:C221(aQR_Longint1;0)
		ARRAY LONGINT:C221(aQR_Longint2;0)
		
		$resp:=CD_Dlog (0;__ ("Esta opción buscará las cuentas corrientes activas para las cuales no han sido emitidos avisos de cobranza por alguna matriz de cargos para el mes seleccionado del período actual.\r\r¿Desea continuar con la ejecución de esta opción?");__ ("");__ ("Si");__ ("No"))
		If ($resp=1)
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_SeleccionaMes";-1;4;__ ("Seleccione mes"))
			DIALOG:C40([xxSTR_Constants:1];"STR_SeleccionaMes")
			CLOSE WINDOW:C154
			If (ok=1)
				C_DATE:C307(vQR_Date1;vQR_Date2;vQR_Date3)
				vQR_Date1:=PERIODOS_InicioAñoSTrack 
				vQR_Date2:=PERIODOS_FinAñoPeriodosSTrack 
				
				vQR_Date3:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;Year of:C25(Current date:C33(*)))
				If ((vQR_Date3>=vQR_Date1) & (vQR_Date3<=vQR_Date2))
				Else 
					vQR_Date3:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;Year of:C25(Current date:C33(*))-1)
					If ((vQR_Date3>=vQR_Date1) & (vQR_Date3<=vQR_Date2))
					Else 
						vQR_Date3:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;Year of:C25(Current date:C33(*))+1)
						If ((vQR_Date3>=vQR_Date1) & (vQR_Date3<=vQR_Date2))
						Else 
							vQR_Date3:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;Year of:C25(Current date:C33(*)))
						End if 
					End if 
				End if 
				
				$vl_mes:=Month of:C24(vQR_Date3)
				$vl_year:=Year of:C25(vQR_Date3)
				
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214;*)
				QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]ID_Matriz:7#0)
				
				SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;aQR_Longint1)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando avisos para el mes ")+String:C10($vl_mes)+__ (", año ")+String:C10($vl_year)+__ (" para todas las cuentas activas y con matriz asignada."))
				For ($i;1;Size of array:C274(aQR_Longint1))
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=aQR_Longint1{$i};*)
					QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]ID_Matriz:2>0;*)
					QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Mes:13=$vl_mes;*)
					QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Año:14=$vl_year;*)
					QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]FechaEmision:21#!00-00-00!)
					If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0)
						APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$i})
					Else 
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
						If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=0)
							APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$i})
						End if 
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1);__ ("Verificando avisos para el mes ")+String:C10($vl_mes)+__ (", año ")+String:C10($vl_year)+__ (" para todas las cuentas activas y con matriz asignada."))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				If (Size of array:C274(aQR_Longint2)>0)
					QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;aQR_Longint2)
				Else 
					  //CD_Dlog (0;"Todas las cuentas activas y con matriz tienen avisos generados para el mes :"+String($vl_mes))
				End if 
				REDRAW WINDOW:C456
				ARRAY LONGINT:C221(aQR_Longint1;0)
				ARRAY LONGINT:C221(aQR_Longint2;0)
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("Este comando sólo puede ser ejecutado desde la lengüeta Cuentas Corrientes."))
	End if 
End if 