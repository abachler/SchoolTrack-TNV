//%attributes = {}
  //RINSCwa_EnviaCargos

C_TEXT:C284($t_principal;$t_err;$node;$t_avisos;$t_cargo;$json)
C_LONGINT:C283($l_indice;$l_pos;$l_idApp)
C_TEXT:C284($t_periodo;$0;$t_parametro;$t_llavePrivada;$t_hash)
C_BLOB:C604($blob)
C_REAL:C285($r_error)

READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([Colegio:31])

If (Count parameters:C259=1)
	$t_json:=$1
Else 
	$t_json:=RINSCwa_TestJSONEnviaCargos 
End if 







If (CONDOR_ValidaAutenticacion (4;$t_json))
	
	C_TEXT:C284($t_periodo)
	
	
	  // Modificado por: Alexis Bustamante (10-06-2017)
	  //Ticket 179869
	
	
	C_OBJECT:C1216($ob)
	
	$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
	
	  //$t_principal:=JSON Parse text ($t_json)
	
	OB_GET ($ob;->$t_periodo;"anio")
	
	If ($t_periodo#"")
		  //If (($t_principal#"0") & ($t_principal#"false"))
		$r_error:=0
		  //JSON_ExtraeValor ($t_principal;"anio";->$t_periodo)
		  //JSON CLOSE ($t_principal)
	Else 
		$r_error:=-2
	End if 
	
	If ($r_error=0)
		
		  //si el periodo es vacio se devuelve lo configurado para el siguiente periodo escolar
		If ($t_periodo="")
			$t_periodo:=<>gNombreAgnoEscolar
			For ($l_indice;Year of:C25(Current date:C33(*))+5;Year of:C25(Current date:C33(*))-5;-1)  // no se puede mas de 19 porque sino se reemplazara el año
				$t_periodo:=Replace string:C233($t_periodo;String:C10($l_indice);String:C10($l_indice+1))
			End for 
		End if 
		
		
		ARRAY LONGINT:C221($alACT_AIDCargo;0)
		ARRAY TEXT:C222($atACT_glosa;0)
		ARRAY REAL:C219($alACT_monto;0)
		ARRAY TEXT:C222($atACT_moneda;0)
		ARRAY TEXT:C222($atACT_observaciones;0)
		
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Periodo:42=$t_periodo)
		
		If (Records in selection:C76([xxACT_Items:179])>0)
			While (Not:C34(End selection:C36([xxACT_Items:179])))
				APPEND TO ARRAY:C911($alACT_AIDCargo;[xxACT_Items:179]ID:1)
				APPEND TO ARRAY:C911($atACT_glosa;[xxACT_Items:179]Glosa:2)
				APPEND TO ARRAY:C911($alACT_monto;[xxACT_Items:179]Monto:7)
				APPEND TO ARRAY:C911($atACT_moneda;[xxACT_Items:179]Moneda:10)
				APPEND TO ARRAY:C911($atACT_observaciones;[xxACT_Items:179]Observaciones:11)
				NEXT RECORD:C51([xxACT_Items:179])
			End while 
			
			C_TEXT:C284($t_version;$t_mensaje)
			$t_version:=SYS_LeeVersionBaseDeDatos   //20160824 RCH
			
			  //armo json
			
			C_LONGINT:C283($vl_error)
			C_OBJECT:C1216($ob_raiz;$ob_temp)
			ARRAY OBJECT:C1221($ao_cargos;0)
			
			$vl_error:=0
			$t_mensaje:=""
			$ob_raiz:=OB_Create 
			
			OB_SET ($ob_raiz;->$vl_error;"error")
			OB_SET ($ob_raiz;->$t_mensaje;"mensaje")
			OB_SET ($ob_raiz;->$t_version;"version_st")
			
			
			
			For ($l_indice;1;Size of array:C274($alACT_AIDCargo))
				$ob_temp:=OB_Create 
				OB_SET ($ob_temp;->$alACT_AIDCargo{$l_indice};"id")
				OB_SET ($ob_temp;->$atACT_glosa{$l_indice};"nombre")
				OB_SET ($ob_temp;->$alACT_monto{$l_indice};"monto")
				OB_SET ($ob_temp;->$atACT_moneda{$l_indice};"moneda")
				OB_SET ($ob_temp;->$atACT_observaciones{$l_indice};"observaciones")
				APPEND TO ARRAY:C911($ao_cargos;$ob_temp)
				CLEAR VARIABLE:C89($ob_temp)
			End for 
			OB_SET ($ob_raiz;->$ao_cargos;"cargos")
			
			
			  //20170822 RCH Desde 12.2.14257
			If (<>vtXS_CountryCode="")
				STR_ReadGlobals 
			End if 
			ACTcfgmyt_CargaArreglos 
			ARRAY OBJECT:C1221($ao_bancos;0)
			For ($l_indice;1;Size of array:C274(atACT_BankID))
				$ob_temp:=OB_Create 
				OB_SET ($ob_temp;->atACT_BankID{$l_indice};"serie")
				OB_SET ($ob_temp;->atACT_BankName{$l_indice};"nombre")
				APPEND TO ARRAY:C911($ao_bancos;$ob_temp)
				CLEAR VARIABLE:C89($ob_temp)
			End for 
			OB_SET ($ob_raiz;->$ao_bancos;"bancos")
			
			ARRAY TEXT:C222($sElements;0)
			READ ONLY:C145([xShell_List:39])
			QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Tarjetas de Crédito")
			$arrayPointer:=Get pointer:C304([xShell_List:39]ArrayName1:5)
			BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;$arrayPointer)
			COPY ARRAY:C226($arrayPointer->;$sElements)
			SORT ARRAY:C229($sElements;>)
			ARRAY OBJECT:C1221($ao_tipostc;0)
			For ($l_indice;1;Size of array:C274($sElements))
				$ob_temp:=OB_Create 
				OB_SET ($ob_temp;->$sElements{$l_indice};"tipo_tarjeta")
				APPEND TO ARRAY:C911($ao_tipostc;$ob_temp)
				CLEAR VARIABLE:C89($ob_temp)
			End for 
			OB_SET ($ob_raiz;->$ao_tipostc;"tipo_tarjeta")  //20170822 RCH
			
			ARRAY TEXT:C222($sElements;0)
			READ ONLY:C145([xShell_List:39])
			QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Lugares de Pago")
			$arrayPointer:=Get pointer:C304([xShell_List:39]ArrayName1:5)
			BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;$arrayPointer)
			COPY ARRAY:C226($arrayPointer->;$sElements)
			SORT ARRAY:C229($sElements;>)
			ARRAY OBJECT:C1221($ao_lugares;0)
			For ($l_indice;1;Size of array:C274($sElements))
				$ob_temp:=OB_Create 
				OB_SET ($ob_temp;->$sElements{$l_indice};"lugar")
				APPEND TO ARRAY:C911($ao_lugares;$ob_temp)
				CLEAR VARIABLE:C89($ob_temp)
			End for 
			OB_SET ($ob_raiz;->$ao_lugares;"lugar")  //20170822 RCH
			
			$json:=OB_Object2Json ($ob_raiz)
		Else 
			$r_error:=-21
		End if 
		
	End if 
	
Else 
	$r_error:=-19
End if 

If ($r_error#0)
	$json:=RINSCwa_RespuestaError ($r_error)
End if 

$0:=$json