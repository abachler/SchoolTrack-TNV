//%attributes = {}
  //BBLw_more

C_TEXT:C284($0;$1)
C_TEXT:C284(vt_Lineas)
C_BLOB:C604(vx_HTMLBlob)
C_TEXT:C284($htmlText)

SET BLOB SIZE:C606(vx_HTMLBlob;0)

$parameters:=Num:C11($1)
$vt_Lineas:=String:C10($parameters)

If (Count parameters:C259=2)
	$estilo:=$2
Else 
	$estilo:=3  //en principio se ocupa solo para interfaz logica
End if 
If (Count parameters:C259=4)
	$namesArrayPtr:=$3
	$valuesArrayPtr:=$4
Else 
	ARRAY TEXT:C222($aNames;0)
	ARRAY TEXT:C222($aValues;0)
	$namesArrayPtr:=->$aNames
	$valuesArrayPtr:=->$aValues
End if 

If (Num:C11($vt_Lineas)=0)
	$vt_Lineas:="1"
End if 

$htmlText:=""

For ($i;1;Num:C11($vt_Lineas))
	If ($i=1)
		$htmlText:="<tr>"+"\r"+"<td width="+ST_Qte ("84")+" valign="+ST_Qte ("middle")+">Buscar en</td>"+"\r"
		$htmlText:=$htmlText+"<td width="+ST_Qte ("84")+"><div align="+ST_Qte ("center")+"><input src="+ST_Qte ("/images/3/mas.gif")+" name="+ST_Qte ("submitAdd")+" type="+ST_Qte ("image")+" id="+ST_Qte ("vt_agregar")+" border="+ST_Qte ("0")+"/></div></td>"+"\r"
	Else 
		$htmlText:=$htmlText+"<tr><td width="+ST_Qte ("84")+" valign="+ST_Qte ("middle")+"></td>"+"\r"+"<td width="+ST_Qte ("84")+"></td>"
	End if 
	$htmlText:=$htmlText+"<td colspan="+ST_Qte ("2")+"><select name="+ST_Qte ("vt_place"+String:C10($i))+" size="+ST_Qte ("1")+" id="+ST_Qte ("vt_place"+String:C10($i))+">"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_Place"+String:C10($i))="1");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("1")+">"+"Cualquier parte</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_Place"+String:C10($i))="2");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("2")+">"+"Materias</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_Place"+String:C10($i))="3");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("3")+">"+"T&iacute;tulo</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_Place"+String:C10($i))="4");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("4")+">"+"Autor</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_Place"+String:C10($i))="5");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("5")+">"+"Editor</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_Place"+String:C10($i))="6");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("6")+">"+"Resumen</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_Place"+String:C10($i))="7");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("7")+">"+"Contenido</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_Place"+String:C10($i))="8");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("8")+">"+"Serie</option></select>"+"\r"
	
	$htmlText:=$htmlText+"<select name="+ST_Qte ("vt_string"+String:C10($i))+" id="+ST_Qte ("vt_string"+String:C10($i))+">"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_string"+String:C10($i))="1");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("1")+">"+"comienza con</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_string"+String:C10($i))="2");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("2")+">"+"es igual a</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_string"+String:C10($i))="3");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("3")+">"+"es distinto de</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_string"+String:C10($i))="4");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("4")+">"+"es superior a</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_string"+String:C10($i))="5");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("5")+">"+"es superior o igual a</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_string"+String:C10($i))="6");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("6")+">"+"es inferior a</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_string"+String:C10($i))="7");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("7")+">"+"es inferior o igual a</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_string"+String:C10($i))="8");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("8")+">"+"contiene</option>"+"\r"
	$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_string"+String:C10($i))="9");" selected="+ST_Qte ("selected"))+" value="+ST_Qte ("9")+">"+"no contiene</option></select>"+"\r"
	
	$htmlText:=$htmlText+"<input name="+ST_Qte ("vt_keywords"+String:C10($i))+" type="+ST_Qte ("text")+" id="+ST_Qte ("vt_keywords"+String:C10($i))+" "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_keywords"+String:C10($i))#"");"value="+_O_Mac to ISO:C519(ST_Qte (NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_keywords"+String:C10($i)))))+"/>"+"\r"
	If ($i#1)
		$htmlText:=$htmlText+"<input src="+ST_Qte ("/images/3/menos.gif")+" name="+ST_Qte ("submit"+String:C10($i))+" type="+ST_Qte ("image")+" id="+ST_Qte ("vt_quitar"+String:C10($i))+" border="+ST_Qte ("0")+"/></td></tr>"+"\r"
	Else 
		$htmlText:=$htmlText+"</td></tr>"+"\r"
	End if 
	If ($i<Num:C11($vt_Lineas))
		$htmlText:=$htmlText+"<tr><td>&nbsp;</td><td><select name="+ST_Qte ("vt_option"+String:C10($i))+" id="+ST_Qte ("vt_option"+String:C10($i))+">"+"\r"
		$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_option"+String:C10($i))="1");"selected="+ST_Qte ("selected"))+" value="+ST_Qte ("1")+">"+"y</option>"+"\r"
		$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_option"+String:C10($i))="2");"selected="+ST_Qte ("selected"))+" value="+ST_Qte ("2")+">"+"o</option>"+"\r"
		$htmlText:=$htmlText+"<option "+ST_Boolean2Str ((NV_GetValueFromPairedArrays ($namesArrayPtr;$valuesArrayPtr;"vt_option"+String:C10($i))="3");"selected="+ST_Qte ("selected"))+" value="+ST_Qte ("3")+">"+"excepto</option></select></td></tr>"+"\r"
	End if 
End for 
$htmlText:=$htmlText+"<tr><td width="+ST_Qte ("84")+" valign="+ST_Qte ("top")+"></td>"+"\r"
$htmlText:=$htmlText+"<td width="+ST_Qte ("84")+" valign="+ST_Qte ("top")+"></td>"+"\r"
$htmlText:=$htmlText+"<td colspan="+ST_Qte ("2")+" valign="+ST_Qte ("top")+"><input name="+ST_Qte ("search")+" type="+ST_Qte ("submit")+" class="+ST_Qte ("mt_control_html")+" id="+ST_Qte ("vt_Search")+" value="+ST_Qte ("Buscar")+"/>"+"\r"
$htmlText:=$htmlText+"<input name="+ST_Qte ("reset")+" type="+ST_Qte ("submit")+" class="+ST_Qte ("mt_control_html")+" id="+ST_Qte ("vt_Reset")+" value="+ST_Qte ("Limpiar")+"/>"+"</td></tr>"
$htmlText:=Char:C90(1)+$htmlText
TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
WEB_SendHtmlFile ("Search_"+String:C10($estilo)+".shtml")