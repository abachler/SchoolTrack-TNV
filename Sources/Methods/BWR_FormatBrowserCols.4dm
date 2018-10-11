//%attributes = {}
  // Método: BWR_FormatBrowserCols
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 13-04-10, 14:19:37
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //BWR_FormatBrowserCols

ARRAY INTEGER:C220($aHeaderJust;Size of array:C274(atBWR_ArrayNames)-1)
ARRAY INTEGER:C220($aColumnJust;Size of array:C274(atBWR_ArrayNames)-1)
ARRAY INTEGER:C220($afontSize;Size of array:C274(atBWR_ArrayNames)-1)
ARRAY INTEGER:C220($afontStyle;Size of array:C274(atBWR_ArrayNames)-1)
ARRAY INTEGER:C220($aforeColor;Size of array:C274(atBWR_ArrayNames)-1)
ARRAY TEXT:C222($afontName;Size of array:C274(atBWR_ArrayNames)-1)
ARRAY TEXT:C222($aformat;Size of array:C274(atBWR_ArrayNames)-1)

vs_DataMode:="Arrays"

For ($i;1;Size of array:C274(atBWR_ArrayNames)-1)
	$aformat{$i}:=ST_GetWord (atVS_BrowserFormat{$i};1;"{")
	If (($aformat{$i}="###.###.###-#") & (<>vtXS_CountryCode#"cl"))
		$aformat{$i}:=""
	End if 
	  //20151016 ASM Ticket 151088 
	If (KRL_isSameField (ayBWR_FieldPointers{$i};->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33))
		$aformat{$i}:="|Pct_1Dec"
	End if 
	$aheaderJust{$i}:=Num:C11(ST_GetWord (atVS_BrowserFormat{$i};2;"{"))
	$acolumnJust{$i}:=Num:C11(ST_GetWord (atVS_BrowserFormat{$i};3;"{"))
	$afontName{$i}:=ST_GetWord (atVS_BrowserFormat{$i};4;"{")
	$aFontsize{$i}:=Num:C11(ST_GetWord (atVS_BrowserFormat{$i};5;"{"))
	$aFontStyle{$i}:=Num:C11(ST_GetWord (atVS_BrowserFormat{$i};6;"{"))
	$aforecolor{$i}:=Num:C11(ST_GetWord (atVS_BrowserFormat{$i};7;"{"))
	atVS_Header{$i}:=Replace string:C233(atVS_Header{$i};"\\r";"\r")
	  //AL_SetHeaderOptions
	If ($aheaderJust{$i}=0)
		$aheaderJust{$i}:=2
	End if 
	If ($afontName{$i}="")
		$afontName{$i}:="Tahoma"
	End if 
	If ($aFontsize{$i}=0)
		$aFontsize{$i}:=9
	End if 
	If ($aforeColor{$i}=0)
		$aforeColor{$i}:=16
	End if 
End for 

vlBWR_ALPColumns:=Size of array:C274(atBWR_ArrayNames)
For ($i;1;vlBWR_ALPColumns-1)
	$err:=ALP_DefaultColSettings (xALP_Browser;$i;atBWR_ArrayNames{$i};atVS_Header{$i};alVS_ColumnWidth{$i};$aformat{$i};$acolumnJust{$i};$aheaderJust{$i})
	AL_SetStyle (xALP_Browser;$i;$afontName{$i};$aFontsize{$i};$aFontstyle{$i})
	AL_SetForeColor (xALP_Browser;$i;"";0;"";$aforeColor{$i})
End for 
AL_UpdateArrays (xALP_Browser;-1)