Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		SET WINDOW TITLE:C213(__ ("Documento Tributario para ")+[Personas:7]Apellidos_y_nombres:30)
		xALSet_PP_ACT_DocTApdo 
		$line:=Find in array:C230(alACT_IDsCats;[Personas:7]ACT_DocumentoTributario:45)
		$PorDefecto:=Find in array:C230(abACT_PorDefecto;True:C214)
		If ($line=-1)
			If ($PorDefecto#-1)
				$line:=$PorDefecto
			Else 
				$line:=1
			End if 
			[Personas:7]ACT_DocumentoTributario:45:=alACT_IDsCats{$line}
		End if 
		If (abACT_ReqDatos{$line}=True:C214)
			$width:=508
			$height:=427
			$botTopPosChange:=0
			$VisibleData:=True:C214
		Else 
			$width:=508
			$height:=227
			$botTopPosChange:=-200
			$VisibleData:=False:C215
		End if 
		AL_SetLine (xALP_DocTributario;$line)
		WDW_SlideDrawer (->[Personas:7];"InputFactData_ACT";$width;$height)
		OBJECT MOVE:C664(*;"boton@";0;$botTopPosChange)
		OBJECT SET VISIBLE:C603(*;"DA@";$VisibleData)
		If (BLOB size:C605([Personas:7]ACT_Datos_de_Facturacion:44)=0)
			vRazonSocial:=[Personas:7]Apellidos_y_nombres:30
			vRUT:=[Personas:7]RUT:6
			vDireccion:=[Personas:7]Direccion:14
			vComuna:=[Personas:7]Comuna:16
			vCiudad:=[Personas:7]Ciudad:17
			vTelefono:=[Personas:7]Telefono_domicilio:19
			vGiro:=""
		Else 
			BLOB_Blob2Vars (->[Personas:7]ACT_Datos_de_Facturacion:44;0;->vRazonSocial;->vRUT;->vDireccion;->vComuna;->vCiudad;->vTelefono;->vGiro)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
