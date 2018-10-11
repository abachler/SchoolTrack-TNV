//%attributes = {"executedOnServer":true}
  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 16/08/16, 12:54:43
  // ----------------------------------------------------
  // Método: ACT_MetodoInforme_Simple
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_BLOB:C604($x_blob;$0)
C_REAL:C285(TotalMorosidad1;TotalMorosidad2;TotalMorosidad3;TotalMorosidad4;TotalMorosidad5;TotalMorosidad6;TotalMorosidad7;TotalMorosidad8;TotalMorosidad9;TotalMorosidad10;TotalMorosidad11;TotalMorosidad12)
C_POINTER:C301($TotalMorosidadPtr)
C_TEXT:C284($aHeaderTextAño;$HeaderText2;$Header1;$Header2;$HeaderTextRow2;$col2;$ruta)
C_DATE:C307($vd_fechaHasta)

$sem:=Semaphore:C143("InformeServer")

SET BLOB SIZE:C606($x_blob;0)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Cargos:173])

$l_porApoderado:=$1
$l_incluirProtestado:=$2
$l_fechaSeleccionada:=$3
$l_soloPagosPeriodo:=$4
$l_año2:=$5
$l_soloActivas:=$6
$l_soloDeudas:=$7
vd_fechaCorte:=$8

$col5:=""
$SedeFlag:=0

If ($l_porApoderado=1)
	$label1:=__ ("Apoderado")
	$label2:=__ ("Apdos")
	$hdr:=__ ("No.")+"\t"+__ ("Cod. Interno")+"\t"+__ ("Nombre")+"\t"
	$tabTotales:="\t"*2
Else 
	$label1:=__ ("Cuenta Corriente")
	$label2:=__ ("Ctas")
	$hdr:=__ ("No.")+"\t"+__ ("Código")+"\t"+__ ("Nombre")+"\t"+__ ("Curso")+"\t"
	$tabTotales:="\t"*3
End if 
COPY ARRAY:C226(<>atXS_MonthNames;aHeaders1)
$HeaderText1:=$hdr+AT_array2text (->aHeaders1;"\t")+"\t"+"Anual"+"\r\n"
$msg:=__ ("AccountTrack generará un archivo Excel con la morosidad simplificada por ")+$label1+__ (" para")
$msg2:=__ (" Esta operación puede ser larga. ¿Desea continuar?")

$year:=$l_año2
$fileName:=String:C10($year)
$titulo:=__ ("Morosidad por ")+$label1+__ (" para el año ")+String:C10($year)+"\r\n"+"\r\n"+"\r\n"
$msg:=$msg+__ (" el año ")+String:C10($year)+"."+$msg2
If ($l_soloPagosPeriodo=1)
	$msg:=$msg+"\r\r"+__ (" - El informe sólo considera los pagos realizados hasta el ")+ST_Boolean2Str ($l_fechaSeleccionada=1;String:C10(vd_fechaCorte);__ ("último día de cada mes"))+"-"
	$fileName:="InfoMorosidad_Simple_P_"+$label2+"_"+$fileName
Else 
	$fileName:="InfoMorosidad_Simple_"+$label2+"_"+$fileName
End if 

If ($l_incluirProtestado=1)
	$fileName:=$fileName+"_IncProt"
End if 

$r:=1
If ($r=1)
	
	$fileName:="IMS"+DTS_MakeFromDateTime 
	$vt_filePath:=Temporary folder:C486+$fileName+".txt"
	SYS_DeleteFile ($vt_filePath)
	
	
	USE CHARACTER SET:C205("windows-1252";0)
	$ref:=Create document:C266($vt_filePath;"TEXT")
	If ($ref#?00:00:00?)
		IO_SendPacket ($ref;$HeaderText1)
		If ($l_soloActivas=1)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
		Else 
			ALL RECORDS:C47([ACT_CuentasCorrientes:175])
		End if 
		ARRAY TEXT:C222($aNombres;0)
		ARRAY TEXT:C222($aCodigo;0)
		ARRAY LONGINT:C221($aIDs;0)
		
		If ($l_porApoderado=1)
			  //KRL_RelateSelection (->[Personas]No;->[ACT_CuentasCorrientes]ID_Apoderado;"")
			READ ONLY:C145([ACT_Cargos:173])
			C_DATE:C307($vd_fechaInicio;$vd_fechaTermino)
			$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;1;$year)
			$vd_fechaTermino:=DT_GetDateFromDayMonthYear (31;12;$year)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaInicio;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaTermino)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-129)
			  //10-09-2015 JVP ticket 156094
			  // /codigo nuevo para mostar solo las personas con deuda
			  //If ($l_soloDeudas=1)
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
			  //End if 
			  //ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;vd_fechaCorte;$l_incluirProtestado)  //ABC//213047 //20180727
			If ((cb_considerarSoloPagosPeriodo=0) & (cb_fechaSeleccionada=0))
				ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;vd_fechaCorte;$l_incluirProtestado)
			Else 
				CREATE SET:C116([ACT_Cargos:173];"$Temp")
				CREATE EMPTY SET:C140([ACT_Cargos:173];"$Cargos_Usar")
				For (vQR_long10;1;12)
					$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;vQR_long10;$year)
					$vd_fechaTermino:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vQR_long10;$year);vQR_long10;$year)
					USE SET:C118("$temp")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaInicio;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaTermino)
					If (cb_considerarSoloPagosPeriodo=1)
						If (cb_fechaSeleccionada=1)
							ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;vd_fechaCorte;$l_incluirProtestado)
						Else 
							ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;$vd_fechaTermino;$l_incluirProtestado)
						End if 
					Else 
						ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;vd_fechaCorte;$l_incluirProtestado)
					End if 
					CREATE SET:C116([ACT_Cargos:173];"$temp2")
					UNION:C120("$Cargos_Usar";"$temp2";"$Cargos_Usar")
				End for 
				USE SET:C118("$Cargos_Usar")
			End if 
			KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Cargos:173]ID_Apoderado:18;"")
			CREATE SET:C116([ACT_Cargos:173];"$todos")
			SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;$aNombres;[Personas:7]Codigo_interno:22;$aCodigo;[Personas:7]No:1;$aIDs)
			SORT ARRAY:C229($aNombres;$aCodigo;$aIDs;>)
		Else 
			$procID:=IT_UThermometer (1;0;__ ("Recopilando información de las cuentas..."))
			ARRAY TEXT:C222($aCursos;0)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			  //10-09-2015 JVP ticket 156094
			  // /codigo nuevo para mostar solo las personas con deuda
			C_DATE:C307($vd_fechaInicio;$vd_fechaTermino)
			$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;1;$year)
			$vd_fechaTermino:=DT_GetDateFromDayMonthYear (31;12;$year)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaInicio;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaTermino)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-129)
			  //ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;vd_fechaCorte;$l_incluirProtestado)  //ABC//213047 //20180727
			If ((cb_considerarSoloPagosPeriodo=0) & (cb_fechaSeleccionada=0))
				ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;vd_fechaCorte;$l_incluirProtestado)
			Else 
				CREATE SET:C116([ACT_Cargos:173];"$Temp")
				CREATE EMPTY SET:C140([ACT_Cargos:173];"$Cargos_Usar")
				For (vQR_long10;1;12)
					$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;vQR_long10;$year)
					$vd_fechaTermino:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vQR_long10;$year);vQR_long10;$year)
					USE SET:C118("$temp")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaInicio;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaTermino)
					If (cb_considerarSoloPagosPeriodo=1)
						If (cb_fechaSeleccionada=1)
							ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;vd_fechaCorte;$l_incluirProtestado)
						Else 
							ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;$vd_fechaTermino;$l_incluirProtestado)
						End if 
					Else 
						ACTcar_ValidaOpcionMorosidad ($l_soloDeudas;$l_soloPagosPeriodo;vd_fechaCorte;$l_incluirProtestado)
					End if 
					CREATE SET:C116([ACT_Cargos:173];"$temp2")
					UNION:C120("$Cargos_Usar";"$temp2";"$Cargos_Usar")
				End for 
				USE SET:C118("$Cargos_Usar")
			End if 
			
			CREATE SET:C116([ACT_Cargos:173];"$todos")
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
			
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$aIDs;[ACT_CuentasCorrientes:175]Codigo:19;$aCodigo;[Alumnos:2]apellidos_y_nombres:40;$aNombres;[Alumnos:2]curso:20;$aCursos)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			SORT ARRAY:C229($aNombres;$aIDs;$aCursos;$aCodigo;>)
			IT_UThermometer (-2;$procID)
		End if 
		For ($x;1;12)
			$totalMorosidadPtr:=Get pointer:C304("TotalMorosidad"+String:C10($x))
			$totalMorosidadPtr->:=0
		End for 
		$TotalMorosidad:=0
		$totAnualMorosidadtot:=0
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando y exportando morosidad para ")+$aNombres{1}+"...")
		For ($i;1;Size of array:C274($aIDs))
			USE SET:C118("$todos")
			If ($l_porApoderado=1)
				IO_SendPacket ($ref;String:C10($i;"####0")+"\t"+$aCodigo{$i}+"\t"+$aNombres{$i}+"\t")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$aIDs{$i})
			Else 
				IO_SendPacket ($ref;String:C10($i;"####0")+"\t"+$aCodigo{$i}+"\t"+$aNombres{$i}+"\t"+$aCursos{$i}+"\t")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$aIDs{$i})
			End if 
			  //agrego validacion para que solo se muestre la deuda
			  //If ($l_soloDeudas=1)
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
			  //End if 
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]EsRelativo=False)
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-129)
			CREATE SET:C116([ACT_Cargos:173];"Cargos")
			DIFFERENCE:C122("$todos";"Cargos";"$todos")
			$text:=""
			$Morosidad:=0
			$totAnualMorosidad:=0
			$totAnualProtestado:=0
			If ($l_fechaSeleccionada=1)
				$vd_fechaHasta:=vd_fechaCorte
			End if 
			For ($x;1;12)
				If ($l_fechaSeleccionada=0)
					$vd_fechaHasta:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($x;$year);$x;$year)
				End if 
				USE SET:C118("Cargos")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Año:14=$year;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$x;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
				ARRAY LONGINT:C221($al_CargosRecNum;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_CargosRecNum)
				  //$Morosidad:=Sum([ACT_Cargos]Saldo)*-1
				If ($l_soloPagosPeriodo=0)
					$Morosidad:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
				Else 
					$neto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*)))
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_fechaHasta;*)
					QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
					ARRAY LONGINT:C221($al_recNumTransacciones;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
					$MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
					$Morosidad:=$neto-$MontoPagado
				End if 
				$MontoProtestado:=0
				If ($l_incluirProtestado=1)  //si se seecciona protestado
					
					If ($l_soloPagosPeriodo=0)  //se valida si desea fecha de corte por mes o seleccionada
						$MontoProtestado:=ACTpgs_CalculaProtestado (->$al_CargosRecNum)  //se le agrega la fecha de corte
					Else 
						$MontoProtestado:=ACTpgs_CalculaProtestado (->$al_CargosRecNum;$vd_fechaHasta)  //se le agrega la fecha de corte
					End if 
					$Morosidad:=$Morosidad+$MontoProtestado
				End if 
				$totAnualProtestado:=$totAnualProtestado+$MontoProtestado
				$totAnualMorosidad:=$totAnualMorosidad+$Morosidad
				$text:=$text+String:C10($Morosidad)+"\t"
				$totalMorosidadPtr:=Get pointer:C304("TotalMorosidad"+String:C10($x))
				$totalMorosidadPtr->:=$totalMorosidadPtr->+$Morosidad
				$totAnualMorosidadtot:=$totAnualMorosidadtot+$Morosidad
			End for 
			$text:=$text+String:C10($totAnualMorosidad)+"\t"
			$text:=Substring:C12($text;1;Length:C16($text)-1)
			$text:=$text+"\r\n"
			IO_SendPacket ($ref;$text)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aIDs);__ ("Calculando y exportando morosidad para ")+$aNombres{$i}+"...")
		End for 
		CLEAR SET:C117("Cargos")
		
		$text:=$tabTotales+__ ("Totales")+"\t"
		For ($x;1;12)
			$totalMorosidadPtr:=Get pointer:C304("TotalMorosidad"+String:C10($x))
			$text:=$text+String:C10($totalMorosidadPtr->)+"\t"
		End for 
		$text:=$text+String:C10($totAnualMorosidadtot)+"\t"
		$text:=Substring:C12($text;1;Length:C16($text)-1)
		IO_SendPacket ($ref;$text)
		
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		CLOSE DOCUMENT:C267($ref)
		
		DOCUMENT TO BLOB:C525($vt_filePath;$x_blob)
		DELETE DOCUMENT:C159($vt_filePath)
	Else 
		CD_Dlog (0;__ ("Se produjo un error al intentar eliminar el archivo. El archivo puede estar abier"+"to "+"por otra aplicación. Ciérrelo e intente otra vez."))
	End if 
	USE CHARACTER SET:C205(*;0)
End if 
$0:=$x_blob
  // Modificado por: Saúl Ponce (26-09-2016), limpio el semaforo
CLEAR SEMAPHORE:C144("InformeServer")

