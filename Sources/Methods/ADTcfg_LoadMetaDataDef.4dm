//%attributes = {}
  //ADTcfg_LoadMetaDataDef

C_LONGINT:C283($type;$length)
C_BOOLEAN:C305($indexed;$unique;$invisible)

$category:=$1
AL_ExitCell (xALP_MetaDef)
AL_UpdateArrays (xALP_MetaDef;0)
If (($category=1) & (Is compiled mode:C492))
	AL_SetEnterable (xALP_MetaDef;3;0)
	AL_SetEnterable (xALP_MetaDef;2;0)
	AL_SetDrgSrc (xALP_MetaDef;1;"")
	AL_SetDrgDst (xALP_MetaDef;1;"")
Else 
	If ($category=1)
		AL_SetEnterable (xALP_MetaDef;3;0)
		AL_SetEnterable (xALP_MetaDef;2;0)
		AL_SetDrgSrc (xALP_MetaDef;1;String:C10(xALP_MetaDef))
		AL_SetDrgDst (xALP_MetaDef;1;String:C10(xALP_MetaDef))
	Else 
		AL_SetEnterable (xALP_MetaDef;3;2;atADT_TypesTxt)
		AL_SetEnterable (xALP_MetaDef;2;1)
		AL_SetDrgSrc (xALP_MetaDef;1;String:C10(xALP_MetaDef))
		AL_SetDrgDst (xALP_MetaDef;1;String:C10(xALP_MetaDef))
	End if 
End if 

READ ONLY:C145([xxADT_MetaDataDefinition:79])
QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Category:4=$category)
ORDER BY:C49([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Posicion:8;>)
SELECTION TO ARRAY:C260([xxADT_MetaDataDefinition:79];alADT_DefRecNums;[xxADT_MetaDataDefinition:79]ID:1;alADT_DefID;[xxADT_MetaDataDefinition:79]Name:2;asADT_DefName;[xxADT_MetaDataDefinition:79]Tipo:3;alADT_DefType;[xxADT_MetaDataDefinition:79]Tag:5;atADT_DefHTMLTags;[xxADT_MetaDataDefinition:79]FieldNum:6;alADT_DefFieldNum;[xxADT_MetaDataDefinition:79]TableNum:7;alADT_DefTableNum;[xxADT_MetaDataDefinition:79]Posicion:8;alADT_Positions)
ARRAY TEXT:C222(atADT_DefTypeTxt;Size of array:C274(alADT_DefRecNums))
For ($i;1;Size of array:C274(alADT_DefRecNums))
	Case of 
		: (alADT_DefType{$i}=Is text:K8:3)
			atADT_DefTypeTxt{$i}:="Texto"
		: (alADT_DefType{$i}=Is date:K8:7)
			atADT_DefTypeTxt{$i}:="Fecha"
		: (alADT_DefType{$i}=Is longint:K8:6)
			atADT_DefTypeTxt{$i}:="Entero"
		: (alADT_DefType{$i}=Is real:K8:4)
			atADT_DefTypeTxt{$i}:="Real"
		: (alADT_DefType{$i}=Is alpha field:K8:1)
			If ((alADT_DefFieldNum{$i}#0) & (alADT_DefTableNum{$i}#0))
				GET FIELD PROPERTIES:C258(alADT_DefTableNum{$i};alADT_DefFieldNum{$i};$type;$length;$indexed;$unique;$invisible)
				$largo:=String:C10($length)
			Else 
				$largo:=""
			End if 
			atADT_DefTypeTxt{$i}:="String "+$largo
		: (alADT_DefType{$i}=Is boolean:K8:9)
			atADT_DefTypeTxt{$i}:="Boolean"
		: (alADT_DefType{$i}=Is picture:K8:10)
			atADT_DefTypeTxt{$i}:="Imagen"
		: (alADT_DefType{$i}=10)
			atADT_DefTypeTxt{$i}:="Lista"
		Else 
			atADT_DefTypeTxt{$i}:="Indefinido"
	End case 
End for 
AL_UpdateArrays (xALP_MetaDef;-2)
AL_SetLine (xALP_MetaDef;0)
_O_DISABLE BUTTON:C193(bDelMetaData)