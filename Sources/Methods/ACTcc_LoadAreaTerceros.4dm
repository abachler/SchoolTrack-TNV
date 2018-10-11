//%attributes = {}
  //ACTcc_LoadAreaTerceros

ACTcc_FormArraysDeclarations ("ArreglosTerceros")
C_LONGINT:C283($vl_IDctaCte)
ARRAY LONGINT:C221($al_TerceroRN;0)

If (Count parameters:C259=1)
	$vl_IDctaCte:=$1
Else 
	$vl_IDctaCte:=[ACT_CuentasCorrientes:175]ID:1
End if 

AL_UpdateArrays (xAL_ACTter_TercerosAsociados;0)
If ($vl_IDctaCte#0)
	READ ONLY:C145([ACT_Terceros:138])
	READ ONLY:C145([ACT_Terceros_Pactado:139])
	QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_CuentaCorriente:3=$vl_IDctaCte)
	KRL_RelateSelection (->[ACT_Terceros:138]Id:1;->[ACT_Terceros_Pactado:139]Id_Tercero:2;"")
	If (Records in selection:C76([ACT_Terceros:138])>0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Terceros:138];$al_TerceroRN)
		AT_RedimArrays (Size of array:C274($al_TerceroRN);->atACT_TerceroNombre;->atACT_TerceroTipo;->atACT_TerceroRUT;->alACT_TerceroRecNum)
		For ($i;1;Size of array:C274($al_TerceroRN))
			GOTO RECORD:C242([ACT_Terceros:138];$al_TerceroRN{$i})
			atACT_TerceroNombre{$i}:=[ACT_Terceros:138]Nombre_Completo:9
			atACT_TerceroTipo{$i}:=ST_Boolean2Text ([ACT_Terceros:138]Es_empresa:2;__ ("Empresa");__ ("Persona Natural"))
			atACT_TerceroRUT{$i}:=SR_FormatoRUT2 ([ACT_Terceros:138]RUT:4)
			alACT_TerceroRecNum{$i}:=Record number:C243([ACT_Terceros:138])
		End for 
	End if 
End if 
AL_UpdateArrays (xAL_ACTter_TercerosAsociados;-2)
AL_SetLine (xAL_ACTter_TercerosAsociados;0)



