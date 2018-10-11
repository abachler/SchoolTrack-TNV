//%attributes = {}
  //ACTdc_CargaDatosDCartera

READ WRITE:C146([ACT_Documentos_en_Cartera:182])
READ WRITE:C146([ACT_Documentos_de_Pago:176])

GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];alACT_RecNumsDocs{i_Doc})
QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
vdACT_FechaCheque:=[ACT_Documentos_de_Pago:176]Fecha:13
vsACT_Banco:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
vsACT_Titular:=[ACT_Documentos_de_Pago:176]Titular:9
vsACT_RUT:=[ACT_Documentos_de_Pago:176]RUTTitular:10
vsACT_Cuenta:=[ACT_Documentos_de_Pago:176]Ch_Cuenta:11
vsACT_NoSerie:=[ACT_Documentos_de_Pago:176]NoSerie:12
vrACT_Monto:=[ACT_Documentos_de_Pago:176]MontoPago:6
vdACT_FechaVencimiento:=[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10
vdACT_FechaPago:=[ACT_Documentos_de_Pago:176]FechaPago:4
  //20120524 RCH
vsACT_RUT:=[ACT_Documentos_de_Pago:176]RUTTitular:10
vsACT_TipoDoc:=[ACT_Documentos_de_Pago:176]Tipodocumento:5
vlACT_idFormaDePago:=[ACT_Documentos_de_Pago:176]id_forma_de_pago:51
vlACT_idEstadoFormaDePago:=[ACT_Documentos_de_Pago:176]id_estado:53
If ([ACT_Documentos_de_Pago:176]Prorrogado:46)
	vdACT_FechaProrroga:=[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12
Else 
	vdACT_FechaProrroga:=vdACT_FechaCheque
End if 
vtACT_FechaProrroga:=String:C10(vdACT_FechaProrroga;7)
vUbicacionActual:=[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8
vNuevaUbicacion:=vUbicacionActual
vtACT_PagoMsg:=__ ("Para el reemplazo con ")+aACT_DocsReemp{vl_indiceFormasDePago}+__ (" no se requieren datos adicionales.")
vDias:=vdACT_FechaProrroga-vdACT_FechaCheque
vsACT_DocsReemp:=aACT_DocsReemp{vl_indiceFormasDePago}
vlACT_ReempPor:=vl_indiceFormasDePago
FORM GOTO PAGE:C247(1)
If ([ACT_Documentos_en_Cartera:182]Reemplazado:14)
	Reemplazado:=True:C214
	vMsgReemplazador:=__ ("Este documento ya fue reemplazado.")
	vsACT_DocsReemp:=__ ("Doc. ya reemplazado")
	_O_DISABLE BUTTON:C193(bDocReemp)
	If (Size of array:C274(abrSelect)>1)
		vMsgReemplazador:=vMsgReemplazador+"\r"+__ ("Haga clic en la flecha derecha para continuar.")
		OBJECT SET TITLE:C194(*;"@Ingresar@";__ ("Reemplazar"))
	Else 
		OBJECT SET TITLE:C194(*;"@Ingresar@";__ ("Terminar"))
	End if 
Else 
	Reemplazado:=False:C215
	vsACT_DocsReemp:=aACT_DocsReemp{vl_indiceFormasDePago}
	aACT_DocsReemp:=vl_indiceFormasDePago
End if 
If ([ACT_Documentos_de_Pago:176]Prorrogado:46)
	vt_datosProrroga:=ACTdc_ConstruyeDatosProrroga ([ACT_Documentos_de_Pago:176]Prorrogado_datos:47)
	OBJECT SET VISIBLE:C603(*;"vt_datosProrroga@";True:C214)
Else 
	vt_datosProrroga:=""
	OBJECT SET VISIBLE:C603(*;"vt_datosProrroga@";False:C215)
End if 

  //**** para asignar otro estado...
ACTdc_OpcionesGenerales ("CargaArregloEstadosXFdP";->vlACT_idFormaDePago;->vlACT_idEstadoFormaDePago)
REDRAW WINDOW:C456
