//%attributes = {}
  //ACTpgs_ValidaDocumentos

C_BOOLEAN:C305($vb_documentando;$1)
$vb_documentando:=$1

ARRAY LONGINT:C221(aIDPagosDocumentar;0)
C_BOOLEAN:C305($continuar;$0)

$Validado:=True:C214
$continuar:=False:C215
$SerieDuplicada:=False:C215
$fechaIncorrecta:=False:C215

atACT_BancoNombre{0}:=""
atACT_BancoCodigo{0}:=""
atACT_Cuenta{0}:=""
atACT_Serie{0}:=""
atACT_Fecha{0}:=""
adACT_Fecha{0}:=!00-00-00!
arACT_MontoCheque{0}:=0

ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
AT_SearchArray (->atACT_BancoNombre;"=";->alACT_ResultadoBusqueda)
If (Size of array:C274(alACT_ResultadoBusqueda)>0)
	$Validado:=False:C215
End if 
ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
AT_SearchArray (->atACT_BancoCodigo;"=";->alACT_ResultadoBusqueda)
If (Size of array:C274(alACT_ResultadoBusqueda)>0)
	$Validado:=False:C215
End if 
ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
AT_SearchArray (->atACT_Cuenta;"=";->alACT_ResultadoBusqueda)
If (Size of array:C274(alACT_ResultadoBusqueda)>0)
	$Validado:=False:C215
End if 
ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
AT_SearchArray (->atACT_Serie;"=";->alACT_ResultadoBusqueda)
If (Size of array:C274(alACT_ResultadoBusqueda)>0)
	$Validado:=False:C215
End if 
ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
AT_SearchArray (->atACT_Fecha;"=";->alACT_ResultadoBusqueda)
If (Size of array:C274(alACT_ResultadoBusqueda)>0)
	$Validado:=False:C215
End if 
ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
AT_SearchArray (->adACT_Fecha;"=";->alACT_ResultadoBusqueda)
If (Size of array:C274(alACT_ResultadoBusqueda)>0)
	$Validado:=False:C215
End if 
ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
AT_SearchArray (->arACT_MontoCheque;"=";->alACT_ResultadoBusqueda)
If (Size of array:C274(alACT_ResultadoBusqueda)>0)
	$Validado:=False:C215
End if 

For ($k;1;vlACT_Cuotas)
	C_LONGINT:C283($Duplicados)
	$Duplicados:=ACTdc_buscaDuplicados (2;atACT_Serie{$k};atACT_Cuenta{$k};atACT_BancoCodigo{$k})
	
	If ($Duplicados>0)
		$SerieDuplicada:=True:C214
		$k:=vlACT_Cuotas+1
	End if 
End for 
For ($k;1;vlACT_Cuotas)
	If (adACT_Fecha{$k}-Current date:C33(*)<=-60)
		$fechaIncorrecta:=True:C214
		$k:=vlACT_Cuotas+1
	End if 
End for 
Case of 
	: (($Validado=False:C215) & ($SerieDuplicada=True:C214) & ($fechaIncorrecta=False:C215))
		CD_Dlog (0;__ ("Faltan datos en algunos cheques, además de haber cheques cuyo número de serie para ese banco y cuenta ya existen."))
	: (($Validado=False:C215) & ($SerieDuplicada=False:C215) & ($fechaIncorrecta=True:C214))
		CD_Dlog (0;__ ("Faltan datos en algunos cheques, además de haber cheques cuya fecha genería un cheque vencido."))
	: (($Validado=False:C215) & ($SerieDuplicada=False:C215) & ($fechaIncorrecta=False:C215))
		If ($vb_documentando)
			$vt_boton:="ingresar"
		Else 
			$vt_boton:="reemplazar"
		End if 
		CD_Dlog (0;__ ("Faltan datos en algunos cheques. Revise la información y pulse ")+$vt_boton+__ ("."))
	: (($Validado=False:C215) & ($SerieDuplicada=True:C214) & ($fechaIncorrecta=True:C214))
		CD_Dlog (0;__ ("Faltan datos en algunos cheques, además de haber cheques cuyo número de serie para ese banco y cuenta ya existen, además de cheques cuyas fechas generarían cheques vencidos."))
	: (($Validado=True:C214) & ($SerieDuplicada=True:C214) & ($fechaIncorrecta=False:C215))
		CD_Dlog (0;__ ("Existen cheques con números de serie ya existentes para este banco y cuenta."))
	: (($Validado=True:C214) & ($SerieDuplicada=False:C215) & ($fechaIncorrecta=True:C214))
		$t:=CD_Dlog (0;__ ("Existen cheques cuyas fechas generarían cheques vencidos. ¿Desea ingresarlos de todas maneras?");__ ("");__ ("No");__ ("Si"))
		$format:="|Despliegue_ACT_Pagos"
		If ($t=2)
			If ((cbMultaXCaja=1) & ($vb_documentando))
				$r:=CD_Dlog (0;__ ("¿Está seguro de querer ingresar ")+String:C10(vlACT_Cuotas)+__ (" cheques por un monto total de ")+String:C10(vrACT_MontoAPagarApdo;$format)+__ (" para pagar una deuda de ")+String:C10(vrACT_MontoSeleccionado;$format)+__ (" y una multa de ")+String:C10(vrACT_MontoMulta;$format)+__ ("?");__ ("");__ ("Si");__ ("No"))
			Else 
				$r:=CD_Dlog (0;__ ("¿Está seguro de querer ingresar ")+String:C10(vlACT_Cuotas)+__ (" cheques por un monto total de ")+String:C10(vrACT_MontoAPagarApdo;$format)+__ ("?");__ ("");__ ("Si");__ ("No"))
			End if 
			If ($r=1)
				$continuar:=True:C214
			End if 
		End if 
	: (($Validado=True:C214) & ($SerieDuplicada=True:C214) & ($fechaIncorrecta=True:C214))
		CD_Dlog (0;__ ("Existen cheques con números de serie ya existentes para este banco y cuenta, además de cheques cuyas fechas generarían cheques vencidos."))
	: (($Validado=True:C214) & ($SerieDuplicada=False:C215) & ($fechaIncorrecta=False:C215))
		$format:="|Despliegue_ACT_Pagos"
		If ((cbMultaXCaja=1) & ($vb_documentando))
			$r:=CD_Dlog (0;__ ("¿Está seguro de querer ingresar ")+String:C10(vlACT_Cuotas)+__ (" cheques por un monto total de ")+String:C10(vrACT_MontoAPagarApdo;$format)+__ (" para pagar una deuda de ")+String:C10(vrACT_MontoSeleccionado;$format)+__ (" y una multa de ")+String:C10(vrACT_MontoMulta;$format)+__ ("?");__ ("");__ ("Si");__ ("No"))
		Else 
			$r:=CD_Dlog (0;__ ("¿Está seguro de querer ingresar ")+String:C10(vlACT_Cuotas)+__ (" cheques por un monto total de ")+String:C10(vrACT_MontoAPagarApdo;$format)+__ ("?");__ ("");__ ("Si");__ ("No"))
		End if 
		If ($r=1)
			$continuar:=True:C214
		End if 
End case 
$0:=$continuar