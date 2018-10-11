//%attributes = {}
  // Método: UD_v20180121_EliminaDupInformes
  //
  //
  // por Alberto Bachler Klein
  // creación 21/01/18, 12:06:23
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($i;$i_registros;$l_progress;$l_registros)
C_POINTER:C301($y_tabla)

ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_uuids;0)

  // CONVERSION DE dts A timestamps
READ WRITE:C146([xShell_Reports:54])
ALL RECORDS:C47([xShell_Reports:54])

$l_progress:=Progress New 
Progress SET TITLE ($l_progress;"Actualizando informes…")
Progress SET ICON ($l_progress;<>p_iconoColegium)
$y_tabla:=->[xShell_Reports:54]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
READ WRITE:C146($y_tabla->)
$l_registros:=Records in selection:C76($y_tabla->)
For ($i_registros;1;$l_registros)
	GOTO RECORD:C242($y_tabla->;$al_recNums{$i_registros})
	Progress SET PROGRESS ($l_progress;$i_registros/$l_registros)
	[xShell_Reports:54]timestampISO_creacion:36:=DT_DTS_a_ISOTimestamp ([xShell_Reports:54]DTS_creacion:20)
	[xShell_Reports:54]timestampISO_modificacion:35:=DT_DTS_a_ISOTimestamp ([xShell_Reports:54]DTS_UltimaModificacion:46)
	[xShell_Reports:54]timestampISO_repositorio:37:=DT_DTS_a_ISOTimestamp ([xShell_Reports:54]DTS_Repositorio:45)
	SAVE RECORD:C53($y_Tabla->)
End for 
Progress QUIT ($l_progress)
KRL_UnloadReadOnly (->[xShell_Reports:54])
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


  // ELIMINACION DE INFORTMES DEL REPOSITORIO DUPLICADOS
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48;=;True:C214;*)
QUERY:C277([xShell_Reports:54]; | [xShell_Reports:54]DTS_Repositorio:45;#;"")
DISTINCT VALUES:C339([xShell_Reports:54]UUID:47;$at_uuids)

READ WRITE:C146([xShell_Reports:54])
For ($i;1;Size of array:C274($at_uuids))
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47;=;$at_uuids{$i})
	$l_registros:=Records in selection:C76([xShell_Reports:54])
	If ($l_registros>1)
		REDUCE SELECTION:C351([xShell_Reports:54];$l_registros-1)
		DELETE SELECTION:C66([xShell_Reports:54])
	End if 
End for 

RIN_ActualizaInformes 
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––




