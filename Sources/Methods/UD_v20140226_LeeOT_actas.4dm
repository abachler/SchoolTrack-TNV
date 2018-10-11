//%attributes = {}
  // UD_v20140226_LeeOT_actas()
  // Por: Alberto Bachler K.: 26-02-14, 09:40:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($0)

C_LONGINT:C283($l_refObjeto)
C_POINTER:C301($y_blob)


If (False:C215)
	C_POINTER:C301(UD_v20140226_LeeOT_actas ;$1)
End if 

$y_blob:=$1

ACTAS_Initialize 


BLOB_ExpandBlob_byPointer ($y_blob)

$l_refObjeto:=OT BLOBToObject ($y_blob->)
If ($l_refObjeto#0)
	  //actas
	OT GetArray ($l_refObjeto;"Numeros_Columnas";alActas_ColumnNumber)
	OT GetArray ($l_refObjeto;"Subsectores";atActas_Subsectores)
	vs_ActaTitle:=OT GetText ($l_refObjeto;"vs_ActaTitle")
	vs_ActaSubTitle:=OT GetText ($l_refObjeto;"vs_ActaSubTitle")
	vt_Menciones:=OT GetText ($l_refObjeto;"vt_Menciones")
	vRespName:=OT GetText ($l_refObjeto;"vRespName")
	vt_obsPg1:=OT GetText ($l_refObjeto;"vt_obsPg1")
	vt_ObsPg2:=OT GetText ($l_refObjeto;"vt_ObsPg2")
	vs_PromoAbs:=OT GetText ($l_refObjeto;"vs_PromoAbs")
	vs_BirthDateFormat:=OT GetText ($l_refObjeto;"vs_BirthDateFormat")
	vs_PCtext:=OT GetText ($l_refObjeto;"vs_PCtext")
	vs_PEtext:=OT GetText ($l_refObjeto;"vs_PEtext")
	vs_NoReligion:=OT GetText ($l_refObjeto;"vs_NoReligion")
	vs_AbrNoReligion:=OT GetText ($l_refObjeto;"vs_AbrNoReligion")
	vs_actaFont:=OT GetText ($l_refObjeto;"vs_actaFont")
	vs_PromoAnticipada:=OT GetText ($l_refObjeto;"vs_PromoAnticipada")
	vi_columns:=OT GetLong ($l_refObjeto;"vi_columns")
	vi_PCStart:=OT GetLong ($l_refObjeto;"vi_PCStart")
	vi_PEStart:=OT GetLong ($l_refObjeto;"vi_PEStart")
	vi_PCEnd:=OT GetLong ($l_refObjeto;"vi_PCEnd")
	vi_PEEnd:=OT GetLong ($l_refObjeto;"vi_PEEnd")
	vi_UppercaseNames:=OT GetLong ($l_refObjeto;"vi_UppercaseNames")
	vi_noCalculations:=OT GetLong ($l_refObjeto;"vi_noCalculations")
	vi_PrintCodes:=OT GetLong ($l_refObjeto;"bPrintCodes")
	vi_autoPromo:=OT GetLong ($l_refObjeto;"vi_autoPromo")
	vi_EtiquetasEnAltas:=OT GetLong ($l_refObjeto;"vi_EtiquetasEnAltas")
	vi_ImprimeObsActas:=OT GetLong ($l_refObjeto;"bImprimeObsActas")
	vi_FirmaDirectorNivel:=OT GetLong ($l_refObjeto;"vi_FirmaDirectorNivel")
	vi_FirmaDirectorColegio:=OT GetLong ($l_refObjeto;"vi_FirmaDirectorColegio")
	vi_PrintEvaluadas:=OT GetLong ($l_refObjeto;"bPrintEvaluadas")
	
	  //certificados
	OT GetArray ($l_refObjeto;"atActas_SubsectoresCertif";atActas_SubsectoresCertif)
	vCert1:=OT GetText ($l_refObjeto;"vCert1")
	vFont1:=OT GetText ($l_refObjeto;"vFont1")
	vSize1:=OT GetLong ($l_refObjeto;"vSize1")
	vStyle1:=OT GetLong ($l_refObjeto;"vStyle1")
	vCert2:=OT GetText ($l_refObjeto;"vCert2")
	vFont2:=OT GetText ($l_refObjeto;"vFont2")
	vSize2:=OT GetLong ($l_refObjeto;"vSize2")
	vStyle2:=OT GetLong ($l_refObjeto;"vStyle2")
	vCert3:=OT GetText ($l_refObjeto;"vCert3")
	vFont3:=OT GetText ($l_refObjeto;"vFont3")
	vSize3:=OT GetLong ($l_refObjeto;"vSize3")
	vStyle3:=OT GetLong ($l_refObjeto;"vStyle3")
	vCert4:=OT GetText ($l_refObjeto;"vCert4")
	vFont4:=OT GetText ($l_refObjeto;"vFont4")
	vSize4:=OT GetLong ($l_refObjeto;"vSize4")
	vStyle4:=OT GetLong ($l_refObjeto;"vStyle4")
	vCert5:=OT GetText ($l_refObjeto;"vCert5")
	vFont5:=OT GetText ($l_refObjeto;"vFont5")
	vSize5:=OT GetLong ($l_refObjeto;"vSize5")
	vStyle5:=OT GetLong ($l_refObjeto;"vStyle5")
	vCert6:=OT GetText ($l_refObjeto;"vCert6")
	vFont6:=OT GetText ($l_refObjeto;"vFont6")
	vSize6:=OT GetLong ($l_refObjeto;"vSize6")
	vStyle6:=OT GetLong ($l_refObjeto;"vStyle6")
	vi_PrintHeadName:=OT GetLong ($l_refObjeto;"vi_PrintHeadName")
	vtSTR_TextoPromocion:=OT GetText ($l_refObjeto;"vtSTR_TextoPromocion")
	vtSTR_TextoRepitencia:=OT GetText ($l_refObjeto;"vtSTR_TextoRepitencia")
	
	
	OT Clear ($l_refObjeto)
Else 
	$0:=-1
End if 