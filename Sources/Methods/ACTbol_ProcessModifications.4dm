//%attributes = {}
  //ACTbol_ProcessModifications

  //20110608 AS. Se cambia de ubicacion
ARRAY LONGINT:C221($DA_Return;0)
alACT_WDTRecNums{0}:=0
AT_SearchArray (->alACT_WDTRecNums;"<";->$DA_Return)
If (Size of array:C274($DA_Return)>10)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Creando Documentos...")
End if 
For ($i;1;Size of array:C274($DA_Return))
	CREATE RECORD:C68([ACT_Boletas:181])
	[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
	[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_RelatedTableUserName
	[ACT_Boletas:181]FechaEmision:3:=adACT_WDTFecha{$DA_Return{$i}}
	[ACT_Boletas:181]AfectaIVA:9:=vbACT_WAfectaDocL
	[ACT_Boletas:181]Monto_Total:6:=0
	[ACT_Boletas:181]Monto_Afecto:4:=0
	[ACT_Boletas:181]Monto_IVA:5:=0
	[ACT_Boletas:181]ID_Categoria:12:=vlACT_WCatDocL
	ARRAY LONGINT:C221($al_idDoc;0)
	AT_Text2Array (->$al_idDoc;vtACT_WTipoDocID;";")
	[ACT_Boletas:181]ID_Documento:13:=$al_idDoc{1}
	  //[ACT_Boletas]ID_Documento:=vlACT_WTipoDocL
	[ACT_Boletas:181]TipoDocumento:7:=vtACT_WTipoDocL
	[ACT_Boletas:181]Numero:11:=alACT_WDTNumero{$DA_Return{$i}}
	[ACT_Boletas:181]ID_Apoderado:14:=0
	[ACT_Boletas:181]ID_Estado:20:=4
	[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
	[ACT_Boletas:181]Nula:15:=True:C214
	
	  //20161130 RCH
	[ACT_Boletas:181]ID_RazonSocial:25:=-1
	ACTbol_AsignaCodigoSII 
	
	SAVE RECORD:C53([ACT_Boletas:181])
	LOG_RegisterEvt ("Creación de Documento Tributario tipo "+[ACT_Boletas:181]TipoDocumento:7+" N° "+String:C10([ACT_Boletas:181]Numero:11)+" para rellenar vacío en la numeración.")
	If (Size of array:C274($DA_Return)>10)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_WDTEliminar))
	End if 
	alACT_WDTRecNums{$DA_Return{$i}}:=Record number:C243([ACT_Boletas:181])  //20110608 AS. Se agrega para reemplazar el record Number.
End for 
If (Size of array:C274($DA_Return)>10)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
KRL_UnloadReadOnly (->[ACT_Boletas:181])


If (Size of array:C274(alACT_WDTAnular)>10)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Anulando Documentos...")
End if 
For ($i;1;Size of array:C274(alACT_WDTAnular))
	GOTO RECORD:C242([ACT_Boletas:181];alACT_WDTAnular{$i})
	ACTbol_AnulaDcto (False:C215)
	If (Size of array:C274(alACT_WDTAnular)>10)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_WDTAnular))
	End if 
End for 
If (Size of array:C274(alACT_WDTAnular)>10)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
AT_Initialize (->alACT_WDTAnular)
DELAY PROCESS:C323(Current process:C322;60)
If (Size of array:C274(alACT_WDTEliminar)>10)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Eliminando Documentos...")
End if 
For ($i;1;Size of array:C274(alACT_WDTEliminar))
	READ WRITE:C146([ACT_Boletas:181])
	GOTO RECORD:C242([ACT_Boletas:181];alACT_WDTEliminar{$i})
	LOG_RegisterEvt ("Eliminación de Documento Tributario tipo "+[ACT_Boletas:181]TipoDocumento:7+" N° "+String:C10([ACT_Boletas:181]Numero:11))
	If (Not:C34(Locked:C147([ACT_Boletas:181])))
		If ([ACT_Boletas:181]Nula:15)
			DELETE RECORD:C58([ACT_Boletas:181])
		Else 
			BM_CreateRequest ("ACT_EliminaNulas";String:C10([ACT_Boletas:181]ID:1))
		End if 
	Else 
		BM_CreateRequest ("ACT_EliminaNulas";String:C10([ACT_Boletas:181]ID:1))
	End if 
	If (Size of array:C274(alACT_WDTAnular)>10)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_WDTEliminar))
	End if 
End for 
If (Size of array:C274(alACT_WDTEliminar)>10)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
AT_Initialize (->alACT_WDTEliminar)
abACT_WDTModificada{0}:=True:C214
  //AT_SearchArray (->abACT_WDTModificada;"=")
AT_SearchArray (->abACT_WDTModificada;"=";->$DA_Return)  //20170731 RCH No se pasaba el arreglo...
If (Size of array:C274($DA_Return)>10)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Modificando Documentos...")
End if 
For ($i;1;Size of array:C274($DA_Return))
	READ WRITE:C146([ACT_Boletas:181])
	GOTO RECORD:C242([ACT_Boletas:181];alACT_WDTRecNums{$DA_Return{$i}})
	$evt:="Modificación de Documento Tributario tipo "+[ACT_Boletas:181]TipoDocumento:7+" N° "+String:C10(alACT_WDTNumero{$DA_Return{$i}})+". "+ST_Boolean2Str (([ACT_Boletas:181]Numero:11#alACT_WDTNumero{$DA_Return{$i}});"Cambia número de "+String:C10([ACT_Boletas:181]Numero:11)+" a "+String:C10(alACT_WDTNumero{$DA_Return{$i}}))+ST_Boolean2Str (([ACT_Boletas:181]FechaEmision:3#adACT_WDTFecha{$DA_Return{$i}});"Cambia fecha de "+String:C10([ACT_Boletas:181]FechaEmision:3;7)+" a "+String:C10(adACT_WDTFecha{$DA_Return{$i}};7))
	LOG_RegisterEvt ($evt)
	If (Not:C34(Locked:C147([ACT_Boletas:181])))
		[ACT_Boletas:181]Numero:11:=alACT_WDTNumero{$DA_Return{$i}}
		[ACT_Boletas:181]FechaEmision:3:=adACT_WDTFecha{$DA_Return{$i}}
		SAVE RECORD:C53([ACT_Boletas:181])
	Else 
		$msg:=ST_Concatenate (Char:C90(0);->[ACT_Boletas:181]ID:1;->[ACT_Boletas:181]Numero:11;->[ACT_Boletas:181]FechaEmision:3)
		BM_CreateRequest ("ACT_ModificaBoleta";$msg)
	End if 
	If (Size of array:C274($DA_Return)>10)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_WDTEliminar))
	End if 
End for 
If (Size of array:C274($DA_Return)>10)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 


If (Size of array:C274(alACT_WDTNumero)>0)
	ACTbol_WDTAnalize 
End if 
