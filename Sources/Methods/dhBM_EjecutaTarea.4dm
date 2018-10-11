//%attributes = {}
  // dhBM_EjecutaTarea()
  // Por: Alberto Bachler K.: 29-08-14, 08:38:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_POINTER:C301(${3})

C_LONGINT:C283($i;$l_error;$l_hora;$l_milisegundos;$l_minutos;$l_ms;$l_restoHora;$l_restoMinutos;$l_segundos)
C_TIME:C306($h_refLog)
C_TEXT:C284($t_Duracion;$t_errores;$t_metodo;$t_metodoGestionErrorActual;$t_nombreTarea)

ARRAY LONGINT:C221($al_codigosError;0)
ARRAY TEXT:C222($at_Componentes;0)
ARRAY TEXT:C222($at_textoErrores;0)


If (False:C215)
	C_TEXT:C284(dhBM_EjecutaTarea ;$1)
	C_TEXT:C284(dhBM_EjecutaTarea ;$2)
	C_POINTER:C301(dhBM_EjecutaTarea ;${3})
End if 

$t_metodo:=$1
$t_nombreTarea:=$2


$l_ms:=Milliseconds:C459
SEND PACKET:C103(vh_refLog;String:C10(Current time:C178(*);HH MM SS:K7:1)+"\t"+$t_nombreTarea)

$l_error:=0
If ($t_metodo#"")
	  //$t_metodoGestionErrorActual:=Method called on error
	  //ON ERR CALL("ERR_EventoError")
	Case of 
		: (Count parameters:C259=10)
			EXECUTE METHOD:C1007($t_metodo;*;$3->;$4->;$5->;$6->;$7->;$8->;$9->;$10->)
		: (Count parameters:C259=9)
			EXECUTE METHOD:C1007($t_metodo;*;$3->;$4->;$5->;$6->;$7->;$8->;$9->)
		: (Count parameters:C259=8)
			EXECUTE METHOD:C1007($t_metodo;*;$3->;$4->;$5->;$6->;$7->;$8->)
		: (Count parameters:C259=7)
			EXECUTE METHOD:C1007($t_metodo;*;$3->;$4->;$5->;$6->;$7->)
		: (Count parameters:C259=6)
			EXECUTE METHOD:C1007($t_metodo;*;$3->;$4->;$5->;$6->)
		: (Count parameters:C259=5)
			EXECUTE METHOD:C1007($t_metodo;*;$3->;$4->;$5->)
		: (Count parameters:C259=4)
			EXECUTE METHOD:C1007($t_metodo;*;$3->;$4->)
		: (Count parameters:C259=3)
			EXECUTE METHOD:C1007($t_metodo;*;$3->)
		Else 
			EXECUTE METHOD:C1007($t_metodo)
	End case 
	  //$l_error:=error
	  //error:=0
	  //ON ERR CALL($t_metodoGestionErrorActual)
End if 

If ($l_error=0)
	$l_milisegundos:=Milliseconds:C459-$l_ms
	$t_duracion:=DT_Milisegundos_a_texto ($l_milisegundos)
	
	SEND PACKET:C103(vh_refLog;": "+$t_Duracion+"."+"\r\n")
	
Else 
	  //GET LAST ERROR STACK($al_codigosError;$at_Componentes;$at_textoErrores)
	  //$t_errores:="Error durante la ejecución del método "+$t_metodo+"\r\t"
	  //For ($i;1;Size of array($al_codigosError))
	  //$t_errores:=$t_errores+"Error Nº "+String($al_codigosError{$i})+": "+$at_textoErrores{$i}+"\r\t"
	  //End for 
	  //SEND PACKET(vh_refLog;": "+$t_errores+"\r\n")
	  //If (Size of array($al_codigosError)>0)
	  //$0:=$al_codigosError{1}
	  //Else 
	  //$0:=-1  // error desconocido
	  //End if 
End if 
