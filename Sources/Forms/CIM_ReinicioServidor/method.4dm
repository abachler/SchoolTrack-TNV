  // CIM_ReinicioServidor()
  //
  //
  // creado por: Alberto Bachler Klein: 16-03-16, 10:00:34
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_reiniciar)
C_LONGINT:C283($l_abajo;$l_alto;$l_altoActual;$l_ancho;$l_anchoActual;$l_arriba;$l_derecha;$l_izquierda)
C_POINTER:C301($y_mensaje;$y_minutos)

$y_minutos:=OBJECT Get pointer:C1124(Object named:K67:5;"reinicioMinutos")
Case of 
	: (Form event:C388=On Load:K2:1)
		  //(OBJECT Get pointer(Object named;"minutos"))->:=10
		(OBJECT Get pointer:C1124(Object named:K67:5;"reinicioMinutos"))->:=1
		(OBJECT Get pointer:C1124(Object named:K67:5;"desconectar"))->:=0
		vt_mensaje:=Choose:C955(vt_Mensaje#"";vt_Mensaje;__ ("El servidor debe ser reiniciado.\rPor favor seleccione la modalidad de desconexión de los clientes."))
		vt_mensajeCierre:=__ ("El servidor será reiniciado.\rPor favor guarde su trabajo y salga de esta aplicación.")
		
		OBJECT GET COORDINATES:C663(*;"titulo";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		$l_anchoActual:=$l_derecha-$l_izquierda+1
		$l_altoActual:=$l_abajo-$l_arriba+1
		OBJECT GET BEST SIZE:C717(*;"titulo";$l_ancho;$l_alto;$l_anchoActual)
		If ($l_altoActual<$l_alto)
			OBJECT MOVE:C664(*;"@";0;$l_alto-$l_altoActual+1)
			OBJECT SET COORDINATES:C1248(*;"titulo";$l_izquierda;$l_arriba;$l_derecha;$l_arriba+$l_alto)
		End if 
		OBJECT GET COORDINATES:C663(*;"botonReiniciar";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
		SET WINDOW RECT:C444($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW+$l_alto-$l_altoActual)
		
	: (Form event:C388=On Validate:K2:3)
		If ((OBJECT Get pointer:C1124(Object named:K67:5;"desconectar"))->=1)
			SYS_ReiniciarServidor (False:C215;vt_mensajeCierre;30)
		Else 
			SYS_ReiniciarServidor (False:C215;vt_mensajeCierre;vl_minutos*60)
		End if 
		
		
	: (Form event:C388=On Activate:K2:9)
		
	: (Form event:C388=On Deactivate:K2:10)
		
	: (Form event:C388=On Page Change:K2:54)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Close Box:K2:21)
		
End case 


