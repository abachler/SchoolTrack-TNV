//%attributes = {}
  //ACTbol_InitVariablesPrintSub

C_REAL:C285(v_2NombreMesP;v_2MontoP;v_2MontoPP;v_3MontoP;v_4MontoMensualP;v_4MontoTotalP;v_4MontoMensualNoVecesP;v_4MontosSeparadosP;v_4RepiteMonto1EnMonto2P;v_4MontoColegiaturaLinea2P)
C_REAL:C285(v_2AbonoA;v_2NombreMesA;v_2MontoA;v_2MontoPA;v_3MontoA;v_4MontoMensualA;v_4MontoTotalA;v_4MontoMensualNoVecesA;v_4MontosSeparadosA;v_4RepiteMonto1EnMonto2A;v_4MontoColegiaturaLinea2A;v_5ImprimeAbonoA)
C_REAL:C285(v_2SaldoS;v_2NombreMesS;v_2MontoS;v_2MontoPS;v_3MontoS;v_4MontoMensualS;v_4MontoTotalS;v_4MontoMensualNoVecesS;v_4MontosSeparadosS;v_4RepiteMonto1EnMonto2S;v_4MontoColegiaturaLinea2S)
C_LONGINT:C283(v_ImprimeObsC;v_ImprimeObsA;v_ImprimeObsS)  //observaciones pagos
C_TEXT:C284(vt_obsCompletoSBeca;vt_obsCompletoCBeca;vt_obsAbonoSBeca;vt_obsAbonoCBeca;vt_obsSaldoSbeca;vt_obsSaldoCbeca)  //observaciones pagos
C_REAL:C285(vb_ImprimeTexto)
C_TEXT:C284(textoAImprimir;vt_AgnoBoleta)
C_REAL:C285(v_GSumarP;v_GSumarA;v_GSumarS)

C_REAL:C285(vr_MontoBoleta)
C_REAL:C285(vr_MontoMensual)
C_REAL:C285(NoBoleta)
C_REAL:C285(vr_Abono)
C_TEXT:C284(vt_MontoBoletaPalabras)
C_TEXT:C284(vt_DiaBol)
C_TEXT:C284(vt_MesAgnoBol)

C_TEXT:C284(vt_Mes)
C_TEXT:C284(vt_MontoMensual)
C_TEXT:C284(vt_Becas)
C_REAL:C285(vr_Becas)

C_TEXT:C284(vt_CategoriaNombre1;vt_CategoriaNombre2;vt_CategoriaNombre3;vt_CategoriaNombre4;vt_CategoriaNombre5)
C_REAL:C285(vr_CategoriaMonto1;vr_CategoriaMonto2;vr_CategoriaMonto3;vr_CategoriaMonto4;vr_CategoriaMonto5)

C_TEXT:C284(vt_Becas2;vt_Becas)
vt_Becas2:=""
vt_Becas:=""

C_REAL:C285(vr_MontoPagadoCol)
vr_MontoPagadoCol:=0

ARRAY TEXT:C222(at_Periodo;0)
ARRAY LONGINT:C221(al_MontoMensualTemp;0)

vt_Mes:=""
vt_MontoMensual:=""
vt_Becas:=""
vr_Becas:=0

vr_MontoBoleta:=0
vr_MontoMensual:=0
NoBoleta:=0
vr_Abono:=0
vt_MontoBoletaPalabras:=""
vt_DiaBol:=""
vt_MesAgnoBol:=""