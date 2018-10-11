//%attributes = {}
  //QR_LoadUpdaterSettings

C_BLOB:C604($updaterSettings)
C_TEXT:C284(vtRU_DTSLast)

QR_InitUpdaterSettings 

$ot:=OT New 
OT PutText ($ot;"ultima";vtRU_LastUpdate)
OT PutLong ($ot;"buscar";cb_SearchWhen)
OT PutLong ($ot;"cuando";vlRU_CadaCuanto)
OT PutLong ($ot;"descargar";cb_AutoDownload)
OT PutText ($ot;"lastDTS";vtRU_DTSLast)

$updaterSettings:=OT ObjectToNewBLOB ($ot)
OT Clear ($ot)


$updaterSettings:=PREF_fGetBlob (0;"ReportUpdaterSettings";$updaterSettings)

$ot:=OT BLOBToObject ($updaterSettings)

vtRU_LastUpdate:=OT GetText ($ot;"ultima")
cb_SearchWhen:=OT GetLong ($ot;"buscar")
vlRU_CadaCuanto:=OT GetLong ($ot;"cuando")
cb_AutoDownload:=OT GetLong ($ot;"descargar")
vtRU_DTSLast:=OT GetText ($ot;"lastDTS")

OT Clear ($ot)