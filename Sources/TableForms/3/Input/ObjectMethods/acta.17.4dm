  //Script en popup ◊aNivel en modelo de actas

If (Selected list items:C379(Self:C308->)>0)
	GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$className)
	If ($ref>-32000)
		If ([Cursos:3]ActaEspecificaAlCurso:35)
			If ($ref#0)  //`es un modelo de nivel      
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$ref)
				If (Records in selection:C76([xxSTR_Niveles:6])>0)
					$actas:=[xxSTR_Niveles:6]Actas_y_Certificados:43
					[Cursos:3]Acta:34:=$actas
					SAVE RECORD:C53([Cursos:3])
				End if 
			Else 
				PUSH RECORD:C176([Cursos:3])
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$className)
				If (Records in selection:C76([Cursos:3])>0)
					$actas:=[Cursos:3]Acta:34
					POP RECORD:C177([Cursos:3])
					[Cursos:3]Acta:34:=$actas
					SAVE RECORD:C53([Cursos:3])
				Else 
					POP RECORD:C177([Cursos:3])
				End if 
			End if 
		Else 
			ok:=CD_Dlog (0;__ ("Atención !!\rEl modelo de acta seleccionado será definido como modelo por defecto para todos los curso de este nivel\r\r¿Es lo que usted desea hacer?");__ ("");__ ("No");__ ("Sí"))
			If (ok=2)
				If ($ref#0)  //`es un modelo de nivel     
					READ ONLY:C145([xxSTR_Niveles:6])
					QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$ref)
					If (Records in selection:C76([xxSTR_Niveles:6])>0)
						$actas:=[xxSTR_Niveles:6]Actas_y_Certificados:43
						[Cursos:3]Acta:34:=$actas
						SAVE RECORD:C53([Cursos:3])
					End if 
				Else 
					PUSH RECORD:C176([Cursos:3])
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$className)
					If (Records in selection:C76([Cursos:3])>0)
						$actas:=[Cursos:3]Acta:34
						POP RECORD:C177([Cursos:3])
						READ WRITE:C146([xxSTR_Niveles:6])
						QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
						[xxSTR_Niveles:6]Actas_y_Certificados:43:=$actas
						SAVE RECORD:C53([xxSTR_Niveles:6])
						UNLOAD RECORD:C212([xxSTR_Niveles:6])
					Else 
						POP RECORD:C177([Cursos:3])
					End if 
				End if 
			End if 
		End if 
		CU_PgActas 
	End if 
End if 