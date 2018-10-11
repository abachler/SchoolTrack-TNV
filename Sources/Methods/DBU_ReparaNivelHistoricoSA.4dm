//%attributes = {}
  //DBU_ReparaNivelHistoricoSA 
  //Busca el nivel de alumnos historicos para reparar el de las sintesis anual historicas
  //20101217 RCH v562. Se agregan acentos y se testea que el registro no este bloqueado.

C_LONGINT:C283($i)
ARRAY LONGINT:C221(aQR_longint2;0)
READ ONLY:C145([Alumnos_SintesisAnual:210])
READ ONLY:C145([Alumnos_Historico:25])

QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4<0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];aQR_longint1;"")

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Comparando Síntesis anual con Históricos...")

For ($i;1;Size of array:C274(aQR_longint1))
	
	GOTO RECORD:C242([Alumnos_SintesisAnual:210];aQR_longint1{$i})
	
	QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4);*)
	QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Año:2=[Alumnos_SintesisAnual:210]Año:2)
	
	If ((Records in selection:C76([Alumnos_Historico:25])=1) & ([Alumnos_Historico:25]Nivel:11#0))
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]LlavePrincipal:5=[Alumnos_SintesisAnual:210]LlavePrincipal:5)
		If (Records in selection:C76([Alumnos_SintesisAnual:210])=1)
			If ([Alumnos_Historico:25]Nivel:11#[Alumnos_SintesisAnual:210]NumeroNivel:6)
				KRL_ReloadInReadWriteMode (->[Alumnos_SintesisAnual:210])
				If (Not:C34(Locked:C147([Alumnos_SintesisAnual:210])))
					$RecNum:=Record number:C243([Alumnos_SintesisAnual:210])
					vQR_longint1:=[Alumnos_SintesisAnual:210]NumeroNivel:6
					vQR_text1:=KRL_MakeStringAccesKey (-><>gInstitucion;->[Alumnos_Historico:25]Año:2;->[Alumnos_Historico:25]Nivel:11;->[Alumnos_Historico:25]Alumno_Numero:1)
					$RecNumB:=Find in field:C653([Alumnos_SintesisAnual:210]LlavePrincipal:5;vQR_text1)
					If ($RecNumB#-1)
						APPEND TO ARRAY:C911(aQR_longint2;$RecNum)
					Else 
						GOTO RECORD:C242([Alumnos_SintesisAnual:210];$RecNum)
						[Alumnos_SintesisAnual:210]NumeroNivel:6:=[Alumnos_Historico:25]Nivel:11
						SAVE RECORD:C53([Alumnos_SintesisAnual:210])
						LOG_RegisterEvt ("Alumno ID: "+String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))+", el registro de síntesis anual para el año "+String:C10([Alumnos_SintesisAnual:210]Año:2)+" tenía el número de nivel incorrecto ("+String:C10(vQR_longint1)+") con respecto al número de nivel de su histórico ("+String:C10([Alumnos_Historico:25]Nivel:11)+")")
					End if 
				Else 
					LOG_RegisterEvt ("Alumno ID: "+String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))+", el registro de síntesis anual para el año "+String:C10([Alumnos_SintesisAnual:210]Año:2)+" no pudo ser cambiado. Tiene el número de nivel incorrecto ("+String:C10(vQR_longint1)+") con respecto al número de nivel de su histórico ("+String:C10([Alumnos_Historico:25]Nivel:11)+")")
				End if 
			End if 
		End if 
		KRL_UnloadReadOnly (->[Alumnos_Historico:25])
	End if 
	
	KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
	
End for 

CREATE SELECTION FROM ARRAY:C640([Alumnos_SintesisAnual:210];aQR_longint2)
KRL_DeleteSelection (->[Alumnos_SintesisAnual:210])

ARRAY LONGINT:C221(aQR_longint1;0)
ARRAY LONGINT:C221(aQR_longint2;0)
vQR_longint1:=0

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)