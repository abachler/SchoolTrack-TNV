//%attributes = {}
  //ACTcc_OnRecordLoad

C_LONGINT:C283(vlACT_PageCuentas)
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Personas:7])
RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)
  //C_BOOLEAN(campopropio)
  //campopropio:=False
  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
vb_guardarCambios:=False:C215
If (Records in selection:C76([Alumnos:2])>0)
	RELATE ONE:C42([Alumnos:2]Familia_Número:24)
	QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_Cuentas_Número:28)
	If ([Alumnos:2]nivel_numero:29=Nivel_AdmissionTrack)
		READ WRITE:C146([ADT_Candidatos:49])
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_numero:1=[Alumnos:2]numero:1)
		OBJECT SET VISIBLE:C603(*;"ADT@";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"ADT@";False:C215)
	End if 
End if 
ACTinit_LoadMatrixIntoArrays 
AT_Initialize (->aUFItmName;->aUFItmVal)
UFLD_LoadFileTplt (->[ACT_CuentasCorrientes:175])
UFLD_LoadFields (->[ACT_CuentasCorrientes:175];->[ACT_CuentasCorrientes:175]UserFields:26;->[ACT_CuentasCorrientes]UserFields'Value;->xAL_ccUF)

If (vlACT_PageCuentas=0)
	vlACT_PageCuentas:=1
End if 
$recNum:=Record number:C243([ACT_CuentasCorrientes:175])
$wasROnly:=Read only state:C362([ACT_CuentasCorrientes:175])

$recNumAL:=Record number:C243([Alumnos:2])
ACTcc_OnLoadRecord (vlACT_PageCuentas)
  //GOTO RECORD([Alumnos];$recNumAL)
KRL_GotoRecord (->[Alumnos:2];$recNumAL)

SELECT LIST ITEMS BY POSITION:C381(hlTab_ACT_CuentaCorriente;vlACT_PageCuentas)
FORM GOTO PAGE:C247(vlACT_PageCuentas)

If (Records in selection:C76([Alumnos:2])>0)
	AL_LoadFamily 
End if 

KRL_ResetPreviousRWMode (->[ACT_CuentasCorrientes:175];$wasROnly)
GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNum)
If ([ACT_CuentasCorrientes:175]Codigo:19="")
	ACTcc_AsignaCodInterno ([ACT_CuentasCorrientes:175]ID_Alumno:3)
End if 
KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$recNum;Not:C34($wasROnly))
$el:=Find in array:C230(<>alACT_MatrixID;[ACT_CuentasCorrientes:175]ID_Matriz:7)
If ($el>0)
	<>atACT_MAtrixName:=$el
	vsACT_AsignedMatrix:=<>atACT_MatrixName{$el}
Else 
	vsACT_AsignedMatrix:="Seleccionar..."
	<>atACT_MAtrixName:=0
End if 
If ([ACT_CuentasCorrientes:175]Frecuencia_Facturacion:13="")
	[ACT_CuentasCorrientes:175]Frecuencia_Facturacion:13:="Seleccionar..."
	SAVE RECORD:C53([ACT_CuentasCorrientes:175])
End if 
vbACT_EstadoCC:=[ACT_CuentasCorrientes:175]Estado:4
  //ACTcc_SetTotalsColors -> Unused_ACTcc_SetTotalsColors
ACT_SetTotalsColorInputForm (->[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21;->[ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18)
READ ONLY:C145([ACT_Matrices:177])
READ ONLY:C145([Personas:7])
QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=[ACT_CuentasCorrientes:175]ID_Matriz:7)
QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)

AL_SetIdentificadorPrincipal 

SET BLOB SIZE:C606(xBlob;0)
xBlob:=PREF_fGetBlob (0;"ACT_DescuentosFamilia";xBlob)
BLOB_Blob2Vars (->xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision)
SET BLOB SIZE:C606(xBlob;0)

Case of 
	: (gGroupByFamily=1)
		vHijoCarga:=__ ("Hijo N°:")
		AL_SetHeaders (xALP_Hermano;3;1;__ ("Nº en Familia"))
	: (gGroupByGardian=1)
		vHijoCarga:=__ ("Carga N°:")
		AL_SetHeaders (xALP_Hermano;3;1;__ ("Carga N°"))
End case 

ACTcc_LoadAreaTerceros ([ACT_CuentasCorrientes:175]ID:1)

vtACT_NumTC:=""
vtACT_ModoPago:=""
vtACTcc_IdentTC:=""
vtACTcc_IdentPAC:=""
vbACT_CambioModoPago:=False:C215
ACTpp_CRYPTTC ("onLoad";->vtACT_NumTC;->[ACT_CuentasCorrientes:175]PAT_num_t_c:38)
If ([ACT_CuentasCorrientes:175]id_modo_de_pago:32=0)
	[ACT_CuentasCorrientes:175]id_modo_de_pago:32:=Num:C11(ACTcfgfdp_OpcionesGenerales ("GetIDFormaDePagoXDef"))
End if 
vtACT_ModoPago:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->[ACT_CuentasCorrientes:175]id_modo_de_pago:32)
IT_SetEnterable ((([ACT_CuentasCorrientes:175]id_modo_de_pago:32=-9) | ([ACT_CuentasCorrientes:175]id_modo_de_pago:32=-10));0;->[ACT_CuentasCorrientes:175]dia_de_cargo:33)
ACTpp_LabelPACPAT (->[Alumnos:2]Fecha_de_nacimiento:7;->vtACTcc_IdentTC;->vtACTcc_IdentPAC)

  //20160713 RCH Se cargan los descuentos
ACTcc_OpcionesDctos ("OnLoadingCtaCte";->[ACT_CuentasCorrientes:175]ID:1)