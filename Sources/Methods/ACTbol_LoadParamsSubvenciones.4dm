//%attributes = {}
  //ACTbol_LoadParamsSubvenciones

C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)

ACTcfgbol_InitVarsSub ("declaraVars")

BLOB_Variables2Blob (->xBlob;0;->cs_0102;->cs_0103;->cs_0104;->cs_0105;->cs_0106;->cs_0107;->cs_0108;->cs_0109;->cs_0110;->cs_0111;->cs_0112;->vt_obsCompletoSBeca;->vt_obsCompletoCBeca)
xBlob:=PREF_fGetBlob (0;"PreferenciasImpresionBoletasCompleto";xBlob)
BLOB_Blob2Vars (->xBlob;0;->cs_0102;->cs_0103;->cs_0104;->cs_0105;->cs_0106;->cs_0107;->cs_0108;->cs_0109;->cs_0110;->cs_0111;->cs_0112;->vt_obsCompletoSBeca;->vt_obsCompletoCBeca)
SET BLOB SIZE:C606(xBlob;0)

BLOB_Variables2Blob (->xBlob;0;->cs_0201;->cs_0202;->cs_0203;->cs_0204;->cs_0205;->cs_0206;->cs_0207;->cs_0208;->cs_0209;->cs_0210;->cs_0211;->cs_0212;->cs_0213;->vt_obsAbonoSBeca;->vt_obsAbonoCBeca)
xBlob:=PREF_fGetBlob (0;"PreferenciasImpresionBoletasAbono";xBlob)
BLOB_Blob2Vars (->xBlob;0;->cs_0201;->cs_0202;->cs_0203;->cs_0204;->cs_0205;->cs_0206;->cs_0207;->cs_0208;->cs_0209;->cs_0210;->cs_0211;->cs_0212;->cs_0213;->vt_obsAbonoSBeca;->vt_obsAbonoCBeca)
SET BLOB SIZE:C606(xBlob;0)

BLOB_Variables2Blob (->xBlob;0;->cs_0301;->cs_0302;->cs_0303;->cs_0304;->cs_0305;->cs_0306;->cs_0307;->cs_0308;->cs_0309;->cs_0310;->cs_0311;->cs_0312;->vt_obsSaldoSbeca;->vt_obsSaldoCbeca)
xBlob:=PREF_fGetBlob (0;"PreferenciasImpresionBoletasSaldo";xBlob)
BLOB_Blob2Vars (->xBlob;0;->cs_0301;->cs_0302;->cs_0303;->cs_0304;->cs_0305;->cs_0306;->cs_0307;->cs_0308;->cs_0309;->cs_0310;->cs_0311;->cs_0312;->vt_obsSaldoSbeca;->vt_obsSaldoCbeca)
SET BLOB SIZE:C606(xBlob;0)

BLOB_Variables2Blob (->xBlob;0;->cs_g01;->vt_TextoImprimir;->cs_g02;->cs_g03;->cs_g04;->vt_AgnoBoleta)
xBlob:=PREF_fGetBlob (0;"PreferenciasImpresionBoletasOtros";xBlob)
BLOB_Blob2Vars (->xBlob;0;->cs_g01;->vt_TextoImprimir;->cs_g02;->cs_g03;->cs_g04;->vt_AgnoBoleta)
SET BLOB SIZE:C606(xBlob;0)