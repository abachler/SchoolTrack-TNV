//%attributes = {}
  //BBLw_BuildRecentsPages

ARRAY TEXT:C222($aClass;0)
ARRAY TEXT:C222($aAutor;0)
ARRAY TEXT:C222($aTitle;0)
ARRAY TEXT:C222($aMedia;0)
ARRAY LONGINT:C221($aID;0)
ARRAY INTEGER:C220($alBBL_CopiasDispo;0)
C_BLOB:C604(vx_HTMLBlob)
C_TEXT:C284($htmlText;vt_Pages)


$page:=$1

SET BLOB SIZE:C606(vx_HTMLBlob;0)
$4DCGI_prefix:="HTTP://"+vtWEB_Host
vt_Pages:=""

If (Records in selection:C76([BBL_Items:61])>0)
	SELECTION TO ARRAY:C260([BBL_Items:61]Clasificacion:2;$aClass;[BBL_Items:61]Primer_título:4;$aTitle;[BBL_Items:61]Primer_autor:6;$aAutor;[BBL_Items:61]Numero:1;$aId;[BBL_Items:61]Media:15;$aMedia;[BBL_Items:61]Fecha_de_creacion:36;$aDate)
	SORT ARRAY:C229($aTitle;$aDate;$aAutor;$aClass;$aMedia;$aID;>)
	
	If (Size of array:C274($aID)>10)
		$pages:=Size of array:C274($aID)/10
		If (Dec:C9($pages)>0)
			$pages:=Int:C8($pages)+1
		End if 
		If ($page>1)
			$first:=(($page-1)*10)+1
			$last:=$first+9
		Else 
			$first:=1
			$last:=10
		End if 
		vt_Pages:="|"
		For ($i;1;$pages)
			If ($i=$page)
				vt_Pages:=vt_Pages+" "+String:C10($i)+" |"+"\r"
			Else 
				vt_Pages:=vt_Pages+" "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_GetRecentsPage/"+String:C10($i)+"&?estilo="+String:C10(1))+" "+HTML_mseOver ("Página "+String:C10($i))+">"+" "+String:C10($i)+"</A> |"+"\r"
			End if 
		End for 
	Else 
		vt_pages:=""
		$first:=1
		$last:=Size of array:C274($aID)
	End if 
	
	$size:=$last-$first+1
	$offset:=$first-1
	If (($size+$offset)>Size of array:C274($aID))
		$size:=Size of array:C274($aID)-$offset
	End if 
	
	$HdrTAG:="<tr>"
	$rowTAG:="<tr>"
	$tableTAG:="<table align="+ST_Qte ("Center")+" border="+ST_Qte ("0")+" cellpadding="+ST_Qte ("5")+" cellspacing="+ST_Qte ("2")+" width="+ST_Qte ("600")+">"
	
	$htmlText:=$tableTag+"\r"
	$htmlText:=$htmlText+$hdrTAG+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Clasificaci&oacute;n</td>"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("250")+">T&iacute;tulo</td>"+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Autor</td>"+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Media</td>"+"\r"+"</tr>"+"\r"
	TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
	For ($i;1;$size)
		If (($aTitle{$i+$offset}#"") & ($aClass{$i+$offset}#""))
			$htmlText:=$rowTag+"\r"
			$tip:=HTML_mseOver ("Ver detalle de "+$aTitle{$i+$offset})
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aId{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+_O_Mac to ISO:C519($aClass{$i+$offset})+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aId{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+_O_Mac to ISO:C519($aTitle{$i+$offset})+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"+"\r"
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aId{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+_O_Mac to ISO:C519($aAutor{$i+$offset})+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"+"\r"
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aId{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+_O_Mac to ISO:C519($aMedia{$i+$offset})+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"+"\r"+"</tr>"+"\r"
			TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
		End if 
	End for 
	TEXT TO BLOB:C554("</Table>";vx_HTMLBlob;Mac text without length:K22:10;*)
Else 
	vt_table:=_O_Mac to ISO:C519("La biblioteca no ha adquirido ningún item en los últimos 30 días.")
	TEXT TO BLOB:C554(vt_table;vx_HTMLBlob;Mac text without length:K22:10)
End if 