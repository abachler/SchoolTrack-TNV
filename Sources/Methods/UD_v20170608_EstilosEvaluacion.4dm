//%attributes = {}
  // Método: UD_20170608_EstilosEvaluacion
  //
  //
  // por Alberto Bachler Klein
  // creación 08/06/17, 06:02:43
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($i_registros)
C_POINTER:C301($y_tabla)

ARRAY LONGINT:C221($al_recNums;0)

QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1>0)
$y_tabla:=->[xxSTR_EstilosEvaluacion:44]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
READ WRITE:C146($y_tabla->)
For ($i_registros;1;Records in selection:C76($y_tabla->))
	GOTO RECORD:C242($y_tabla->;$al_recNums{$i_registros})
	QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=[xxSTR_EstilosEvaluacion:44]Created_By:6)
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[xShell_Users:47]NoEmployee:7)
	[xxSTR_EstilosEvaluacion:44]creadoPor:11:=[Profesores:4]Nombre_comun:21
	
	QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=[xxSTR_EstilosEvaluacion:44]Modified_By:9)
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[xShell_Users:47]NoEmployee:7)
	[xxSTR_EstilosEvaluacion:44]modificadoPor:12:=[Profesores:4]Nombre_comun:21
	
	[xxSTR_EstilosEvaluacion:44]dtsCreacion:13:=""
	[xxSTR_EstilosEvaluacion:44]dtsModificacion:14:=""
	
	SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])
End for 



