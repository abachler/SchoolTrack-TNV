//%attributes = {}
  //ACTdl_ResetData2Zero

MESSAGES OFF:C175

USR_SetModuleSemaphore (3)

PREF_Set (0;"ACT_Inicializado";"0")
$iterations:=18
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Reconfigurando AccountTrack..."))

$currentIteration:=1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Descargando y estableciendo modo lectrura/escritura..."))
IT_1SecDelay (1)

KRL_UnloadAll 
LOAD RECORD:C52([xShell_Dialogs:114])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Eliminando Preferencias..."))

$readonlystate:=Read only state:C362([xShell_Prefs:46])
READ WRITE:C146([xShell_Prefs:46])
QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="ACT_@")
DELETE SELECTION:C66([xShell_Prefs:46])
If ($readonlystate)
	READ ONLY:C145([xShell_Prefs:46])
End if 

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Eliminando cargos..."))

READ WRITE:C146([ACT_Cargos:173])
ALL RECORDS:C47([ACT_Cargos:173])
DELETE SELECTION:C66([ACT_Cargos:173])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Eliminando Cuentas Corrientes..."))

READ WRITE:C146([ACT_CuentasCorrientes:175])
ALL RECORDS:C47([ACT_CuentasCorrientes:175])
DELETE SELECTION:C66([ACT_CuentasCorrientes:175])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Eliminando Observaciones en Cuentas Corrientes..."))

READ WRITE:C146([ACT_Cuentas_Observaciones:102])
ALL RECORDS:C47([ACT_Cuentas_Observaciones:102])
DELETE SELECTION:C66([ACT_Cuentas_Observaciones:102])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Eliminando definiciones de items de cargo..."))

READ WRITE:C146([xxACT_Items:179])
ALL RECORDS:C47([xxACT_Items:179])
DELETE SELECTION:C66([xxACT_Items:179])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Eliminando items de matrices..."))

READ WRITE:C146([xxACT_ItemsMatriz:180])
ALL RECORDS:C47([xxACT_ItemsMatriz:180])
DELETE SELECTION:C66([xxACT_ItemsMatriz:180])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Eliminando definiciones de matrices..."))

READ WRITE:C146([ACT_Matrices:177])
ALL RECORDS:C47([ACT_Matrices:177])
DELETE SELECTION:C66([ACT_Matrices:177])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Eliminando avisos de cobranza..."))

READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
ALL RECORDS:C47([ACT_Avisos_de_Cobranza:124])
DELETE SELECTION:C66([ACT_Avisos_de_Cobranza:124])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Eliminando boletas..."))

READ WRITE:C146([ACT_Boletas:181])
ALL RECORDS:C47([ACT_Boletas:181])
DELETE SELECTION:C66([ACT_Boletas:181])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Eliminando descuentos por item..."))

READ WRITE:C146([xxACT_DesctosXItem:103])
ALL RECORDS:C47([xxACT_DesctosXItem:103])
DELETE SELECTION:C66([xxACT_DesctosXItem:103])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Eliminando documentos de pago..."))

READ WRITE:C146([ACT_Documentos_de_Pago:176])
ALL RECORDS:C47([ACT_Documentos_de_Pago:176])
DELETE SELECTION:C66([ACT_Documentos_de_Pago:176])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Eliminando documentos de cargo..."))

READ WRITE:C146([ACT_Documentos_de_Cargo:174])
ALL RECORDS:C47([ACT_Documentos_de_Cargo:174])
DELETE SELECTION:C66([ACT_Documentos_de_Cargo:174])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Eliminando pagos..."))

READ WRITE:C146([ACT_Pagos:172])
ALL RECORDS:C47([ACT_Pagos:172])
DELETE SELECTION:C66([ACT_Pagos:172])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Eliminando transacciones..."))

READ WRITE:C146([ACT_Transacciones:178])
ALL RECORDS:C47([ACT_Transacciones:178])
DELETE SELECTION:C66([ACT_Transacciones:178])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Eliminando documentos en cartera..."))

READ WRITE:C146([ACT_Documentos_en_Cartera:182])
ALL RECORDS:C47([ACT_Documentos_en_Cartera:182])
DELETE SELECTION:C66([ACT_Documentos_en_Cartera:182])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Liberando meses bloqueados..."))

READ WRITE:C146([xxACT_CierresMensuales:108])
ALL RECORDS:C47([xxACT_CierresMensuales:108])
DELETE SELECTION:C66([xxACT_CierresMensuales:108])

$currentIteration:=$currentIteration+1
$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$Iterations;__ ("Estableciendo modo sólo lectura..."))
IT_1SecDelay (1)
KRL_AllTablesReadOnly 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
FLUSH CACHE:C297
PREF_Set (0;"TestACTLicense";"0")
USR_ClearModuleSemaphore (3)