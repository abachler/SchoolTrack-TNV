//%attributes = {}
  // MÉTODO: EV2_RecalculoAsignaturasEnBWR
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/12/11, 17:50:42
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // ASev2_Recalculos()
  // ----------------------------------------------------
C_BLOB:C604($x_recNumArray)

  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(->[Asignaturas:18])))
ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumAsignaturas)
BLOB_Variables2Blob (->$x_recNumArray;0;->$al_RecNumAsignaturas)

$P:=New process:C317("EV2dbu_Recalculos";256000;"Calculo de promedios";$x_recNumArray)