Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"barra@";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Fondo)
		OBJECT SET RGB COLORS:C628(*;"lineaSeparador@";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Borde)
		
		$t_statusActual:=Old:C35([Alumnos:2]Status:50)
		$t_nuevoStatus:=[Alumnos:2]Status:50
		
		Case of 
			: (($t_statusActual="Retirado@") & ($t_nuevoStatus="Retirado@"))
				$t_titulo:=__ ("Información sobre el retiro del alumno ^0")
				OBJECT SET TITLE:C194(*;"boton_Aceptar";"Guardar")
				OBJECT SET ENABLED:C1123(*;"cb_ocultarEnNominas";True:C214)
				
			: (($t_statusActual="Activo") | ($t_statusActual="Oyente") | ($t_statusActual="En Trámite"))
				$t_titulo:=__ ("Retiro del alumno ^0")
				OBJECT SET TITLE:C194(*;"boton_Aceptar";"Retirar")
				
			: ($t_statusActual="Retirado@")
				$t_titulo:=__ ("Reactivación del alumno ^0")
				OBJECT SET ENTERABLE:C238(*;"@";False:C215)
				OBJECT SET ENABLED:C1123(*;"@";False:C215)
				OBJECT SET ENABLED:C1123(*;"boton@";True:C214)
				OBJECT SET TITLE:C194(*;"boton_Aceptar";"Activar")
				  //OBJECT SET ENABLED(*;"cb_ocultarEnNominas";True)  // 20160523 ASM ticket 162083. Al reintegrar se debe poder cambiar la opción de ocultar en Nóminas
				OBJECT SET VISIBLE:C603(*;"cb_ocultarEnNominas";False:C215)
				OBJECT SET VISIBLE:C603(*;"Texto2";False:C215)
		End case 
		OBJECT SET TITLE:C194(*;"t_titulo";Replace string:C233($t_titulo;"^0";[Alumnos:2]apellidos_y_nombres:40))
		
		
		If ([Alumnos:2]Fecha_de_retiro:42=!00-00-00!)
			[Alumnos:2]Fecha_de_retiro:42:=Current date:C33(*)
		End if 
		
		
		$y_OcultarEnNominas:=OBJECT Get pointer:C1124(Object named:K67:5;"cb_ocultarEnNominas")
		$y_OcultarEnNominas->:=Num:C11([Alumnos:2]ocultoEnNominas:89)
		
		
		$y_RetiradoTemporalmente:=OBJECT Get pointer:C1124(Object named:K67:5;"cb_retiradoTemporalmente")
		If ([Alumnos:2]Status:50="Retirado temporalmente")
			$y_RetiradoTemporalmente->:=1
		Else 
			$y_RetiradoTemporalmente->:=0
		End if 
		
		
		
		If ([Alumnos:2]Colegio_destino:102#"")
			OBJECT SET TITLE:C194(*;"boton_popupColegioDestino";[Alumnos:2]Colegio_destino:102)
		Else 
			OBJECT SET TITLE:C194(*;"boton_popupColegioDestino";__ ("Seleccione la institución de destino"))
		End if 
		
		If ([Alumnos:2]Curso_alRetirarse:83="")
			[Alumnos:2]Curso_alRetirarse:83:=[Alumnos:2]curso:20
		End if 
		
		
		
	: (Form event:C388=On Unload:K2:2)
		
End case 