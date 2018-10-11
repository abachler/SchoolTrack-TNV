//%attributes = {}
  //ACTcfg_RecalculateCargoOnServer

<>vbACT_RecalcCargosServer:=True:C214
ACTinit_LoadPrefs 

SET BLOB SIZE:C606(xBlob;0)

xBlob:=$1
ARRAY LONGINT:C221(alACT_CargosAfectados;0)
ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
ARRAY DATE:C224(adACT_fechasEm;0)

BLOB_Blob2Vars (->xBlob;0;->alACT_CargosAfectados)

CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];alACT_CargosAfectados)
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=0)
KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRNC)
SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocsCargo)
$iterations:=Size of array:C274($aRNC)+Size of array:C274($aRecNumDocsCargo)
$currentIteration:=0
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ (""))
If (Size of array:C274($aRNC)>0)
	For ($i_Cargos;1;Size of array:C274($aRNC))
		$currentIteration:=$currentIteration+1
		READ WRITE:C146([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Cargos:173];$aRNC{$i_Cargos})
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
		$idmatriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7
		QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$idmatriz;*)
		QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
		If (Records in selection:C76([xxACT_ItemsMatriz:180])>0)
			$itemnomatriz:=False:C215
		Else 
			$itemnomatriz:=True:C214
		End if 
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
		LOAD RECORD:C52([ACT_Documentos_de_Cargo:174])
		UNLOAD RECORD:C212([ACT_Cargos:173])
		$Glosa:=ACTcc_CalculaMontoItem ($aRNC{$i_Cargos};$idmatriz;$itemnomatriz)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Recalculando cargo ")+$Glosa+__ ("..."))
		UNLOAD RECORD:C212([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	End for 
	
	For ($i_Docs;1;Size of array:C274($aRecNumDocsCargo))
		$currentIteration:=$currentIteration+1
		ACTcc_CalculaDocumentoCargo ($aRecNumDocsCargo{$i_Docs})
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Recalculando documentos de cargo..."))
	End for 
End if 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
<>vbACT_RecalcCargosServer:=False:C215