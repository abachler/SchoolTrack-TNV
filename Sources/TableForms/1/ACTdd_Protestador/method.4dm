Case of 
	: (Form event:C388=On Load:K2:1)
		C_REAL:C285(cs_aplicaraTodos)
		i_Doc:=1
		cs_aplicaraTodos:=0
		ACTdd_CargaDatosDDepositados 
		ACTcfg_OpcionesRecargos ("BuscaItemsADesplegar")
		If (cbMultaXProtesto=1)
			OBJECT SET VISIBLE:C603(*;"multa@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"multa@";False:C215)
		End if 
		If (<>vlACT_Decimales>0)
			$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
			$format:="#####0"+<>tXS_RS_DecimalSeparator+("#"*<>vlACT_Decimales)
		Else 
			$filter:="&"+ST_Qte ("0-9")
			$format:="#####0"
		End if 
		OBJECT SET FILTER:C235(vrACT_MontoMulta;$filter)
		OBJECT SET FORMAT:C236(vrACT_MontoMulta;$format)
		If (cbMultaPermiteMod=1)
			OBJECT SET ENTERABLE:C238(*;"multa4Mod@";True:C214)
			_O_ENABLE BUTTON:C192(*;"multa4Mod@")
		Else 
			OBJECT SET ENTERABLE:C238(*;"multa4Mod@";False:C215)
			_O_DISABLE BUTTON:C193(*;"multa4Mod@")
		End if 
		Case of 
			: (Size of array:C274(alACT_RecNumsDocs)>1)
				i_Doc:=1
				If (cs_aplicaraTodos=1)
					OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
					OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
				Else 
					OBJECT SET VISIBLE:C603(*;"@next@";True:C214)
					OBJECT SET VISIBLE:C603(*;"@Ingresar@";False:C215)
				End if 
				GOTO OBJECT:C206(vdACT_FechaProtesto)
				
			: (Size of array:C274(alACT_RecNumsDocs)=1)
				i_Doc:=1
				OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
				OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
				GOTO OBJECT:C206(vdACT_FechaProtesto)
			: (Size of array:C274(alACT_RecNumsDocs)=0)
		End case 
		
		OBJECT SET VISIBLE:C603(*;"cs_aplicaraTodos";Size of array:C274(alACT_RecNumsDocs)>1)
		
		XS_SetInterface 
		Case of 
				  //: (vt_tipoDocumento="Letra@")
			: (vl_tipoDocumento=-8)
				vMotivos:=LOC_LoadList2Text ("ACT_MotivosProtestoLC")
			Else 
				vMotivos:=LOC_LoadList2Text ("ACT_MotivosProtesto")
		End case 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
	: (Form event:C388=On Clicked:K2:4)
		If (Size of array:C274(alACT_RecNumsDocs)>1)
			If (cs_aplicaraTodos=1)
				OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
				OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"@next@";True:C214)
				OBJECT SET VISIBLE:C603(*;"@Ingresar@";False:C215)
			End if 
		End if 
End case 