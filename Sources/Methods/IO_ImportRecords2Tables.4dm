//%attributes = {}
  // IO_ImportRecords2Tables()
  // Por: Alberto Bachler K.: 23-07-14, 12:50:36
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($i;$j;$l_numeroTabla;$l_numeroTablas;$l_registros)
C_POINTER:C301($y_Tabla)
C_TEXT:C284($t_RutaDocumento;$t_nombreTabla)

If (Count parameters:C259=1)
	$t_RutaDocumento:=$1
Else 
	$t_RutaDocumento:=""
End if 


SET CHANNEL:C77(10;$t_RutaDocumento)

If (ok=1)
	RECEIVE VARIABLE:C81($l_numeroTablas)
	For ($j;1;$l_numeroTablas)
		RECEIVE VARIABLE:C81($l_numeroTabla)
		RECEIVE VARIABLE:C81($t_nombreTabla)
		RECEIVE VARIABLE:C81($l_registros)
		$y_Tabla:=Table:C252($l_numeroTabla)
		
		If ($t_nombreTabla=Table name:C256($l_numeroTabla))
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando registros en el archivo ")+$t_nombreTabla)
			For ($i;1;$l_registros)
				RECEIVE RECORD:C79($y_Tabla->)
				SAVE RECORD:C53($y_Tabla->)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$l_registros)
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		Else 
			ALERT:C41("Los datos exportados no corresponden al archivo que debe recibirlos")
			$j:=$l_numeroTablas
		End if 
	End for 
End if 


SET CHANNEL:C77(11)  //20160716 RCH