//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Alexis Bustamante
  // Fecha y hora: 27-07-18, 11:51:48
  // ----------------------------------------------------
  // Método: ACTcar_ValidaOpcionMorosidad
  // Descripción
  // El método trabaja con la seleccion Previa de Registros de Tabla [ACT_Cargos]
  //y dejará los cargos en seleccion
  // Parámetros
  //$1-> para buscar solo cargos con deudas
  //$2->Considerar esta fecha para corte de pago, esto permite saber si considerar o no transacion y pagos 
  //$3->Fecha de corte a utilizar, si se pasa vacía, no se ejecuta query
  //$4-> si se desea buscar deuda por protestado del cargo que se recorre
  // ----------------------------------------------------
C_REAL:C285($MontoPagado;$MontoConvenido;$Morosidad;$MontoProtestado)
ARRAY LONGINT:C221($al_Temporal;0)
ARRAY LONGINT:C221($al_CargosUsar;0)
ARRAY LONGINT:C221($al_recNumTransacciones;0)
C_DATE:C307($vd_fechaHasta;$3)
C_LONGINT:C283($1;$2;$i)
C_LONGINT:C283($thermo)
C_LONGINT:C283($cb_considerarSoloPagosPeriodo;$cb_SoloDeudas;$cb_incluirProtestado)

$cb_SoloDeudas:=$1
$cb_considerarSoloPagosPeriodo:=$2
$vd_fechaHasta:=$3
$cb_incluirProtestado:=$4
If ($cb_SoloDeudas=1)
	SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_Temporal)
	$thermo:=IT_Progress (1;0;0;"")
	
	For ($i;1;Size of array:C274($al_Temporal))
		$thermo:=IT_Progress (0;$thermo;$i/Size of array:C274($al_Temporal);"Validando cargos con deuda...")
		GOTO RECORD:C242([ACT_Cargos:173];$al_Temporal{$i})
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
		If ($cb_considerarSoloPagosPeriodo=1)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_fechaHasta;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
		Else 
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
			ARRAY LONGINT:C221($al_recNumTransacciones;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
		End if 
		$MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
		ARRAY LONGINT:C221($al_recNumsCargos;0)
		APPEND TO ARRAY:C911($al_recNumsCargos;$al_Temporal{$i})
		$MontoConvenido:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNumsCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
		$Morosidad:=0
		$Morosidad:=$MontoConvenido-$MontoPagado
		If ($cb_incluirProtestado=1)
			$MontoProtestado:=ACTpgs_CalculaProtestado (->$al_recNumsCargos;$vd_fechaHasta)
			$Morosidad:=$Morosidad+$MontoProtestado
		End if 
		If ($cb_SoloDeudas=1)
			If ($Morosidad#0)
				APPEND TO ARRAY:C911($al_CargosUsar;$al_Temporal{$i})
			End if 
		End if 
	End for 
	$thermo:=IT_Progress (-1;$thermo;$i/Size of array:C274($al_Temporal);"")
	CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_CargosUsar)
Else 
	  //todos
	If ($cb_considerarSoloPagosPeriodo=1)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_Temporal)
		$thermo:=IT_Progress (1;0;0;"")
		For ($i;1;Size of array:C274($al_Temporal))
			$thermo:=IT_Progress (0;$thermo;$i/Size of array:C274($al_Temporal);"Validando cargos con deuda...")
			GOTO RECORD:C242([ACT_Cargos:173];$al_Temporal{$i})
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_fechaHasta;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
			$MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
			ARRAY LONGINT:C221($al_recNumsCargos;0)
			APPEND TO ARRAY:C911($al_recNumsCargos;$al_Temporal{$i})
			$MontoConvenido:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_recNumsCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			$Morosidad:=0
			$Morosidad:=$MontoConvenido-$MontoPagado
			If ($cb_incluirProtestado=1)
				$MontoProtestado:=ACTpgs_CalculaProtestado (->$al_recNumsCargos;$vd_fechaHasta)
				$Morosidad:=$Morosidad+$MontoProtestado
			End if 
			If ($Morosidad#0)
				APPEND TO ARRAY:C911($al_CargosUsar;$al_Temporal{$i})
			End if 
		End for 
		$thermo:=IT_Progress (-1;$thermo;$i/Size of array:C274($al_Temporal);"")
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_CargosUsar)
	Else 
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_CargosUsar)
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_CargosUsar)
		  //se usan todos los cargos encontrados si no esta la fecha de corte no se calcula nada.
		  //dejo el ELse para no confundir
	End if 
End if   //if solo con deuda o todos 
