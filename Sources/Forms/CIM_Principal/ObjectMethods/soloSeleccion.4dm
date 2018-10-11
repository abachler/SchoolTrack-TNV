  // [xShell_Logs].Manager.soloSeleccion()
  // 
  //
  // creado por: Alberto Bachler Klein: 06-06-16, 13:16:13
  // -----------------------------------------------------------

USE SET:C118("$seleccionActividades")
ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
OBJECT SET TITLE:C194(*;"totalEventos";String:C10(Records in selection:C76([xShell_Logs:37]))+__ (" sobre ")+String:C10(Records in table:C83([xShell_Logs:37]))+" "+__ ("eventos"))
