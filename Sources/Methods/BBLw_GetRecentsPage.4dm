//%attributes = {}
  //BBLw_GetRecentsPage

$parameters:=$1

$page:=Num:C11(Substring:C12($parameters;1;Position:C15("&";$parameters)-1))

SET BLOB SIZE:C606(vx_HTMLBlob;0)
$4DCGI_prefix:="HTTP://"+vtWEB_Host

SCAN INDEX:C350([BBL_Items:61]Numero:1;50;<)
BBLw_BuildRecentsPages ($page;$estilo)
WEB_SendHtmlFile ("recents_1.shtml")