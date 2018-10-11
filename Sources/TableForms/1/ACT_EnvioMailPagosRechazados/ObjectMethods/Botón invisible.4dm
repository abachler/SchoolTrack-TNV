C_TEXT:C284($t_textoCuerpo)
$t_textoCuerpo:=vtACTepr_Cuerpo
If (Size of array:C274(alACTepr_ApoderadoID)>0)
	ACTepr_OpcionesGenerales ("ProcesaTextoCuerpo";->$t_textoCuerpo;->alACTepr_ApoderadoID{1};->arACTepr_ApoderadoMontoRechaza{1})
	CD_Dlog (0;$t_textoCuerpo)
Else 
	CD_Dlog (0;__ ("No hay apoderados en a lista. No es posible generar la vista previa."))
End if 