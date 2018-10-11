//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 16-08-18, 08:36:35
  // ----------------------------------------------------
  // Método: UD_v20180816_AsistenteTransfere
  // Descripción
  // Método que actualiza nueva preferencia para usar código de autorización como texto.
  //
  // Parámetros
  // ----------------------------------------------------

ARRAY LONGINT:C221(al_Numero;0)
ARRAY TEXT:C222(at_Descripcion;0)
ARRAY LONGINT:C221(al_PosIni;0)
ARRAY LONGINT:C221(al_Largo;0)
ARRAY LONGINT:C221(al_PosFinal;0)
ARRAY TEXT:C222(at_Alineado;0)
ARRAY TEXT:C222(at_Relleno;0)
ARRAY LONGINT:C221(al_Decimales;0)
ARRAY TEXT:C222(at_idsTextos;0)

C_LONGINT:C283(PWTrf_h2;PWTrf_h1;WTrf_s1;WTrf_s2)
C_LONGINT:C283(WTrf_s3;cs_IEncabezado;cs_IPie)
C_LONGINT:C283(WTrf_s4)
C_TEXT:C284(WTrf_s4_CaracterOtro)
C_TEXT:C284(vIIdentificador;vt_ICodApr)
C_REAL:C285(cs_usarComoTexto)  //20180816 RCH

ARRAY LONGINT:C221($al_recNums;0)
C_LONGINT:C283($l_indice)

If (<>gCountryCode="mx")
	cs_usarComoTexto:=1
End if 

READ WRITE:C146([xxACT_ArchivosBancarios:118])

QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=True:C214;*)
QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]ImpExp:5=True:C214)

LONGINT ARRAY FROM SELECTION:C647([xxACT_ArchivosBancarios:118];$al_recNums;"")

For ($l_indice;1;Size of array:C274($al_recNums))
	KRL_GotoRecord (->[xxACT_ArchivosBancarios:118];$al_recNums{$l_indice};True:C214)
	If (ok=1)
		BLOB_Blob2Vars (->[xxACT_ArchivosBancarios:118]xData:2;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro)
		BLOB_Variables2Blob (->[xxACT_ArchivosBancarios:118]xData:2;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro;->cs_usarComoTexto)  //20180816 RCH
		SAVE RECORD:C53([xxACT_ArchivosBancarios:118])
		LOG_RegisterEvt ("El registro de archivo bancario id: "+String:C10([xxACT_ArchivosBancarios:118]ID:1)+", nombre: "+[xxACT_ArchivosBancarios:118]Nombre:3+" fue actualizado.")
	Else 
		LOG_RegisterEvt ("El registro de archivo bancario id: "+String:C10([xxACT_ArchivosBancarios:118]ID:1)+", nombre: "+[xxACT_ArchivosBancarios:118]Nombre:3+" no pudo ser actualizado.")
	End if 
End for 
KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])