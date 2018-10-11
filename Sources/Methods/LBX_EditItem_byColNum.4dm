//%attributes = {}
  // MÉTODO: LBX_EditItem_byColNum
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 18/11/11, 16:26:29
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Edita un item del listbox desde fuera del objeto ListBox sin entrar en conflicto con el método LBX_HandleEvents
  // Ver también LBX_EditItem_byObjectPointer y LBX_EditItem_byColNum
  //
  //
  // PARÁMETROS
  // LBX_EditItem_byColNum(NombreObjetoLista;NumeroColumna;Fila)
  // $1: Texto : Nombre del Objeto lista
  // $2: Longint : Numero de la columna a editar
  // $3: Longint : Numero de la fila a Editar
  // ----------------------------------------------------

  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($2;$3;vl_LBXcolumn;vl_LBXrow)
C_LONGINT:C283($l_table;$l_fieldNum;$l_NumberOfColumns)
C_TEXT:C284($t_SelectionName;$t_ColumnNum)
C_POINTER:C301($y_TablePointer;$y_fieldPointer)
C_BOOLEAN:C305($b_ObjectIsEnterable)
C_LONGINT:C283($l_NumberOfColumns;$l_numberOfRows)


  // arreglos para obtener información de la configuración del ListBox
ARRAY TEXT:C222($at_ColumnNames;0)
ARRAY TEXT:C222($at_HeaderNames;0)
ARRAY POINTER:C280($ay_Objects;0)
ARRAY POINTER:C280($ay_Headers;0)
ARRAY BOOLEAN:C223($ab_Visible;0)
ARRAY POINTER:C280($ay_Styles;0)

$l_cocacola:=0
$t_listBoxObjectName:=$1
vl_LBXcolumn:=$2
vl_LBXrow:=$3
$t_ColumnNum:=String:C10($2)


  // CODIGO PRINCIPAL

  // obtengo información de la lista para validar los parametros recibidos
LISTBOX GET TABLE SOURCE:C1014(*;$t_listboxObjectName;$l_table;$t_SelectionName)
LISTBOX GET ARRAYS:C832(*;$t_listboxObjectName;$at_ColumnNames;$at_HeaderNames;$ay_Objects;$ay_Headers;$ab_Visible;$ay_Styles)
$l_NumberOfColumns:=LISTBOX Get number of columns:C831(*;$t_listboxObjectName)
$l_numberOfRows:=LISTBOX Get number of rows:C915(*;$t_listboxObjectName)



If ((vl_LBXcolumn>0) & (vl_LBXcolumn<=$l_NumberOfColumns))  //si la columna especificada es válida
	If (Not:C34(Is nil pointer:C315($ay_Objects{vl_LBXcolumn})))  //verifico que no sea una formula
		$b_ObjectIsEnterable:=OBJECT Get enterable:C1067($ay_Objects{vl_LBXcolumn}->)  //verifico que sea editable
		$t_ObjectName:=$at_ColumnNames{vl_LBXcolumn}  // obtengo el nombre de la columna en caso para mostrar alertas
	End if 
Else 
	vl_LBXcolumn:=0
	ALERT:C41("La columna especificada ("+$t_ColumnNum+") no existe en el Listbox.")
End if 

If (vl_LBXcolumn>0)  // si la columna es válida
	Case of 
		: (vl_LBXrow>$l_numberOfRows)  //si la fila no existe en el listbox muestro una alerta
			ALERT:C41("La fila especificada ("+String:C10(vl_LBXrow)+") no existe en la fila.")
			
		: (Is nil pointer:C315($ay_Objects{vl_LBXcolumn}))  //si la columna corresponde a una formula muestro una alerta
			ALERT:C41("Los valores de la columna "+$t_ColumnNum+" corresponden a una fórmula. \r\rNo puede ser editada.")
			
		: (Not:C34($b_ObjectIsEnterable))  // si el objeto no es editable muestro una alerta
			ALERT:C41("El objeto "+$t_ObjectName+" no es ingresable.")
			
		Else 
			
			RESOLVE POINTER:C394($ay_Objects{vl_LBXcolumn};$t_varName;$l_Table;$l_fieldNum)  // determino si el objeto es una arreglo o un campo 
			If (($l_Table>0) & ($l_fieldNum>0))  // si es un campo cargo el registro en escritura
				$y_TablePointer:=Table:C252($l_Table)
				READ WRITE:C146($y_TablePointer->)
				LOAD RECORD:C52($y_TablePointer->)
			End if 
			
			EDIT ITEM:C870($ay_Objects{vl_LBXcolumn}->;vl_LBXrow)
			
			
	End case 
End if 