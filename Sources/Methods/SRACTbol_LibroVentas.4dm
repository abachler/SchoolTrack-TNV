//%attributes = {}
  //SRACTbol_LibroVentas

ARRAY DATE:C224(aQR_Date1;0)
ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY TEXT:C222(aQR_Text1;0)
ARRAY TEXT:C222(aQR_Text2;0)
ARRAY REAL:C219(aQR_Real1;0)
ARRAY REAL:C219(aQR_Real2;0)
ARRAY REAL:C219(aQR_Real3;0)
C_REAL:C285(vQR_Real1;vQR_Real2;vQR_Real3)
C_DATE:C307($date1;$date2)
ARRAY LONGINT:C221($al_pos1;0)
ARRAY LONGINT:C221($al_pos2;0)
ARRAY LONGINT:C221($al_pos3;0)
ARRAY LONGINT:C221($al_posFInal;0)
ARRAY LONGINT:C221($al_posFInal2;0)

vQR_Real1:=0
$go:=ACTbol_SeleccionaPeriodoLibro 
If ($go)
	MESSAGES OFF:C175
	$proc:=IT_UThermometer (1;0;__ ("Buscando documentos..."))
	$index:=Find in array:C230(alACT_DocsIDs;vl_DocID)
	  // ticket 166980 - 166420 - 165435 AOQ 20160927
	If (aiACT_Tipo{$index}=1)
		$val1:=1
		$val2:=Num:C11(ST_GetWord (atACT_DocsIDsCats{$index};1;";"))
		$val3:=Num:C11(ST_GetWord (atACT_DocsIDsCats{$index};2;";"))
	Else 
		$val1:=2
		$val2:=Num:C11(ST_GetWord (atACT_DocsIDsCats{$index};1;";"))
		$val3:=Num:C11(ST_GetWord (atACT_DocsIDsCats{$index};2;";"))
	End if 
	If (cb_Agrupar=0)
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13=vl_DocID)
	Else 
		aiACT_Tipo{0}:=$val1
		alACT_IDCat{0}:=$val2
		abACT_Afecta{0}:=($val3=1)
		
		AT_SearchArray (->aiACT_Tipo;"=";->$al_pos1)
		AT_SearchArray (->alACT_IDCat;"=";->$al_pos2)
		AT_SearchArray (->abACT_Afecta;"=";->$al_pos3)
		
		AT_intersect (->$al_pos1;->$al_pos2;->$al_posFInal2)
		AT_intersect (->$al_posFInal2;->$al_pos3;->$al_posFInal)
		
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]TipoDocumento:7="";*)
		For ($i;1;Size of array:C274($al_posFInal))
			QUERY:C277([ACT_Boletas:181]; | ;[ACT_Boletas:181]ID_Documento:13=alACT_IDDT{$al_posFInal{$i}};*)
		End for 
		QUERY:C277([ACT_Boletas:181])
	End if 
	Case of 
		: (vb_Hoy=1)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3=Current date:C33(*))
			$date1:=Current date:C33(*)
			$date2:=Current date:C33(*)
		: (vb_Mes=1)
			$lastday:=DT_GetLastDay (vl_Mes;vl_Añom)
			$date1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Añom)
			$date2:=DT_GetDateFromDayMonthYear ($lastday;vl_Mes;vl_Añom)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$date1;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$date2)
		: (vb_Año=1)
			$date1:=DT_GetDateFromDayMonthYear (1;1;vl_Año)
			$date2:=DT_GetDateFromDayMonthYear (31;12;vl_Año)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$date1;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$date2)
		: (vb_Rango=1)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=vd_Fecha1;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=vd_Fecha2)
			$date1:=vd_Fecha1
			$date2:=vd_Fecha2
	End case 
	
	If (cb_IncluirDA=1)
		CREATE SET:C116([ACT_Boletas:181];"boletas2Print")
		If ($val2>=-1)
			$val2:=-4
		Else 
			$pos:=Find in array:C230(atACT_Categorias;"Boleta@")
			$val2:=alACT_IDsCats{$pos}
		End if 
		aiACT_Tipo{0}:=$val1
		alACT_IDCat{0}:=$val2
		abACT_Afecta{0}:=($val3=1)
		AT_SearchArray (->aiACT_Tipo;"=";->$al_pos1)
		AT_SearchArray (->alACT_IDCat;"=";->$al_pos2)
		AT_SearchArray (->abACT_Afecta;"=";->$al_pos3)
		AT_intersect (->$al_pos1;->$al_pos2;->$al_posFInal2)
		AT_intersect (->$al_posFInal2;->$al_pos3;->$al_posFInal)
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]TipoDocumento:7="";*)
		For ($i;1;Size of array:C274($al_posFInal))
			QUERY:C277([ACT_Boletas:181]; | ;[ACT_Boletas:181]ID_Documento:13=alACT_IDDT{$al_posFInal{$i}};*)
		End for 
		QUERY:C277([ACT_Boletas:181])
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13#vl_DocID)
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$date1;*)
		QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$date2)
		ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3;>;[ACT_Boletas:181]Numero:11;>)
		ARRAY LONGINT:C221($al_recNum;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];$al_recNum)
		For ($i;1;Size of array:C274($al_recNum))
			GOTO RECORD:C242([ACT_Boletas:181];$al_recNum{$i})
			APPEND TO ARRAY:C911(aQR_Date1;[ACT_Boletas:181]FechaEmision:3)
			APPEND TO ARRAY:C911(aQR_Longint1;[ACT_Boletas:181]Numero:11)
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Boletas:181]ID_Apoderado:14)
			APPEND TO ARRAY:C911(aQR_Text1;ST_Boolean2Str (([ACT_Boletas:181]ID_Estado:20=4);"NULA";[Personas:7]Apellidos_y_nombres:30))
			If (aQR_Text1{Size of array:C274(aQR_Text1)}#"Nula")
				APPEND TO ARRAY:C911(aQR_Text2;SR_FormatoRUT2 ([Personas:7]RUT:6))
				APPEND TO ARRAY:C911(aQR_Real1;[ACT_Boletas:181]Monto_Total:6)
				APPEND TO ARRAY:C911(aQR_Real2;Num:C11(ST_Boolean2Str (([ACT_Boletas:181]AfectaIVA:9);String:C10([ACT_Boletas:181]Monto_Afecto:4);String:C10([ACT_Boletas:181]Monto_Total:6))))
				APPEND TO ARRAY:C911(aQR_Real3;Num:C11(ST_Boolean2Str (([ACT_Boletas:181]AfectaIVA:9);String:C10([ACT_Boletas:181]Monto_IVA:5);"0")))
			Else 
				APPEND TO ARRAY:C911(aQR_Text2;"")
				APPEND TO ARRAY:C911(aQR_Real1;0)
				APPEND TO ARRAY:C911(aQR_Real2;0)
				APPEND TO ARRAY:C911(aQR_Real3;0)
			End if 
			vQR_Real1:=vQR_Real1+aQR_Real1{Size of array:C274(aQR_Real1)}
			vQR_Real2:=vQR_Real2+aQR_Real2{Size of array:C274(aQR_Real2)}
			vQR_Real3:=vQR_Real3+aQR_Real3{Size of array:C274(aQR_Real3)}
		End for 
		USE SET:C118("boletas2Print")
		CLEAR SET:C117("boletas2Print")
	End if 
	
	ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3;>;[ACT_Boletas:181]Numero:11;>)
	vtACT_LVTipoDocumento:=vt_Documento
	vtACT_LVRango:="Desde el "+String:C10($date1;7)+" hasta el "+String:C10($date2;7)
	
	IT_UThermometer (-2;$proc)
End if 