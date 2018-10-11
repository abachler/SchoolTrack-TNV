  // Actualizacion11_1.Botón15()
  // Por: Alberto Bachler: 11/01/13, 18:31:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_canceladoUsuario;$b_exito)
C_LONGINT:C283($l_error)
C_TEXT:C284($t_asunto;$t_copiaA;$t_Cuerpo;$t_email;$t_inicio;$t_jsonPerdidaRegistros;$t_operacion;$t_refJson;$t_refJsonPerdidas;$t_terminoCompactacion)
C_TEXT:C284($t_terminoReparacion;$t_TextoErrores;$t_versionBaseDeDatos;$t_versionEstructura)

ARRAY LONGINT:C221($al_Perdidas_numeroTabla;0)
ARRAY LONGINT:C221($al_Perdidas_registrosAntes;0)
ARRAY LONGINT:C221($al_Perdidas_registrosDespues;0)
ARRAY LONGINT:C221($al_Perdidas_registrosPerdidos;0)
ARRAY TEXT:C222($at_Perdidas_nombreTablas;0)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		
	: (Form event:C388=On Clicked:K2:4)
		
		$t_versionEstructura:=SYS_LeeVersionEstructura 
		$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos 
		
		$t_asunto:="Informe de pérdida de registros en la base de datos de "+<>gCustom
		
		
		  // Modificado por: Alexis Bustamante (10-06-2017)
		  //Ticket 179869
		
		C_OBJECT:C1216($ob)
		$ob:=JSON Parse:C1218(vt_jsonPerdidaRegistros;Is object:K8:27)
		OB_GET ($ob;->$al_Perdidas_numeroTabla;"numeroTabla")
		OB_GET ($ob;->$at_Perdidas_nombreTablas;"nombreTabla")
		OB_GET ($ob;->$al_Perdidas_registrosAntes;"registrosAntes")
		OB_GET ($ob;->$al_Perdidas_registrosDespues;"registrosDespues")
		OB_GET ($ob;->$al_Perdidas_registrosPerdidos;"registrosPerdidos")
		
		
		
		
		  //$t_refJsonPerdidas:=JSON Parse text (vt_jsonPerdidaRegistros)
		  //JSON_ExtraeValorElemento ($t_refJsonPerdidas;->$al_Perdidas_numeroTabla;"numeroTabla")
		  //JSON_ExtraeValorElemento ($t_refJsonPerdidas;->$at_Perdidas_nombreTablas;"nombreTabla")
		  //JSON_ExtraeValorElemento ($t_refJsonPerdidas;->$al_Perdidas_registrosAntes;"registrosAntes")
		  //JSON_ExtraeValorElemento ($t_refJsonPerdidas;->$al_Perdidas_registrosDespues;"registrosDespues")
		  //JSON_ExtraeValorElemento ($t_refJsonPerdidas;->$al_Perdidas_registrosPerdidos;"registrosPerdidos")
		  //  //JSON CLOSE ($t_refJson)
		  //JSON CLOSE ($t_refJsonPerdidas)  //20150421 RCH Se agrega cierre
		
		$l_error:=CIM_InfoReparacion (->$t_inicio;->$t_terminoReparacion;->$b_exito;->$b_canceladoUsuario)
		$l_error:=CIM_InfoCompactacion (->$t_inicio;->$t_terminoCompactacion;->$b_exito;->$b_canceladoUsuario)
		Case of 
			: ($t_terminoReparacion="") & ($t_terminoCompactacion#"")
				  // no hay log de reparacion pero hay log de compactación
				  // se asume que la última operación después del cierre fue una compactacion
				$t_operacion:=__ ("Compactación de base de datos")+"("+$t_terminoCompactacion+")"
				
			: ($t_terminoReparacion#"") & ($t_terminoCompactacion="")
				  // hay log de reparacion y no hay log de compactación
				  // se asume que la última operación después del cierre fue una reparacion
				$t_operacion:=__ ("Reparación de base de datos")+"("+$t_terminoReparacion+")"
				
			: ($t_terminoReparacion>$t_terminoCompactacion)
				  // el log de reparación indica una reparación más reciente que la última compactacion
				  // se asume que la última operación antes de la apertura de la base fue una reparacion
				$t_operacion:=__ ("Reparación de base de datos")+"("+$t_terminoReparacion+")"
				
			: ($t_terminoReparacion<$t_terminoCompactacion)
				  // el log de reparación indica una compctacion más reciente que la última reparacion
				  // se asume que la última operación antes de la apertura de la base fue una compactacion
				$t_operacion:=__ ("Compactación de base de datos ")+"("+$t_terminoCompactacion+")"
		End case 
		
		$t_TextoErrores:="Nº Tabla\tNombre de la tabla\tRegistros antes\tRegistros despues\tDiferencia\r"
		$t_TextoErrores:=$t_TextoErrores+AT_Arrays2Text ("\r";"\t";->$al_Perdidas_numeroTabla;->$at_Perdidas_nombreTablas;->$al_Perdidas_registrosAntes;->$al_Perdidas_registrosDespues;->$al_Perdidas_registrosPerdidos)
		$t_Cuerpo:=__ ("Se detectó pérdida de registros en algunas tablas después de una operación de ^0.")+<>gCustom+": \r\r"
		$t_Cuerpo:=$t_Cuerpo+$t_TextoErrores+"\r\r"
		$t_Cuerpo:=$t_Cuerpo+"Version Aplicación: "+SYS_LeeVersionEstructura +"\r"
		$t_Cuerpo:=$t_Cuerpo+"Version Base de datos: "+SYS_LeeVersionBaseDeDatos +"\r\r"
		$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("La base de datos se encuentra en el servidor SchoolTrack del colegio en la ruta siguiente:\r")+Data file:C490+"\r\r"
		$t_cuerpo:=Replace string:C233($t_Cuerpo;"^0";$t_operacion)
		
		$t_email:="soporte@colegium.com"
		$t_copiaA:="qa@colegium.com"
		OPEN URL:C673("mailto:"+$t_email+"?cc="+$t_copiaA+"&subject="+$t_asunto+"&body="+$t_Cuerpo)
		
		
		
		
		
		$t_email:="soporte@colegium.com"
		$t_copiaA:="qa@colegium.com"
		OPEN URL:C673("mailto:"+$t_email+"?cc="+$t_copiaA+"&subject="+$t_asunto+"&body="+$t_Cuerpo)
		
End case 


