//%attributes = {}
  //CFG_STR_EditaMateria

C_LONGINT:C283($sort)
WDW_OpenFormWindow (->[xxSTR_Materias:20];"Input";-1;8;__ ("Subsectores de aprendizaje"))
KRL_ModifyRecord (->[xxSTR_Materias:20];"Input")
CLOSE WINDOW:C154
<>aAsign{<>aAsign}:=[xxSTR_Materias:20]Materia:2
<>aAsignNo{<>aAsign}:=[xxSTR_Materias:20]Orden interno:9
AL_GetSort (xALP_Materias;$sort)
Case of 
	: ($sort=1)
		ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Orden interno:9;>)
	: ($sort=2)
		ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Area:12;>)
	: ($sort=3)
		ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;>)
End case 
AL_UpdateFields (xALP_Materias;1)