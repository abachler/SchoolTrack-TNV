Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ADT_xALSet_Examenes 
		$currentChoice:=[ADT_Candidatos:49]ID_Exam:29
		$currentsection:=[ADT_Candidatos:49]Sección:26
		Case of 
			: (iPST_DistributeBySex=0)
				$max:=iPST_MaxPerSection
				$arrPtr:=->aiPST_SelEXmTotal
			: ([Alumnos:2]Sexo:49="F")
				$max:=iPST_MaxPerSection/2
				$arrPtr:=->aiPST_SelEXmGirls
			: ([Alumnos:2]Sexo:49="M")
				$max:=iPST_MaxPerSection/2
				$arrPtr:=->aiPST_SelEXmBoys
		End case 
		For ($i;1;Size of array:C274(adPST_SelEXmDate))
			If (aLPST_SelEXmID{$i}=$currentChoice)
				viPST_CurrentExamID:=aLPST_SelEXmID{$i}
				AL_SetRowStyle (xALP_Sections;$i;1)
			End if 
		End for 
		AL_SetSort (xALP_Sections;2;1)
		AL_SetLine (xALP_Sections;0)
		AL_SetLine (xALP_Groups;0)
		
		vdPST_NewSesionDate:=!00-00-00!
		IT_SetButtonState (False:C215;->bAssign;->bNew)
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Plug in Area:K2:16) | (Form event:C388=On Data Change:K2:15))
		$line:=AL_GetLine (xALP_sections)
		IT_SetButtonState (($line>0);->bAssign)
		IT_SetButtonState ((vdPST_NewSesionDate#!00-00-00!);->bNew)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
