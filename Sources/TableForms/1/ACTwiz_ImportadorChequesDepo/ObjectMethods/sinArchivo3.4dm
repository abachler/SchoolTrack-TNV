C_LONGINT:C283($vl_table;$vl_field)

$vl_table:=Table:C252(aIDFieldPointers{aIdentificadores})
$vl_field:=Field:C253(aIDFieldPointers{aIdentificadores})
UFLD_LoadFileTplt (Table:C252(Table:C252(vyIDFieldPointersUF));"AccountTrack")
If (Size of array:C274(aUFList)>0)
	Case of 
		: (r1=1)
			USE CHARACTER SET:C205("MacRoman";0)
		: (r2=1)
			USE CHARACTER SET:C205("windows-1252";0)
		: (r3=1)
			USE CHARACTER SET:C205(*;0)
	End case 
	
	$ref:=Create document:C266("")
	If (ok=1)
		$path:=document
		
		ARRAY TEXT:C222($aHeaders;0)
		APPEND TO ARRAY:C911($aHeaders;"Identificador")
		For ($i;1;Size of array:C274(aUFList))
			APPEND TO ARRAY:C911($aHeaders;aUFList{$i})
		End for 
		$text:=AT_array2text (->$aHeaders;"\t")
		AT_Initialize (->$aHeaders)
		
		IO_SendPacket ($ref;$text)
		
		CLOSE DOCUMENT:C267($ref)
		
		ACTcd_DlogWithShowOnDisk ($path;0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
	End if 
	USE CHARACTER SET:C205(*;0)
Else 
	CD_Dlog (0;__ ("No hay campos propios configurados para la tabla ")+atACT_TablesUF_ACT{atACT_TablesUF_ACT}+".")
End if 