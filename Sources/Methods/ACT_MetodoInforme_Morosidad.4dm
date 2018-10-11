//%attributes = {"executedOnServer":true}
$sem:=Semaphore:C143("InformeServer")

C_BLOB:C604($x_blob;$0)
C_DATE:C307($vd_fechaHasta;$vd_fechaInicio;$vd_fechaTermino;vd_fechaCorte)
C_LONGINT:C283($d;$el;$SedeFlag)
C_POINTER:C301($TotalConvPtr;$TotalMorosidadPtr;$TotalPagadoPtr;$TotalPctMorosidadPtr)
C_TEXT:C284($aHeaderTextAño;$BoletasNumText;$col2;$Header1;$Header2;$HeaderText2;$HeaderTextRow2)

ARRAY LONGINT:C221($aBoletasNum;0)
ARRAY LONGINT:C221($aIDFamilia;0)
ARRAY LONGINT:C221($aIDs;0)
ARRAY LONGINT:C221($al_recNumsCargos;0)
ARRAY LONGINT:C221($al_recNumTransacciones;0)
ARRAY TEXT:C222($aCodigo;0)
ARRAY TEXT:C222($aCursos;0)
ARRAY TEXT:C222($aFamilias;0)
ARRAY TEXT:C222($aNombres;0)
ARRAY TEXT:C222($aRUT;0)
ARRAY TEXT:C222($aSede;0)
ARRAY TEXT:C222(atACT_Modo_de_Pago;0)

C_REAL:C285(TotalConv1;TotalConv2;TotalConv3;TotalConv4;TotalConv5;TotalConv6;TotalConv7;TotalConv8;TotalConv9;TotalConv10;TotalConv11;TotalConv12)
C_REAL:C285(TotalPagado1;TotalPagado2;TotalPagado3;TotalPagado4;TotalPagado5;TotalPagado6;TotalPagado7;TotalPagado8;TotalPagado9;TotalPagado10;TotalPagado11;TotalPagado12)
C_REAL:C285(TotalMorosidad1;TotalMorosidad2;TotalMorosidad3;TotalMorosidad4;TotalMorosidad5;TotalMorosidad6;TotalMorosidad7;TotalMorosidad8;TotalMorosidad9;TotalMorosidad10;TotalMorosidad11;TotalMorosidad12)
C_REAL:C285(TotalPctMorosidad1;TotalPctMorosidad2;TotalPctMorosidad3;TotalPctMorosidad4;TotalPctMorosidad5;TotalPctMorosidad6;TotalPctMorosidad7;TotalPctMorosidad8;TotalPctMorosidad9;TotalPctMorosidad10;TotalPctMorosidad11;TotalPctMorosidad12)
C_REAL:C285(TotalProtestado1;TotalProtestado2;TotalProtestado3;TotalProtestado4;TotalProtestado5;TotalProtestado6;TotalProtestado7;TotalProtestado8;TotalProtestado9;TotalProtestado10;TotalProtestado11;TotalProtestado12)
C_LONGINT:C283($l_idTermometro)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([Cursos:3])
cb_XApdo:=$1
cb_incluirProtestado:=$2
b1:=$3
b3:=$4
b5:=$5
b6:=$6
cb_fechaSeleccionada:=$7
cb_considerarSoloPagosPeriodo:=$8
vi_SelectedMonth:=$9
viAño2:=$10
vt_Fecha1:=$11
vt_Fecha2:=$12
vd_Fecha1:=$13
vd_Fecha2:=$14
cb_SoloActivas:=$15
cb_SoloDeudas:=$16
vt_Modo:=$17
viAño:=$18
vd_fechaCorte:=$19

COPY ARRAY:C226(<>atACT_ModosdePago;atACT_Modo_de_Pago)


$col5:=""
$SedeFlag:=0

If (cb_XApdo=1)
	$label1:=__ ("Apoderado")
	$label2:=__ ("Apdos")
	$col2:=__ ("Nº Cargas")
	$col3:=__ ("RUT")
	$col4:=__ ("Familia(s)")
Else 
	QUERY:C277([Cursos:3];[Cursos:3]Sede:19#"")
	$SedeFlag:=Records in selection:C76([Cursos:3])
	
	If ($SedeFlag>0)
		$label1:=__ ("Cuenta Corriente")
		$label2:=__ ("Ctas")
		$col2:=__ ("Curso")
		$col3:=__ ("Centro/Sede")
		$col4:=__ ("Código")
		$col5:=__ ("Familia(s)")
	Else 
		$label1:=__ ("Cuenta Corriente")
		$label2:=__ ("Ctas")
		$col2:=__ ("Curso")
		$col3:=__ ("Código")
		$col4:=__ ("Familia(s)")
	End if 
	
End if 
ARRAY TEXT:C222(aHeaders1;0)
  //Se agrega el o los numeros de boleta(s)
If (cb_incluirProtestado=0)
	ARRAY TEXT:C222(aHeaders2;5)
	aHeaders2{1}:=__ ("Nro Boleta")
	aHeaders2{2}:=__ ("Conv.")
	aHeaders2{3}:=__ ("Pagada")
	aHeaders2{4}:=__ ("Dif.")
	aHeaders2{5}:=__ ("Morosidad")
Else 
	ARRAY TEXT:C222(aHeaders2;6)
	aHeaders2{1}:=__ ("Nro Boleta")
	aHeaders2{2}:=__ ("Conv.")
	aHeaders2{3}:=__ ("Pagada")
	aHeaders2{4}:=__ ("Dif.")
	aHeaders2{5}:=__ ("Protestado")
	aHeaders2{6}:=__ ("Morosidad")
End if 
$howMany:=Size of array:C274(aHeaders2)-1
$HeaderText2:="\t"+AT_array2text (->aHeaders2;"\t")+"\r\n"
AT_Initialize (->aHeaders2)
COPY ARRAY:C226(<>atXS_MonthNames;aHeaders1)
For ($p;2;(($howmany+1)*10)+2;$howmany+1)
	INSERT IN ARRAY:C227(aHeaders1;$p;$howMany)
End for 
$HeaderText1:=AT_array2text (->aHeaders1;"\t")

If (cb_incluirProtestado=1)
	$HeaderTextAño:=("\t"*4)+$HeaderText1+("\t"*6)+__ ("Anual")+"\r\n"
Else 
	$HeaderTextAño:=("\t"*4)+$HeaderText1+("\t"*5)+__ ("Anual")+"\r\n"
End if 

  //Encabezado con y sin sede
If ($col5="")
	$HeaderTExtRow2:=$label1+"\t"+$col2+"\t"+$col3+"\t"+$col4
Else 
	$HeaderTExtRow2:=$label1+"\t"+$col2+"\t"+$col3+"\t"+$col4+"\t"+$col5
End if 

For ($p;1;13)
	$HeaderTExtRow2:=$HeaderTExtRow2+Substring:C12($HeaderText2;1;Length:C16($HeaderText2)-2)
End for 
$HeaderTExtRow2:=$HeaderTExtRow2+"\r\n"
$msg:=__ ("AccountTrack generará un archivo Excel con la morosidad por ")+$label1+__ (" para")
$msg2:=__ (" Esta operación puede ser larga. ¿Desea continuar?")
Case of 
	: (b1=1)
		$year:=Year of:C25(Current date:C33(*))
		$month:=Month of:C24(Current date:C33(*))
		$day:=Day of:C23(Current date:C33(*))
		$fileName:=String:C10($year)+<>atXS_MonthNames{$month}+String:C10($day)
		$titulo:=__ ("Morosidad por ")+$label1+__ (" para el dia ")+String:C10($day)+__ (" de ")+<>atXS_MonthNames{$month}+__ (" de ")+String:C10($year)
		  //cambios en encabezado
		If ($col5="")
			$Header1:=$label1+"\t"+$col2+"\t"+$col3+"\t"+$col4+$HeaderText2
		Else 
			$Header1:=$label1+"\t"+$col2+"\t"+$col3+"\t"+$col4+"\t"+$col5+$HeaderText2
		End if 
		
		$Header2:=""
		$msg:=$msg+__ (" el día de hoy.")+$msg2
		$vd_fechaHasta:=DT_GetDateFromDayMonthYear ($day;$month;$year)
		
		$vd_fechaInicio:=Current date:C33(*)
		$vd_fechaTermino:=$vd_fechaInicio
		
	: (b3=1)
		$year:=viAño
		$month:=vi_SelectedMonth
		$fileName:=String:C10($year)+<>atXS_MonthNames{vi_SelectedMonth}
		$titulo:=__ ("Morosidad por ")+$label1+__ (" para el mes de ")+<>atXS_MonthNames{vi_SelectedMonth}+" "+String:C10($year)
		
		  //cambios en encabezado
		If ($col5="")
			$Header1:=$label1+"\t"+$col2+"\t"+$col3+"\t"+$col4+$HeaderText2
		Else 
			$Header1:=$label1+"\t"+$col2+"\t"+$col3+"\t"+$col4+"\t"+$col5+$HeaderText2
		End if 
		
		$Header2:=""
		$msg:=$msg+__ (" el mes de ")+<>atXS_MonthNames{$month}+" "+String:C10($year)+"."+$msg2
		$vd_fechaHasta:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($month;$year);$month;$year)
		
		$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;$month;$year)
		$vd_fechaTermino:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($month;$year);$month;$year)
	: (b5=1)
		$year:=viAño2
		$fileName:=String:C10($year)
		$titulo:=__ ("Morosidad por ")+$label1+__ (" para el año ")+String:C10($year)
		$Header1:=$HeaderTextAño
		$Header2:=$HeaderTExtRow2
		$msg:=$msg+__ (" el año ")+String:C10($year)+"."+$msg2
		$vd_fechaHasta:=DT_GetDateFromDayMonthYear (31;12;$year)
		
		  //PS 21-09-12 se corrige fecha $vd_fechaInicio
		  //$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;12;$year)
		$vd_fechaInicio:=DT_GetDateFromDayMonthYear (1;1;$year)
		$vd_fechaTermino:=DT_GetDateFromDayMonthYear (31;12;$year)
	: (b6=1)
		$dateInicial:=Replace string:C233(Replace string:C233(vt_Fecha1;"/";"-");":";"-")
		$dateFinal:=Replace string:C233(Replace string:C233(vt_Fecha2;"/";"-");":";"-")
		$fileName:=$dateInicial+"al"+$dateFinal
		$titulo:=__ ("Morosidad por ")+$label1+__ (" entre el ")+vt_Fecha1+__ (" y el ")+vt_Fecha2
		  //cambios en encabezado
		If ($col5="")
			$Header1:=$label1+"\t"+$col2+"\t"+$col3+"\t"+$col4+$HeaderText2
		Else 
			$Header1:=$label1+"\t"+$col2+"\t"+$col3+"\t"+$col4+"\t"+$col5+$HeaderText2
		End if 
		$Header2:=""
		$msg:=$msg+__ (" el período entre el ")+vt_Fecha1+__ (" y el ")+vt_Fecha2+"."+$msg2
		$vd_fechaHasta:=vd_Fecha2
		
		$vd_fechaInicio:=vd_Fecha1
		$vd_fechaTermino:=vd_Fecha2
End case 

If (cb_fechaSeleccionada=1)
	$vd_fechaHasta:=vd_fechaCorte
End if 



If (cb_considerarSoloPagosPeriodo=1)
	$titulo:=$titulo+__ (" - El informe considera los pagos ingresados hasta el ")+String:C10($vd_fechaHasta)
End if 
$titulo:=$titulo+"\r\n"+"\r\n"+"\r\n"
$fileName:="InfoMorosidad_General_"+$label2+"_"+$fileName

If (cb_incluirProtestado=1)
	$fileName:=$fileName+"_IncProt"
End if 
$r:=1


If ($r=1)
	$fileName:="IMG"+DTS_MakeFromDateTime 
	$vt_filePath:=Temporary folder:C486+$fileName+".txt"
	SYS_DeleteFile ($vt_filePath)
	If (ok=1)
		USE CHARACTER SET:C205("windows-1252";0)
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		$ref:=Create document:C266($vt_filePath;"TEXT")
		EM_ErrorManager ("Clear")
		If ($ref#?00:00:00?)
			IO_SendPacket ($ref;$titulo)
			IO_SendPacket ($ref;$Header1)
			IO_SendPacket ($ref;$Header2)
			If (cb_SoloActivas=1)
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			Else 
				ALL RECORDS:C47([ACT_CuentasCorrientes:175])
			End if 
			READ ONLY:C145([Familia_RelacionesFamiliares:77])
			READ ONLY:C145([Familia:78])
			
			If (cb_XApdo=1)
				  //KRL_RelateSelection (->[Personas]No;->[ACT_CuentasCorrientes]ID_Apoderado;"")
				READ ONLY:C145([ACT_Cargos:173])
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaInicio;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaTermino;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-2;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
				  //ABC//Filtro para saber que cargos usar en el modelo.208539 26-07-2018
				  ///////PARA RESPETAR LAS OPCIONES DE LA VENTANA, COMO INCLUIR PROTESTADO Y CONSIDERAR LA DEUDA COMO FECHA DE CORTE
				C_REAL:C285($MontoPagado;$MontoConvenido;$Morosidad;$MontoProtestado)
				ARRAY LONGINT:C221($al_Temporal;0)
				ARRAY LONGINT:C221($al_CargosUsar;0)
				ACTcar_ValidaOpcionMorosidad (cb_SoloDeudas;cb_considerarSoloPagosPeriodo;$vd_fechaHasta;cb_incluirProtestado)
				  ////ABCTodo este codigo es nuevo para verificar los cargos a utilizar en el informe.
				  /////////***************
				
				  //creo un set de cargos para consultar sobre una seleccion y no sobre toda la bd
				  //160021
				CREATE SET:C116([ACT_Cargos:173];"cargos_todos")
				KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Cargos:173]ID_Apoderado:18;"")
				cb_SoloActivas:=0
				$el:=Find in array:C230(atACT_Modo_de_Pago;vt_Modo)
				If ($el#-1)
					  //20121005 RCH Se maneja este campo para las formas de pago en tabla.
					  //QUERY SELECTION([Personas];[Personas]ACT_Modo_de_pago=atACT_Modo_de_Pago{$el})
					QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_modo_de_pago_new:95=atACT_Modo_de_Pago{$el})
				End if 
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;$aNombres;[Personas:7]No:1;$aIDs;[Personas:7]RUT:6;$aRUT)
				ARRAY TEXT:C222($aNumHijos;Size of array:C274($aIDs))
				For ($uuu;1;Size of array:C274($aNumHijos))
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=$aIDs{$uuu})
					If (cb_SoloActivas=1)
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					End if 
					$aNumHijos{$uuu}:=String:C10(Records in selection:C76([ACT_CuentasCorrientes:175]))
					
					QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=$aIDs{$uuu})
					SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Familia:2;$aIDFamilia)
					INSERT IN ARRAY:C227($aFamilias;Size of array:C274($aFamilias)+1;1)
					For ($i;1;Size of array:C274($aIDFamilia))
						QUERY:C277([Familia:78];[Familia:78]Numero:1=$aIDFamilia{$i})
						$aFamilias{Size of array:C274($aFamilias)}:=$aFamilias{Size of array:C274($aFamilias)}+[Familia:78]Nombre_de_la_familia:3+"-"
					End for 
					$aFamilias{Size of array:C274($aFamilias)}:=Substring:C12($aFamilias{Size of array:C274($aFamilias)};1;Length:C16($aFamilias{Size of array:C274($aFamilias)})-1)
				End for 
				SORT ARRAY:C229($aNombres;$aIDs;$aNumHijos;$aRUT;$aFamilias;>)
			Else 
				$procID:=IT_UThermometer (1;0;"Recopilando información de las cuentas...")
				  //10-09-2015 JVP ticket 145508
				  // /codigo nuevo para mostar solo las personas con deuda
				READ ONLY:C145([ACT_Cargos:173])
				KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaInicio;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaTermino;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-129;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-2;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
				
				ACTcar_ValidaOpcionMorosidad (cb_SoloDeudas;cb_considerarSoloPagosPeriodo;$vd_fechaHasta;cb_incluirProtestado)
				KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
				  //creo un set de cargos para consultar sobre una seleccion y no sobre toda la bd
				  //160021
				CREATE SET:C116([ACT_Cargos:173];"cargos_todos")
				
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$aIDs;[ACT_CuentasCorrientes:175]Codigo:19;$aCodigo;[Alumnos:2]apellidos_y_nombres:40;$aNombres;[Alumnos:2]curso:20;$aCursos;[Alumnos:2]Familia_Número:24;$aIDFamilia;[Familia:78]Nombre_de_la_familia:3;$aFamilias)
				  //búsqueda de sedes cuando hay registradas en cursos
				If ($SedeFlag>0)
					  //declaro var y array de sede
					
					For ($d;1;Size of array:C274($aCursos))
						QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$aCursos{$d})
						APPEND TO ARRAY:C911($aSede;[Cursos:3]Sede:19)
					End for 
					SORT ARRAY:C229($aNombres;$aIDs;$aSede;$aCursos;$aCodigo;$aFamilias;>)
				Else 
					SORT ARRAY:C229($aNombres;$aIDs;$aCursos;$aCodigo;$aFamilias;>)
				End if 
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				IT_UThermometer (-2;$procID)
			End if 
			For ($x;1;12)
				$totalConvPtr:=Get pointer:C304("TotalConv"+String:C10($x))
				$totalPagadoPtr:=Get pointer:C304("TotalPagado"+String:C10($x))
				$totalMorosidadPtr:=Get pointer:C304("TotalMorosidad"+String:C10($x))
				$totalPctMorosidadPtr:=Get pointer:C304("TotalPctMorosidad"+String:C10($x))
				$totalProtestadoPtr:=Get pointer:C304("TotalProtestado"+String:C10($x))
				$totalConvPtr->:=0
				$totalPagadoPtr->:=0
				$totalMorosidadPtr->:=0
				$totalPctMorosidadPtr->:=0
				$totalProtestadoPtr->:=0
			End for 
			$TotalConv:=0
			$TotalPagado:=0
			$TotalMorosidad:=0
			$TotalProtestado:=0
			$TotalPctMorosidad:=0
			$totAnualConvtot:=0
			$totAnualPagadotot:=0
			$totAnualMorosidadtot:=0
			$PctAnualMorosidadtot:=0
			$totAnualProtestadotot:=0
			
			$l_idTermometro:=IT_Progress (1;0;0;__ ("Recopilando información y generando archivo..."))
			For ($i;1;Size of array:C274($aIDs))
				USE SET:C118("cargos_todos")
				If (cb_XApdo=1)
					IO_SendPacket ($ref;$aNombres{$i}+"\t"+$aNumHijos{$i}+"\t"+$aRUT{$i}+"\t"+$aFamilias{$i}+"\t")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$aIDs{$i})
				Else 
					  //impresión de detalle con o sin sede
					If ($SedeFlag>0)
						IO_SendPacket ($ref;$aNombres{$i}+"\t"+$aCursos{$i}+"\t"+$aSede{$i}+"\t"+$aCodigo{$i}+"\t"+$aFamilias{$i}+"\t")
					Else 
						IO_SendPacket ($ref;$aNombres{$i}+"\t"+$aCursos{$i}+"\t"+$aCodigo{$i}+"\t"+$aFamilias{$i}+"\t")
					End if 
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$aIDs{$i})
				End if 
				
				
				CREATE SET:C116([ACT_Cargos:173];"Cargos")
				DIFFERENCE:C122("cargos_todos";"Cargos";"cargos_todos")
				
				$text:=""
				$MontoConvenido:=0
				$MontoPagado:=0
				$Morosidad:=0
				$PctMorosidad:=0
				$MontoProtestado:=0
				Case of 
					: (b1=1)
						USE SET:C118("Cargos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=Current date:C33(*))
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos;"")
						If (cb_considerarSoloPagosPeriodo=1)
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_fechaHasta;*)
							QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
							$MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
						Else 
							$MontoPagado:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
						End if 
						$MontoConvenido:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNumsCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						$Morosidad:=$MontoConvenido-$MontoPagado
						
						  //Búsqueda de boletas
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$aBoletasNum)
						$BoletasNumText:=AT_array2text (->$aBoletasNum;" - ")
						If (cb_incluirProtestado=1)
							$MontoProtestado:=ACTpgs_CalculaProtestado (->$al_recNumsCargos;$vd_fechaHasta)
							$Morosidad:=$Morosidad+$MontoProtestado
						End if 
						
						$PctMorosidad:=0
						$PctMorosidad:=(($Morosidad*100)/$MontoConvenido)  //calculo de morosidad
						
						If (cb_incluirProtestado=1)
							$text:=$text+$BoletasNumText+"\t"+String:C10($MontoConvenido)+"\t"+String:C10($MontoPagado)+"\t"+String:C10($Morosidad)+"\t"+String:C10($MontoProtestado)+"\t"+String:C10($PctMorosidad;"|Pct_2DecIfNec")+"\r\n"
						Else 
							$text:=$text+$BoletasNumText+"\t"+String:C10($MontoConvenido)+"\t"+String:C10($MontoPagado)+"\t"+String:C10($Morosidad)+"\t"+String:C10($PctMorosidad;"|Pct_2DecIfNec")+"\r\n"
						End if 
						  //$text:=$text+$BoletasNumText+<>tb+String($MontoConvenido)+<>tb+String($MontoPagado)+<>tb+String($Morosidad)+<>tb+String($PctMorosidad;"|Pct_2DecIfNec")+<>crlf
						IO_SendPacket ($ref;$text)
						$TotalConv:=$TotalConv+$MontoConvenido
						$TotalPagado:=$TotalPagado+$MontoPagado
						$TotalMorosidad:=$TotalMorosidad+$Morosidad
						$TotalProtestado:=$TotalProtestado+$MontoProtestado
						  //FIN CASE B1
						
						
						
					: (b3=1)
						
						USE SET:C118("Cargos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Año:14=$year;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
						  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item#-2)
						
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos;"")
						If (cb_considerarSoloPagosPeriodo=1)
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_fechaHasta;*)
							QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
							$MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
						Else 
							$MontoPagado:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
						End if 
						$MontoConvenido:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNumsCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						$Morosidad:=$MontoConvenido-$MontoPagado
						
						  //Búsqueda de boletas
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$aBoletasNum)
						$BoletasNumText:=AT_array2text (->$aBoletasNum;" - ")
						
						If (cb_incluirProtestado=1)
							$MontoProtestado:=ACTpgs_CalculaProtestado (->$al_recNumsCargos;$vd_fechaHasta)
							$Morosidad:=$Morosidad+$MontoProtestado
						End if 
						
						$PctMorosidad:=0
						$PctMorosidad:=(($Morosidad*100)/$MontoConvenido)
						  //se incluye en el detalle las boletas
						If (cb_incluirProtestado=1)
							$text:=$text+$BoletasNumText+"\t"+String:C10($MontoConvenido)+"\t"+String:C10($MontoPagado)+"\t"+String:C10($Morosidad)+"\t"+String:C10($MontoProtestado)+"\t"+String:C10($PctMorosidad;"|Pct_2DecIfNec")+"\r\n"
						Else 
							$text:=$text+$BoletasNumText+"\t"+String:C10($MontoConvenido)+"\t"+String:C10($MontoPagado)+"\t"+String:C10($Morosidad)+"\t"+String:C10($PctMorosidad;"|Pct_2DecIfNec")+"\r\n"
						End if 
						
						IO_SendPacket ($ref;$text)
						$TotalConv:=$TotalConv+$MontoConvenido
						$TotalPagado:=$TotalPagado+$MontoPagado
						$TotalMorosidad:=$TotalMorosidad+$Morosidad
						$TotalProtestado:=$TotalProtestado+$MontoProtestado
					: (b5=1)  //Aca lo hace por año
						$totAnualConv:=0
						$totAnualPagado:=0
						$totAnualMorosidad:=0
						$PctAnualMorosidad:=0
						$totAnualProtestado:=0
						For ($x;1;12)
							USE SET:C118("Cargos")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Año:14=$year;*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$x;*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
							  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item#-2)
							  //$MontoConvenido:=Sum([ACT_Cargos]Monto_Neto)+Sum([ACT_Cargos]Intereses)
							  //$MontoConvenido:=Sum([ACT_Cargos]Monto_Neto)
							  //$MontoPagado:=Sum([ACT_Cargos]MontosPagados)
							  //$Morosidad:=Sum([ACT_Cargos]Saldo)*-1
							ARRAY LONGINT:C221($al_recNumsCargos;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos;"")
							If (cb_considerarSoloPagosPeriodo=1)
								KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
								QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_fechaHasta;*)
								QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
								LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
								$MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
							Else 
								$MontoPagado:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
							End if 
							$MontoConvenido:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNumsCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							$Morosidad:=$MontoConvenido-$MontoPagado
							
							  //Búsqueda de boletas
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
							SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$aBoletasNum)
							$BoletasNumText:=AT_array2text (->$aBoletasNum;" - ")
							
							$Protestado:=0
							If (cb_incluirProtestado=1)
								$Protestado:=ACTpgs_CalculaProtestado (->$al_recNumsCargos;$vd_fechaHasta)
								$Morosidad:=$Morosidad+$Protestado
							End if 
							
							$PctMorosidad:=0
							$PctMorosidad:=(($Morosidad*100)/$MontoConvenido)
							
							$totAnualConv:=$totAnualConv+$MontoConvenido
							$totAnualPagado:=$totAnualPagado+$MontoPagado
							$totAnualMorosidad:=$totAnualMorosidad+$Morosidad
							$totAnualProtestado:=$totAnualProtestado+$Protestado
							
							If (cb_incluirProtestado=1)
								$text:=$text+$BoletasNumText+"\t"+String:C10($MontoConvenido)+"\t"+String:C10($MontoPagado)+"\t"+String:C10($Morosidad)+"\t"+String:C10($Protestado)+"\t"+String:C10($PctMorosidad;"|Pct_2DecIfNec")+"\t"
							Else 
								$text:=$text+$BoletasNumText+"\t"+String:C10($MontoConvenido)+"\t"+String:C10($MontoPagado)+"\t"+String:C10($Morosidad)+"\t"+String:C10($PctMorosidad;"|Pct_2DecIfNec")+"\t"
							End if 
							
							$totalConvPtr:=Get pointer:C304("TotalConv"+String:C10($x))
							$totalPagadoPtr:=Get pointer:C304("TotalPagado"+String:C10($x))
							$totalMorosidadPtr:=Get pointer:C304("TotalMorosidad"+String:C10($x))
							$totalProtestadoPtr:=Get pointer:C304("TotalProtestado"+String:C10($x))
							
							$totalConvPtr->:=$totalConvPtr->+$MontoConvenido
							$totalPagadoPtr->:=$totalPagadoPtr->+$MontoPagado
							$totalMorosidadPtr->:=$totalMorosidadPtr->+$Morosidad
							$totalProtestadoPtr->:=$totalProtestadoPtr->+$Protestado
							
							$totAnualConvtot:=$totAnualConvtot+$MontoConvenido
							$totAnualPagadotot:=$totAnualPagadotot+$MontoPagado
							$totAnualMorosidadtot:=$totAnualMorosidadtot+$Morosidad
							$totAnualProtestadotot:=$totAnualProtestadotot+$Protestado
						End for   //for por los meses
						
						$PctAnualMorosidadtot:=0
						$PctAnualMorosidadtot:=(($totAnualMorosidadtot*100)/$totAnualConvtot)
						
						If (cb_incluirProtestado=1)
							$text:=$text+"\t"+String:C10($totAnualConv)+"\t"+String:C10($totAnualPagado)+"\t"+String:C10($totAnualMorosidad)+"\t"+String:C10($totAnualProtestado)+"\t"+String:C10($PctAnualMorosidad;"|Pct_2DecIfNec")+"\t"
						Else 
							$text:=$text+"\t"+String:C10($totAnualConv)+"\t"+String:C10($totAnualPagado)+"\t"+String:C10($totAnualMorosidad)+"\t"+String:C10($PctAnualMorosidad;"|Pct_2DecIfNec")+"\t"
						End if 
						
						$text:=Substring:C12($text;1;Length:C16($text)-1)
						$text:=$text+"\r\n"
						IO_SendPacket ($ref;$text)
						  //B5
					: (b6=1)
						USE SET:C118("Cargos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=vd_Fecha1;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=vd_Fecha2)
						  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item#-2)
						  //$MontoConvenido:=Sum([ACT_Cargos]Monto_Neto)
						  //$MontoPagado:=Sum([ACT_Cargos]MontosPagados)
						  //$Morosidad:=Sum([ACT_Cargos]Saldo)*-1
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos;"")
						If (cb_considerarSoloPagosPeriodo=1)
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_fechaHasta;*)
							QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
							$MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
						Else 
							$MontoPagado:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
						End if 
						$MontoConvenido:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNumsCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						$Morosidad:=$MontoConvenido-$MontoPagado
						
						  //Búsqueda de boletas
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
						SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$aBoletasNum)
						$BoletasNumText:=AT_array2text (->$aBoletasNum;" - ")
						
						$MontoProtestado:=0
						If (cb_incluirProtestado=1)
							$MontoProtestado:=ACTpgs_CalculaProtestado (->$al_recNumsCargos;$vd_fechaHasta)
							$Morosidad:=$Morosidad+$MontoProtestado
						End if 
						
						$PctMorosidad:=0
						$PctMorosidad:=(($Morosidad*100)/$MontoConvenido)
						
						If (cb_incluirProtestado=1)
							$text:=$text+$BoletasNumText+"\t"+String:C10($MontoConvenido)+"\t"+String:C10($MontoPagado)+"\t"+String:C10($Morosidad)+"\t"+String:C10($MontoProtestado)+"\t"+String:C10($PctMorosidad;"|Pct_2DecIfNec")+"\r\n"
						Else 
							$text:=$text+$BoletasNumText+"\t"+String:C10($MontoConvenido)+"\t"+String:C10($MontoPagado)+"\t"+String:C10($Morosidad)+"\t"+String:C10($PctMorosidad;"|Pct_2DecIfNec")+"\r\n"
						End if 
						
						IO_SendPacket ($ref;$text)
						$TotalConv:=$TotalConv+$MontoConvenido
						$TotalPagado:=$TotalPagado+$MontoPagado
						$TotalMorosidad:=$TotalMorosidad+$Morosidad
						$TotalProtestado:=$TotalProtestado+$MontoProtestado
						  //B6
						
				End case 
				$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($aIDs))
				  //CD_THERMOMETREXSEC (0;$i/Size of array($aIDs)*100;__ ("Calculando y exportando morosidad para ")+$aNombres{$i}+"...")
			End for   //////FOR Por Apoderado
			
			$PctAnualMorosidadtot:=0
			$TotalMorosidad:=$TotalConv-$TotalPagado
			$TotalMorosidad:=$TotalMorosidad+$TotalProtestado
			$PctAnualMorosidadtot:=(($TotalMorosidad*100)/$TotalConv)
			
			
			CLEAR SET:C117("Cargos")
			
			  /////TOTALES DEL PIE
			Case of 
				: (b1=1)
					$TotalPctMorosidad:=0
					$TotalPctMorosidad:=(($TotalMorosidad*100)/$TotalConv)
					
					If (cb_incluirProtestado=1)
						$text:=("\t"*4)+"Totales"+"\t"+String:C10($TotalConv)+"\t"+String:C10($TotalPagado)+"\t"+String:C10($TotalMorosidad)+"\t"+String:C10($TotalProtestado)+"\t"+String:C10($TotalPctMorosidad;"|Pct_2DecIfNec")
					Else 
						$text:=("\t"*4)+"Totales"+"\t"+String:C10($TotalConv)+"\t"+String:C10($TotalPagado)+"\t"+String:C10($TotalMorosidad)+"\t"+String:C10($TotalPctMorosidad;"|Pct_2DecIfNec")
					End if 
					IO_SendPacket ($ref;$text)
				: (b3=1)
					
					$TotalPctMorosidad:=0
					$TotalPctMorosidad:=(($TotalMorosidad*100)/$TotalConv)
					  //If ($TotalConv>0)
					  //$TotalPctMorosidad:=(1-($TotalPagado/$TotalConv)*100)
					  //Else 
					  //$TotalPctMorosidad:=0
					  //End if 
					If ($SedeFlag>0)
						If (cb_incluirProtestado=1)
							$text:=("\t"*5)+"Totales"+"\t"+String:C10($TotalConv)+"\t"+String:C10($TotalPagado)+"\t"+String:C10($TotalMorosidad)+"\t"+String:C10($TotalProtestado)+"\t"+String:C10($TotalPctMorosidad;"|Pct_2DecIfNec")
						Else 
							$text:=("\t"*5)+"Totales"+"\t"+String:C10($TotalConv)+"\t"+String:C10($TotalPagado)+"\t"+String:C10($TotalMorosidad)+"\t"+String:C10($TotalPctMorosidad;"|Pct_2DecIfNec")
						End if 
					Else 
						If (cb_incluirProtestado=1)
							$text:=("\t"*4)+"Totales"+"\t"+String:C10($TotalConv)+"\t"+String:C10($TotalPagado)+"\t"+String:C10($TotalMorosidad)+"\t"+String:C10($TotalProtestado)+"\t"+String:C10($TotalPctMorosidad;"|Pct_2DecIfNec")
						Else 
							$text:=("\t"*4)+"Totales"+"\t"+String:C10($TotalConv)+"\t"+String:C10($TotalPagado)+"\t"+String:C10($TotalMorosidad)+"\t"+String:C10($TotalPctMorosidad;"|Pct_2DecIfNec")
						End if 
					End if 
					IO_SendPacket ($ref;$text)
				: (b5=1)  //por el año
					
					$text:=("\t"*4)+"Totales"+"\t"
					For ($x;1;12)
						$totalConvPtr:=Get pointer:C304("TotalConv"+String:C10($x))
						$totalPagadoPtr:=Get pointer:C304("TotalPagado"+String:C10($x))
						$totalPctMorosidadPtr:=Get pointer:C304("TotalPctMorosidad"+String:C10($x))
						$totalMorosidadPtr:=Get pointer:C304("TotalMorosidad"+String:C10($x))
						$totalProtestadoPtr:=Get pointer:C304("TotalProtestado"+String:C10($x))
						
						  ///abc aca se calcula el porcentaje del pie
						$TotalPctMorosidad:=$totalConvPtr->-$totalPagadoPtr->
						$TotalPctMorosidad:=$TotalPctMorosidad+$totalProtestadoPtr->
						$totalPctMorosidadPtr->:=(($TotalPctMorosidad*100)/$totalConvPtr->)
						If (cb_incluirProtestado=1)
							$text:=$text+String:C10($totalConvPtr->)+"\t"+String:C10($totalPagadoPtr->)+"\t"+String:C10($totalMorosidadPtr->)+"\t"+String:C10($totalProtestadoPtr->)+"\t"+String:C10($totalPctMorosidadPtr->;"|Pct_2DecIfNec")+"\t\t"
						Else 
							$text:=$text+String:C10($totalConvPtr->)+"\t"+String:C10($totalPagadoPtr->)+"\t"+String:C10($totalMorosidadPtr->)+"\t"+String:C10($totalPctMorosidadPtr->;"|Pct_2DecIfNec")+"\t\t"
						End if 
					End for 
					$totAnualMorosidadtot:=$totAnualConvtot-$totAnualPagadotot
					$TotalPctMorosidad:=0
					$TotalPctMorosidad:=(($totAnualMorosidadtot*100)/$totalConvPtr->)
					
					If (cb_incluirProtestado=1)
						$text:=$text+String:C10($totAnualConvtot)+"\t"+String:C10($totAnualPagadotot)+"\t"+String:C10($totAnualMorosidadtot)+"\t"+String:C10($totAnualProtestadotot)+"\t"+String:C10($PctAnualMorosidadtot;"|Pct_2DecIfNec")+"\t"
					Else 
						$text:=$text+String:C10($totAnualConvtot)+"\t"+String:C10($totAnualPagadotot)+"\t"+String:C10($totAnualMorosidadtot)+"\t"+String:C10($PctAnualMorosidadtot;"|Pct_2DecIfNec")+"\t"
					End if 
					$text:=Substring:C12($text;1;Length:C16($text)-1)
					IO_SendPacket ($ref;$text)
				: (b6=1)
					$TotalMorosidad:=$TotalConv-$TotalPagado
					$TotalMorosidad:=$TotalMorosidad+$TotalProtestado
					$TotalPctMorosidad:=0
					$TotalPctMorosidad:=(($TotalMorosidad*100)/$TotalConv)
					If (cb_incluirProtestado=1)
						$text:=("\t"*4)+"Totales"+"\t"+String:C10($TotalConv)+"\t"+String:C10($TotalPagado)+"\t"+String:C10($TotalMorosidad)+"\t"+String:C10($TotalProtestado)+"\t"+String:C10($TotalPctMorosidad;"|Pct_2DecIfNec")
					Else 
						$text:=("\t"*4)+"Totales"+"\t"+String:C10($TotalConv)+"\t"+String:C10($TotalPagado)+"\t"+String:C10($TotalMorosidad)+"\t"+String:C10($TotalPctMorosidad;"|Pct_2DecIfNec")
					End if 
					IO_SendPacket ($ref;$text)
			End case 
			$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
			CLOSE DOCUMENT:C267($ref)
			DOCUMENT TO BLOB:C525($vt_filePath;$x_blob)
			DELETE DOCUMENT:C159($vt_filePath)
		Else 
			CD_Dlog (0;__ ("Se produjo un error al intentar crear el archivo. El archivo puede estar abierto por otra aplicación. Ciérrelo e intente otra vez."))
		End if 
		USE CHARACTER SET:C205(*;0)
	Else 
		CD_Dlog (0;__ ("Se produjo un error al intentar eliminar el archivo. El archivo puede estar abier"+"to "+"por otra aplicación. Ciérrelo e intente otra vez."))
	End if 
End if 
CLEAR SEMAPHORE:C144("InformeServer")
$0:=$x_blob

