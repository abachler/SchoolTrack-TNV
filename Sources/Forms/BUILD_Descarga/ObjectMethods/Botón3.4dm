  // Build_Descarga.Botón3()
  //
  //
  // creado por: Alberto Bachler Klein: 20-08-16, 19:23:09
  // -----------------------------------------------------------
C_LONGINT:C283($i;$l_dia)
C_TIME:C306($h_Hora)
C_POINTER:C301($y_descarga;$y_dia;$y_hora;$y_instalarAuto;$y_instalarProgramado;$y_preferencias)

$y_preferencias:=OBJECT Get pointer:C1124(Object named:K67:5;"preferencias")
$y_descarga:=OBJECT Get pointer:C1124(Object named:K67:5;"descargar")
$y_instalarAuto:=OBJECT Get pointer:C1124(Object named:K67:5;"instalarAuto")
$y_instalarProgramado:=OBJECT Get pointer:C1124(Object named:K67:5;"instalarProgramado")
$y_hora:=OBJECT Get pointer:C1124(Object named:K67:5;"hora")


OB_SET ($y_preferencias->;$y_descarga;"descargar")
OB_SET ($y_preferencias->;$y_instalarAuto;"instalarAuto")
OB_SET ($y_preferencias->;$y_instalarProgramado;"instalarProgramado")
If ($y_hora->>0)
	$h_Hora:=$y_hora->{$y_hora->}
	OB_SET ($y_preferencias->;->$h_hora;"hora")
End if 

For ($i;1;7)
	$y_dia:=OBJECT Get pointer:C1124(Object named:K67:5;"Dia"+String:C10($i))
	If ($y_dia->=1)
		$l_dia:=$i
		$i:=8
	End if 
End for 
If ($l_dia=0)
	$l_dia:=1
End if 
OB_SET ($y_preferencias->;->$l_dia;"dia")

BUILD_SavePreferences ($y_preferencias->)