//%attributes = {}
  //ACTcfg_OpcionesTextoMail

C_TEXT:C284($1;$vt_accion;$0;$vt_retorno)
C_TEXT:C284($vt_sexo;$vt_nombre;$vt_prefijoNombre;$vt_idAviso;$vt_mesAviso;$vt_yearAviso)
C_TEXT:C284($vt_cuerpoSinFormato;$vt_body;$vt_nombreArchivo)
C_LONGINT:C283($idApdo)
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 
If (Count parameters:C259>=6)
	$ptr5:=$6
End if 
If (Count parameters:C259>=7)
	$ptr6:=$7
End if 
If (Count parameters:C259>=8)
	$ptr7:=$8
End if 

Case of 
	: ($vt_accion="DeclaraVars")
		C_TEXT:C284(vt_CuerpoMail;vt_CuerpoMail2)
		C_TEXT:C284(vtACTmail_AsuntoMail;vtACTmail_ResponderA;vtACTmail_NombreDe;vtACTmail_CCO)
		
	: ($vt_accion="TextoXDefecto")
		$vt_retorno:="&NA:&CR&CRAdjuntamos el aviso de cobranza N° &ID correspondiente a &M, &A.&CR&CR"+"Atentamente,&CR&NC"
		
	: ($vt_accion="InitVars")
		ACTcfg_OpcionesTextoMail ("DeclaraVars")
		vt_CuerpoMail:=ACTcfg_OpcionesTextoMail ("TextoXDefecto")
		vt_CuerpoMail2:=ACTcfg_OpcionesTextoMail ("ProcesaEjemplo")
		
	: ($vt_accion="LeeBlob")
		ACTcfg_LeeBlob ("ACTcfg_CuerpoMail")
		If (vt_CuerpoMail="")
			ACTcfg_OpcionesTextoMail ("InitVars")
			ACTcfg_OpcionesTextoMail ("GuardaBlob")
			ACTcfg_OpcionesTextoMail ("LeeBlob")
		End if 
		
	: ($vt_accion="GuardaBlob")
		ACTcfg_GuardaBlob ("ACTcfg_CuerpoMail")
		
	: ($vt_accion="CreaBlob")
		BLOB_Variables2Blob (->xBlob;0;->vt_CuerpoMail;->vt_CuerpoMail2;->vtACTmail_AsuntoMail;->vtACTmail_ResponderA;->vtACTmail_NombreDe;->vtACTmail_CCO)
		
	: ($vt_accion="CargaBlob")
		BLOB_Blob2Vars (->xBlob;0;->vt_CuerpoMail;->vt_CuerpoMail2;->vtACTmail_AsuntoMail;->vtACTmail_ResponderA;->vtACTmail_NombreDe;->vtACTmail_CCO)
		
	: ($vt_accion="ConvierteTexto")
		$vt_cuerpoSinFormato:=$ptr1->
		$vt_sexo:=$ptr2->
		$vt_nombre:=$ptr3->
		$vt_prefijoNombre:=$ptr4->
		$vt_idAviso:=$ptr5->
		$vt_mesAviso:=$ptr6->
		$vt_yearAviso:=$ptr7->
		$vt_body:=$vt_cuerpoSinFormato
		If ($vt_prefijoNombre="")
			Case of 
				: ($vt_sexo="F")
					$vt_prefijoNombre:="Sra."
				: ($vt_sexo="M")
					$vt_prefijoNombre:="Sr."
			End case 
		End if 
		$vt_prefijoNombre:=$vt_prefijoNombre+" "
		$vt_body:=Replace string:C233($vt_body;"&NA";$vt_prefijoNombre+$vt_nombre)
		$vt_body:=Replace string:C233($vt_body;"&CR";"\r")
		$vt_body:=Replace string:C233($vt_body;"&ID";$vt_idAviso)
		$vt_body:=Replace string:C233($vt_body;"&M";$vt_mesAviso)
		$vt_body:=Replace string:C233($vt_body;"&A";$vt_yearAviso)
		$vt_body:=Replace string:C233($vt_body;"&NC";<>gCustom)
		  //$vt_body:=$vt_body+"\r\r"+"\r"+"Powered by Colegium.com"
		$vt_retorno:=$vt_body
		
	: ($vt_accion="ProcesaEjemplo")
		ACTcfg_OpcionesTextoMail ("ObtieneDatosEjemplo";->$vt_sexo;->$vt_nombre;->$vt_prefijoNombre;->$vt_idAviso;->$vt_mesAviso;->$vt_yearAviso)
		$vt_retorno:=ACTcfg_OpcionesTextoMail ("ConvierteTexto";->vt_CuerpoMail;->$vt_sexo;->$vt_nombre;->$vt_prefijoNombre;->$vt_idAviso;->$vt_mesAviso;->$vt_yearAviso)
		
	: ($vt_accion="ProcesaCuerpoMail")
		ACTcfg_OpcionesTextoMail ("LeeBlob")
		$vt_nombreArchivo:=$ptr1->
		$idApdo:=Num:C11(ST_GetWord ($vt_nombreArchivo;2;"_"))
		READ ONLY:C145([Personas:7])
		KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$idApdo)
		$vt_sexo:=[Personas:7]Sexo:8
		$vt_nombre:=[Personas:7]Nombre_Comun:60
		$vt_prefijoNombre:=[Personas:7]Prefijo:90
		$vt_idAviso:=ST_GetWord ($vt_nombreArchivo;1;"_")
		$vt_mesAviso:=ST_GetWord ($vt_nombreArchivo;3;"_")
		$vt_yearAviso:=Substring:C12(ST_GetWord ($vt_nombreArchivo;4;"_");1;Position:C15(".";ST_GetWord ($vt_nombreArchivo;4;"_"))-1)
		$vt_retorno:=ACTcfg_OpcionesTextoMail ("ConvierteTexto";->vt_CuerpoMail;->$vt_sexo;->$vt_nombre;->$vt_prefijoNombre;->$vt_idAviso;->$vt_mesAviso;->$vt_yearAviso)
		
	: ($vt_accion="ObtieneDatosEjemplo")
		$ptr1->:="M"
		$ptr2->:="Vicente Huidobro"
		$ptr3->:="Sr."
		$ptr4->:="4320"
		$ptr5->:="03"
		$ptr6->:="2010"
		
	: ($vt_accion="ValidaRBD")
		  //20090414 se agrega el colegio Santiago College a pedido de Ariel RBD 89958.
		  //20091001 se agrega el colegio San Mateo a pedido de Ariel RBD 100001.
		  //$vt_retorno:=String(Num(((<>gRolBD#"90468") & (<>gRolBD#"92169") & (<>gRolBD#"890981239-0") & (<>gRolBD#"890916768-9") & (<>gRolBD#"89958"))))
		  //$vt_retorno:=String(Num(((<>gRolBD#"90468") & (<>gRolBD#"92169") & (<>gRolBD#"890981239-0") & (<>gRolBD#"890916768-9") & (<>gRolBD#"89958") & (<>gRolBD#"100001") & Not(DL_IsModuleLicensed (1;CommTrack Light)))))
		$vt_retorno:="0"
End case 
$0:=$vt_retorno