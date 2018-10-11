//%attributes = {}
  //WIZ_ACT_ManejoIEC_IEV

TRACE:C157
  //en produccion crear el proceso autorizado
  //If (LICENCIA_esModuloAutorizado (1;12))
If ((LICENCIA_esModuloAutorizado (1;12)) | (<>gRolBD="90468"))  //20150309 RCH El Grange debe solo enviar los libros de venta. No necesariamente con licencia
	If (USR_GetMethodAcces (Current method name:C684))
		WDW_OpenFormWindow (->[ACT_IECV:253];"Listado_IEC_IEV";-1;4;__ ("Listado de IECV"))
		DIALOG:C40([ACT_IECV:253];"Listado_IEC_IEV")
		CLOSE WINDOW:C154
	End if 
Else 
	CD_Dlog (0;__ ("Su licencia no permite ejecutar esta opción."))
End if 