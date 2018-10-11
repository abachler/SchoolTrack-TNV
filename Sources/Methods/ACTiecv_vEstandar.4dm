//%attributes = {}
  //ACTiecv_vEstandar

ACTdte_OpcionesGeneralesIE ("DeclaraArreglosIEV")

C_DATE:C307($vd_fechaInicio;$vd_fechaTermino)
C_LONGINT:C283($i)
C_TEXT:C284($t_rut;$t_razonSocial)

ARRAY LONGINT:C221(aQR_Longint1;0)
READ ONLY:C145([ACT_Boletas:181])

$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;vlACTdte_MesIE;vlACTdte_YearIE)
$vd_fechaTermino:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vlACTdte_MesIE;vlACTdte_YearIE);vlACTdte_MesIE;vlACTdte_YearIE)

QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$vd_fechaInicio;*)
  //20150910 RCH Filtro por RS
  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]FechaEmision<=$vd_fechaTermino)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$vd_fechaTermino;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11>0;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_RazonSocial:25=[ACT_RazonesSociales:279]id:1)

  //20150727 RCH Se envia todo lo que hay. Esto es para enviar boletas
  //QUERY SELECTION([ACT_Boletas];[ACT_Boletas]codigo_SII="33";*)
  //QUERY SELECTION([ACT_Boletas]; | ;[ACT_Boletas]codigo_SII="34";*)
  //QUERY SELECTION([ACT_Boletas]; | ;[ACT_Boletas]codigo_SII="56";*)
  //QUERY SELECTION([ACT_Boletas]; | ;[ACT_Boletas]codigo_SII="61";*)
  //QUERY SELECTION([ACT_Boletas]; | ;[ACT_Boletas]codigo_SII="30";*)
  //QUERY SELECTION([ACT_Boletas]; | ;[ACT_Boletas]codigo_SII="32";*)
  //QUERY SELECTION([ACT_Boletas]; | ;[ACT_Boletas]codigo_SII="55";*)
  //QUERY SELECTION([ACT_Boletas]; | ;[ACT_Boletas]codigo_SII="60")
  //
  //If (Not(Is compiled mode))
  //QUERY SELECTION([ACT_Boletas];[ACT_Boletas]Nula=False)
  //QUERY SELECTION([ACT_Boletas];[ACT_Boletas]Numero#0)
  //End if 

ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3;>)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Buscando información...")

If (cs_totales=0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];aQR_Longint1;"")
	For ($i;1;Size of array:C274(aQR_Longint1))
		GOTO RECORD:C242([ACT_Boletas:181];aQR_Longint1{$i})
		ACTdte_OpcionesGeneralesIE ("InsertaElemento")
		atACTie_COLUMNA1{Size of array:C274(atACTie_COLUMNA1)}:=[ACT_Boletas:181]codigo_SII:33
		atACTie_COLUMNA3{Size of array:C274(atACTie_COLUMNA3)}:=String:C10([ACT_Boletas:181]Numero:11)
		If ([ACT_Boletas:181]Nula:15)
			atACTie_COLUMNA4{Size of array:C274(atACTie_COLUMNA4)}:="A"
		Else 
			atACTie_COLUMNA6{Size of array:C274(atACTie_COLUMNA6)}:=String:C10([ACT_Boletas:181]TasaIVA:16)
			atACTie_COLUMNA10{Size of array:C274(atACTie_COLUMNA10)}:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_Boletas:181]FechaEmision:3)
			If ([ACT_Boletas:181]ID_Apoderado:14#0)
				$t_rut:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14;->[Personas:7]RUT:6)
				$t_razonSocial:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14;->[Personas:7]Apellidos_y_nombres:30)
			Else 
				$t_rut:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]RUT:4)
				$t_razonSocial:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]Nombre_Completo:9)
			End if 
			atACTie_COLUMNA12{Size of array:C274(atACTie_COLUMNA12)}:=ST_Uppercase (ACTdte_GeneraArchivo ("GetRutConFormato";->$t_rut))
			atACTie_COLUMNA13{Size of array:C274(atACTie_COLUMNA13)}:=Substring:C12($t_razonSocial;1;50)
			
			If (atACTie_COLUMNA12{Size of array:C274(atACTie_COLUMNA12)}="")  //20170221 RCH
				atACTie_COLUMNA14{Size of array:C274(atACTie_COLUMNA14)}:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Pasaporte:59;[ACT_Terceros:138]Pasaporte:25)
				atACTie_COLUMNA15{Size of array:C274(atACTie_COLUMNA15)}:=ACTdte_ObtieneCodigoPaisSII (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Nacionalidad:7;[ACT_Terceros:138]Nacionalidad:27))
				If ((atACTie_COLUMNA14{Size of array:C274(atACTie_COLUMNA14)}#"") & (atACTie_COLUMNA15{Size of array:C274(atACTie_COLUMNA15)}#""))
					atACTie_COLUMNA12{Size of array:C274(atACTie_COLUMNA12)}:=ST_Uppercase (ACTdte_GeneraArchivo ("GetRutConFormato";->[ACT_RazonesSociales:279]RUT:3))  //cuando se envia sin rut el SII reclama.
				End if 
			End if 
			
			If (([ACT_Boletas:181]ID_DctoAsociado:19#0) & ([ACT_Boletas:181]codigo_referencia:31=1))
				atACTie_COLUMNA16{Size of array:C274(atACTie_COLUMNA16)}:=KRL_GetTextFieldData (->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]ID_DctoAsociado:19;->[ACT_Boletas:181]codigo_SII:33)
				atACTie_COLUMNA17{Size of array:C274(atACTie_COLUMNA17)}:=String:C10(KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]ID_DctoAsociado:19;->[ACT_Boletas:181]Numero:11))
				GOTO RECORD:C242([ACT_Boletas:181];aQR_Longint1{$i})
			End if 
			atACTie_COLUMNA18{Size of array:C274(atACTie_COLUMNA18)}:=String:C10([ACT_Boletas:181]Monto_Exento:30)
			atACTie_COLUMNA19{Size of array:C274(atACTie_COLUMNA19)}:=String:C10([ACT_Boletas:181]Monto_Afecto:4)
			atACTie_COLUMNA20{Size of array:C274(atACTie_COLUMNA20)}:=String:C10([ACT_Boletas:181]Monto_IVA:5)
			atACTie_COLUMNA29{Size of array:C274(atACTie_COLUMNA29)}:=String:C10([ACT_Boletas:181]Monto_Total:6)
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1))
	End for 
	
Else 
	ARRAY TEXT:C222(aQR_Text1;0)
	DISTINCT VALUES:C339([ACT_Boletas:181]codigo_SII:33;aQR_Text1)
	CREATE SET:C116([ACT_Boletas:181];"setBoletas")
	For ($i;1;Size of array:C274(aQR_Text1))
		USE SET:C118("setBoletas")
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33=aQR_Text1{$i})
		CREATE SET:C116([ACT_Boletas:181];"setCodigo")
		
		ACTdte_OpcionesGeneralesIE ("InsertaElemento")
		atACTie_COLUMNA1{Size of array:C274(atACTie_COLUMNA1)}:=aQR_Text1{$i}
		  //QUERY SELECTION([ACT_Boletas];[ACT_Boletas]Nula=False)//20151002 RCH este total incluye los nulos
		atACTie_COLUMNA2{Size of array:C274(atACTie_COLUMNA2)}:=String:C10(Records in selection:C76([ACT_Boletas:181]))
		USE SET:C118("setCodigo")
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=True:C214)
		atACTie_COLUMNA3{Size of array:C274(atACTie_COLUMNA3)}:=String:C10(Records in selection:C76([ACT_Boletas:181]))
		
		USE SET:C118("setCodigo")
		atACTie_COLUMNA5{Size of array:C274(atACTie_COLUMNA5)}:=String:C10(Sum:C1([ACT_Boletas:181]Monto_Exento:30))  //exento
		
		atACTie_COLUMNA6{Size of array:C274(atACTie_COLUMNA6)}:=String:C10(Sum:C1([ACT_Boletas:181]Monto_Afecto:4))  //afecto
		
		atACTie_COLUMNA7{Size of array:C274(atACTie_COLUMNA7)}:=String:C10(Sum:C1([ACT_Boletas:181]Monto_IVA:5))  //iva
		
		atACTie_COLUMNA18{Size of array:C274(atACTie_COLUMNA18)}:=String:C10(Sum:C1([ACT_Boletas:181]Monto_Total:6))  //total
		
		SET_ClearSets ("setCodigo")
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1))
	End for 
	SET_ClearSets ("setBoletas")
End if 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
