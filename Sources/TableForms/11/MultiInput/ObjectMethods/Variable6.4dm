
Case of 
	: (Form event:C388=On Data Change:K2:15)  //20180921 ASM Ticket 216740
		If (sProf#"")
			ARRAY TEXT:C222(aAsignaturasProfesor;0)
			QUERY:C277([Profesores:4];[Profesores:4]Apellido_paterno:3=(sProf+"@");*)
			QUERY:C277([Profesores:4]; & ;[Profesores:4]Inactivo:62=False:C215)
			Case of 
				: (Records in selection:C76([Profesores:4])=0)
					$r:=CD_Dlog (1;__ ("Profesor inexistente."))
					sProf:=""
					iProfID:=0
					GOTO OBJECT:C206(Self:C308->)
				: (Records in selection:C76([Profesores:4])=1)
					sProf:=[Profesores:4]Nombre_comun:21
					iProfID:=[Profesores:4]Numero:1
				: (Records in selection:C76([Profesores:4])>1)
					SELECTION TO ARRAY:C260([Profesores:4]Nombre_comun:21;<>aGenNme;[Profesores:4]Numero:1;<>aGenId)
					ARRAY POINTER:C280(<>aChoicePtrs;2)
					<>aChoicePtrs{1}:=-><>aGenNme
					<>aChoicePtrs{2}:=-><>aGenID
					TBL_ShowChoiceList (1)
					If ((ok=1) & (choiceIdx>0))
						sProf:=<>aChoicePtrs{1}->{choiceIdx}
						iprofId:=<>aChoicePtrs{2}->{choiceIdx}
					Else 
						sProf:=""
						iprofId:=0
						GOTO OBJECT:C206(sProf)
					End if 
			End case 
			If (iprofId#0)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=iprofId;*)
				QUERY:C277([Asignaturas:18]; | [Asignaturas:18]profesor_firmante_numero:33=iprofId)
				AT_DistinctsFieldValues (->[Asignaturas:18]denominacion_interna:16;->aAsignaturasProfesor)
				  //20160606 ASM Ticket 156940
				AT_Insert (1;1;->aAsignaturasProfesor)
				aAsignaturasProfesor{1}:="Sin Asignatura"
				If (Size of array:C274(aAsignaturasProfesor)>0)
					aAsignaturasProfesor:=1
				End if 
			End if 
			If (Size of array:C274(aAsignaturasProfesor)>0)
				OBJECT SET ENTERABLE:C238(*;"asignatura@";True:C214)
			Else 
				OBJECT SET ENTERABLE:C238(*;"asignatura@";False:C215)
			End if 
			vbSpell_StopChecking:=True:C214
		End if 
End case 