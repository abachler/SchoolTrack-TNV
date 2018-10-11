//%attributes = {}
  //dhBWR_OnDeleteSelection

  //xShell, Alberto Bachler
  //Metodo: dhBWR_OnDeleteSelection
  //Por abachler
  //Creada el 29/09/2003, 08:39:09
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  //llamado desde: BWR_OnDeleteSelection
	  //Utilizar para desviar el comportamiento por defecto de xShell
	  //en el Case Of instalar el código correspondiente a las acciones a ejecutar para cada tabla accesible en el explorador
	  //asignar TRUE a $trapped si se utiliza
End if 

  //****DECLARACIONES****
C_POINTER:C301($tablePointer;$1)

  //****INICIALIZACIONES****
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_CurrentTable
End if 

  //****CUERPO****
If (USR_checkRights ("D";$tablePointer))
	$Trapped:=False:C215  //No trap, deletion is handled by the main deletion rutine (BWR_OnDeleteRecord)
	Case of 
		: (Table:C252($tablePointer)=(Table:C252(->[Alumnos:2])))
			AL_DeleteSelection 
			$trapped:=True:C214
		: (Table:C252($tablePointer)=(Table:C252(->[BBL_Items:61])))
			BBLdc_DeleteSelection 
			$trapped:=True:C214
	End case 
Else 
	CD_Dlog (0;__ ("Usted no dispone de los derechos necesarios para eliminar registros en esta tabla."))
End if 
$0:=$trapped

  //****LIMPIEZA****


