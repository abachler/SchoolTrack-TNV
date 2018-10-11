//%attributes = {}
  //ACTcc_Documentar

ARRAY POINTER:C280(apACT_BlobsAvisos;0)
ARRAY TEXT:C222(aCtasApdo;0)
C_REAL:C285(vrACT_MontoPago;vrACT_MontoAdeudado)
C_PICTURE:C286($4)

RNApdo:=$1
RNCta:=$2
RNTercero:=$3
vpXS_IconModule:=$4
vsBWR_CurrentModule:=$5

ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")

WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTpgs_Documentar";0;4;__ ("Documentar Deuda");"wdw_CloseDlog")
DIALOG:C40([xxSTR_Constants:1];"ACTpgs_Documentar")
CLOSE WINDOW:C154
<>lACT_Documentar:=0
For ($i;1;Size of array:C274(apACT_BlobsAvisos))
	Bash_Return_Variable (apACT_BlobsAvisos{$i})
End for 
AT_Initialize (->apACT_BlobsAvisos;->aCtasApdo)