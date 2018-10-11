//%attributes = {}
READ ONLY:C145([SN3_PublicationPrefs:161])
ALL RECORDS:C47([SN3_PublicationPrefs:161])
ARRAY LONGINT:C221($rns;0)
LONGINT ARRAY FROM SELECTION:C647([SN3_PublicationPrefs:161];$rns)
For ($i;1;Size of array:C274($rns))
	KRL_GotoRecord (->[SN3_PublicationPrefs:161];$rns{$i};False:C215)
	$nivel:=[SN3_PublicationPrefs:161]Nivel:1
	SN3_InitPubVariables 
	SN3_ParseConfigXML (->[SN3_PublicationPrefs:161]xData:2)
	For ($j;1;5)
		$ptr:=Get pointer:C304("cbOcultarPeriodo"+String:C10($j))
		$ptr->:=0
		$ptr:=Get pointer:C304("vdHastaPeriodo"+String:C10($j))
		$ptr->:=!00-00-00!
		$ptr:=Get pointer:C304("cbOcultarPeriodo"+String:C10($j)+"_Obs")
		$ptr->:=0
		$ptr:=Get pointer:C304("vdHastaPeriodo"+String:C10($j)+"_Obs")
		$ptr->:=!00-00-00!
		$ptr:=Get pointer:C304("cbOcultarPeriodo"+String:C10($j)+"_Ap")
		$ptr->:=0
		$ptr:=Get pointer:C304("vdHastaPeriodo"+String:C10($j)+"_Ap")
		$ptr->:=!00-00-00!
	End for 
	cb_PublicarCompColegio:=0
	SN3_ModifyXMLEntry ($nivel;SN3_DTi_Calificaciones)
	SN3_ModifyXMLEntry ($nivel;SN3_DTi_Observaciones)
	SN3_ModifyXMLEntry ($nivel;SN3_DTi_CalificacionesMPA)
	SN3_ModifyXMLEntry ($nivel;SN3_DTi_Companeros)
End for 