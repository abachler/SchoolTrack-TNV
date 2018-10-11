Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ACTtf_DeclareArrays 
		ARRAY TEXT:C222(atACT_Modo_de_Pago;0)
		C_LONGINT:C283(cs_IEncabezado;cs_IPie;PWTrf_h2;PWTrf_h1;WTrf_s1;WTrf_s2;WTrf_s3)
		C_LONGINT:C283(vlInicio;vlLargo)
		C_TEXT:C284(vtAlin;vtRelleno;vt_ICodApr;vIIdentificador)
		C_LONGINT:C283(vlPos)
		C_BLOB:C604(xblob)
		COPY ARRAY:C226(<>atACT_ModosdePago;atACT_Modo_de_Pago)
		
		vlInicio:=0
		vlLargo:=0
		vtAlin:=""
		vtRelleno:=""
		vlPos:=0
		WTrf_s1:=0
		WTrf_s2:=0
		WTrf_s3:=0
		
		ARRAY TEXT:C222(at_IIdentificador;2)
		at_IIdentificador{1}:="Rut apoderado"
		at_IIdentificador{2}:="Código de familia"
		vIIdentificador:=at_IIdentificador{1}
		
		SET BLOB SIZE:C606(xblob;0)
		BLOB_Variables2Blob (->xblob;0;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->PWTrf_h2;->vlInicio;->vlLargo;->vtAlin;->vtRelleno;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->vlPos)
		xblob:=PREF_fGetBlob (0;"PreferenciasUniversoACT";xblob)
		BLOB_Blob2Vars (->xblob;0;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->PWTrf_h2;->vlInicio;->vlLargo;->vtAlin;->vtRelleno;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->vlPos)
		SET BLOB SIZE:C606(xblob;0)
		
		AT_Insert (1;2;->atACT_FillExp)
		atACT_FillExp{1}:="Espacio"
		atACT_FillExp{2}:="Cero"
		
		AT_Insert (1;2;->atACT_AlinExp)
		atACT_AlinExp{1}:="Der"
		atACT_AlinExp{2}:="Izq"
		
		  //at_IIdentificador{2}:="Rut titular Cuenta Corriente"
		AT_Insert (1;1;->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales;->al_Numero;->at_idsTextos)  //se inserta 1 en los arreglos a utilizar
		
		If (PWTrf_h2=1)  //plano
			OBJECT SET ENTERABLE:C238(*;"aPlano@";True:C214)
			_O_ENABLE BUTTON:C192(*;"aPlano@")
		Else 
			OBJECT SET ENTERABLE:C238(*;"aPlano@";False:C215)
			_O_DISABLE BUTTON:C193(*;"aPlano@")
		End if 
		If (PWTrf_h1=1)  //delimitado
			OBJECT SET ENTERABLE:C238(*;"sTab@";True:C214)
			_O_ENABLE BUTTON:C192(*;"sTab@")
		Else 
			OBJECT SET ENTERABLE:C238(*;"sTab@";False:C215)
			_O_DISABLE BUTTON:C193(*;"sTab@")
		End if 
	: (Form event:C388=On Clicked:K2:4)
		If (PWTrf_h2=1)  //plano
			OBJECT SET ENTERABLE:C238(*;"aPlano@";True:C214)
			_O_ENABLE BUTTON:C192(*;"aPlano@")
		Else 
			OBJECT SET ENTERABLE:C238(*;"aPlano@";False:C215)
			_O_DISABLE BUTTON:C193(*;"aPlano@")
		End if 
		If (PWTrf_h1=1)  //delimitado
			OBJECT SET ENTERABLE:C238(*;"sTab@";True:C214)
			_O_ENABLE BUTTON:C192(*;"sTab@")
		Else 
			OBJECT SET ENTERABLE:C238(*;"sTab@";False:C215)
			_O_DISABLE BUTTON:C193(*;"sTab@")
		End if 
End case 
