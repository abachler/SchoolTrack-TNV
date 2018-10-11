
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 187484
  // Fecha y hora: 02-10-18, 09:44:40
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_AsignaIDGlosaParaTramos.btnAceptar
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		If (OBJECT Get title:C1068(*;"btnAceptar")="Aceptar")
			
			C_OBJECT:C1216($ob_retornados)
			C_POINTER:C301($y_control)
			C_LONGINT:C283($l_estado;$l_idAsignado)
			C_TEXT:C284($t_glosa)
			
			ARRAY LONGINT:C221($al_modificados;0)
			
			$ob_retornados:=ACTwiz_AsignaIDGlosaTramosMas ("aplicarCambiosEnItemsSeleccionados")
			$l_estado:=OB Get:C1224($ob_retornados;"estado")
			If ($l_estado=1)
				If (Not:C34(OB Is empty:C1297($ob_retornados)))
					$l_idAsignado:=OB Get:C1224($ob_retornados;"idAsignado")
					OB GET ARRAY:C1229($ob_retornados;"idItemsModificados";$al_modificados)
					$t_glosa:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$l_idAsignado;->[xxACT_Items:179]Glosa:2)
					If (Size of array:C274($al_modificados)>0)
						$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"txtResumen")
						$y_control->:=__ ("Se estableció correctamente "+ST_Qte ($t_glosa)+" como la glosa para cargos por tramo en ^0 items de cargo.";String:C10(Size of array:C274($al_modificados)))
						ACTwiz_AsignaIDGlosaTramosMas ("LogAsignacionIDGlosaParaTramos";->$l_idAsignado;->$al_modificados)
						$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"btnCancelar")
						OBJECT SET VISIBLE:C603($y_control->;False:C215)
						OBJECT SET ACTION:C1259(*;"btnAceptar";_o_Object Accept action:K76:3)
						OBJECT SET TITLE:C194(*;"btnAceptar";"Salir")
					End if 
				End if 
			End if 
		End if 
		
End case 









