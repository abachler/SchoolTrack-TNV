//%attributes = {}
  //ACTfol_OpcionesGenerales
C_POINTER:C301($vy_pointer1;$vy_pointer2;${2})
C_LONGINT:C283($vl_id)
C_TEXT:C284($vt_path;$vt_accion;$1;$vt_retorno;$0)

$vt_accion:=$1
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
	: ($vt_accion="CreaRegistro")
		
		$vt_retorno:=ACTfol_OpcionesGenerales ("ValidaCreacionRegistro";$vy_pointer1;$vy_pointer2)
		If ($vt_retorno="")
			C_BLOB:C604($xBlob)
			C_LONGINT:C283($l_indice)
			$xBlob:=$vy_pointer3->
			
			If ([ACT_RazonesSociales:279]RUT:3=Replace string:C233($vy_pointer2->{1};"-";""))
				$vl_idRS:=[ACT_RazonesSociales:279]id:1
				READ WRITE:C146([ACT_FoliosDT:293])
				CREATE RECORD:C68([ACT_FoliosDT:293])
				
				  //20150207 RCH. En una base se perdio el id de secuencia y arrojo errores de llave duplicada
				  //[ACT_FoliosDT]id:=SQ_SeqNumber (->[ACT_FoliosDT]id)
				$l_indice:=SQ_SeqNumber (->[ACT_FoliosDT:293]id:1)
				While (Find in field:C653([ACT_FoliosDT:293]id:1;$l_indice)#-1)
					$l_indice:=SQ_SeqNumber (->[ACT_FoliosDT:293]id:1)
				End while 
				[ACT_FoliosDT:293]id:1:=$l_indice
				
				[ACT_FoliosDT:293]rut:12:=Replace string:C233($vy_pointer2->{1};"-";"")
				[ACT_FoliosDT:293]id_razonSocial:8:=$vl_idRS
				[ACT_FoliosDT:293]tipo_dteSII:7:=Num:C11($vy_pointer2->{3})
				[ACT_FoliosDT:293]desde:4:=Num:C11($vy_pointer2->{4})
				[ACT_FoliosDT:293]hasta:5:=Num:C11($vy_pointer2->{5})
				[ACT_FoliosDT:293]folio_disponible:6:=[ACT_FoliosDT:293]desde:4
				[ACT_FoliosDT:293]estado:3:=1
				[ACT_FoliosDT:293]id_categoriaACT:2:=0
				[ACT_FoliosDT:293]CAF_SII:9:=$xBlob
				[ACT_FoliosDT:293]llave_caf:11:=KRL_MakeStringAccesKey (->[ACT_FoliosDT:293]rut:12;->[ACT_FoliosDT:293]tipo_dteSII:7;->[ACT_FoliosDT:293]desde:4;->[ACT_FoliosDT:293]hasta:5)
				SAVE RECORD:C53([ACT_FoliosDT:293])
				$vt_retorno:=String:C10([ACT_FoliosDT:293]id:1)
				KRL_UnloadReadOnly (->[ACT_FoliosDT:293])
				
				KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->$vl_idRS;True:C214)
				[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ 8
				KRL_SaveUnLoadReadOnly (->[ACT_RazonesSociales:279])
				
			End if 
		Else 
			C_TEXT:C284($t_nombre)
			C_LONGINT:C283($l_estado;$l_tiempo)
			PROCESS PROPERTIES:C336(Current process:C322;$t_nombre;$l_estado;$l_tiempo)
			If ($t_nombre#"Batch Tasks Processor")
				CD_Dlog (0;$vt_retorno)
			End if 
			$vt_retorno:=""
		End if 
		
	: ($vt_accion="RetornaLlaveDesdeArreglo")
		C_TEXT:C284($vt_value1;$vt_value2;$vt_value3;$vt_value4;$vt_key)
		If (Size of array:C274($vy_pointer1->)>=5)
			$vt_value1:=Replace string:C233($vy_pointer1->{1};"-";"")
			$vt_value2:=$vy_pointer1->{3}
			$vt_value3:=$vy_pointer1->{4}
			$vt_value4:=$vy_pointer1->{5}
			$vt_retorno:=KRL_MakeStringAccesKey (->$vt_value1;->$vt_value2;->$vt_value3;->$vt_value4)
		End if 
		
	: ($vt_accion="ValidaCreacionRegistro")
		C_TEXT:C284($vt_key;$vt_value1)
		$vt_rut:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;$vy_pointer1;->[ACT_RazonesSociales:279]RUT:3)
		$vt_key:=ACTfol_OpcionesGenerales ("RetornaLlaveDesdeArreglo";$vy_pointer2)
		If ($vt_key#"")
			$vt_value1:=Replace string:C233($vy_pointer2->{1};"-";"")
			Case of 
				: ($vt_rut#$vt_value1)
					$vt_retorno:=__ ("El RUT del código de autorización de folios no corresponde con el ingresado en la base de datos.")
				: (Find in field:C653([ACT_FoliosDT:293]llave_caf:11;$vt_key)>=0)
					$vt_retorno:=__ ("Código de autorización de folios ya cargado.")
				Else 
					$vt_retorno:=""
			End case 
		End if 
		
	: ($vt_accion="ObtieneCaf")
		READ ONLY:C145([ACT_FoliosDT:293])
		KRL_FindAndLoadRecordByIndex (->[ACT_FoliosDT:293]id:1;$vy_pointer1)
		If (ok=1)
			  //$vt_retorno:=BLOB to text([ACT_FoliosDT]CAF_SII;Mac text without length;$offSet)
			$vt_retorno:=ACTfol_OpcionesGenerales ("ObtieneTextoCaf";->[ACT_FoliosDT:293]CAF_SII:9)
		End if 
		
	: ($vt_accion="ObtieneTextoCaf")
		C_LONGINT:C283($offSet)
		$vt_retorno:=BLOB to text:C555($vy_pointer1->;Mac text without length:K22:10;$offSet)
		
	: ($vt_accion="MarcaRegistroComoEnviado")
		$vl_id:=$vy_pointer1->
		  //esto puede venir desde la conf o desde las tareas bash...
		$vb_readOnly:=Read only state:C362([ACT_RazonesSociales:279])
		$vl_recNumRS:=Record number:C243([ACT_RazonesSociales:279])
		KRL_FindAndLoadRecordByIndex (->[ACT_FoliosDT:293]id:1;->$vl_id;True:C214)
		If (ok=1)
			KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279];->[ACT_FoliosDT:293]id_razonSocial:8;True:C214)
			If (ok=1)
				[ACT_RazonesSociales:279]estadoConfiguracion:33:=[ACT_RazonesSociales:279]estadoConfiguracion:33 ?+ 8
				SAVE RECORD:C53([ACT_RazonesSociales:279])
				[ACT_FoliosDT:293]enviadoDTE:10:=True:C214
				SAVE RECORD:C53([ACT_FoliosDT:293])
				$vt_retorno:="1"
			Else 
				If (Records in selection:C76([ACT_RazonesSociales:279])=1)
					BM_CreateRequest ("ACT_MarcaRegistroFolioEnviado";String:C10($vl_id);String:C10($vl_id))
				Else 
					$vt_retorno:="1"
				End if 
			End if 
		Else 
			If (Records in selection:C76([ACT_FoliosDT:293])=1)
				BM_CreateRequest ("ACT_MarcaRegistroFolioEnviado";String:C10($vl_id);String:C10($vl_id))
			Else 
				$vt_retorno:="1"
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_FoliosDT:293])
		KRL_UnloadReadOnly (->[ACT_RazonesSociales:279])
		KRL_ResetPreviousRWMode (->[ACT_RazonesSociales:279];$vb_readOnly)
		KRL_GotoRecord (->[ACT_RazonesSociales:279];$vl_recNumRS)
		
	: ($vt_accion="ObtieneProximoFolio")
		Case of 
				  //: ((at_proveedores{at_proveedores}="Colegium") & (cs_emitirCFDI=1))
			: ((at_proveedores{at_proveedores}="Colegium") & (cs_emitirCFDI=1) & (<>gCountryCode="cl"))  //para AR podria tomar el proveedor Colegium
				vbACT_noHayCAF:=True:C214
				
				READ ONLY:C145([ACT_RazonesSociales:279])
				REDUCE SELECTION:C351([ACT_RazonesSociales:279];0)
				$vb_estado:=KRL_GetNumericFieldData (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25;->[ACT_RazonesSociales:279]estadoConfiguracion:33)
				If ($vb_estado=510)  // todas las propiedades configuradas...
					READ WRITE:C146([ACT_FoliosDT:293])
					QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]id_razonSocial:8=[ACT_RazonesSociales:279]id:1;*)
					QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]estado:3=1;*)
					QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]tipo_dteSII:7=[ACT_Boletas:181]codigo_SII:33)
					ORDER BY:C49([ACT_FoliosDT:293];[ACT_FoliosDT:293]folio_disponible:6;>)
					REDUCE SELECTION:C351([ACT_FoliosDT:293];1)
					If (Records in selection:C76([ACT_FoliosDT:293])=1)
						If ((Not:C34(Locked:C147([ACT_FoliosDT:293]))))
							  //$vt_retorno:="0"  // para proveedor colegium, DTE asigna el folio
							$vt_retorno:=String:C10([ACT_FoliosDT:293]id:1)
							[ACT_FoliosDT:293]folio_disponible:6:=[ACT_FoliosDT:293]folio_disponible:6+1
							If ([ACT_FoliosDT:293]folio_disponible:6>[ACT_FoliosDT:293]hasta:5)
								[ACT_FoliosDT:293]estado:3:=2
							End if 
							SAVE RECORD:C53([ACT_FoliosDT:293])
							vbACT_noHayCAF:=False:C215
						Else 
							$vt_retorno:="-2"
						End if 
					Else 
						$vt_retorno:="-2"
					End if 
					KRL_UnloadReadOnly (->[ACT_FoliosDT:293])
				Else 
					$vt_retorno:="-2"
				End if 
			Else 
				$index:=$vy_pointer1->
				$vt_retorno:=String:C10(alACT_Proxima{$index})
		End case 
		
	: ($vt_accion="ReduceFolio")
		Case of 
			: ((at_proveedores{at_proveedores}="Colegium") & (cs_emitirCFDI=1))
				READ WRITE:C146([ACT_FoliosDT:293])
				READ ONLY:C145([ACT_RazonesSociales:279])
				REDUCE SELECTION:C351([ACT_RazonesSociales:279];0)
				$vb_estado:=KRL_GetNumericFieldData (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25;->[ACT_RazonesSociales:279]estadoConfiguracion:33)
				If ($vb_estado=510)  // todas las propiedades configuradas...
					QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]id:1=[ACT_Boletas:181]ID_CAF:43)
					REDUCE SELECTION:C351([ACT_FoliosDT:293];1)
					If (Records in selection:C76([ACT_FoliosDT:293])=1)
						If ((Not:C34(Locked:C147([ACT_FoliosDT:293]))))
							$vt_retorno:="0"  // para proveedor colegium, DTE asigna el folio
							[ACT_FoliosDT:293]folio_disponible:6:=[ACT_FoliosDT:293]folio_disponible:6-1
							If ([ACT_FoliosDT:293]folio_disponible:6<=[ACT_FoliosDT:293]hasta:5)
								[ACT_FoliosDT:293]estado:3:=1
							End if 
							SAVE RECORD:C53([ACT_FoliosDT:293])
						Else 
							$vt_retorno:="-2"
						End if 
					Else 
						$vt_retorno:="-2"
					End if 
				Else 
					$vt_retorno:="-2"
				End if 
		End case 
		KRL_UnloadReadOnly (->[ACT_FoliosDT:293])
		
	: ($vt_accion="CreaRegistroBash")
		C_BLOB:C604($xBlob;$xBlob2)
		C_LONGINT:C283($vl_idRS)
		ARRAY TEXT:C222($atACTdte_DatosCAF;0)
		$xBlob:=$vy_pointer1->
		$vt_retorno:="1"
		If (BLOB size:C605($xBlob)>0)
			BLOB_Blob2Vars (->$xBlob;0;->$vl_idRS;->$atACTdte_DatosCAF;->$xBlob2)
			If ((Size of array:C274($atACTdte_DatosCAF)>0) & (BLOB size:C605($xBlob2)>0))
				ACTfol_OpcionesGenerales ("CreaRegistro";->$vl_idRS;->$atACTdte_DatosCAF;->$xBlob2)
			End if 
		End if 
		
End case 

$0:=$vt_retorno