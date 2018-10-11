//%attributes = {}
  // KRL_ValoresDuplicados(campo:Y; arregloRecNums:Y{; arregloValores;Y}) <- numero de registros con valores duplicados
  // -> puntero sobre campo
  // <- puntero sobre arreglo LONGINT: retorna recnums de los registros con valor duplicados en el campo en la selección.
  // <- arregloValores: retorna los valores duplicados en el campo en la selección, opcional

If (False:C215)
	  // Por: Alberto Bachler K.: 16-12-13, 14:26:44
	  //  ---------------------------------------------
End if 

C_POINTER:C301($1)
C_POINTER:C301($2)

_O_C_INTEGER:C282($i)
C_LONGINT:C283($l_Resultado;$l_tipoCampo)
C_POINTER:C301($y_Arreglo;$y_ArregloValores;$y_Campo;$y_recNumDuplicados_a;$y_tabla)

ARRAY DATE:C224($ad_fecha;0)
ARRAY INTEGER:C220($ai_entero;0)
ARRAY LONGINT:C221($al_largo;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY REAL:C219($ar_real;0)
ARRAY TEXT:C222($at_Alfa;0)
If (False:C215)
	C_POINTER:C301(KRL_ValoresDuplicados ;$1)
	C_POINTER:C301(KRL_ValoresDuplicados ;$2)
End if 


$y_tabla:=Table:C252(Table:C252($1))
$y_Campo:=$1
$y_recNumDuplicados_a:=$2
If (Count parameters:C259=3)
	$y_ArregloValores:=$3
End if 
$l_tipoCampo:=Type:C295($y_Campo->)

If (Not:C34(Is nil pointer:C315($y_ArregloValores)))
	AT_RedimArrays (0;$y_recNumDuplicados_a;$y_ArregloValores)
Else 
	AT_RedimArrays (0;$y_recNumDuplicados_a)
End if 

Case of 
	: (($l_tipoCampo=Is BLOB:K8:12) | ($l_tipoCampo=Is picture:K8:10) | ($l_tipoCampo=Is text:K8:3) | ($l_tipoCampo=Is boolean:K8:9))
		ALERT:C41("Este método sólo puede ser usado para campos numéricos o alfanuméricos (excluyendo texto)")
		$l_Resultado:=-1
		
	: ($l_tipoCampo=Is real:K8:4)
		SELECTION TO ARRAY:C260($y_tabla->;$al_recNums;$y_Campo->;$ar_real)
		$y_Arreglo:=->$ar_real
		
	: ($l_tipoCampo=Is integer:K8:5)
		SELECTION TO ARRAY:C260($y_tabla->;$al_recNums;$y_Campo->;$ai_entero)
		$y_Arreglo:=->$ai_entero
		
	: (($l_tipoCampo=Is longint:K8:6) | ($l_tipoCampo=Is time:K8:8))
		SELECTION TO ARRAY:C260($y_tabla->;$al_recNums;$y_Campo->;$al_largo)
		$y_Arreglo:=->$al_largo
		
	: ($l_tipoCampo=Is date:K8:7)
		SELECTION TO ARRAY:C260($y_tabla->;$al_recNums;$y_Campo->;$ad_fecha)
		$y_Arreglo:=->$ad_fecha
		
	: ($l_tipoCampo=Is alpha field:K8:1)
		SELECTION TO ARRAY:C260($y_tabla->;$al_recNums;$y_Campo->;$at_Alfa)
		$y_Arreglo:=->$at_Alfa
		
End case 

If ($l_Resultado=0)
	MULTI SORT ARRAY:C718($y_Arreglo->;>;$al_recNums;>)
	For ($i;2;Size of array:C274($al_recNums))
		If ($y_Arreglo->{$i}=$y_Arreglo->{$i-1})
			APPEND TO ARRAY:C911($y_recNumDuplicados_a->;$al_recNums{$i-1})
			APPEND TO ARRAY:C911($y_recNumDuplicados_a->;$al_recNums{$i})
			If (Not:C34(Is nil pointer:C315($y_ArregloValores)))
				APPEND TO ARRAY:C911($y_ArregloValores->;$y_Arreglo->{$i-1})
				APPEND TO ARRAY:C911($y_ArregloValores->;$y_Arreglo->{$i})
			End if 
		End if 
	End for 
End if 

For ($i;Size of array:C274($y_recNumDuplicados_a->);2;-1)
	If ($y_recNumDuplicados_a->{$i}=$y_recNumDuplicados_a->{$i-1})
		DELETE FROM ARRAY:C228($y_recNumDuplicados_a->;$i)
		If (Not:C34(Is nil pointer:C315($y_ArregloValores)))
			DELETE FROM ARRAY:C228($y_ArregloValores->;$i)
		End if 
	End if 
End for 

$l_resultado:=Size of array:C274($y_recNumDuplicados_a->)

$0:=$l_resultado