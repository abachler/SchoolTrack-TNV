  // Método: Método de Formulario: [xxSTR_Constants]STR_ReplicaConfigAsignaturas
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 20/07/10, 14:58:31
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		LISTBOX SELECT ROW:C912(lb_Niveles;0;lk remove from selection:K53:3)
		LISTBOX SELECT ROW:C912(lb_Cursos;0;lk remove from selection:K53:3)
		LISTBOX SELECT ROW:C912(lb_Asignaturas;0;lk remove from selection:K53:3)
		LISTBOX SELECT ROW:C912(lb_CursosDestino;0;lk remove from selection:K53:3)
		cb_InicializarProfesores:=1
		cb_InscribirAlumnos:=1
		cb_RecalcularPromedios:=1
		_O_DISABLE BUTTON:C193(bReplicar)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4) | (Form event:C388=On Selection Change:K2:29))
		If ((vt_secciones#"") & (Find in array:C230(lb_Asignaturas;True:C214)>0))
			_O_ENABLE BUTTON:C192(bReplicar)
		Else 
			_O_DISABLE BUTTON:C193(bReplicar)
		End if 
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
