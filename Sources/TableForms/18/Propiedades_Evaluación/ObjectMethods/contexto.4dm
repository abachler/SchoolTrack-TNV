AL_ExitCell (xALP_CsdList2)

  //DECLARATIONS
C_BOOLEAN:C305($cancelTrans)
C_LONGINT:C283($i;$r)

  //INITIALIZATION
$cancelTrans:=False:C215

  //MAIN CODE
If ((vb_CsdVariable=True:C214) & (r1=1))  //si existian configuraciones periódicas pregunta se inicializan las opciones
	  //$msg:="Si selecciona esta opción las atributos establecidos para cada período seran elim"+"inados.\r\r¿Desea continuar e inicializar todos los atributos a sus valores por def"+"ecto?"
	$r:=CD_Dlog (0;__ ("Si selecciona esta opción las atributos establecidos para cada período seran eliminados.\r\r¿Desea continuar e inicializar todos los atributos a sus valores por defecto?");__ ("");__ ("Inicializar todo");__ ("Cancelar"))
	
	If ($r=1)
		QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID)
		If (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
			$opcion:=1
		Else 
			  //$msg:="Hay sub-asignaturas asociadas a esta asignatura.\rPuede optar por eliminarlas de"+"finitivamente o conservarlas para usarlas posteriormente.\r\r¿Que desea usted hacer"+"?"
			$opcion:=CD_Dlog (0;__ ("Hay sub-asignaturas asociadas a esta asignatura.\rPuede optar por eliminarlas definitivamente o conservarlas para usarlas posteriormente.\r\r¿Que desea usted hacer?");__ ("");__ ("Conservar");__ ("Eliminar");__ ("Cancelar"))
		End if 
		Case of 
			: ($opcion=1)  //conservar subasignaturas
				$cancelTrans:=AScsd_DesconectaHijas_TODAS (lConsID;False:C215)
				If ($cancelTrans)  //si algún registro estaba bloqueado se cancela la transacción
					vb_CsdVariable:=True:C214
					POST KEY:C465(27;0)
				End if 
				
			: ($opcion=2)  //eliminar subasignaturas
				$cancelTrans:=AScsd_DesconectaHijas_TODAS (lConsID;True:C214)
				If ($cancelTrans)  //si algún registro estaba bloqueado se cancela la transacción
					vb_CsdVariable:=True:C214
					POST KEY:C465(27;0)
				End if 
				
			: ($opcion=3)
				$cancelTrans:=True:C214
				
		End case 
		
	Else 
		$cancelTrans:=True:C214
		r1:=0
		r2:=1
	End if 
End if 


If (Not:C34($cancelTrans))
	vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")
	$fatObjName:="Blob_ConfigNotas/"+String:C10(lConsID)+"/P@"  //se buscan y eliminan configuraciones períodicas
	READ WRITE:C146([XShell_FatObjects:86])
	QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$fatObjName)
	DELETE SELECTION:C66([XShell_FatObjects:86])
	
	
	  //se inicializan los parametros de configuración
	AScsd_InicializaPropiedades (lConsID)
	
	$l_RecordNumber:=Record number:C243([Asignaturas:18])
	AL_RemoveArrays (xALP_CsdList2;1;8)
	AS_PropEval_MenuAsignaturas 
	GOTO RECORD:C242([Asignaturas:18];$l_RecordNumber)
	xALSet_AS_PropiedadesEvaluacion 
	
	AL_SetColOpts (xALP_CsdList2;0;0;0;3)
	AL_SetWidths (xALP_CsdList2;5;1;225)
	AL_UpdateArrays (xALP_CsdList2;-2)
	OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)
	
	vb_CsdVariable:=False:C215
	OBJECT SET VISIBLE:C603(atSTR_Periodos_Nombre;False:C215)
	OBJECT SET VISIBLE:C603(sPeriodo;False:C215)
	
	  // Ticket 175179
	  //APPEND TO ARRAY(atSTR_EventLog;"Atributo \"Aplicar al año escolar completo\" activado")
End if 
  //END OF METHOD 





