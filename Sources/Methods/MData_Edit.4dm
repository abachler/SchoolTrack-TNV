//%attributes = {}
  // Método: MDATA_Edit
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 14/10/09, 11:23:22
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_POINTER:C301(vyMD_FieldPointer;$1)
C_LONGINT:C283($tableNum;$year;$2)
C_BOOLEAN:C305($3;$openDialog)
vyMD_FieldPointer:=$1
$tableNum:=Table:C252(vyMD_FieldPointer)
$year:=<>gYear
$openDialog:=True:C214
Case of 
	: (Count parameters:C259=2)
		$year:=$2
		$openDialog:=True:C214
	: (Count parameters:C259=3)
		$year:=$2
		$openDialog:=$3
End case 

If ($year=0)
	$year:=<>gYear
End if 

ARRAY TEXT:C222(atMD_FieldUUID;0)
ARRAY TEXT:C222(atMD_FieldName;0)
ARRAY INTEGER:C220(alMD_FieldType;0)
ARRAY INTEGER:C220(aiMD_FieldLength;0)
ARRAY TEXT:C222(atMD_ValueList;0)

ARRAY REAL:C219(arMD_MinimumValue;0)
ARRAY REAL:C219(arMD_MaximumValue;0)

QUERY:C277([xxSTR_MetadatosLocales:141];[xxSTR_MetadatosLocales:141]CodigoPais:1=<>vtXS_CountryCode;*)
QUERY:C277([xxSTR_MetadatosLocales:141]; & [xxSTR_MetadatosLocales:141]Tabla:2;=;$tableNum)
ORDER BY:C49([xxSTR_MetadatosLocales:141];[xxSTR_MetadatosLocales:141]Orden:11;>)

SELECTION TO ARRAY:C260([xxSTR_MetadatosLocales:141]UUID:10;atMD_FieldUUID;[xxSTR_MetadatosLocales:141]Etiqueta:3;atMD_FieldName;[xxSTR_MetadatosLocales:141]Tipo:5;alMD_FieldType;[xxSTR_MetadatosLocales:141]Largo:6;aiMD_FieldLength;[xxSTR_MetadatosLocales:141]ValorMinimo:8;arMD_MinimumValue;[xxSTR_MetadatosLocales:141]ValorMaximo:9;arMD_MaximumValue;[xxSTR_MetadatosLocales:141]ListaDeValores:7;atMD_ValueList)
ARRAY TEXT:C222(atMD_TextValues;Size of array:C274(atMD_FieldUUID))
ARRAY TEXT:C222(atMD_Keys;Size of array:C274(atMD_FieldUUID))
ARRAY LONGINT:C221(atMD_RecNum;Size of array:C274(atMD_FieldUUID))

For ($i;1;Size of array:C274(atMD_FieldUUID))
	$key:=atMD_FieldUUID{$i}+"."+ST_Coerce_to_Text (vyMD_FieldPointer)+"."+String:C10($year)
	$recNum:=KRL_FindAndLoadRecordByIndex (->[MDATA_RegistrosDatosLocales:145]Llave:5;->$key)
	If ($recNum>=0)
		atMD_Keys{$i}:=$key
		atMD_RecNum{$i}:=$recNum
		atMD_TextValues{$i}:=[MDATA_RegistrosDatosLocales:145]Valor_Texto:10
	Else 
		atMD_Keys{$i}:=$key
		atMD_RecNum{$i}:=-1
		atMD_TextValues{$i}:=""
	End if 
End for 

If ($openDialog)
	WDW_OpenFormWindow (->[MDATA_RegistrosDatosLocales:145];"MD_Edit";-1;8)
	DIALOG:C40([MDATA_RegistrosDatosLocales:145];"MD_Edit")
	CLOSE WINDOW:C154
Else 
	ALP_DefaultColSettings (xALP_MetaDatos;1;"atMD_FieldName";"";150)
	ALP_DefaultColSettings (xALP_MetaDatos;2;"atMD_TextValues";"";300)
	ALP_DefaultColSettings (xALP_MetaDatos;3;"atMD_FieldUUID")
	ALP_DefaultColSettings (xALP_MetaDatos;4;"alMD_FieldType")
	ALP_DefaultColSettings (xALP_MetaDatos;5;"aiMD_FieldLength")
	ALP_DefaultColSettings (xALP_MetaDatos;6;"atMD_ValueList")
	ALP_DefaultColSettings (xALP_MetaDatos;7;"arMD_MinimumValue")
	ALP_DefaultColSettings (xALP_MetaDatos;8;"arMD_MaximumValue")
	ALP_DefaultColSettings (xALP_MetaDatos;9;"atMD_Keys")
	ALP_DefaultColSettings (xALP_MetaDatos;10;"atMD_RecNum")
	
	ALP_SetDefaultAppareance (xALP_MetaDatos)
	AL_SetColOpts (xALP_MetaDatos;0;0;0;8)
	AL_SetMiscOpts (xALP_MetaDatos;1)
	AL_SetEntryOpts (xALP_MetaDatos;3;0;0;1;2;<>tXS_RS_DecimalSeparator)
	AL_SetEnterable (xALP_MetaDatos;2;1)
	AL_SetCallbacks (xALP_MetaDatos;"";"xALCB_EX_MetaDatosLocales")
	
	ARRAY INTEGER:C220($aInt2;2;0)
	For ($i;1;Size of array:C274(atMD_FieldUUID))
		Case of 
			: (atMD_ValueList{$i}#"")
				AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;0)
				AL_SetCellIcon (xALP_MetaDatos;2;$i;Use PicRef:K28:4+12047;1;3;2)
				
			: (alMD_FieldType{$i}=Is text:K8:3)
				AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;1)
				
			: (alMD_FieldType{$i}=Is date:K8:7)
				AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;0)
				
			: (alMD_FieldType{$i}=Is boolean:K8:9)
				AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;0)
				AL_SetCellIcon (xALP_MetaDatos;2;$i;Use PicRef:K28:4+12047;1;3;2)
				
			: ((alMD_FieldType{$i}=Is real:K8:4) | (alMD_FieldType{$i}=Is longint:K8:6) | (alMD_FieldType{$i}=Is integer:K8:5))
				AL_SetCellEnter (xALP_MetaDatos;2;$i;2;$i;$aInt2;1)
				
		End case 
	End for 
End if 











