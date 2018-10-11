//%attributes = {}
  // Método: KRL_Array2Selection
  // código original de:
  // modificado por Alberto Bachler Klein el 17/02/18, 12:32:54
  // - normalización, declaración de variables, limpieza
  // - sin limite para el numero de pares arreglo/campo (antes 12)
  // - optimización, mejora en la eficiencia del código
  // - reemplazo INSERT ARRAY por APPEND TO ARRAY
  // - eliminacion de variables no utilizadas
  // - cambio del método des gestion de error
  // - corrección de errores de sintáxis no toleradas por 4D v16R6
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_POINTER:C301(${1})

C_BOOLEAN:C305($b_abortar;$b_transaccionLocal;$b_esperarSiBloqueado)
C_LONGINT:C283($i;$i_RecNums;$l_resultado;$l_tabla;$l_proceso)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_onERR_actual)

ARRAY LONGINT:C221($al_recNums;0)


If (False:C215)
	C_POINTER:C301(KRL_Array2Selection ;${1})
End if 


$t_onERR_actual:=Method called on error:C704
ON ERR CALL:C155("ERR_GenericOnError")

$y_tabla:=Table:C252(Table:C252($2))
$l_tabla:=Table:C252($y_tabla)
$l_resultado:=1
$b_abortar:=False:C215
Case of 
	: (Count parameters:C259>24)
		$b_abortar:=True:C214
		ALERT:C41("La rutina KRL_Array to selection acepta un máximo de 12 pares de punteros arreglo/campos.")
	: (Count parameters:C259>2)
		For ($i;3;Count parameters:C259;2)
			If (Size of array:C274(${$i}->)=Size of array:C274(${$i-2}->))
			Else 
				$i:=Count parameters:C259
				$b_abortar:=True:C214
				ALERT:C41("Los arreglos deben tener el mismo tamaño.")
			End if 
		End for 
		For ($i;4;Count parameters:C259;2)
			If (Table:C252(${$i})=$l_tabla)
			Else 
				$i:=Count parameters:C259
				$b_abortar:=True:C214
				ALERT:C41("No es posible aplicar arreglos a tablas distintas.")
			End if 
		End for 
	: (Size of array:C274($1->)#(Records in selection:C76($y_tabla->)))
		ALERT:C41("Arreglos y selección deben tener el mismo número de elementos.")
End case 
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums;"")  // guardo una copia de los recnum de la selección en un arreglo

If ($b_abortar)
	$l_resultado:=0
Else 
	$b_transaccionLocal:=False:C215
	If (Not:C34(In transaction:C397))
		START TRANSACTION:C239  // inicio transacción
		$b_transaccionLocal:=True:C214
	End if 
	READ WRITE:C146($y_tabla->)
	CREATE EMPTY SET:C140($y_tabla->;"lockedSet")  // inicializo "lockedSet" (por si acaso)
	
	For ($i;1;Count parameters:C259;2)
		ARRAY TO SELECTION:C261(${$i}->;${$i+1}->;*)
	End for 
	ARRAY TO SELECTION:C261
	
	UNLOAD RECORD:C212($y_tabla->)
	READ ONLY:C145($y_tabla->)
	LOAD RECORD:C52($y_tabla->)
	
	
	$b_esperarSiBloqueado:=True:C214
	If ((Records in set:C195("lockedSet")>0) & (error=0))  // si hay registros que no pudieron ser actualizados (en lockedSet)
		$l_resultado:=KRL_ShowLockedRecordsDialog   // muestro el cuadro de diálogo que permite al usuario cancelar
		If ($l_resultado=1)
			USE SET:C118("lockedSet")  // creo una selección con los registros bloqueados
			LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNumBloqueados)  // conservo los recnums de registros bloquedos en el arreglo de recnums de registros bloqueados
			For ($i_RecNums;Size of array:C274($al_recNums);1;-1)  // en este bucle elimino todos los elementos con los recnums de los registros exitosamente modificado
				If (Find in array:C230($al_recNumBloqueados;$al_recNums{$i_RecNums})<0)  // si el registro no estaba bloqueado elimino los elementos de los arreglos con los valores y los recnums
					For ($i;1;Count parameters:C259;2)
						DELETE FROM ARRAY:C228(${$i}->;$i_recNums)
						DELETE FROM ARRAY:C228($al_recNums;$i_recNums)
					End for 
				End if 
			End for 
			
			<>stopExec:=False:C215
			$l_proceso:=IT_UThermometer (1;0;__ ("Esperando que se liberen los registros.\rPresione la tecla ESC para interrumpir."))
			While ((Size of array:C274($al_recNumBloqueados)>0) & (<>stopExec=False:C215))  // mientras existen registros bloqueados y el usuario no cancela la operación
				For ($i_RecNums;1;Size of array:C274($al_recNums))  // recorro la selección
					READ WRITE:C146($y_tabla->)
					GOTO RECORD:C242($y_tabla->;$al_recNums{$i_RecNums})
					If (Not:C34(Locked:C147($y_tabla->)))  // si el registro no está bloqueado
						For ($i;1;Count parameters:C259;2)
							${$i+1}->{$i_RecNums}:=${$i}->{$i_RecNums}  // asigno a los campos los valores de los arreglos
						End for 
						SAVE RECORD:C53($y_tabla->)
						KRL_ReloadAsReadOnly ($y_tabla)
					End if 
				End for 
			End while 
			
			If (<>stopExec)
				$l_resultado:=0
			Else 
				$l_resultado:=1
			End if 
			IT_UThermometer (-2;$l_proceso)
		End if 
	Else 
		$l_resultado:=1
	End if 
	
	If (($l_resultado=1) & (<>sy_LErr=0))  // si la actualización de todos los registros se completó exitosamente
		If ($b_transaccionLocal)
			VALIDATE TRANSACTION:C240  // valido la transacción
		End if 
	Else   // si el usuario cancelo la modificación o se produjo un error
		If ($b_transaccionLocal)
			CANCEL TRANSACTION:C241  // cancelo la transacción
		End if 
	End if 
	<>stopExec:=False:C215
	error:=0
	ON ERR CALL:C155($t_onERR_actual)
End if 

$0:=$l_resultado

