//%attributes = {}
  //SRACTlc_CargaDatos

  //SRACTbol_CargaCargos
C_LONGINT:C283($1;$lc)
C_POINTER:C301($varPtr)

READ ONLY:C145([Personas:7])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Familia:78])
READ ONLY:C145([ACT_Documentos_de_Pago:176])

ARRAY TEXT:C222($aMesesText;0)
COPY ARRAY:C226(<>atXS_MonthNames;$aMesesText)
ARRAY TEXT:C222($at_indiceLetras;0)

$lc:=1
If (Count parameters:C259=1)
	$lc:=$1
End if 

SRACTlc_InitiPrintingVariables (3;$lc)

$varPtr:=Get pointer:C304("vlACT_SRlc_Folio"+String:C10($lc))
$varPtr->:=Num:C11([ACT_Documentos_de_Pago:176]NoSerie:12)
$varPtr:=Get pointer:C304("vdACT_SRlc_fEmision"+String:C10($lc))
$varPtr->:=[ACT_Documentos_de_Pago:176]Fecha:13
$varPtr:=Get pointer:C304("vlACT_SRlc_dEmision"+String:C10($lc))
$varPtr->:=Day of:C23([ACT_Documentos_de_Pago:176]Fecha:13)
$varPtr:=Get pointer:C304("vlACT_SRlc_mEmision"+String:C10($lc))
$varPtr->:=Month of:C24([ACT_Documentos_de_Pago:176]Fecha:13)
$varPtr:=Get pointer:C304("vtACT_SRlc_mTEmision"+String:C10($lc))
$varPtr->:=$aMesesText{Month of:C24([ACT_Documentos_de_Pago:176]Fecha:13)}
$varPtr:=Get pointer:C304("vlACT_SRlc_aEmision"+String:C10($lc))
$varPtr->:=Year of:C25([ACT_Documentos_de_Pago:176]Fecha:13)
$varPtr:=Get pointer:C304("vdACT_SRlc_fVencimiento"+String:C10($lc))
$varPtr->:=[ACT_Documentos_de_Pago:176]FechaVencimiento:27
$varPtr:=Get pointer:C304("vlACT_SRlc_dVEncimiento"+String:C10($lc))
$varPtr->:=Day of:C23([ACT_Documentos_de_Pago:176]FechaVencimiento:27)
$varPtr:=Get pointer:C304("vlACT_SRlc_mVencimiento"+String:C10($lc))
$varPtr->:=Month of:C24([ACT_Documentos_de_Pago:176]FechaVencimiento:27)
$varPtr:=Get pointer:C304("vtACT_SRlc_mTVencimiento"+String:C10($lc))
$varPtr->:=$aMesesText{Month of:C24([ACT_Documentos_de_Pago:176]FechaVencimiento:27)}
$varPtr:=Get pointer:C304("vlACT_SRlc_aVencimiento"+String:C10($lc))
$varPtr->:=Year of:C25([ACT_Documentos_de_Pago:176]FechaVencimiento:27)
$varPtr:=Get pointer:C304("vlACT_SRlc_noLetra"+String:C10($lc))
AT_Text2Array (->$at_indiceLetras;[ACT_Documentos_de_Pago:176]L_Indice:29;";")
If (Size of array:C274($at_indiceLetras)=2)
	$varPtr->:=Num:C11($at_indiceLetras{1})
Else 
	$varPtr->:=0
End if 
$varPtr:=Get pointer:C304("vlACT_SRlc_noTLetra"+String:C10($lc))
If (Size of array:C274($at_indiceLetras)=2)
	$varPtr->:=Num:C11($at_indiceLetras{2})
Else 
	$varPtr->:=0
End if 
$varPtr:=Get pointer:C304("vlACT_SRlc_mPesosLetra"+String:C10($lc))
$varPtr->:=[ACT_Documentos_de_Pago:176]MontoPago:6
$varPtr:=Get pointer:C304("vtACT_SRlc_mPalabraLetra"+String:C10($lc))
$varPtr->:=ST_Num2Text2 ([ACT_Documentos_de_Pago:176]MontoPago:6;"Spanish")

QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Documentos_de_Pago:176]ID_Apoderado:2)
$varPtr:=Get pointer:C304("vtACT_SRlc_apeNom"+String:C10($lc))
$varPtr->:=[Personas:7]Apellidos_y_nombres:30
$varPtr:=Get pointer:C304("vtACT_SRlc_ideUnico"+String:C10($lc))
$varPtr->:=[Personas:7]RUT:6
$varPtr:=Get pointer:C304("vtACT_SRlc_domicilio"+String:C10($lc))
$varPtr->:=[Personas:7]ACT_DireccionEC:67
$varPtr:=Get pointer:C304("vtACT_SRlc_comuna"+String:C10($lc))
$varPtr->:=[Personas:7]ACT_ComunaEC:68
$varPtr:=Get pointer:C304("vtACT_SRlc_ciudad"+String:C10($lc))
$varPtr->:=[Personas:7]ACT_CiudadEC:69

QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
$varPtr:=Get pointer:C304("vtACT_SRlc_codFamilia"+String:C10($lc))
$varPtr->:=[Familia:78]Codigo_interno:14