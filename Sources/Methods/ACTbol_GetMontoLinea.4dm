//%attributes = {}
  //ACTbol_GetMontoLinea

  //Es necesario que haya un registro de [ACT_Cargos] cargado.
  //Debe existir un set de [ACT_Transacciones] cuyo nombre debe ser pasado en $1
  //Debe estar la boleta cargada

C_TEXT:C284($set;$1)
C_REAL:C285($monto;$0)
C_DATE:C307($vd_fecha)
C_BOOLEAN:C305($b_montoEnMoneda)
C_BOOLEAN:C305($b_montoEnBoletaActual)  //20170513 RCH
$vd_fecha:=Current date:C33(*)

$set:=$1
If (Count parameters:C259>=2)
	$b_montoEnBoletaActual:=$2
End if 

Case of 
	: ([ACT_Boletas:181]ID_DctoAsociado:19>0)
		If ([ACT_Cargos:173]Ref_Item:16#-129)  //devolución nota de credito
			If (([ACT_Cargos:173]Ref_Item:16#-127) & ([ACT_Cargos:173]Ref_Item:16#-128))
				USE SET:C118($set)
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
				ARRAY LONGINT:C221($al_recNum;0)
				SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNum)
				  //$vr_credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Credito;->$vd_fecha)
				  //$vr_debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Debito;->$vd_fecha)
				
				  //$b_montoEnMoneda:=([ACT_Boletas]Moneda#<>vtACT_monedaPais)
				$b_montoEnMoneda:=Choose:C955([ACT_Boletas:181]Moneda:53="";False:C215;([ACT_Boletas:181]Moneda:53#<>vtACT_monedaPais))  //20161021 RCH 
				$vr_credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Credito:7;->$b_montoEnMoneda)
				$vr_debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6;->$b_montoEnMoneda)
				
				$monto:=Abs:C99($vr_credito-$vr_debito)
			End if 
		End if 
		
	: ([ACT_Boletas:181]ID_Estado:20=3)
		USE SET:C118($set)
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
		QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
		ARRAY LONGINT:C221($al_recNum;0)
		SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNum)
		
		  //$b_montoEnMoneda:=([ACT_Boletas]Moneda#<>vtACT_monedaPais)
		$b_montoEnMoneda:=Choose:C955([ACT_Boletas:181]Moneda:53="";False:C215;([ACT_Boletas:181]Moneda:53#<>vtACT_monedaPais))  //20161021 RCH 
		
		$r_monto:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6;->$b_montoEnMoneda)
		
		If ([ACT_Cargos:173]Monto_Neto:5<0)
			$monto:=Abs:C99($r_monto)*-1
		Else 
			$monto:=$r_monto
		End if 
		
	: ([ACT_Boletas:181]ID_Estado:20=1)
		USE SET:C118($set)
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
		QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0;*)
		QUERY SELECTION:C341([ACT_Transacciones:178]; | ;[ACT_Transacciones:178]ID_Pago:4=-2)
		ARRAY LONGINT:C221($al_recNum;0)
		SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNum)
		
		  //$b_montoEnMoneda:=([ACT_Boletas]Moneda#<>vtACT_monedaPais)
		$b_montoEnMoneda:=Choose:C955([ACT_Boletas:181]Moneda:53="";False:C215;([ACT_Boletas:181]Moneda:53#<>vtACT_monedaPais))  //20161021 RCH 
		
		  //$vr_credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Credito;->$vd_fecha)
		  //$vr_debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Debito;->$vd_fecha)
		$vr_credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Credito:7;->$b_montoEnMoneda)
		$vr_debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6;->$b_montoEnMoneda)
		
		
		$monto:=$vr_credito-$vr_debito
		
	: ([ACT_Boletas:181]ID_Estado:20=2)
		If ([ACT_Boletas:181]DTS_Creacion:22#"")
			$recNumCargo:=Record number:C243([ACT_Cargos:173])
			
			USE SET:C118($set)
			$vl_idITem:=[ACT_Cargos:173]ID:1
			$vl_idBoleta:=[ACT_Transacciones:178]No_Boleta:9
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$vl_idITem;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=$vl_idBoleta)
			CREATE SET:C116([ACT_Transacciones:178];"ACTtra_Todas")
			
			If (Not:C34($b_montoEnBoletaActual))
				  //  `  `***** para buscar las transacciones asociadas a nc
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$vl_idBoleta)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($vl_records>0)
					$vl_recNum:=Record number:C243([ACT_Boletas:181])
					
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$vl_idBoleta)
					KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$vl_idITem)
					CREATE SET:C116([ACT_Transacciones:178];"ACTtra_Todas2")
					UNION:C120("ACTtra_Todas";"ACTtra_Todas2";"ACTtra_Todas")
					SET_ClearSets ("ACTtra_Todas2")
					
					GOTO RECORD:C242([ACT_Boletas:181];$vl_recNum)
				End if 
				  //  `  `***** para buscar las transacciones asociadas a nc
			End if 
			
			USE SET:C118("ACTtra_Todas")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8#"Balanceo @")
			ARRAY LONGINT:C221($al_recNum;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum;"")
			  //$vr_credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Credito;->$vd_fecha)
			  //$vr_debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Debito;->$vd_fecha)
			
			  //$b_montoEnMoneda:=([ACT_Boletas]Moneda#<>vtACT_monedaPais)
			$b_montoEnMoneda:=Choose:C955([ACT_Boletas:181]Moneda:53="";False:C215;([ACT_Boletas:181]Moneda:53#<>vtACT_monedaPais))  //20161021 RCH 
			$vr_credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Credito:7;->$b_montoEnMoneda)
			$vr_debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6;->$b_montoEnMoneda)
			
			  //20120109 RCH Cuando hay beca (cargos con monto negativo) y la boleta esta parcialmente pagada, el monto salia positivo
			If ([ACT_Cargos:173]Monto_Neto:5<0)
				$vr_debito:=$vr_debito*-1
			End if 
			
			$monto:=$vr_credito+$vr_debito
			
			USE SET:C118("ACTtra_Todas")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Balanceo @")
			ARRAY LONGINT:C221($al_recNum;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum;"")
			  //$vr_credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Credito;->$vd_fecha)
			  //$vr_debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Debito;->$vd_fecha)
			
			  //$b_montoEnMoneda:=([ACT_Boletas]Moneda#<>vtACT_monedaPais)
			$b_montoEnMoneda:=Choose:C955([ACT_Boletas:181]Moneda:53="";False:C215;([ACT_Boletas:181]Moneda:53#<>vtACT_monedaPais))  //20161021 RCH 
			$vr_credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Credito:7;->$b_montoEnMoneda)
			$vr_debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6;->$b_montoEnMoneda)
			
			$monto2:=$vr_credito+$vr_debito
			
			$monto:=$monto+$monto2
			
			If ($recNumCargo#-1)
				GOTO RECORD:C242([ACT_Cargos:173];$recNumCargo)
			End if 
			  //End if 
		Else 
			USE SET:C118($set)
			C_LONGINT:C283($vl_enBoleta;$recNumCargo;$montoCre)
			$recNumCargo:=Record number:C243([ACT_Cargos:173])
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
			
			ARRAY LONGINT:C221($al_recNum;0)
			SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNum)
			  //If ([ACT_Boletas]DTS_Creacion="")
			
			  //$b_montoEnMoneda:=([ACT_Boletas]Moneda#<>vtACT_monedaPais)
			$b_montoEnMoneda:=Choose:C955([ACT_Boletas:181]Moneda:53="";False:C215;([ACT_Boletas:181]Moneda:53#<>vtACT_monedaPais))  //20161021 RCH 
			  //$montoCre:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Credito;->$vd_fecha)
			$montoCre:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Credito:7;->$b_montoEnMoneda)
			  //End if 
			
			USE SET:C118($set)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
			CREATE EMPTY SET:C140([ACT_Transacciones:178];"Pagos")
			FIRST RECORD:C50([ACT_Transacciones:178])
			ARRAY LONGINT:C221($al_recNumT;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumT;"")
			For ($i;1;Size of array:C274($al_recNumT))
				GOTO RECORD:C242([ACT_Transacciones:178];$al_recNumT{$i})
				  //While (Not(End selection([ACT_Transacciones])))
				$vr_debito:=[ACT_Transacciones:178]Debito:6
				
				$vr_monto:=ACTtra_CalculaMontos ("CalculaDesctoAsociado";->$set;->[ACT_Transacciones:178]ID_Item:3;->$b_montoEnMoneda)
				GOTO RECORD:C242([ACT_Transacciones:178];$al_recNumT{$i})
				$vr_debito:=$vr_debito+$vr_monto
				
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_enBoleta)
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Credito:7=$vr_debito)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($vl_enBoleta>0)
					ADD TO SET:C119([ACT_Transacciones:178];"Pagos")
				Else 
					$index:=Find in field:C653([ACT_Cargos:173]ID:1;[ACT_Transacciones:178]ID_Item:3)
					If ($index#-1)
						GOTO RECORD:C242([ACT_Cargos:173];$index)
						If ([ACT_Cargos:173]Saldo:23=0)
							ADD TO SET:C119([ACT_Transacciones:178];"Pagos")
						End if 
					End if 
				End if 
			End for 
			USE SET:C118("Pagos")
			$vt_set:="transacciones2"
			ARRAY LONGINT:C221($al_recNum;0)
			SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNum)
			CREATE SET:C116([ACT_Transacciones:178];$vt_set)
			CLEAR SET:C117("Pagos")
			
			  //$b_montoEnMoneda:=([ACT_Boletas]Moneda#<>vtACT_monedaPais)
			$b_montoEnMoneda:=Choose:C955([ACT_Boletas:181]Moneda:53="";False:C215;([ACT_Boletas:181]Moneda:53#<>vtACT_monedaPais))  //20161021 RCH 
			  //$montoDeb:=Abs(ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones]Debito))
			$montoDeb:=Abs:C99(ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->$b_montoEnMoneda))
			
			USE SET:C118($vt_set)
			$vr_monto:=0
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			ARRAY LONGINT:C221($al_recNum;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNum)
			For ($i;1;Size of array:C274($al_recNum))
				GOTO RECORD:C242([ACT_Cargos:173];$al_recNum{$i})
				  //$vr_monto:=$vr_monto+ACTtra_CalculaMontos ("CalculaDesctoAsociado";->$set;->[ACT_Cargos]ID)
				$vr_monto:=$vr_monto+ACTtra_CalculaMontos ("CalculaDesctoAsociado";->$set;->[ACT_Cargos:173]ID:1;->$b_montoEnMoneda)
			End for 
			$montoDeb:=$montoDeb+$vr_monto
			If ([ACT_Cargos:173]Monto_Neto:5<0)
				$monto:=$montoCre-$montoDeb
			Else 
				$monto:=$montoCre+$montoDeb
			End if 
			If ($recNumCargo#-1)
				GOTO RECORD:C242([ACT_Cargos:173];$recNumCargo)
			End if 
		End if 
End case 

$0:=$monto