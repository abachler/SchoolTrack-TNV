//%attributes = {}
  //MDATA_ObjectHandler

C_LONGINT:C283($tableID;$itemRef)
C_TEXT:C284($countryCode;$tableName;$fieldName)


GET LIST ITEM:C378(hl_Countries;*;$itemRef;$countryCode)
vs_CountryName:=ST_GetWord ($countryCode;2;":")
$countryCode:=ST_GetWord ($countryCode;1;":")
GET LIST ITEM:C378(hl_Tablas;*;$tableID;$tableName)

QUERY:C277([xxSTR_MetadatosLocales:141];[xxSTR_MetadatosLocales:141]CodigoPais:1=$countryCode;*)
QUERY:C277([xxSTR_MetadatosLocales:141]; & [xxSTR_MetadatosLocales:141]Tabla:2;=;$tableID)

ORDER BY:C49([xxSTR_MetadatosLocales:141];[xxSTR_MetadatosLocales:141]Orden:11;>)

hl_Campos:=HL_Selection2List (->[xxSTR_MetadatosLocales:141]Etiqueta:3)
If (Count list items:C380(hl_Campos)>0)
	If (vl_LastMetaDataRecNum<0)
		SELECT LIST ITEMS BY POSITION:C381(hl_Campos;1)
		GET LIST ITEM:C378(hl_Campos;*;vl_LastMetaDataRecNum;$fieldName)
	Else 
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Campos;vl_LastMetaDataRecNum)
	End if 
	
	KRL_GotoRecord (->[xxSTR_MetadatosLocales:141];vl_LastMetaDataRecNum;True:C214)
	
	
	SELECT LIST ITEMS BY REFERENCE:C630(hlMeta_TipoCampo;[xxSTR_MetadatosLocales:141]Tipo:5)
	OBJECT SET ENTERABLE:C238(*;"campos@";True:C214)
	_O_ENABLE BUTTON:C192(hlMeta_TipoCampo)
	
	Case of 
		: ([xxSTR_MetadatosLocales:141]Tipo:5=Is string var:K8:2)
			If (([xxSTR_MetadatosLocales:141]Largo:6=0) | ([xxSTR_MetadatosLocales:141]Largo:6>80))
				[xxSTR_MetadatosLocales:141]Largo:6:=80
			End if 
			[xxSTR_MetadatosLocales:141]ValorMaximo:9:=0
			[xxSTR_MetadatosLocales:141]ValorMinimo:8:=0
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMaximo:9;False:C215)
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMinimo:8;False:C215)
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]Largo:6;True:C214)
			
		: ([xxSTR_MetadatosLocales:141]Tipo:5=Is date:K8:7)
			[xxSTR_MetadatosLocales:141]Largo:6:=0
			[xxSTR_MetadatosLocales:141]ValorMaximo:9:=0
			[xxSTR_MetadatosLocales:141]ValorMinimo:8:=0
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMaximo:9;False:C215)
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMinimo:8;False:C215)
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]Largo:6;False:C215)
			
		: (([xxSTR_MetadatosLocales:141]Tipo:5=Is real:K8:4) | ([xxSTR_MetadatosLocales:141]Tipo:5=Is longint:K8:6))
			[xxSTR_MetadatosLocales:141]Largo:6:=0
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMaximo:9;True:C214)
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMinimo:8;True:C214)
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]Largo:6;False:C215)
			
		: ([xxSTR_MetadatosLocales:141]Tipo:5=Is boolean:K8:9)
			[xxSTR_MetadatosLocales:141]Largo:6:=0
			[xxSTR_MetadatosLocales:141]ValorMaximo:9:=0
			[xxSTR_MetadatosLocales:141]ValorMinimo:8:=0
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMaximo:9;False:C215)
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMinimo:8;False:C215)
			OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]Largo:6;False:C215)
			
	End case 
	GOTO OBJECT:C206([xxSTR_MetadatosLocales:141]Etiqueta:3)
	
Else 
	REDUCE SELECTION:C351([xxSTR_MetadatosLocales:141];0)
	OBJECT SET ENTERABLE:C238(*;"campos@";False:C215)
	_O_DISABLE BUTTON:C193(hlMeta_TipoCampo)
	vs_CountryName:=""
End if 