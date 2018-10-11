//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce, Ticket N° 179864 
  // Fecha y hora: 04-05-17, 13:26:35
  // ----------------------------------------------------
  // Método: ACTpgs_validaFechaPago
  // Descripción: Validar a partir de la configuración (cb_noPagosConFechasAnteriores) la posibilidad de registrar pagos con fechas anteriores a la del último pago ingresado
  // 
  //
  // Parámetros: $1 corresponde a la fecha de pago que se necesita validar.
  // Retorno: "ok" de tipo texto en caso de que se pueda registrar el pago con la fecha pasada en $1 y. En caso contrario, se retorna el mensaje para mostrar al usuario.
  // 
  // Registro de cambios:
  // 
  // 01.- Reescribì el còdigo para añadir las sugerencias de Roberto.
  // ----------------------------------------------------



C_DATE:C307($2)
C_TEXT:C284($0;$1)
C_LONGINT:C283($3)

C_DATE:C307($vd_fechaDelPago)
C_BOOLEAN:C305($vb_estaModificandoPago)
C_TEXT:C284($vt_accion;$vt_retorno;$vt_dtsCreacion;$vt_msg)

$vt_retorno:=""

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$vd_fechaDelPago:=$2
End if 
If (Count parameters:C259>=3)
	$vl_recNumPago:=$3
End if 




If (cb_noPagosConFechasAnteriores=1)
	
	C_TIME:C306($vt_time)
	C_TEXT:C284($vt_DTSFechaPago)
	C_DATE:C307($vd_ultimoPago)
	
	$vt_dtsCreacion:=""
	$vt_time:=?00:00:00?
	$vd_ultimoPago:=!00-00-00!
	
	
	
	
	
	Case of 
		: ("ModificacionPagos"=$vt_accion)
			$vb_estaModificandoPago:=True:C214
			GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
			$vd_fechaDelPago:=KRL_GetDateFieldData (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]FechaPago:4)
			
		: ("RechazaPagoImportado"=$vt_accion)
			$vb_estaModificandoPago:=False:C215
	End case 
	
	$vt_DTSFechaPago:=DTS_MakeFromDateTime ($vd_fechaDelPago)
	
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha_creacion:40>$vt_DTSFechaPago)
	
	If (Records in selection:C76([ACT_Pagos:172])>0)
		
		ORDER BY:C49([ACT_Pagos:172]Fecha_creacion:40;>)
		LAST RECORD:C200([ACT_Pagos:172])
		
		$vd_ultimoPago:=DTS_GetDate ([ACT_Pagos:172]Fecha_creacion:40)
		$vt_time:=DTS_GetTime ([ACT_Pagos:172]Fecha_creacion:40)
		$vt_dtsCreacion:=[ACT_Pagos:172]Fecha_creacion:40
		
		
		If ($vt_dtsCreacion="")
			$vt_msg:=__ ("El último pago número ")+String:C10([ACT_Pagos:172]ID:1)+__ (", fue ingresado el ")+String:C10([ACT_Pagos:172]FechaIngreso:24)+__ (" y no tiene información registrada")
			$vt_msg:=$vt_msg+__ (" en el DTS de creación, campo utilizado para validar la fecha del último ingreso de pagos.\n\n")
			$vt_msg:=$vt_msg+__ ("No se permitirá generar otro registro de pago.\n\n")
			$vt_msg:=$vt_msg+__ ("Para corregir la situación, desmarque la configuración que restringe el ingreso de pago, registre un pago y ")
			$vt_msg:=$vt_msg+__ (" y vuelva a establecer la configuración.")
			
		Else 
			$vt_msg:=__ ("La configuración de AccountTrack no permite asignar una fecha de pago anterior a ")+String:C10(DTS_GetDate ($vt_dtsCreacion))
			$vt_msg:=$vt_msg+__ (" a las ")+String:C10(DTS_GetTime ($vt_dtsCreacion))+__ (" hrs, correspondiente al último pago registrado en la Base de Datos.")
			If ($vt_accion#"RechazaPagoImportado")
				$vt_msg:=$vt_msg+__ ("\n\nEl pago no será ")+Choose:C955($vb_estaModificandoPago;"modificado";"ingresado")+__ (". Por favor, consulte con su Administrador.")
			End if 
		End if 
		
	Else 
		$vt_dtsCreacion:=DTS_MakeFromDateTime 
	End if 
	
	
	If ($vt_dtsCreacion#"")
		
		If ($vd_fechaDelPago<$vd_ultimoPago)
			$vt_retorno:=$vt_msg
		Else 
			If ($vd_fechaDelPago=$vd_ultimoPago)
				If ($vt_time>Current time:C178(*))
					$vt_retorno:=$vt_msg
				Else 
					$vt_retorno:="ok"
				End if 
			Else 
				If ($vd_fechaDelPago>$vd_ultimoPago)
					$vt_retorno:="ok"
				End if 
			End if 
		End if 
		
	Else 
		$vt_retorno:=$vt_msg
	End if 
	
	
Else 
	$vt_retorno:="ok"
End if 

$0:=$vt_retorno