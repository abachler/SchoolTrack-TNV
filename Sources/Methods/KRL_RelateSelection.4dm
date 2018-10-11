//%attributes = {}
  // KRL_RelateSelection()
  //
  //
  // creado por: Alberto Bachler Klein: 23-08-16, 12:32:51
  // -----------------------------------------------------------
C_REAL:C285($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($b_showProgress)
C_LONGINT:C283($i;$l_tipoCampo)
C_POINTER:C301($y_arreglo;$y_campoDestino;$y_CampoOrigen;$y_tabla;$y_tablaDestino;$y_tablaOrigen)
C_TEXT:C284($t_ProgressMessage)

ARRAY BOOLEAN:C223($ab_Booleano;0)
ARRAY DATE:C224($ad_fechas;0)
ARRAY INTEGER:C220($ai_enteros;0)
ARRAY LONGINT:C221($ai_longint;0)
ARRAY REAL:C219($ar_real;0)
ARRAY TEXT:C222($at_Texto;0)
ARRAY TEXT:C222($at_Texto;0)

If (False:C215)
	C_REAL:C285(KRL_RelateSelection ;$0)
	C_POINTER:C301(KRL_RelateSelection ;$1)
	C_POINTER:C301(KRL_RelateSelection ;$2)
	C_TEXT:C284(KRL_RelateSelection ;$3)
End if 


$y_tablaDestino:=Table:C252(Table:C252($1))  //get pointer to file from field pointer
$y_tablaOrigen:=Table:C252(Table:C252($2))
$y_campoDestino:=$1
$y_CampoOrigen:=$2
GET FIELD PROPERTIES:C258($y_CampoOrigen;$l_tipoCampo)
Case of 
	: ($l_tipoCampo=Is integer:K8:5)
		$y_arreglo:=->$ai_enteros
	: ($l_tipoCampo=Is alpha field:K8:1)
		$y_arreglo:=->$at_Texto
	: ($l_tipoCampo=Is text:K8:3)
		$y_arreglo:=->$at_Texto
	: (($l_tipoCampo=Is real:K8:4))
		$y_arreglo:=->$ar_real
	: ($l_tipoCampo=Is longint:K8:6)
		$y_arreglo:=->$ai_longint
	: ($l_tipoCampo=Is date:K8:7)
		$y_arreglo:=->$ad_fechas
	: ($l_tipoCampo=Is boolean:K8:9)
		$y_arreglo:=->$ab_Booleano
End case 


$readOnlyState:=Read only state:C362($y_tablaOrigen->)
If (Records in selection:C76($y_tablaOrigen->)>0)
	SELECTION TO ARRAY:C260($y_CampoOrigen->;$y_arreglo->)
	If (Size of array:C274($y_arreglo->)>0)
		QUERY WITH ARRAY:C644($y_campoDestino->;$y_arreglo->)
	Else 
		CREATE EMPTY SET:C140($y_tablaDestino->;"$seleccion")
		USE SET:C118("$seleccion")
	End if 
Else 
	CREATE EMPTY SET:C140($y_tablaDestino->;"$seleccion")
	USE SET:C118("$seleccion")
End if 

If ($readOnlyState)
	READ ONLY:C145($y_tablaOrigen->)
Else 
	READ WRITE:C146($y_tablaOrigen->)
End if 
LOAD RECORD:C52($y_tablaOrigen->)

$0:=Records in selection:C76($y_tablaDestino->)
