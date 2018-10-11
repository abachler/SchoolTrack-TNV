ACTcfg_SaveConfig (1)
If (Application type:C494=4D Remote mode:K5:5)
	  //$ServerProc:=Execute on server("ACTcc_OrderCtasCtes";64*1024;"Ordenando Ctas. Ctes.")
	  //20120228 RCH En compilado se estaba generando un error porque el metodo accedia a un parametro inexistente...
	C_LONGINT:C283($vl_id;$ServerProc;$ther)
	$vl_id:=0
	$ServerProc:=Execute on server:C373("ACTcc_OrderCtasCtes";Pila_256K;"Ordenando Ctas. Ctes.";$vl_id)
	
	vb_Ordenando:=True:C214
	<>ACT_OrdenandoCtas:=True:C214
	GET PROCESS VARIABLE:C371(-1;<>ACT_OrdenandoCtas;vb_Ordenando)
	$ther:=IT_UThermometer (1;0;__ ("Asignando número de hijo para cálculo de descuentos por familia..."))
	While (vb_Ordenando)
		GET PROCESS VARIABLE:C371(-1;<>ACT_OrdenandoCtas;vb_Ordenando)
	End while 
	IT_UThermometer (-2;$ther)
Else 
	ACTcc_OrderCtasCtes 
End if 

  // Modificado por: Saúl Ponce (09-03-2017) Ticket Nº 176708
  // para recargar la configuración de descuentos individuales
ACTcfg_OpcionesDescuentos ("CargaConf")