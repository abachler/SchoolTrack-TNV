modObjetivos:=True:C214
OBJECT SET VISIBLE:C603(*;"ListaAsg@"\
;[Asignaturas:18]ConObjetivosEspecificos:62)
$Objetivo:=Get pointer:C304("vObj_P"\
+String:C10(atSTR_Periodos_Nombre))
Case of 
	: (([Asignaturas:18]ConObjetivosEspecificos:62) & (Old:C35([Asignaturas:18]ConObjetivosEspecificos:62)))
		vObj_P1:=tempObj_P1
		vObj_P2:=tempObj_P2
		vObj_P3:=tempObj_P3
		vObj_P4:=tempObj_P4
		vObj_P5:=tempObj_P5
		[Asignaturas:18]ID_Objetivos:43:=Old:C35([Asignaturas:18]ID_Objetivos:43)
	: (([Asignaturas:18]ConObjetivosEspecificos:62=False:C215) & (Old:C35([Asignaturas:18]ConObjetivosEspecificos:62)=True:C214))
		tempObj_P1:=vObj_P1
		tempObj_P2:=vObj_P2
		tempObj_P3:=vObj_P3
		tempObj_P4:=vObj_P4
		tempObj_P5:=vObj_P5
		If ($Objetivo->#"")
			CD_Dlog (0;__ ("Al cambiar el tipo de objetivos perderá la información ingresada hasta ahora. Puede recuperar la información volviendo al estado anterior antes de grabar."))
		End if 
		QUERY:C277([Asignaturas_Objetivos:104];[Asignaturas_Objetivos:104]Nivel_numero:4=[Asignaturas:18]Numero_del_Nivel:6;*)
		QUERY:C277([Asignaturas_Objetivos:104]; & ;[Asignaturas_Objetivos:104]Subsector:2=[Asignaturas:18]Asignatura:3)
		If (Records in selection:C76([Asignaturas_Objetivos:104])>0)
			[Asignaturas:18]ID_Objetivos:43:=[Asignaturas_Objetivos:104]ID:1
			vObj_P1:=[Asignaturas_Objetivos:104]Objetivos_P1:6
			vObj_P2:=[Asignaturas_Objetivos:104]Objetivos_P2:7
			vObj_P3:=[Asignaturas_Objetivos:104]Objetivos_P3:8
			vObj_P4:=[Asignaturas_Objetivos:104]Objetivos_P4:9
			vObj_P5:=[Asignaturas_Objetivos:104]Objetivos_P5:10
		Else 
			vObj_P1:=""
			vObj_P2:=""
			vObj_P3:=""
			vObj_P4:=""
			vObj_P5:=""
		End if 
	: (([Asignaturas:18]ConObjetivosEspecificos:62) & (Not:C34(Old:C35([Asignaturas:18]ConObjetivosEspecificos:62))))
		[Asignaturas:18]ID_Objetivos:43:=0
		tempObj_P1:=vObj_P1
		tempObj_P2:=vObj_P2
		tempObj_P3:=vObj_P3
		tempObj_P4:=vObj_P4
		tempObj_P5:=vObj_P5
		If ($Objetivo->#"")
			CD_Dlog (0;__ ("Al cambiar el tipo de objetivos perderá la información ingresada hasta ahora. Puede recuperar la información volviendo al estado anterior antes de grabar."))
		End if 
		vObj_P1:=""
		vObj_P2:=""
		vObj_P3:=""
		vObj_P4:=""
		vObj_P5:=""
	: (([Asignaturas:18]ConObjetivosEspecificos:62) & (Old:C35([Asignaturas:18]ConObjetivosEspecificos:62)))
		[Asignaturas:18]ID_Objetivos:43:=Old:C35([Asignaturas:18]ID_Objetivos:43)
		vObj_P1:=tempObj_P1
		vObj_P2:=tempObj_P2
		vObj_P3:=tempObj_P3
		vObj_P4:=tempObj_P4
		vObj_P5:=tempObj_P5
End case 
  //SAVE RECORD([Asignaturas])
GOTO OBJECT:C206($Objetivo->)