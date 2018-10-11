//%attributes = {}
  //ADTcfg_LoadEstados

C_BLOB:C604($blob)
C_LONGINT:C283($tempList)

$hl_Estados:=New list:C375
APPEND TO LIST:C376($hl_Estados;"Inscrito";-1)
APPEND TO LIST:C376($hl_Estados;"Informes";-2)
APPEND TO LIST:C376($hl_Estados;"Aspirante";-3)
APPEND TO LIST:C376($hl_Estados;"Lista de Espera";-4)
APPEND TO LIST:C376($hl_Estados;"Admitido";-5)
LIST TO BLOB:C556($hl_Estados;$blob)
HL_ClearList ($hl_Estados)

$blob:=PREF_fGetBlob (0;"estadosADT";$blob)
$tempList:=BLOB to list:C557($blob)

For ($i;Count list items:C380($tempList);1;-1)
	GET LIST ITEM:C378($tempList;$i;$ref;$text)
	If ($ref=0)
		SELECT LIST ITEMS BY POSITION:C381($tempList;$i)
		DELETE FROM LIST:C624($tempList;*)
	End if 
End for 

$0:=$tempList

