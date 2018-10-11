//%attributes = {}
  //STR_BusquedaEspecial

C_POINTER:C301($1;vyQRY_TablePointer)
vyQRY_TablePointer:=$1

Case of 
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Alumnos:2]))
		LOAD RECORD:C52([Alumnos:2])
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Cursos:3]))
		LOAD RECORD:C52([Cursos:3])
		PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
	: (Table:C252(vyQRY_TablePointer)=Table:C252(->[Asignaturas:18]))
		LOAD RECORD:C52([Asignaturas:18])
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
End case 

WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_SpecialFind";-1;4;__ ("Búsqueda de registros"))
DIALOG:C40([xxSTR_Constants:1];"STR_SpecialFind")
CLOSE WINDOW:C154

If (bEditor=1)
	QRY_QueryEditor (vyQRY_TablePointer)
End if 

