//%attributes = {}
  //0xDev_ACTUpdateMontosVariables

  //método para probar en compilado el tiempo que toma en ejecutarse
$vl_time:=IT_StartTimer 
If (Application type:C494=4D Remote mode:K5:5)
	$pid:=Execute on server:C373(Current method name:C684;Pila_256K;"Recalculo...")
Else 
	ACTcfg_OpcionesTareasFinDia ("EjecutaTareasInicioDia")
End if 
If (Application type:C494#4D Server:K5:6)
	If (<>lUSR_CurrentUserID=-6) | (<>lUSR_CurrentUserID=-8)
		IT_StopTimer ($vl_time)
	End if 
End if 