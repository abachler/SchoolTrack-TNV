//%attributes = {}
  // TMT_ResaltaHorario()
  // Por: Alberto Bachler: 31/05/13, 09:59:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$i_fila;$l_columna;$l_fila)
C_TEXT:C284($t_Asignaciones;$t_nombreObjeto)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY LONGINT:C221($al_columnasResalte;0)
ARRAY INTEGER:C220($al_dia;0)
ARRAY LONGINT:C221($al_filasResalte;0)
ARRAY INTEGER:C220($al_hora;0)
ARRAY POINTER:C280($ay_Columnas;0)
ARRAY POINTER:C280($ay_Encabezados;0)
ARRAY POINTER:C280($ay_estilos;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)

$l_idAsignatura:=$1
AT_Initialize (->$al_columnasResalte;->$al_filasResalte)
  //LISTBOX GET CELL POSITION(*;"lbAsignaturas";$l_columna;$l_fila)
  //If ($l_fila>0)
  //QUERY([TMT_Horario];[TMT_Horario]ID_Asignatura=$l_idAsignatura)
  //If (Records in selection([TMT_Horario])>0)
  //SELECTION TO ARRAY([TMT_Horario]NumeroDia;$al_dia;[TMT_Horario]NumeroHora;$al_hora)
  //AT_MultiLevelSort (">>";->$al_dia;->$al_hora)
  //$t_Asignaciones:=""
  //For ($i;1;Size of array($al_dia))
  //  //$t_Asignaciones:=$t_Asignaciones+";(  "+DT_DayNameFromISODayNumber ($al_dia{$i})+" "+String($al_hora{$i})+"ª hora"
  //APPEND TO ARRAY($al_columnasResalte;$al_dia{$i}+3)
  //APPEND TO ARRAY($al_filasResalte;$al_hora{$i})
  //End for 
  //  //End if 
  //End if 

QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=$l_idAsignatura)
SELECTION TO ARRAY:C260([TMT_Horario:166];$al_recNums)
For ($i_recNums;1;Size of array:C274($al_recNums))
	For ($i;1;6)
		$y_columna:=Get pointer:C304("alSTK_Day"+String:C10($i))
		$l_celda:=Find in array:C230($y_columna->;$al_recNums{$i_recNums})
		While ($l_celda>0)
			  //APPEND TO ARRAY($al_columnasResalte;$i+3)
			APPEND TO ARRAY:C911($al_columnasResalte;$i+4)  //ASM Ticket 206706 se suma una columna por el "Alias"
			APPEND TO ARRAY:C911($al_filasResalte;$l_celda)
			$l_celda:=Find in array:C230($y_columna->;$al_recNums{$i_recNums};$l_celda+1)
		End while 
	End for 
End for 

LB_SelectCellsArray (->$al_columnasResalte;->$al_filasResalte;IT_IndexColor2RGB (Dark green:K11:10);0x00FFFFFF;"lbHorario")
