  //verificar si se tiene ADN contratado

C_BOOLEAN:C305($valor)

$valor:=LICENCIA_esModuloAutorizado (1;AdmissionNet)
If ($valor=True:C214)
	  //verificar si realmente hay una fecha de presentacion asignada
	If ([ADT_Candidatos:49]Fecha_de_examen:7=!00-00-00!)
		CD_Dlog (1;__ ("Debe asignar una fecha de exámen, para poder noificar."))
	Else 
		$r:=CD_Dlog (0;__ ("Confirma el envío de la notificación para la fecha de exámen?.");__ ("");__ ("Si");__ ("No"))
		If ($r=1)  //confirma
			ALERT:C41("Confirma")
		Else 
			ALERT:C41("No Confirma")
		End if 
	End if 
Else 
	CD_Dlog (1;__ ("Se debe disponer de licencia AdmissionNet para poder utilizar esta funcionalidad."))
End if 