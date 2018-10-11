//%attributes = {}
  //xALSet_ACT_CargosBoleta

AL_RemoveArrays (ALP_CargosBoleta;1;25)

ARRAY TEXT:C222(atACT_CGlosaImpresion;0)
ARRAY REAL:C219(arACT_MontoPagado;0)
ARRAY TEXT:C222(atACT_CAlumno;0)
ARRAY LONGINT:C221(alACT_Cantidad;0)
  //20130626 RCH NF CANTIDAD
ARRAY REAL:C219(arACT_Cantidad;0)
ARRAY TEXT:C222(atACT_RecNumsCargosAgr;0)
If (cbAgruparBoletas=1)
	AT_Inc (0)
	$error:=ALP_DefaultColSettings (ALP_CargosBoleta;AT_Inc ;"arACT_Cantidad";__ ("Cantidad");100;"#####")
	$error:=ALP_DefaultColSettings (ALP_CargosBoleta;AT_Inc ;"atACT_CGlosaImpresion";__ ("Glosa");500)
	If (<>gCountryCode="cl")
		$error:=ALP_DefaultColSettings (ALP_CargosBoleta;AT_Inc ;"arACT_MontoPagado";__ ("Monto");131;"|Despliegue_ACT_Pagos")
	Else 
		$error:=ALP_DefaultColSettings (ALP_CargosBoleta;AT_Inc ;"arACT_MontoPagado";__ ("Monto");131;"|Despliegue_ACT")
	End if 
Else 
	AT_Inc (0)
	$error:=ALP_DefaultColSettings (ALP_CargosBoleta;AT_Inc ;"atACT_CGlosaImpresion";__ ("Glosa");300)
	$error:=ALP_DefaultColSettings (ALP_CargosBoleta;AT_Inc ;"atACT_CAlumno";__ ("Alumno");300)
	If (<>gCountryCode="cl")
		$error:=ALP_DefaultColSettings (ALP_CargosBoleta;AT_Inc ;"arACT_MontoPagado";__ ("Monto");131;"|Despliegue_ACT_Pagos")
	Else 
		$error:=ALP_DefaultColSettings (ALP_CargosBoleta;AT_Inc ;"arACT_MontoPagado";__ ("Monto");131;"|Despliegue_ACT")
	End if 
End if 
$error:=ALP_DefaultColSettings (ALP_CargosBoleta;AT_Inc ;"atACT_RecNumsCargosAgr";"IdsAgrupados";31;"")

  //general options
ALP_SetDefaultAppareance (ALP_CargosBoleta;9;1;6;1;8)
AL_SetColOpts (ALP_CargosBoleta;1;1;1;1;0)
AL_SetRowOpts (ALP_CargosBoleta;1;1;0;0;1;0)
AL_SetCellOpts (ALP_CargosBoleta;0;1;1)
AL_SetMainCalls (ALP_CargosBoleta;"";"")
AL_SetScroll (ALP_CargosBoleta;0;0)
AL_SetEntryOpts (ALP_CargosBoleta;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (ALP_CargosBoleta;0;30;0)