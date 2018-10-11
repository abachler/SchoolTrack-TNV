//%attributes = {}
  //ACTpgs_LLenaBlobCargosAviso

If (Count parameters:C259=1)
	$Display:=$1
Else 
	$Display:=True:C214
End if 

$iterations:=Size of array:C274(alACT_RecNumsAvisos)
If ($iterations>0)
	If ($Display)
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos{1})
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando cargos del aviso N° ")+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+__ ("..."))
	End if 
	For ($i;1;$iterations)
		If (BLOB size:C605(apACT_BlobsAvisos{$i}->)=0)
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos{$i})
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			If (vbACT_PagoXCuenta)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
			End if 
			$rnCta:=Record number:C243([ACT_CuentasCorrientes:175])
			ACTcc_LoadCargosIntoArrays 
			If ($rnCta#-1)
				GOTO RECORD:C242([ACT_CuentasCorrientes:175];$rnCta)
			End if 
			BLOB_Variables2Blob (apACT_BlobsAvisos{$i};0;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
			If ($Display)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$iterations;__ ("Buscando cargos del aviso Nº ")+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+__ ("..."))
			End if 
		End if 
	End for 
	If ($Display)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
End if 