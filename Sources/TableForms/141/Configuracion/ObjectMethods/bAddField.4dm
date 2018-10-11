  // [xxSTR_MetadatosLocales].Configuracion.bAddField()
  // Por: Alberto Bachler K.: 22-12-13, 19:43:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------




C_LONGINT:C283($tableID;$itemRef)
C_TEXT:C284($countryCode;$tableName)

GET LIST ITEM:C378(hl_Countries;*;$itemRef;$countryCode)
vs_CountryName:=ST_GetWord ($countryCode;2;":")
$countryCode:=ST_GetWord ($countryCode;1;":")
GET LIST ITEM:C378(hl_Tablas;*;$tableID;$tableName)

$date:=Current date:C33(*)
$time:=Current time:C178(*)
If (($date#!00-00-00!) & (Current time:C178(*)#?00:00:00?))
	CREATE RECORD:C68([xxSTR_MetadatosLocales:141])
	[xxSTR_MetadatosLocales:141]CodigoPais:1:=$countryCode
	[xxSTR_MetadatosLocales:141]Tabla:2:=$tableID
	[xxSTR_MetadatosLocales:141]Tipo:5:=24
	[xxSTR_MetadatosLocales:141]Largo:6:=80
	[xxSTR_MetadatosLocales:141]ValorMaximo:9:=0
	[xxSTR_MetadatosLocales:141]ValorMinimo:8:=0
	SAVE RECORD:C53([xxSTR_MetadatosLocales:141])
	[xxSTR_MetadatosLocales:141]Etiqueta:3:="Nuevo Campo #"+String:C10(Record number:C243([xxSTR_MetadatosLocales:141]))
	SAVE RECORD:C53([xxSTR_MetadatosLocales:141])
	
	OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMaximo:9;False:C215)
	OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMinimo:8;False:C215)
	
	vl_LastMetaDataRecNum:=Record number:C243([xxSTR_MetadatosLocales:141])
	SELECT LIST ITEMS BY REFERENCE:C630(hl_Campos;vl_LastMetaDataRecNum)
	MDATA_ObjectHandler 
	
Else 
	BEEP:C151
End if 
