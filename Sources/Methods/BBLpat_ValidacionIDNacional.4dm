//%attributes = {}
  // BBLpat_ValidacionIDNacional()
  // Por: Alberto Bachler K.: 06-12-13, 12:37:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_solicitarConfirmacion)
C_LONGINT:C283($l_opcionUsuario)
C_POINTER:C301($y_Campo)
C_TEXT:C284($t_mensaje;$t_titulo)

$y_Campo:=OBJECT Get pointer:C1124(Object current:K67:2)
$b_mostrarAlertas:=False:C215

If (Count parameters:C259=1)
	$b_mostrarAlertas:=$1
End if 


Case of 
	: ((Field:C253($y_campo)=Field:C253(->[BBL_Lectores:72]RUT:7)) & ([BBL_Lectores:72]RUT:7#""))
		If (<>vtXS_CountryCode="cl")
			[BBL_Lectores:72]RUT:7:=CTRY_CL_VerifRUT ([BBL_Lectores:72]RUT:7;False:C215)
			If ([BBL_Lectores:72]RUT:7="")
				vt_mensaje:=__ ("RUT incorrecto.")
				If ($b_mostrarAlertas)
					ModernUI_Notificacion (vt_mensaje)
				End if 
				GOTO OBJECT:C206([BBL_Lectores:72]RUT:7)
			Else 
				vt_mensaje:=""
			End if 
			OBJECT SET FORMAT:C236([BBL_Lectores:72]RUT:7;"###.###.###-#")
		End if 
		If ([BBL_Lectores:72]RUT:7#"")
			If (KRL_RecordExists (->[BBL_Lectores:72]RUT:7))
				vt_mensaje:="Ya existe un lector con este "+<>vt_IDNacional1_name
				If ($b_mostrarAlertas)
					ModernUI_Notificacion (vt_mensaje)
				End if 
				[BBL_Lectores:72]RUT:7:=Old:C35([BBL_Lectores:72]RUT:7)
				GOTO OBJECT:C206([BBL_Lectores:72]RUT:7)
			Else 
				vt_mensaje:=""
				If (([BBL_Lectores:72]RUT:7#Old:C35([BBL_Lectores:72]RUT:7)) & (<>lBBL_refCampoBarcodeLector=Field:C253(->[BBL_Lectores:72]RUT:7)))
					$b_solicitarConfirmacion:=True:C214
				End if 
			End if 
		End if 
		
		
	: (Field:C253($y_campo)=Field:C253(->[BBL_Lectores:72]IDNacional_2:33))
		If ([BBL_Lectores:72]IDNacional_2:33#"")
			If (KRL_RecordExists (->[BBL_Lectores:72]IDNacional_2:33))
				vt_mensaje:="Ya existe un lector con este "+<>vt_IDNacional2_name
				If ($b_mostrarAlertas)
					ModernUI_Notificacion (vt_mensaje)
				End if 
				[BBL_Lectores:72]IDNacional_2:33:=Old:C35([BBL_Lectores:72]IDNacional_2:33)
				GOTO OBJECT:C206([BBL_Lectores:72]IDNacional_2:33)
			Else 
				vt_mensaje:=""
				If (([BBL_Lectores:72]IDNacional_2:33#Old:C35([BBL_Lectores:72]IDNacional_2:33)) & (<>lBBL_refCampoBarcodeLector=Field:C253(->[BBL_Lectores:72]IDNacional_2:33)))
					$b_solicitarConfirmacion:=True:C214
				End if 
			End if 
		Else 
			GOTO OBJECT:C206([BBL_Lectores:72]IDNacional_2:33)
		End if 
		
		
		
	: (Field:C253($y_campo)=Field:C253(->[BBL_Lectores:72]IDNacional_3:34))
		If ([BBL_Lectores:72]IDNacional_3:34#"")
			If (KRL_RecordExists (->[BBL_Lectores:72]IDNacional_3:34))
				vt_mensaje:="Ya existe un lector con este "+<>vt_IDNacional2_name
				If ($b_mostrarAlertas)
					ModernUI_Notificacion (vt_mensaje)
				End if 
				[BBL_Lectores:72]IDNacional_3:34:=Old:C35([BBL_Lectores:72]IDNacional_3:34)
				GOTO OBJECT:C206([BBL_Lectores:72]IDNacional_3:34)
			Else 
				vt_mensaje:=""
				If (([BBL_Lectores:72]IDNacional_3:34#Old:C35([BBL_Lectores:72]IDNacional_3:34)) & (<>lBBL_refCampoBarcodeLector=Field:C253(->[BBL_Lectores:72]IDNacional_3:34)))
					$b_solicitarConfirmacion:=True:C214
				End if 
			End if 
		Else 
			GOTO OBJECT:C206([BBL_Lectores:72]IDNacional_3:34)
		End if 
End case 

If (($b_solicitarConfirmacion) & ($y_campo->#""))
	$t_titulo:=__ ("Usted modificó el ^0 de ^1.\rActualmente los códigos de barra son generados con esta información.")
	$t_mensaje:=__ ("Puede volver a generar el código de barra con el nuevo ^0 o mantener y proteger el código de barra anterior.")
	$t_titulo:=Replace string:C233($t_titulo;"^0";<>vt_IDNacional1_name)
	$t_titulo:=Replace string:C233($t_titulo;"^1";[BBL_Lectores:72]Nombre_Comun:35)
	$t_mensaje:=Replace string:C233($t_mensaje;"^0";<>vt_IDNacional1_name)
	$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Nuevo código de barra");__ ("Mantener anterior");__ ("Cancelar"))
	vt_mensaje:=""
	Case of 
		: ($l_opcionUsuario=1)
			  // genero nuevo codigo
			[BBL_Lectores:72]Código_de_barra:10:=""
			BBLpat_GeneraCodigoBarra 
			SAVE RECORD:C53([BBL_Lectores:72])
		: ($l_opcionUsuario=2)
			  // mantengo el código anterior aunque el identificador haya cambiado
			[BBL_Lectores:72]Barcode_Protegido:39:=True:C214
			SAVE RECORD:C53([BBL_Lectores:72])
			
		: ($l_opcionUsuario=3)
			  // Cancelo
			$y_campo->:=Old:C35($y_Campo->)
			HIGHLIGHT TEXT:C210($y_Campo->;255;255)
	End case 
End if 


