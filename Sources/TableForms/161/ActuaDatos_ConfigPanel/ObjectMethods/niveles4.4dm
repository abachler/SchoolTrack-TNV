COPY ARRAY:C226(at_IDNivel;$at_IDNivel)
For ($i;1;Size of array:C274(aiADT_NivNo))
	If (ab_NivelModificado{$i})
		$at_IDNivel{$i}:="<B<I"+$at_IDNivel{$i}
	End if 
End for 

$niveles:=AT_array2text (->$at_IDNivel)
$choice:=Pop up menu:C542($niveles;aiADT_NivNo)
If ($choice>0)
	$nivel:=aiADT_NivNo{$choice}
	aiADT_NivNo:=$choice
	SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
	SN3_LoadDataReceptionSettings ($nivel)
	vlSN3_CurrConfigLevel:=aiADT_NivNo{$choice}
	vtSNT_ConfigLevelRD:=at_IDNivel{$choice}
	OBJECT SET TITLE:C194(bEnviarNivel;__ ("Enviar ahora ")+vtSNT_ConfigLevelRD)
	
	OBJECT SET SCROLL POSITION:C906(lb_CamposAlumno;1;*)
	OBJECT SET SCROLL POSITION:C906(lb_CamposRelaciones;1;*)
	OBJECT SET ENTERABLE:C238(SN3_PublicaRF;(SN3_ActuaDatosPublica=1))
	OBJECT SET ENTERABLE:C238(SN3_PublicaAlumno;(SN3_ActuaDatosPublica=1))
	OBJECT SET ENTERABLE:C238(SN3_EditaAlumno;(SN3_ActuaDatosPublica=1))
	OBJECT SET ENTERABLE:C238(SN3_EditaRF;(SN3_ActuaDatosPublica=1))
End if 