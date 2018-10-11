//%attributes = {}
  //ACTtrf_DetectFileType

C_TEXT:C284($1)
C_BOOLEAN:C305($importer;$exporter;$0)

$importer:=(Position:C15("importer";$1)#0)
$exporter:=(Position:C15("exporter";$1)#0)

Case of 
	: ($importer)
		$0:=$importer
	: ($exporter)
		$0:=Not:C34($exporter)
End case 