//%attributes = {}
  //ACTcc_CambiaFechaCargosProyecta

C_BLOB:C604($1;xBlob)
C_DATE:C307($date)
C_LONGINT:C283($startAtMonth;$endAtMonth;$matrixId;$itemID)
_O_C_INTEGER:C282($diaGeneracion;$diaVencimiento)
ARRAY LONGINT:C221(aLong1;0)
C_PICTURE:C286($2)
ACTinit_LoadPrefs   //lectura de las preferencias generales
xBlob:=$1
If (Count parameters:C259>1)
	vpXS_IconModule:=$2
	vsBWR_CurrentModule:=$3
End if 
If (Count parameters:C259=4)
	$Termometro:=$4
Else 
	$Termometro:=True:C214
End if 

BLOB_Blob2Vars (->xBlob;0;->aLong1;->b2;->b3;->cbTodosb2;->cbTodosb3;->vsGlosab3;->vdFecha1;->vdFecha2;->vdFecha3;->viACT_IDItem)
COPY ARRAY:C226(aLong1;$aRecNums)
READ WRITE:C146([ACT_CuentasCorrientes:175])
If ($Termometro)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cambiando fechas cargos..."))
End if 
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	READ WRITE:C146([ACT_Cargos:173])
	READ WRITE:C146([ACT_Documentos_de_Cargo:174])
	READ WRITE:C146([ACT_Transacciones:178])
	READ WRITE:C146([xxACT_DesctosXItem:103])
	GOTO RECORD:C242([ACT_CuentasCorrientes:175];$aRecNums{$i})
	If (b2=1)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4>=vdFecha1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4<=vdFecha2;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		If (cbTodosb2=1)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-2)
		Else 
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=viACT_IDItem)
		End if 
		  //20120418 ASM. Se perdia la selecciona al ejecutar la linea ($done:=ACTcc_BorrarDocdeCargo (String([ACT_Documentos_de_Cargo]ID_Documento))
		  // creo el set para utilizarlo posteriormente.
		CREATE SET:C116([ACT_Cargos:173];"CargosModificar")
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		ARRAY LONGINT:C221($aRNDocs;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Cargo:174];$aRNDocs;"")
		For ($u;1;Size of array:C274($aRNDocs))
			GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$aRNDocs{$u})
			  //20111116 RCH Se eliminaba siempre el documento de cargo asociado al item, esto podria producir problemas...
			$done:=ACTcc_BorrarDocdeCargo (String:C10([ACT_Documentos_de_Cargo:174]ID_Documento:1))
			If (Not:C34($done))
				BM_CreateRequest ("ACT_BorrarDocdeCargo";String:C10([ACT_Documentos_de_Cargo:174]ID_Documento:1))
			End if 
			  //If (Not(Locked([ACT_Documentos_de_Cargo])))
			  //DELETE RECORD([ACT_Documentos_de_Cargo])
			  //Else 
			  //BM_CreateRequest ("ACT_BorrarDocdeCargo";String([ACT_Documentos_de_Cargo]ID_Documento))
			  //End if 
		End for 
		USE SET:C118("CargosModificar")
		ARRAY LONGINT:C221($aRNCargos;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNCargos;"")
		For ($j;1;Size of array:C274($aRNCargos))
			READ WRITE:C146([ACT_Cargos:173])
			GOTO RECORD:C242([ACT_Cargos:173];$aRNCargos{$j})
			QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
			[ACT_Cargos:173]Fecha_de_generacion:4:=vdFecha3
			[ACT_Cargos:173]Mes:13:=Month of:C24([ACT_Cargos:173]Fecha_de_generacion:4)
			[ACT_Cargos:173]Año:14:=Year of:C25([ACT_Cargos:173]Fecha_de_generacion:4)
			[xxACT_DesctosXItem:103]Fecha_Generacion:7:=vdFecha3
			SAVE RECORD:C53([xxACT_DesctosXItem:103])
			CREATE RECORD:C68([ACT_Documentos_de_Cargo:174])
			[ACT_Documentos_de_Cargo:174]ID_Documento:1:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
			[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6:=[ACT_CuentasCorrientes:175]ID:1
			[ACT_Documentos_de_Cargo:174]ID_Alumno:11:=[ACT_CuentasCorrientes:175]ID_Alumno:3
			[ACT_Documentos_de_Cargo:174]ID_Apoderado:12:=[ACT_CuentasCorrientes:175]ID_Apoderado:9
			[ACT_Documentos_de_Cargo:174]ID_Matriz:2:=-2
			[ACT_Documentos_de_Cargo:174]Moneda:23:=[ACT_Cargos:173]Moneda:28
			[ACT_Documentos_de_Cargo:174]Año:14:=Year of:C25(vdFecha3)
			[ACT_Documentos_de_Cargo:174]Mes:13:=Month of:C24(vdFecha3)
			[ACT_Documentos_de_Cargo:174]FechaGeneracion:7:=vdFecha3
			[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20:=!00-00-00!
			SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
			[ACT_Cargos:173]ID_Documento_de_Cargo:3:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
			SAVE RECORD:C53([ACT_Cargos:173])
			$RecNumDC:=Record number:C243([ACT_Documentos_de_Cargo:174])
			ACTcc_CalculaDocumentoCargo ($RecNumDC)
		End for 
	End if 
	ACTcc_CalculaMontos ([ACT_CuentasCorrientes:175]ID:1)
	If ($Termometro)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Cambiando fechas cargos..."))
	End if 
End for 
If ($Termometro)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
SET_ClearSets ("CargosModificar")
KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
KRL_UnloadReadOnly (->[ACT_Cargos:173])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
KRL_UnloadReadOnly (->[ACT_Transacciones:178])
KRL_UnloadReadOnly (->[xxACT_DesctosXItem:103])