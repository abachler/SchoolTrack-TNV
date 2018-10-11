//%attributes = {}
  //ACTpgs_RecalcularAvisos

  //En $1 se pasa un puntero a un arreglo con los rec nums de los avisos a recalcular!!!

If (Count parameters:C259=2)
	$Display:=$2
Else 
	$Display:=True:C214
End if 
If (Size of array:C274($1->)>0)
	If ($Display)
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$1->{1})
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando aviso de cobranza N° ")+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+__ ("..."))
		UNLOAD RECORD:C212([ACT_Avisos_de_Cobranza:124])
	End if 
	$iterations:=Size of array:C274($1->)
	
	For ($i;1;Size of array:C274($1->))
		READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$1->{$i})
		ACTac_Recalcular (Record number:C243([ACT_Avisos_de_Cobranza:124]))
		If (($Display) & ($i<Size of array:C274($1->)))
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$1->{$i+1})
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$iterations;__ ("Recalculando aviso de cobranza N° ")+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+__ ("..."))
			UNLOAD RECORD:C212([ACT_Avisos_de_Cobranza:124])
		End if 
	End for 
	If ($Display)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
End if 