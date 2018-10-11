  //[Alumnos_Castigos.AutDetention.bClearCumul
$value:=0
$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]AnotacionesNegativas_Cumulo:54;->$value)