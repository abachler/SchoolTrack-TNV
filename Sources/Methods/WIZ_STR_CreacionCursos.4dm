//%attributes = {}
  //WIZ_STR_CreacionCursos

C_BOOLEAN:C305(vb_FirstInstall)

ARRAY TEXT:C222(atWiz_NombresNivel;0)
ARRAY LONGINT:C221(alWiz_NosNivel;0)
ARRAY LONGINT:C221(alWiz_QtCursos;0)

READ ONLY:C145([xxSTR_Niveles:6])
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>;[xxSTR_Niveles:6]Nivel:1;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;atWiz_NombresNivel;[xxSTR_Niveles:6]NoNivel:5;alWiz_NosNivel)
ARRAY LONGINT:C221(alWiz_QtCursos;Size of array:C274(alWiz_NosNivel))
READ ONLY:C145([xxSTR_Niveles:6])

WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_Asistente_CreacionCursos";-1;4;__ ("Asistentes"))
DIALOG:C40([xxSTR_Constants:1];"STR_Asistente_CreacionCursos")
CLOSE WINDOW:C154
If (ok=1)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando cursos en ")+atWiz_NombresNivel{1})
	For ($i;1;Size of array:C274(alWiz_NosNivel))
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alWiz_NosNivel);__ ("Creando ")+String:C10(alWiz_QtCursos{$i})+__ (" curso(s) en ")+atWiz_NombresNivel{$i})
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=alWiz_NosNivel{$i})
		For ($j;1;alWiz_QtCursos{$i})
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=([xxSTR_Niveles:6]Abreviatura:19+"-"+Char:C90($j+64)))
			If (Records in selection:C76([Cursos:3])=0)
				CREATE RECORD:C68([Cursos:3])
				[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)
				[Cursos:3]Curso:1:=[xxSTR_Niveles:6]Abreviatura:19+"-"+Char:C90($j+64)
				[Cursos:3]Nivel_Numero:7:=[xxSTR_Niveles:6]NoNivel:5
				[Cursos:3]Ciclo:5:=[xxSTR_Niveles:6]Sección:9
				[Cursos:3]Letra_del_curso:9:=Char:C90($j+64)
				[Cursos:3]Letra_Oficial_del_Curso:18:=[Cursos:3]Letra_del_curso:9
				[Cursos:3]Nivel_Nombre:10:=[xxSTR_Niveles:6]Nivel:1
				[Cursos:3]Nombre_Oficial_Nivel:14:=[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21
				[Cursos:3]Nombre_Oficial_Curso:15:=[Cursos:3]Curso:1
				SAVE RECORD:C53([Cursos:3])
			End if 
		End for 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SQ_SetSequences 
Else 
	
	
End if 

CU_LoadArrays 

AT_Initialize (->atWiz_NombresNivel;->alWiz_NosNivel;->alWiz_QtCursos)
