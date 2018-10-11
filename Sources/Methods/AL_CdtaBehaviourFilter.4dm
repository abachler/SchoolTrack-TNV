//%attributes = {}
  //AL_CdtaBehaviourFilter

C_TEXT:C284($1;$accion)
C_REAL:C285(subListaCategorias;subListaMotivos;subListaProfesores;al_FiltroCdta;subListaTipoLic)
C_LONGINT:C283($i)
$accion:=$1
Case of 
	: ($accion="initListCdta")
		ARRAY LONGINT:C221(al_idsProfesores;0)
		ARRAY TEXT:C222(at_nomProfesores;0)
		If (Is a list:C621(al_FiltroCdta))
			CLEAR LIST:C377(al_FiltroCdta)
			al_FiltroCdta:=0
		End if 
		If (Is a list:C621(subListaCategorias))
			CLEAR LIST:C377(subListaCategorias)
			subListaCategorias:=0
		End if 
		If (Is a list:C621(subListaMotivos))
			CLEAR LIST:C377(subListaMotivos)
			subListaMotivos:=0
		End if 
		If (Is a list:C621(subListaProfesores))
			CLEAR LIST:C377(subListaProfesores)
			subListaProfesores:=0
		End if 
		If (Is a list:C621(subListaTipoLic))
			CLEAR LIST:C377(subListaTipoLic)
			subListaTipoLic:=0
		End if 
	: ($accion="createListAnt")
		AL_CdtaBehaviourFilter ("initListCdta")
		ARRAY LONGINT:C221(al_idsProfesores;0)
		ARRAY TEXT:C222(at_nomProfesores;0)
		
		ARRAY TEXT:C222($atSTRal_CategoriaAnotacion;0)
		ARRAY TEXT:C222($atSTRal_MotivoAnotacion;0)
		ARRAY TEXT:C222($atSTRal_NombreProfesorAnot;0)
		
		COPY ARRAY:C226(atSTRal_CategoriaAnotacion;$atSTRal_CategoriaAnotacion)
		COPY ARRAY:C226(atSTRal_MotivoAnotacion;$atSTRal_MotivoAnotacion)
		COPY ARRAY:C226(atSTRal_NombreProfesorAnot;$atSTRal_NombreProfesorAnot)
		
		COPY ARRAY:C226(alSTRal_NoProfesorAnot;al_idsProfesores)
		COPY ARRAY:C226(atSTRal_NombreProfesorAnot;at_nomProfesores)
		
		AT_DistinctsArrayValues (->$atSTRal_CategoriaAnotacion)
		AT_DistinctsArrayValues (->$atSTRal_MotivoAnotacion)
		AT_DistinctsArrayValues (->$atSTRal_NombreProfesorAnot)
		subListaCategorias:=New list:C375
		For ($i;1;Size of array:C274($atSTRal_CategoriaAnotacion))
			If ($atSTRal_CategoriaAnotacion{$i}#"")
				APPEND TO LIST:C376(subListaCategorias;$atSTRal_CategoriaAnotacion{$i};10000+$i)
			End if 
		End for 
		subListaMotivos:=New list:C375
		For ($i;1;Size of array:C274($atSTRal_MotivoAnotacion))
			If ($atSTRal_MotivoAnotacion{$i}#"")
				APPEND TO LIST:C376(subListaMotivos;$atSTRal_MotivoAnotacion{$i};20000+$i)
			End if 
		End for 
		subListaProfesores:=New list:C375
		For ($i;1;Size of array:C274($atSTRal_NombreProfesorAnot))
			If ($atSTRal_NombreProfesorAnot{$i}#"")
				APPEND TO LIST:C376(subListaProfesores;$atSTRal_NombreProfesorAnot{$i};30000+$i)
			End if 
		End for 
		al_FiltroCdta:=New list:C375
		APPEND TO LIST:C376(al_FiltroCdta;"Todas";1)
		APPEND TO LIST:C376(al_FiltroCdta;"Categorías";10000;subListaCategorias;True:C214)
		APPEND TO LIST:C376(al_FiltroCdta;"Motivos";20000;subListaMotivos;True:C214)
		APPEND TO LIST:C376(al_FiltroCdta;"Profesores";30000;subListaProfesores;True:C214)
		SELECT LIST ITEMS BY POSITION:C381(al_FiltroCdta;1)
		AL_CdtaBehaviourFilter ("copyArraysAnt")
	: ($accion="copyArraysAnt")
		AL_CdtaBehaviourFilter ("initArrays")
		COPY ARRAY:C226(<>aCdtaRecNo;alSTRal_RecNumItemAnotacionT)
		COPY ARRAY:C226(adSTRal_FechaAnotacion;adSTRal_FechaAnotacionT)
		COPY ARRAY:C226(atSTRal_MotivoAnotacion;atSTRal_MotivoAnotacionT)
		COPY ARRAY:C226(atSTRal_NotasAnotacion;atSTRal_NotasAnotacionT)
		COPY ARRAY:C226(atSTRal_NombreProfesorAnot;atSTRal_NombreProfesorAnotT)
		COPY ARRAY:C226(alSTRal_NoProfesorAnot;alSTRal_NoProfesorAnotT)
		COPY ARRAY:C226(atSTRal_CategoriaAnotacion;atSTRal_CategoriaAnotacionT)
		COPY ARRAY:C226(alSTRal_PuntosAnotacion;alSTRal_PuntosAnotacionT)
		COPY ARRAY:C226(atSTRal_TipoAnotacion;atSTRal_TipoAnotacionT)
	: ($accion="returnArraysAnt")
		COPY ARRAY:C226(alSTRal_RecNumItemAnotacionT;<>aCdtaRecNo)
		COPY ARRAY:C226(adSTRal_FechaAnotacionT;adSTRal_FechaAnotacion)
		COPY ARRAY:C226(atSTRal_MotivoAnotacionT;atSTRal_MotivoAnotacion)
		COPY ARRAY:C226(atSTRal_NotasAnotacionT;atSTRal_NotasAnotacion)
		COPY ARRAY:C226(atSTRal_NombreProfesorAnotT;atSTRal_NombreProfesorAnot)
		COPY ARRAY:C226(alSTRal_NoProfesorAnotT;alSTRal_NoProfesorAnot)
		COPY ARRAY:C226(atSTRal_CategoriaAnotacionT;atSTRal_CategoriaAnotacion)
		COPY ARRAY:C226(alSTRal_PuntosAnotacionT;alSTRal_PuntosAnotacion)
		COPY ARRAY:C226(atSTRal_TipoAnotacionT;atSTRal_TipoAnotacion)
	: ($accion="processListAnt")
		AL_UpdateArrays (xALP_ConductaAlumnos;0)
		C_TEXT:C284($yearName;$itemText)
		C_LONGINT:C283($itemRef;$year)
		$itemRef:=$2
		$itemText:=$3
		If ($itemRef>0)
			AL_CdtaBehaviourFilter ("returnArraysAnt")
			Case of 
				: ($itemRef>30000)
					$el:=Find in array:C230(at_nomProfesores;$itemText)
					If ($el#-1)
						alSTRal_NoProfesorAnot{0}:=al_idsProfesores{$el}
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->alSTRal_NoProfesorAnot;"#";->$DA_Return)
						For ($i;Size of array:C274($DA_Return);1;-1)
							AT_Delete ($DA_Return{$i};1;-><>aCdtaRecNo;->adSTRal_FechaAnotacion;->atSTRal_MotivoAnotacion;->atSTRal_NotasAnotacion;->atSTRal_NombreProfesorAnot;->atSTRal_CategoriaAnotacion;->alSTRal_PuntosAnotacion;->atSTRal_TipoAnotacion;->alSTRal_NoProfesorAnot)
						End for 
					End if 
				: ($itemRef>20000)
					atSTRal_MotivoAnotacion{0}:=$itemText
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->atSTRal_MotivoAnotacion;"#";->$DA_Return)
					For ($i;Size of array:C274($DA_Return);1;-1)
						AT_Delete ($DA_Return{$i};1;-><>aCdtaRecNo;->adSTRal_FechaAnotacion;->atSTRal_MotivoAnotacion;->atSTRal_NotasAnotacion;->atSTRal_NombreProfesorAnot;->atSTRal_CategoriaAnotacion;->alSTRal_PuntosAnotacion;->atSTRal_TipoAnotacion;->alSTRal_NoProfesorAnot)
					End for 
				: ($itemRef>10000)
					atSTRal_CategoriaAnotacion{0}:=$itemText
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->atSTRal_CategoriaAnotacion;"#";->$DA_Return)
					For ($i;Size of array:C274($DA_Return);1;-1)
						AT_Delete ($DA_Return{$i};1;-><>aCdtaRecNo;->adSTRal_FechaAnotacion;->atSTRal_MotivoAnotacion;->atSTRal_NotasAnotacion;->atSTRal_NombreProfesorAnot;->atSTRal_CategoriaAnotacion;->alSTRal_PuntosAnotacion;->atSTRal_TipoAnotacion;->alSTRal_NoProfesorAnot)
					End for 
			End case 
		End if 
		xALSet_AL_Anotaciones 
	: ($accion="createListDtn")
		AL_CdtaBehaviourFilter ("initListCdta")
		ARRAY LONGINT:C221(al_idsProfesores;0)
		ARRAY TEXT:C222(at_nomProfesores;0)
		
		ARRAY TEXT:C222($atSTRal_MotivoDtn;0)
		ARRAY TEXT:C222($atSTRal_nomProfesor;0)
		
		COPY ARRAY:C226(<>aCdtaText1;$atSTRal_MotivoDtn)
		COPY ARRAY:C226(<>aCdtaText3;$atSTRal_nomProfesor)
		
		COPY ARRAY:C226(<>aCdtaLong1;al_idsProfesores)
		COPY ARRAY:C226(<>aCdtaText3;at_nomProfesores)
		AT_DistinctsArrayValues (->$atSTRal_MotivoDtn)
		AT_DistinctsArrayValues (->$atSTRal_nomProfesor)
		
		subListaMotivos:=New list:C375
		For ($i;1;Size of array:C274($atSTRal_MotivoDtn))
			If ($atSTRal_MotivoDtn{$i}#"")
				APPEND TO LIST:C376(subListaMotivos;$atSTRal_MotivoDtn{$i};10000+$i)
			End if 
		End for 
		subListaProfesores:=New list:C375
		For ($i;1;Size of array:C274($atSTRal_nomProfesor))
			If ($atSTRal_nomProfesor{$i}#"")
				APPEND TO LIST:C376(subListaProfesores;$atSTRal_nomProfesor{$i};20000+$i)
			End if 
		End for 
		al_FiltroCdta:=New list:C375
		APPEND TO LIST:C376(al_FiltroCdta;"Todos";1)
		APPEND TO LIST:C376(al_FiltroCdta;"Motivos";10000;subListaMotivos;True:C214)
		APPEND TO LIST:C376(al_FiltroCdta;"Profesores";20000;subListaProfesores;True:C214)
		SELECT LIST ITEMS BY POSITION:C381(al_FiltroCdta;1)
		AL_CdtaBehaviourFilter ("copyArraysDtn")
	: ($accion="copyArraysDtn")
		AL_CdtaBehaviourFilter ("initArrays")
		COPY ARRAY:C226(<>aCdtaRecNo;al_recNumDtn)
		COPY ARRAY:C226(<>aCdtaDate;ad_fechasDtn)
		COPY ARRAY:C226(<>aCdtaText1;at_motivosDtn)
		COPY ARRAY:C226(<>aCdtaText2;at_observacionesDtn)
		COPY ARRAY:C226(<>aCdtaText3;at_nomProfDtn)
		COPY ARRAY:C226(<>aCdtaNum1;al_horasDtn)
		COPY ARRAY:C226(<>aCdtaBool;ab_cumplidoDtn)
		COPY ARRAY:C226(<>aCdtaLong1;al_idsProfDtn)
	: ($accion="returnArraysDtn")
		COPY ARRAY:C226(al_recNumDtn;<>aCdtaRecNo)
		COPY ARRAY:C226(ad_fechasDtn;<>aCdtaDate)
		COPY ARRAY:C226(at_motivosDtn;<>aCdtaText1)
		COPY ARRAY:C226(at_observacionesDtn;<>aCdtaText2)
		COPY ARRAY:C226(at_nomProfDtn;<>aCdtaText3)
		COPY ARRAY:C226(al_horasDtn;<>aCdtaNum1)
		COPY ARRAY:C226(ab_cumplidoDtn;<>aCdtaBool)
		COPY ARRAY:C226(al_idsProfDtn;<>aCdtaLong1)
	: ($accion="processListDtn")
		AL_UpdateArrays (xALP_ConductaAlumnos;0)
		C_TEXT:C284($yearName;$itemText)
		C_LONGINT:C283($itemRef;$year)
		$itemRef:=$2
		$itemText:=$3
		If ($itemRef>0)
			AL_CdtaBehaviourFilter ("returnArraysDtn")
			Case of 
				: ($itemRef>20000)
					$el:=Find in array:C230(at_nomProfesores;$itemText)
					If ($el#-1)
						<>aCdtaLong1{0}:=al_idsProfesores{$el}
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (-><>aCdtaLong1;"#";->$DA_Return)
						For ($i;Size of array:C274($DA_Return);1;-1)
							AT_Delete ($DA_Return{$i};1;-><>aCdtaRecNo;-><>aCdtaDate;-><>aCdtaText1;-><>aCdtaText2;-><>aCdtaText3;-><>aCdtaNum1;-><>aCdtaBool;-><>aCdtaLong1)
						End for 
					End if 
				: ($itemRef>10000)
					<>aCdtaText1{0}:=$itemText
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (-><>aCdtaText1;"#";->$DA_Return)
					For ($i;Size of array:C274($DA_Return);1;-1)
						AT_Delete ($DA_Return{$i};1;-><>aCdtaRecNo;-><>aCdtaDate;-><>aCdtaText1;-><>aCdtaText2;-><>aCdtaText3;-><>aCdtaNum1;-><>aCdtaBool;-><>aCdtaLong1)
					End for 
			End case 
		End if 
		xALSet_AL_Castigos 
	: ($accion="createListSpn")
		AL_CdtaBehaviourFilter ("initListCdta")
		ARRAY LONGINT:C221(al_idsProfesores;0)
		ARRAY TEXT:C222(at_nomProfesores;0)
		
		ARRAY TEXT:C222($atSTRal_MotivoSpn;0)
		ARRAY TEXT:C222($atSTRal_nomProfesor;0)
		
		COPY ARRAY:C226(<>aCdtaText1;$atSTRal_MotivoSpn)
		COPY ARRAY:C226(<>aCdtaText3;$atSTRal_nomProfesor)
		
		COPY ARRAY:C226(<>aCdtaLong1;al_idsProfesores)
		COPY ARRAY:C226(<>aCdtaText3;at_nomProfesores)
		AT_DistinctsArrayValues (->$atSTRal_MotivoSpn)
		AT_DistinctsArrayValues (->$atSTRal_nomProfesor)
		
		subListaMotivos:=New list:C375
		For ($i;1;Size of array:C274($atSTRal_MotivoSpn))
			If ($atSTRal_MotivoSpn{$i}#"")
				APPEND TO LIST:C376(subListaMotivos;$atSTRal_MotivoSpn{$i};10000+$i)
			End if 
		End for 
		subListaProfesores:=New list:C375
		For ($i;1;Size of array:C274($atSTRal_nomProfesor))
			If ($atSTRal_nomProfesor{$i}#"")
				APPEND TO LIST:C376(subListaProfesores;$atSTRal_nomProfesor{$i};20000+$i)
			End if 
		End for 
		al_FiltroCdta:=New list:C375
		APPEND TO LIST:C376(al_FiltroCdta;"Todas";1)
		APPEND TO LIST:C376(al_FiltroCdta;"Motivos";10000;subListaMotivos;True:C214)
		APPEND TO LIST:C376(al_FiltroCdta;"Profesores";20000;subListaProfesores;True:C214)
		SELECT LIST ITEMS BY POSITION:C381(al_FiltroCdta;1)
		AL_CdtaBehaviourFilter ("copyArraysSpn")
	: ($accion="copyArraysSpn")
		AL_CdtaBehaviourFilter ("initArrays")
		COPY ARRAY:C226(<>aCdtaRecNo;al_recNumSpn)
		COPY ARRAY:C226(<>aCdtaDate;ad_desdeSpn)
		COPY ARRAY:C226(<>aCdtaDate2;ad_hastaSpn)
		COPY ARRAY:C226(<>aCdtaText1;at_motivosSpn)
		COPY ARRAY:C226(<>aCdtaText2;at_observacionesSpn)
		COPY ARRAY:C226(<>aCdtaText3;at_nomProfSpn)
		COPY ARRAY:C226(<>aCdtaLong1;al_idsProfSpn)
	: ($accion="returnArraysSpn")
		COPY ARRAY:C226(al_recNumSpn;<>aCdtaRecNo)
		COPY ARRAY:C226(ad_desdeSpn;<>aCdtaDate)
		COPY ARRAY:C226(ad_hastaSpn;<>aCdtaDate2)
		COPY ARRAY:C226(at_motivosSpn;<>aCdtaText1)
		COPY ARRAY:C226(at_observacionesSpn;<>aCdtaText2)
		COPY ARRAY:C226(at_nomProfSpn;<>aCdtaText3)
		COPY ARRAY:C226(al_idsProfSpn;<>aCdtaLong1)
	: ($accion="processListSpn")
		AL_UpdateArrays (xALP_ConductaAlumnos;0)
		C_TEXT:C284($yearName;$itemText)
		C_LONGINT:C283($itemRef;$year)
		$itemRef:=$2
		$itemText:=$3
		If ($itemRef>0)
			AL_CdtaBehaviourFilter ("returnArraysSpn")
			Case of 
				: ($itemRef>20000)
					$el:=Find in array:C230(at_nomProfesores;$itemText)
					If ($el#-1)
						<>aCdtaLong1{0}:=al_idsProfesores{$el}
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (-><>aCdtaLong1;"#";->$DA_Return)
						For ($i;Size of array:C274($DA_Return);1;-1)
							AT_Delete ($DA_Return{$i};1;-><>aCdtaRecNo;-><>aCdtaDate;-><>aCdtaDate2;-><>aCdtaText1;-><>aCdtaText2;-><>aCdtaText3;-><>aCdtaLong1)
						End for 
					End if 
				: ($itemRef>10000)
					<>aCdtaText1{0}:=$itemText
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (-><>aCdtaText1;"#";->$DA_Return)
					For ($i;Size of array:C274($DA_Return);1;-1)
						AT_Delete ($DA_Return{$i};1;-><>aCdtaRecNo;-><>aCdtaDate;-><>aCdtaDate2;-><>aCdtaText1;-><>aCdtaText2;-><>aCdtaText3;-><>aCdtaLong1)
					End for 
			End case 
		End if 
		xALSet_AL_Suspensiones 
	: ($accion="createListLic")
		AL_CdtaBehaviourFilter ("initListCdta")
		ARRAY TEXT:C222($atSTRal_TipoLicencia;0)
		COPY ARRAY:C226(<>aCdtaText1;$atSTRal_TipoLicencia)
		AT_DistinctsArrayValues (->$atSTRal_TipoLicencia)
		subListaTipoLic:=New list:C375
		For ($i;1;Size of array:C274($atSTRal_TipoLicencia))
			If ($atSTRal_TipoLicencia{$i}#"")
				APPEND TO LIST:C376(subListaTipoLic;$atSTRal_TipoLicencia{$i};10000+$i)
			End if 
		End for 
		al_FiltroCdta:=New list:C375
		APPEND TO LIST:C376(al_FiltroCdta;"Todas";1)
		APPEND TO LIST:C376(al_FiltroCdta;"Tipos de Licencia";10000;subListaTipoLic;True:C214)
		SELECT LIST ITEMS BY POSITION:C381(al_FiltroCdta;1)
		AL_CdtaBehaviourFilter ("copyArraysLic")
	: ($accion="copyArraysLic")
		AL_CdtaBehaviourFilter ("initArrays")
		COPY ARRAY:C226(<>aCdtaRecNo;al_recNumLic)
		COPY ARRAY:C226(<>aCdtaDate;ad_desdeLic)
		COPY ARRAY:C226(<>aCdtaDate2;ad_hastaLic)
		COPY ARRAY:C226(<>aCdtaText1;at_tipoLic)
		COPY ARRAY:C226(<>aCdtaText2;at_observacionesLic)
	: ($accion="returnArraysLic")
		COPY ARRAY:C226(al_recNumLic;<>aCdtaRecNo)
		COPY ARRAY:C226(ad_desdeLic;<>aCdtaDate)
		COPY ARRAY:C226(ad_hastaLic;<>aCdtaDate2)
		COPY ARRAY:C226(at_tipoLic;<>aCdtaText1)
		COPY ARRAY:C226(at_observacionesLic;<>aCdtaText2)
	: ($accion="processListLic")
		AL_UpdateArrays (xALP_ConductaAlumnos;0)
		C_TEXT:C284($yearName;$itemText)
		C_LONGINT:C283($itemRef;$year)
		$itemRef:=$2
		$itemText:=$3
		If ($itemRef>0)
			AL_CdtaBehaviourFilter ("returnArraysLic")
			Case of 
				: ($itemRef>10000)
					<>aCdtaText1{0}:=$itemText
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (-><>aCdtaText1;"#";->$DA_Return)
					For ($i;Size of array:C274($DA_Return);1;-1)
						AT_Delete ($DA_Return{$i};1;-><>aCdtaRecNo;-><>aCdtaDate;-><>aCdtaDate2;-><>aCdtaText1;-><>aCdtaText2)
					End for 
			End case 
		End if 
		xALSet_AL_Licencias 
	: ($accion="createListAbs")
		AL_CdtaBehaviourFilter ("initListCdta")
		al_FiltroCdta:=New list:C375
		APPEND TO LIST:C376(al_FiltroCdta;"Todas";1)
		SELECT LIST ITEMS BY POSITION:C381(al_FiltroCdta;1)
	: ($accion="createListSessAte")
		AL_CdtaBehaviourFilter ("initListCdta")
		al_FiltroCdta:=New list:C375
		APPEND TO LIST:C376(al_FiltroCdta;"Todas";1)
		SELECT LIST ITEMS BY POSITION:C381(al_FiltroCdta;1)
	: ($accion="createListLte")
		AL_CdtaBehaviourFilter ("initListCdta")
		al_FiltroCdta:=New list:C375
		APPEND TO LIST:C376(al_FiltroCdta;"Todos";1)
		SELECT LIST ITEMS BY POSITION:C381(al_FiltroCdta;1)
	: ($accion="initArrays")
		  //ant
		ARRAY LONGINT:C221(alSTRal_RecNumItemAnotacionT;0)
		ARRAY DATE:C224(adSTRal_FechaAnotacionT;0)
		ARRAY TEXT:C222(atSTRal_MotivoAnotacionT;0)
		ARRAY TEXT:C222(atSTRal_NotasAnotacionT;0)
		ARRAY TEXT:C222(atSTRal_NombreProfesorAnotT;0)
		ARRAY LONGINT:C221(alSTRal_NoProfesorAnotT;0)
		ARRAY TEXT:C222(atSTRal_CategoriaAnotacionT;0)
		ARRAY INTEGER:C220(alSTRal_PuntosAnotacionT;0)
		ARRAY TEXT:C222(atSTRal_TipoAnotacionT;0)
		  //´dtn
		ARRAY LONGINT:C221(al_recNumDtn;0)
		ARRAY DATE:C224(ad_fechasDtn;0)
		ARRAY TEXT:C222(at_motivosDtn;0)
		ARRAY TEXT:C222(at_observacionesDtn;0)
		ARRAY TEXT:C222(at_nomProfDtn;0)
		ARRAY INTEGER:C220(al_horasDtn;0)
		ARRAY BOOLEAN:C223(ab_cumplidoDtn;0)
		ARRAY LONGINT:C221(al_idsProfDtn;0)
		  //spn
		ARRAY LONGINT:C221(al_recNumSpn;0)
		ARRAY DATE:C224(ad_desdeSpn;0)
		ARRAY DATE:C224(ad_hastaSpn;0)
		ARRAY TEXT:C222(at_motivosSpn;0)
		ARRAY TEXT:C222(at_observacionesSpn;0)
		ARRAY TEXT:C222(at_nomProfSpn;0)
		ARRAY LONGINT:C221(al_idsProfSpn;0)
		  //lic
		ARRAY LONGINT:C221(al_recNumLic;0)
		ARRAY DATE:C224(ad_desdeLic;0)
		ARRAY DATE:C224(ad_hastaLic;0)
		ARRAY TEXT:C222(at_tipoLic;0)
		ARRAY TEXT:C222(at_observacionesLic;0)
	: ($accion="mostrarFiltro")
		$mostrar:=False:C215
		$listas:=0
		If (Is a list:C621(subListaCategorias))
			If ((Count list items:C380(subListaCategorias)>0))
				$listas:=$listas+1
			End if 
		End if 
		If (Is a list:C621(subListaMotivos))
			If ((Count list items:C380(subListaMotivos)>0))
				$listas:=$listas+1
			End if 
		End if 
		If (Is a list:C621(subListaProfesores))
			If ((Count list items:C380(subListaProfesores)>0))
				$listas:=$listas+1
			End if 
		End if 
		If (Is a list:C621(subListaTipoLic))
			If ((Count list items:C380(subListaTipoLic)>0))
				$listas:=$listas+1
			End if 
		End if 
		If ($listas>0)
			$mostrar:=True:C214
		Else 
			$mostrar:=False:C215
		End if 
		$0:=$mostrar
End case 
If ($accion="create@")
	_O_REDRAW LIST:C382(al_FiltroCdta)
End if 