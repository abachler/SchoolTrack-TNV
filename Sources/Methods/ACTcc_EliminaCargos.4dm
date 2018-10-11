//%attributes = {}
  //ACTcc_EliminaCargos

<>vbACT_EliminandoCargos:=True:C214
C_BLOB:C604($1;xBlob)
C_DATE:C307($date)
C_LONGINT:C283($startAtMonth;$endAtMonth;$matrixId;$itemID)
_O_C_INTEGER:C282($diaGeneracion;$diaVencimiento)
ARRAY LONGINT:C221(aLong1;0)
ARRAY LONGINT:C221($al_idsCtas;0)
ARRAY LONGINT:C221($al_idsCtas2;0)
ARRAY LONGINT:C221($al_idsCtas3;0)

C_LONGINT:C283($l_idUsuario)
ARRAY LONGINT:C221($alACT_idsCargosAEliminarI;0)
ARRAY LONGINT:C221($alACT_idsCargosAEliminarT;0)
ARRAY LONGINT:C221($alACT_idsCargosAEliminarF;0)

C_PICTURE:C286($2)
ACTinit_LoadPrefs   //lectura de las preferencias generales
ACTcfg_ItemsMatricula ("InicializaYLee")
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
If (Count parameters:C259>=5)
	$l_idUsuario:=$5
End if 

BLOB_Blob2Vars (->xBlob;0;->aLong1;->b1;->b2;->b3;->aMeses;->aMeses2;->vdACT_AñoAviso;->cbTodosb2;->cbTodosb3;->vsGlosab3;->viACT_IDItem;->vdACT_AñoAviso2)
COPY ARRAY:C226(aLong1;$aRecNums)
If ($Termometro)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Eliminado cargos..."))
End if 
$fechaIni:=DT_GetDateFromDayMonthYear (1;aMeses;vdACT_AñoAviso)
$fechaFin:=DT_GetDateFromDayMonthYear (DT_GetLastDay (aMeses2;vdACT_AñoAviso2);aMeses2;vdACT_AñoAviso2)
READ WRITE:C146([ACT_CuentasCorrientes:175])
READ WRITE:C146([ACT_Cargos:173])
READ WRITE:C146([ACT_Documentos_de_Cargo:174])
READ WRITE:C146([ACT_Transacciones:178])
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([ACT_CuentasCorrientes:175];$aRecNums{$i})
	If (b1=1)
		
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=[ACT_CuentasCorrientes:175]ID:1;*)
		  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]FechaEmision=!00-00-00!;*)
		QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]ID_Matriz:2>-1;*)
		QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]FechaGeneracion:7>=$fechaIni;*)
		QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]FechaGeneracion:7<=$fechaFin)
		
		CREATE SET:C116([ACT_Documentos_de_Cargo:174];"setDcotCargo")
		QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]FechaEmision:21=!00-00-00!)
		CREATE SET:C116([ACT_Documentos_de_Cargo:174];"setDcotCargo2")
		DIFFERENCE:C122("setDcotCargo";"setDcotCargo2";"setDcotCargo")
		
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_idsCtas)
		COPY ARRAY:C226($al_idsCtas3;$al_idsCtas2)
		AT_Union (->$al_idsCtas;->$al_idsCtas2;->$al_idsCtas3)
		
		  //para log...
		SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_idsCargosAEliminarI)
		
		ACTcc_EliminaCargosLoop 
		
		If (Records in set:C195("setDcotCargo")>0)  //pueden existir dctos de cargo que esten asociados a avisos borrados. Con esto se eliminan los cargos...
			USE SET:C118("setDcotCargo")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			CREATE SET:C116([ACT_Documentos_de_Cargo:174];"setDcotCargo2")
			DIFFERENCE:C122("setDcotCargo";"setDcotCargo2";"setDcotCargo")
			USE SET:C118("setDcotCargo")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_idsCtas)
			COPY ARRAY:C226($al_idsCtas3;$al_idsCtas2)
			AT_Union (->$al_idsCtas;->$al_idsCtas2;->$al_idsCtas3)
			
			  //para log...
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_idsCargosAEliminarT)
			
			ACTcc_EliminaCargosLoop 
		End if 
		SET_ClearSets ("setDcotCargo";"setDcotCargo2")
		
		AT_Union (->$alACT_idsCargosAEliminarI;->$alACT_idsCargosAEliminarT;->$alACT_idsCargosAEliminarF)
		
	End if 
	If (b2=1)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4>=$fechaIni;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4<=$fechaFin;*)
		
		If (cbTodosb2=1)
			QUERY SELECTION:C341([ACT_Cargos:173])
		Else 
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=viACT_IDItem)
		End if 
		
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		  //QUERY SELECTION([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_Matriz=-2;*)
		  //QUERY SELECTION([ACT_Documentos_de_Cargo]; | ;[ACT_Documentos_de_Cargo]ID_Matriz=-1)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_idsCtas)
		COPY ARRAY:C226($al_idsCtas3;$al_idsCtas2)
		AT_Union (->$al_idsCtas;->$al_idsCtas2;->$al_idsCtas3)
		
		  //para log...
		SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_idsCargosAEliminarT)
		COPY ARRAY:C226($alACT_idsCargosAEliminarF;$alACT_idsCargosAEliminarI)
		AT_Union (->$alACT_idsCargosAEliminarI;->$alACT_idsCargosAEliminarT;->$alACT_idsCargosAEliminarF)
		
		ACTcc_EliminaCargosLoop 
	End if 
	ACTcc_CalculaMontos ([ACT_CuentasCorrientes:175]ID:1)
	If ($Termometro)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
	End if 
End for 
If ($Termometro)
	ACTcfg_ItemsMatricula ("EliminaPago";->$al_idsCtas3)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 

If (Size of array:C274($alACT_idsCargosAEliminarF)>0)
	$t_ids:=AT_array2text (->$alACT_idsCargosAEliminarF;" - ";"############")
	
	
	LOG_RegisterEvt ("Eliminación de cargos proyectados mediante Asistente. Los siguientes ids de cargos fueron eliminados "+$t_ids+".";0;0;$l_idUsuario;"AccountTrack")
End if 

KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
KRL_UnloadReadOnly (->[ACT_Cargos:173])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
KRL_UnloadReadOnly (->[ACT_Transacciones:178])
<>vbACT_EliminandoCargos:=False:C215
DELAY PROCESS:C323(Current process:C322;60)