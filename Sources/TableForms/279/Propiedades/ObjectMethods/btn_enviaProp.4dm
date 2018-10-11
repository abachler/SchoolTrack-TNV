  //el primer elemento debe ser confItem
C_TEXT:C284($vt_rutContribuyente)
$vt_rutContribuyente:=ACTcfg_opcionesDTE ("GetFormatoRUT";->[ACT_RazonesSociales:279]RUT:3)
ACTcfg_opcionesDTE ("GuardaCamposACT";->atRS_Propiedad_RS;->atRS_Valor_RS)

$vt_ok:=ACTcfg_opcionesDTE ("CallWSIntranet")
If ($vt_ok="1")
	C_TEXT:C284($vt_propiedades)
	For ($i;1;Size of array:C274(atRS_Propiedad))
		$vt_propiedades:=$vt_propiedades+atRS_Propiedad{$i}+"="+ACTcfg_opcionesDTE ("ReemplazaValores";->atRS_ValorXDefecto{$i};->$vt_rutContribuyente)
		If ($i<Size of array:C274(atRS_Propiedad))
			$vt_propiedades:=$vt_propiedades+"\n"
		End if 
	End for 
	If ($vt_propiedades#"")
		$ok:=WSact_CargaPropiedades ($vt_rutContribuyente;$vt_propiedades)
		If ($ok=1)
			KRL_ReloadInReadWriteMode (->[ACT_RazonesSociales:279])
			[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ 6  //propiedades enviadas
			SAVE RECORD:C53([ACT_RazonesSociales:279])
			vtACT_Obs1:=__ ("Propiedades enviadas.")
			CD_Dlog (0;vtACT_Obs1)
		Else 
			vtACT_Obs1:=__ ("no es posible conectarse con Colegium. Las propiedades no fueron enviadas.")
			CD_Dlog (0;vtACT_Obs1)
		End if 
	Else 
		vtACT_Obs1:=__ ("Las propiedades no pudieron ser enviadas.")
		CD_Dlog (0;vtACT_Obs1)
	End if 
	CANCEL:C270
Else 
	vtACT_Obs1:=__ ("No es posible conectarse con Colegium en este momento. Por favor intente nuevamente.")
	CD_Dlog (0;vtACT_Obs1)
End if 