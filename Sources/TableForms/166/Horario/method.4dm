Case of 
	: (Form event:C388=On Load:K2:1)
		DISABLE MENU ITEM:C150(1;0)
		ENABLE MENU ITEM:C149(1;4)
		DISABLE MENU ITEM:C150(3;0)
		DISABLE MENU ITEM:C150(4;0)
		DISABLE MENU ITEM:C150(5;0)
		DISABLE MENU ITEM:C150(6;0)
		
		C_BOOLEAN:C305(b_soloBloquesVigentes)  //MONO TICKET 216065
		b_soloBloquesVigentes:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"HORARIOsoloBloquesVigentes";String:C10(Num:C11(b_soloBloquesVigentes))))=1  //MONO TICKET 216065
		OBJECT SET VISIBLE:C603(*;"txt_bloquesvigentes";b_soloBloquesVigentes)  //MONO TICKET 216065
		
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  //20180329 RCH
		
		DISTINCT VALUES:C339([Cursos:3]Nivel_Numero:7;$al_niveles)
		SORT ARRAY:C229($al_niveles;>)
		
		For ($l_indice;Size of array:C274($al_niveles);1;-1)
			$b_nivelHabilitado:=Periodo_VerificaConfiguracion ("VerificaConfiguracionPeriodos";$al_niveles{$l_indice})
			If (Not:C34($b_nivelHabilitado))
				DELETE FROM ARRAY:C228($al_niveles;$l_indice)
			End if 
		End for 
		
		QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;$al_niveles)
		QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)  //ABC /20180313//201139 
		ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;at_CursosEnHorario)
		
		LOAD RECORD:C52([Cursos:3])
		PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
		vs_SelectedClass:=[Cursos:3]Curso:1
		$el:=Find in array:C230(at_CursosEnHorario;vs_SelectedClass)
		If ($el>0)
			LISTBOX SELECT ROW:C912(*;"lbCursos";$el)
		Else 
			LISTBOX SELECT ROW:C912(*;"lbCursos";0;lk remove from selection:K53:3)
		End if 
		
		Case of 
			: (vlSTR_Horario_NoCiclos=1)
				OBJECT SET VISIBLE:C603(*;"ciclo@";False:C215)
				vlSTR_Horario_CicloNumero:=1
				SET TIMER:C645(0)
				
			: (vlSTR_Horario_NoCiclos=2)
				ARRAY TEXT:C222(atSTR_NombresCiclos;vlSTR_Horario_NoCiclos)
				atSTR_NombresCiclos{1}:="A"
				atSTR_NombresCiclos{2}:="B"
				atSTR_NombresCiclos:=1
				vlSTR_Horario_CicloNumero:=1
				OBJECT SET VISIBLE:C603(*;"ciclo@";True:C214)
				
			Else 
				CD_Dlog (0;__ ("No se ha definido el tipo de horario a utilizar\rEl horario no puede ser configurado ahora."))
				CANCEL:C270
		End case 
		TMT_CargaSalas 
		TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
		
	: (Form event:C388=On Resize:K2:27)
		OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
		  //TMT_FijaAparienciaCeldas 
		  // posteo un click sobre el botón que llama a TMT_FijaAparienciaCeldas ya queen algunos casos el redibujo no se hace correctamente con un llamado directo
		POST KEY:C465(Character code:C91("*");Command key mask:K16:1)
		
	: (Form event:C388=On Activate:K2:9)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Scroll:K2:57)
		
End case 
