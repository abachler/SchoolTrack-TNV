//%attributes = {}
  //ACTtrf_IsColegiumTransferFile

C_TEXT:C284($1)

$0:=((Position:C15("ColegiumTransferFile";$1)#0) & ((Position:C15("importer";$1)#0) | (Position:C15("exporter";$1)#0)))