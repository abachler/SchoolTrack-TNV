//%attributes = {}
  //ACTlc_retornaTasa

SET BLOB SIZE:C606(xBlob;0)
ARRAY LONGINT:C221(alACT_AñoTasaImpuesto;0)
ARRAY REAL:C219(arACT_TasaMesImpuesto;0)
ARRAY REAL:C219(arACT_TasaMaximaImpuesto;0)
C_BOOLEAN:C305(vb_solo1Mensaje)
C_BOOLEAN:C305($vb_mostrarMensaje)
$vb_mostrarMensaje:=True:C214
xBlob:=PREF_fGetBlob (0;"ACT_ImpuestoTimbres";xBlob)
BLOB_Blob2Vars (->xBlob;0;->alACT_AñoTasaImpuesto;->arACT_TasaMesImpuesto;->arACT_TasaMaximaImpuesto)
SET BLOB SIZE:C606(xBlob;0)

C_LONGINT:C283($1;$accion;$2;$año)
C_REAL:C285($0;$el)
$accion:=$1
$año:=$2
If (Count parameters:C259=3)
	$vb_mostrarMensaje:=$3
End if 

$el:=Find in array:C230(alACT_AñoTasaImpuesto;$año)
If ($el>0)
	vb_solo1Mensaje:=True:C214
	If ((arACT_TasaMesImpuesto{$el}>0) & (arACT_TasaMaximaImpuesto{$el}>0))
		Case of 
			: ($accion=1)  //tasa mensual
				$0:=arACT_TasaMesImpuesto{$el}
			: ($accion=2)  //tasa anual
				$0:=arACT_TasaMaximaImpuesto{$el}
		End case 
	Else 
		$0:=0
		CD_Dlog (0;__ ("La configuración para el año de emisión de la letra de cambio (")+String:C10($año)+__ (") está incompleta."))
	End if 
Else 
	$0:=0
	If ((Not:C34(vb_solo1Mensaje)) & ($vb_mostrarMensaje))
		vb_solo1Mensaje:=True:C214
		CD_Dlog (0;__ ("No existe la configuración para el año de emisión de la letra de cambio (")+String:C10($año)+__ ("). Cierre la ventana y vaya a la Configuración de monedas y tasas."))
	End if 
End if 