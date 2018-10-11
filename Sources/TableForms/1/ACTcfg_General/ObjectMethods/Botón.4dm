C_TEXT:C284(vt_maquinaPDF)

$machine:=Current machine:C483
$user:=Current system user:C484

$combinedWS:=$machine+"/"+$user
If (vt_maquinaPDF#$combinedWS)
	If (($machine#"") & ($user#""))
		vt_maquinaPDF:=$combinedWS
	Else 
		vt_maquinaPDF:=""
	End if 
	If (vt_maquinaPDF="")
		CD_Dlog (0;__ ("La impresión PDF no puede realizarse en esta máquina ya que el nombre del computador y/o el nombre de usuario no han sido definido.\r\rPor favor consulte la documentación de su sistema operativo para configurar adecuadamente su computador."))
		_O_DISABLE BUTTON:C193(bSame2)
	Else 
		CD_Dlog (0;__ ("Si modifica el nombre del computador o del usuario deberá redefinir esta estación (u otra) para efectuar la impresión de avisos de cobranza en PDF."))
	End if 
End if 