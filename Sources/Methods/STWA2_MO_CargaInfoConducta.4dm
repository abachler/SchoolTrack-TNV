//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 20-06-18, 09:18:29
  // ----------------------------------------------------
  // Método: STWA2_MO_CargaInfoConducta
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_OBJECT:C1216($o_parametros)
C_LONGINT:C283($userID)

$t_accion:=$1
If (Count parameters:C259=2)
	$o_parametros:=$2
End if 

Case of 
	: ($t_accion="ProfesoresConducta")
		ARRAY LONGINT:C221($al_profesorNumero;0)
		ARRAY TEXT:C222($at_nombreCompuesto;0)
		ARRAY TEXT:C222($at_profesorAutocomplete;0)
		ARRAY LONGINT:C221($al_profesorNumeroAutocomplete;0)
		
		C_OBJECT:C1216($ob_temporal;$ob_profesores)
		C_LONGINT:C283($l_idProf)
		
		If (OB Is defined:C1231($o_parametros))
			$l_idProf:=OB Get:C1224($o_parametros;"profID")
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=$l_idProf)
			SELECTION TO ARRAY:C260([Profesores:4]Numero:1;$al_profesorNumero)
		Else 
			QUERY:C277([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
			SELECTION TO ARRAY:C260([Profesores:4]Numero:1;$al_profesorNumero)
		End if 
		
		For ($i;1;Size of array:C274($al_profesorNumero))
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=$al_profesorNumero{$i})
			QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=$al_profesorNumero{$i};*)
			QUERY:C277([Asignaturas:18]; | ;[Asignaturas:18]profesor_firmante_numero:33=$al_profesorNumero{$i})
			ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]Asignatura:3;>)
			SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_idAsiProfesor;[Asignaturas:18]Asignatura:3;$at_nombreAsiProfesor;[Asignaturas:18]Curso:5;$at_CursoAsiProfesor;[Asignaturas:18]denominacion_interna:16;$at_denominacionInterna)
			
			  //20180828 ASM Ticket 214723
			AT_Initialize (->$at_nombreCompuesto)
			AT_RedimArrays (Size of array:C274($at_nombreAsiProfesor);->$at_nombreCompuesto)
			For ($ii;1;Size of array:C274($at_nombreAsiProfesor))
				If ($at_denominacionInterna{$ii}=$at_nombreAsiProfesor{$ii})
					$at_nombreCompuesto{$ii}:=$at_nombreAsiProfesor{$ii}+" - ("+$at_CursoAsiProfesor{$ii}+")"
				Else 
					$at_nombreCompuesto{$ii}:=$at_nombreAsiProfesor{$ii}+" "+"("+$at_denominacionInterna{$ii}+") - ("+$at_CursoAsiProfesor{$ii}+")"
				End if 
			End for 
			
			APPEND TO ARRAY:C911($at_profesorAutocomplete;[Profesores:4]Apellidos_y_nombres:28)
			APPEND TO ARRAY:C911($al_profesorNumeroAutocomplete;[Profesores:4]Numero:1)
			
			OB SET ARRAY:C1227($ob_temporal;"idAsignatura";$al_idAsiProfesor)
			OB SET ARRAY:C1227($ob_temporal;"nombreasignatura";$at_nombreAsiProfesor)
			OB SET ARRAY:C1227($ob_temporal;"cursoasignatura";$at_CursoAsiProfesor)
			OB SET ARRAY:C1227($ob_temporal;"nombrecompuesto";$at_nombreCompuesto)
			OB SET:C1220($ob_temporal;"idprofesor";$al_profesorNumero{$i})
			OB SET:C1220($ob_temporal;"nombreprofesor";[Profesores:4]Apellidos_y_nombres:28)
			OB SET:C1220($ob_profesores;String:C10([Profesores:4]Numero:1);$ob_temporal)
			CLEAR VARIABLE:C89($ob_temporal)
		End for 
		
		OB SET ARRAY:C1227($ob_profesores;"profnombreautocomplete";$at_profesorAutocomplete)
		OB SET ARRAY:C1227($ob_profesores;"profIDbreautocomplete";$al_profesorNumeroAutocomplete)
		
		$0:=$ob_profesores
		
	: ($t_accion="MotivosAnotaciones")
		
		ARRAY TEXT:C222($at_signo;0)
		ARRAY TEXT:C222($at_color;0)
		STR_LeePreferenciasConducta2 
		C_OBJECT:C1216($ob_anotaciones)
		ARRAY TEXT:C222($at_categorias;0)
		SORT ARRAY:C229(<>aiID_Matriz;<>atSTR_Anotaciones_categorias;<>atSTR_Anotaciones_motivo;<>aiSTR_Anotaciones_puntaje;<>aiSTR_Anotaciones_motivo_puntaj)
		
		For ($l_indice;1;Size of array:C274(<>aiID_Matriz))
			$l_posicion:=Find in array:C230(aiSTR_IDCategoria;<>aiID_Matriz{$l_indice})
			Case of 
				: (ai_TipoAnotacion{$l_posicion}>0)
					$t_signo:="+"
					$t_color:="#07c611"
				: (ai_TipoAnotacion{$l_posicion}=0)
					$t_signo:="="
					$t_color:="#0465f7"
				: (ai_TipoAnotacion{$l_posicion}<0)
					$t_signo:="-"
					$t_color:="#f74545"
			End case 
			APPEND TO ARRAY:C911($at_signo;$t_signo)
			APPEND TO ARRAY:C911($at_color;$t_color)
		End for 
		
		OB SET ARRAY:C1227($ob_anotaciones;"idmatriz";<>aiID_Matriz)
		OB SET ARRAY:C1227($ob_anotaciones;"categorias";<>atSTR_Anotaciones_categorias)
		OB SET ARRAY:C1227($ob_anotaciones;"motivo";<>atSTR_Anotaciones_motivo)
		OB SET ARRAY:C1227($ob_anotaciones;"puntaje";<>aiSTR_Anotaciones_puntaje)
		OB SET ARRAY:C1227($ob_anotaciones;"motivopuntaje";<>aiSTR_Anotaciones_motivo_puntaj)
		OB SET ARRAY:C1227($ob_anotaciones;"categoriasgrupo";at_STR_CategoriasAnot_Nombres)
		OB SET ARRAY:C1227($ob_anotaciones;"signo";$at_signo)
		OB SET ARRAY:C1227($ob_anotaciones;"color";$at_color)
		
		$0:=$ob_anotaciones
		
	: ($t_accion="MotivosMedidas")
		ARRAY TEXT:C222($at_MotivosCastigo;0)
		C_BLOB:C604(xblob)
		C_OBJECT:C1216($ob_castigos)
		xblob:=PREF_fGetBlob (0;"MotivosCastigo";xblob)
		BLOB_Blob2Vars (->xblob;0;->$at_MotivosCastigo)
		OB SET ARRAY:C1227($ob_castigos;"motivo";$at_MotivosCastigo)
		
		$0:=$ob_castigos
		
	: ($t_accion="MotivosSuspensiones")
		C_OBJECT:C1216($ob_suspensiones)
		ARRAY TEXT:C222($at_MotivosSuspension;0)
		xblob:=PREF_fGetBlob (0;"MotivosSuspension";xblob)
		BLOB_Blob2Vars (->xblob;0;->$at_MotivosSuspension)
		
		$userID:=OB Get:C1224($o_parametros;"userID")
		
		  //preferencias
		$b_CrearInasistencias:=(PREF_fGet ($userID;"SuspencionCreaInasistencia";"0")="1")
		$b_CrearInasistenciasFuturas:=(PREF_fGet ($userID;"SuspencionCreaInasistenciaFutura";"0")="1")
		
		
		OB SET ARRAY:C1227($ob_suspensiones;"motivo";$at_MotivosSuspension)
		OB SET:C1220($ob_suspensiones;"reginasist";$b_CrearInasistencias)
		OB SET:C1220($ob_suspensiones;"reginasistfutura";$b_CrearInasistenciasFuturas)
		
		$0:=$ob_suspensiones
		
	: ($t_accion="OpcionesLicencias")
		C_OBJECT:C1216($ob_licencias)
		
		STR_LeePreferenciasConducta2 
		$userID:=OB Get:C1224($o_parametros;"userID")
		
		$b_CrearInasistenciasLicencias:=(PREF_fGet ($userID;"LicenciaCreaInasistencia";"0")="1")
		$b_CrearInasistenciasFuturasLic:=(PREF_fGet ($userID;"LicenciaCreaInasistenciaFutura";"0")="1")
		
		OB SET ARRAY:C1227($ob_licencias;"motivo";<>aLicencias)
		OB SET ARRAY:C1227($ob_licencias;"motivoespecial";<>at_LicenciaMotivosEspeciales)
		OB SET:C1220($ob_licencias;"reginasist";$b_CrearInasistenciasLicencias)
		OB SET:C1220($ob_licencias;"reginasistfutura";$b_CrearInasistenciasFuturasLic)
		
		$0:=$ob_licencias
End case 