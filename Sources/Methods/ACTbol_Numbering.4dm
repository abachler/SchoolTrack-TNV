//%attributes = {}
  //ACTbol_Numbering

C_REAL:C285($0)
C_LONGINT:C283(vlACT_numeroDctoDuplicado)
C_TEXT:C284(vtACT_tipoDctoDuplicado)
C_BOOLEAN:C305($vb_afecta)
C_BOOLEAN:C305(vbACT_noHayCAF;vbACT_noHayFDE)
vlACT_numeroDctoDuplicado:=0
vtACT_tipoDctoDuplicado:=""
vbACT_noHayCAF:=False:C215
vbACT_noHayFDE:=False:C215

$index:=$1
$selection:=$2
$unload:=True:C214
$save:=True:C214
If (Count parameters:C259=3)
	$save:=$3
End if 
If (Count parameters:C259=4)
	$save:=$3
	$unload:=$4
End if 
While (Semaphore:C143("NumeracionDT"))
	DELAY PROCESS:C323(Current process:C322;20)
End while 
C_LONGINT:C283($vl_docs;$vl_numDoc;$vl_catDoc)

  //20150627 RCH Cuando se cargaba toda la configuración, se perdia la configuración para una RS diferente. Ahora solo se recargan los arreglos para obtener el próximo folio...
  //ACTcfg_LoadConfigData (8)
ACTcfg_LeeBlob ("ACT_DocsTributarios")

  //$Proxima:=alACT_Proxima{$index}

$DocName:=atACT_NombreDoc{$index}
$vl_idRazonSocial:=alACT_RazonSocial{$index}
$vb_afecta:=abACT_Afecta{$index}
$vbACT_EsDigital:=(aiACT_Tipo{$index}=2)

  //20120626 RCH la razon social por defecto es -1
If ($vl_idRazonSocial=0)
	$vl_idRazonSocial:=-1
End if 

$Proxima:=Num:C11(ACTfol_OpcionesGenerales ("ObtieneProximoFolio";->$index))
If ($Proxima#-2)
	If ((<>gCountryCode="ar") & ($vbACT_EsDigital))  //20150626 RCH Por si configuran en 0
		If ($Proxima=0)
			$Proxima:=1
		End if 
	End if 
	
	  //If (($vbACT_EsDigital) & (at_proveedores{at_proveedores}="Colegium") & (cs_emitirCFDI=1))
	If (($vbACT_EsDigital) & (at_proveedores{at_proveedores}="Colegium") & (cs_emitirCFDI=1) & (<>gCountryCode="cl"))  //Para ar tb podria ser Colegium el proveedor
		$l_idCAF:=$Proxima
	Else 
		$l_idCAF:=0
	End if 
	  //20120103 RCH Para documentos digitales a los que asignamos folios.
	  //If ($vbACT_EsDigital)
	If (($vbACT_EsDigital) & (cs_asignarFolio=0))
		$Proxima:=0
	End if 
	
	Case of 
		: ($selection="current")
			  //If (Not($vbACT_EsDigital))
			If ((Not:C34($vbACT_EsDigital)) | (cs_asignarFolio=1))
				$vl_numDoc:=$Proxima
				$vl_catDoc:=[ACT_Boletas:181]ID_Categoria:12
				$vl_idRazonSocial:=[ACT_Boletas:181]ID_RazonSocial:25
				
				$vl_docs:=Num:C11(ACTbol_OpcionesGenerales ("BuscaDocDuplicado";->[ACT_Boletas:181]TasaIVA:16;->$vl_numDoc;->$vl_catDoc;->$vbACT_EsDigital;->$vl_idRazonSocial))
				
				  //SET QUERY DESTINATION(Into variable;$vl_docs)
				  //If ($vb_afecta)
				  //QUERY([ACT_Boletas];[ACT_Boletas]Numero=$vl_numDoc;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]ID_Categoria=$vl_catDoc;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]TasaIVA#0;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]documento_electronico=$vbACT_EsDigital;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]ID_RazonSocial=$vl_idRazonSocial)
				  //Else 
				  //QUERY([ACT_Boletas];[ACT_Boletas]Numero=$vl_numDoc;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]ID_Categoria=$vl_catDoc;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]TasaIVA=0;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]documento_electronico=$vbACT_EsDigital;*)
				  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]ID_RazonSocial=$vl_idRazonSocial)
				  //End if 
				  //SET QUERY DESTINATION(Into current selection)
			End if 
			If ($vl_docs=0)
				[ACT_Boletas:181]Numero:11:=$Proxima
				[ACT_Boletas:181]TipoDocumento:7:=$DocName
				If ($l_idCAF#0)
					[ACT_Boletas:181]ID_CAF:43:=$l_idCAF
				End if 
				  //20120907 RCH Se almacena el id en ACTbol_CreateRecord
				  //[ACT_Boletas]ID_RazonSocial:=$vl_idRazonSocial
				$Proxima:=$Proxima+1
				If ($save)
					SAVE RECORD:C53([ACT_Boletas:181])
				End if 
			Else 
				$Proxima:=-2
			End if 
		: ($selection="seleccion")
			FIRST RECORD:C50([ACT_Boletas:181])
			For ($i;1;Records in selection:C76([ACT_Boletas:181]))
				  //If (Not($vbACT_EsDigital))
				If ((Not:C34($vbACT_EsDigital)) | (cs_asignarFolio=1))
					$vl_numDoc:=$Proxima
					$vl_catDoc:=[ACT_Boletas:181]ID_Categoria:12
					$vl_idRazonSocial:=[ACT_Boletas:181]ID_RazonSocial:25
					
					$vl_docs:=Num:C11(ACTbol_OpcionesGenerales ("BuscaDocDuplicado";->[ACT_Boletas:181]TasaIVA:16;->$vl_numDoc;->$vl_catDoc;->$vbACT_EsDigital;->$vl_idRazonSocial))
					  //SET QUERY DESTINATION(Into variable;$vl_docs)
					  //If ($vb_afecta)
					  //QUERY([ACT_Boletas];[ACT_Boletas]Numero=$vl_numDoc;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]ID_Categoria=$vl_catDoc;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]TasaIVA#0;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]documento_electronico=$vbACT_EsDigital;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]ID_RazonSocial=$vl_idRazonSocial)
					  //Else 
					  //QUERY([ACT_Boletas];[ACT_Boletas]Numero=$vl_numDoc;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]ID_Categoria=$vl_catDoc;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]TasaIVA=0;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]documento_electronico=$vbACT_EsDigital;*)
					  //QUERY([ACT_Boletas]; & ;[ACT_Boletas]ID_RazonSocial=$vl_idRazonSocial)
					  //End if 
					  //SET QUERY DESTINATION(Into current selection)
				End if 
				If ($vl_docs=0)
					[ACT_Boletas:181]Numero:11:=$Proxima
					[ACT_Boletas:181]TipoDocumento:7:=$DocName
					If ($l_idCAF#0)
						[ACT_Boletas:181]ID_CAF:43:=$l_idCAF
					End if 
					
					  //20120907 RCH Se almacena el id en ACTbol_CreateRecord
					  //[ACT_Boletas]ID_RazonSocial:=$vl_idRazonSocial
					SAVE RECORD:C53([ACT_Boletas:181])
					NEXT RECORD:C51([ACT_Boletas:181])
					If ($i=1)
						$0:=$Proxima
					End if 
					$Proxima:=$Proxima+1
				Else 
					$i:=Records in selection:C76([ACT_Boletas:181])
					$Proxima:=-2
				End if 
			End for 
	End case 
	If ($Proxima#-2)
		  //If (Not($vbACT_EsDigital))
		If ((Not:C34($vbACT_EsDigital)) | (cs_asignarFolio=1))
			alACT_Proxima{$index}:=$Proxima
			ACTcfgbol_OpcionesSinc ("SincronizaNumeracion";->$index;->$Proxima)
			ACTcfg_SaveConfig (8)
		End if 
	Else 
		vlACT_numeroDctoDuplicado:=$vl_numDoc
		vtACT_tipoDctoDuplicado:=$DocName
		vtACT_RazonSocialDctoDuplicado:=atACT_RazonSocial{$index}
		$0:=$Proxima
	End if 
Else 
	$0:=$Proxima
End if 
If ($unload)
	UNLOAD RECORD:C212([ACT_Boletas:181])
End if 
CLEAR SEMAPHORE:C144("NumeracionDT")