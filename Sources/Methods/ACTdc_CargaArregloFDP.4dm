//%attributes = {}
  //ACTdc_CargaArregloFDP
C_TEXT:C284($t_accion)

$t_accion:=$1
Case of 
	: ($t_accion="CargaArreglos")
		ARRAY TEXT:C222(aACT_DocsReemp;0)
		ARRAY LONGINT:C221(alACT_IdFormasdePago;0)
		COPY ARRAY:C226(atACT_FormasdePago;aACT_DocsReemp)
		COPY ARRAY:C226(alACT_FormasdePagoID;alACT_IDFormasdePago)
		C_LONGINT:C283(vl_indiceFormasDePago)
		C_LONGINT:C283(vlACT_idFormaDePagoOrg)
		C_TEXT:C284(vtACT_TCNumero)
		vl_indiceFormasDePago:=4
		vlACT_idFormaDePagoOrg:=0
		AT_Insert (1;vl_indiceFormasDePago-1;->aACT_DocsReemp;->alACT_IDFormasdePago)
		aACT_DocsReemp{1}:=__ ("Mismo cheque")
		aACT_DocsReemp{2}:=__ ("Varios cheques")
		aACT_DocsReemp{3}:="(-"
		alACT_IDFormasdePago{1}:=0
		alACT_IDFormasdePago{2}:=0
		alACT_IDFormasdePago{3}:=0
End case 