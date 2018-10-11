//%attributes = {}
  //xALP_CBIN_ACT_Boletas

C_BOOLEAN:C305($0)
C_LONGINT:C283($ALArea;$entryMethod;$1;$2;$3)

$ALArea:=$1
$entryMethod:=$2

AL_GetCurrCell (ALP_TiposdeDoc;vCol;vRow)

If (vCol>0)
	Case of 
		: (vCol=6)
			vOldNumber:=alACT_Proxima{vRow}
		: (vCol=vlACT_indexSincronizar)
			COPY ARRAY:C226(atACT_NombreDoc;atACT_NombreDoc2)
			AT_Delete (vRow;1;->atACT_NombreDoc2)
			AL_SetEnterable (ALP_TiposdeDoc;vlACT_indexSincronizar;2;atACT_NombreDoc2)
			AL_UpdateArrays (ALP_TiposdeDoc;-2)
	End case 
End if 