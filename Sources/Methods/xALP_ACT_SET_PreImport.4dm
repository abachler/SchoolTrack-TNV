//%attributes = {}
  //xALP_ACT_SET_PreImport

C_LONGINT:C283($err)

ARRAY TEXT:C222($aHeaders;44)
AT_Inc (0)
$aHeaders{AT_Inc }:="Identificador"  //1
$aHeaders{AT_Inc }:="ID Item"  //2
$aHeaders{AT_Inc }:="Glosa"  //3
$aHeaders{AT_Inc }:="Moneda"  //4
$aHeaders{AT_Inc }:="Monto"  //5
$aHeaders{AT_Inc }:="Afecto a IVA"  //6
$aHeaders{AT_Inc }:="Mes Desde"  //7
$aHeaders{AT_Inc }:="Año Desde"  //8
$aHeaders{AT_Inc }:="Mes Hasta"  //9
$aHeaders{AT_Inc }:="Año Hasta"  //10
$aHeaders{AT_Inc }:="Cargo/Descto"  //11
$aHeaders{AT_Inc }:="Cta. Contable"  //12
$aHeaders{AT_Inc }:="Cod. Auxiliar"  //13
$aHeaders{AT_Inc }:="Centro de\rCostos"  //14
$aHeaders{AT_Inc }:="Contra Cta.\rContable"  //15
$aHeaders{AT_Inc }:="Contra\rCod. Auxiliar"  //16
$aHeaders{AT_Inc }:="Contra Centro\rde Costos"  //17
$aHeaders{AT_Inc }:="No Incluir en\rDoc. Tribs"  //18
$aHeaders{AT_Inc }:="Afecto a Desctos\rpor Cta."  //19
$aHeaders{AT_Inc }:="Afecto a Desctos\r o Cargos"  //20
$aHeaders{AT_Inc }:="Porcentaje de\rInterés"  //21
$aHeaders{AT_Inc }:="Tipo de Interés"  //22
$aHeaders{AT_Inc }:="Imputación Unica"  //23
$aHeaders{AT_Inc }:="Descto.\rHijo 2"  //24
$aHeaders{AT_Inc }:="Descto.\rHijo 3"  //25
$aHeaders{AT_Inc }:="Descto.\rHijo 4"  //26
$aHeaders{AT_Inc }:="Descto.\rHijo 5"  //27
$aHeaders{AT_Inc }:="Descto.\rHijo 6"  //28
$aHeaders{AT_Inc }:="Descto.\rHijo 7"  //29
$aHeaders{AT_Inc }:="Descto.\rHijo 8"  //30
$aHeaders{AT_Inc }:="Descto.\rHijo 9"  //31
$aHeaders{AT_Inc }:="Descto.\rHijo 10"  //32
$aHeaders{AT_Inc }:="Descto.\rHijo 11"  //33
$aHeaders{AT_Inc }:="Descto.\rHijo 12"  //34
$aHeaders{AT_Inc }:="Descto.\rHijo 13"  //35
$aHeaders{AT_Inc }:="Descto.\rHijo 14"  //36
$aHeaders{AT_Inc }:="Descto.\rHijo 15"  //37
$aHeaders{AT_Inc }:="Descto.\rHijo 16"  //38
$aHeaders{AT_Inc }:="Descto.\rHijo 17"  //39
$aHeaders{AT_Inc }:="Motivo"  //40
$aHeaders{AT_Inc }:="Aprobado"  //41
$aHeaders{AT_Inc }:="IDCta"  //42
$aHeaders{AT_Inc }:="Codigo Interno"  //43
$aHeaders{AT_Inc }:="Bloqueadas"  //44
AT_Inc (0)
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aPareo")  //1 
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aIDItem")  //2
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aGlosa")  //3
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aMoneda")  //4
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aMontotxt")  //5
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aAfectoIVA")  //6
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aMesDesde")  //7
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aAño")  //8
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aMesHasta")  //9
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aAño2")  //10
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aCargoDescto")  //11
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aCtaContable")  //12
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aCodAux")  //13
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aCentro")  //14
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aCCtaContable")  //15
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aCCodAux")  //16
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aCCentro")  //17
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aNoDocTribs")  //18
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aAfectoaDxCta")  //19
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aAfectoaDesctos")  //20
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aPctInteres")  //21
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aTipoInteres")  //22
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aImpUnica")  //23
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH2")  //24
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH3")  //25
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH4")  //26
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH5")  //27
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH6")  //28
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH7")  //29
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH8")  //30
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH9")  //31
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH10")  //32
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH11")  //33
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH12")  //34
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH13")  //35
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH14")  //36
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH15")  //37
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH16")  //38
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aDesctoH17")  //39
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aMotivo")  //40
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aAprobado")  //41
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aIDCta")  //42
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"Codigo Interno")  //43
$err:=AL_SetArraysNam (xALP_PreImport;AT_Inc ;1;"aBloqueadas")  //44

For ($u;1;Size of array:C274($aHeaders))
	AL_SetHeaders (xALP_PreImport;$u;1;$aHeaders{$u})
	AL_SetFormat (xALP_PreImport;$u;"";0;2;0;0)
	AL_SetHdrStyle (xALP_PreImport;$u;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_PreImport;$u;"Tahoma";9;0)
	AL_SetStyle (xALP_PreImport;$u;"Tahoma";9;0)
	AL_SetForeColor (xALP_PreImport;$u;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_PreImport;$u;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_PreImport;$u;1)
	AL_SetEntryCtls (xALP_PreImport;$u;0)
End for 
AL_SetEnterable (xALP_PreImport;4;2;atACT_NombreMoneda)
AL_SetEnterable (xALP_PreImport;11;0)

  //general options
ALP_SetDefaultAppareance (xALP_PreImport;9;1;6;2;8)
AL_SetColOpts (xALP_PreImport;1;1;1;4;0)
AL_SetRowOpts (xALP_PreImport;0;1;0;0;1;0)
AL_SetCellOpts (xALP_PreImport;0;1;1)
AL_SetMainCalls (xALP_PreImport;"";"")
AL_SetCallbacks (xALP_PreImport;"";"xALP_ACT_CB_ImportCargos")
AL_SetScroll (xALP_PreImport;0;0)
AL_SetEntryOpts (xALP_PreImport;5;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
AL_SetDrgOpts (xALP_PreImport;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_PreImport;1;"";"";"")
AL_SetDrgSrc (xALP_PreImport;2;"";"";"")
AL_SetDrgSrc (xALP_PreImport;3;"";"";"")
AL_SetDrgDst (xALP_PreImport;1;"";"";"")
AL_SetDrgDst (xALP_PreImport;1;"";"";"")
AL_SetDrgDst (xALP_PreImport;1;"";"";"")