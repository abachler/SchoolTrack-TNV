//%attributes = {}
  //DBU_EliminaSubsectoresSinUso

ALL RECORDS:C47([xxSTR_Materias:20])
CREATE SET:C116([xxSTR_Materias:20];"todas")

ALL RECORDS:C47([Asignaturas:18])
KRL_RelateSelection (->[xxSTR_Materias:20]Materia:2;->[Asignaturas:18]Asignatura:3)
CREATE SET:C116([xxSTR_Materias:20];"utilizadas")

DIFFERENCE:C122("todas";"utilizadas";"inutilizadas")
USE SET:C118("inutilizadas")
KRL_DeleteSelection (->[xxSTR_Materias:20])