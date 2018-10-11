C_LONGINT:C283($l_largoMax)
$l_largoMax:=90
If (Length:C16(vt_refRazon)>$l_largoMax)
	vt_refRazon:=Substring:C12(vt_refRazon;1;$l_largoMax)
	CD_Dlog (0;__ ("El número máximo de caracteres es "+String:C10($l_largoMax)+"."))
End if 