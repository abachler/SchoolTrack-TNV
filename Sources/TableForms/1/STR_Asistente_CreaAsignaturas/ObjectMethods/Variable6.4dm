Case of 
	: (alProEvt=-5)
		AL_GetDrgSrcRow (Self:C308->;$line)
		AL_GetDrgArea (Self:C308->;$area;$pId)
		If ($area=xALP_PlanNivel)
			AL_GetDrgDstTyp (xALP_PlanNivel;$type)
			If ($type=1)
				AL_GetDrgDstRow (xALP_PlanNivel;$NewNo)
				$el:=Find in array:C230(aSubject;<>aAsign{$line})
				If ($el=-1)
					AL_UpdateArrays (xALP_PlanNivel;0)
					AT_Insert ($newNo;1;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
					aSubject{$newNo}:=<>aAsign{$line}
					aSex{$newNo}:=aText2{1}
					If (aSubject{$newNo}="@Religión@")
						aSubjectType{$newNo}:="Optativo"
						aIncide{$newNo}:=False:C215
						aNumber{$newNo}:="Uno por curso"
						$el:=Find in array:C230(aEvStyleId;-3)
						If ($el>0)
							aStyle{$newNo}:=aEvStyleName{$el}
						End if 
					Else 
						QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=<>aAsign{$line})
						If ([xxSTR_Materias:20]Subsector_Oficial:15)
							aSubjectType{$newNo}:="Plan Común, cursos"
							aIncide{$newNo}:=True:C214
							aNumber{$newNo}:="Uno por curso"
						Else 
							aSubjectType{$newNo}:="Plan Electivo"
							aIncide{$newNo}:=True:C214
							aNumber{$newNo}:="1"
						End if 
						$el:=Find in array:C230(aEvStyleId;-5)
						If ($el>0)
							aStyle{$newNo}:=aEvStyleName{$el}
						End if 
					End if 
					For ($i;1;Size of array:C274(aSubject))
						aOrder{$i}:=$i
					End for 
					AL_UpdateArrays (xALP_PlanNivel;-2)
				End if 
			End if 
		End if 
End case 