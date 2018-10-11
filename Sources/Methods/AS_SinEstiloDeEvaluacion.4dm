//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Alexis Bustamante
  // Fecha y hora: 27-02-18, 09:46:37
  // ----------------------------------------------------
  // Método: AS_SinEstiloDeEvaluacion
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$t_accion)
$t_accion:=$1

Case of 
	: ($t_accion="AsignaturasSinEstilo")
		
		ARRAY LONGINT:C221($al_recNumAsig;0)
		ALL RECORDS:C47([Asignaturas:18])
		SELECTION TO ARRAY:C260([Asignaturas:18];$al_recNumAsig)
		CREATE EMPTY SET:C140([Asignaturas:18];"$Asignaturas")
		For ($i;1;Size of array:C274($al_recNumAsig))
			GOTO RECORD:C242([Asignaturas:18];$al_recNumAsig{$i})
			QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			If (Records in selection:C76([xxSTR_EstilosEvaluacion:44])=0)
				ADD TO SET:C119([Asignaturas:18];"$Asignaturas")
			End if 
		End for 
		USE SET:C118("$Asignaturas")
		CLEAR SET:C117("$Asignaturas")
		
	: ($t_accion="AsignaturasValidas")
		
		ARRAY LONGINT:C221($al_recNumAsig;0)
		SELECTION TO ARRAY:C260([Asignaturas:18];$al_recNumAsig)
		CREATE EMPTY SET:C140([Asignaturas:18];"$Asignaturas")
		CREATE EMPTY SET:C140([Asignaturas:18];"$AsignaturasSinE")
		For ($i;1;Size of array:C274($al_recNumAsig))
			GOTO RECORD:C242([Asignaturas:18];$al_recNumAsig{$i})
			QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			If (Records in selection:C76([xxSTR_EstilosEvaluacion:44])>0)
				ADD TO SET:C119([Asignaturas:18];"$Asignaturas")
			Else 
				ADD TO SET:C119([Asignaturas:18];"$AsignaturasSinE")
			End if 
		End for 
		USE SET:C118("$Asignaturas")
		CLEAR SET:C117("$Asignaturas")
		
		If (Records in set:C195("$AsignaturasSinE")>0)
			AS_SinEstiloDeEvaluacion ("creaNotificacion")
			CLEAR SET:C117("$Asignaturas")
		End if 
		
	: ($t_accion="creaNotificacion")
		C_TEXT:C284($t_mensaje;$t_UUID)
		$t_mensaje:=__ ("Para solucionar el problema diríjase al menú Herramientas/Ejecutar y seleccione la opción "+ST_Qte ("Asignar Estilos de Evaluación"))
		$t_UUID:=NTC_CreaMensaje ("";__ ("Envío de Asignaturas a SchoolNet");__ ("Existen Asignaturas Sin estilo de evaluación"))
		NTC_Mensaje_Texto ($t_UUID;$t_mensaje)
		
End case 
