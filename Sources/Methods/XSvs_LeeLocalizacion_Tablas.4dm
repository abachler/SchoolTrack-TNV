//%attributes = {"executedOnServer":true}
  // XSvs_LeeLocalizacion_Tablas()
  // Por: Alberto Bachler: 06/03/13, 12:25:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BLOB:C604($x_blob)
C_LONGINT:C283($i;$l_desde;$l_eliminarDesde)
C_TEXT:C284($t_codigoPaisLenguaje;$t_documentoTablas;$t_dtsModificacionTablas)

ARRAY TEXT:C222($at_alias;0)
ARRAY TEXT:C222($at_DTS;0)
ARRAY TEXT:C222($at_paisLenguaje;0)
ARRAY TEXT:C222($at_tableRef;0)
If (False:C215)
	C_TEXT:C284(XSvs_LeeLocalizacion_Tablas ;$1)
	C_TEXT:C284(XSvs_LeeLocalizacion_Tablas ;$2)
	C_TEXT:C284(XSvs_LeeLocalizacion_Tablas ;$3)
End if 


$t_documentoTablas:=$1
$t_codigoPaisLenguaje:=$2
$t_dtsModificacionTablas:=$3

DOCUMENT TO BLOB:C525($t_documentoTablas;$x_blob)
BLOB_ExpandBlob_byPointer (->$x_blob)
BLOB_Blob2Vars (->$x_blob;0;->$at_tableRef;->$at_DTS;->$at_paisLenguaje;->$at_alias)
AT_MultiLevelSort (">>";->$at_paisLenguaje;->$at_DTS;->$at_alias;->$at_tableRef)

$l_desde:=Find in array:C230($at_paisLenguaje;$t_codigoPaisLenguaje)
If ($l_desde>1)
	AT_Delete (1;$l_desde-1;->$at_tableRef;->$at_DTS;->$at_paisLenguaje;->$at_alias)
End if 

$l_eliminarDesde:=0
For ($i;1;Size of array:C274($at_paisLenguaje))
	If ($at_paisLenguaje{$i}#$t_codigoPaisLenguaje)
		$l_eliminarDesde:=$i
		$i:=Size of array:C274($at_paisLenguaje)
	End if 
End for 

If ($l_eliminarDesde>0)
	AT_RedimArrays ($l_eliminarDesde-1;->$at_tableRef;->$at_DTS;->$at_paisLenguaje;->$at_alias)
End if 
AT_Populate (->$at_DTS;->$t_dtsModificacionTablas)
QUERY WITH ARRAY:C644([xShell_TableAlias:199]TableRef:1;$at_tableRef)
READ WRITE:C146([xShell_TableAlias:199])
ARRAY TO SELECTION:C261($at_tableRef;[xShell_TableAlias:199]TableRef:1;$at_DTS;[xShell_TableAlias:199]DTS:3;$at_paisLenguaje;[xShell_TableAlias:199]PaisLenguaje:4;$at_alias;[xShell_TableAlias:199]Alias:2)
KRL_UnloadReadOnly (->[xShell_TableAlias:199])
