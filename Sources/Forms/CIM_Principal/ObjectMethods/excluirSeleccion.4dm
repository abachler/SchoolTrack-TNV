  // [xShell_Logs].Manager.excluirSeleccion()
  // 
  //
  // creado por: Alberto Bachler Klein: 06-06-16, 13:15:54
  // -----------------------------------------------------------



  //COPY SET("$seleccionActividades";"$temp")
ALL RECORDS:C47([xShell_Logs:37])
CREATE SET:C116([xShell_Logs:37];"$todos")
DIFFERENCE:C122("$todos";"$seleccionActividades";"$todos")
USE SET:C118("$todos")
SET_ClearSets ("$seleccionActividades";"$temp";"$todos")
ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
OBJECT SET TITLE:C194(*;"totalEventos";String:C10(Records in selection:C76([xShell_Logs:37]))+__ (" sobre ")+String:C10(Records in table:C83([xShell_Logs:37]))+" "+__ ("eventos"))
