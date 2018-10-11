ARRAY TEXT:C222($at_obNodes;0)
C_LONGINT:C283($i;$l_idTermometro)
C_OBJECT:C1216($o_subAsig)
C_POINTER:C301($y_nombre)
C_TEXT:C284($t_log)

$y_nombre:=(OBJECT Get pointer:C1124(Object named:K67:5;"nombres"))
$l_idTermometro:=IT_Progress (1;0;0;"Aplicando cambios...")
$t_log:="Cambios aplicados a los nombres de las parciales de las subasignaturas de forma masiva.\n"
For ($i;1;Size of array:C274(al_recNumSubAsig))  //periodos posibles actuales
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274(al_recNumSubAsig))
	READ WRITE:C146([xxSTR_Subasignaturas:83])
	GOTO RECORD:C242([xxSTR_Subasignaturas:83];al_recNumSubAsig{$i})
	$t_log:=$t_log+String:C10([xxSTR_Subasignaturas:83]ID_Mother:6)+" "+[xxSTR_Subasignaturas:83]Name:2+"("+String:C10([xxSTR_Subasignaturas:83]Columna:13)+"."+String:C10([xxSTR_Subasignaturas:83]Periodo:12)+")"+"\n"
	OB_GetChildNodes ([xxSTR_Subasignaturas:83]o_Data:21;->$at_obNodes)
	If (Size of array:C274($at_obNodes)=0)
		ASsev_InitArrays 
		ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
		READ WRITE:C146([xxSTR_Subasignaturas:83])
		GOTO RECORD:C242([xxSTR_Subasignaturas:83];al_recNumSubAsig{$i})
	End if 
	$o_subAsig:=[xxSTR_Subasignaturas:83]o_Data:21
	OB_SET ($o_subAsig;$y_nombre;"aSubEvalNombreParciales")
	[xxSTR_Subasignaturas:83]o_Data:21:=$o_subAsig
	SAVE RECORD:C53([xxSTR_Subasignaturas:83])
	KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
End for 
LOG_RegisterEvt ($t_log)
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
CANCEL:C270
