//%attributes = {}
  //AL_VerifyPromediosActas

C_LONGINT:C283($0)
USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
ARRAY TEXT:C222(aText1;0)  //student Class
ARRAY TEXT:C222(aText2;0)  //student Names
ARRAY TEXT:C222(aText3;0)  //promedio SchoolTrack
ARRAY TEXT:C222(aText4;0)  //promedio acta
ARRAY TEXT:C222(aText5;0)  //promedio acta


USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
$Process:=IT_UThermometer (1;0;__ ("Iniciando el examen..."))
SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
VARIABLE TO BLOB:C532($aRecNums;$blob)
IT_UThermometer (-2;$Process)
$0:=dbu_VerificaPromediosActa ($blob;True:C214)

If ($0#1)
	$r:=CD_Dlog (0;__ ("¿Desea usted listar a los alumnos con errores en sus promedios generales?");__ ("");__ ("Si");__ ("No"))
	If ($r=1)
		CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
	End if 
End if 


ARRAY TEXT:C222(aText1;0)  //student Class
ARRAY TEXT:C222(aText2;0)  //student Names
ARRAY TEXT:C222(aText3;0)  //promedio SchoolTrack
ARRAY TEXT:C222(aText4;0)  //promedio acta
ARRAY TEXT:C222(aText5;0)  //promedio acta