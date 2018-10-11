//%attributes = {}
  // Método: xALP_ACT_CB_MYTValXDia
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-03-10, 09:43:07
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

  // Código principal
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	$vRowMoneda:=AL_GetLine (xALP_Divisas)
	If ($vRowMoneda>0)
		AL_GetCurrCell (xALP_UF;$vCol;$vRow)
		If (AL_GetCellMod (xALP_UF)=1)
			Case of 
				: ($vCol=1)
					
				: ($vCol=2)
					$vl_idMoneda:=alACT_IdRegistro{$vRowMoneda}
					$vl_mes:=Num:C11(Substring:C12(atACT_UFReference{atACT_UFLabel};5;2))
					$vl_year:=Num:C11(Substring:C12(atACT_UFReference{atACT_UFLabel};1;4))
					$vd_fecha:=DT_GetDateFromDayMonthYear (alACT_MonedaDia{$vRow};$vl_mes;$vl_year)
					$vr_monto:=arACT_ValorMonedaDia{$vRow}
					$lineMoneda:=AL_GetLine (xALP_Divisas)
					AL_UpdateArrays (xALP_Divisas;0)
					AL_UpdateArrays (xALP_UF;0)
					ACTcfgmyt_OpcionesGenerales ("AplicaCambioParidadManual";->$vl_idMoneda;->$vd_fecha;->$vr_monto)
					AL_UpdateArrays (xALP_Divisas;-2)
					AL_UpdateArrays (xALP_UF;-2)
					AL_SetLine (xALP_Divisas;$lineMoneda)
					ACTcfg_ColorUndelDivisas 
					AL_ExitCell (xALP_UF)
			End case 
		End if 
	End if 
End if 