//%attributes = {}
  //dbuACT_GeneraDirEC

C_LONGINT:C283($t)
C_LONGINT:C283($x)
C_TEXT:C284($direccion)
C_TEXT:C284($resto)
C_LONGINT:C283($vl_accion)

READ ONLY:C145([Familia:78])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ WRITE:C146([Personas:7])
ARRAY LONGINT:C221($aPersonas;0)

If (Count parameters:C259=1)
	$vl_accion:=$1
End if 

Case of 
	: ($vl_accion=0)  //copia desde familia a personas
		ALL RECORDS:C47([Personas:7])
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando dirección de envío de correspondencia a apoderados de cuenta..."))
		LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aPersonas;"")
		For ($t;1;Size of array:C274($aPersonas))
			GOTO RECORD:C242([Personas:7];$aPersonas{$t})
			ACT_relacionaCtasyApdos (2)
			GOTO RECORD:C242([Personas:7];$aPersonas{$t})
			KRL_RelateSelection (->[Familia:78]Numero:1;->[ACT_CuentasCorrientes:175]ID_Familia:2;"")
			REDUCE SELECTION:C351([Familia:78];1)
			$direccion:=ST_GetWord ([Familia:78]Direccion_Postal:29;1;"\r")
			[Personas:7]ACT_DireccionEC:67:=$direccion
			$resto:=Replace string:C233([Familia:78]Direccion_Postal:29;$direccion;"")
			For ($x;1;Size of array:C274(<>aComuna))
				If (Position:C15(<>aComuna{$x};$resto)#0)
					[Personas:7]ACT_ComunaEC:68:=<>aComuna{$x}
					$resto:=ST_GetCleanString (Replace string:C233(Replace string:C233($resto;<>aComuna{$x};"");"\r";" "))
					[Personas:7]ACT_CodPostalEC:70:=$resto
					$x:=Size of array:C274(<>aComuna)+1
				End if 
			End for 
			[Personas:7]ACT_CiudadEC:69:=[Familia:78]Ciudad:9
			SAVE RECORD:C53([Personas:7])
			NEXT RECORD:C51([Personas:7])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$t/Size of array:C274($aPersonas);__ ("Asignando dirección de envío de correspondencia a apoderados de cuenta..."))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		KRL_UnloadReadOnly (->[Personas:7])
		
	: ($vl_accion=2)  //copia dirección desde personas a personas 
		ALL RECORDS:C47([Personas:7])
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando dirección de envío de correspondencia a apoderados de cuenta..."))
		LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aPersonas;"")
		For ($t;1;Size of array:C274($aPersonas))
			GOTO RECORD:C242([Personas:7];$aPersonas{$t})
			[Personas:7]ACT_DireccionEC:67:=[Personas:7]Direccion:14
			[Personas:7]ACT_ComunaEC:68:=[Personas:7]Comuna:16
			[Personas:7]ACT_CodPostalEC:70:=[Personas:7]Codigo_postal:15
			[Personas:7]ACT_CiudadEC:69:=[Personas:7]Ciudad:17
			SAVE RECORD:C53([Personas:7])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$t/Size of array:C274($aPersonas);__ ("Asignando dirección de envío de correspondencia a apoderados de cuenta..."))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		KRL_UnloadReadOnly (->[Personas:7])
		
	: ($vl_accion=3)  //para los registros seleccionados copia dirección desde personas a personas 
		If (Application type:C494#4D Server:K5:6)
			If (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				$el:=BWR_SearchRecords 
				If ($el#-1)
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando dirección de envío de correspondencia a apoderados de cuenta..."))
					LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aPersonas;"")
					For ($t;1;Size of array:C274($aPersonas))
						GOTO RECORD:C242([Personas:7];$aPersonas{$t})
						[Personas:7]ACT_DireccionEC:67:=[Personas:7]Direccion:14
						[Personas:7]ACT_ComunaEC:68:=[Personas:7]Comuna:16
						[Personas:7]ACT_CodPostalEC:70:=[Personas:7]Codigo_postal:15
						[Personas:7]ACT_CiudadEC:69:=[Personas:7]Ciudad:17
						SAVE RECORD:C53([Personas:7])
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$t/Size of array:C274($aPersonas);__ ("Asignando dirección de envío de correspondencia a apoderados de cuenta..."))
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					KRL_UnloadReadOnly (->[Personas:7])
				Else 
					CD_Dlog (0;__ ("Se debe tener algún apoderado seleccionado."))
				End if 
			End if 
		End if 
End case 