//%attributes = {}
  //SR_FijaPropiedad

C_BOOLEAN:C305($condition;$1;$4;$7;$10;$13;$16;$19;$22)
C_TEXT:C284($propertyToSet;$propertyValue;$2;$3;$5;$6;$8;$9;$11;$12;$14;$15;$17;$18;$20;$21;$23;$24)


If (Count parameters:C259>=3)
	$condition:=$1
	$propertyToSet:=$2
	$propertyValue:=$3
	If ($condition)
		Case of 
			: ($propertyToSet="Color")
				SR_SetObjectColor ($propertyValue;"White";0)
			: ($propertyToSet="Color fondo")
				SR_SetObjectColor ("";$propertyValue;2)
			: ($propertyToSet="Color texto")
				SR_SetObjectColor ($propertyValue;"";1)
			: ($propertyToSet="Fuente")
				SR_SetObjectFontName ($propertyValue)
			: ($propertyToSet="Estilo")
				SR_SetObjectFontStyleFromString ($propertyValue)
			: ($propertyToSet="Tamaño")
				SR_SetObjectFontSizeFromString ($propertyValue)
		End case 
	End if 
End if 

If (Count parameters:C259>=6)
	$condition:=$4
	$propertyToSet:=$5
	$propertyValue:=$6
	If ($condition)
		Case of 
			: ($propertyToSet="Color")
				SR_SetObjectColor ($propertyValue;"White";0)
			: ($propertyToSet="Color fondo")
				SR_SetObjectColor ("";$propertyValue;2)
			: ($propertyToSet="Color texto")
				SR_SetObjectColor ($propertyValue;"";1)
			: ($propertyToSet="Fuente")
				SR_SetObjectFontName ($propertyValue)
			: ($propertyToSet="Estilo")
				SR_SetObjectFontStyleFromString ($propertyValue)
			: ($propertyToSet="Tamaño")
				SR_SetObjectFontSizeFromString ($propertyValue)
		End case 
	End if 
End if 

If (Count parameters:C259>=9)
	$condition:=$7
	$propertyToSet:=$8
	$propertyValue:=$9
	If ($condition)
		Case of 
			: ($propertyToSet="Color")
				SR_SetObjectColor ($propertyValue;"White";0)
			: ($propertyToSet="Color fondo")
				SR_SetObjectColor ("";$propertyValue;2)
			: ($propertyToSet="Color texto")
				SR_SetObjectColor ($propertyValue;"";1)
			: ($propertyToSet="Fuente")
				SR_SetObjectFontName ($propertyValue)
			: ($propertyToSet="Estilo")
				SR_SetObjectFontStyleFromString ($propertyValue)
			: ($propertyToSet="Tamaño")
				SR_SetObjectFontSizeFromString ($propertyValue)
		End case 
	End if 
End if 

If (Count parameters:C259>=12)
	$condition:=$10
	$propertyToSet:=$11
	$propertyValue:=$12
	If ($condition)
		Case of 
			: ($propertyToSet="Color")
				SR_SetObjectColor ($propertyValue;"White";0)
			: ($propertyToSet="Color fondo")
				SR_SetObjectColor ("";$propertyValue;2)
			: ($propertyToSet="Color texto")
				SR_SetObjectColor ($propertyValue;"";1)
			: ($propertyToSet="Fuente")
				SR_SetObjectFontName ($propertyValue)
			: ($propertyToSet="Estilo")
				SR_SetObjectFontStyleFromString ($propertyValue)
			: ($propertyToSet="Tamaño")
				SR_SetObjectFontSizeFromString ($propertyValue)
		End case 
	End if 
End if 

If (Count parameters:C259>=15)
	$condition:=$13
	$propertyToSet:=$14
	$propertyValue:=$15
	If ($condition)
		Case of 
			: ($propertyToSet="Color")
				SR_SetObjectColor ($propertyValue;"White";0)
			: ($propertyToSet="Color fondo")
				SR_SetObjectColor ("";$propertyValue;2)
			: ($propertyToSet="Color texto")
				SR_SetObjectColor ($propertyValue;"";1)
			: ($propertyToSet="Fuente")
				SR_SetObjectFontName ($propertyValue)
			: ($propertyToSet="Estilo")
				SR_SetObjectFontStyleFromString ($propertyValue)
			: ($propertyToSet="Tamaño")
				SR_SetObjectFontSizeFromString ($propertyValue)
		End case 
	End if 
End if 

If (Count parameters:C259>=18)
	$condition:=$16
	$propertyToSet:=$17
	$propertyValue:=$18
	If ($condition)
		Case of 
			: ($propertyToSet="Color")
				SR_SetObjectColor ($propertyValue;"White";0)
			: ($propertyToSet="Color fondo")
				SR_SetObjectColor ("";$propertyValue;2)
			: ($propertyToSet="Color texto")
				SR_SetObjectColor ($propertyValue;"";1)
			: ($propertyToSet="Fuente")
				SR_SetObjectFontName ($propertyValue)
			: ($propertyToSet="Estilo")
				SR_SetObjectFontStyleFromString ($propertyValue)
			: ($propertyToSet="Tamaño")
				SR_SetObjectFontSizeFromString ($propertyValue)
		End case 
	End if 
End if 

If (Count parameters:C259>=21)
	$condition:=$19
	$propertyToSet:=$20
	$propertyValue:=$21
	If ($condition)
		Case of 
			: ($propertyToSet="Color")
				SR_SetObjectColor ($propertyValue;"White";0)
			: ($propertyToSet="Color fondo")
				SR_SetObjectColor ("";$propertyValue;2)
			: ($propertyToSet="Color texto")
				SR_SetObjectColor ($propertyValue;"";1)
			: ($propertyToSet="Fuente")
				SR_SetObjectFontName ($propertyValue)
			: ($propertyToSet="Estilo")
				SR_SetObjectFontStyleFromString ($propertyValue)
			: ($propertyToSet="Tamaño")
				SR_SetObjectFontSizeFromString ($propertyValue)
		End case 
	End if 
End if 

If (Count parameters:C259>=24)
	$condition:=$22
	$propertyToSet:=$24
	$propertyValue:=$24
	If ($condition)
		Case of 
			: ($propertyToSet="Color")
				SR_SetObjectColor ($propertyValue;"White";0)
			: ($propertyToSet="Color fondo")
				SR_SetObjectColor ("";$propertyValue;2)
			: ($propertyToSet="Color texto")
				SR_SetObjectColor ($propertyValue;"";1)
			: ($propertyToSet="Fuente")
				SR_SetObjectFontName ($propertyValue)
			: ($propertyToSet="Estilo")
				SR_SetObjectFontStyleFromString ($propertyValue)
			: ($propertyToSet="Tamaño")
				SR_SetObjectFontSizeFromString ($propertyValue)
		End case 
	End if 
End if 

  //For ($i;1;Count parameters;3)
  //$condition:=${$i}
  //$propertyToSet:=${$i+1}
  //$propertyValue:=${$i+2}
  //If ($condition)
  //Case of 
  //: ($propertyToSet="Color")
  //SR_SetObjectColor ($propertyValue;"White";0)
  //: ($propertyToSet="Color fondo")
  //SR_SetObjectColor ("";$propertyValue;2)
  //: ($propertyToSet="Color texto")
  //SR_SetObjectColor ($propertyValue;"";1)
  //: ($propertyToSet="Fuente")
  //SR_SetObjectFontName ($propertyValue)
  //: ($propertyToSet="Estilo")
  //SR_SetObjectFontStyleFromString ($propertyValue)
  //: ($propertyToSet="Tamaño")
  //SR_SetObjectFontSizeFromString ($propertyValue)
  //End case 
  //End if 
  //End for 