ST_JustificacionAtrasos ("cargaVariables")
vt_justificacionNombre:=AT_array2text (->at_JustificacionNombre;";")
$choice:=Pop up menu:C542(Replace string:C233(vt_justificacionNombre;",";";"))
If ($choice>0)  //rch desde acá
	vJustificacion:=at_JustificacionNombre{$choice}
	vIdJustificacion:=al_JustificacionID{$choice}
End if 


