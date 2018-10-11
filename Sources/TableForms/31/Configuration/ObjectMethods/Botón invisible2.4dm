WDW_OpenFormWindow (->[xxSTR_Constants:1];"ADTcfg_ColegiosGrupo";0;-Palette form window:K39:9;__ ("Colegios Grupo"))
DIALOG:C40([xxSTR_Constants:1];"ADTcfg_ColegiosGrupo")
CLOSE WINDOW:C154
C_BLOB:C604(blob)
SET BLOB SIZE:C606(blob;0)
BLOB_Variables2Blob (->blob;0;->aColegiosGrupo)
PREF_SetBlob (0;"colegiosgrupo";blob)
SET BLOB SIZE:C606(blob;0)