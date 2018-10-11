//%attributes = {"executedOnServer":true}
  // Método: 4D_XLIFF_Forms
  //
  //
  // creado por Alberto Bachler Klein
  // el 20/02/18, 13:51:56
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($hl_lenguas;$hl_Paises;$i_forms;$i_lenguas;$i_paises;$i_table)
C_POINTER:C301($y_table)
C_TEXT:C284($t_bodyXML;$t_footerXML;$t_groupXML;$t_headerXML;$t_ruta;$t_archivo;$t_metodoOnErr)
C_LONGINT:C283($l_proc)
C_BOOLEAN:C305($0;$b_hecho)

ARRAY TEXT:C222($at_countryCodes;0)
ARRAY TEXT:C222($at_forms;0)
ARRAY TEXT:C222($at_langageCodes;0)

$t_ruta:=Get 4D folder:C485(Database folder:K5:14)+"xliff"+Folder separator:K24:12+"es-cl.lproj"+Folder separator:K24:12
$t_archivo:=$t_ruta+"forms.xlf"

$t_headerXML:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>\r"
$t_headerXML:=$t_headerXML+"<xliff version=\"1.0\">\r"
$t_headerXML:=$t_headerXML+"<file original=\"undefined\" source-language=\"es\" target-language=\"es-cl\">\r\r"
$t_headerXML:=$t_headerXML+"<body>\r"

$t_footerXML:="\r</body></file></xliff>"

FORM GET NAMES:C1167($at_forms)
For ($i_forms;1;Size of array:C274($at_forms))
	$t_groupXML:=4D_XLIFF_FormTexts ($y_table;$at_forms{$i_forms})
	If ($t_groupXML#"")
		$t_bodyXML:=$t_bodyXML+$t_groupXML
	End if 
End for 

$l_proc:=IT_Progress (1;0;0;"Generando archivo forms.xlf...")
For ($i_table;1;Get last table number:C254)
	If (Is table number valid:C999($i_table))
		$y_table:=Table:C252($i_table)
		FORM GET NAMES:C1167($y_table->;$at_forms)
		For ($i_forms;1;Size of array:C274($at_forms))
			$t_groupXML:=4D_XLIFF_FormTexts ($y_table;$at_forms{$i_forms})
			If ($t_groupXML#"")
				$t_bodyXML:=$t_bodyXML+$t_groupXML
			End if 
		End for 
	End if 
	IT_Progress (0;$l_proc;$i_table/Get last table number:C254)
End for 
IT_Progress (-1;$l_proc)

CREATE FOLDER:C475($t_ruta;*)

$t_metodoOnErr:=Method called on error:C704
Error:=0
ON ERR CALL:C155("ERR_EventoError")
TEXT TO DOCUMENT:C1237($t_archivo;$t_headerXML+$t_bodyXML+$t_footerXML)
If (Error=0)
	$b_hecho:=True:C214
End if 
ON ERR CALL:C155($t_metodoOnErr)


$0:=$b_hecho
