//%attributes = {}
  //0000xDev_BuscaAvisosDuplicados

If (Application type:C494#4D Server:K5:6)
	If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Cargos:173])
		C_LONGINT:C283($mes;$año;$idApdo;$idCta;$idCargo)
		C_LONGINT:C283($fldValue;$fldValue2;$fldValue3;$fldValue4;$fldValue5)
		ALL RECORDS:C47([ACT_Documentos_de_Cargo:174])
		ORDER BY:C49([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]Año:14;>;[ACT_Documentos_de_Cargo:174]ID_Apoderado:12;>;[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;[ACT_Documentos_de_Cargo:174]Mes:13;>)
		
		CREATE EMPTY SET:C140([ACT_Documentos_de_Cargo:174];"duplis")
		$mes:=0
		$año:=0
		$idApdo:=0
		$idCta:=0
		$idCargo:=0
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando avisos duplicados..."))
		While (Not:C34(End selection:C36([ACT_Documentos_de_Cargo:174])))
			$fldValue:=[ACT_Documentos_de_Cargo:174]Mes:13
			$fldValue2:=[ACT_Documentos_de_Cargo:174]Año:14
			$fldValue3:=[ACT_Documentos_de_Cargo:174]ID_Apoderado:12
			$fldValue4:=[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
			$fldValue5:=[ACT_Cargos:173]Ref_Item:16
			If (($fldValue=$mes) & ($fldValue2=$año) & ($fldValue3=$idApdo) & ($fldValue4=$idCta) & ($fldValue5=$idCargo))
				ADD TO SET:C119([ACT_Documentos_de_Cargo:174];"duplis")
				PREVIOUS RECORD:C110([ACT_Documentos_de_Cargo:174])
				ADD TO SET:C119([ACT_Documentos_de_Cargo:174];"duplis")
				NEXT RECORD:C51([ACT_Documentos_de_Cargo:174])
			End if 
			$mes:=[ACT_Documentos_de_Cargo:174]Mes:13
			$año:=[ACT_Documentos_de_Cargo:174]Año:14
			$idApdo:=[ACT_Documentos_de_Cargo:174]ID_Apoderado:12
			$idCta:=[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6
			$idCargo:=[ACT_Cargos:173]Ref_Item:16
			NEXT RECORD:C51([ACT_Documentos_de_Cargo:174])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ACT_Documentos_de_Cargo:174])/Records in table:C83([ACT_Avisos_de_Cobranza:124]))
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		USE SET:C118("Duplis")
		CLEAR SET:C117("duplis")
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"$RecordSet_Table"+String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124])))
		If (brLastDim>0)
			AL_RemoveArrays (xALP_Browser;1;brLastDim)
		End if 
		  //BWR_SelectTableData  `en algunos casos se caía el sistema en compilado
		BWR_LoadData 
	Else 
		CD_Dlog (0;__ ("Este comando sólo puede ser ejecutado desde la lengüeta Avisos de Cobranza."))
	End if 
End if 