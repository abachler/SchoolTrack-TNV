//%attributes = {}
  //ADTcdd_InputForm
  //Setea la visibilidad incial del motivo 

ARRAY TEXT:C222($at_motivos;0)
C_BLOB:C604($vx_motivos)
C_BOOLEAN:C305($vb_saltaEstados;$vb_motivoVisible)

READ ONLY:C145([xxADT_LogCambioEstado:162])
ADTcdd_CargaLogCambioEstado 
REDUCE SELECTION:C351([xxADT_LogCambioEstado:162];1)
FIRST RECORD:C50([xxADT_LogCambioEstado:162])

hl_motivos:=New list:C375
For ($i;1;Size of array:C274(<>aMotivosEstados))
	APPEND TO LIST:C376(hl_motivos;<>aMotivosEstados{$i};$i)
	If ([xxADT_LogCambioEstado:162]Motivo:8#"") & (<>aMotivosEstados{$i}=[xxADT_LogCambioEstado:162]Motivo:8)
		SELECT LIST ITEMS BY POSITION:C381(hl_motivos;$i)
	End if 
End for 

$vx_Motivos:=PREF_fGetBlob (0;"EstadosConMotivo";$vx_motivos)
BLOB_Blob2Vars (->$vx_motivos;0;->$at_motivos)

$vb_motivoVisible:=False:C215
If (Not:C34(Find in array:C230($at_motivos;[ADT_Candidatos:49]Estado:52)#-1))
	SET BLOB SIZE:C606($vx_motivos;0)
	ARRAY TEXT:C222($at_motivos;0)
	
	$vb_motivoVisible:=True:C214
	$vx_motivos:=PREF_fGetBlob (0;"EstadosConMotivoObl";$vx_motivos)
	BLOB_Blob2Vars (->$vx_motivos;0;->$at_motivos)
	
	If (Not:C34(Find in array:C230($at_motivos;[ADT_Candidatos:49]Estado:52)#-1))
		$vb_motivoVisible:=False:C215
	End if 
End if 

OBJECT SET VISIBLE:C603(*;"mMotiv@";$vb_motivoVisible)