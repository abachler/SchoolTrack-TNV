//%attributes = {}
  //xALCB_EX_ControlesMedicos

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($Col;$Row)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_ControlesMedicos)=1)
		$stop:=False:C215
		vl_ModSalud:=vl_ModSalud ?+ 3
		AL_GetCurrCell (xALP_ControlesMedicos;$Col;$Row)
		Case of 
			: ($col=1)
				aCMedico_Edad{$row}:=DT_ReturnAgeLongString ([Alumnos:2]Fecha_de_nacimiento:7;aCMedico_Fecha{$row})
				If (<>gYear=Year of:C25(aCMedico_fecha{$row}))
					aCMedico_curso{$row}:=[Alumnos:2]curso:20
				Else 
					READ ONLY:C145([Alumnos_Historico:25])
					QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Año:2=(Year of:C25(aCMedico_fecha{$row}));*)
					QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Alumno_Numero:1=[Alumnos_FichaMedica:13]Alumno_Numero:1)
					aCMedico_curso{$row}:=[Alumnos_Historico:25]Curso:3
				End if 
				AL_UpdateArrays (xALP_ControlesMedicos;-2)
				
			: ($col=2)
				$separator:=Position:C15(".";aCMedico_Edad{$row})
				If ($separator=0)
					$separator:=Position:C15(",";aCMedico_Edad{$row})
					If ($separator=0)
						$separator:=Position:C15(" ";aCMedico_Edad{$row})
						If ($separator=0)
							$separator:=Position:C15("-";aCMedico_Edad{$row})
							If ($separator=0)
								$separator:=Position:C15("/";aCMedico_Edad{$row})
							End if 
						End if 
					End if 
				End if 
				
				If ($separator>0)
					$years:=Num:C11(Substring:C12(aCMedico_Edad{$row};1;$separator-1))
					$months:=Num:C11(Substring:C12(aCMedico_Edad{$row};$separator+1))
					$months:=($years*12)+$months
				Else 
					$months:=Num:C11(aCMedico_Edad{$row})
				End if 
				aCMedico_Edad{$row}:=DT_Months2AgeLongString ($months)
				
			: (($col=4) | ($col=5))
				If ((aCMedico_Peso{$row}>0) & (aCMedico_Talla{$row}>0))
					$size2:=(aCMedico_Talla{$row}/100)*(aCMedico_Talla{$row}/100)
					$imc:=Round:C94(aCMedico_Peso{$row}/$size2;1)
					aCMedico_IMC{$row}:=String:C10($imc)
					  //Case of 
					  //: ($imc<20)
					  //aCMedico_IMC{$row}:=String($imc)+": Bajo Peso Normal"
					  //: ($imc<24,9)
					  //aCMedico_IMC{$row}:=String($imc)+": Normal"
					  //: ($imc<29,9)
					  //aCMedico_IMC{$row}:=String($imc)+": Sobrepeso"
					  //Else 
					  //aCMedico_IMC{$row}:=String($imc)+": Obsesidad"
					  //End case 
					AL_UpdateArrays (xALP_ControlesMedicos;-2)
					POST KEY:C465(Character code:C91("-");256)
				Else 
					aCMedico_IMC{$row}:=""
				End if 
				
		End case 
	End if 
End if 

