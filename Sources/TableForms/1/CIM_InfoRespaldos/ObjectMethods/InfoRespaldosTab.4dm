
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 22/09/17, 12:25:32
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].CIM_InfoRespaldos.InfoRespaldosTab
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($vt_text)
GET LIST ITEM:C378(hl_CIM_InfoRespaldos;Selected list items:C379(hl_CIM_InfoRespaldos);vl_numPestaña;$vt_text)

Case of 
	: (vl_numPestaña=1)
		
		ARRAY TEXT:C222($at_keys;0)
		ARRAY REAL:C219($ar_keysPesos;0)
		ARRAY TEXT:C222(at_nombreBkpNube;0)
		ARRAY TEXT:C222(at_tamañoBkpNube;0)
		ARRAY TEXT:C222($tt_requestHeadersArray;0)
		ARRAY TEXT:C222($tt_responseHeadersArray;0)
		
		C_TEXT:C284($vt_uriBase)
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
			CD_Dlog (0;"Error en la consulta. Error número: "+String:C10($vl_httpReponseStatus))
		End if 
		
		
		
		
	: (vl_numPestaña=2)
		
		C_POINTER:C301($y_mostrarMsg)
		C_TEXT:C284($vt_fecha;$vt_hora;$vt_evento)
		C_LONGINT:C283($vl_dia;$vl_mes;$vl_año)
		
		
		ARRAY TEXT:C222($at_log;0)
		ARRAY TEXT:C222(atCIM_fecha;0)
		ARRAY TEXT:C222(atCIM_hora;0)
		ARRAY TEXT:C222(atCIM_Evento;0)
		
		GET PROCESS VARIABLE:C371(-1;<>atBKPaws_log;$at_log)
		
		
		If (Not:C34(Undefined:C82(<>atBKPaws_log)))
			
			If (Size of array:C274($at_log)>0)
				
				For ($z;1;Size of array:C274($at_log))
					
					$vl_año:=Num:C11((Substring:C12($at_log{$z};1;4)))
					$vl_mes:=Num:C11((Substring:C12($at_log{$z};6;2)))
					$vl_dia:=Num:C11((Substring:C12($at_log{$z};9;2)))
					$vt_fecha:=String:C10(DT_GetDateFromDayMonthYear ($vl_dia;$vl_mes;$vl_año))
					$vt_hora:=Substring:C12($at_log{$z};12;2)+":"+Substring:C12($at_log{$z};15;2)+":"+Substring:C12($at_log{$z};18;2)
					$vt_evento:=ST_GetWord ($at_log{$z};2;"\t")
					
					APPEND TO ARRAY:C911(atCIM_fecha;$vt_fecha)
					APPEND TO ARRAY:C911(atCIM_hora;$vt_hora)
					APPEND TO ARRAY:C911(atCIM_Evento;$vt_evento)
				End for 
				
			End if 
		End if 
		
		
		
End case 
FORM GOTO PAGE:C247(vl_numPestaña)