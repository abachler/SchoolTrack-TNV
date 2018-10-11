C_TEXT:C284($t_textoCuerpo;$t_textoAsunto)

If (Size of array:C274(alACTdte_ID)>0)
	ARRAY LONGINT:C221($alACT_seleccionados;0)
	C_LONGINT:C283($l_indice)
	lb_ACTdte_Apoderados{0}:=True:C214
	AT_SearchArray (->lb_ACTdte_Apoderados;"=";->$alACT_seleccionados)
	If (Size of array:C274($alACT_seleccionados)>0)
		$l_indice:=$alACT_seleccionados{1}
	Else 
		$l_indice:=1
	End if 
	
	$t_textoAsunto:=vtACTdte_Asunto
	ACTdte_EnvioPDFXMail ("ProcesaTexto";->$t_textoAsunto;->alACTdte_ID{$l_indice})
	
	$t_textoCuerpo:=vtACTdte_Cuerpo
	ACTdte_EnvioPDFXMail ("ProcesaTexto";->$t_textoCuerpo;->alACTdte_ID{$l_indice})
	
	CD_Dlog (0;"Asunto:"+"\r"+$t_textoAsunto+"\r\r"+"Cuerpo:"+"\r"+$t_textoCuerpo)
Else 
	CD_Dlog (0;__ ("No hay apoderados en a lista. No es posible generar la vista previa."))
End if 