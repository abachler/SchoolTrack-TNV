//%attributes = {}
  //ACTitem_CreateRecord
C_REAL:C285(vr_Hijo2;vr_Hijo3;vr_Hijo4;vr_Hijo5;vr_Hijo6;vr_Hijo7;vr_Hijo8;vr_Hijo9;vr_Hijo10;vr_Hijo11;vr_Hijo12;vr_Hijo13;vr_Hijo14;vr_Hijo15;vr_Hijo16;vr_Hijo17)
C_BOOLEAN:C305($vb_afecto;$vb_afectoDcto;$vb_afectoDctoInd;$vb_afectoInteres;$vb_esDescuento;$vb_impUnica;$vb_noIncluirDT;$vb_tipoInteres)
C_REAL:C285($vr_monto;$vr_tasaInteres;$0)
C_TEXT:C284($vt_ccentroCosto;$vt_cctaAuxiliar;$vt_cctaContable;$vt_centroCosto;$vt_ctaAuxiliar;$vt_ctaContable;$vt_glosa;$vt_moneda;$vt_obs;$vt_nomArrDctoNoHijo)
C_TEXT:C284($t_periodo)

C_LONGINT:C283($xx;$vl_indiceArray)
C_POINTER:C301($varPtr;$arrayPtr)
C_REAL:C285($r_idRS)

$vt_glosa:=$1

If (Count parameters:C259>=2)
	$vb_afecto:=$2
End if 
If (Count parameters:C259>=3)
	$vb_esDescuento:=$3
End if 
If (Count parameters:C259>=4)
	$vt_moneda:=$4
End if 
If (Count parameters:C259>=5)
	$vr_monto:=$5
End if 
If (Count parameters:C259>=6)
	$vt_ctaContable:=$6
End if 
If (Count parameters:C259>=7)
	$vt_ctaAuxiliar:=$7
End if 
If (Count parameters:C259>=8)
	$vt_centroCosto:=$8
End if 
If (Count parameters:C259>=9)
	$vt_cctaContable:=$9
End if 
If (Count parameters:C259>=10)
	$vt_cctaAuxiliar:=$10
End if 
If (Count parameters:C259>=11)
	$vt_ccentroCosto:=$11
End if 
If (Count parameters:C259>=12)
	$vb_noIncluirDT:=$12
End if 
If (Count parameters:C259>=13)
	$vt_obs:=$13
End if 
If (Count parameters:C259>=14)
	$vb_impUnica:=$14
End if 
If (Count parameters:C259>=15)
	$vb_afectoDctoInd:=$15
End if 
If (Count parameters:C259>=16)
	$vb_afectoDcto:=$16
End if 
If (Count parameters:C259>=17)
	$vb_afectoInteres:=$17
End if 
If (Count parameters:C259>=18)
	$vr_tasaInteres:=$18
End if 
If (Count parameters:C259>=19)
	$vb_tipoInteres:=$19
End if 
If (Count parameters:C259>=20)
	$vt_nomArrDctoNoHijo:=$20
End if 
If (Count parameters:C259>=21)
	$vl_indiceArray:=$21
End if 
If (Count parameters:C259>=22)
	$t_periodo:=$22
End if 
If (Count parameters:C259>=23)
	$r_idRS:=$23
End if 

  //20141222 RCH 
If ($t_periodo="")
	$t_periodo:=<>gNombreAgnoEscolar
End if 
  //$vt_glosa:=$1
  //$vb_afecto:=$2
  //$vb_esDescuento:=$3
  //$vt_moneda:=$4
  //$vr_monto:=$5
  //$vt_ctaContable:=$6
  //$vt_ctaAuxiliar:=$7
  //$vt_centroCosto:=$8
  //$vt_cctaContable:=$9
  //$vt_cctaAuxiliar:=$10
  //$vt_ccentroCosto:=$11
  //$vb_noIncluirDT:=$12
  //$vt_obs:=$13
  //$vb_impUnica:=$14
  //$vb_afectoDctoInd:=$15
  //$vb_afectoDcto:=$16
  //$vb_afectoInteres:=$17
  //$vr_tasaInteres:=$18
  //$vb_tipoInteres:=$19
  //$vt_nomArrDctoNoHijo:=$20
  //$vl_indiceArray:=$21
  //ACTitem_CreateRecord ($vt_glosa;$vb_afecto;$vb_esDescuento;$vt_moneda;$vr_monto;$vt_ctaContable;$vt_ctaAuxiliar;$vt_centroCosto;$vt_cctaContable;$vt_cctaAuxiliar;$vt_ccentroCosto;$vb_noIncluirDT;$vt_obs;$vb_impUnica;$vb_afectoDctoInd;$vb_afectoDcto;$vb_afectoInteres;$vr_tasaInteres;$vb_tipoInteres;$vt_nomArrDctoNoHijo;$vl_indiceArray)

READ WRITE:C146([xxACT_Items:179])

CREATE RECORD:C68([xxACT_Items:179])
[xxACT_Items:179]ID:1:=SQ_SeqNumber (->[xxACT_Items:179]ID:1)
[xxACT_Items:179]Glosa:2:=$vt_glosa
If (USR_GetUserID >0)  //20150912 RCH Para dtenet
	[xxACT_Items:179]Glosa:2:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233([xxACT_Items:179]Glosa:2;"(";"[");")";"]");"/";"_");"\\";"_")
End if 
[xxACT_Items:179]Glosa_de_Impresión:20:=[xxACT_Items:179]Glosa:2
[xxACT_Items:179]Afecto_IVA:12:=$vb_afecto
[xxACT_Items:179]EsDescuento:6:=$vb_esDescuento
[xxACT_Items:179]Moneda:10:=$vt_moneda
[xxACT_Items:179]Monto:7:=$vr_monto
[xxACT_Items:179]No_de_Cuenta_Contable:15:=$vt_ctaContable
[xxACT_Items:179]CodAuxCta:27:=$vt_ctaAuxiliar
[xxACT_Items:179]Centro_de_Costos:21:=$vt_centroCosto
[xxACT_Items:179]No_CCta_contable:22:=$vt_cctaContable
[xxACT_Items:179]CodAuxCCta:28:=$vt_cctaAuxiliar
[xxACT_Items:179]CCentro_de_costos:23:=$vt_ccentroCosto
[xxACT_Items:179]No_incluir_en_DocTributario:31:=$vb_noIncluirDT
[xxACT_Items:179]Observaciones:11:=$vt_obs
[xxACT_Items:179]Imputacion_Unica:24:=$vb_impUnica
[xxACT_Items:179]AfectoDsctoIndividual:17:=$vb_afectoDctoInd
[xxACT_Items:179]Afecto_a_descuentos:4:=$vb_afectoDcto
[xxACT_Items:179]AfectoInteres:26:=$vb_afectoInteres
[xxACT_Items:179]TasaInteresMensual:25:=$vr_tasaInteres
[xxACT_Items:179]TipoInteres:29:=$vb_tipoInteres
[xxACT_Items:179]Periodo:42:=$t_periodo
[xxACT_Items:179]ID_RazonSocial:36:=$r_idRS
If ([xxACT_Items:179]ID_RazonSocial:36#0)
	[xxACT_Items:179]RazonSocialAsociada:35:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->[xxACT_Items:179]ID_RazonSocial:36;->[ACT_RazonesSociales:279]razon_social:2)
End if 

For ($xx;2;17)
	$varPtr:=Get pointer:C304("vr_Hijo"+String:C10($xx))
	If ($vt_nomArrDctoNoHijo#"")
		$arrayPtr:=Get pointer:C304($vt_nomArrDctoNoHijo+String:C10($xx))
		If (($vl_indiceArray>0) & ($vl_indiceArray<=Size of array:C274($arrayPtr->)))
			$varPtr->:=Num:C11($arrayPtr->{$i})
		Else 
			$varPtr->:=0
		End if 
	Else 
		$varPtr->:=0
	End if 
End for 
BLOB_Variables2Blob (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
SAVE RECORD:C53([xxACT_Items:179])

$0:=[xxACT_Items:179]ID:1

KRL_UnloadReadOnly (->[xxACT_Items:179])