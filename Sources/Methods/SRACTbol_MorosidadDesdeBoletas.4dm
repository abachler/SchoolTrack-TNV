//%attributes = {}
C_BOOLEAN:C305(vbACT_Procesado)
C_REAL:C285(vlSelAño)
C_DATE:C307(vd_fecha1;vd_fecha2)

vbACT_Finalizar:=False:C215
vbACT_Procesado:=False:C215

  //vlSelAño:=<>vlBash_DSS1
vlSelAño:=$1
vd_fecha1:=DT_GetDateFromDayMonthYear (1;1;vlSelAño)
vd_fecha2:=DT_GetDateFromDayMonthYear (31;12;vlSelAño)

ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY TEXT:C222(aQR_Text2;0)  //codigo
ARRAY TEXT:C222(aQR_Text3;0)
ARRAY TEXT:C222(aQR_Text4;0)  //rut
ARRAY REAL:C219(aQR_Real4;0)  //saldo anterior
ARRAY REAL:C219(aQR_Real5;0)  //enero
ARRAY REAL:C219(aQR_Real6;0)
ARRAY REAL:C219(aQR_Real7;0)
ARRAY REAL:C219(aQR_Real8;0)
ARRAY REAL:C219(aQR_Real9;0)
ARRAY REAL:C219(aQR_Real10;0)
ARRAY REAL:C219(aQR_Real11;0)
ARRAY REAL:C219(aQR_Real12;0)
ARRAY REAL:C219(aQR_Real13;0)
ARRAY REAL:C219(aQR_Real14;0)
ARRAY REAL:C219(aQR_Real15;0)
ARRAY REAL:C219(aQR_Real16;0)
ARRAY REAL:C219(aQR_Real17;0)
ARRAY REAL:C219(aQR_Real18;0)
ARRAY REAL:C219(aQR_Real19;0)
ARRAY REAL:C219(aQR_Real20;0)
ARRAY REAL:C219(aQR_Real21;0)
ARRAY REAL:C219(aQR_Real22;0)
ARRAY REAL:C219(aQR_Real23;0)
ARRAY REAL:C219(aQR_Real24;0)
ARRAY REAL:C219(aQR_Real25;0)
ARRAY REAL:C219(aQR_Real26;0)
ARRAY REAL:C219(aQR_Real27;0)
ARRAY REAL:C219(aQR_Real28;0)
ARRAY REAL:C219(aQR_Real29;0)
ARRAY REAL:C219(aQR_Real30;0)
ARRAY REAL:C219(aQR_Real31;0)

ARRAY TEXT:C222(aQR_Text31;0)  //meses
ARRAY TEXT:C222(aQR_Text32;0)  //encabezados

ARRAY LONGINT:C221(aQR_Longint2;0)  //id apdo
ARRAY LONGINT:C221(aQR_Longint3;0)  //recnum Boletas
ARRAY LONGINT:C221(aQR_Longint4;0)  //acumula ids apdos
ARRAY LONGINT:C221(aQR_Longint5;0)  //recNum transacciones
ARRAY LONGINT:C221(aQR_Longint6;0)  //ids terceros total
ARRAY LONGINT:C221(aQR_Longint7;0)  //ids terceros por mes
ARRAY LONGINT:C221(aQR_Longint8;0)  //ids terceros procesados

C_LONGINT:C283($i;$j;$vl_pos;$vl_yaProcesado;$vl_indiceMes;$vl_proc;$vt_totalRec;$vt_totalProc;$vl_ultimoApoderado)
C_DATE:C307($vd_fecha1;$vd_fecha2;$vd_fecha3)
C_POINTER:C301($vy_pointer1;$vy_pointer2)
C_REAL:C285($vr_neto)
C_TEXT:C284($vt_fileName)
C_TIME:C306($ref)
C_BOOLEAN:C305($vb_apoderado;$vb_tercer)

LIST TO ARRAY:C288("XS_Meses";aQR_Text31)

READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

MESSAGES OFF:C175
$vl_proc:=IT_UThermometer (1;0;"Buscando documentos tributarios para el período...")
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=vd_fecha1;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=vd_fecha2;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)

QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12>0)
CREATE SET:C116([ACT_Boletas:181];"setBoletasPeriodo")
$vt_totalRec:=Records in set:C195("setBoletasPeriodo")
$vt_totalProc:=0
QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Apoderado:14#0)
KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14;"")
ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;aQR_Text3;[Personas:7]Codigo_interno:22;aQR_Text2;[Personas:7]No:1;aQR_Longint2;[Personas:7]RUT:6;aQR_Text4)

$vl_ultimoApoderado:=Size of array:C274(aQR_Text3)

  //terceros
USE SET:C118("setBoletasPeriodo")
QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Tercero:21#0)
KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;"")
ORDER BY:C49([ACT_Terceros:138];[ACT_Terceros:138]Nombre_Completo:9;>)

While (Not:C34(End selection:C36([ACT_Terceros:138])))
	APPEND TO ARRAY:C911(aQR_Text3;"TERCERO: "+[ACT_Terceros:138]Nombre_Completo:9)
	APPEND TO ARRAY:C911(aQR_Text2;[ACT_Terceros:138]Codigo_Interno:29)
	APPEND TO ARRAY:C911(aQR_Longint2;[ACT_Terceros:138]Id:1)
	APPEND TO ARRAY:C911(aQR_Text4;[ACT_Terceros:138]RUT:4)
	APPEND TO ARRAY:C911(aQR_Longint6;[ACT_Terceros:138]Id:1)
	NEXT RECORD:C51([ACT_Terceros:138])
End while 

For ($i;1;Size of array:C274(aQR_Text2))
	APPEND TO ARRAY:C911(aQR_Longint1;$i)
End for 

AT_RedimArrays (Size of array:C274(aQR_Text2);->aQR_Real4;->aQR_Real5;->aQR_Real6;->aQR_Real7;->aQR_Real8;->aQR_Real9;->aQR_Real10;->aQR_Real11;->aQR_Real12;->aQR_Real13;->aQR_Real14;->aQR_Real15;->aQR_Real16;->aQR_Real17;->aQR_Real18;->aQR_Real19;->aQR_Real20;->aQR_Real21;->aQR_Real22;->aQR_Real23;->aQR_Real24;->aQR_Real25;->aQR_Real26;->aQR_Real27;->aQR_Real28;->aQR_Real29;->aQR_Real30;->aQR_Real31)

$vl_indiceMes:=4

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información...")
For ($i;1;12)
	IT_UThermometer (0;$vl_proc;"Procesando documentos tributarios para el mes "+aQR_Text31{$i})
	$vl_indiceMes:=$vl_indiceMes+1
	USE SET:C118("setBoletasPeriodo")
	$vd_fecha1:=DT_GetDateFromDayMonthYear (1;$i;vlSelAño)
	$vd_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($i;vlSelAño);$i;vlSelAño)
	QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$vd_fecha1;*)
	QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=$vd_fecha2)
	
	If (Records in selection:C76([ACT_Boletas:181])>0)
		CREATE SET:C116([ACT_Boletas:181];"setBoletasMes")
		DIFFERENCE:C122("setBoletasPeriodo";"setBoletasMes";"setBoletasPeriodo")
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Apoderado:14#0)
		DISTINCT VALUES:C339([ACT_Boletas:181]ID_Apoderado:14;aQR_Longint3)
		
		USE SET:C118("setBoletasMes")
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Tercero:21#0)
		DISTINCT VALUES:C339([ACT_Boletas:181]ID_Tercero:21;aQR_Longint7)
		
		$vy_pointer1:=Get pointer:C304("aQR_Real"+String:C10($vl_indiceMes))
		$vl_indiceMes:=$vl_indiceMes+1
		$vy_pointer2:=Get pointer:C304("aQR_Real"+String:C10($vl_indiceMes))
		
		For ($j;1;Size of array:C274(aQR_Longint3)+Size of array:C274(aQR_Longint7))
			USE SET:C118("setBoletasMes")
			If ($j<=Size of array:C274(aQR_Longint3))
				$vb_apoderado:=True:C214
				$vb_tercer:=False:C215
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Apoderado:14=aQR_Longint3{$j})
				$vl_pos:=Find in array:C230(aQR_Longint2;aQR_Longint3{$j})  //se busca la posicion en el arreglo sincronizado de apoderados...
				$vl_yaProcesado:=Find in array:C230(aQR_Longint4;aQR_Longint3{$j})
			Else 
				$vb_apoderado:=False:C215
				$vb_tercer:=True:C214
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Tercero:21=aQR_Longint7{$j-Size of array:C274(aQR_Longint3)})
				$vl_pos:=$vl_ultimoApoderado+Find in array:C230(aQR_Longint6;aQR_Longint7{$j-Size of array:C274(aQR_Longint3)})  //se busca la posicion en el arreglo sincronizado de apoderados...
				$vl_yaProcesado:=Find in array:C230(aQR_Longint8;aQR_Longint7{$j-Size of array:C274(aQR_Longint3)})
			End if 
			CREATE SET:C116([ACT_Boletas:181];"setBoletasMesApdo")
			$vt_totalProc:=$vt_totalProc+Records in set:C195("setBoletasMesApdo")
			
			If ($vl_yaProcesado=-1)
				$vd_fecha3:=DT_GetDateFromDayMonthYear (1;1;vlSelAño)
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3<$vd_fecha3;*)
				If ($vb_apoderado)
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Apoderado:14=aQR_Longint3{$j})
					APPEND TO ARRAY:C911(aQR_Longint4;aQR_Longint3{$j})
				Else 
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Tercero:21=aQR_Longint7{$j-Size of array:C274(aQR_Longint3)})
					APPEND TO ARRAY:C911(aQR_Longint8;aQR_Longint7{$j-Size of array:C274(aQR_Longint3)})
					
				End if 
				KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-129)
				aQR_Real4{$vl_pos}:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
				aQR_Real29{$vl_pos}:=aQR_Real29{$vl_pos}+aQR_Real4{$vl_pos}
			End if 
			USE SET:C118("setBoletasMesApdo")
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-129)
			$vy_pointer1->{$vl_pos}:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
			aQR_Real29{$vl_pos}:=aQR_Real29{$vl_pos}+$vy_pointer1->{$vl_pos}
			
			$vr_neto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*)))
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
			CREATE SET:C116([ACT_Transacciones:178];"TransaccionesCargos")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_fecha2)
			ARRAY LONGINT:C221(aQR_Longint5;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];aQR_Longint5;"")
			$vy_pointer2->{$vl_pos}:=$vr_neto-ACTtra_CalculaMontos ("calculaFromRecNum";->aQR_Longint5;->[ACT_Transacciones:178]Debito:6)
			aQR_Real30{$vl_pos}:=aQR_Real30{$vl_pos}+$vy_pointer2->{$vl_pos}
			
			If ($vy_pointer2->{$vl_pos}#0)
				USE SET:C118("TransaccionesCargos")
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=vd_fecha2)
				ARRAY LONGINT:C221(aQR_Longint5;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];aQR_Longint5;"")
				aQR_Real31{$vl_pos}:=aQR_Real31{$vl_pos}+($vr_neto-ACTtra_CalculaMontos ("calculaFromRecNum";->aQR_Longint5;->[ACT_Transacciones:178]Debito:6))
			End if 
			
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vt_totalProc/$vt_totalRec)
		End for 
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

vbACT_Procesado:=True:C214
While (vbACT_Procesado)
	DELAY PROCESS:C323(Current process:C322;60)
	IDLE:C311
End while 

AT_Initialize (->aQR_Longint1;->aQR_Text2;->aQR_Text3;->aQR_Real4;->aQR_Real5;->aQR_Real6;->aQR_Real7;->aQR_Real8;->aQR_Real9;->aQR_Real10;->aQR_Real11;->aQR_Real12;->aQR_Real13;->aQR_Real14;->aQR_Real15;->aQR_Real16;->aQR_Real17;->aQR_Real18;->aQR_Real19;->aQR_Real20;->aQR_Real21;->aQR_Real22;->aQR_Real23;->aQR_Real24;->aQR_Real25;->aQR_Real26;->aQR_Real27;->aQR_Real28;->aQR_Real29;->aQR_Real30;->aQR_Real31)
IT_UThermometer (-2;$vl_proc)

