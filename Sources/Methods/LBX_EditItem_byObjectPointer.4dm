//%attributes = {}
  // MÉTODO: LBX_EditItem_byObjectPointer
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 18/11/11, 17:42:39
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //   // Edita un item del listbox desde fuera del objeto ListBox sin entrar en conflicto con el método LBX_HandleEvents
  // Ver también LBX_EditItem_byObjectPointer y LBX_EditItem_byColNum
  //
  //
  // PARÁMETROS
  // LBX_EditItem_byObjectPointer(NombreObjetoLista;PunteroObjeto;Fila)
  // $1: Texto : Nombre del Objeto lista
  // $2: Puntero : Puntero sobre objeto columna que se desea editar
  // $3: Longint : Numero de la fila a Editar


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_ObjectIsEnterable;$b_PointerObjectIsInLBX)
C_LONGINT:C283($i;$l_fieldNum;$l_NumberOfColumns;$l_numberOfRows;$l_PointerFieldNum;$l_PointerTableNum;$l_table)
C_POINTER:C301($y_ObjectPointer;$y_TablePointer)
C_TEXT:C284($t_listboxObjectName;$t_ObjectName;$t_PointerVarName;$t_SelectionName;$t_varName)

ARRAY BOOLEAN:C223($ab_Visible;0)
ARRAY POINTER:C280($ay_Headers;0)
ARRAY POINTER:C280($ay_Objects;0)
ARRAY POINTER:C280($ay_Styles;0)
ARRAY TEXT:C222($at_ColumnNames;0)
ARRAY TEXT:C222($at_HeaderNames;0)

  // arreglos para obtener información de la configuración del ListBox

$t_listboxObjectName:=$1
$y_ObjectPointer:=$2
vl_LBXrow:=$3

  // CODIGO PRINCIPAL

  // obtengo información de la lista para validar los parametros recibidos
LISTBOX GET TABLE SOURCE:C1014(*;$t_listboxObjectName;$l_table;$t_SelectionName)
LISTBOX GET ARRAYS:C832(*;$t_listboxObjectName;$at_ColumnNames;$at_HeaderNames;$ay_Objects;$ay_Headers;$ab_Visible;$ay_Styles)
$l_NumberOfColumns:=LISTBOX Get number of columns:C831(*;$t_listboxObjectName)
$l_numberOfRows:=LISTBOX Get number of rows:C915(*;$t_listboxObjectName)

  // obtengo información del puntero sobre el objeto a editar
RESOLVE POINTER:C394($y_ObjectPointer;$t_PointerVarName;$l_PointerTableNum;$l_PointerFieldNum)

  // verifico que el objeto apuntado exista en la lista
vl_LBXcolumn:=0
$b_PointerObjectIsInLBX:=False:C215
For ($i;1;Size of array:C274($ay_Objects))
	RESOLVE POINTER:C394($ay_Objects{$i};$t_varName;$l_Table;$l_fieldNum)
	If ((($t_PointerVarName=$t_varName) & ($t_PointerVarName#"")) | (($l_Table>-1) & ($l_PointerTableNum=$l_Table) & ($l_PointerFieldNum=$l_fieldNum)))
		vl_LBXcolumn:=$i
		$i:=Size of array:C274($ay_Objects)
	End if 
End for 

  // si el objeto no existe en el listbox muestro una alerta
If (vl_LBXcolumn=0)
	If ($t_PointerVarName="")
		If ((Is field number valid:C1000($l_PointerTableNum;$l_PointerFieldNum)))
			$t_ObjectName:="["+Table name:C256($l_PointerTableNum)+"]"+Field name:C257($l_PointerTableNum;$l_PointerFieldNum)
		End if 
	Else 
		$t_ObjectName:=$t_PointerVarName
	End if 
	ALERT:C41("El objeto referenciado \""+$t_ObjectName+"\" no esta definido en el Listbox.")
End if 

If (vl_LBXcolumn>0)  //si el objeto existe en el listbox
	If (Not:C34(Is nil pointer:C315($ay_Objects{vl_LBXcolumn})))
		$b_ObjectIsEnterable:=OBJECT Get enterable:C1067($ay_Objects{vl_LBXcolumn}->)
	End if 
	
	Case of 
		: (vl_LBXrow>$l_numberOfRows)  //si la fila no existe en el listbox  muestro una alerta
			ALERT:C41("La fila especificada ("+String:C10(vl_LBXrow)+") no existe en la fila.")
			
		: (Is nil pointer:C315($ay_Objects{vl_LBXcolumn}))  //si la columna corresponde a una formula muestro una alerta
			ALERT:C41("Los valores de la columna corresponden a una fórmula. \r\rNo puede ser editada.")
			
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

