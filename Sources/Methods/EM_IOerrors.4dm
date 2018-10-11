//%attributes = {}
  //EM_IOerrors

Case of 
	: (error=-33)
		$0:="El directorio del volúmen está lleno."
	: (error=-34)
		$0:="No existe más lugar disponible en el disco."
	: (error=-35)
		$0:="Volúmen inexistente."
	: ((error=-36) | (error=-39) | (error=-40))
		$0:="Error de durante la escritura."
	: (error=-41)
		$0:="Imposible abrir el archivo."
	: (error=-42)
		$0:="Hay demasiados archivos abiertos simultáneamente."
	: (error=-43)
		$0:="El archivo no se encuentra en el volúmen seleccionado."
	: (error=-44)
		$0:="Diskette bloqueado."
	: (error=-45)
		$0:="Archivo bloqueado."
	: (error=-46)
		$0:="Volúmen bloqueado."
	: (error=-49)
		$0:="El archivo ya está abierto."
	: (error=-53)
		$0:="Volúmen inaccesible."
	Else 
		$0:="Error desconocido (N° "+String:C10(error)+"). Imposible acceder al archivo."
End case 