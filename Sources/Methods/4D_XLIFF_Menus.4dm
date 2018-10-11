//%attributes = {"executedOnServer":true}
  // Método: 4D_XLIFF_Menus
  //
  //
  // creado por Alberto Bachler Klein
  // el 20/02/18, 18:19:13
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($hl_lenguas;$hl_Paises;$i_barras;$i_items;$i_lenguas;$i_menus;$i_paises;$l_numeroItems)
C_TEXT:C284($t_barraMenuActual;$t_bodyXML;$t_footerXML;$t_headerXML;$t_nombreItem;$t_ruta;$t_archivo)
C_BOOLEAN:C305($b_errorAlEliminar;$0;$b_hecho)

ARRAY TEXT:C222($at_barrasMenu;0)
ARRAY TEXT:C222($at_countryCodes;0)
ARRAY TEXT:C222($at_langageCodes;0)
ARRAY TEXT:C222($at_refMenus;0)
ARRAY TEXT:C222($at_titulosMenu;0)

APPEND TO ARRAY:C911($at_barrasMenu;"XS_Browser")
APPEND TO ARRAY:C911($at_barrasMenu;"XS_ReportManager")
APPEND TO ARRAY:C911($at_barrasMenu;"XS_Edicion")
APPEND TO ARRAY:C911($at_barrasMenu;"XS_Settings")
APPEND TO ARRAY:C911($at_barrasMenu;"XS_ReportEditor")

$t_ruta:=Get 4D folder:C485(Database folder:K5:14)+"xliff"+Folder separator:K24:12+"es-cl.lproj"+Folder separator:K24:12

$t_headerXML:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>\r"
$t_headerXML:=$t_headerXML+"<xliff version=\"1.0\">\r"
$t_headerXML:=$t_headerXML+"<file original=\"undefined\" source-language=\"es\" target-language=\"es-cl\">\r\r"
$t_headerXML:=$t_headerXML+"<body>\r"


$t_footerXML:="\r</body>\r</file>\r</xliff>"

$t_bodyXML:=""
For ($i_barras;1;Size of array:C274($at_barrasMenu))
	SET MENU BAR:C67($at_barrasMenu{$i_barras})
	$t_bodyXML:=""
	  //$t_bodyXML:=$t_bodyXML+"<group resname=\""+$at_barrasMenu{$i_barras}+"\">\r"
	
	$t_barraMenuActual:=Get menu bar reference:C979
	GET MENU ITEMS:C977($t_barraMenuActual;$at_titulosMenu;$at_refMenus)
	
	For ($i_menus;1;Size of array:C274($at_refMenus))
		If ($at_refMenus{$i_menus}#"")
			$t_bodyXML:=$t_bodyXML+" <group resname=\""+$at_titulosMenu{$i_menus}+"\">\r"
			$l_numeroItems:=Count menu items:C405($at_refMenus{$i_menus})
			For ($i_items;1;$l_numeroItems)
				$t_nombreItem:=Get menu item:C422($at_refMenus{$i_menus};$i_items)
				$t_nombreItem:=Replace string:C233($t_nombreItem;":xliff:";"")
				If (($t_nombreItem#"") & ($t_nombreItem#"(-") & (($t_nombreItem#"Elemento @") & (Num:C11($t_nombreItem)=0)))
					$t_bodyXML:=$t_bodyXML+"  <trans-unit id=\""+$t_nombreItem+"\" resname=\""+$t_nombreItem+"\">\r"
					$t_bodyXML:=$t_bodyXML+"    <source>"+$t_nombreItem+"</source>\r"
					$t_bodyXML:=$t_bodyXML+"    <target>"+$t_nombreItem+"</target>\r"
					$t_bodyXML:=$t_bodyXML+"  </trans-unit>\r"
					
				End if 
			End for 
			$t_bodyXML:=$t_bodyXML+" </group>\r"
		End if 
	End for 
	
	  //$t_bodyXML:=$t_bodyXML+"</group>\r\r"
	
	$t_archivo:=$t_ruta+$at_barrasMenu{$i_barras}+".xlf"
	$t_metodoOnErr:=Method called on error:C704
	Error:=0
	ON ERR CALL:C155("ERR_EventoError")
	TEXT TO DOCUMENT:C1237($t_archivo;$t_headerXML+$t_bodyXML+$t_footerXML)
	If (Error=0)
		$b_hecho:=True:C214
	Else 
		$i_barras:=Size of array:C274($at_barrasMenu)
	End if 
	ON ERR CALL:C155($t_metodoOnErr)
	
End for 

$0:=$b_hecho

