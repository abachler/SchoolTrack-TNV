//%attributes = {}
  //ACTcfgbol_InitVarsSub

C_TEXT:C284($1;$accion)
If (Count parameters:C259=1)
	$accion:=$1
End if 
Case of 
	: ($accion="declaraVars")
		C_LONGINT:C283(cs_0102;cs_0103;cs_0104;cs_0105;cs_0106;cs_0107;cs_0108;cs_0109;cs_0110;cs_0111;cs_0112)
		C_TEXT:C284(vt_obsCompletoSBeca;vt_obsCompletoCBeca)
		
		C_LONGINT:C283(cs_0201;cs_0202;cs_0203;cs_0204;cs_0205;cs_0206;cs_0207;cs_0208;cs_0209;cs_0210;cs_0211;cs_0212;cs_0213)
		C_TEXT:C284(vt_obsAbonoSBeca;vt_obsAbonoCBeca)
		
		C_LONGINT:C283(cs_0301;cs_0302;cs_0303;cs_0304;cs_0305;cs_0306;cs_0307;cs_0308;cs_0309;cs_0310;cs_0311;cs_0312)
		C_TEXT:C284(vt_obsSaldoSbeca;vt_obsSaldoCbeca)
		
		C_LONGINT:C283(cs_g01;cs_g02;cs_g03;cs_g04)
		C_TEXT:C284(vt_TextoImprimir;vt_AgnoBoleta)
	: ($accion="inicializaVars")
		cs_0102:=0
		cs_0103:=0
		cs_0104:=0
		cs_0105:=0
		cs_0106:=0
		cs_0107:=0
		cs_0108:=0
		cs_0109:=0
		cs_0110:=0
		cs_0111:=0
		cs_0112:=0
		vt_obsCompletoSBeca:=""
		vt_obsCompletoCBeca:=""
		cs_0201:=0
		cs_0202:=0
		cs_0203:=0
		cs_0204:=0
		cs_0205:=0
		cs_0206:=0
		cs_0207:=0
		cs_0208:=0
		cs_0209:=0
		cs_0210:=0
		cs_0211:=0
		cs_0212:=0
		cs_0213:=0
		vt_obsAbonoSBeca:=""
		vt_obsAbonoCBeca:=""
		cs_0301:=0
		cs_0302:=0
		cs_0303:=0
		cs_0304:=0
		cs_0305:=0
		cs_0306:=0
		cs_0307:=0
		cs_0308:=0
		cs_0309:=0
		cs_0310:=0
		cs_0311:=0
		cs_0312:=0
		vt_obsSaldoSbeca:=""
		vt_obsSaldoCbeca:=""
		cs_g01:=0
		cs_g02:=0
		cs_g03:=0
		cs_g04:=0
		vt_TextoImprimir:=""
		vt_AgnoBoleta:=""
		
	: ($accion="inicializaBlob")
		ACTcfgbol_InitVarsSub ("declaraVars")
		ACTcfgbol_InitVarsSub ("inicializaVars")
		ACTbol_SaveParamsSubvenciones 
		
	: ($accion="borraPrefs")
		READ WRITE:C146([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
		QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]Reference:1="PreferenciasImpresionBoletasCompleto")
		DELETE SELECTION:C66([xShell_Prefs:46])
		
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
		QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]Reference:1="PreferenciasImpresionBoletasAbono")
		DELETE SELECTION:C66([xShell_Prefs:46])
		
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
		QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]Reference:1="PreferenciasImpresionBoletasSaldo")
		DELETE SELECTION:C66([xShell_Prefs:46])
		
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
		QUERY:C277([xShell_Prefs:46]; & ;[xShell_Prefs:46]Reference:1="PreferenciasImpresionBoletasOtros")
		DELETE SELECTION:C66([xShell_Prefs:46])
		KRL_UnloadReadOnly (->[xShell_Prefs:46])
End case 