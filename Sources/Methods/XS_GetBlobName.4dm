//%attributes = {}
  //XS_GetBlobName

C_LONGINT:C283($2;$5)
_O_C_STRING:C293(80;$0;$1;$3;$4;$type;$country;$langage;$module;$panel)

Case of 
	: (Count parameters:C259=1)
		$type:=$1
		$module:=String:C10(vlBWR_CurrentModuleRef)
		$country:=<>vtXS_CountryCode
		$langage:=<>vtXS_langage
		$panel:=""
	: (Count parameters:C259=2)
		$type:=$1
		$module:=String:C10($2)
		$country:=<>vtXS_CountryCode
		$langage:=<>vtXS_langage
		$panel:=""
	: (Count parameters:C259=3)
		$type:=$1
		$module:=String:C10($2)
		$country:=$3
		$langage:=<>vtXS_langage
		$panel:=""
	: (Count parameters:C259=4)
		$type:=$1
		$module:=String:C10($2)
		$country:=$3
		$langage:=$4
		$panel:=""
	: (Count parameters:C259=5)
		$type:=$1
		$module:=String:C10($2)
		$country:=$3
		$langage:=$4
		$panel:=String:C10($5)
End case 

Case of 
	: ($type="config")
		$0:="XS_CFG_ConfigModule#"+$module+"#"+$country+"#"+$langage
	: ($type="wizard")
		$0:="XS_CFG_WizardsModule#"+$module+"#"+$country+"#"+$langage
	: ($type="service")
		$0:="XS_CFG_ServicesMenuModule#"+$module+"#"+$country+"#"+$langage
	: ($type="browser")
		$0:="XS_CFG_ModuleBrowserSettings#"+$module+"#"+$country+"#"+$langage
	: ($type="panel")
		$0:="XS_CFG_Module#"+$module+"_Panel#"+$panel+"#"+$country+"#"+$langage
	: ($type="tables")
		$0:="XS_CFG_Tables_Module#"+$module+"#"+$country+"#"+$langage
	Else 
		CD_Dlog (0;__ ("Tipo de blob no soportado."))
		$0:=""
End case 