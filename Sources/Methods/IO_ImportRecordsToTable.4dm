//%attributes = {}
  // IO_ImportRecordsToTable()
  // Por: Alberto Bachler K.: 23-07-14, 12:43:30
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($i;$l_registros)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_nombreTabla)


If (False:C215)
	C_POINTER:C301(IO_ImportRecordsToTable ;$1)
End if 

$y_tabla:=$1


SET CHANNEL:C77(10;"")
If (ok=1)
	RECEIVE VARIABLE:C81($t_nombreTabla)
	RECEIVE VARIABLE:C81($l_registros)
	If ($t_nombreTabla=Table name:C256($y_tabla))
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando registros en el archivo ")+$t_nombreTabla)
		For ($i;1;$l_registros)
			RECEIVE RECORD:C79($y_tabla->)
			SAVE RECORD:C53($y_tabla->)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$l_registros)
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		CD_Dlog (0;__ ("Los datos del archivo seleccionado no corresponden al archivo recepcionante"))
	End if 
	SET CHANNEL:C77(11)
End if 