//%attributes = {}
  // VC4D_CommitCode()
  //
  //
  // creado por: Alberto Bachler Klein: 14-02-16, 17:39:48
  // -----------------------------------------------------------
C_BLOB:C604($x_Retorno)
C_LONGINT:C283($i;$l_error;$l_errorCode;$l_fila;$l_progreso;$l_resultado)
C_POINTER:C301($y_fechaModificacionDestino;$y_integrar;$y_listbox;$y_password;$y_Rutas;$y_servidorSeleccionado;$y_status;$y_userName;$y_uuidMetodo)
C_TEXT:C284($t_dtsIntegracion;$t_error;$t_servidorSeleccionado;$t_text)
C_OBJECT:C1216($ob_Retorno)

ARRAY LONGINT:C221($al_filasSeleccionadas;0)

$y_listbox:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_vc4d")
$y_userName:=OBJECT Get pointer:C1124(Object named:K67:5;"userName")
$y_password:=OBJECT Get pointer:C1124(Object named:K67:5;"password")
$y_Rutas:=OBJECT Get pointer:C1124(Object named:K67:5;"ruta")
$y_integrar:=OBJECT Get pointer:C1124(Object named:K67:5;"integrable")
$y_status:=OBJECT Get pointer:C1124(Object named:K67:5;"statusServer")
$y_fechaModificacionDestino:=OBJECT Get pointer:C1124(Object named:K67:5;"modificacionServer")
$y_uuidMetodo:=OBJECT Get pointer:C1124(Object named:K67:5;"uuid_metodo")
$y_servidorSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"servidorSeleccionado")
$t_servidorSeleccionado:=$y_servidorSeleccionado->{$y_servidorSeleccionado->}

LB_GetSelectedRows ($y_listBox;->$al_filasSeleccionadas)
If (Size of array:C274($al_filasSeleccionadas)>1)
	$l_progreso:=Progress New 
	Progress SET TITLE ($l_progreso;"Integrando código en "+$t_servidorSeleccionado)
End if 

For ($i;1;Size of array:C274($al_filasSeleccionadas))
	$l_fila:=$al_filasSeleccionadas{$i}
	If ($y_integrar->{$l_fila})
		If ($l_progreso>0)
			Progress SET PROGRESS ($l_progreso;$l_fila/Size of array:C274($al_filasSeleccionadas);$y_Rutas->{$l_fila})
		End if 
		$x_Retorno:=VC4D_UpdateMethod ($y_Rutas->{$l_fila};$y_userName->;$y_password->)
		If (BLOB size:C605($x_Retorno)>0)
			$l_resultado:=OB_BlobToObject (->$x_Retorno;->$ob_Retorno)
			If (Not:C34(OB Is empty:C1297($ob_Retorno)))
				OB_GET ($ob_Retorno;->$t_dtsIntegracion;"dtsIntegration")
				OB_GET ($ob_Retorno;->$t_error;"errorText")
				OB_GET ($ob_Retorno;->$l_errorCode;"errorCode")
				
				If ($l_error=0)
					$t_text:="Integrado"
					$y_integrar->{$l_fila}:=False:C215
					$y_status->{$l_fila}:=IT_SetTextColor_Name (->$t_text;"Green")
					$y_fechaModificacionDestino->{$l_fila}:=Replace string:C233($t_dtsIntegracion;"T";", ")
					VC4D_SetCommited ($y_uuidMetodo->{$l_fila})
				Else 
					$y_integrar->{$l_fila}:=False:C215
					$t_text:=__ ("Error al integrar: ^0:^1 ";String:C10($l_error);$t_error)
					$y_status->{$l_fila}:=IT_SetTextColor_Name (->$t_text;"Red")
				End if 
			End if 
		End if 
	End if 
End for 
If ($l_progreso#0)
	Progress QUIT ($l_progreso)
End if 
  //VC4D_LoadChanges