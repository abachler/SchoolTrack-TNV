//%attributes = {"publishedWeb":true}
  //BBLw_recents

C_BLOB:C604(vx_HTMLBlob)
C_TEXT:C284($htmlText;vt_Pages)


SET BLOB SIZE:C606(vx_HTMLBlob;0)
$4DCGI_prefix:="HTTP://"+vtWEB_Host

SCAN INDEX:C350([BBL_Items:61]Numero:1;50;<)
BBLw_BuildRecentsPages (1)
WEB_SendHtmlFile ("recents_1.shtml")