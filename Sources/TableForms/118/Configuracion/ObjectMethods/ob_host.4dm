  // Declaraciones
C_POINTER:C301($y_host)
C_TEXT:C284($t_host)

  // Punteros a la interfaz
$y_host:=OBJECT Get pointer:C1124(Object current:K67:2;"ob_host")

  // Validacionde http, la direccion de ftp debe ser relativa no absoluta
If (Position:C15("http";$y_host->;1)>0)
	CD_Dlog (0;"La direccion hacia no debe incluir el protocolo http.\n\nEjemplo:\nUna direccion http://ftp.colegium.com, quedara como ftp.colegium.com")
	OBJECT SET COLOR:C271(*;"ob_host";-(Red:K11:4+(256*White:K11:1)))
Else 
	OBJECT SET COLOR:C271(*;"ob_host";-(Black:K11:16+(256*White:K11:1)))
End if 


