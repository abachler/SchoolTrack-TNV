//%attributes = {}
  //EVLG_ConfiguracionAvanzada

ARRAY TEXT:C222(atEVLG_EjesLogros;0)
ARRAY LONGINT:C221(alEVLG_Ids;0)
ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
ARRAY TEXT:C222(atEVLG_Icons;0)

  //arreglos para competencias o logros asignados a una asignatura (utilizado en área xALP_LogrosAsignaturas, en configuracion avanzada)
ARRAY TEXT:C222(atEVLG_AdvCFG_EjesLogros;0)
ARRAY LONGINT:C221(alEVLG_AdvCFG_Ids;0)
ARRAY LONGINT:C221(alEVLG_AdvCFG_TipoObjeto;0)
ARRAY TEXT:C222(atEVLG_AdvCFG_Icons;0)


hl_Periodos:=New list:C375
APPEND TO LIST:C376(hl_Periodos;"Comunes a todos los períodos";0)
APPEND TO LIST:C376(hl_Periodos;"-";-1)
For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	APPEND TO LIST:C376(hl_Periodos;atSTR_Periodos_Nombre{$i};$i)
End for 
SELECT LIST ITEMS BY POSITION:C381(hl_Periodos;1)


hl_Periodos2:=Copy list:C626(hl_Periodos)
SELECT LIST ITEMS BY POSITION:C381(hl_Periodos2;1)
$title:=__ ("Aprendizajes Esperados en ")+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
WDW_OpenFormWindow (->[MPA_AsignaturasMatrices:189];"Configuracion";-1;8;$title)
DIALOG:C40([MPA_AsignaturasMatrices:189];"Configuracion")
CLOSE WINDOW:C154

HL_ClearList (hl_Periodos)