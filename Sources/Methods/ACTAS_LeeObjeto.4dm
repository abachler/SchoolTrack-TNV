//%attributes = {}
  // ACTAS_LeeObjeto()
  // Por: Alberto Bachler K.: 26-02-14, 09:58:47
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_recNum;$l_recNumNivel)
C_POINTER:C301($y_Blob;$y_tabla)
C_OBJECT:C1216($oo_ObjetoActa)


If (False:C215)
	C_POINTER:C301(ACTAS_LeeObjeto ;$1)
	C_LONGINT:C283(ACTAS_LeeObjeto ;$2)
End if 

$y_Blob:=$1
$l_recNum:=$2

If (($l_recNum>No current record:K29:2) & (Not:C34(Is nil pointer:C315($y_Blob))))
	$y_tabla:=Table:C252(Table:C252($y_Blob))
	If ($l_recNum#Record number:C243($y_tabla->))
		KRL_GotoRecord ($y_tabla;$l_recNum)
	End if 
	
	ACTAS_Initialize 
	OB_BlobToObject ($y_Blob;->$oo_ObjetoActa)
	
	OB GET ARRAY:C1229($oo_ObjetoActa;"Numeros_Columnas";alActas_ColumnNumber)
	OB GET ARRAY:C1229($oo_ObjetoActa;"Subsectores";atActas_Subsectores)
	OB GET ARRAY:C1229($oo_ObjetoActa;"atActas_SubsectoresCertif";atActas_SubsectoresCertif)
	
	vs_ActaTitle:=OB Get:C1224($oo_ObjetoActa;"vs_ActaTitle")
	vs_ActaSubTitle:=OB Get:C1224($oo_ObjetoActa;"vs_ActaSubTitle")
	vt_Menciones:=OB Get:C1224($oo_ObjetoActa;"vt_Menciones")
	vRespName:=OB Get:C1224($oo_ObjetoActa;"vRespName")
	vt_obsPg1:=OB Get:C1224($oo_ObjetoActa;"vt_obsPg1")
	vt_ObsPg2:=OB Get:C1224($oo_ObjetoActa;"vt_ObsPg2")
	vs_PromoAbs:=OB Get:C1224($oo_ObjetoActa;"vs_PromoAbs")
	vs_BirthDateFormat:=OB Get:C1224($oo_ObjetoActa;"vs_BirthDateFormat")
	vs_PCtext:=OB Get:C1224($oo_ObjetoActa;"vs_PCtext")
	vs_PEtext:=OB Get:C1224($oo_ObjetoActa;"vs_PEtext")
	vs_NoReligion:=OB Get:C1224($oo_ObjetoActa;"vs_NoReligion")
	vs_AbrNoReligion:=OB Get:C1224($oo_ObjetoActa;"vs_AbrNoReligion")
	vs_actaFont:=OB Get:C1224($oo_ObjetoActa;"vs_actaFont")
	vs_PromoAnticipada:=OB Get:C1224($oo_ObjetoActa;"vs_PromoAnticipada")
	vi_columns:=OB Get:C1224($oo_ObjetoActa;"vi_columns")
	vi_PCStart:=OB Get:C1224($oo_ObjetoActa;"vi_PCStart")
	vi_PEStart:=OB Get:C1224($oo_ObjetoActa;"vi_PEStart")
	vi_PCEnd:=OB Get:C1224($oo_ObjetoActa;"vi_PCEnd")
	vi_PEEnd:=OB Get:C1224($oo_ObjetoActa;"vi_PEEnd")
	vi_UppercaseNames:=OB Get:C1224($oo_ObjetoActa;"vi_UppercaseNames")
	vi_noCalculations:=OB Get:C1224($oo_ObjetoActa;"vi_noCalculations")
	vi_PrintCodes:=OB Get:C1224($oo_ObjetoActa;"vi_PrintCodes")
	vi_autoPromo:=OB Get:C1224($oo_ObjetoActa;"vi_autoPromo")
	vi_EtiquetasEnAltas:=OB Get:C1224($oo_ObjetoActa;"vi_EtiquetasEnAltas")
	vi_FirmaDirectorNivel:=OB Get:C1224($oo_ObjetoActa;"vi_FirmaDirectorNivel")
	vi_FirmaDirectorColegio:=OB Get:C1224($oo_ObjetoActa;"vi_FirmaDirectorColegio")
	vi_ImprimeObsActas:=OB Get:C1224($oo_ObjetoActa;"vi_ImprimeObsActas")
	vi_PrintEvaluadas:=OB Get:C1224($oo_ObjetoActa;"vi_PrintEvaluadas")
	
	
	vCert1:=OB Get:C1224($oo_ObjetoActa;"vCert1")
	vFont1:=OB Get:C1224($oo_ObjetoActa;"vFont1")
	vSize1:=OB Get:C1224($oo_ObjetoActa;"vSize1")
	vStyle1:=OB Get:C1224($oo_ObjetoActa;"vStyle1")
	vCert2:=OB Get:C1224($oo_ObjetoActa;"vCert2")
	vFont2:=OB Get:C1224($oo_ObjetoActa;"vFont2")
	vSize2:=OB Get:C1224($oo_ObjetoActa;"vSize2")
	vStyle2:=OB Get:C1224($oo_ObjetoActa;"vStyle2")
	vCert3:=OB Get:C1224($oo_ObjetoActa;"vCert3")
	vFont3:=OB Get:C1224($oo_ObjetoActa;"vFont3")
	vSize3:=OB Get:C1224($oo_ObjetoActa;"vSize3")
	vStyle3:=OB Get:C1224($oo_ObjetoActa;"vStyle3")
	vCert4:=OB Get:C1224($oo_ObjetoActa;"vCert4")
	vFont4:=OB Get:C1224($oo_ObjetoActa;"vFont4")
	vSize4:=OB Get:C1224($oo_ObjetoActa;"vSize4")
	vStyle4:=OB Get:C1224($oo_ObjetoActa;"vStyle4")
	vCert5:=OB Get:C1224($oo_ObjetoActa;"vCert5")
	vFont5:=OB Get:C1224($oo_ObjetoActa;"vFont5")
	vSize5:=OB Get:C1224($oo_ObjetoActa;"vSize5")
	vStyle5:=OB Get:C1224($oo_ObjetoActa;"vStyle5")
	vCert6:=OB Get:C1224($oo_ObjetoActa;"vCert6")
	vFont6:=OB Get:C1224($oo_ObjetoActa;"vFont6")
	vSize6:=OB Get:C1224($oo_ObjetoActa;"vSize6")
	vStyle6:=OB Get:C1224($oo_ObjetoActa;"vStyle6")
	vi_PrintHeadName:=OB Get:C1224($oo_ObjetoActa;"vi_PrintHeadName")
	vtSTR_TextoPromocion:=OB Get:C1224($oo_ObjetoActa;"vtSTR_TextoPromocion")
	vtSTR_TextoRepitencia:=OB Get:C1224($oo_ObjetoActa;"vtSTR_TextoRepitencia")
End if 
  //Else 
  //TRACE
  //End if 

