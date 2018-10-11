//%attributes = {}
  //CAE_VerificaPromediosActas

C_LONGINT:C283($0)
QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7>=1;*)
QUERY:C277([Cursos:3]; & [Cursos:3]Nivel_Numero:7<=12;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
yBWR_currentTable:=->[Cursos:3]
CREATE SET:C116([Cursos:3];"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
$0:=CU_VerifyPromedioActas (False:C215)
