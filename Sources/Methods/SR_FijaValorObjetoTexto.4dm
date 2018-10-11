//%attributes = {}
  // SR_FijaValorObjetoTexto()
  // Por: Alberto Bachler K.: 14-08-15, 13:06:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)
C_TEXT:C284($4)
C_BOOLEAN:C305($5)
C_TEXT:C284($6)
C_BOOLEAN:C305($7)
C_TEXT:C284($8)
C_BOOLEAN:C305($9)
C_TEXT:C284($10)
C_BOOLEAN:C305($11)
C_TEXT:C284($12)
C_BOOLEAN:C305($13)
C_TEXT:C284($14)
C_BOOLEAN:C305($15)
C_TEXT:C284($16)

C_BOOLEAN:C305($b_Condicion)
C_LONGINT:C283($l_columnas;$l_elementoArreglo;$l_error;$l_filas;$l_numeroCampo;$l_numeroTabla;$l_opciones;$l_orden;$l_PosAbajo;$l_PosArriba)
C_LONGINT:C283($l_PosDerecha;$l_PosIzquierda;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV;$l_seleccionado;$l_tipoCalculo;$l_tipoObjeto;$l_tipoVariable)
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_nombreCalculo;$t_nombreObjeto;$t_nombreVariable;$t_RefCampo;$t_tipoObjeto;$t_valorTexto)

ARRAY LONGINT:C221($al_idObjetos;0)
ARRAY LONGINT:C221($aPropID;0)
ARRAY TEXT:C222($aPropName;0)
ARRAY TEXT:C222($aPropValue;0)



If (False:C215)
	C_BOOLEAN:C305(SR_FijaValorObjetoTexto ;$1)
	C_TEXT:C284(SR_FijaValorObjetoTexto ;$2)
	C_BOOLEAN:C305(SR_FijaValorObjetoTexto ;$3)
	C_TEXT:C284(SR_FijaValorObjetoTexto ;$4)
	C_BOOLEAN:C305(SR_FijaValorObjetoTexto ;$5)
	C_TEXT:C284(SR_FijaValorObjetoTexto ;$6)
	C_BOOLEAN:C305(SR_FijaValorObjetoTexto ;$7)
	C_TEXT:C284(SR_FijaValorObjetoTexto ;$8)
	C_BOOLEAN:C305(SR_FijaValorObjetoTexto ;$9)
	C_TEXT:C284(SR_FijaValorObjetoTexto ;$10)
	C_BOOLEAN:C305(SR_FijaValorObjetoTexto ;$11)
	C_TEXT:C284(SR_FijaValorObjetoTexto ;$12)
	C_BOOLEAN:C305(SR_FijaValorObjetoTexto ;$13)
	C_TEXT:C284(SR_FijaValorObjetoTexto ;$14)
	C_BOOLEAN:C305(SR_FijaValorObjetoTexto ;$15)
	C_TEXT:C284(SR_FijaValorObjetoTexto ;$16)
End if 

$y_objeto:=SR_GetVariableFieldInfo (->$t_nombreVariable;->$t_tipoObjeto)


If (Count parameters:C259>=2)
	$b_Condicion:=$1
	$t_valorTexto:=$2
	If ($b_Condicion)
		$y_objeto->:=$t_valorTexto
	End if 
End if 
If (Count parameters:C259>=4)
	$b_Condicion:=$3
	$t_valorTexto:=$4
	If ($b_Condicion)
		$y_objeto->:=$t_valorTexto
	End if 
End if 
If (Count parameters:C259>=6)
	$b_Condicion:=$5
	$t_valorTexto:=$6
	If ($b_Condicion)
		$y_objeto->:=$t_valorTexto
	End if 
End if 
If (Count parameters:C259>=8)
	$b_Condicion:=$7
	$t_valorTexto:=$8
	If ($b_Condicion)
		$y_objeto->:=$t_valorTexto
	End if 
End if 
If (Count parameters:C259>=10)
	$b_Condicion:=$9
	$t_valorTexto:=$10
	If ($b_Condicion)
		$y_objeto->:=$t_valorTexto
	End if 
End if 
If (Count parameters:C259>=12)
	$b_Condicion:=$11
	$t_valorTexto:=$12
	If ($b_Condicion)
		$y_objeto->:=$t_valorTexto
	End if 
End if 
If (Count parameters:C259>=14)
	$b_Condicion:=$13
	$t_valorTexto:=$14
	If ($b_Condicion)
		$y_objeto->:=$t_valorTexto
	End if 
End if 
If (Count parameters:C259=16)
	$b_Condicion:=$15
	$t_valorTexto:=$6
	If ($b_Condicion)
		$y_objeto->:=$t_valorTexto
	End if 
End if 