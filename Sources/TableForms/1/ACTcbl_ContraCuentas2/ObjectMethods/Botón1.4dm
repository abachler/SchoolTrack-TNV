  //tenemos que testear si esta todo ok para generar archivo...
  //(1): Codigos de plan de cuetas
  //(2): Descripcion del movimiento
  //(3): Codigos Centros de costos
  //(4): Blanceo debe-haber

  //$generar:=False
  //$cpc:=False
  //$desc:=False
  //$ccc:=False
  //$dd:=False
  //$dh:=False
  //$msgcpc:=""
  //$msgdesc:=""
  //$msgccc:=""
  //$msgdd:=""
  //$msgdh:=""
ACTwiz_CuentasCblFootersTrf 

C_POINTER:C301($ptr)
C_TEXT:C284($msgTrf)
$msgTrf:=""
For ($i;1;Size of array:C274(al_Numero))
	$ptr:=Get pointer:C304("at_contabilidadTrf"+String:C10($i))
	$ptr->{0}:=""
	If (AT_SearchArray ($ptr;"=")>0)
		$msgTrf:=$msgTrf+__ ("- Existen líneas que no tienen ")+at_titulosAreaContabilidad{$i}+"\r"
	Else 
		$ptr:=Get pointer:C304("at_contabilidadTrfCC"+String:C10($i))
		$ptr->{0}:=""
		If (AT_SearchArray ($ptr;"=")>0)
			$msgTrf:=$msgTrf+__ ("- Existen líneas que no tienen ")+at_titulosAreaContabilidad{$i}+"\r"
		End if 
	End if 
End for 

If (vrACT_Descuadre#0)
	If (vrACT_Descuadre>0)
		$msgTrf:=$msgTrf+__ ("- Existe un descuadre en el archivo. Montos al debe superan montos al haber.")
	Else 
		$msgTrf:=$msgTrf+__ ("- Existe un descuadre en el archivo. Montos al haber superan montos al debe.")
	End if 
End if 

If ($msgTrf#"")
	$r:=CD_Dlog (0;$msgTrf;__ ("");__ ("Revisar");__ ("Generar de todas maneras"))
	If ($r=2)
		ACCEPT:C269
	End if 
Else 
	$r:=CD_Dlog (0;__ ("El sistema está listo para generar el archivo. ¿Desea Continuar?");__ ("");__ ("Revisar");__ ("Generar"))
	If ($r=2)
		ACCEPT:C269
	End if 
End if 