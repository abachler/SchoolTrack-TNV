  // CIM_DiferenciasRegistros()
  // Por: Alberto Bachler K.: 28-09-14, 17:36:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_canceladoUsuario;$b_exito)
C_LONGINT:C283($l_error)
C_POINTER:C301($y_diferencia;$y_nombreTabla;$y_numeroTabla;$y_registrosAntes;$y_registrosDespues)
C_TEXT:C284($t_inicio;$t_jsonPerdidaRegistros;$t_operacion;$t_refJson;$t_terminoCompactacion;$t_terminoReparacion;$t_titulo)
C_OBJECT:C1216($ob_perdidas)

  //ARRAY LONGINT($al_Perdidas_numeroTabla;0)
  //ARRAY LONGINT($al_Perdidas_registrosAntes;0)
  //ARRAY LONGINT($al_Perdidas_registrosDespues;0)
  //ARRAY LONGINT($al_Perdidas_registrosPerdidos;0)
  //ARRAY TEXT($at_Perdidas_nombreTablas;0)

C_TEXT:C284(vt_Titulo;vt_Mensaje)

Case of 
	: (Form event:C388=On Load:K2:1)
		If (vt_titulo#"")
			OBJECT SET TITLE:C194(*;"titulo";vt_Titulo)
		Else 
			$l_error:=CIM_InfoReparacion (->$t_inicio;->$t_terminoReparacion;->$b_exito;->$b_canceladoUsuario)
			$l_error:=CIM_InfoCompactacion (->$t_inicio;->$t_terminoCompactacion;->$b_exito;->$b_canceladoUsuario)
			Case of 
				: ($t_terminoReparacion="") & ($t_terminoCompactacion#"")
					$t_operacion:=__ ("Compactación de base de datos")+"("+$t_terminoCompactacion+")"
					
				: ($t_terminoReparacion#"") & ($t_terminoCompactacion="")
					$t_operacion:=__ ("Reparación de base de datos")+"("+$t_terminoReparacion+")"
					
				: ($t_terminoReparacion>$t_terminoCompactacion)
					$t_operacion:=__ ("Reparación de base de datos")+"("+$t_terminoReparacion+")"
					
				: ($t_terminoReparacion<$t_terminoCompactacion)
					$t_operacion:=__ ("Compactación de base de datos ")+"("+$t_terminoCompactacion+")"
					
			End case 
			If ($t_operacion#"")
				$t_titulo:=__ ("Se detectó pérdida de registros en algunas tablas después de una operación de ")+$t_operacion
				OBJECT SET TITLE:C194(*;"titulo";$t_titulo)
			End if 
		End if 
		OBJECT SET TITLE:C194(*;"textoApoyo";vt_resultadoEnvioCorreo)
		
		
		
		$y_numero:=OBJECT Get pointer:C1124(Object named:K67:5;"numeroTabla")
		$y_nombre:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreTabla")
		$y_registrosAntes:=OBJECT Get pointer:C1124(Object named:K67:5;"registrosAntes")
		$y_registrosDespues:=OBJECT Get pointer:C1124(Object named:K67:5;"registrosDespues")
		$y_diferencia:=OBJECT Get pointer:C1124(Object named:K67:5;"diferencia")
		
		  //$y_numeroTabla:=OBJECT Get pointer(Object named;"numeroTabla")
		  //$y_nombreTabla:=OBJECT Get pointer(Object named;"nombreTabla")
		  //$y_registrosAntes:=OBJECT Get pointer(Object named;"registrosAntes")
		  //$y_registrosDespues:=OBJECT Get pointer(Object named;"registrosDespues")
		  //$y_diferencia:=OBJECT Get pointer(Object named;"diferencia")
		
		$t_jsonPerdidaRegistros:=vt_jsonPerdidaRegistros
		
		$ob_perdidas:=OB_JsonToObject ($t_jsonPerdidaRegistros)
		OB_GET ($ob_perdidas;$y_numero;"numeroTabla")
		OB_GET ($ob_perdidas;$y_nombre;"nombreTabla")
		OB_GET ($ob_perdidas;$y_registrosAntes;"registrosAntes")
		OB_GET ($ob_perdidas;$y_registrosDespues;"registrosDespues")
		OB_GET ($ob_perdidas;$y_diferencia;"registrosPerdidos")
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		QUIT 4D:C291
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 


