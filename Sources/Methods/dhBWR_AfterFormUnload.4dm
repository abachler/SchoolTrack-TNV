//%attributes = {}
  //dhBWR_AfterFormUnload

  //xShell, Alberto Bachler
  //Metodo: dhBWR_AfteFormUnload
  //Por abachler
  //Creada el 20/04/2006, 15:32:21
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  //llamado desde: 
	  //utilizar para desviar el procesamiento estandar del evento en xShell
	  //En el Case of poner las instrucciones necesarias para procesar el evento para cada tabla en que se requiera
	  //Asignar True a $trapped si el evento es procesado
End if 

  //****DECLARACIONES****


  //****INICIALIZACIONES****


  //****CUERPO****
$redraw:=False:C215
Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
		$redraw:=True:C214  // inicializo redraw a true
		$alBWR_recordNumber:=lBWR_recordNumber  // conservo el record number del registro del que salí
		  //AL_UpdateArrays (xALP_Browser;0)
		BWR_LoadData   // cargo la selección
		  //AL_UpdateArrays (xALP_Browser;-2)
		lBWR_recordNumber:=$alBWR_recordNumber  //después de cargar nuevamente la selección en el explorador restauro el record number del registro del que salí
End case 

If ($redraw)  // redibujo menus, titulo de ventanas y otros objetos de interfaz, restauro el orden
	BWR_SetWindowTitle 
	BWR_SetMenuBar 
	BWR_SetInterfaceObjects 
	  //AL_UpdateArrays (xALP_Browser;-2)
	BWR_SetSort 
End if 


  //****LIMPIEZA****