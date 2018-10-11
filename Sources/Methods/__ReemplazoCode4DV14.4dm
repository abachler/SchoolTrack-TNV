//%attributes = {}
  // __ReemplazoCode4DV14()
  // Por: Alberto Bachler K.: 30-03-15, 12:25:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($t_json;$t_raizJson)

ARRAY TEXT:C222($usuarios;0)



  // EN METODO STWA2_ONWEBCONECTION
If (False:C215)
	  //If (($url="stwa@") | ($url="/stwa@"))
	  //Case of 
	  //: ($action="builder")
	  //$dato:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"dato")
	  //Case of 
	  //  //...
	  //: ($dato="graficanotas")
	  //  //...
	  //: ($dato="foto")  // aproximadamente en linea 2524
	  //$rn:=Num(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"rnCal"))
	  //$json:=STWA2_AJAX_SendFotoAlumno ($rn)
	
	  //: ($dato="fotoalumnoxalumno")  // aproximadamente en linea 2527
	  //$rn:=Num(NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"rnAlumno"))
	  //$json:=STWA2_AJAX_SendFotoAlumno 
	
	
	  //: ($action="saveDato")  // aproximadamente en linea 2580
	  //$t_raizJson:=JSON New 
	  //If (STWA2_SaveDato (->$aParameterNames;->$aParameterValues;$t_raizJson))
	  //JSON_AgregaTexto ($t_raizJson;"";"ERR")
	  //$json:=JSON Export to text ($t_raizJson;JSON_WITHOUT_WHITE_SPACE)
	  //JSON CLOSE ($t_raizJson)
	  //Else 
	  //$json:=STWA2_JSON_SendError (-70000)
	  //End if 
	
	  //Else 
	  //  //devolver json con error...
	  //$t_raizJson:=JSON New 
	  //JSON_AgregaTexto ($t_raizJson;"unknown action";"Error")
	  //$json:=JSON Export to text ($t_raizJson;JSON_WITHOUT_WHITE_SPACE)
	  //JSON CLOSE ($t_raizJson)
	  //End case 
	  //End case 
	
	  //Else 
	  //Case of 
	  //: ($action="imprimircomprobantevisitaenf")
	  //  //....
	  //: ($action="isValidSession")  // linea 2892
	  //$uuid:=NV_GetValueFromPairedArrays (->$aParameterNames;->$aParameterValues;"UUID")
	  //$valid:=STWA2_Session_IsSessionValid ($uuid)
	  //$t_raizJson:=JSON New 
	  //JSON_AgregaTexto ($t_raizJson;ST_Qte (String(Num($valid)));ST_Qte ("valida"))
	  //$t_json:=JSON Export to text ($t_raizJson;JSON_WITHOUT_WHITE_SPACE)
	  //JSON CLOSE ($t_raizJson)
	  //TEXT TO BLOB($t_json;$blob;UTF8 text without length)
	  //WEB SEND RAW DATA($blob;*)
	
	  //: ($action="users")  // linea 2901
	  //$tecleo:=Num(PREF_fGet (0;"DeshabillitarPredictivo";"0"))
	  //If ($tecleo=0)
	  //COPY ARRAY(<>atUSR_UserNames;$usuarios)
	  //End if 
	  //$t_raizJson:=JSON New 
	  //STWA2_Arreglo_a_json ($t_raizJson;->$usuarios;"users";"")
	  //TEXT TO BLOB($users;$blob;UTF8 text without length)
	  //WEB SEND RAW DATA($blob;*)
	
	  //: ($action="licencia")
	  //  //...
	  //End case 
	
	  //End if
	
End if 