//%attributes = {}
  // UD_20130214_PropAsignaturas()
  // Por: Alberto Bachler: 14/02/13, 15:34:28
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_consolida;$b_conSubasignaturas)
C_LONGINT:C283($i;$j)
C_TEXT:C284($t_NombreRegistroPropiedades)

ARRAY LONGINT:C221($al_RecNums;0)



PERIODOS_Init 
ALL RECORDS:C47([Asignaturas:18])
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNums;"")
For ($i_asignaturas;1;Size of array:C274($al_RecNums))
	KRL_GotoRecord (->[Asignaturas:18];$al_RecNums{$i_asignaturas};True:C214)
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		$b_consolida:=False:C215
		$b_conSubasignaturas:=False:C215
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			$t_NombreRegistroPropiedades:="Blob_ConfigNotas/"+String:C10([Asignaturas:18]Numero:1)+"/P"+String:C10($i)
			AS_PropEval_Lectura ($t_NombreRegistroPropiedades)
			For ($j;1;Size of array:C274(alAS_EvalPropSourceID))
				Case of 
					: (alAS_EvalPropSourceID{$j}>0)
						$b_consolida:=True:C214
					: (alAS_EvalPropSourceID{$j}<0)
						$b_conSubasignaturas:=True:C214
				End case 
			End for 
		End for 
	Else 
		$t_NombreRegistroPropiedades:="Blob_ConfigNotas/"+String:C10([Asignaturas:18]Numero:1)
		AS_PropEval_Lectura ($t_NombreRegistroPropiedades)
		$b_consolida:=False:C215
		$b_conSubasignaturas:=False:C215
		For ($j;1;Size of array:C274(alAS_EvalPropSourceID))
			Case of 
				: (alAS_EvalPropSourceID{$j}>0)
					$b_consolida:=True:C214
				: (alAS_EvalPropSourceID{$j}<0)
					$b_conSubasignaturas:=True:C214
			End case 
		End for 
	End if 
	
	
	If ([Asignaturas:18]Consolidacion_EsConsolidante:35#(($b_consolida | $b_conSubasignaturas)))
		KRL_GotoRecord (->[Asignaturas:18];$al_RecNums{$i_asignaturas};True:C214)
		[Asignaturas:18]Consolidacion_EsConsolidante:35:=True:C214
		SAVE RECORD:C53([Asignaturas:18])
	End if 
	
	If ([Asignaturas:18]Consolidacion_ConSubasignaturas:31#$b_conSubasignaturas)
		KRL_GotoRecord (->[Asignaturas:18];$al_RecNums{$i_asignaturas};True:C214)
		[Asignaturas:18]Consolidacion_ConSubasignaturas:31:=$b_conSubasignaturas
		SAVE RECORD:C53([Asignaturas:18])
	End if 
	
End for 


