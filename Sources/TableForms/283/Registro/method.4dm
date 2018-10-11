  // [xShell_AnotacionesRegistros].Registro()
  // Por: Alberto Bachler K.: 13-03-15, 09:27:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_abajoV;$l_altoMensaje;$l_altoOptimo;$l_ancho;$l_arriba;$l_arribaV;$l_derecha;$l_derechaV;$l_desplazamientoVertical)
C_LONGINT:C283($l_izquierda;$l_izquierdaV)
C_POINTER:C301($y_BotonAceptar;$y_BotonCancelar;$y_Mensaje)
C_TEXT:C284($t_botonAceptar;$t_botonCancelar;$t_jSon;$t_mensaje;$t_tituloVentana)

Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET ENABLED:C1123(*;"botonAceptar";False:C215)
		
		$y_Mensaje:=OBJECT Get pointer:C1124(Object named:K67:5;"textoMensaje")
		$y_BotonAceptar:=OBJECT Get pointer:C1124(Object named:K67:5;"botonAceptar")
		$y_BotonCancelar:=OBJECT Get pointer:C1124(Object named:K67:5;"botonCancelar")
		
		OB_GET (ob_mensajeRegistroNota;->$t_tituloVentana;"tituloVentana")
		OB_GET (ob_mensajeRegistroNota;->$t_mensaje;"mensaje")
		OB_GET (ob_mensajeRegistroNota;->$t_botonAceptar;"botonAceptar")
		OB_GET (ob_mensajeRegistroNota;->$t_botonCancelar;"botonCancelar")
		CLEAR VARIABLE:C89(ob_mensajeRegistroNota)
		
		SET WINDOW TITLE:C213($t_tituloVentana)
		$y_Mensaje->:=$t_mensaje
		OBJECT SET TITLE:C194(*;"botonAceptar";$t_botonAceptar)
		OBJECT SET TITLE:C194(*;"botonCancelar";$t_botonCancelar)
		
		[xShell_RecordNotes:283]Anotacion:8:=""
		OBJECT GET COORDINATES:C663(*;"textoMensaje";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		$l_altoMensaje:=IT_Objeto_Alto ("textoMensaje")
		OBJECT GET BEST SIZE:C717(*;"textoMensaje";$l_ancho;$l_altoOptimo;IT_Objeto_Ancho ("textoMensaje"))
		$l_desplazamientoVertical:=$l_altoOptimo-$l_altoMensaje
		If ($l_desplazamientoVertical>0)
			GET WINDOW RECT:C443($l_izquierdaV;$l_arribaV;$l_derechaV;$l_abajoV)
			SET WINDOW RECT:C444($l_izquierdaV;$l_arribaV;$l_derechaV;$l_abajoV+$l_desplazamientoVertical)
			OBJECT MOVE:C664(*;"textoMensaje";0;0;0;$l_desplazamientoVertical)
			OBJECT MOVE:C664(*;"fondo";0;0;0;$l_desplazamientoVertical)
			OBJECT MOVE:C664(*;"anotacion";0;$l_desplazamientoVertical;0;0)
			OBJECT MOVE:C664(*;"boton@";0;$l_desplazamientoVertical)
			
		End if 
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

