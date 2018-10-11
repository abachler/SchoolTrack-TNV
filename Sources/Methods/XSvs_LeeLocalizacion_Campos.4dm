//%attributes = {"executedOnServer":true}
  // XSvs_LeeLocalizacion_Campos()
  // Por: Alberto Bachler: 06/03/13, 13:00:46
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
ARRAY TEXT:C222($at_refTablaCampo;0)
If (False:C215)
	C_TEXT:C284(XSvs_LeeLocalizacion_Campos ;$1)
	C_TEXT:C284(XSvs_LeeLocalizacion_Campos ;$2)
	C_TEXT:C284(XSvs_LeeLocalizacion_Campos ;$3)
End if 


$t_documentoTablas:=$1
$t_codigoPaisLenguaje:=$2
$t_dtsModificacionTablas:=$3


DOCUMENT TO BLOB:C525($t_documentoTablas;$x_blob)
BLOB_ExpandBlob_byPointer (->$x_blob)
BLOB_Blob2Vars (->$x_blob;0;->$at_tableRef;->$at_fieldRef;->$at_DTS;->$at_paisLenguaje;->$at_alias;->$at_refTablaCampo)
AT_MultiLevelSort (">>";->$at_paisLenguaje;->$at_DTS;->$at_tableRef;->$at_fieldRef;->$at_alias;->$at_refTablaCampo)

$l_desde:=Find in array:C230($at_paisLenguaje;"@"+$t_codigoPaisLenguaje)
If ($l_desde>1)
	AT_Delete (1;$l_desde-1;->$at_fieldRef;->$at_tableRef;->$at_DTS;->$at_paisLenguaje;->$at_alias;->$at_refTablaCampo)
End if 

$l_eliminarDesde:=0
For ($i;1;Size of array:C274($at_paisLenguaje))
	If ($at_paisLenguaje{$i}#$t_codigoPaisLenguaje)
		$l_eliminarDesde:=$i
		$i:=Size of array:C274($at_paisLenguaje)
	End if 
End for 

If ($l_eliminarDesde>0)
	AT_RedimArrays ($l_eliminarDesde-1;->$at_fieldRef;->$at_tableRef;->$at_DTS;->$at_paisLenguaje;->$at_alias;->$at_refTablaCampo)
End if 
AT_Populate (->$at_DTS;->$t_dtsModificacionTablas)
QUERY WITH ARRAY:C644([xShell_FieldAlias:198]FieldRef:5;$at_fieldRef)
READ WRITE:C146([xShell_FieldAlias:198])
ARRAY TO SELECTION:C261($at_fieldRef;[xShell_FieldAlias:198]FieldRef:5;$at_tableRef;[xShell_FieldAlias:198]TableRef:2;$at_DTS;[xShell_FieldAlias:198]DTS:7;$at_paisLenguaje;[xShell_FieldAlias:198]PaisLenguaje:6;$at_alias;[xShell_FieldAlias:198]Alias:3;$at_refTablaCampo;[xShell_FieldAlias:198]Referencia_tablaCampo:1)
KRL_UnloadReadOnly (->[xShell_FieldAlias:198])

