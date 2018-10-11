//%attributes = {}
  //ACTbol_ValidaEmisionDesdeAvisos

C_BOOLEAN:C305($vb_emitir;$0)
Case of 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124])) | (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
		C_BOOLEAN:C305(vbACT_noHayCAF;vbACT_noHayFDE;vbACT_validacionDirDTE)
		$set:=$1
		$vb_emitir:=ACTbol_ValidaEmisionDocs ($set)
		If (Not:C34($vb_emitir))
			Case of 
				: (vbACT_noHayCAF)
					vbACT_noHayCAF:=False:C215
					CD_Dlog (0;"No ha sido realizada la configuración inicial y/o no han cargado códigos de autorización de folios al sistema.")
				: (vbACT_noHayFDE)
					vbACT_noHayFDE:=False:C215
					CD_Dlog (0;__ ("No hay firma digital electrónica cargada. El proceso fue interrumpido."))
				: (vbACT_validacionDirDTE)
					  //error por validacion de direcciones.
				Else 
					  //CD_Dlog (0;__ ("En la selección de avisos de cobranza existen cargos relacionados a monedas con montos variables, los documentos no pueden ser generados para dichos montos."))
					$vt_msj:=__ ("En la selección de avisos de cobranza existen cargos relacionados a monedas con montos variables, los documentos no pueden ser generados para dichos montos.")
					$vt_msj:=$vt_msj+"\r\r"+__ ("¿Desea fijar los montos en moneda variable?")
					$vl_resp:=CD_Dlog (0;$vt_msj;"";__ ("Si");__ ("No"))
					If ($vl_resp=1)
						C_LONGINT:C283($b1;$b2;$b3;$f1;$f2;$f3)
						  // dentro de ACTac_FijaMontosMonedaVariable se pierde el valor de b1, b2, b3...
						$b1:=b1
						$b2:=b2
						$b3:=b3
						$f1:=f1
						$f2:=f2
						$f3:=f3
						$vb_emitir:=ACTac_FijaMontosMonedaVariable ($set)
						b1:=$b1
						b2:=$b2
						b3:=$b3
						f1:=$f1
						f2:=$f2
						f3:=$f3
						  //20150203 RCH se vuelve a verificar por si hay otro error
						If ($vb_emitir)
							$vb_emitir:=ACTbol_ValidaEmisionDesdeAvisos ($set)
						End if 
					End if 
			End case 
		End if 
	Else 
		$vb_emitir:=True:C214
End case 
$0:=$vb_emitir