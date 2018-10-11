//%attributes = {}
  //ACTdte_OpcionesManeja 

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
	: ($t_accion="InicializaVars")  //20161105 RCH
		C_REAL:C285(r_verificarDirecciones;r_generaDTEAlIngresarPago)
		C_TEXT:C284(t_indicadorServicioPBol;t_indicadorServicioPFac)
		C_REAL:C285(r_abrirDTEAlIngresarPago;r_enviarDTEAlIngresarPago;r_obtieneCopiaCedible;r_abrirDTEIngresoPagoNoReceptor)
		
		r_verificarDirecciones:=1  //preferencias que se leen desde la configuracion
		t_indicadorServicioPBol:="3"
		t_indicadorServicioPFac:=""
		r_generaDTEAlIngresarPago:=0
		r_abrirDTEAlIngresarPago:=1
		r_enviarDTEAlIngresarPago:=0
		r_obtieneCopiaCedible:=0
		r_abrirDTEIngresoPagoNoReceptor:=0
		
		  //opciones emisión/impresión
		C_REAL:C285(r_enviaDesc;r_enviaObs)
		C_TEXT:C284(vtACTdte_obs1;vtACTdte_obs2;vtACTdte_obs3;vtACTdte_obs4;vtACTdte_obs5;vtACTdte_obs6;vtACTdte_obs7;vtACTdte_obs7;vtACTdte_obs8;vtACTdte_obs9;vtACTdte_obs10)
		C_TEXT:C284(vtACT_TextoDescripcion;vtACT_TextoDescripcionFact)
		
		r_enviaDesc:=0
		r_enviaObs:=0
		vtACTdte_obs1:=""
		vtACTdte_obs2:=""
		vtACTdte_obs3:=""
		vtACTdte_obs4:=""
		vtACTdte_obs5:=""
		vtACTdte_obs6:=""
		vtACTdte_obs7:=""
		vtACTdte_obs7:=""
		vtACTdte_obs8:=""
		vtACTdte_obs9:=""
		vtACTdte_obs10:=""
		vtACT_TextoDescripcion:=""
		vtACT_TextoDescripcionFact:=""
	Else 
		
		If (<>gCountryCode="cl")  //20150313 RCH se agega validacion para solo cl
			Case of 
				: ($t_accion="ArreglosVars")
					ARRAY TEXT:C222(atACTdte_NomVar;0)
					ARRAY TEXT:C222(atACTdte_Var;0)
					ARRAY TEXT:C222(atACTdte_VarDisp;0)
					
					APPEND TO ARRAY:C911(atACTdte_NomVar;"&al_ape&")
					APPEND TO ARRAY:C911(atACTdte_NomVar;"&al_rut&")
					APPEND TO ARRAY:C911(atACTdte_NomVar;"&al_cur&")
					APPEND TO ARRAY:C911(atACTdte_NomVar;"&al_nivel&")
					APPEND TO ARRAY:C911(atACTdte_NomVar;"&car_mes&")
					APPEND TO ARRAY:C911(atACTdte_NomVar;"&car_year&")
					
					APPEND TO ARRAY:C911(atACTdte_Var;__ ("Apellidos y Nombres del Alumno"))
					APPEND TO ARRAY:C911(atACTdte_Var;__ ("RUT del Alumno"))
					APPEND TO ARRAY:C911(atACTdte_Var;__ ("Curso del Alumno"))
					APPEND TO ARRAY:C911(atACTdte_Var;__ ("Nivel del Alumno"))
					APPEND TO ARRAY:C911(atACTdte_Var;__ ("Mes"))
					APPEND TO ARRAY:C911(atACTdte_Var;__ ("Año"))
					
					APPEND TO ARRAY:C911(atACTdte_VarDisp;"B")
					APPEND TO ARRAY:C911(atACTdte_VarDisp;"B")
					APPEND TO ARRAY:C911(atACTdte_VarDisp;"B")
					APPEND TO ARRAY:C911(atACTdte_VarDisp;"B")
					APPEND TO ARRAY:C911(atACTdte_VarDisp;"B - F")
					APPEND TO ARRAY:C911(atACTdte_VarDisp;"B - F")
					
				: ($t_accion="LeeBlob")
					If (Not:C34(Is nil pointer:C315($y_pointer1)))
						$l_idRS:=$y_pointer1->
					End if 
					If ($l_idRS=0)
						$l_idRS:=-1
					End if 
					ACTdte_OpcionesManeja ("InicializaVars")
					ACTdte_OpcionesManeja ("ArmaBlob";->$xBlob)
					$xBlob:=PREF_fGetBlob (0;"ACT_DTE_OPCIONES_"+String:C10($l_idRS);$xBlob)
					ACTdte_OpcionesManeja ("CargaBlob";->$xBlob)
					
				: ($t_accion="GuardaBlob")
					If (Not:C34(Is nil pointer:C315($y_pointer1)))
						$l_idRS:=$y_pointer1->
					Else 
						$l_idRS:=-1
					End if 
					
					If (ACTdte_EsEmisorColegium ($l_idRS))
						t_indicadorServicioPBol:=ACTdte_OpcionesManeja ("ValidaIndicadorServicio";->t_indicadorServicioPBol)
						t_indicadorServicioPFac:=ACTdte_OpcionesManeja ("ValidaIndicadorServicioFactura";->t_indicadorServicioPFac)
						
						ACTdte_OpcionesManeja ("ArmaBlob";->$xBlob)
						PREF_SetBlob (0;"ACT_DTE_OPCIONES_"+String:C10($l_idRS);$xBlob)
					End if 
					
				: ($t_accion="ArmaBlob")
					$y_blob:=$y_pointer1
					vtACT_TextoDescripcion:=Replace string:C233(vtACT_TextoDescripcion;";";"")  //20150727 RCH El caracter ";" se usa como separador de dato. No pueden configurar un ";" en esta variable.
					vtACT_TextoDescripcionFact:=Replace string:C233(vtACT_TextoDescripcionFact;";";"")  //20150727 RCH El caracter ";" se usa como separador de dato. No pueden configurar un ";" en esta variable.
					$l_offSet:=BLOB_Variables2Blob ($y_blob;0;->r_verificarDirecciones;->t_indicadorServicioPBol;->t_indicadorServicioPFac;->r_generaDTEAlIngresarPago;->r_enviaDesc;->r_enviaObs;->vtACTdte_obs1;->vtACTdte_obs2;->vtACTdte_obs3;->vtACTdte_obs4;->vtACTdte_obs5;->vtACTdte_obs6;->vtACTdte_obs7;->vtACTdte_obs7;->vtACTdte_obs8;->vtACTdte_obs9;->vtACTdte_obs10;->vtACT_TextoDescripcion;->vtACT_TextoDescripcionFact;->r_abrirDTEAlIngresarPago;->r_enviarDTEAlIngresarPago;->r_obtieneCopiaCedible;->r_abrirDTEIngresoPagoNoReceptor)
					
				: ($t_accion="CargaBlob")
					$y_blob:=$y_pointer1
					BLOB_Blob2Vars ($y_blob;0;->r_verificarDirecciones;->t_indicadorServicioPBol;->t_indicadorServicioPFac;->r_generaDTEAlIngresarPago;->r_enviaDesc;->r_enviaObs;->vtACTdte_obs1;->vtACTdte_obs2;->vtACTdte_obs3;->vtACTdte_obs4;->vtACTdte_obs5;->vtACTdte_obs6;->vtACTdte_obs7;->vtACTdte_obs7;->vtACTdte_obs8;->vtACTdte_obs9;->vtACTdte_obs10;->vtACT_TextoDescripcion;->vtACT_TextoDescripcionFact;->r_abrirDTEAlIngresarPago;->r_enviarDTEAlIngresarPago;->r_obtieneCopiaCedible;->r_abrirDTEIngresoPagoNoReceptor)
					
				: ($t_accion="ValidaIndicadorServicio")
					$t_indicador:=$y_pointer1->
					
					C_LONGINT:C283($l_numero)
					$l_numero:=Num:C11($t_indicador)
					If (($l_numero=1) | ($l_numero=2) | ($l_numero=3) | ($l_numero=4))
						$t_retorno:=String:C10($l_numero)
					Else 
						$t_retorno:="3"
						CD_Dlog (0;__ ("Los valores posibles son: 1, 2, 3 y 4."))
					End if 
					
				: ($t_accion="ValidaIndicadorServicioFactura")
					$t_indicador:=$y_pointer1->
					If ($t_indicador#"")
						C_LONGINT:C283($l_numero)
						$l_numero:=Num:C11($t_indicador)
						If (($l_numero=1) | ($l_numero=2) | ($l_numero=3) | ($l_numero=4) | ($l_numero=5))
							$t_retorno:=String:C10($l_numero)
						Else 
							$t_retorno:=""
							CD_Dlog (0;__ ("Los valores posibles son: 1, 2, 3, 4 y 5."))
						End if 
					End if 
			End case 
		Else 
			ACTdte_OpcionesManeja ("InicializaVars")
		End if 
End case 

$0:=$t_retorno