//%attributes = {}
  //xALCB_EX_Aparatos
  //Ticket 179828 20170417 AOQ
C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row)
C_TEXT:C284(vt_NombreNivel)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_Aparatos)=1)
		$stop:=False:C215
		vl_ModSalud:=vl_ModSalud ?+ 5
		AL_GetCurrCell (xALP_Aparatos;$Col;$Row)
		Case of 
			: ($col=1)
				If (aAparatos_Year{$row}=<>gYear)
					aAparatos_Curso{$row}:=[Alumnos:2]curso:20
					vt_NombreNivel:=aAparatos_Curso{$row}
					aAparatos_NoNivel{$row}:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->vt_NombreNivel;->[xxSTR_Niveles:6]NoNivel:5)
				Else 
					QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos_FichaMedica:13]Alumno_Numero:1;*)
					QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2=aAparatos_Year{$row})
					If (Records in selection:C76([Alumnos_Historico:25])>0)
						aAparatos_Curso{$row}:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Historico:25]Nivel:11;->[xxSTR_Niveles:6]Nivel:1)
						vt_NombreNivel:=aAparatos_Curso{$row}
						aAparatos_NoNivel{$row}:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->vt_NombreNivel;->[xxSTR_Niveles:6]NoNivel:5)
					Else 
						aAparatos_Curso{$row}:=""
					End if 
				End if 
				AL_UpdateArrays (xALP_Aparatos;-1)
			: ($col=2)
				vt_NombreNivel:=aAparatos_Curso{$row}
				aAparatos_NoNivel{$row}:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->vt_NombreNivel;->[xxSTR_Niveles:6]NoNivel:5)
			: ($col=3)
				C_TEXT:C284($text)
				$text:=aAparatos_Aparato{$row}
				$text:=TBL_GetValue (-><>at_Protesis;->$text;"Ficha Médica: Aparatos y Protesis")
				vt_NombreNivel:=aAparatos_Curso{$row}
				aAparatos_NoNivel{$row}:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]Nivel:1;->vt_NombreNivel;->[xxSTR_Niveles:6]NoNivel:5)
				aAparatos_Aparato{$row}:=$text
				AL_SetEnterable (xALP_Aparatos;3;3;<>at_Protesis)
				AL_UpdateArrays (xALP_Aparatos;-2)
		End case 
	End if 
End if 





