//%attributes = {}
  //ACTcfg_SearchCatDocs

C_REAL:C285(vlACT_IndexAfecta1;vlACT_IndexAfecta2;vlACT_IndexExenta1;vlACT_IndexExenta2)
$catID:=$1
If (Count parameters:C259=2)
	$row:=$2
	$testRow:=True:C214
Else 
	$row:=0
	$testRow:=False:C215
End if 

vbACT_Afecta1:=False:C215
vbACT_Afecta2:=False:C215
vbACT_Exenta1:=False:C215
vbACT_Exenta2:=False:C215

$0:=True:C214
If ($testRow)
	If (($catID=0) | (aiACT_Tipo{$row}=0))
		$0:=False:C215
	Else 
		alACT_IDCat{0}:=$catID
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->alACT_IDCat;"=";->$DA_Return)
		For ($i;1;Size of array:C274($DA_Return))
			$index:=$DA_Return{$i}
			If ($index#$row)
				Case of 
					: (aiACT_Tipo{$index}=1) & (abACT_Afecta{$index}) & (abACT_DocPorDefecto{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
						vbACT_Afecta1:=True:C214
						vlACT_IndexAfecta1:=$index
					: (aiACT_Tipo{$index}=2) & (abACT_Afecta{$index}) & (abACT_DocPorDefecto{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
						vbACT_Afecta2:=True:C214
						vlACT_IndexAfecta2:=$index
					: (aiACT_Tipo{$index}=1) & (Not:C34(abACT_Afecta{$index})) & (abACT_DocPorDefecto{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
						vbACT_Exenta1:=True:C214
						vlACT_IndexExenta1:=$index
					: (aiACT_Tipo{$index}=2) & (Not:C34(abACT_Afecta{$index})) & (abACT_DocPorDefecto{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
						vbACT_Exenta2:=True:C214
						vlACT_IndexExenta2:=$index
				End case 
			End if 
		End for 
		Case of 
			: (aiACT_Tipo{$row}=1) & (abACT_Afecta{$row})
				If (vbACT_Afecta1)
					$0:=False:C215
				End if 
			: (aiACT_Tipo{$row}=1) & (Not:C34(abACT_Afecta{$row}))
				If (vbACT_Exenta1)
					$0:=False:C215
				End if 
			: (aiACT_Tipo{$row}=2) & (abACT_Afecta{$row})
				If (vbACT_Afecta2)
					$0:=False:C215
				End if 
			: (aiACT_Tipo{$row}=2) & (Not:C34(abACT_Afecta{$row}))
				If (vbACT_Exenta2)
					$0:=False:C215
				End if 
		End case 
	End if 
Else 
	alACT_IDCat{0}:=$catID
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->alACT_IDCat;"=";->$DA_Return)
	For ($i;1;Size of array:C274($DA_Return))
		$index:=$DA_Return{$i}
		Case of 
			: (aiACT_Tipo{$index}=1) & (abACT_Afecta{$index}) & (abACT_DocPorDefecto{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
				vbACT_Afecta1:=True:C214
				vlACT_IndexAfecta1:=$index
			: (aiACT_Tipo{$index}=2) & (abACT_Afecta{$index}) & (abACT_DocPorDefecto{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
				vbACT_Afecta2:=True:C214
				vlACT_IndexAfecta2:=$index
			: (aiACT_Tipo{$index}=1) & (Not:C34(abACT_Afecta{$index})) & (abACT_DocPorDefecto{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
				vbACT_Exenta1:=True:C214
				vlACT_IndexExenta1:=$index
			: (aiACT_Tipo{$index}=2) & (Not:C34(abACT_Afecta{$index})) & (abACT_DocPorDefecto{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
				vbACT_Exenta2:=True:C214
				vlACT_IndexExenta2:=$index
		End case 
	End for 
	C_LONGINT:C283($el)
	$el:=Find in array:C230(alACT_IDsCats;$catID)
	If ($el>0)
		Case of 
			: (<>gCountryCode="mx")
				  //If (vbACT_Exenta1)  //en MX se debe crear una definición Exenta impresa.
				If (vbACT_Afecta1)  // 20141021 ASM Se cambia la validación para que se considere la definicion Afecta.
					$0:=True:C214
					
					  // 20120110 RCH cuando emiten documentos digitales, deben tener creada la definicion exenta digital.
					  //If (cs_emitirCFDI=1)
					  //If (Not(vbACT_Exenta2))
					  //$0:=False
					  //End if 
					  //End if 
					If (cs_emitirCFDI=1)
						If (Not:C34(vbACT_Afecta1))
							$0:=False:C215
						End if 
					End if 
				Else 
					$0:=False:C215
				End if 
				
			: (atACT_Categorias{$el}="Letra@")
				If (vbACT_Exenta1)
					$0:=True:C214
				Else 
					$0:=False:C215
				End if 
				
			: ($catID=-4)
				If ((vbACT_Afecta1) & (vbACT_Afecta2))
					$0:=True:C214
				Else 
					$0:=False:C215
				End if 
				
			: ($catID=-5)
				If ((vbACT_Afecta1) & (vbACT_Afecta2))
					$0:=True:C214
				Else 
					$0:=False:C215
				End if 
				
			Else 
				If ((vbACT_Afecta1) & (vbACT_Afecta2) & (vbACT_Exenta1) & (vbACT_Exenta2))
					$0:=True:C214
				Else 
					$0:=False:C215
				End if 
		End case 
	Else 
		$0:=False:C215
	End if 
End if 