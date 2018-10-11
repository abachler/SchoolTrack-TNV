//%attributes = {}
  //ACTcae_CargaVarsCierre

C_LONGINT:C283($vl_Año;$vl_Mes)
C_BOOLEAN:C305($0)
$vl_Año:=$1
$vl_Mes:=$2

READ ONLY:C145([xxACT_Datos_de_Cierre:116])
QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$vl_Año;*)
QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$vl_Mes)
If ((Records in selection:C76([xxACT_Datos_de_Cierre:116])=1) & ([xxACT_Datos_de_Cierre:116]CantidadDeCierres:5>0))
	  //20120629 RCH
	  //BLOB_Blob2Vars (->[xxACT_Datos_de_Cierre]xPreferences;0;->vi_AgnosAvisos;->vi_AgnosPagos;->vi_AgnosDocDep;->vi_AgnosDocTrib;->cb_EliminaHAvisos;->cb_EliminaHPagos;->cb_EliminaHDocDep;->cb_EliminaHDocTrib;->cb_InactivaEgresados;->cb_InactivaRetirados;->cb_LimpiaMatrices;->cb_LimpiaDesctoXCta;->vt_backupFolder;->vt_backupFile;->vl_Mes;->vl_Año)
	BLOB_Blob2Vars (->[xxACT_Datos_de_Cierre:116]xPreferences:2;0;->vi_AgnosAvisos;->vi_AgnosPagos;->vi_AgnosDocDep;->vi_AgnosDocTrib;->cb_EliminaHAvisos;->cb_EliminaHPagos;->cb_EliminaHDocDep;->cb_EliminaHDocTrib;->cb_InactivaEgresados;->cb_InactivaRetirados;->cb_LimpiaMatrices;->cb_LimpiaDesctoXCta;->vt_backupFolder;->vt_backupFile;->vl_Mes;->vl_Año;->cb_inicializaUFields;->cb_eliminaDocCarNulos)
	$0:=True:C214
Else 
	$0:=False:C215
End if 