//%attributes = {}
  // ACTAS_GuardaObjeto()
  // Por: Alberto Bachler K.: 26-02-14, 09:21:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_tablaEnLectura)
C_LONGINT:C283($l_recNum)
C_POINTER:C301($y_Blob;$y_Tabla)
C_OBJECT:C1216($oo_ObjetoActa)

$y_Blob:=$1
$l_recNum:=$2
$y_Tabla:=Table:C252(Table:C252($y_Blob))

OB SET ARRAY:C1227($oo_ObjetoActa;"Numeros_Columnas";alActas_ColumnNumber)
OB SET ARRAY:C1227($oo_ObjetoActa;"Subsectores";atActas_Subsectores)
OB SET ARRAY:C1227($oo_ObjetoActa;"atActas_SubsectoresCertif";atActas_SubsectoresCertif)

OB SET:C1220($oo_ObjetoActa;"vs_ActaTitle";vs_ActaTitle)
OB SET:C1220($oo_ObjetoActa;"vs_ActaSubTitle";vs_ActaSubTitle)
OB SET:C1220($oo_ObjetoActa;"vt_Menciones";vt_Menciones)
OB SET:C1220($oo_ObjetoActa;"vRespName";vRespName)
OB SET:C1220($oo_ObjetoActa;"vt_obsPg1";vt_obsPg1)
OB SET:C1220($oo_ObjetoActa;"vt_ObsPg2";vt_ObsPg2)
OB SET:C1220($oo_ObjetoActa;"vs_PromoAbs";vs_PromoAbs)
OB SET:C1220($oo_ObjetoActa;"vs_BirthDateFormat";vs_BirthDateFormat)
OB SET:C1220($oo_ObjetoActa;"vs_PCtext";vs_PCtext)
OB SET:C1220($oo_ObjetoActa;"vs_PEtext";vs_PEtext)
OB SET:C1220($oo_ObjetoActa;"vs_NoReligion";vs_NoReligion)
OB SET:C1220($oo_ObjetoActa;"vs_AbrNoReligion";vs_AbrNoReligion)
OB SET:C1220($oo_ObjetoActa;"vs_actaFont";vs_actaFont)
OB SET:C1220($oo_ObjetoActa;"vs_PromoAnticipada";vs_PromoAnticipada)
OB SET:C1220($oo_ObjetoActa;"vi_columns";vi_columns)
OB SET:C1220($oo_ObjetoActa;"vi_PCStart";vi_PCStart)
OB SET:C1220($oo_ObjetoActa;"vi_PEStart";vi_PEStart)
OB SET:C1220($oo_ObjetoActa;"vi_PCEnd";vi_PCEnd)
OB SET:C1220($oo_ObjetoActa;"vi_PEEnd";vi_PEEnd)
OB SET:C1220($oo_ObjetoActa;"vi_UppercaseNames";vi_UppercaseNames)
OB SET:C1220($oo_ObjetoActa;"vi_noCalculations";vi_noCalculations)
OB SET:C1220($oo_ObjetoActa;"vi_PrintCodes";vi_PrintCodes)  //
OB SET:C1220($oo_ObjetoActa;"vi_autoPromo";vi_autoPromo)
OB SET:C1220($oo_ObjetoActa;"vi_EtiquetasEnAltas";vi_EtiquetasEnAltas)  //
OB SET:C1220($oo_ObjetoActa;"vi_ImprimeObsActas";vi_ImprimeObsActas)  //
OB SET:C1220($oo_ObjetoActa;"vi_PrintEvaluadas";vi_PrintEvaluadas)  //
OB SET:C1220($oo_ObjetoActa;"vi_FirmaDirectorColegio";vi_FirmaDirectorColegio)  //
OB SET:C1220($oo_ObjetoActa;"vi_FirmaDirectorNivel";vi_FirmaDirectorNivel)  //

OB SET:C1220($oo_ObjetoActa;"vCert1";vCert1)
OB SET:C1220($oo_ObjetoActa;"vFont1";vFont1)
OB SET:C1220($oo_ObjetoActa;"vSize1";vSize1)
OB SET:C1220($oo_ObjetoActa;"vStyle1";vStyle1)
OB SET:C1220($oo_ObjetoActa;"vCert2";vCert2)
OB SET:C1220($oo_ObjetoActa;"vFont2";vFont2)
OB SET:C1220($oo_ObjetoActa;"vSize2";vSize2)
OB SET:C1220($oo_ObjetoActa;"vStyle2";vStyle2)
OB SET:C1220($oo_ObjetoActa;"vCert3";vCert3)
OB SET:C1220($oo_ObjetoActa;"vFont3";vFont3)
OB SET:C1220($oo_ObjetoActa;"vSize3";vSize3)
OB SET:C1220($oo_ObjetoActa;"vStyle3";vStyle3)
OB SET:C1220($oo_ObjetoActa;"vCert4";vCert4)
OB SET:C1220($oo_ObjetoActa;"vFont4";vFont4)
OB SET:C1220($oo_ObjetoActa;"vSize4";vSize4)
OB SET:C1220($oo_ObjetoActa;"vStyle4";vStyle4)
OB SET:C1220($oo_ObjetoActa;"vCert5";vCert5)
OB SET:C1220($oo_ObjetoActa;"vFont5";vFont5)
OB SET:C1220($oo_ObjetoActa;"vSize5";vSize5)
OB SET:C1220($oo_ObjetoActa;"vStyle5";vStyle5)
OB SET:C1220($oo_ObjetoActa;"vCert6";vCert6)
OB SET:C1220($oo_ObjetoActa;"vFont6";vFont6)
OB SET:C1220($oo_ObjetoActa;"vSize6";vSize6)
OB SET:C1220($oo_ObjetoActa;"vStyle6";vStyle6)
OB SET:C1220($oo_ObjetoActa;"vi_PrintHeadName";vi_PrintHeadName)
OB SET:C1220($oo_ObjetoActa;"vtSTR_TextoPromocion";vtSTR_TextoPromocion)
OB SET:C1220($oo_ObjetoActa;"vtSTR_TextoRepitencia";vtSTR_TextoRepitencia)

$b_tablaEnLectura:=Read only state:C362($y_Tabla->)
KRL_GotoRecord ($y_Tabla;$l_recNum;True:C214)
SET BLOB SIZE:C606($y_Blob->;0)
Case of 
	: ($y_Tabla=->[xxSTR_Niveles:6])
		[xxSTR_Niveles:6]Auto_UUID:51:=[xxSTR_Niveles:6]Auto_UUID:51
End case 
OB_ObjectToBlob (->$oo_ObjetoActa;$y_Blob)
SAVE RECORD:C53($y_Tabla->)
KRL_ResetPreviousRWMode ($y_Tabla;$b_tablaEnLectura)