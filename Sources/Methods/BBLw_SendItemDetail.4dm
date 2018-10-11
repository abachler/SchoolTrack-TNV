//%attributes = {"publishedWeb":true}
  // BBLw_SendItemDetail()
  //
  //
  // creado por: Alberto Bachler Klein: 09-01-16, 17:01:02
  // -----------------------------------------------------------
C_LONGINT:C283($i_campos)
C_TEXT:C284($t_refjSon)
C_OBJECT:C1216($ob_Materias)

ARRAY TEXT:C222($at_Materias;0)
ARRAY TEXT:C222($at_palabrasIndexadas;0)
ARRAY TEXT:C222($at_Temp;0)


C_BLOB:C604(vx_HTMLBlob)
SET BLOB SIZE:C606(vx_HTMLBlob;0)
SET BLOB SIZE:C606(vx_Analiticos;0)



$4DCGI_prefix:="HTTP://"+vtWEB_Host


READ ONLY:C145([BBL_Items:61])
READ ONLY:C145([BBL_Registros:66])
QUERY:C277([BBL_Items:61];[BBL_Items:61]Numero:1=$1)

vt_subjects:=""
vt_Copies:=""
vt_keywords:=""
vs_ReserveBtn:=""


  //$t_refjSon:=JSON Parse text ([BBL_Items]Materias_json)
  //JSON_ExtraeValorElemento ($t_refjSon;->$at_Materias;"materiasCatalogacion_KW")
  //JSON CLOSE ($t_refjSon)
$ob_Materias:=OB_JsonToObject ([BBL_Items:61]Materias_json:53)
OB_GET ($ob_Materias;->$at_materias;"materiasCatalogacion_KW")


For ($i;1;Size of array:C274($at_Materias))
	vt_subjects:=vt_subjects+"<A HREF="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_QuerybySubject/"+$at_Materias{$i}+"?estilo="+String:C10(1))+HTML_mseOver ($at_Materias{$i})+">"+String:C10($i)+"."+$at_Materias{$i}+"</A><BR>"+"\r"
End for 


ARRAY POINTER:C280($ay_camposIndexados;7)
$ay_camposIndexados{1}:=->[BBL_Items:61]Titulos:5
$ay_camposIndexados{2}:=->[BBL_Items:61]Autores:7
$ay_camposIndexados{3}:=->[BBL_Items:61]Editores:9
$ay_camposIndexados{4}:=->[BBL_Items:61]Resumen:17
$ay_camposIndexados{5}:=->[BBL_Items:61]Serie_Nombre:26
$ay_camposIndexados{6}:=->[BBL_Items:61]Notas:16
$ay_camposIndexados{7}:=->[BBL_Items:61]NotasDeContenido:50
For ($i_campos;1;Size of array:C274($ay_camposIndexados))
	DISTINCT VALUES:C339($ay_camposIndexados{$i_campos}->;$at_Temp)
	For ($i;1;Size of array:C274($at_temp))
		If ($at_temp{$i}#"")
			If (Find in array:C230($at_palabrasIndexadas;$at_temp{$i})=-1)
				APPEND TO ARRAY:C911($at_palabrasIndexadas;$at_temp{$i})
			End if 
		End if 
	End for 
End for 

For ($i;1;Size of array:C274($at_palabrasIndexadas))
	vt_keywords:=vt_keywords+"<A HREF="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_QuerybyKeyword/"+$at_palabrasIndexadas{$i}+"?estilo="+String:C10(1))+HTML_mseOver ($at_palabrasIndexadas{$i})+">"+String:C10($i)+"."+$at_palabrasIndexadas{$i}+"</A><BR>"+"\r"
End for 

QUERY:C277([BBL_RegistrosAnaliticos:74];[BBL_RegistrosAnaliticos:74]ID:1=[BBL_Items:61]Numero:1)
If (Records in selection:C76([BBL_RegistrosAnaliticos:74])>0)
	SELECTION TO ARRAY:C260([BBL_RegistrosAnaliticos:74]Autores:5;$autores;[BBL_RegistrosAnaliticos:74]Titulos:3;$titulos;[BBL_RegistrosAnaliticos:74]Paginas:6;$paginas)
	SORT ARRAY:C229($titulos;$autores;$paginas;>)
	$HdrTAG:="<tr>"
	$rowTAG:="<tr>"
	$tableTAG:="<h2><p align=\"center\">"+_O_Mac to ISO:C519("Registro Analíticos")+"\r"+"<table align="+ST_Qte ("Center")+" border="+ST_Qte ("0")+" cellpadding="+ST_Qte ("5")+" cellspacing="+ST_Qte ("2")+" width="+ST_Qte ("600")+" >"
	
	$htmlText:=$tableTag+"\r"
	$htmlText:=$htmlText+$hdrTAG+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("300")+">"+_O_Mac to ISO:C519("Título")+"</td>"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("200")+">Autor</td>"+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("100")+">"+_O_Mac to ISO:C519("Extensión")+"</td>"+"\r"+"</tr>"+"\r"
	TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
	For ($i;1;Size of array:C274($autores))
		$htmlText:=$rowTag+"\r"
		$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+_O_Mac to ISO:C519($titulos{$i})+"</td>"+"\r"
		$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+_O_Mac to ISO:C519($autores{$i})+"</td>"+"\r"
		$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+_O_Mac to ISO:C519($paginas{$i})+"</td>"+"\r"+"</tr>"+"\r"
		TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
	End for 
	$htmlText:="</Table>"
	TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
	TEXT TO BLOB:C554("</p>";vx_HTMLBlob;Mac text without length:K22:10;*)
End if 

QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
If (Records in selection:C76([BBL_Registros:66])>0)
	SELECTION TO ARRAY:C260([BBL_Registros:66]Prestado_hasta:14;$aDate;[BBL_Registros:66]Status:10;$aStatus;[BBL_Registros:66]Lugar:13;$aLugar;[BBL_Registros:66]No_Registro:25;$aNoReg)
	$HdrTAG:="<tr>"
	$rowTAG:="<tr>"
	$tableTAG:="<h2><p align=\"center\">"+"Copias"+"\r"+"</h2><table align="+ST_Qte ("Center")+" border="+ST_Qte ("0")+" cellpadding="+ST_Qte ("5")+" cellspacing="+ST_Qte ("2")+" width="+ST_Qte ("600")+" >"
	
	$htmlText:=$tableTag+"\r"
	$htmlText:=$htmlText+$hdrTAG+"\r"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("150")+">No de registro</td>"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("250")+">Status</td>"
	$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_encabezado")+" width="+ST_Qte ("200")+">Lugar</td>"+"\r"+"</tr>"+"\r"
	TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
	For ($i;1;Size of array:C274($aNoReg))
		If ($aStatus{$i}=<>aCpyStatus{2})
			$status:=$aStatus{$i}+" hasta el "+String:C10($adate{$i};3)
			$lugar:=""
		Else 
			$status:=$aStatus{$i}
			$lugar:=$aLugar{$i}
		End if 
		$htmlText:=$rowTag+"\r"
		$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+String:C10($aNoReg{$i})+"</td>"+"\r"
		$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$status+"</td>"
		$htmlText:=$htmlText+"<td class="+ST_Qte ("mt_tabla_cuerpo")+">"+$lugar+"</td>"+"\r"+"</tr>"+"\r"
		TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
	End for 
	$htmlText:="</Table>"
	TEXT TO BLOB:C554($htmlText;vx_HTMLBlob;Mac text without length:K22:10;*)
	TEXT TO BLOB:C554("</p>";vx_HTMLBlob;Mac text without length:K22:10;*)
	
	vs_ReserveBtn:=_O_Mac to ISO:C519("(No se permiten reservas sobre este ítem)")
	KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaItems:69]Codigo_regla:1;->[BBL_Items:61]Regla:20)
	If ([xxBBL_ReglasParaItems:69]Reserva_Permitida:9)
		If ((Find in array:C230($aStatus;<>aCpyStatus{1})>0) | (Find in array:C230($aStatus;<>aCpyStatus{2})>0) | (Find in array:C230($aStatus;<>aCpyStatus{3})>0))
			vs_ReserveBtn:="<A HREF="+ST_Qte ($4DCGI_prefix+"/4DCGI/BBLw_Reservation/"+String:C10([BBL_Items:61]Numero:1)+"?estilo="+String:C10(1))+HTML_mseOver ([BBL_Items:61]Primer_título:4)+">Reservar</A>"
		End if 
	End if 
Else 
	vt_Copies:=_O_Mac to ISO:C519(__ ("No existe ninguna copia registrada de este item."))
End if 
WEB_SendHtmlFile ("docview_1.shtml")