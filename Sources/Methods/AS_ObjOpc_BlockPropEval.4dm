//%attributes = {}
  //AS_ObjOpc_BlockPropEval
  //MONO ticket 175179 01-08-2017 
  //Definir y actualizar el objeto de opciones de la asignatura en la edición de las propiedades de evaluación.
  //Existen al menos 3 formas (permiso M sobre la tabla de asignaturas, proceso autorizado, preferencia de profesores de la asignatura) 
  //para la edición de las propiedades de evaluación, al parecer ninguna de estas le sirve al ICIF ya que quieren uno especifico por asignatura.

C_POINTER:C301($1;$ptr_array)
ARRAY LONGINT:C221($al_recnumAsig;0)
C_BOOLEAN:C305($b_log;$b_opc;$b_opc_old;$b_save;$2;$3)
C_OBJECT:C1216($object)
C_LONGINT:C283($i;$l_idTermometro;$n)

$l_idTermometro:=IT_Progress (1;0;0;"Opciones Asignatura, Bloquear Edición de Propiedades de Evaluación:")
Case of 
	: (Count parameters:C259=0)
		READ ONLY:C145([Asignaturas:18])
		ALL RECORDS:C47([Asignaturas:18])
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recnumAsig;"")
		$ptr_array:=->$al_recnumAsig
		
	: (Count parameters:C259=1)
		$ptr_array:=$1
		
	: (Count parameters:C259=2)
		$ptr_array:=$1
		$b_opc:=$2
		
	: (Count parameters:C259=3)
		$ptr_array:=$1
		$b_opc:=$2
		$b_log:=$3
		
End case 

For ($i;1;Size of array:C274($ptr_array->))
	READ WRITE:C146([Asignaturas:18])
	GOTO RECORD:C242([Asignaturas:18];$ptr_array->{$i})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($ptr_array->);"Opciones Asignatura, Bloquear Edición de Propiedades de Evaluación: \n"+[Asignaturas:18]denominacion_interna:16+" "+[Asignaturas:18]Curso:5)
	
	If (OB Is defined:C1231([Asignaturas:18]Opciones:57))
		$object:=[Asignaturas:18]Opciones:57
	Else 
		$object:=OB_Create 
	End if 
	
	$b_save:=True:C214
	If (OB Get type:C1230($object;"BloqueoPropDeEval")#Is undefined:K8:13)
		OB_GET ($object;->$b_opc_old;"BloqueoPropDeEval")
		$b_save:=($b_opc#$b_opc_old)
	End if 
	
	If ($b_save)
		OB_SET ($object;->$b_opc;"BloqueoPropDeEval")
		[Asignaturas:18]Opciones:57:=$object
		SAVE RECORD:C53([Asignaturas:18])
		
		If (($b_log) & (OK=1))
			LOG_RegisterEvt ("Asignatura :"+[Asignaturas:18]denominacion_interna:16+" "+[Asignaturas:18]Curso:5+", bloqueo de propiedades de evaluación cambia a: "+String:C10($b_opc))
		End if 
		
	End if 
	KRL_UnloadReadOnly (->[Asignaturas:18])
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
