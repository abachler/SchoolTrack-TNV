//%attributes = {}
  // AS_MenuContextualNotas()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 10/10/12, 13:01:39
  // ---------------------------------------------
C_BLOB:C604($x_RecNumsArray)
C_BOOLEAN:C305($b_calificacionesEditables;$b_columnaIngresable;$b_columnaSinDatos;$b_edicionPropiedadesPermitida;$b_GuardarRegistro;$b_PromediosEditables;$b_recalcular;$b_usuarioSinRestriccion)
_O_C_INTEGER:C282($i_alumnos)
C_LONGINT:C283($l_columna;$l_error;$l_recNumAsignatura;$l_recNumCalificaciones)
C_POINTER:C301($y_arregloLiterales;$y_arregloReales;$y_campoCalificaciones_literal;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_real;$y_campoCalificaciones_simbolo)
C_REAL:C285($r_valorEditadoReal)
C_TEXT:C284($t_arregloLiterales;$t_itemsPopupMenu)

ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
ARRAY LONGINT:C221($l_itemSeleccionado;0)
ARRAY LONGINT:C221($al_filasSeleccionadas;0)
ARRAY REAL:C219($ar_copiaReales;0)
ARRAY TEXT:C222($at_arrayNames;0)
_O_ARRAY STRING:C218(5;$as_copiaLiterales;0)




  // CÓDIGO
$l_error:=AL_GetArrayNames (xALP_ASNotas;$at_arrayNames)
$l_error:=AL_GetSelect (xALP_ASNotas;$al_filasSeleccionadas)
$l_columna:=AL_GetColumn (xALP_ASNotas)
$t_arregloLiterales:=$at_arrayNames{$l_columna}
$y_arregloLiterales:=Get pointer:C304($t_arregloLiterales)

$t_itemsPopupMenu:=__ ("Copiar planilla al portapapeles;Copiar selección al portapapeles...;(-;Cortar columna;Copiar columna;Pegar columna;Borrar columna;(-;Orden ascendente;Orden descendente;(-;(Propiedades de la columna…")
$b_recalcular:=False:C215

  // obtengo punteros sobre los campos en los que almacenarán las calificaciones
$y_campoCalificaciones_real:=ASev2_punteroReal ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
$y_campoCalificaciones_nota:=ASev2_punteroNota ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
$y_campoCalificaciones_puntos:=ASev2_punteroPuntos ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
$y_campoCalificaciones_simbolo:=ASev2_punteroSimbolo ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
$y_campoCalificaciones_literal:=ASev2_punteroLiteral ($at_ArrayNames{$l_columna};aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})



  // construyo el popupmenu según los privilegios del usuario y el contexto:
  // - los items Copiar Planilla y Copiar selección se inactivan si no hay datos
  // - los items Cortar y Borrar se inactivan si el usuario no tiene derechos de edición o si el click derecho fue
  //   sobre las columnas Nº, Alumno o Curso
  // - el item Pegar está activo sólo si el usuario tiene derechos de edición.
  //   si no está autorizado a modificar notas ya registradas solo se habilita si la columna no tiene ninguna nota
  // - Los items de ordenamiento se habilitan solo si hay datos
  // - El item que permite establecer propiedades de evaluación de la columna se habilita solo si el usuario
  //   tiene derecho de edición de las propiedades de la asignatura
$b_usuarioSinRestriccion:=(USR_checkRights ("M";->[Alumnos_Calificaciones:208]))
$b_calificacionesEditables:=vb_calificacionesEditables & (<>viSTR_NoModificarNotas=0)
$b_PromediosEditables:=AS_PromediosSonEditables ([Asignaturas:18]Numero:1)

  //20130614 ASM para cuando no se selecciona columnas en las evaluaciones
If ($l_columna>0)
	$b_columnaSinDatos:=Not:C34(AT_ArrayHasNonNulValues ($y_arregloLiterales))
Else 
	$b_columnaSinDatos:=True:C214
	$b_calificacionesEditables:=False:C215
	vb_calificacionesEditables:=False:C215
End if 

$b_edicionPropiedadesPermitida:=(USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ([Asignaturas:18]profesor_numero:4=<>lUSR_RelatedTableUserID)
ARRAY TEXT:C222($at_itemsMenu;12)
$at_itemsMenu{1}:="("*Num:C11(Size of array:C274(aNtaOrden)=0)+__ ("Copiar planilla al portapapeles")
$at_itemsMenu{2}:="("*Num:C11(Size of array:C274($al_filasSeleccionadas)=0)+__ ("Copiar selección al portapapeles...")
$at_itemsMenu{3}:="(-"
$at_itemsMenu{4}:=__ ("Cortar Columna")
$at_itemsMenu{5}:=__ ("Copiar Columna")
$at_itemsMenu{6}:=__ ("Pegar Columna")
$at_itemsMenu{7}:=__ ("Borrar Columna")
$at_itemsMenu{8}:="(-"
$at_itemsMenu{9}:="("*Num:C11((Size of array:C274(aNtaOrden)=0) | ($b_columnaSinDatos))+__ ("Orden ascendente")
$at_itemsMenu{10}:="("*Num:C11((Size of array:C274(aNtaOrden)=0) | ($b_columnaSinDatos))+__ ("Orden descendente")
$at_itemsMenu{11}:="(-"
$at_itemsMenu{12}:="("*Num:C11($b_edicionPropiedadesPermitida=False:C215)+__ ("Propiedades de la columna…")

If (Size of array:C274(aNtaCopyCol)=0)
	$at_itemsMenu{6}:="("+$at_itemsMenu{6}
End if 

If ($b_columnaSinDatos)
	$at_itemsMenu{4}:="("+$at_itemsMenu{4}
	$at_itemsMenu{5}:="("+$at_itemsMenu{5}
	$at_itemsMenu{7}:="("+$at_itemsMenu{7}
End if 

If ($l_columna<vi_PrimeraColumnaParciales)
	$at_itemsMenu{12}:="("+$at_itemsMenu{12}
End if 

Case of 
	: ((vb_calificacionesEditables=False:C215) | ($t_arregloLiterales="aNtaOrden") | ($t_arregloLiterales="aNtaStdNme") | ($t_arregloLiterales="aNtaOf") | ($t_arregloLiterales="aNtaCurso"))
		$at_itemsMenu{4}:="("+$at_itemsMenu{4}
		$at_itemsMenu{5}:="("+$at_itemsMenu{5}
		$at_itemsMenu{6}:="("+$at_itemsMenu{6}
		$at_itemsMenu{7}:="("+$at_itemsMenu{7}
		
	: (($t_arregloLiterales="aNtaP@") | ($t_arregloLiterales="aNtaF") | ($t_arregloLiterales="aNtaOf"))
		$y_arregloReales:=Get pointer:C304(Replace string:C233($t_arregloLiterales;"aNta";"aRealNta"))
		If (Not:C34($b_PromediosEditables))
			$at_itemsMenu{4}:="("+$at_itemsMenu{4}
			$at_itemsMenu{5}:="("+$at_itemsMenu{5}
			$at_itemsMenu{6}:="("+$at_itemsMenu{6}
			$at_itemsMenu{7}:="("+$at_itemsMenu{7}
		End if 
		
	: ($t_arregloLiterales="aNtaEsfuerzo")
		$at_itemsMenu{4}:="("+$at_itemsMenu{4}
		$at_itemsMenu{5}:="("+$at_itemsMenu{5}
		$at_itemsMenu{6}:="("+$at_itemsMenu{6}
		If (Not:C34($b_calificacionesEditables))
			$at_itemsMenu{7}:="("+$at_itemsMenu{7}
		End if 
		
	Else 
		$y_arregloReales:=Get pointer:C304(Replace string:C233($t_arregloLiterales;"aNta";"aRealNta"))
		If (($b_calificacionesEditables=False:C215) & ($b_usuarioSinRestriccion=False:C215))
			$at_itemsMenu{4}:="("+$at_itemsMenu{4}
			$at_itemsMenu{7}:="("+$at_itemsMenu{7}
		End if 
		
		If (vb_calificacionesEditables)
			$b_columnaIngresable:=(aiAS_EvalPropEnterable{$l_Columna-vi_PrimeraColumnaParciales+1}=1)
			If ((Size of array:C274(aNtaCopyCol)>0) & ($b_columnaIngresable=True:C214) & (($b_columnaSinDatos) | (<>viSTR_NoModificarNotas=0) | ($b_usuarioSinRestriccion=True:C214)))
				$at_itemsMenu{6}:=__ ("Pegar Columna")
			Else 
				$at_itemsMenu{6}:="("+$at_itemsMenu{6}
			End if 
		Else 
			$at_itemsMenu{6}:="("+$at_itemsMenu{6}
		End if 
End case 

$t_itemsPopupMenu:=Replace string:C233(AT_array2text (->$at_itemsMenu;";");"((";"(")






$b_recalcular:=False:C215
$l_itemSeleccionado:=Pop up menu:C542($t_itemsPopupMenu)
If ($l_itemSeleccionado>0)
	Case of 
		: ($l_itemSeleccionado=1)  //copiar toda la planilla al portapapeles
			ARRAY LONGINT:C221($al_filasSeleccionadas;Size of array:C274(aNtaIDAlumno))
			For ($i_alumnos;1;Size of array:C274(aNtaIDAlumno))
				$al_filasSeleccionadas{$i_alumnos}:=$i_alumnos
			End for 
			AL_SetSelect (xALP_ASNotas;$al_filasSeleccionadas)
			POST KEY:C465(Character code:C91("C");256)
			
		: ($l_itemSeleccionado=2)  //copiar la selección actual al portapapeles
			POST KEY:C465(Character code:C91("C");256)
			
			
		: ($l_itemSeleccionado=4)  //cortar columna
			COPY ARRAY:C226($y_arregloLiterales->;aNtaCopyCol)
			COPY ARRAY:C226($y_arregloReales->;aRealNtaCopyCol)
			For ($i_alumnos;1;Size of array:C274(aNtaIdAlumno))
				$r_valorEditadoReal:=-10
				$b_GuardarRegistro:=True:C214
				$l_recNumCalificaciones:=aNtaRecNum{$i_alumnos}
				ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
			End for 
			$b_recalcular:=True:C214
			modNotas:=True:C214
			
			
		: ($l_itemSeleccionado=5)  //copiar columna
			COPY ARRAY:C226($y_arregloLiterales->;aNtaCopyCol)
			COPY ARRAY:C226($y_arregloReales->;aRealNtaCopyCol)
			
			
		: (($l_itemSeleccionado=6) & (Size of array:C274(aNtaCopyCol)>0))  //pegar columna
			AL_UpdateArrays (xALP_ASNotas;0)
			For ($i_alumnos;1;Size of array:C274(aNtaIdAlumno))
				$r_valorEditadoReal:=aRealNtaCopyCol{$i_alumnos}
				$b_GuardarRegistro:=True:C214
				$l_recNumCalificaciones:=aNtaRecNum{$i_alumnos}
				ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
			End for 
			$b_recalcular:=True:C214
			modNotas:=True:C214
			
			
		: ($l_itemSeleccionado=7)  //borrar columna
			For ($i_alumnos;1;Size of array:C274(aNtaIdAlumno))
				$r_valorEditadoReal:=-10
				$b_GuardarRegistro:=True:C214
				$l_recNumCalificaciones:=aNtaRecNum{$i_alumnos}
				ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
			End for 
			$b_recalcular:=True:C214
			modNotas:=True:C214
			_O_ARRAY STRING:C218(5;aNtaCopyCol;0)
			ARRAY REAL:C219(aRealNtaCopyCol;0)
			modNotas:=True:C214
			
			
		: ($l_itemSeleccionado=9)  //orden ascendente
			vb_AvisaSiOrdenModificado:=True:C214
			AL_SetSort (xALP_ASNotas;$l_columna)
			AL_UpdateArrays (xALP_ASNotas;-2)
			AS_SetNotasClr 
			
			
		: ($l_itemSeleccionado=10)  //orden descendente
			vb_AvisaSiOrdenModificado:=True:C214
			AL_SetSort (xALP_ASNotas;-$l_columna)
			AL_UpdateArrays (xALP_ASNotas;-2)
			AS_SetNotasClr 
			
		: ($l_itemSeleccionado=12)  //prefs  
			If ((USR_checkRights ("M";->[Asignaturas:18])) | (USR_GetMethodAcces ("Propiedades de evaluación";0)) | ([Asignaturas:18]profesor_numero:4=<>lUSR_RelatedTableUserID))
				AS_SetGradeOptions ($l_columna-vi_PrimeraColumnaParciales+1)
				$b_recalcular:=True:C214
			End if 
			
	End case 
	
	
	
	
	  //20131126 ASM ticket 127170 . No se refrescaban los datos en la pagina de evaluación cuando estaba marcada la opción de no calcular promedios.
	  //If (($b_recalcular) & (AS_PromediosSonCalculados ) & (vb_calificacionesEditables))
	If (($b_recalcular) & (vb_calificacionesEditables))
		If (AS_PromediosSonCalculados )
			  // conservo una copia de la eventual copia de la columna cortada (los arreglos aNtaCopyCol y aRealNtaCopyCol son inicializados en AS_PaginaEvaluacion)
			COPY ARRAY:C226(aNtaCopyCol;$as_copiaLiterales)
			COPY ARRAY:C226(aRealNtaCopyCol;$ar_copiaReales)
			
			$l_recNumAsignatura:=Record number:C243([Asignaturas:18])
			SAVE RECORD:C53([Asignaturas:18])
			
			APPEND TO ARRAY:C911($al_RecNumsAsignaturas;$l_recNumAsignatura)
			BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumsAsignaturas)
			EV2dbu_Recalculos ($x_RecNumsArray;False:C215)
			KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura)
			AS_PaginaEvaluacion 
			
			  // restablezco la columna cortada para permitir pegar en un paso posterior
			COPY ARRAY:C226($as_copiaLiterales;aNtaCopyCol)
			COPY ARRAY:C226($ar_copiaReales;aRealNtaCopyCol)
		Else 
			AS_PaginaEvaluacion 
		End if 
	End if 
	
End if 