//%attributes = {"executedOnServer":true}
  // CIM_ReiniciaAplicacion()
  // Por: Alberto Bachler K.: 07-04-15, 18:32:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  //DELAY PROCESS(Current process;60)


If (Application type:C494=4D Remote mode:K5:5)
	$l_refVentana:=Open form window:C675("CIM_ReinicioServidor";Movable form dialog box:K39:8;Horizontally centered:K39:1;Vertically centered:K39:4)
	$t_mensaje:=__ ("El servidor se reiniciará en 3 minutos.\rPor favor guarde su trabajo y salga de Schooltrack.")
	RESTART 4D:C1292(60;$t_mensaje)
Else 
	RESTART 4D:C1292
End if 



