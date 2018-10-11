$item:=Selected list items:C379(Self:C308->)
If ($item>0)
	GET LIST ITEM:C378(Self:C308->;$item;$ref;$text)
	$prevCode:=[Colegio:31]Codigo_Pais:31
	If ([Colegio:31]Codigo_Pais:31#Substring:C12($text;1;2))
		[Colegio:31]Codigo_Pais:31:=Substring:C12($text;1;2)
		[Colegio:31]Pais:21:=Substring:C12($text;5)
		SAVE RECORD:C53([Colegio:31])
		If ([Colegio:31]Codigo_Pais:31="cl")
			OBJECT SET VISIBLE:C603(*;"chile@";True:C214)
			OBJECT SET VISIBLE:C603(*;"extranjero@";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"chile@";False:C215)
			OBJECT SET VISIBLE:C603(*;"extranjero@";True:C214)
		End if 
		<>vtXS_CountryCode:=[Colegio:31]Codigo_Pais:31
		  //CFG_LoadDevelopperConfig 
	End if 
End if 
<>vtXS_CountryCode:=[Colegio:31]Codigo_Pais:31
<>gCountryCode:=[Colegio:31]Codigo_Pais:31
[Colegio:31]Moneda:49:=ACT_DivisaPais 
ACTutl_GetDecimalFormat 
[Colegio:31]Numero_Decimales:53:=<>vlACT_Decimales

ACTcfg_LeeDecimalMonedaPais 

Case of 
	: (<>vtXS_CountryCode="cl")
		<>vs_AppDecimalSeparator:=","
	: (<>vtXS_CountryCode="co")
		<>vs_AppDecimalSeparator:=","
	: (<>vtXS_CountryCode="pe")
		<>vs_AppDecimalSeparator:=","
	: (<>vtXS_CountryCode="ar")
		<>vs_AppDecimalSeparator:=","
	: (<>vtXS_CountryCode="mx")
		<>vs_AppDecimalSeparator:="."
	Else 
		<>vs_AppDecimalSeparator:=","
End case 
PREF_Set (0;"DecimalSeparator";<>vs_AppDecimalSeparator)
XSvs_LocalizaEstructura 
POST KEY:C465(Character code:C91("+");256)