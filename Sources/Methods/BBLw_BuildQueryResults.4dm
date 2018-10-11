//%attributes = {"publishedWeb":true}
  //BBLw_BuildQueryResults

C_LONGINT:C283($copias)
ARRAY TEXT:C222($aClass;0)
ARRAY TEXT:C222($aAutor;0)
ARRAY TEXT:C222($aAutores;0)
ARRAY TEXT:C222($aTitle;0)
ARRAY TEXT:C222($aMedia;0)
ARRAY TEXT:C222($cutter;0)
ARRAY LONGINT:C221($aID;0)
ARRAY TEXT:C222($aFechaEdicion;0)
ARRAY INTEGER:C220($alBBL_CopiasDispo;0)
ARRAY TEXT:C222($aCopiasLugares;0)
C_BLOB:C604(vx_HTMLBlob)
C_TEXT:C284($htmlText;vt_Pages)


$page:=$1

SET BLOB SIZE:C606(vx_HTMLBlob;0)
$4DCGI_prefix:="HTTP://"+vtWEB_Host
vt_Pages:=""

If (Records in selection:C76([BBL_Items:61])>0)
	ARRAY LONGINT:C221($aRecNums;0)
	  //ticket188042 ABC agrego columna Autores.
	SELECTION TO ARRAY:C260([BBL_Items:61];$aRecNums;[BBL_Items:61]Clasificacion:2;$aClass;[BBL_Items:61]Cutter:47;$cutter;[BBL_Items:61]Primer_título:4;$aTitle;[BBL_Items:61]Primer_autor:6;$aAutor;[BBL_Items:61]Autores:7;$aAutores;[BBL_Items:61]Numero:1;$aID;[BBL_Items:61]Media:15;$aMedia;[BBL_Items:61]Copias_disponibles:43;$alBBL_CopiasDispo;[BBL_Items:61]Fecha_de_edicion:10;$aFechaEdicion)
	ARRAY TEXT:C222($aCopiasLugares;Size of array:C274($aRecNums))
	For ($iRecNum;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([BBL_Items:61];$aRecNums{$iRecNum})
		QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]StatusID:34=Disponible)
		CREATE SET:C116([BBL_Registros:66];"lugares")
		SELECTION TO ARRAY:C260([BBL_Registros:66]Lugar:13;$aLugares)
		AT_DistinctsArrayValues (->$aLugares)
		If (Size of array:C274($aLugares)>0)
			For ($i;1;Size of array:C274($aLugares))
				USE SET:C118("lugares")
				SET QUERY DESTINATION:C396(Into variable:K19:4;$copias)
				QUERY SELECTION:C341([BBL_Registros:66];[BBL_Registros:66]Lugar:13=$aLugares{$i})
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($aLugares{$i}#"")
					$aLugares{$i}:=" ("+$aLugares{$i}+")"
				Else 
					  //$aLugares{$i}:=" (Principal)"
				End if 
				If ($i=1)
					$aCopiasLugares{$iRecNum}:=$aCopiasLugares{$iRecNum}+String:C10($copias)+" "+$aLugares{$i}
				Else 
					$aCopiasLugares{$iRecNum}:=$aCopiasLugares{$iRecNum}+"<br />"+String:C10($copias)+" "+$aLugares{$i}
				End if 
			End for 
		Else 
			$aCopiasLugares{$iRecNum}:=String:C10([BBL_Items:61]Copias_disponibles:43)
		End if 
	End for 
	
	
	
	SORT ARRAY:C229($aTitle;$aAutor;$aAutores;$aClass;$aMedia;$aID;$alBBL_CopiasDispo;$aFechaEdicion;$aCopiasLugares;>)
	
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
				vt_Pages:=vt_Pages+" "+"<A HREF="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_GetResultPage/"+String:C10($i)+vt_searchString+"?estilo="+String:C10(1))+" "+HTML_mseOver ("Página "+String:C10($i))+">"+" "+String:C10($i)+"</A> |"+"\r"
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
	$tableTAG:="<table align="+ST_Qte ("Center")+" border="+ST_Qte ("0")+" cellpadding="+ST_Qte ("5")+" cellspacing="+ST_Qte ("2")+" width="+ST_Qte ("700")+" >"
	
	$htmlText:=$tableTag+"\r"
	$htmlText:=$htmlText+$hdrTAG+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Clasificaci&oacute;n </td>"+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Cutter </td>"+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("250")+">T&iacute;tulo</td>"+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Autor</td>"+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Autores</td>"+"\r"  //aregadoABC 188042 
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Media</td>"+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Copias Disp.</td>"+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">Edici&oacute;n</td></tr>"+"\r"
	
	TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
	For ($i;1;$size)
		If ($aTitle{$i+$offset}#"")
			If ($aClass{$i+$offset}="")
				$aClass{$i+$offset}:="&nbsp;"
			End if 
			$htmlText:=$rowTag+"\r"
			$tip:=HTML_mseOver ("Ver detalle de "+$aTitle{$i+$offset})
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aID{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+$aClass{$i+$offset}+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aID{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+$cutter{$i+$offset}+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aID{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+_O_Mac to ISO:C519($aTitle{$i+$offset})+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"+"\r"
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aID{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+_O_Mac to ISO:C519($aAutor{$i+$offset})+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"+"\r"
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aID{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+_O_Mac to ISO:C519($aAutores{$i+$offset})+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"+"\r"  //agregado. ABC 188042 
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aID{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+_O_Mac to ISO:C519($aMedia{$i+$offset})+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"+"\r"
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aID{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+$aCopiasLugares{$i+$offset}+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"
			$link:="<a href="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_SendItemDetail/"+String:C10($aID{$i+$offset})+"?estilo="+String:C10(1))+$tip+">"+$aFechaEdicion{$i+$offset}+"</A>"
			$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$link+"</td>"+"\r"+"</tr>"+"\r"
			TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
		End if 
	End for 
	TEXT TO BLOB:C554("</Table>";vx_HTMLBlob;Mac text without length:K22:10;*)
	$t_html:=BLOB to text:C555(vx_HTMLBlob;UTF8 text without length:K22:17)
	SET TEXT TO PASTEBOARD:C523($t_html)
	
Else 
	TEXT TO BLOB:C554(_O_Mac to ISO:C519("No existe ningún item que reponda a los criterios especificados.");vx_HTMLBlob;Mac text without length:K22:10;*)
End if 