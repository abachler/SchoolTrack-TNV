//%attributes = {}
  // ACTcfdi_OpcionesGenerales()
  // 
  //
  // modificado por: Alberto Bachler Klein: 26-12-16, 17:52:12
  // -----------------------------------------------------------



C_TEXT:C284($vt_accion;$1;$0;$vt_retorno;$vt_propiedad)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2)
C_LONGINT:C283($vl_idRS;$vl_resultado;$vl_idBoleta)

C_TEXT:C284($vt_rutaOrigen;$vt_rutaDestino)
C_BLOB:C604($xBlob)
C_TIME:C306($ref)

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 

If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 

Case of 
	: ($vt_accion="CargaConf")
		ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
		$vl_idRS:=alACTcfg_Razones{atACTcfg_Razones}
		ACTcfdi_OpcionesGenerales ("OnLoadConf";->$vl_idRS)
		
	: ($vt_accion="OnLoadConf")
		C_LONGINT:C283($vl_idRS)
		C_LONGINT:C283(vlACT_RSSel)
		
		$vl_idRS:=$vy_pointer1->
		
		If ($vl_idRS=0)
			$vl_idRS:=-1
		End if 
		vlACT_RSSel:=$vl_idRS
		ACTcfdi_OpcionesGenerales ("LeeConf";->$vl_idRS)
		
		
	: ($vt_accion="LeeConfEmisor")
		C_LONGINT:C283(cs_emitirCFDI;$vl_idRS;cs_generarArchivoIP;cs_asignarFolio;cs_imprimirDocumento)
		C_BLOB:C604($vy_blob)
		ARRAY TEXT:C222(at_proveedores;0)
		
		  // blob con es emisor y proveedor
		$vl_idRS:=$vy_pointer1->
		If ($vl_idRS=0)
			$vl_idRS:=-1
		End if 
		
		cs_emitirCFDI:=0
		at_proveedores:=1
		cs_generarArchivoIP:=0
		cs_asignarFolio:=0
		cs_imprimirDocumento:=0
		
		ARRAY TEXT:C222($at_proveedores;0)
		
		ACTdte_OpcionesGenerales ("CargaProveedores";->$at_proveedores)
		ACTcfdi_OpcionesGenerales ("ArmaBlob";->$vy_blob)
		$vy_blob:=PREF_fGetBlob (0;"ACT_CFG_BlobEmisor_"+String:C10($vl_idRS);$vy_blob)
		BLOB_Blob2Vars (->$vy_blob;0;->cs_emitirCFDI;->at_proveedores;->cs_generarArchivoIP;->cs_asignarFolio;->cs_imprimirDocumento)
		
		  //valida la inclusion de nuevos proveedores
		For ($i;1;Size of array:C274($at_proveedores))
			If (Find in array:C230(at_proveedores;$at_proveedores{$i})=-1)
				APPEND TO ARRAY:C911(at_proveedores;$at_proveedores{$i})
			End if 
		End for 
		
		  //elimina proveedores...
		For ($i;Size of array:C274(at_proveedores);1;-1)
			If (Find in array:C230($at_proveedores;at_proveedores{$i})=-1)
				AT_Delete ($i;1;->at_proveedores)
			End if 
		End for 
		
	: ($vt_accion="LeePropiedadesXMLXDefecto")
		AT_Initialize ($vy_pointer1;$vy_pointer2;$vy_pointer3)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"formaDePago")
		APPEND TO ARRAY:C911($vy_pointer2->;"Pago en una sola exhibición")
		APPEND TO ARRAY:C911($vy_pointer3->;True:C214)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"tipoDeComprobante")
		APPEND TO ARRAY:C911($vy_pointer2->;"ingreso")
		APPEND TO ARRAY:C911($vy_pointer3->;True:C214)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"plaza")
		APPEND TO ARRAY:C911($vy_pointer2->;"1")
		APPEND TO ARRAY:C911($vy_pointer3->;True:C214)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"Campo Propio para R.F.C.")
		APPEND TO ARRAY:C911($vy_pointer2->;"")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"serie")  //se utiliza en el Williams para version 3.0
		APPEND TO ARRAY:C911($vy_pointer2->;"")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"estado")  // obligatorio en v 3.0
		APPEND TO ARRAY:C911($vy_pointer2->;"México D.F.")
		APPEND TO ARRAY:C911($vy_pointer3->;True:C214)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"LugarExpedicion")  // obligatorio en v 3.2
		APPEND TO ARRAY:C911($vy_pointer2->;"Colegio")
		APPEND TO ARRAY:C911($vy_pointer3->;True:C214)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"RegimenFiscal")  // obligatorio en v 3.2
		APPEND TO ARRAY:C911($vy_pointer2->;"Régimen de las Personas Morales No Contribuyentes Titulo III LISR")  // SEPARAR POR PUNTO Y COMA SI HAY MAS DE UNO ";"
		APPEND TO ARRAY:C911($vy_pointer3->;True:C214)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"ConceptosUnidad")  // obligatorio en v 3.2
		APPEND TO ARRAY:C911($vy_pointer2->;"Un")
		APPEND TO ARRAY:C911($vy_pointer3->;True:C214)
		
		  //20120920 RCH 
		APPEND TO ARRAY:C911($vy_pointer1->;"Identificador Nacional para R.F.C.")  // 1 para RUT: 2 para IN2; 3 para IN3; 4 para pasaporte; 5 para codigo interno.
		APPEND TO ARRAY:C911($vy_pointer2->;"1")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		  //20120920 RCH Campo desconocido del archivo... parece ser un numero de convenio...
		APPEND TO ARRAY:C911($vy_pointer1->;"aut_rvoe")
		APPEND TO ARRAY:C911($vy_pointer2->;"")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		  //20121114 RCH Para manejar que yaocalli quiere usar la direccion de envio de correspondencia.
		APPEND TO ARRAY:C911($vy_pointer1->;"Utilizar dirección E.C.")
		APPEND TO ARRAY:C911($vy_pointer2->;"0")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		  //20121128 RCH para cumplir con datos obligatorios para txt levicom
		APPEND TO ARRAY:C911($vy_pointer1->;"Moneda")
		APPEND TO ARRAY:C911($vy_pointer2->;"MXN")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"Tipo de cambio")
		APPEND TO ARRAY:C911($vy_pointer2->;"1.00")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"Tipo impresión")
		APPEND TO ARRAY:C911($vy_pointer2->;"P")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		APPEND TO ARRAY:C911($vy_pointer1->;"Tipo envío")
		APPEND TO ARRAY:C911($vy_pointer2->;"I01")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		  //20121210 RCH 
		APPEND TO ARRAY:C911($vy_pointer1->;"Identificador Nacional para R.F.C. para Cuentas")  // 1 para RUT: 2 para IN2; 3 para IN3; 4 para pasaporte; 5 para codigo interno.
		APPEND TO ARRAY:C911($vy_pointer2->;"1")
		APPEND TO ARRAY:C911($vy_pointer3->;False:C215)
		
		  //ASM 20141016 
		APPEND TO ARRAY:C911($vy_pointer1->;"serie NC")  //Serie para notas de credito
		APPEND TO ARRAY:C911($vy_pointer2->;"NC")
		APPEND TO ARRAY:C911($vy_pointer3->;True:C214)
		
	: ($vt_accion="LeeConf")
		C_BLOB:C604($vy_blob)
		
		ARRAY TEXT:C222(atACTcfdi_PropiedadXML;0)
		ARRAY TEXT:C222(atACTcfdi_ValorXML;0)
		ARRAY TEXT:C222(atACTcfdi_PropiedadGen;0)
		ARRAY TEXT:C222(atACTcfdi_ValorGen;0)
		
		$vl_idRS:=$vy_pointer1->
		If ($vl_idRS=0)
			$vl_idRS:=-1
		End if 
		
		  // propiedades generacion XML
		ARRAY TEXT:C222($atACTcfdi_PropiedadXML;0)
		ARRAY TEXT:C222($atACTcfdi_ValorXML;0)
		ARRAY BOOLEAN:C223($abACTcfdi_requeridoXML;0)
		
		ACTcfdi_OpcionesGenerales ("LeePropiedadesXMLXDefecto";->$atACTcfdi_PropiedadXML;->$atACTcfdi_ValorXML;->$abACTcfdi_requeridoXML)
		
		If (Undefined:C82(alACT_IDsCats))
			ARRAY LONGINT:C221(alACT_IDsCats;0)
		End if 
		
		For ($i;1;Size of array:C274(alACT_IDsCats))
			$vt_propiedad:="Tipo documento "+String:C10(alACT_IDsCats{$i})
			$vl_existe:=Find in array:C230($atACTcfdi_PropiedadXML;$vt_propiedad)
			If ($vl_existe=-1)
				APPEND TO ARRAY:C911($atACTcfdi_PropiedadXML;$vt_propiedad)
				APPEND TO ARRAY:C911($atACTcfdi_ValorXML;"0")
			End if 
		End for 
		
		Case of 
			: (<>gCountryCode="cl")
				$vt_prefijo:="DTE"
			: (<>gCountryCode="mx")
				$vt_prefijo:="CFDI"
			Else 
				$vt_prefijo:=""
		End case 
		
		$t_rutaResourcesACT:=Get 4D folder:C485(Current resources folder:K5:16)+"ResourcesACT"
		$t_carpetaArchivosServer:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"ACT"
		$t_carpetaArchivosCliente:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)
		
		  // propiedades generacion archivo
		ARRAY TEXT:C222($atACTcfdi_PropiedadGen;0)
		ARRAY TEXT:C222($atACTcfdi_ValorGen;0)
		APPEND TO ARRAY:C911($atACTcfdi_PropiedadGen;"rutaXSLT")
		APPEND TO ARRAY:C911($atACTcfdi_ValorGen;"$t_rutaResourcesACT:CFDI:cadenaoriginal_3_2_Col.xslt")
		APPEND TO ARRAY:C911($atACTcfdi_PropiedadGen;"rutaCodigoPHP")
		APPEND TO ARRAY:C911($atACTcfdi_ValorGen;"$t_rutaResourcesACT:CFDI:FirmaCFDi.php")
		APPEND TO ARRAY:C911($atACTcfdi_PropiedadGen;"rutaAlmacenamientoArchivosServer")
		APPEND TO ARRAY:C911($atACTcfdi_ValorGen;"<>syT_ArchivosFolder:ACT:"+$vt_prefijo+":RUT:YEAR:MONTH:DAY:")
		APPEND TO ARRAY:C911($atACTcfdi_PropiedadGen;"rutaAlmacenamientoArchivosCliente")
		APPEND TO ARRAY:C911($atACTcfdi_ValorGen;"<>syT_ApplicationPath:AccountTrack:"+$vt_prefijo+":RUT:YEAR:MONTH:DAY:")
		APPEND TO ARRAY:C911($atACTcfdi_PropiedadGen;"rutaAlmacenamientoArchivosIngresoPago")
		APPEND TO ARRAY:C911($atACTcfdi_ValorGen;"")
		APPEND TO ARRAY:C911($atACTcfdi_PropiedadGen;"rutaAlmacenamientoArchivosIngresoPagoServer")
		APPEND TO ARRAY:C911($atACTcfdi_ValorGen;"")
		
		  // blob con es emisor y proveedor
		ACTcfdi_OpcionesGenerales ("LeeConfEmisor";->$vl_idRS)
		
		  // rutas certificados
		ACTcfdi_OpcionesGenerales ("LeeRutasCertificados";->$vl_idRS)
		
		  //lee blob gen xml
		If (False:C215)
			AT_Initialize (->atACTcfdi_PropiedadXML;->atACTcfdi_ValorXML)
		End if 
		
		BLOB_Variables2Blob (->$vy_blob;0;->atACTcfdi_PropiedadXML;->atACTcfdi_ValorXML)
		$vy_blob:=PREF_fGetBlob (0;"ACT_CFG_BlobXML_"+String:C10($vl_idRS);$vy_blob)
		BLOB_Blob2Vars (->$vy_blob;0;->atACTcfdi_PropiedadXML;->atACTcfdi_ValorXML)
		
		  //lee blob gen archivos}
		If (False:C215)
			AT_Initialize (->atACTcfdi_PropiedadGen;->atACTcfdi_ValorGen)
		End if 
		BLOB_Variables2Blob (->$vy_blob;0;->atACTcfdi_PropiedadGen;->atACTcfdi_ValorGen)
		$vy_blob:=PREF_fGetBlob (0;"ACT_CFG_BlobFiles_"+String:C10($vl_idRS);$vy_blob)
		BLOB_Blob2Vars (->$vy_blob;0;->atACTcfdi_PropiedadGen;->atACTcfdi_ValorGen)
		
		  //valida propiedades
		For ($i;1;Size of array:C274($atACTcfdi_PropiedadXML))
			If (Find in array:C230(atACTcfdi_PropiedadXML;$atACTcfdi_PropiedadXML{$i})=-1)
				APPEND TO ARRAY:C911(atACTcfdi_PropiedadXML;$atACTcfdi_PropiedadXML{$i})
				APPEND TO ARRAY:C911(atACTcfdi_ValorXML;$atACTcfdi_ValorXML{$i})
			End if 
		End for 
		
		For ($i;1;Size of array:C274($atACTcfdi_PropiedadGen))
			If (Find in array:C230(atACTcfdi_PropiedadGen;$atACTcfdi_PropiedadGen{$i})=-1)
				APPEND TO ARRAY:C911(atACTcfdi_PropiedadGen;$atACTcfdi_PropiedadGen{$i})
				APPEND TO ARRAY:C911(atACTcfdi_ValorGen;$atACTcfdi_ValorGen{$i})
			End if 
		End for 
		
		  //carga variables de chile
		ACTdte_OpcionesGenerales ("CargaConf")
		
	: ($vt_accion="ArmaBlob")
		BLOB_Variables2Blob ($vy_pointer1;0;->cs_emitirCFDI;->at_proveedores;->cs_generarArchivoIP;->cs_asignarFolio;->cs_imprimirDocumento)
		
	: ($vt_accion="SaveConf")
		C_LONGINT:C283($vl_idRS)
		$vl_idRS:=$vy_pointer1->
		If ($vl_idRS=0)
			$vl_idRS:=-1
		End if 
		
		  // blob con es emisor y proveedor
		  //BLOB_Variables2Blob (->$vy_blob;0;->cs_emitirCFDI;->at_proveedores;->cs_generarArchivoIP;->cs_asignarFolio)
		ACTcfdi_OpcionesGenerales ("ArmaBlob";->$vy_blob)
		PREF_SetBlob (0;"ACT_CFG_BlobEmisor_"+String:C10($vl_idRS);$vy_blob)
		
		  // rutas certificados
		ACTcfdi_OpcionesGenerales ("GuardaPaths";->$vl_idRS)
		
		  //lee blob gen xml
		BLOB_Variables2Blob (->$vy_blob;0;->atACTcfdi_PropiedadXML;->atACTcfdi_ValorXML)
		PREF_SetBlob (0;"ACT_CFG_BlobXML_"+String:C10($vl_idRS);$vy_blob)
		
		  //lee blob gen archivos
		BLOB_Variables2Blob (->$vy_blob;0;->atACTcfdi_PropiedadGen;->atACTcfdi_ValorGen)
		PREF_SetBlob (0;"ACT_CFG_BlobFiles_"+String:C10($vl_idRS);$vy_blob)
		
		  //20130926 RCH guarda configuracion de emisor electronico
		KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->$vl_idRS;True:C214)
		If (ok=1)
			[ACT_RazonesSociales:279]emisor_electronico:30:=(Num:C11(cs_emitirCFDI)=1)
			SAVE RECORD:C53([ACT_RazonesSociales:279])
		End if 
		KRL_UnloadReadOnly (->[ACT_RazonesSociales:279])
		
	: ($vt_accion="GuardaPaths")
		$vl_idRS:=$vy_pointer1->
		If ($vl_idRS=0)
			$vl_idRS:=-1
		End if 
		
		PREF_Set (0;"ACT_PathCertificado"+String:C10($vl_idRS);vtACT_rutaCertificado)
		PREF_Set (0;"ACT_NumCertificado"+String:C10($vl_idRS);vtACT_numeroCertificado)
		PREF_Set (0;"ACT_PathLlavePubCertificado"+String:C10($vl_idRS);vtACT_llavePubCertificado)
		PREF_Set (0;"ACT_PathLlavePrivCertificado"+String:C10($vl_idRS);vtACT_llavePrivCertificado)
		
	: ($vt_accion="LeeRutasCertificados")
		$vl_idRS:=$vy_pointer1->
		If ($vl_idRS=0)
			$vl_idRS:=-1
		End if 
		
		C_TEXT:C284(vtACT_rutaCertificado;vtACT_numeroCertificado;vtACT_llavePubCertificado;vtACT_llavePrivCertificado)
		
		vtACT_rutaCertificado:=""
		vtACT_numeroCertificado:=""
		vtACT_llavePubCertificado:=""
		vtACT_llavePrivCertificado:=""
		
		vtACT_rutaCertificado:=PREF_fGet (0;"ACT_PathCertificado"+String:C10($vl_idRS);vtACT_rutaCertificado)
		vtACT_numeroCertificado:=PREF_fGet (0;"ACT_NumCertificado"+String:C10($vl_idRS);vtACT_numeroCertificado)
		vtACT_llavePubCertificado:=PREF_fGet (0;"ACT_PathLlavePubCertificado"+String:C10($vl_idRS);vtACT_llavePubCertificado)
		vtACT_llavePrivCertificado:=PREF_fGet (0;"ACT_PathLlavePrivCertificado"+String:C10($vl_idRS);vtACT_llavePrivCertificado)
		
	: ($vt_accion="LeeCheckBox")
		cs_generaOnServer:=Num:C11(PREF_fGet (0;"ACT_CFGbol_CheckBoxGeneraOnServer";String:C10(cs_generaOnServer)))
		If (cs_generaOnServer=1)
			
			$vt_propiedad:="FILE|rutaAlmacenamientoArchivosIngresoPagoServer"
			vtACT_rutaOnServer:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
			If (vtACT_rutaOnServer="")
				$vt_propiedad:="FILE|rutaAlmacenamientoArchivosServer"
				vtACT_rutaOnServer:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
			End if 
			
			  //20120922 RCH
			SYS_CreateFolderOnServer (vtACT_rutaOnServer)
			
			If (SYS_TestPathName (vtACT_rutaOnServer;Server)=Is a folder:K24:2)
			Else 
				vtACT_rutaOnServer:=""
			End if 
		Else 
			vtACT_rutaOnServer:=""
		End if 
		
	: ($vt_accion="PathFileValidate")
		Case of 
			: (vtACT_rutaCertificado="")
				$vt_retorno:="-1"
			: (vtACT_numeroCertificado="")
				$vt_retorno:="-2"
			: (vtACT_llavePubCertificado="")
				$vt_retorno:="-3"
			: (vtACT_llavePrivCertificado="")
				$vt_retorno:="-4"
			Else 
				$vt_retorno:="1"
		End case 
		
		If ($vt_retorno="1")
			Case of 
				: (Test path name:C476(vtACT_rutaCertificado)#Is a document:K24:1)
					$vt_retorno:="-5"
				: (Test path name:C476(vtACT_llavePubCertificado)#Is a document:K24:1)
					$vt_retorno:="-6"
				: (Test path name:C476(vtACT_llavePrivCertificado)#Is a document:K24:1)
					$vt_retorno:="-7"
			End case 
		End if 
		
		If ((at_proveedores{at_proveedores}#"Buzón Fiscal") & (at_proveedores{at_proveedores}#"Levicom"))
			$vt_retorno:="1"
		End if 
		
	: ($vt_accion="GeneraXML")
		$vl_idBoleta:=$vy_pointer1->
		ACTbol_GeneraArchivoDigital ($vl_idBoleta)
		
	: ($vt_accion="GetPropiedad")
		$vt_propiedad:=$vy_pointer1->
		$vt_tipo:=ST_GetWord ($vt_propiedad;1;"|")
		$vt_propiedad:=ST_GetWord ($vt_propiedad;2;"|")
		$vt_retorno:=""
		Case of 
			: ($vt_tipo="XML")
				$vl_pos:=Find in array:C230(atACTcfdi_PropiedadXML;$vt_propiedad)
				If ($vl_pos>0)
					$vt_retorno:=atACTcfdi_ValorXML{$vl_pos}
				End if 
				
			: ($vt_tipo="FILE")
				$vl_pos:=Find in array:C230(atACTcfdi_PropiedadGen;$vt_propiedad)
				If ($vl_pos>0)
					$vt_retorno:=atACTcfdi_ValorGen{$vl_pos}
					
					$vt_posibleRuta:=Substring:C12($vt_retorno;1;3)  // necesito evitar que se reemplace el ; del C:/ en win
					$vt_retorno:=Substring:C12($vt_retorno;4;Length:C16($vt_retorno))
					$vt_retorno:=Replace string:C233($vt_retorno;":";Folder separator:K24:12)
					$vt_retorno:=$vt_posibleRuta+$vt_retorno
					
					  //$vt_retorno:=Replace string($vt_retorno;"<>syT_ApplicationPath";<>syT_ApplicationPath)
					$t_rutaCarpetaLocal:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)
					  //$t_rutaCarpetaServidor:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"ACT"+SYS_FolderDelimiterOnServer 
					$t_rutaCarpetaServidor:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"ACT"  //20180502 ASM Ticket 204814
					$t_rutaBD:=SYS_CarpetaAplicacion (CLG_Datos)
					$vt_retorno:=Replace string:C233($vt_retorno;"<>syT_ApplicationPath";$t_rutaCarpetaLocal)
					$vt_retorno:=Replace string:C233($vt_retorno;"<>syT_ArchivosFolder";$t_rutaCarpetaServidor)
					$vt_retorno:=Replace string:C233($vt_retorno;"<>syT_ExtrasFolder";$t_rutaCarpetaLocal)
					$vt_retorno:=Replace string:C233($vt_retorno;"<>syT_DataFilePath";$t_rutaBD)
					
					  //$vt_retorno:=Replace string($vt_retorno;"<>syT_ApplicationPath";<>syT_ApplicationPath)
					  //$vt_dataFileFolder:=SYS_GetServerProperty (211)  //XS_DataFileFolder
					  //$vt_retorno:=Replace string($vt_retorno;"<>syT_ArchivosFolder";$vt_dataFileFolder+"Archivos"+Folder separator)
					  //$vt_retorno:=Replace string($vt_retorno;"<>syT_ExtrasFolder";<>syT_ExtrasFolder)
					  //$vt_retorno:=Replace string($vt_retorno;"<>syT_DataFilePath";<>syT_DataFilePath)  //20140807 RCH
					
					$vt_retorno:=Replace string:C233($vt_retorno;"RUT";<>vsACT_RUT)
					$vt_retorno:=Replace string:C233($vt_retorno;"YEAR";String:C10(Year of:C25(Current date:C33(*));"0000"))
					$vt_retorno:=Replace string:C233($vt_retorno;"MONTH";String:C10(Month of:C24(Current date:C33(*));"00"))
					$vt_retorno:=Replace string:C233($vt_retorno;"DAY";String:C10(Day of:C23(Current date:C33(*));"00"))
					
					$vt_retorno:=Replace string:C233($vt_retorno;Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)
				End if 
		End case 
		
	: ($vt_accion="GeneraArchivoIngresoPago")
		If (cs_generarArchivoIP=1)
			If (Size of array:C274($vy_pointer1->)>0)
				$vl_proc:=IT_UThermometer (1;0;__ ("Generando archivos CFDI"))
				
				  //20120922 RCH Se cambia for...
				vtACT_rutaCliente:=""
				vtACT_rutaServer:=""
				vtACT_ErrorString:=""
				$vt_propiedad:="FILE|rutaAlmacenamientoArchivosIngresoPago"
				vtACT_rutaCliente:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
				
				$vt_propiedad:="FILE|rutaAlmacenamientoArchivosIngresoPagoServer"
				vtACT_rutaServer:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
				
				If (vtACT_rutaCliente="")
					$vt_propiedad:="FILE|rutaAlmacenamientoArchivosCliente"
					vtACT_rutaCliente:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
				End if 
				
				If ((vtACT_rutaCliente#"") | (vtACT_rutaServer#""))
					SYS_CreatePath (vtACT_rutaCliente)
					For ($j;1;Size of array:C274($vy_pointer1->))
						$vl_idBoleta:=$vy_pointer1->{$j}
						ACTcfdi_OpcionesGenerales ("GeneraXML";->$vl_idBoleta)
						If (vtACT_ErrorString#"")
							$j:=Size of array:C274($vy_pointer1->)
						End if 
					End for 
				Else 
					CD_Dlog (0;__ ("Error al leer ruta para almacenar archivos."))
				End if 
				IT_UThermometer (-2;$vl_proc)
				
			End if 
		End if 
		  //***** genera archivo en el cliente...
		
	: ($vt_accion="GeneraArchivoEnCliente")
		
		If (Size of array:C274($vy_pointer1->)>0)
			$vl_proc:=IT_UThermometer (1;0;__ ("Generando archivos CFDI"))
			vtACT_ErrorString:=""
			  //20120921 RCH En ACTbol_GeneraArchivoDigital se leen nuevamente las preferencias...
			$vt_propiedad:="FILE|rutaAlmacenamientoArchivosCliente"
			vtACT_rutaCliente:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
			
			vtACT_rutaServer:=vtACT_rutaOnServer
			
			  //vtACT_rutaCliente:=$vt_rutaCliente+Substring(DTS_MakeFromDateTime ;9;14)+SYS_FolderDelimiter 
			SYS_CreatePath (vtACT_rutaCliente)
			
			C_LONGINT:C283($i;$l_idBoleta)
			If (Test path name:C476(vtACT_rutaCliente)=Is a folder:K24:2)
				For ($i;1;Size of array:C274($vy_pointer1->))
					$l_idBoleta:=$vy_pointer1->{$i}
					ACTcfdi_OpcionesGenerales ("GeneraXML";->$l_idBoleta)
					If (vtACT_ErrorString#"")
						$i:=Size of array:C274($vy_pointer1->)
					End if 
				End for 
			Else 
				vtACT_ErrorString:=__ ("Error al leer ruta para almacenar archivos en el cliente.")
			End if 
			IT_UThermometer (-2;$vl_proc)
		End if 
		
	: ($vt_accion="SetPropiedad")
		  //ACTcfdi_OpcionesGenerales ("SetPropiedad";->$vt_propiedad)
		$vt_propiedad:=$vy_pointer1->
		$vt_tipo:=ST_GetWord ($vt_propiedad;1;"|")
		$vt_propiedad:=ST_GetWord ($vt_propiedad;2;"|")
		$vt_retorno:=""
		Case of 
			: ($vt_tipo="XML")
				$vl_pos:=Find in array:C230(atACTcfdi_PropiedadXML;$vt_propiedad)
				If ($vl_pos>0)
					atACTcfdi_ValorXML{$vl_pos}:=$vy_pointer2->
				End if 
				
			: ($vt_tipo="FILE")
				$vl_pos:=Find in array:C230(atACTcfdi_PropiedadGen;$vt_propiedad)
				If ($vl_pos>0)
					atACTcfdi_ValorGen{$vl_pos}:=$vy_pointer2->
				End if 
		End case 
		
	: ($vt_accion="ValidaPropiedad")
		Case of 
			: ($vy_pointer1->="FILE|rutaAlmacenamientoArchivosIngresoPagoServer")
				If (Not:C34((SYS_TestPathNameOnServer ($vy_pointer2->)=Is a folder:K24:2)))
					$vt_retorno:=""
					CD_Dlog (0;__ ("Ningún directorio fue encontrado en el servidor con la ruta especificada."))
				Else 
					$vt_retorno:=$vy_pointer2->
				End if 
				
			: ($vy_pointer1->="FILE|rutaAlmacenamientoArchivosIngresoPago")
				If (Not:C34((SYS_TestPathName ($vy_pointer2->)=Is a folder:K24:2)))
					$vt_retorno:=""
					CD_Dlog (0;__ ("Ningún directorio fue encontrado para la ruta especificada."))
				Else 
					$vt_retorno:=$vy_pointer2->
				End if 
				
		End case 
		
		
	: ($vt_accion="ObtieneArchivoDesdeServer")
		$vt_rutaOrigen:=$vy_pointer1->
		$vt_rutaDestino:=$vy_pointer2->
		$xBlob:=KRL_GetFileFromServer ($vt_rutaOrigen;True:C214)
		If (BLOB size:C605($xBlob)>0)
			EM_ErrorManager ("Install")
			EM_ErrorManager ("SetMode";"")
			SYS_CreateFolder (SYS_GetParentNme ($vt_rutaDestino))
			$ref:=Create document:C266($vt_rutaDestino)
			If (ok=1)
				CLOSE DOCUMENT:C267($ref)
				BLOB TO DOCUMENT:C526(document;$xBlob)
				$vt_retorno:="1"
			Else 
				$vt_retorno:="-1"
			End if 
			EM_ErrorManager ("Clear")
		Else 
			$vt_retorno:="-2"
		End if 
		
End case 
$0:=$vt_retorno