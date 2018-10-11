//%attributes = {}
  //ACTpgs_onRecordLoad

Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Pagos:172]))
		READ WRITE:C146([ACT_Documentos_en_Cartera:182])
		READ WRITE:C146([ACT_Documentos_de_Pago:176])
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_DocdePago:3=[ACT_Pagos:172]ID_DocumentodePago:6)
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Pagos:172]ID_DocumentodePago:6)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Documentos_de_Pago:176]ID_Apoderado:2)
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		READ WRITE:C146([ACT_Documentos_de_Pago:176])
		READ WRITE:C146([ACT_Pagos:172])
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Documentos_de_Pago:176]ID_Apoderado:2)
		SET WINDOW TITLE:C213(__ ("Detalle del Documento en Cartera"))
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
		READ WRITE:C146([ACT_Documentos_en_Cartera:182])
		READ WRITE:C146([ACT_Pagos:172])
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_DocdePago:3=[ACT_Pagos:172]ID_DocumentodePago:6)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Documentos_de_Pago:176]ID_Apoderado:2)
		SET WINDOW TITLE:C213(__ ("Detalle del Documento Depositado"))
End case 
IT_SetButtonState (False:C215;->cb_VentaRapída)
AL_UpdateArrays (xALP_DesglosePago;0)
AL_RemoveArrays (xALP_DesglosePago;1;12)

xALSet_Pgs_Desglose 
ACTpgs_LoadDesgloseArrays 

AL_UpdateArrays (xALP_DesglosePago;-2)

cb_Depositado:=Num:C11([ACT_Documentos_de_Pago:176]Depositado:35)
cb_Reemplazado:=Num:C11([ACT_Documentos_en_Cartera:182]Reemplazado:14)
cb_EnCartera:=Num:C11([ACT_Documentos_de_Pago:176]En_cartera:34)
cb_Protestado:=Num:C11([ACT_Documentos_de_Pago:176]Protestado:36)
cb_Prorrogado:=Num:C11([ACT_Documentos_de_Pago:176]Prorrogado:46)

vsUbicacion:=[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8

  //20120525 RCH Se deja mensaje para todos los documentos, incluso para los nulos.
  //... se asignan estilos a los cheques y letras...
vMsgPagos:=__ ("El estado de este documento es ")
vMsgPagos:=vMsgPagos+[ACT_Documentos_de_Pago:176]Estado:14

If (([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4) | ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-8))
	If ([ACT_Documentos_de_Pago:176]Depositado:35)
		OBJECT SET FONT STYLE:C166(cb_Depositado;Underline:K14:4+Bold:K14:2+Italic:K14:3)
	Else 
		OBJECT SET FONT STYLE:C166(cb_Depositado;Bold:K14:2)
	End if 
	If ([ACT_Documentos_de_Pago:176]Protestado:36)
		OBJECT SET FONT STYLE:C166(cb_Protestado;Underline:K14:4+Bold:K14:2+Italic:K14:3)
	Else 
		OBJECT SET FONT STYLE:C166(cb_Protestado;Bold:K14:2)
	End if 
	If ([ACT_Documentos_de_Pago:176]Prorrogado:46)
		OBJECT SET FONT STYLE:C166(cb_Prorrogado;Underline:K14:4+Bold:K14:2+Italic:K14:3)
	Else 
		OBJECT SET FONT STYLE:C166(cb_Prorrogado;Bold:K14:2)
	End if 
	If ([ACT_Documentos_en_Cartera:182]Reemplazado:14)
		OBJECT SET FONT STYLE:C166(cb_Reemplazado;Underline:K14:4+Bold:K14:2+Italic:K14:3)
	Else 
		OBJECT SET FONT STYLE:C166(cb_Reemplazado;Bold:K14:2)
	End if 
End if 

Case of 
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4)
		FORM GOTO PAGE:C247(1)
		OBJECT SET VISIBLE:C603(*;"ubic@";True:C214)
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-8)
		FORM GOTO PAGE:C247(2)
		OBJECT SET VISIBLE:C603(*;"ubic@";True:C214)
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-6)
		ACTpp_CRYPTTC ("onLoadDocPago";->vt_noTarjetaC)
		FORM GOTO PAGE:C247(3)
		OBJECT SET VISIBLE:C603(*;"ubic@";False:C215)
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-7)
		ACTpp_CRYPTTC ("onLoadDocPagoDebito";->vt_noTarjetaDebito)  // Ticket 116401
		FORM GOTO PAGE:C247(4)
		OBJECT SET VISIBLE:C603(*;"ubic@";False:C215)
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-3)
		FORM GOTO PAGE:C247(5)
		OBJECT SET VISIBLE:C603(*;"ubic@";False:C215)
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-18)  //20140528 RCH webpay
		FORM GOTO PAGE:C247(6)
		OBJECT SET VISIBLE:C603(*;"ubic@";False:C215)
	: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-19)  //20141007 RCH pago web mx
		FORM GOTO PAGE:C247(7)
		OBJECT SET VISIBLE:C603(*;"ubic@";False:C215)
	Else 
		FORM GOTO PAGE:C247(5)
		OBJECT SET VISIBLE:C603(*;"ubic@";False:C215)
End case 

OBJECT SET VISIBLE:C603(*;"nulo@";([ACT_Pagos:172]Nulo:14))
  //OBJECT SET VISIBLE(vMsgPagos;(Not([ACT_Pagos]Nulo)))
OBJECT SET VISIBLE:C603(*;"banco@";False:C215)
OBJECT SET ENTERABLE:C238(*;"mod@";False:C215)
OBJECT SET ENTERABLE:C238(*;"obs";(Not:C34([ACT_Pagos:172]Nulo:14)))

OBJECT SET VISIBLE:C603(*;"vt_histReemp";(([ACT_Documentos_de_Pago:176]ID_Dcto_Reemplazado:55#0) | ([ACT_Documentos_de_Pago:176]id_reemplazado:62#0) | ([ACT_Documentos_de_Pago:176]id_reemplazador:63#0)))
OBJECT SET ENTERABLE:C238(*;"reemplazo";(([ACT_Documentos_de_Pago:176]ID_Dcto_Reemplazado:55#0) | ([ACT_Documentos_de_Pago:176]id_reemplazado:62#0) | ([ACT_Documentos_de_Pago:176]id_reemplazador:63#0)))

modPago:=False:C215

ACTcfg_LoadBancos 
<>vb_Refresh:=True:C214

C_TEXT:C284($vt_formato)
$vt_formato:=ACTcfgmyt_OpcionesGenerales ("ObtieneFormato";->[ACT_Pagos:172]Moneda:27)
OBJECT SET FORMAT:C236([ACT_Pagos:172]MontoEnMoneda:28;$vt_formato)
OBJECT SET FORMAT:C236([ACT_Pagos:172]ValorParidad:29;$vt_formato)

  //20171229 RCH
C_POINTER:C301($y_valores;$y_datos)
$y_valores:=OBJECT Get pointer:C1124(Object named:K67:5;"o_datos_nombre")
$y_datos:=OBJECT Get pointer:C1124(Object named:K67:5;"o_datos_valores")
AT_Initialize ($y_valores;$y_datos)
  // Modificado por: Saul Ponce (27-04-2018) Ticket 205271, en una BD encontramos el valor "undefined" como texto
If (([ACT_Pagos:172]Datos_pago:36#"") & ([ACT_Pagos:172]Datos_pago:36#"undefined"))
	ACTpgs_DatosPagosWeb ("CargaArreglos";[ACT_Pagos:172]Datos_pago:36;$y_valores;$y_datos)
End if 