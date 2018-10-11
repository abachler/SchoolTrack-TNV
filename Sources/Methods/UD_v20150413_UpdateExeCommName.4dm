//%attributes = {}
  //UD_v20150413_UpdateExeCommName
  //Este commando tenia duplicado el id, fue corregido pero necesito actualizar el nombre para todos los paises
C_LONGINT:C283($proc)
$proc:=IT_UThermometer (1;0;__ ("Actualizando nombre de comando..."))
READ WRITE:C146([xShell_ExecCommands_Localized:232])
QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6=10365)
APPLY TO SELECTION:C70([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]Alias:3:="Modificar Porcentaje de Descuento de Cuentas Corrientes")
QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6=23098)
APPLY TO SELECTION:C70([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]Alias:3:="Importación de asistencia y atrasos de jornada")
KRL_UnloadReadOnly (->[xShell_ExecCommands_Localized:232])
IT_UThermometer (-2;$proc)