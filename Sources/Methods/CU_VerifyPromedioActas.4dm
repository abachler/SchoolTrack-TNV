//%attributes = {}
  //CU_VerifyPromedioActas

C_LONGINT:C283($0)
C_BOOLEAN:C305($1;$displayDialogs)

If (Count parameters:C259=1)
	$displayDialogs:=$1
Else 
	$displayDialogs:=True:C214
End if 

USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
ARRAY TEXT:C222(aText1;0)  //student Class
ARRAY TEXT:C222(aText2;0)  //student Names
ARRAY TEXT:C222(aText3;0)  //promedio SchoolTrack
ARRAY TEXT:C222(aText4;0)  //promedio acta
ARRAY TEXT:C222(aText5;0)  //promedio acta

USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;__ ("Iniciando el examen..."))
ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@";*)
QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Status:50#"En Trámite";*)
QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Status:50#"Oyente")

SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
VARIABLE TO BLOB:C532($aRecNums;$blob)
CLOSE WINDOW:C154
$0:=dbu_VerificaPromediosActa ($blob;$displayDialogs)
If ($0#1)
	If ($displayDialogs)
		$r:=CD_Dlog (0;__ ("¿Desea usted listar los cursos que tienen alumnos con errores en sus promedios generales?");__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			yBWR_currentTable:=->[Cursos:3]
			KRL_RelateSelection (->[Cursos:3]Curso:1;->[Alumnos:2]curso:20)
			CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
			BWR_SelectTableData 
		End if 
	End if 
End if 
ARRAY TEXT:C222(aText1;0)  //student Class
ARRAY TEXT:C222(aText2;0)  //student Names
ARRAY TEXT:C222(aText3;0)  //promedio SchoolTrack
ARRAY TEXT:C222(aText4;0)  //promedio acta
ARRAY TEXT:C222(aText5;0)  //promedio acta