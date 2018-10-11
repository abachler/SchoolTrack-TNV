//%attributes = {}
  //ACTcfg_CheckRRecuadDef

$Fillercero:=False:C215
$w:=0

ARRAY LONGINT:C221(alACT_FillerPositions;0)
$j:=1
$filler:=Find in array:C230(atACT_Descripcion;"Filler")

While ($filler#-1)
	INSERT IN ARRAY:C227(alACT_FillerPositions;Size of array:C274(alACT_FillerPositions)+1;1)
	alACT_FillerPositions{$j}:=$filler
	$j:=$j+1
	$filler:=Find in array:C230(atACT_Descripcion;"Filler";$filler+1)
End while 

For ($i;1;Size of array:C274(alACT_FillerPositions))
	If (alACT_Largo{alACT_FillerPositions{$i}}=0)
		$Fillercero:=True:C214
	End if 
End for 

ARRAY LONGINT:C221(alACT_LargoCeroPos;0)
$j:=1
$cero:=Find in array:C230(alACT_Largo;0)

While ($cero#-1)
	INSERT IN ARRAY:C227(alACT_LargoCeroPos;Size of array:C274(alACT_LargoCeroPos)+1;1)
	alACT_LargoCeroPos{$j}:=$cero
	$j:=$j+1
	$cero:=Find in array:C230(alACT_Largo;0;$cero+1)
End while 

For ($i;1;Size of array:C274(alACT_LargoCeroPos))
	$w:=Size of array:C274(alACT_LargoCeroPos)
	If (atACT_Descripcion{alACT_LargoCeroPos{$i}}="Filler")
		$w:=$w-1
	End if 
End for 

$tipo:=False:C215

For ($i;1;Size of array:C274(atACT_Descripcion))
	If (atACT_Tipo{$i}="")
		$tipo:=True:C214
	End if 
End for 

Case of 
		
	: (($Fillercero) & ($w>0) & ($tipo))
		CD_Dlog (0;__ ("Existen campos de largo cero además de fillers de cero bytes.\rExisten también campos donde no se ha definido el tipo de dato.\r\rRevise esta situación antes de importar o exportar datos con este modelo."))
	: (($w>0) & ($tipo))
		CD_Dlog (0;__ ("Existen campos de largo cero además de campos donde no se ha definido el tipo de dato.\r\rRevise esta situación antes de importar o exportar datos usando este modelo."))
	: (($Fillercero) & ($tipo))
		CD_Dlog (0;__ ("Existen campos donde no se ha definido el tipo de dato además de fillers de cero bytes.\r\rRevise esta situación antes de importar o exportar datos usando este modelo."))
	: (($Fillercero) & ($w>0))
		CD_Dlog (0;__ ("Existen campos de largo cero además de fillers de cero bytes.\r\rRevise esta situación antes de importar o exportar datos usando este modelo."))
	: ($Fillercero)
		CD_Dlog (0;__ ("Existen fillers de cero bytes.\r\rRevise esta situación antes de importar o exportar datos."))
	: ($tipo)
		CD_Dlog (0;__ ("Existen campos donde no se ha definido el tipo de dato.\r\rRevise esta situación antes de importar o exportar datos usando este modelo."))
	: ($w>0)
		CD_Dlog (0;__ ("Existen campos de largo cero.\r\rRevise esta situación antes de importar o exportar datos usando este modelo."))
End case 