//%attributes = {}
  // MÉTODO: LBX_HandleEvents
  // 
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 17/11/11, 17:14:37
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //   Maneja los eventos de de edición de items en un Listbox y los desplazamientos 
  //   entre las celdas con las teclas enter o flechas de desplazamiento
  //   - Puede ser utilizados con ListBox con arreglos o campos
  //   - El llamado a este método debe hacerse desde el método objeto del ListBox, 
  //   el objecto activo (campo o arreglo) es detectado automáticamente
  //   - Permite llamar a métodos de callback para la entrada y la salida de la celda.
  //   Los métodos de callback de llamada pueden usarse para rechazar el acceso a una celda específica (entrada)
  //   o para rechazar la modificación de un valor (salida)
  //   
  //   En los métodos de callback se deben declarar dos parametros: 
  //   $1: puntero, recibe un puntero sobre el objeto en edición (campo o arreglo)
  //   $2: longint fila editada
  //   Utilizando conjuntamente ambos argumentos se obtiene el valor de la celda
  //   Para rechazar la entrada o el valor editado se debe retornar un valor inferior a 0 en $0. 
  //   si se retorna 0 o superior la accción es aceptada
  //
  //   ===========
  //   Importante!
  //   ===========
  //   El listbox y el formulario deben tener activado los eventos siguientes
  //   - On Before Data Entry (Si el formulario proviene de una versión anterior a v12 es posible que este evento no aparezca 
  //     en la lista de propiedades. En ese caso hay que recrear el Listbox)
  //   - On Before Keystroke
  //   - On Double Clicked
  //   - On Data Change
  //   - On Losing Focus
  //
  //
  // PARÁMETROS
  // $l_editedCol:=LBX_HandleEvents(nombre_ObjetoListBox;punteroObjeto{;callbackEntrada{;callbackSalida}})
  //   $1: Nombre_objetoListBox : Texto   ->   : nombre del objeto Listbox (objeto, no variable)
  //   $2: punteroObjeto        : Puntero <-   : retorna un puntero sobre el objeto (columna, campo o arreglo)
  //   $3: callbackEntrada:     : Texto   ->   : nombre del metodo de callback de entrada a la celda
  //   $4: callbackSalida:      : Texto   ->   : nombre del metodo de callback de salida de la celda
  //   Resultado                : Longint <-   : numero de columna editada (positivo si callback no devuelve error, negativo si hay error)
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($0;$l_RowEdited)
C_TEXT:C284($1;$t_listboxObjectName;$3;$t_EntryCallBackMethod;$4;$t_ExitCallBackMethod)
C_POINTER:C301($2;$y_objectEdited)
C_LONGINT:C283($l_char;vl_LBXcolumn;vl_LBXrow;$l_numberOfRows;$l_numberOfColumns;$l_CallBackResult)
C_BOOLEAN:C305(vb_LBXentryRejected)
C_BOOLEAN:C305($b_handled)
C_TEXT:C284($t_SelectionName)

  // variables proceso para almacenar el valor al entrar a la celda
C_LONGINT:C283(vl_LBXobjectValue_Long)
C_REAL:C285(vr_LBXobjectValue_Real)
_O_C_INTEGER:C282(vi_LBXobjectValue_Integer)
C_TEXT:C284(vt_LBXobjectValue_Text)
C_DATE:C307(vd_LBXobjectValue_Date)
C_TIME:C306(vh_LBXobjectValue_Time)
C_PICTURE:C286(vp_LBXobjectValue_Picture)
C_BOOLEAN:C305(vb_LBXobjectValue_Boolean)

  // arreglos para obtener información de la configuración del ListBox
ARRAY TEXT:C222($at_ColumnNames;0)
ARRAY TEXT:C222($at_HeaderNames;0)
ARRAY POINTER:C280($ay_Objects;0)
ARRAY POINTER:C280($ay_Headers;0)
ARRAY BOOLEAN:C223($ab_Visible;0)
ARRAY POINTER:C280($ay_Styles;0)



$t_listboxObjectName:=$1  //nombre del objeto listbox
$y_objectEdited:=$2  //puntero en el que se retorna el objeto (campo o arreglo)


Case of 
	: (Count parameters:C259=3)
		$t_EntryCallBackMethod:=$3  // callback de entrada a la celda
		
	: (Count parameters:C259=4)
		$t_EntryCallBackMethod:=$3  // callback de entrada a la celda
		$t_ExitCallBackMethod:=$4  // callback de salida de la celda
		
End case 

  // CODIGO PRINCIPAL

  // obtención de información del listbox
LISTBOX GET TABLE SOURCE:C1014(*;$t_listboxObjectName;$l_table;$t_SelectionName)
LISTBOX GET ARRAYS:C832(*;$t_listboxObjectName;$at_ColumnNames;$at_HeaderNames;$ay_Objects;$ay_Headers;$ab_Visible;$ay_Styles)
$l_numberOfRows:=LISTBOX Get number of rows:C915(*;$t_listboxObjectName)
$l_numberOfColumns:=LISTBOX Get number of columns:C831(*;$t_listboxObjectName)

  // obtengo la columna y la fila actual
If ((vl_LBXcolumn=0) & (vl_LBXrow=0))
	LISTBOX GET CELL POSITION:C971(*;$t_listboxObjectName;vl_LBXcolumn;vl_LBXrow)
End if 

Case of 
	: (Form event:C388=On Before Data Entry:K2:39)
		
		  // Inicializo las variables en las que almaceno el valor de la celda al entrar
		vl_LBXobjectValue_Long:=0
		vr_LBXobjectValue_Real:=0
		vi_LBXobjectValue_Integer:=0
		vt_LBXobjectValue_Text:=""
		vd_LBXobjectValue_Date:=!00-00-00!
		vh_LBXobjectValue_Time:=?00:00:00?
		vp_LBXobjectValue_Picture:=vp_LBXobjectValue_Picture*0
		vb_LBXobjectValue_Boolean:=False:C215
		
		
		  // almacenos el valor de la celda actual en variable según el tipo del objecto (columna)
		$l_TypeObject:=Type:C295($ay_Objects{vl_LBXcolumn}->)
		Case of 
			: ($l_TypeObject=Real array:K8:17)
				vr_LBXobjectValue_Real:=$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}
				
			: ($l_TypeObject=LongInt array:K8:19)
				vl_LBXobjectValue_Long:=$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}
				
			: ($l_TypeObject=Integer array:K8:18)
				vi_LBXobjectValue_Integer:=$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}
				
			: (($l_TypeObject=Text array:K8:16) | ($l_TypeObject=String array:K8:15))
				vt_LBXobjectValue_Text:=$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}
				
			: ($l_TypeObject=Boolean array:K8:21)
				vb_LBXobjectValue_Boolean:=$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}
				
			: ($l_TypeObject=Picture array:K8:22)
				vp_LBXobjectValue_Picture:=$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}
				
			: ($l_TypeObject=Date array:K8:20)
				vd_LBXobjectValue_Date:=$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}
				
			: ($l_TypeObject=Is real:K8:4)
				vr_LBXobjectValue_Real:=$ay_Objects{vl_LBXcolumn}->
				
			: ($l_TypeObject=Is longint:K8:6)
				vl_LBXobjectValue_Long:=$ay_Objects{vl_LBXcolumn}->
				
			: ($l_TypeObject=Is integer:K8:5)
				vi_LBXobjectValue_Integer:=$ay_Objects{vl_LBXcolumn}->
				
			: (($l_TypeObject=Is text:K8:3) | ($l_TypeObject=Is alpha field:K8:1))
				vt_LBXobjectValue_Text:=$ay_Objects{vl_LBXcolumn}->
				
			: ($l_TypeObject=Is boolean:K8:9)
				vb_LBXobjectValue_Boolean:=$ay_Objects{vl_LBXcolumn}->
				
			: ($l_TypeObject=Is picture:K8:10)
				vp_LBXobjectValue_Picture:=$ay_Objects{vl_LBXcolumn}->
				
			: ($l_TypeObject=Is date:K8:7)
				vd_LBXobjectValue_Date:=$ay_Objects{vl_LBXcolumn}->
				
			: ($l_TypeObject=Is time:K8:8)
				vh_LBXObjectValue_Time:=$ay_Objects{vl_LBXcolumn}->
				
		End case 
		
		
		  // si se especificó un metodo de callback de entrada lo ejecuto
		If ($t_EntryCallBackMethod#"")
			EXECUTE METHOD:C1007($t_EntryCallBackMethod;$l_CallBackResult;$ay_Objects{vl_LBXcolumn};vl_LBXrow)
			If ($l_CallBackResult<0)
				vb_LBXentryRejected:=True:C214  //si el método de callback devuelve error rechazo la entrada y salgo de la celda
				POST KEY:C465(Enter:K15:35)
			Else 
				vb_LBXentryRejected:=False:C215
			End if 
		End if 
		
		vl_LBXcolumn:=0
		vl_LBXrow:=0
		
	: (Form event:C388=On Before Keystroke:K2:6)  // obtengo el caracter correspondiente a la tecla presionada por el usuario, si es una flecha de desplazamiento será procesada mas abajo
		vb_LBXentryRejected:=False:C215
		$l_char:=Character code:C91(Keystroke:C390)
		
		
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		LISTBOX GET CELL POSITION:C971(*;$t_listboxObjectName;vl_LBXcolumn;vl_LBXrow)
		vb_LBXentryRejected:=False:C215
		If (Not:C34(Is nil pointer:C315($ay_Objects{vl_LBXcolumn})))
			If (OBJECT Get enterable:C1067($ay_Objects{vl_LBXcolumn}->))  // si la columna fue definida como ingresable
				If ($l_table>0)  // si el listbox despliega campos me aseguro que el registro esté en lectura - escritura
					READ WRITE:C146(Table:C252($l_Table)->)
					LOAD RECORD:C52(Table:C252($l_Table)->)
				End if 
				EDIT ITEM:C870($ay_Objects{vl_LBXcolumn}->;vl_LBXrow)  // pongo la celda en edición
			End if 
		End if 
		
		
		
	: (Form event:C388=On Data Change:K2:15)
		vb_LBXentryRejected:=False:C215
		  // asigno las variables que se devolverán al llamado. Si no hay edición el método devuelve 0 en el resultado y NUL en el puntero sobre el objeto editado
		$l_RowEdited:=vl_LBXrow  // fila editada
		$y_objectEdited->:=$ay_Objects{vl_LBXcolumn}  // objeto editado
		
		  // si se especificó un método callback de salida lo ejecuto
		If ($t_exitCallBackMethod#"")
			EXECUTE METHOD:C1007($t_exitCallBackMethod;$l_CallBackResult;$ay_Objects{vl_LBXcolumn};vl_LBXrow)
			If ($l_CallBackResult<0)
				$l_TypeObject:=Type:C295($ay_Objects{vl_LBXcolumn}->)
				$l_RowEdited:=-vl_LBXrow
				
				  // si el método de callback de salida devuelve un error restablezco los valores antes de la edición
				If ($l_table>0)
					READ WRITE:C146(Table:C252($l_Table)->)
					LOAD RECORD:C52(Table:C252($l_Table)->)
				End if 
				
				Case of 
					: ($l_TypeObject=Real array:K8:17)
						$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}:=vr_LBXobjectValue_Real
						
					: ($l_TypeObject=LongInt array:K8:19)
						$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}:=vl_LBXobjectValue_Long
						
					: ($l_TypeObject=Integer array:K8:18)
						$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}:=vi_LBXobjectValue_Integer
						
					: (($l_TypeObject=Text array:K8:16) | ($l_TypeObject=String array:K8:15))
						$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}:=vt_LBXobjectValue_Text
						
					: ($l_TypeObject=Boolean array:K8:21)
						$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}:=vb_LBXobjectValue_Boolean
						
					: ($l_TypeObject=Picture array:K8:22)
						$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}:=vp_LBXobjectValue_Picture
						
					: ($l_TypeObject=Date array:K8:20)
						$ay_Objects{vl_LBXcolumn}->{vl_LBXrow}:=vd_LBXobjectValue_Date
						
					: ($l_TypeObject=Is real:K8:4)
						$ay_Objects{vl_LBXcolumn}->:=vr_LBXobjectValue_Real
						
					: ($l_TypeObject=Is longint:K8:6)
						$ay_Objects{vl_LBXcolumn}->:=vl_LBXobjectValue_Long
						
					: ($l_TypeObject=Is integer:K8:5)
						$ay_Objects{vl_LBXcolumn}->:=vi_LBXobjectValue_Integer
						
					: (($l_TypeObject=Is text:K8:3) | ($l_TypeObject=Is alpha field:K8:1))
						$ay_Objects{vl_LBXcolumn}->:=vt_LBXobjectValue_Text
						
					: ($l_TypeObject=Is boolean:K8:9)
						$ay_Objects{vl_LBXcolumn}->:=vb_LBXobjectValue_Boolean
						
					: ($l_TypeObject=Is picture:K8:10)
						$ay_Objects{vl_LBXcolumn}->:=vp_LBXobjectValue_Picture
						
					: ($l_TypeObject=Is date:K8:7)
						$ay_Objects{vl_LBXcolumn}->:=vd_LBXobjectValue_Date
						
					: ($l_TypeObject=Is time:K8:8)
						$ay_Objects{vl_LBXcolumn}->:=vh_LBXObjectValue_Time
						
				End case 
				
				  // si el listbox muestra campos libero el registro editado
				If ($l_table>0)
					KRL_SaveUnLoadReadOnly (Table:C252($l_table))
				End if 
				
			End if 
			
		End if 
		
		
		If ($l_CallBackResult=0)  // si no hay error devuelto por el callback paso a la celda siguiente (asigno ENTER key &l_Char que será procesado más abajo)
			$l_char:=Character code:C91(Keystroke:C390)
			If (($l_char#Down arrow key:K12:19) & ($l_char#Up arrow key:K12:18) & ($l_char#Left arrow key:K12:16) & ($l_char#Right arrow key:K12:17))
				$l_Char:=Enter key:K12:26
			End if 
		Else 
			If ($l_table>0)  //si hay error en el callback de salida el cursor se mantiene enla celda y permanece editable después de haber reestablecido el valor inicial
				READ WRITE:C146(Table:C252($l_Table)->)
				LOAD RECORD:C52(Table:C252($l_Table)->)
			End if 
			EDIT ITEM:C870($ay_Objects{vl_LBXcolumn}->;vl_LBXrow)
		End if 
		
		
	: ((Form event:C388=On Losing Focus:K2:8) & (Not:C34(vb_LBXentryRejected=False:C215)))  // solo para el manejo correcto de los eventos
		LISTBOX GET CELL POSITION:C971(*;$t_listboxObjectName;$l_col;$l_row)
		$l_char:=Character code:C91(Keystroke:C390)
		If (($l_char#Down arrow key:K12:19) & ($l_char#Up arrow key:K12:18) & ($l_char#Left arrow key:K12:16) & ($l_char#Right arrow key:K12:17))
			If ((vl_LBXcolumn=$l_col) & (vl_LBXrow=$l_row))
				$l_Char:=Down arrow key:K12:19
			End if 
		End if 
End case 




  // manejo de las teclas de desplazamiento
If ($l_Char>0)
	$y_ObjectPointer:=$ay_Objects{vl_LBXcolumn}
	
	Case of 
		: (($l_char=Down arrow key:K12:19) | ($l_Char=Enter key:K12:26))
			If (vl_LBXrow<$l_numberOfRows)
				vl_LBXrow:=vl_LBXrow+1
				If ($l_table>0)
					READ WRITE:C146(Table:C252($l_Table)->)
					LOAD RECORD:C52(Table:C252($l_Table)->)
				End if 
				EDIT ITEM:C870($y_ObjectPointer->;vl_LBXrow)
				$b_handled:=True:C214
			End if 
			If (Not:C34($b_handled))
				POST KEY:C465(Enter key:K12:26)
			End if 
			
			
		: ($l_char=Up arrow key:K12:18)
			If (vl_LBXrow>1)
				vl_LBXrow:=vl_LBXrow-1
				If ($l_table>0)
					READ WRITE:C146(Table:C252($l_Table)->)
					LOAD RECORD:C52(Table:C252($l_Table)->)
				End if 
				EDIT ITEM:C870($y_ObjectPointer->;vl_LBXrow)
				$b_handled:=True:C214
			End if 
			If (Not:C34($b_handled))
				POST KEY:C465(Enter key:K12:26)
			End if 
			
			
		: ($l_char=Left arrow key:K12:16)
			If (vl_LBXcolumn>1)
				vl_LBXcolumn:=vl_LBXcolumn-1
				For ($i;vl_LBXcolumn;1;-1)
					If (Not:C34(Is nil pointer:C315($ay_Objects{vl_LBXcolumn})))
						If ((OBJECT Get enterable:C1067($ay_Objects{$i}->)) & ($ab_Visible{$i}))
							If ($l_table>0)
								READ WRITE:C146(Table:C252($l_Table)->)
								LOAD RECORD:C52(Table:C252($l_Table)->)
							End if 
							EDIT ITEM:C870($ay_Objects{$i}->;vl_LBXrow)
							$b_handled:=True:C214
							$i:=1
						End if 
					End if 
				End for 
			End if 
			If (Not:C34($b_handled))
				POST KEY:C465(Enter key:K12:26)
			End if 
			
		: ($l_char=Right arrow key:K12:17)
			If (vl_LBXcolumn<$l_numberOfColumns)
				vl_LBXcolumn:=vl_LBXcolumn+1
				For ($i;vl_LBXcolumn;$l_numberOfColumns)
					If (Not:C34(Is nil pointer:C315($ay_Objects{vl_LBXcolumn})))
						If ((OBJECT Get enterable:C1067($ay_Objects{$i}->)) & ($ab_Visible{$i}))
							If ($l_table>0)
								READ WRITE:C146(Table:C252($l_Table)->)
								LOAD RECORD:C52(Table:C252($l_Table)->)
							End if 
							EDIT ITEM:C870($ay_Objects{vl_LBXcolumn}->;vl_LBXrow)
							$b_handled:=True:C214
							$i:=$l_numberOfColumns
						End if 
					End if 
				End for 
			End if 
			If (Not:C34($b_handled))
				POST KEY:C465(Enter key:K12:26)
			End if 
			
	End case 
	
	
End if 


  // si los métodos de callback devolvieron algún error la lista es redibujada para reflejar los cambios efectuados por código en el valor de la celda
If ($l_rowEdited<0)
	REDRAW:C174($t_listboxObjectName)
End if 

$0:=$l_RowEdited
