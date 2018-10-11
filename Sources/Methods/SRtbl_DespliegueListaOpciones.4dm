//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 10-08-16, 16:12:51
  // ----------------------------------------------------
  // Método: SRtbl_DespliegueListaOpciones

  // Descripción:
  // La finalidad del método es utilizarlo en reemplazo del SRtbl_ShowChoiceList 
  //
  // Parámetros
  // $1 = Se debe pasar como parametro un arreglo de punteros, cada elemento debe apuntar a un arreglo 
  // $2 = tamaño de celdas (pixeles)
  // $3 = Titulo Encabezados de columnas
  // $4 = Se debe pasar el titulo de la ventana
  // $5 = TRUE: multiselección , FALSE: Selección Simple
  // $6 = Arreglo de tipo Longint para recibir las líneas seleccionadas 
  // $7 = arreglo con lineas preseleccionadas.(opcional)
  // Nota: El listbox tiene un ancho de 400 pixeles, en base a eso se debe calcular el tamaño de las columnas
  // ----------------------------------------------------


C_POINTER:C301(y_puntero,y_resultado;y_marcarLineas)
ARRAY POINTER:C280(ay_arreglos;0)
CLEAR VARIABLE:C89(y_marcarLineas)

y_puntero:=$1
y_tamaño:=$2
y_titulo:=$3
vt_titulo:=$4
muliseleccion:=$5
y_resultado:=$6

If (Count parameters:C259=7)
	y_marcarLineas:=$7
End if 

If (Count parameters:C259=8)
	y_columnaEditable:=$8
End if 


For ($i;1;Size of array:C274(y_puntero->))
	APPEND TO ARRAY:C911(ay_arreglos;y_puntero->{$i})
End for 
WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_MenuSeleccion";-1;-Palette form window:K39:9;vt_titulo)
DIALOG:C40([xxSTR_Constants:1];"STR_MenuSeleccion")
CLOSE WINDOW:C154

$0:=bAceptar