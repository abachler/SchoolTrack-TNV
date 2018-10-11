//%attributes = {}
  // IO_ExportRecordsFromTable()
  // Por: Alberto Bachler K.: 23-07-14, 13:17:56
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($i;$l_registros)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_nombreTabla)


If (False:C215)
	C_POINTER:C301(IO_ExportRecordsFromTable ;$1)
End if 

$y_tabla:=$1
SET CHANNEL:C77(12;"")
If (ok=1)
	$l_registros:=Records in selection:C76($y_tabla->)
	$t_nombreTabla:=Table name:C256($y_tabla)
	SEND VARIABLE:C80($t_nombreTabla)
	SEND VARIABLE:C80($l_registros)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando registros del archivo ")+$t_nombreTabla)
	For ($i;1;$l_registros)
		SEND RECORD:C78($y_tabla->)
		NEXT RECORD:C51($y_tabla->)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$l_registros)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SET CHANNEL:C77(11)
End if 