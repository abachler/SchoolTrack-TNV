//%attributes = {}
  //ACTdc_ValidaDuplicadosInput

C_POINTER:C301($vy_fieldPointer;$1)
C_LONGINT:C283($duplicados)

$vy_fieldPointer:=$1

If ($vy_fieldPointer->#"")
	$Duplicados:=ACTdc_BuscaDuplicados (-2;[ACT_Documentos_de_Pago:176]NoSerie:12;[ACT_Documentos_de_Pago:176]Ch_Cuenta:11;[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8)
	If (([ACT_Documentos_de_Pago:176]NoSerie:12#Old:C35([ACT_Documentos_de_Pago:176]NoSerie:12)) | ([ACT_Documentos_de_Pago:176]Ch_Cuenta:11#Old:C35([ACT_Documentos_de_Pago:176]Ch_Cuenta:11)) | ([ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8#Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8)))
		If ($duplicados>0)
			CD_Dlog (0;__ ("Para este banco ya existe un cheque con ese número de serie."))
			Case of 
				: ([ACT_Documentos_de_Pago:176]NoSerie:12#Old:C35([ACT_Documentos_de_Pago:176]NoSerie:12))
					[ACT_Documentos_de_Pago:176]NoSerie:12:=Old:C35([ACT_Documentos_de_Pago:176]NoSerie:12)
					
				: ([ACT_Documentos_de_Pago:176]Ch_Cuenta:11#Old:C35([ACT_Documentos_de_Pago:176]Ch_Cuenta:11))
					[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=Old:C35([ACT_Documentos_de_Pago:176]Ch_Cuenta:11)
					
				: ([ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8#Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8))
					[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoNombre:7)
					[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8)
			End case 
		End if 
	Else 
		If ($duplicados>1)
			CD_Dlog (0;__ ("Para este banco ya existe un cheque con ese número de serie."))
			[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoNombre:7)
			[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8)
			[ACT_Documentos_de_Pago:176]NoSerie:12:=Old:C35([ACT_Documentos_de_Pago:176]NoSerie:12)
			[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=Old:C35([ACT_Documentos_de_Pago:176]Ch_Cuenta:11)
		End if 
	End if 
Else 
	Case of 
		: (KRL_isSameField ($vy_fieldPointer;->[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8))
			CD_Dlog (0;__ ("Debe ingresar un banco para este documento."))
			[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoNombre:7)
			[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8)
			
		: (KRL_isSameField ($vy_fieldPointer;->[ACT_Documentos_de_Pago:176]NoSerie:12))
			CD_Dlog (0;__ ("Debe ingresar un número de serie para este documento."))
			[ACT_Documentos_de_Pago:176]NoSerie:12:=Old:C35([ACT_Documentos_de_Pago:176]NoSerie:12)
			
		: (KRL_isSameField ($vy_fieldPointer;->[ACT_Documentos_de_Pago:176]Ch_Cuenta:11))
			CD_Dlog (0;__ ("Debe ingresar un número de cuenta para este documento."))
			[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=Old:C35([ACT_Documentos_de_Pago:176]Ch_Cuenta:11)
			
	End case 
End if 