//%attributes = {}
  //AsignaturaConfigBlob2Object
  // MONO: convierte los regisztros que están en Xshell fatObjects de la configuración de la asignatura al campo de objeto de Configuración de Asignaturas

C_LONGINT:C283($i;$vl_LastConfigPerLoaded;$i_periodo;$l_idTermometro)
ARRAY LONGINT:C221($al_IdAsig;0)
READ ONLY:C145([Asignaturas:18])

$l_idTermometro:=IT_Progress (1;0;0;"Creando Objeto de Configuración en Asignaturas ...")

ALL RECORDS:C47([Asignaturas:18])
SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_IdAsig)

For ($i;1;Size of array:C274($al_IdAsig))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_IdAsig))
	AS_CreateConfigObj ($al_IdAsig{$i};True:C214)  //Ticket 184577 
End for 

$l_idTermometro:=IT_Progress (-1;$l_idTermometro)

