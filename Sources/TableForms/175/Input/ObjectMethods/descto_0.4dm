$RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
  //$b_calcularCuentas:=False
  //ACTcc_OpcionesDctos ("OnSavingCtaCte";->$b_calcularCuentas)
ACTcc_OpcionesDctos ("OnSavingCtaCte")

GOTO RECORD:C242([ACT_CuentasCorrientes:175];$RNCta)
ACTcc_OpcionesDctos ("OnLoadingCtaCte";->[ACT_CuentasCorrientes:175]ID:1)

ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando cargos..."))

QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)
$idmatriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7
UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocsCta)
SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumsCargos)
$iterations:=Size of array:C274($aRecNumsCargos)+Size of array:C274($aRecNumDocsCta)
$currentiteration:=0
  //ACTinit_LoadPrefs 
For ($i_Cargos;1;Size of array:C274($aRecNumsCargos))
	$currentiteration:=$i_Cargos
	GOTO RECORD:C242([ACT_Cargos:173];$aRecNumsCargos{$i_Cargos})
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
	QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$idmatriz;*)
	QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
	UNLOAD RECORD:C212([ACT_Cargos:173])
	If (Records in selection:C76([xxACT_ItemsMatriz:180])>0)
		$itemnomatriz:=False:C215
	Else 
		$itemnomatriz:=True:C214
	End if 
	READ WRITE:C146([ACT_Cargos:173])
	ACTcc_CalculaMontoItem ($aRecNumsCargos{$i_Cargos};$idmatriz;$itemnomatriz)
	UNLOAD RECORD:C212([ACT_Cargos:173])
	READ ONLY:C145([ACT_Cargos:173])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentiteration/$iterations;__ ("Recalculando cargos..."))
End for 

For ($Docs;1;Size of array:C274($aRecNumDocsCta))
	$currentiteration:=$currentiteration+1
	ACTcc_CalculaDocumentoCargo ($aRecNumDocsCta{$Docs})
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentiteration/$iterations;__ ("Recalculando documentos de cargo..."))
End for 
READ WRITE:C146([ACT_CuentasCorrientes:175])
GOTO RECORD:C242([ACT_CuentasCorrientes:175];$RNCta)
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If (Size of array:C274($aRecNumsCargos)>0)
	$l_proc:=IT_UThermometer (1;0;"Calculando cuentas...")
	ACTcc_CalculaMontos ([ACT_CuentasCorrientes:175]ID:1)
	IT_UThermometer (-2;$l_proc)
End if 

GOTO RECORD:C242([ACT_CuentasCorrientes:175];$RNCta)