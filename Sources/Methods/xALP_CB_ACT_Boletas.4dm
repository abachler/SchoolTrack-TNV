//%attributes = {}
  //xALP_CB_ACT_Boletas

C_BOOLEAN:C305($0)
C_LONGINT:C283($ALArea;$exitMethod;$1;$2;$3)
  //20120103 RCH se utiliza para los dtes
C_LONGINT:C283(cs_asignarFolio)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (ALP_TiposdeDoc;$col;$row)
	
	$continue:=True:C214
	
	Case of 
		: ($col=2)
			If (AL_GetCellMod (ALP_TiposdeDoc)=1)
				$el:=Find in array:C230(atACT_CategoriasDctos;atACT_Cats{$row})
				If ($el#-1)
					  //$vl_exId:=alACT_IDCat{$row}
					  //alACT_IDsCats{0}:=$vl_exId
					  //AT_SearchArray (->alACT_IDsCats;"=")
					  //For ($i;1;Size of array(DA_Return))
					  //alACT_IDsCats{DA_Return{$i}}:=alACT_CategoriasDctos{$el}
					  //End for 
					alACT_IDCat{$row}:=alACT_CategoriasDctos{$el}
				Else 
					atACT_Cats{$row}:=""
				End if 
				
			End if 
			
		: ($col=4)
			Case of 
				: (atACT_Tipo{$row}=atACT_Tipos{1})
					aiACT_Tipo{$row}:=1
				: (atACT_Tipo{$row}=atACT_Tipos{2})
					aiACT_Tipo{$row}:=2
				Else 
					aiACT_Tipo{$row}:=0
			End case 
		: ($col=6)
			  //20120614 RCH Se hace cambio ya que se habia cambiado el comportamiento...
			  //If (((cs_emitirCFDI=1) & (cs_asignarFolio=1)) | (cs_emitirCFDI=0))
			If (((cs_emitirCFDI=1) & (cs_asignarFolio=1)) | (cs_emitirCFDI=0) | (aiACT_Tipo{$row}=1))  //20140708 RCH Cuando es impreso, se verifica el folio
				If ((vOldNumber>alACT_Proxima{$row}) & (Not:C34(IT_AltKeyIsDown )))
					BEEP:C151
					alACT_Proxima{$row}:=vOldNumber
					$continue:=False:C215
				Else 
					If (alACT_Proxima{$row}=0)
						BEEP:C151
						alACT_Proxima{$row}:=vOldNumber
						$continue:=False:C215
					Else 
						Case of 
							: (vOldNumber=0)
							: (alACT_Proxima{$row}>vOldNumber)
								CD_Dlog (0;__ ("¡¡¡Aumentar la numeración en forma manual va producir vacíos en el Libro de Ventas!!!"))
							: (alACT_Proxima{$row}<vOldNumber)
								CD_Dlog (0;__ ("¡¡¡Disminuir la numeración en forma manual puede producir Documentos Tributarios con numeración duplicada!!!"))
							: (alACT_Proxima{$row}=vOldNumber)
								$continue:=False:C215
						End case 
						If ($continue)
							LOG_RegisterEvt ("Modificación de la numeración de "+atACT_NombreDoc{$row}+" de "+String:C10(vOldNumber)+" a "+String:C10(alACT_Proxima{$row}))
						End if 
					End if 
				End if 
			Else 
				  //20120614 RCH Se hace cambio ya que se habia cambiado el comportamiento...
				If ((cs_emitirCFDI=1) & (cs_asignarFolio=0))
					$continue:=False:C215
					If (alACT_Proxima{$row}#vOldNumber)
						alACT_Proxima{$row}:=vOldNumber
						BEEP:C151
						CD_Dlog (0;__ ("Para modificar los folios digitales usted debe tener marcada la opción Asignar folio al emitir documentos."))
					End if 
				End if 
				
			End if 
		Else 
			If (Not:C34(Shift down:C543))
				Case of 
					: ($col=vlACT_indexRazonSocial)
						If (Not:C34(abACT_DocPorDefecto{$row}))
							C_LONGINT:C283($vl_cantidad;$el;$resp)
							C_BOOLEAN:C305($vb_continue)
							
							SET QUERY LIMIT:C395(1)
							SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_cantidad)
							QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=alACT_RazonSocial{$row};*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Documento:13=alACT_IDDT{$row})
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							SET QUERY LIMIT:C395(0)
							
							$vb_continue:=True:C214
							$el:=Find in array:C230(atACTcfg_Razones;atACT_RazonSocial{$row})
							If (($vl_cantidad>0) & (alACTcfg_Razones{$el}#0))
								$vt_msg:="Existen Documentos Tributarios asociados a la Razón Social "+ST_Qte (atACT_RazonSocial{0})+". Si usted continúa con el cambio podría obtener resultados inesperados al obtene"+"r informes relacionados con Documentos Tributarios."
								$vt_msg:=$vt_msg+"\r\r"+"¿Desea continuar?"
								$resp:=CD_Dlog (0;$vt_msg;__ ("");__ ("Si");__ ("No"))
								If ($resp=2)
									$vb_continue:=False:C215
								Else 
									LOG_RegisterEvt ("Cambio de Razón Social asociada a una definición en la configuración de Documento"+"s Tributarios. ID definición cambiada: "+String:C10(alACT_IDDT{$row})+". Cambió de: "+atACT_RazonSocial{0}+" a "+atACT_RazonSocial{$row}+".")
								End if 
							End if 
							If ($vb_continue)
								If ($el#-1)
									alACT_RazonSocial{$row}:=alACTcfg_Razones{$el}
								End if 
							Else 
								atACT_RazonSocial{$row}:=atACT_RazonSocial{0}
							End if 
						Else 
							atACT_RazonSocial{$row}:=""
							alACT_RazonSocial{$row}:=0
							BEEP:C151
						End if 
					: ($col=vlACT_indexSincronizar)
						$el:=Find in array:C230(atACT_NombreDoc;atACT_DTSinc{$row})
						If ($el#-1)
							If (alACT_Proxima{$row}#alACT_Proxima{$el})
								$resp:=CD_Dlog (0;__ ("¿Está seguro de querer asignar la numeración ")+String:C10(alACT_Proxima{$el})+__ (" a la categoría ")+ST_Qte (atACT_NombreDoc{$row})+__ ("?");__ ("");__ ("Si");__ ("No"))
							Else 
								$resp:=1
							End if 
							If ($resp=1)
								alACT_IdDTSinc{$row}:=alACT_IDDT{$el}
								alACT_Proxima{$row}:=alACT_Proxima{$el}
							Else 
								atACT_DTSinc{$row}:=""
								alACT_IdDTSinc{$row}:=0
							End if 
						Else 
							atACT_DTSinc{$row}:=""
							alACT_IdDTSinc{$row}:=0
						End if 
				End case 
			Else 
				C_POINTER:C301($ptr1;$ptr2)
				Case of 
					: ($col=vlACT_indexRazonSocial)
						$ptr1:=->atACT_RazonSocial
						$ptr2:=->alACT_RazonSocial
					: ($col=vlACT_indexSincronizar)
						$ptr1:=->atACT_DTSinc
						$ptr2:=->alACT_IdDTSinc
				End case 
				If ((Not:C34(Is nil pointer:C315($ptr1))) & (Not:C34(Is nil pointer:C315($ptr2))))  //FRC: se cae al retroceden con tab (shift+tab)
					If ($ptr1->{$row}#"")
						$resp:=CD_Dlog (0;__ ("¿Desea limpiar el dato de esta columna?");__ ("");__ ("Si");__ ("No"))
						If ($resp=1)
							$ptr1->{$row}:=""
							$ptr2->{$row}:=0
							If ($col=vlACT_indexRazonSocial)
								LOG_RegisterEvt ("Limpieza de Razón Social asociada a una definición en la configuración de Documen"+"to"+"s Tributarios. ID definición cambiada: "+String:C10(alACT_IDDT{$row})+". Cambió de: "+atACT_RazonSocial{0}+" a "+atACT_RazonSocial{$row}+".")
							End if 
						End if 
					End if 
				End if 
			End if 
	End case 
	
	If ($continue)
		ARRAY LONGINT:C221($al_posSameCat;0)
		ARRAY LONGINT:C221($al_posResult;0)
		ACTcfgbol_OpcionesMultiNum ("SearchSameCat";->$al_posSameCat;->$row)
		If (Size of array:C274($al_posSameCat)>1)
			alACT_Proxima{0}:=alACT_Proxima{$row}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alACT_Proxima;"=";->$DA_Return)
			AT_intersect (->$al_posSameCat;->$DA_Return;->$al_posResult)
			If ((Size of array:C274($al_posResult)>1) & (Not:C34(IT_AltKeyIsDown )))
				BEEP:C151
				If ($col=6)
					alACT_Proxima{$row}:=vOldNumber
				Else 
					alACT_Proxima{$row}:=0
				End if 
			Else 
				
			End if 
		End if 
	End if 
	
	ACTcfg_SetDocRowsColor 
End if 