C_BLOB:C604(vx_blob)
$fileName:=""
SET CHANNEL:C77(12;$fileName)
BLOB_Variables2Blob (->vx_blob;0;->aSourceDataName;->aSourceDataElement;->vtIOstr_FilePath;->viIOstr_PlatFormSource;->aRecordFieldKey)
vt_signature:="SchoolTrack Students Import Template"
SEND VARIABLE:C80(vt_signature)
SEND VARIABLE:C80(vx_blob)
SET CHANNEL:C77(11)
SET BLOB SIZE:C606(vx_blob;0)