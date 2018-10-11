//%attributes = {}
  //dbuACT_VerificaCargosPagados
  //20110822 RCH verifica que los cargos pagados tengan efectivamente pagos asociados. Puede ser que por algún problema o daño, se produzca un problema de integridad de los datos

C_TEXT:C284($1)
C_DATE:C307($vd_fechaDesde)
C_LONGINT:C283($i)
C_REAL:C285($vr_montoEnTransacciones)

ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY LONGINT:C221(aQR_Longint2;0)
ARRAY LONGINT:C221(aQR_Longint3;0)
ARRAY BOOLEAN:C223(aQR_Boolean1;0)
ARRAY REAL:C219(aQR_Real1;0)
ARRAY TEXT:C222(aQR_Text1;0)

READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

vQR_Text1:=ST_GetWord (ACT_DivisaPais ;1;";")
$vd_fechaDesde:=Add to date:C393(Current date:C33(*);-1;0;0)

Case of 
	: (Count parameters:C259=0)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaDesde;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]MontosPagados:8>0)
		
	: ($1="TODOS")
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]MontosPagados:8>0)
		
	Else 
		TRACE:C157
End case 

SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;aQR_Longint1;[ACT_Cargos:173]MontosPagados:8;aQR_Real1;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;aQR_Boolean1;[ACT_Cargos:173]Moneda:28;aQR_Text1)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando cargos pagados...")
For ($i;1;Size of array:C274(aQR_Longint1))
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=aQR_Longint1{$i})
	LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];aQR_Longint2;"")
	$vr_montoEnTransacciones:=ACTtra_CalculaMontos ("calculaFromRecNum";->aQR_Longint2;->[ACT_Transacciones:178]Debito:6)
	If ($vr_montoEnTransacciones#aQR_Real1{$i})
		If (aQR_Longint1{$i}#0)
			If ((aQR_Boolean1{$i}) & (vQR_Text1#aQR_Text1{$i}))
				KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->aQR_Longint1{$i})
				aQR_Real1{$i}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			End if 
			If ($vr_montoEnTransacciones#aQR_Real1{$i})
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=aQR_Longint1{$i})
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15=0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];aQR_Longint2;"")
				$vr_montoEnTransacciones:=ACTtra_CalculaMontos ("calculaFromRecNum";->aQR_Longint2;->[ACT_Transacciones:178]Debito:6)
				If ($vr_montoEnTransacciones#aQR_Real1{$i})
					APPEND TO ARRAY:C911(aQR_Longint3;aQR_Longint1{$i})
				End if 
			End if 
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If (Size of array:C274(aQR_Longint3)>0)
	SET TEXT TO PASTEBOARD:C523(AT_array2text (->aQR_Longint3;"\r";"###############"))
	CD_Dlog (0;"Hay "+String:C10(aQR_Longint3)+" cargos con problemas. Revise el portapapeles para conocer cada uno de los ids de"+" cargos con problemas.")
End if 