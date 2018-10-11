//%attributes = {}
  //ACTac_ValidaMontosEmision

C_TEXT:C284($vt_set;$1)
C_LONGINT:C283($vl_itemsDescuento)
C_REAL:C285($vr_montoMCargo;$vr_montoDescuento;$vr_montoCargos;$vr_diferencia;$vr_desctoMax;$vr_montoNeto)
C_DATE:C307($vd_date;$2)

$vt_set:=$1
$vd_date:=$2

READ ONLY:C145([ACT_Cargos:173])
USE SET:C118($vt_set)
SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_itemsDescuento)
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($vl_itemsDescuento>0)
	ARRAY LONGINT:C221($al_idsCtas;0)
	AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_idsCtas)
	USE SET:C118($vt_set)
	For ($i;1;Size of array:C274($al_idsCtas))
		USE SET:C118($vt_set)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$al_idsCtas{$i})
		CREATE SET:C116([ACT_Cargos:173];"ACT_setCargosCta")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_itemsDescuento)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		If ($vl_itemsDescuento>0)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)
			CREATE SET:C116([ACT_Cargos:173];"ItemDcto")
			$vr_montoDescuento:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$vd_date)
			USE SET:C118("ACT_setCargosCta")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0)
			$vr_montoCargos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$vd_date)
			
			If (Abs:C99($vr_montoDescuento)>Abs:C99($vr_montoCargos))
				$vr_diferencia:=Abs:C99($vr_montoDescuento)-Abs:C99($vr_montoCargos)
				$vr_desctoMax:=Abs:C99($vr_montoCargos)
				
				USE SET:C118("ItemDcto")
				ARRAY LONGINT:C221($al_recNumCargos;0)
				ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3;<)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumCargos;"")
				For ($j;1;Size of array:C274($al_recNumCargos))
					GOTO RECORD:C242([ACT_Cargos:173];$al_recNumCargos{$j})
					$vr_montoNeto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$vd_date)
					READ WRITE:C146([ACT_Cargos:173])
					GOTO RECORD:C242([ACT_Cargos:173];$al_recNumCargos{$j})
					If (Abs:C99($vr_montoNeto)>$vr_desctoMax)
						$vr_desctoMax:=Abs:C99($vr_desctoMax)
						$vr_montoMCargo:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";$vd_date;->$vr_desctoMax;->[ACT_Cargos:173]Moneda:28)
						$vr_montoOrgLog:=[ACT_Cargos:173]Monto_Neto:5
						[ACT_Cargos:173]Monto_Neto:5:=Abs:C99($vr_montoMCargo)*-1
						[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
						SAVE RECORD:C53([ACT_Cargos:173])
						$vr_desctoMax:=Abs:C99($vr_desctoMax)+[ACT_Cargos:173]Monto_Neto:5
						$vl_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
						LOG_RegisterEvt ("Disminución del monto neto del descuento con id "+String:C10([ACT_Cargos:173]ID:1)+", para la cuenta corriente "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$vl_idAlumno;->[Alumnos:2]apellidos_y_nombres:40)+", para el período "+String:C10([ACT_Cargos:173]Año:14)+String:C10([ACT_Cargos:173]Mes:13;"00")+". Disminuyó de "+String:C10($vr_montoOrgLog)+" a "+String:C10([ACT_Cargos:173]Monto_Neto:5)+".")
					Else 
						$vr_desctoMax:=Abs:C99($vr_desctoMax)+$vr_montoNeto
					End if 
				End for 
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
			End if 
			CLEAR SET:C117("ItemDcto")
			CLEAR SET:C117("ACT_setCargosCta")
		End if 
		
	End for 
End if 