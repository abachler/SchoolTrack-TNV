//%attributes = {}
C_BOOLEAN:C305($b_continuar;$0)
C_TEXT:C284($1;$t_method)
C_LONGINT:C283($l_result)
C_BOOLEAN:C305(<>bXS_esServidorOficial)


$t_method:=$1

$b_continuar:=True:C214
Case of 
	: (<>bXS_esServidorOficial)
		  //el server oficial pasa
		
	: (<>gRolBD="QA112233QA@")
		  //Si es rol de prueba pasa
		
	: (Application type:C494=4D Server:K5:6)
		  //Si se está en server no podemos mostrar cuadro de confirmación así que continuamos
		
	Else 
		  //Se pide verificar inicio del servicio. SOlo se pregunta una vez por sesión.
		If (Find in array:C230(<>at_serviciosSN3Notificados;$t_method)=-1)  //<>at_serviciosSN3Notificados se declara al partir la app
			$l_result:=ModernUI_Notificacion (__ ("Consumo de servicio ")+($t_method);__ ("La base de datos no está configurada como servidor oficial y usted se dispone a consumir un servicio publicado por SN.\r\rSi continúa podría modificar datos o configuraciones para el colegio con rol base de datos: ")+<>gRolBD+__ (". Al continuar, este mensaje no volverá a aparecer para este servicio.\r\r")+__ ("¿Está seguro que desea continuar?");__ ("Si");__ ("No"))
			If ($l_result=1)
				APPEND TO ARRAY:C911(<>at_serviciosSN3Notificados;$t_method)
			Else 
				$b_continuar:=False:C215  //no quiso continuar
			End if 
		Else 
			  //ya notificado y continuó
		End if 
End case 

$0:=$b_continuar