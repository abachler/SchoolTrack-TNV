
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 05/10/17, 13:55:30
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].CIM_InfoRespaldos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

Case of 
	: (Form event:C388=On Load:K2:1)
		
		hl_CIM_InfoRespaldos:=AT_Array2ReferencedList (-><>atCIM_InfoRespaldos;-><>alCIM_InfoRespaldos;0;False:C215;True:C214)
		FORM FIRST PAGE:C250
		vl_numPestaña:=1
		
		ARRAY TEXT:C222($at_keys;0)
		ARRAY REAL:C219($ar_keysPesos;0)
		ARRAY TEXT:C222(at_nombreBkpNube;0)
		ARRAY TEXT:C222(at_tamañoBkpNube;0)
		ARRAY TEXT:C222($tt_requestHeadersArray;0)
		ARRAY TEXT:C222($tt_responseHeadersArray;0)
		
		C_LONGINT:C283($vl_httpReponseStatus)
		C_TEXT:C284($vt_uriBase;$vt_bucket;$vt_uri;$vt_httpVerb;$t_accion)
		C_BLOB:C604($vx_requestBodyBlob;$vx_responseBodyBlob)
		
		
		BKPs3_LoadConfig 
		If ((<>GCOUNTRYCODE="") | (<>gRolBD=""))
			STR_ReadGlobals 
		End if 
		
		$vt_uriBase:="/"+ST_Uppercase (<>GCOUNTRYCODE)+"/"+ST_Uppercase (<>gRolBD)+"/"
		
		$vt_bucket:="bases-st"
		$vt_uri:="/?list-type=2&prefix="+Substring:C12($vt_uriBase;2;Length:C16($vt_uriBase))+"&delimiter=/"
		$vt_httpVerb:=HTTP GET method:K71:1
		$t_accion:="keys"
		
		$vl_httpReponseStatus:=S3_restApi ($vt_httpVerb;$vt_bucket;$vt_uri;->$tt_requestHeadersArray;->$vx_requestBodyBlob;->$tt_responseHeadersArray;->$vx_responseBodyBlob)
		If ($vl_httpReponseStatus=200)
			$t:=BKPs3_AnalizaRespuesta ($t_accion;$vx_responseBodyBlob;->$at_keys;->$ar_keysPesos)
			
			If ((Size of array:C274($at_keys)>0) & (Size of array:C274($ar_keysPesos)>0))
				For ($z;1;Size of array:C274($at_keys))
					APPEND TO ARRAY:C911(at_nombreBkpNube;$at_keys{$z})
					APPEND TO ARRAY:C911(at_tamañoBkpNube;String:C10($ar_keysPesos{$z}))
				End for 
			End if 
		Else 
			CD_Dlog (0;"Error en la consulta. Error número: "+String:C10($vl_httpReponseStatus)+".")
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 