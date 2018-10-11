//%attributes = {}
  //ACTdte_AlertasOpciones

C_TEXT:C284($t_accion;$1)
C_TEXT:C284($t_retorno;$0)
C_BLOB:C604($xBlob)
C_LONGINT:C283($l_offSet)
C_POINTER:C301(${2})
C_POINTER:C301($y_pointer1;$y_blob)
C_LONGINT:C283($l_idRS)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_pointer1:=$2
End if 

Case of 
	: ($t_accion="DeclaraVars")
		C_REAL:C285(r_alertarIEC;r_alertarIEV;r_alertarFolios)
		C_REAL:C285(r_alertarDiaIEC;r_alertarDiaIEV)
		C_TEXT:C284(dts_ultimaEjecucion)
		C_TEXT:C284(dts_ultimaEjecucionMsj)
		r_alertarIEC:=0  //preferencias que se leen desde la configuracion
		r_alertarIEV:=0  //preferencias que se leen desde la configuracion
		r_alertarFolios:=0  //preferencias que se leen desde la configuracion
		
		r_alertarDiaIEC:=0
		r_alertarDiaIEV:=0
		
		dts_ultimaEjecucion:=DTS_MakeFromDateTime (!00-00-00!;?00:00:00?)
		dts_ultimaEjecucionMsj:=DTS_MakeFromDateTime (!00-00-00!;?00:00:00?)
		
	: ($t_accion="InicializaVars")
		ACTdte_AlertasOpciones ("DeclaraVars")
		If (<>gCountryCode="cl")  //para Chile se activan
			r_alertarIEC:=1  //preferencias que se leen desde la configuracion
			r_alertarIEV:=1  //preferencias que se leen desde la configuracion
			r_alertarFolios:=1  //preferencias que se leen desde la configuracion
			
			r_alertarDiaIEC:=25
			r_alertarDiaIEV:=25
		End if 
		
	: ($t_accion="LeeBlob")
		If (Not:C34(Is nil pointer:C315($y_pointer1)))
			$l_idRS:=$y_pointer1->
		Else 
			$l_idRS:=-1
		End if 
		ACTdte_AlertasOpciones ("InicializaVars")
		ACTdte_AlertasOpciones ("ArmaBlob";->$xBlob)
		$xBlob:=PREF_fGetBlob (0;"ACT_DTE_ALERTAS_"+String:C10($l_idRS);$xBlob)
		ACTdte_AlertasOpciones ("CargaBlob";->$xBlob)
		
	: ($t_accion="GuardaBlob")
		If (Not:C34(Is nil pointer:C315($y_pointer1)))
			$l_idRS:=$y_pointer1->
		Else 
			$l_idRS:=-1
		End if 
		ACTdte_AlertasOpciones ("ArmaBlob";->$xBlob)
		PREF_SetBlob (0;"ACT_DTE_ALERTAS_"+String:C10($l_idRS);$xBlob)
		ACTdte_AlertasOpciones ("DeclaraVars")
		
	: ($t_accion="ArmaBlob")
		$y_blob:=$y_pointer1
		$l_offSet:=BLOB_Variables2Blob ($y_blob;0;->r_alertarIEC;->r_alertarIEV;->r_alertarFolios;->r_alertarDiaIEC;->r_alertarDiaIEV;->dts_ultimaEjecucion;->dts_ultimaEjecucionMsj)
		
	: ($t_accion="CargaBlob")
		$y_blob:=$y_pointer1
		BLOB_Blob2Vars ($y_blob;0;->r_alertarIEC;->r_alertarIEV;->r_alertarFolios;->r_alertarDiaIEC;->r_alertarDiaIEV;->dts_ultimaEjecucion;->dts_ultimaEjecucionMsj)
		
	: ($t_accion="ValidaVariablesForm")
		If (r_alertarIEC=0)
			r_alertarDiaIEC:=0
		Else 
			If (r_alertarDiaIEC=0)
				r_alertarDiaIEC:=25
			End if 
		End if 
		
		If (r_alertarIEV=0)
			r_alertarDiaIEV:=0
		Else 
			If (r_alertarDiaIEV=0)
				r_alertarDiaIEV:=25
			End if 
		End if 
		
		OBJECT SET ENTERABLE:C238(r_alertarDiaIEC;r_alertarIEC=1)
		OBJECT SET ENTERABLE:C238(r_alertarDiaIEV;r_alertarIEV=1)
		
End case 

$0:=$t_retorno