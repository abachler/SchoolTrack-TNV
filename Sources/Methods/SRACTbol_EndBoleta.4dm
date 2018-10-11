//%attributes = {}
  //SRACTbol_EndBoleta

C_LONGINT:C283($1;$bol)
C_POINTER:C301($varPtr;$varPtrTemp1;$varPtrTemp2)
C_POINTER:C301($var1;$var2;$var3;$var4;$var5;$var6;$var7;$var8;$var9;$var10;$var11;$var12;$var13;$var14;$var15)

$bol:=1
If (Count parameters:C259=1)
	$bol:=$1
End if 
  //20130210 RCH
$varPtr:=Get pointer:C304("vlACT_SRbol_ID"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vlACT_SRbol_IDDT"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vtACT_SRbol_DocsAsoc"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_TipoDT"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_EstadoDT"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vdACT_SRbol_FechaEmision"+String:C10($bol))
$varPtr->:=!00-00-00!
$varPtr:=Get pointer:C304("vtACT_SRbol_EmitidoPor"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vlACT_SRbol_FechaDia"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vlACT_SRbol_FechaAño"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vlACT_SRbol_FechaMes"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vtACT_SRbol_FechaMesText"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vrACT_SRbol_Total"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRbol_Afecto"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRbol_IVA"+String:C10($bol))
$varPtr->:=0
  //20130210 RCH
$varPtr:=Get pointer:C304("vrACT_SRbol_Exento"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRbol_PorcIVA"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vrACT_SRbol_TotalText"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_ApdoNombre"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_IDNacApdo"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirCombinadaEC"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirEC"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_CodPosEC"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_ComunaEC"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_CiudadEC"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirCombPersonal"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirPersonal"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_CodPosPersonal"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_ComunaPersonal"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_CiudadPersonal"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirProfesional"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_CodigoFamilias"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_NombreFamilias"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_MododePago"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vrACT_SRbol_SaldoApdo"+String:C10($bol))
$varPtr->:=0
$varPtr:=Get pointer:C304("vtACT_SRBol_CtaNombre"+String:C10($bol))
AT_Initialize ($varPtr)
$varPtr:=Get pointer:C304("vtACT_SRbol_CtaCurso"+String:C10($bol))
AT_Initialize ($varPtr)
$varPtr:=Get pointer:C304("vtACT_SRBol_CtaMatricula"+String:C10($bol))
AT_Initialize ($varPtr)
$varPtr:=Get pointer:C304("vtACT_SRBol_CtaPCurso"+String:C10($bol))
AT_Initialize ($varPtr)
$varPtr:=Get pointer:C304("vtACT_SRbol_RUTCta"+String:C10($bol))
AT_Initialize ($varPtr)
$varPtr:=Get pointer:C304("vtACT_SRbol_ATMesCargo"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_ANMesCargo"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("alACT_SRbol_NoNivel"+String:C10($bol))
AT_Initialize ($varPtr)
$varPtr:=Get pointer:C304("atACT_SRbol_NumTrans"+String:C10($bol))
AT_Initialize ($varPtr)
$varPtr:=Get pointer:C304("atACT_SRbol_Sede"+String:C10($bol))
AT_Initialize ($varPtr)
$varPtr:=Get pointer:C304("arACTmx_MontoIVA"+String:C10($bol))
AT_Initialize ($varPtr)

  //receptor
$varPtr:=Get pointer:C304("vtACT_SRbol_RecNombre"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_IDNacRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirCombinadaECRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirECRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_CodPosECRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_ComunaECRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_CiudadECRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirCombPersonalRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirPersonalRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_CodPosPersonalRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_ComunaPersonalRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_CiudadPersonalRec"+String:C10($bol))
$varPtr->:=""
$varPtr:=Get pointer:C304("vtACT_SRbol_DirProfesionalRec"+String:C10($bol))
$varPtr->:=""

C_LONGINT:C283($vl_lineas)
  //$vl_lineas:=Num(ACTcfg_OpcionesLineasDT ("ObtieneNumLineas"))
$vl_lineas:=20  //se resetean el máximo de líneas
For ($t;1;$vl_lineas)
	$var1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($t)+String:C10($bol))
	$var2:=Get pointer:C304("vrACT_SRbol_MontoCargo"+String:C10($t)+String:C10($bol))
	$var3:=Get pointer:C304("vtACT_SRbol_CuentaCargo"+String:C10($t)+String:C10($bol))
	$var4:=Get pointer:C304("vlACT_SRbol_CantidadCargo"+String:C10($t)+String:C10($bol))
	$var5:=Get pointer:C304("vrACT_SRbol_UnitarioCargo"+String:C10($t)+String:C10($bol))
	$var6:=Get pointer:C304("vbACT_HideMonto"+String:C10($t)+String:C10($bol))
	$var7:=Get pointer:C304("vtACT_SRbol_CuentaCurCargo"+String:C10($t)+String:C10($bol))
	$var8:=Get pointer:C304("vtACT_SRbol_CuentaNivCargo"+String:C10($t)+String:C10($bol))
	$var9:=Get pointer:C304("vtACT_SRbol_CuentaPCurCargo"+String:C10($t)+String:C10($bol))
	$var10:=Get pointer:C304("vtACT_SRbol_CuentaPNivCargo"+String:C10($t)+String:C10($bol))
	$var11:=Get pointer:C304("vtACT_SRbol_MesCargo"+String:C10($t)+String:C10($bol))
	$var12:=Get pointer:C304("vlACT_SRbol_AñoCargo"+String:C10($t)+String:C10($bol))
	$var13:=Get pointer:C304("vtACT_SRbol_MontoMoneda"+String:C10($t)+String:C10($bol))
	$var14:=Get pointer:C304("vrACT_SRbol_MontoEnUF"+String:C10($t)+String:C10($bol))
	$var15:=Get pointer:C304("vrACT_SRbol_MontoDcto"+String:C10($t)+String:C10($bol))
	
	$var16:=Get pointer:C304("vbACT_SRbol_Afecto"+String:C10($t)+String:C10($bol))
	$var17:=Get pointer:C304("vlACT_SRbol_IDCargo"+String:C10($t)+String:C10($bol))
	$var18:=Get pointer:C304("vtACT_SRbol_unidadCargo"+String:C10($t)+String:C10($bol))
	
	$var19:=Get pointer:C304("vtACT_SRbol_CuentaRUT"+String:C10($t)+String:C10($bol))
	$var20:=Get pointer:C304("vtACT_SRbol_AñoCargo"+String:C10($t)+String:C10($bol))
	
	$var1->:=""
	$var2->:=0
	$var3->:=""
	$var4->:=0
	$var5->:=0
	$var6->:=True:C214
	$var7->:=""
	$var8->:=""
	$var9->:=""
	$var10->:=""
	$var11->:=""
	$var12->:=0
	$var13->:=""
	$var14->:=0
	$var15->:=0
	
	$var16->:=False:C215
	$var17->:=0
	$var18->:=""
	
	$var19->:=""
	
	$var20->:=""
	
	$var1:=Get pointer:C304("vtACT_SRbolPGS_Forma"+String:C10($t)+String:C10($bol))
	$var2:=Get pointer:C304("vtACT_SRbolPGS_Fecha"+String:C10($t)+String:C10($bol))
	$var3:=Get pointer:C304("vrACT_SRbolPGS_Monto"+String:C10($t)+String:C10($bol))
	$var5:=Get pointer:C304("vrACT_SRbolPGS_MontoUF"+String:C10($t)+String:C10($bol))
	$var1->:=""
	$var2->:=""
	$var3->:=0
	$var5->:=0
	For ($i;1;6)
		$var4:=Get pointer:C304("vtACT_SRbolPGS_DatoPago"+String:C10($i)+String:C10($t)+String:C10($bol))
		$var4->:=""
	End for 
End for 
SRACTbol_CargaDatosTercero ("LimpiaVars";->$bol)