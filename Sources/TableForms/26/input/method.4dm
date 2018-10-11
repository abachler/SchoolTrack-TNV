Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		BWR_SetInputButtonsAppearence 
		If (Is new record:C668([BU_Rutas:26]))
			  //DISABLE BUTTON(b_Add)
			_O_DISABLE BUTTON:C193(bDel)
			_O_DISABLE BUTTON:C193(bPrintItems)
			_O_DISABLE BUTTON:C193(b_Eliminar)
			  //DISABLE BUTTON(bAddInscripción)
			ARRAY TEXT:C222(atQuitar;0)
			[BU_Rutas:26]ID:12:=SQ_SeqNumber (->[BU_Rutas:26]ID:12)
			[BU_Rutas:26]Año:2:=<>gYear
			varMonitor:=""
			sMatBus:=""
			vl_NoBus:=0
			[BU_Rutas:26]Total_Recorridos:13:=0
		Else 
			ARRAY TEXT:C222(atQuitar;0)
			OBJECT SET ENTERABLE:C238(varNombre;False:C215)
			SET WINDOW TITLE:C213(__ ("Ruta : ")+[BU_Rutas:26]Nombre:9)
			If (sMatBus="")
				_O_DISABLE BUTTON:C193(bAddInscripción)
			End if 
			
		End if 
		LIST TO ARRAY:C288("STR_BUSector";<>atSTR_BUSector)
		
		$er:=Size of array:C274(alBU_IdRecorrido)
		If ($er>0)
			_O_ENABLE BUTTON:C192(bDel)
			_O_ENABLE BUTTON:C192(bPrintItems)
		Else 
			_O_DISABLE BUTTON:C193(bDel)
			_O_DISABLE BUTTON:C193(bPrintItems)
		End if 
		
		$err:=ALP_DefaultColSettings (xalp_Comunas;1;"atBU_GenNomCom";__ ("Para Seleccionar");102)
		
		  //general options
		ALP_SetDefaultAppareance (xalp_Comunas)
		AL_SetColOpts (xalp_Comunas;0;0;0;0;0)
		AL_SetRowOpts (xalp_Comunas;1;0;0;0;1;0)
		AL_SetCellOpts (xalp_Comunas;0;1;1)
		AL_SetMiscOpts (xalp_Comunas;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_Comunas;"";"")
		AL_SetScroll (xalp_Comunas;0;-3)
		AL_SetEntryOpts (xalp_Comunas;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_Comunas;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_Comunas;1;"";"";"")
		AL_SetDrgSrc (xalp_Comunas;2;"";"";"")
		AL_SetDrgSrc (xalp_Comunas;3;"";"";"")
		AL_SetDrgDst (xalp_Comunas;1;"";"";"")
		AL_SetDrgDst (xalp_Comunas;1;"";"";"")
		AL_SetDrgDst (xalp_Comunas;1;"";"";"")
		
		
		  //*********************** XALP_RECORRIDOS *************************************************
		
		$err:=ALP_DefaultColSettings (xalp_Recorridos;1;"atBU_RecNombre";__ ("Recorrido");120)
		$err:=ALP_DefaultColSettings (xalp_Recorridos;2;"atBU_Jornada";__ ("Jornada");60)
		$err:=ALP_DefaultColSettings (xalp_Recorridos;3;"alBu_Hora";__ ("Hora");60;"&/2")
		$err:=ALP_DefaultColSettings (xalp_Recorridos;4;"atBU_Dia";__ ("Día");60)
		$err:=ALP_DefaultColSettings (xalp_Recorridos;5;"abBU_ES";__ ("Sentido");60;__ ("Llegada")+";"+__ ("Salida"))
		$err:=ALP_DefaultColSettings (xalp_Recorridos;6;"alBU_IdRecorrido")
		$err:=ALP_DefaultColSettings (xalp_Recorridos;7;"alBU_Ruta")
		
		  //general options
		ALP_SetDefaultAppareance (xalp_Recorridos)
		AL_SetColOpts (xalp_Recorridos;1;1;1;2;0)
		AL_SetRowOpts (xalp_Recorridos;0;1;0;0;1;0)
		AL_SetCellOpts (xalp_Recorridos;0;1;1)
		AL_SetMiscOpts (xalp_Recorridos;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_Recorridos;"";"")
		AL_SetScroll (xalp_Recorridos;0;-3)
		AL_SetEntryOpts (xalp_Recorridos;1;1;0;0;1;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_Recorridos;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_Recorridos;1;"";"";"")
		AL_SetDrgSrc (xalp_Recorridos;2;"";"";"")
		AL_SetDrgSrc (xalp_Recorridos;3;"";"";"")
		AL_SetDrgDst (xalp_Recorridos;1;"";"";"")
		AL_SetDrgDst (xalp_Recorridos;1;"";"";"")
		AL_SetDrgDst (xalp_Recorridos;1;"";"";"")
		
		
		  //********************************* XALP_INSCRIPCIONES ********************************************
		
		$err:=ALP_DefaultColSettings (xalp_Inscripciones;1;"atBU_ALProf";__ ("Alumno/Funcionario");60)
		$err:=ALP_DefaultColSettings (xalp_Inscripciones;2;"atBU_Nombre";__ ("Nombre");160)
		$err:=ALP_DefaultColSettings (xalp_Inscripciones;3;"atBU_Curso";__ ("Curso");45)
		$err:=ALP_DefaultColSettings (xalp_Inscripciones;4;"atBU_NomRec";__ ("Recorrido");95)
		$err:=ALP_DefaultColSettings (xalp_Inscripciones;5;"alBU_IdRec")
		$err:=ALP_DefaultColSettings (xalp_Inscripciones;6;"alBU_IdAlumno")
		$err:=ALP_DefaultColSettings (xalp_Inscripciones;7;"alBU_IdProfesor")
		
		  //general options
		
		AL_SetColOpts (xalp_Inscripciones;1;1;1;3;0)
		AL_SetRowOpts (xalp_Inscripciones;0;0;0;0;1;0)
		AL_SetCellOpts (xalp_Inscripciones;0;1;1)
		AL_SetMiscOpts (xalp_Inscripciones;0;0;"\\";0;1)
		AL_SetMiscColor (xalp_Inscripciones;0;"White";0)
		AL_SetMiscColor (xalp_Inscripciones;1;"White";0)
		AL_SetMiscColor (xalp_Inscripciones;2;"White";0)
		AL_SetMiscColor (xalp_Inscripciones;3;"White";0)
		AL_SetMainCalls (xalp_Inscripciones;"";"")
		AL_SetScroll (xalp_Inscripciones;0;-2)
		AL_SetCopyOpts (xalp_Inscripciones;0;"\t";"\r";Char:C90(0))
		AL_SetSortOpts (xalp_Inscripciones;0;1;0;"Select the columns to sort:";0)
		AL_SetEntryOpts (xalp_Inscripciones;1;0;0;0;0;".")
		AL_SetHeight (xalp_Inscripciones;2;2;1;1;2)
		AL_SetDividers (xalp_Inscripciones;"No line";"Black";0;"No line";"Black";0)
		AL_SetDrgOpts (xalp_Inscripciones;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_Inscripciones;1;"";"";"")
		AL_SetDrgSrc (xalp_Inscripciones;2;"";"";"")
		AL_SetDrgSrc (xalp_Inscripciones;3;"";"";"")
		AL_SetDrgDst (xalp_Inscripciones;1;"";"";"")
		AL_SetDrgDst (xalp_Inscripciones;1;"";"";"")
		AL_SetDrgDst (xalp_Inscripciones;1;"";"";"")
		
		
		ALP_SetDefaultAppareance (xalp_Inscripciones)
		
		  //*******************************  XALP_LISTACOMUNAS *****************************************
		
		$err:=ALP_DefaultColSettings (xalp_ListaComunas;1;"atBU_NomCom";__ ("Seleccionadas");102)
		
		  //general options
		ALP_SetDefaultAppareance (xalp_ListaComunas)
		AL_SetColOpts (xalp_ListaComunas;0;0;0;0;0)
		AL_SetRowOpts (xalp_ListaComunas;1;0;0;0;1;0)
		AL_SetCellOpts (xalp_ListaComunas;0;1;1)
		AL_SetMiscOpts (xalp_ListaComunas;0;0;"\\";0;1)
		AL_SetMainCalls (xalp_ListaComunas;"";"")
		AL_SetScroll (xalp_ListaComunas;0;-3)
		AL_SetEntryOpts (xalp_ListaComunas;1;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xalp_ListaComunas;0;30;0)
		
		  //dragging options
		
		AL_SetDrgSrc (xalp_ListaComunas;1;"";"";"")
		AL_SetDrgSrc (xalp_ListaComunas;2;"";"";"")
		AL_SetDrgSrc (xalp_ListaComunas;3;"";"";"")
		AL_SetDrgDst (xalp_ListaComunas;1;"";"";"")
		AL_SetDrgDst (xalp_ListaComunas;1;"";"";"")
		AL_SetDrgDst (xalp_ListaComunas;1;"";"";"")
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		BU_SaveRutas 
		If (Size of array:C274(alBU_IdRuta)>0)
			_O_ENABLE BUTTON:C192(bDelRuta)
			_O_ENABLE BUTTON:C192(bConfig)
		Else 
			_O_DISABLE BUTTON:C193(bDelRuta)
			_O_DISABLE BUTTON:C193(bConfig)
		End if 
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 