//%attributes = {"invisible":true}
  // Zip_WITH_PROGRESS()
  // 
  //
  // creado por: Alberto Bachler Klein: 29-07-16, 17:24:17
  // -----------------------------------------------------------
C_OBJECT:C1216($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_exito;$b_usar7z)
C_DATE:C307($d_fecha)
C_LONGINT:C283($l_exito;$l_parametros;$l_proceso;$l_procesoLLamante)
C_TIME:C306($d_hora)
C_TEXT:C284($t_password;$t_Resultado;$t_rutaDestino;$t_rutaOrigen)


If (False:C215)
	C_OBJECT:C1216(Zip_WITH_PROGRESS ;$1)
	C_LONGINT:C283(Zip_WITH_PROGRESS ;$2)
End if 

C_OBJECT:C1216(ob_ZIP_Context)

$l_parametros:=Count parameters:C259

Case of 
	: ($l_parametros=1)
		$l_proceso:=New process:C317(Current method name:C684;0;"$"+Current method name:C684;$1;Current process:C322;*)
		
	: ($l_parametros=2)
		<>ZIP_ABORT:=False:C215
		<>ZIP_STATUS:=0
		
		ob_ZIP_Context:=$1
		vl_ZIPprocesoLLamante:=$2
		
		$t_rutaOrigen:=OB Get:C1224(ob_ZIP_Context;"srcPath")
		$t_rutaDestino:=OB Get:C1224(ob_ZIP_Context;"dstPath")
		$t_password:=OB Get:C1224(ob_ZIP_Context;"password")
		
		
		$b_usar7z:=False:C215
		If ($b_usar7z)
			$b_exito:=SYS_CompresionDescompresion_7z ($t_rutaOrigen;$t_rutaDestino;$t_password;->$t_Resultado)
			If ($b_exito)
				  //If (Timestamp_Get(->$d_fecha;->$d_hora))
				  //ON ERR CALL("ERR_LogExecutionError")
				  //SET DOCUMENT PROPERTIES($t_rutaDestino;False;False;$d_fecha;$d_hora;$d_fecha;$d_hora)
				  //ON ERR CALL("")
				  //End if
				OB SET:C1220(ob_ZIP_Context;"Error";"")
				EXECUTE METHOD:C1007(OB Get:C1224(ob_ZIP_Context;"onSuccess");*;$l_procesoLLamante;$t_resultado)
			Else 
				OB SET:C1220(ob_ZIP_Context;"Error";$t_resultado)
				EXECUTE METHOD:C1007(OB Get:C1224(ob_ZIP_Context;"onError");*;$l_procesoLLamante;$t_resultado)
			End if 
			
			
		Else 
			$l_exito:=Zip ($t_rutaOrigen;$t_rutaDestino;"";ZIP_Compression_level_2;ZIP_With_attributes;"Zip_CALLBACK")
			If ($l_exito=1)
				OB SET:C1220(ob_ZIP_Context;"Error";"")
				EXECUTE METHOD:C1007(OB Get:C1224(ob_ZIP_Context;"onSuccess");*;vl_ZIPprocesoLLamante;$t_resultado)
			Else 
				OB SET:C1220(ob_ZIP_Context;"Error";$t_resultado)
				EXECUTE METHOD:C1007(OB Get:C1224(ob_ZIP_Context;"onError");*;vl_ZIPprocesoLLamante;$t_resultado)
			End if 
		End if 
End case 