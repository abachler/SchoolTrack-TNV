//%attributes = {}
  //ACTxx_BuildMonedas

ARRAY TEXT:C222(atACT_NombreMoneda;0)
ARRAY REAL:C219(arACT_ValorMoneda;0)
LIST TO ARRAY:C288("ACT_Monedas";atACT_NombreMoneda)
ARRAY REAL:C219(arACT_ValorMoneda;Size of array:C274(atACT_NombreMoneda))
ARRAY TEXT:C222(atACT_SimboloMoneda;Size of array:C274(atACT_NombreMoneda))
arACT_ValorMoneda{1}:=1


atACT_SimboloMoneda{1}:="$"
atACT_SimboloMoneda{2}:="UF"
atACT_SimboloMoneda{3}:="US$"
atACT_SimboloMoneda{4}:="€"

SET BLOB SIZE:C606(xBlob;0)
BLOB_Variables2Blob (->xBlob;0;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda)
PREF_SetBlob (0;"ACT_Monedas";xBlob)
SET BLOB SIZE:C606(xBlob;0)
