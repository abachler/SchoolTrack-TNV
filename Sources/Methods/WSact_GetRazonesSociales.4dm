//%attributes = {}
  //WSact_GetRazonesSociales

  //****DECLARACIONES****
C_TEXT:C284(vtWS_ResultString)
ARRAY TEXT:C222(atRSws_Rut;0)
ARRAY TEXT:C222(atRSws_Nombre;0)
ARRAY LONGINT:C221(alRSws_NumeroRes;0)
ARRAY DATE:C224(adRSws_FechaRes;0)
ARRAY BOOLEAN:C223(abRSws_enrolado;0)
C_BOOLEAN:C305($b_ambienteProd)

C_TEXT:C284($t_resp;$t_r;$t_req)
C_LONGINT:C283($http)
C_BOOLEAN:C305($b_error)
C_TEXT:C284($t_msj)

  //****INICIALIZACIONES****
vtWS_ResultString:=""
$b_ambienteProd:=(Num:C11(PREF_fGet (0;"ACT_AMBIENTE_CERTIFICACION_SII";"1"))=0)

  //$b_ambienteProduccion:=False
  //$b_ambienteProduccion:=True

  //20160716 RCH
  //$t_ref:=JSON New 
  //$t_r:=JSON Append text ($t_ref;"codpais";<>gCountryCode)
  //$t_r:=JSON Append text ($t_ref;"rolbd";<>gRolBD)
  //$t_r:=JSON Append text ($t_ref;"produccion";String(Num($b_ambienteProd)))
  //$t_req:=JSON Export to text ($t_ref;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($t_ref)
C_OBJECT:C1216($ob_json)
OB SET:C1220($ob_json;"codpais";<>gCountryCode;"rolbd";<>gRolBD;"produccion";String:C10(Num:C11($b_ambienteProd)))
$t_req:=JSON Stringify:C1217($ob_json)

$l_codHTTP:=Intranet3_LlamadoWS ("WSsend_RazonesSociales";$t_req;->$t_resp)
If ($l_codHTTP=200)
	  //ARRAY TEXT($nodes;0)
	  //ARRAY LONGINT($types;0)
	  //ARRAY TEXT($names;0)
	
	ARRAY OBJECT:C1221($ao_Razon;0)
	
	
	  // Modificado por: Alexis Bustamante (10-06-2017)
	  //TICKET 179869
	  //Cambio de plugin por comando nativo
	
	  //$t_ref:=JSON Parse text ($t_resp)
	
	$ob:=JSON Parse:C1218($t_resp;Is object:K8:27)
	
	
	OB_GET ($ob;->$b_error;"error")
	OB_GET ($ob;->$t_msj;"mensaje")
	
	  //JSON_ExtraeValor ($t_ref;"error";->$b_error)
	  //JSON_ExtraeValor ($t_ref;"mensaje";->$t_msj)
	
	
	If (Not:C34($b_error))
		  //OB_GetChildNodes ($ob;$nodes;$types;$names)
		  //ARRAY LONGINT($nodes;0)
		  //JSON GET CHILD NODES ($t_ref;$nodes;$types;$names)
		
		OB_GET ($ob;->$ao_Razon;"resultado")
		
		  //If (Size of array($ao_Razon)>=3)
		If (Size of array:C274($ao_Razon)>0)  //20170731 RCH
			
			ARRAY TEXT:C222($nodes2;0)
			ARRAY LONGINT:C221($types2;0)
			ARRAY TEXT:C222($names2;0)
			
			For ($l_nodos;1;Size of array:C274($ao_Razon))
				C_TEXT:C284($t_rut;$t_nombrerazonsocial;$t_fecharesolucion)
				C_LONGINT:C283($l_numRes)
				C_BOOLEAN:C305($b_enrolado)
				
				OB_GET ($ao_Razon{$l_nodos};->$t_rut;"rut")
				OB_GET ($ao_Razon{$l_nodos};->$t_nombrerazonsocial;"nombrerazonsocial")
				OB_GET ($ao_Razon{$l_nodos};->$t_fecharesolucion;"fecharesolucion")
				OB_GET ($ao_Razon{$l_nodos};->$l_numRes;"numeroresolucion")
				OB_GET ($ao_Razon{$l_nodos};->$b_enrolado;"enrolado")
				
				APPEND TO ARRAY:C911(atRSws_Rut;$t_rut)
				APPEND TO ARRAY:C911(atRSws_Nombre;$t_nombrerazonsocial)
				APPEND TO ARRAY:C911(alRSws_NumeroRes;$l_numRes)
				APPEND TO ARRAY:C911(adRSws_FechaRes;DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_fecharesolucion;1;2));Num:C11(Substring:C12($t_fecharesolucion;4;2));Num:C11(Substring:C12($t_fecharesolucion;7;4))))
				APPEND TO ARRAY:C911(abRSws_enrolado;$b_enrolado)
			End for 
			
			  //JSON GET CHILD NODES ($nodes{3};$nodes2;$types2;$names2)  //20161006 RCH Se obtienen todas las RS
			  //For ($l_nodos;1;Size of array($nodes2))
			  //C_TEXT($t_rut;$t_nombrerazonsocial;$t_fecharesolucion)
			  //C_LONGINT($l_numRes)
			  //C_BOOLEAN($b_enrolado)
			  //JSON_ExtraeValor ($nodes2{$l_nodos};"rut";->$t_rut)
			  //JSON_ExtraeValor ($nodes2{$l_nodos};"nombrerazonsocial";->$t_nombrerazonsocial)
			  //JSON_ExtraeValor ($nodes2{$l_nodos};"fecharesolucion";->$t_fecharesolucion)
			  //JSON_ExtraeValor ($nodes2{$l_nodos};"numeroresolucion";->$l_numRes)
			  //JSON_ExtraeValor ($nodes2{$l_nodos};"enrolado";->$b_enrolado)
			
			  //APPEND TO ARRAY(atRSws_Rut;$t_rut)
			  //APPEND TO ARRAY(atRSws_Nombre;$t_nombrerazonsocial)
			  //APPEND TO ARRAY(alRSws_NumeroRes;$l_numRes)
			  //APPEND TO ARRAY(adRSws_FechaRes;DT_GetDateFromDayMonthYear (Num(Substring($t_fecharesolucion;1;2));Num(Substring($t_fecharesolucion;4;2));Num(Substring($t_fecharesolucion;7;4))))
			  //APPEND TO ARRAY(abRSws_enrolado;$b_enrolado)
			  //End for 
			
		End if 
	End if 
	  //JSON CLOSE ($t_ref)
End if 


Case of 
	: ($l_codHTTP#200)
		$0:=False:C215
		CD_Dlog (0;__ ("No fue posible conectarse a Colegium."))
	: ($b_error)
		$0:=False:C215
		CD_Dlog (0;$t_msj)
	: (Size of array:C274(atRSws_Rut)=0)
		$0:=False:C215
		CD_Dlog (0;__ ("No hay razones sociales ingresadas en Colegium."))
	Else 
		$0:=True:C214
		C_LONGINT:C283($vl_existe)
		For ($i;1;Size of array:C274(atRSws_Rut))
			$vl_existe:=Find in field:C653([ACT_RazonesSociales:279]RUT:3;atRSws_Rut{$i})
			If ($vl_existe#-1)
				READ WRITE:C146([ACT_RazonesSociales:279])
				GOTO RECORD:C242([ACT_RazonesSociales:279];$vl_existe)
				If ([ACT_RazonesSociales:279]razon_social:2#atRSws_Nombre{$i})
					CD_Dlog (0;"La razón social ingresada en Colegium ("+ST_Qte (atRSws_Nombre{$i})+"), para el RUT "+atRSws_Rut{$i}+", no correspondía a la ingresada en la ficha del colegio en AccountTrack ("+ST_Qte ([ACT_RazonesSociales:279]razon_social:2)+")."+"\r\r"+"Se asignó la razón social ingresada en Colegium.")
				End if 
				[ACT_RazonesSociales:279]razon_social:2:=atRSws_Nombre{$i}
				[ACT_RazonesSociales:279]enrolado_dte:19:=abRSws_enrolado{$i}
				[ACT_RazonesSociales:279]numero_resolucion:21:=alRSws_NumeroRes{$i}
				[ACT_RazonesSociales:279]fecha_resolucion:20:=adRSws_FechaRes{$i}
				
				If ([ACT_RazonesSociales:279]fecha_resolucion:20#!00-00-00!)
					[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ 1  //enrolado intranet
				End if 
				
				If (KRL_FieldChanges (->[ACT_RazonesSociales:279]fecha_resolucion:20))  // si cambia el dato, se debe enviar nuevamente a DTE
					[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?- 2
				End if 
				If (KRL_FieldChanges (->[ACT_RazonesSociales:279]numero_resolucion:21))  // si cambia el dato, se debe enviar nuevamente a DTE
					[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?- 2
				End if 
				
				SAVE RECORD:C53([ACT_RazonesSociales:279])
				  //KRL_UnloadReadOnly (->[ACT_RazonesSociales])
			End if 
		End for 
End case 


  //
  //
  //
  //READ ONLY([Colegio])
  //ALL RECORDS([Colegio])
  //FIRST RECORD([Colegio])
  //$countryCode:=[Colegio]Codigo_Pais
  //$rolBD:=[Colegio]Rol Base Datos
  //
  //WEB SERVICE SET PARAMETER("countryCode";$countryCode)
  //WEB SERVICE SET PARAMETER("rolBD";$rolBD)
  //WEB SERVICE SET PARAMETER("produccion";$b_ambienteProd)
  //
  //  //****CUERPO****
  //WSact_DTECallWebServiceIntranet ("WSsend_RazonesSociales")
  //
  //If (OK=1)
  //WEB SERVICE GET RESULT(vtWS_ResultString;"ERRstring")
  //WEB SERVICE GET RESULT(atRSws_Rut;"rut")
  //WEB SERVICE GET RESULT(atRSws_Nombre;"nombre")
  //WEB SERVICE GET RESULT(alRSws_NumeroRes;"numRes")
  //WEB SERVICE GET RESULT(adRSws_FechaRes;"fecRes")
  //WEB SERVICE GET RESULT(abRSws_enrolado;"enrolado";*)
  //End if 
  //
  //Case of 
  //: ((error#0) | (ok=0))
  //$0:=False
  //CD_Dlog (0;__ ("No fue posible conectarse a Colegium."))
  //: (vtWS_ResultString#"")
  //$0:=False
  //CD_Dlog (0;vtWS_ResultString)
  //: ((vtWS_ResultString="") & (Size of array(atRSws_Rut)=0))
  //$0:=False
  //CD_Dlog (0;__ ("No hay razones sociales ingresadas en Colegium."))
  //: (vtWS_ResultString="")
  //$0:=True
  //C_LONGINT($vl_existe)
  //For ($i;1;Size of array(atRSws_Rut))
  //$vl_existe:=Find in field([ACT_RazonesSociales]RUT;atRSws_Rut{$i})
  //If ($vl_existe#-1)
  //READ WRITE([ACT_RazonesSociales])
  //GOTO RECORD([ACT_RazonesSociales];$vl_existe)
  //If ([ACT_RazonesSociales]razon_social#atRSws_Nombre{$i})
  //CD_Dlog (0;"La razón social ingresada en Colegium ("+ST_Qte (atRSws_Nombre{$i})+"), para el RUT "+atRSws_Rut{$i}+", no correspondía a la ingresada en la ficha del colegio en AccountTrack ("+ST_Qte ([ACT_RazonesSociales]razon_social)+")."+<>cr+<>cr+"Se asignó la razón social ingresada en Colegium.")
  //End if 
  //[ACT_RazonesSociales]razon_social:=atRSws_Nombre{$i}
  //[ACT_RazonesSociales]enrolado_dte:=abRSws_enrolado{$i}
  //[ACT_RazonesSociales]numero_resolucion:=alRSws_NumeroRes{$i}
  //[ACT_RazonesSociales]fecha_resolucion:=adRSws_FechaRes{$i}
  //
  //If ([ACT_RazonesSociales]fecha_resolucion#!00-00-0000!)
  //[ACT_RazonesSociales]estadoConfiguracion:=[ACT_RazonesSociales]estadoConfiguracion ?+ 1  //enrolado intranet
  //End if 
  //
  //If (KRL_FieldChanges (->[ACT_RazonesSociales]fecha_resolucion))  // si cambia el dato, se debe enviar nuevamente a DTE
  //[ACT_RazonesSociales]estadoConfiguracion:=[ACT_RazonesSociales]estadoConfiguracion ?- 2
  //End if 
  //If (KRL_FieldChanges (->[ACT_RazonesSociales]numero_resolucion))  // si cambia el dato, se debe enviar nuevamente a DTE
  //[ACT_RazonesSociales]estadoConfiguracion:=[ACT_RazonesSociales]estadoConfiguracion ?- 2
  //End if 
  //
  //SAVE RECORD([ACT_RazonesSociales])
  //  //KRL_UnloadReadOnly (->[ACT_RazonesSociales])
  //End if 
  //End for 
  //End case 
  //****LIMPIEZA****


