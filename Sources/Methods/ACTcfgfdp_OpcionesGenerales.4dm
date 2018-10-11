//%attributes = {}
  //ACTcfgfdp_OpcionesGenerales

C_TEXT:C284($1;$accion;$vt_retorno;$0)
C_POINTER:C301($ptr1;$ptr2)
C_POINTER:C301(${2})
C_LONGINT:C283($vl_idFDP)

$accion:=$1
Case of 
	: (Count parameters:C259=2)
		$ptr1:=$2
	: (Count parameters:C259=3)
		$ptr1:=$2
		$ptr2:=$3
End case 

Case of 
	: ($accion="CargaArreglosFormaDePagoXDef")
		ARRAY TEXT:C222(atACT_Modo_de_Pago;0)
		ARRAY LONGINT:C221(alACT_Modo_de_Pago;0)
		ACTcfg_OpcionesFormasDePago ("FormasAsignables";->atACT_Modo_de_Pago;->alACT_Modo_de_Pago)
		
	: ($accion="seleccionaFormaDePagoXDef")
		ACTcfgfdp_OpcionesGenerales ("CargaArreglosFormaDePagoXDef")
		$text:=AT_array2text (->atACT_Modo_de_Pago;";")
		$choice:=Pop up menu:C542($text)
		If ($choice>0)
			READ WRITE:C146([ACT_Formas_de_Pago:287])
			QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]modo_pago_por_defecto:10=True:C214)
			$vl_id:=[ACT_Formas_de_Pago:287]id:1
			APPLY TO SELECTION:C70([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]modo_pago_por_defecto:10:=False:C215)
			If (Records in set:C195("LockedSet")=0)
				QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=alACT_Modo_de_Pago{$choice})
				If (Locked:C147([ACT_Formas_de_Pago:287]))
					QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$vl_id)
				End if 
				[ACT_Formas_de_Pago:287]modo_pago_por_defecto:10:=True:C214
				SAVE RECORD:C53([ACT_Formas_de_Pago:287])
			End if 
			$ptr1->:=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9
			$ptr2->:=[ACT_Formas_de_Pago:287]id:1
		End if 
		
	: ($accion="loadcfg_FdPXDef")
		C_LONGINT:C283(cbFPXDefecto)
		C_TEXT:C284(vt_FormadePagoXDef)
		C_LONGINT:C283(vl_FormadePagoXDef)
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		cbFPXDefecto:=0
		vl_FormadePagoXDef:=Num:C11(ACTcfgfdp_OpcionesGenerales ("GetIDFormaDePagoXDef"))
		$vl_FormadePagoXDef:=vl_FormadePagoXDef  //20160309 RCH 
		  //vt_FormadePagoXDef:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->vl_FormadePagoXDef)
		BLOB_Variables2Blob (->xBlob;0;->cbFPXDefecto;->vt_FormadePagoXDef;->vl_FormadePagoXDef)
		xBlob:=PREF_fGetBlob (0;"FormaDePagoXDefecto";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->cbFPXDefecto;->vt_FormadePagoXDef;->vl_FormadePagoXDef)
		
		  //20160309 RCH valido que la fdp exista en la base. Si no existe hay problemas con los llamados a metodos recursivos
		If (Find in field:C653([ACT_Formas_de_Pago:287]id:1;vl_FormadePagoXDef)=-1)
			vl_FormadePagoXDef:=$vl_FormadePagoXDef
		End if 
		
		vt_FormadePagoXDef:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->vl_FormadePagoXDef)
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($accion="savecfg_FdPXDef")
		C_BLOB:C604(xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->cbFPXDefecto;->vt_FormadePagoXDef;->vl_FormadePagoXDef)
		PREF_SetBlob (0;"FormaDePagoXDefecto";xBlob)
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($accion="fdpXDefecto")
		  //20121005 RCH
		If (ACT_AccountTrackInicializado )
			ACTcfgfdp_OpcionesGenerales ("loadcfg_FdPXDef")
			If ((cbFPXDefecto=0) | (vt_FormadePagoXDef="") | (vl_FormadePagoXDef=0))
				  //vl_FormadePagoXDef:=Num(ACTcfgfdp_OpcionesGenerales ("fdpFromLista"))
				vl_FormadePagoXDef:=Num:C11(ACTcfgfdp_OpcionesGenerales ("GetIDFormaDePagoXDef"))
				vt_FormadePagoXDef:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->vl_FormadePagoXDef)
				$vt_retorno:=vt_FormadePagoXDef
			Else 
				$vt_retorno:=vt_FormadePagoXDef
			End if 
		Else 
			$vt_retorno:=""
		End if 
		
	: ($accion="aplicaATodosFDPXDef")
		If (cbFPXDefecto=1)
			ACTcfgfdp_OpcionesGenerales ("savecfg_FdPXDef")
			ACTcfgfdp_OpcionesGenerales ("fdpXDefecto")
			ACTcfg_OpcionesGenABancarios ("LeeBlob")
			If ((vt_FormadePagoXDef#"") & (vl_FormadePagoXDef#0))
				$therm:=IT_UThermometer (1;0;__ ("Aplicando cambio..."))
				READ WRITE:C146([Personas:7])
				QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
				APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Modo_de_pago:39:=vt_FormadePagoXDef)
				APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_id_modo_de_pago:94:=vl_FormadePagoXDef)
				APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_modo_de_pago_new:95:=<>atACT_FormasDePago2D{3}{Find in array:C230(<>atACT_FormasDePago2D{1};String:C10(vl_FormadePagoXDef))})
				If (vt_FormadePagoXDef="Cuponera")
					APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_NoCuotasCup:80:=10)
				End if 
				REDUCE SELECTION:C351([Personas:7];0)
				KRL_UnloadReadOnly (->[Personas:7])
				
				If (csACTcfg_ModosPagoXCuenta=1)
					READ WRITE:C146([ACT_CuentasCorrientes:175])
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]id_modo_de_pago:32:=vl_FormadePagoXDef)
					REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
					KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
				End if 
				IT_UThermometer (-2;$therm)
				
			End if 
		End if 
	: ($accion="fdpFromLista")
		$vl_id:=Num:C11(ACTcfgfdp_OpcionesGenerales ("GetIDFormaDePagoXDef"))
		$vt_retorno:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->$vl_id)
		  //$vt_retorno:=<>atACT_ModosdePago{1}
		
	: ($accion="GetFormaDePagoFromID")
		$vl_existe:=Find in array:C230(<>atACT_FormasDePago2D{1};String:C10($ptr1->))
		If ($vl_existe>0)
			$vt_retorno:=<>atACT_FormasDePago2D{3}{$vl_existe}
		Else 
			$vt_retorno:=""
		End if 
		
	: ($accion="GetOLDFormaDePagoFromID")
		$vt_retorno:=<>atACT_FormasDePago2D{2}{Find in array:C230(<>atACT_FormasDePago2D{1};String:C10($ptr1->))}
		
	: ($accion="GetIDFormaDePagoXDef")
		READ ONLY:C145([ACT_Formas_de_Pago:287])
		QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]modo_pago_por_defecto:10=True:C214)
		If (Records in selection:C76([ACT_Formas_de_Pago:287])=0)
			READ WRITE:C146([ACT_Formas_de_Pago:287])
			Case of 
				: (<>gCountryCode="mx")
					$vl_idFDP:=-15
				Else 
					$vl_idFDP:=-2
			End case 
			QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$vl_idFDP)
			  //20111027 RCH Por un defecto no se estaba creando la moneda por defecto de MX. Esto previene dichos casos.
			If (Records in selection:C76([ACT_Formas_de_Pago:287])=0)
				ACTcfgfdp_OpcionesGenerales ("VerificaFormasDePagoXDef")
				READ WRITE:C146([ACT_Formas_de_Pago:287])
				QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$vl_idFDP)
			End if 
			[ACT_Formas_de_Pago:287]modo_pago_por_defecto:10:=True:C214
			$vt_retorno:=String:C10([ACT_Formas_de_Pago:287]id:1)
			ACTpgs_SaveFormasDePago 
		Else 
			$vt_retorno:=String:C10([ACT_Formas_de_Pago:287]id:1)
		End if 
		
	: ($accion="VerificaFormasDePagoXDef")
		  //ARRAY TEXT($atACT_FormasDePagoXDef;0)
		  //ARRAY LONGINT($alACT_FormasDePagoXDef;0)
		  //ACTcfg_OpcionesFormasDePago ("ObtieneFormasDePagoXDefecto";->$atACT_FormasDePagoXDef;->$alACT_FormasDePagoXDef)
		For ($i;1;Size of array:C274(<>atACT_FormasDePago2D{1}))
			$vl_idFDP:=Num:C11(<>atACT_FormasDePago2D{1}{$i})
			If ($vl_idFDP<0)
				READ ONLY:C145([ACT_Formas_de_Pago:287])
				QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$vl_idFDP)
				If (Records in selection:C76([ACT_Formas_de_Pago:287])=0)
					$vt_fdpGlosa:=<>atACT_FormasDePago2D{2}{$i}
					$vt_code:=<>atACT_FormasDePago2D{4}{$i}
					ACTcfg_OpcionesFormasDePago ("NuevaFormaDePago";->$vt_fdpGlosa;->$vt_code)
				End if 
			End if 
		End for 
		$vt_retorno:=ACTcfgfdp_OpcionesGenerales ("GetIDFormaDePagoXDef")
		
	: ($accion="ActualizaIDEnElColegio")
		  //20121005 RCH Parece que la forma de pago -2 no estaba funcionando bien. Me aseguro de que se ejecute el codigo
		ACTfdp_CargaFormasDePago 
		C_TEXT:C284($vt_formaDePago;$vt_formaDePagoNew)
		C_LONGINT:C283($vl_idFormaDePago)
		If (<>gCountryCode="mx")
			$vt_formaDePago:="Por caja"
		Else 
			$vt_formaDePago:="En el Colegio"
		End if 
		$vl_idFormaDePago:=-2
		$vt_formaDePagoNew:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->$vl_idFormaDePago)
		MESSAGES OFF:C175
		$vl_proc:=IT_UThermometer (1;0;"Actualizando forma de pago en el colegio.")
		READ WRITE:C146([Personas:7])
		QUERY:C277([Personas:7];[Personas:7]ACT_Modo_de_pago:39=$vt_formaDePago)
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_id_modo_de_pago:94:=$vl_idFormaDePago)
		APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_modo_de_pago_new:95:=$vt_formaDePagoNew)
		KRL_UnloadReadOnly (->[Personas:7])
		IT_UThermometer (-2;$vl_proc)
		
	: ($accion="FormasDePagoNOReemplazantes")  //20130822 RCH
		AT_Initialize ($ptr1)
		APPEND TO ARRAY:C911($ptr1->;-4)  //cheque
		APPEND TO ARRAY:C911($ptr1->;-6)  //tarjeta de credito
		APPEND TO ARRAY:C911($ptr1->;-7)  // redcompra
		APPEND TO ARRAY:C911($ptr1->;-8)  //letra
		APPEND TO ARRAY:C911($ptr1->;-12)  //Nota de Crédito. Es una fdp especial que representa un egreso
		
End case 
$0:=$vt_retorno