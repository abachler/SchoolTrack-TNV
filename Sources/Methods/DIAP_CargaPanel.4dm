//%attributes = {}
C_LONGINT:C283($1;$pagina;$i;$fia)
C_BOOLEAN:C305($cambiarpagina;$0)
C_TEXT:C284($label_alumnos)

$pagina:=$1
$cambiarpagina:=True:C214

Case of 
	: ($pagina=1)  //Pagina 1 Configuración
		
		  //LB de Subsectores disponibles para DIAP
		ARRAY TEXT:C222(a_LB_Materia;0)
		ARRAY TEXT:C222(a_LB_UUID_Materia;0)
		ARRAY BOOLEAN:C223(a_LB_MateriaDisponible;0)
		ARRAY LONGINT:C221(a_LB_MateriaEstilo;0)
		C_TEXT:C284(t_UUID_MAteriaObligatoria)
		DIAP_ConfigCargaSubsectores (->a_LB_Materia;->a_LB_UUID_Materia;->a_LB_MateriaDisponible;->t_UUID_MAteriaObligatoria)
		ARRAY LONGINT:C221(a_LB_MateriaEstilo;Size of array:C274(a_LB_Materia))
		$fia:=Find in array:C230(a_LB_UUID_Materia;t_UUID_MAteriaObligatoria)
		If ($fia>0)
			a_LB_MateriaEstilo{$fia}:=Bold:K14:2
		End if 
		
		OBJECT SET TITLE:C194(*;"a_LB_MateriaT1";__ ("Sub Sectores"))
		OBJECT SET TITLE:C194(*;"a_LB_MateriaT2";__ ("Disponible DIAP"))
		
		  //LB de Cursos que inscriben DIAP
		ARRAY TEXT:C222(a_LB_Curso;0)
		ARRAY TEXT:C222(a_LB_CursoUUID;0)
		ARRAY BOOLEAN:C223(a_LB_CursoDisponible;0)
		DIAP_ConfigCargaCursos (->a_LB_Curso;->a_LB_CursoUUID;->a_LB_CursoDisponible)
		
		OBJECT SET TITLE:C194(*;"a_LB_CursosT1";__ ("Cursos"))
		OBJECT SET TITLE:C194(*;"a_LB_CursosT2";__ ("Disponible DIAP"))
		
		  //LB Tipos de Evaluación
		ARRAY LONGINT:C221(a_LB_IdTipoEva;0)
		ARRAY TEXT:C222(a_LB_TipoEVA;0)
		
		DIAP_ConfigCargaTipoExamen (->a_LB_IdTipoEva;->a_LB_TipoEVA)
		
		OBJECT SET TITLE:C194(*;"LB_TipoEVaTitulo";__ ("Tipo de Examen"))
		OBJECT SET ENABLED:C1123(*;"bRemoveTipoEVa";False:C215)
		
		  //LB Lenguas Maternas
		ARRAY LONGINT:C221(a_LB_IdLenguaMaterna;0)
		ARRAY TEXT:C222(a_LB_LenguaMaterna;0)
		
		DIAP_ConfigCargaIdiomas (->a_LB_IdLenguaMaterna;->a_LB_LenguaMaterna)
		
		OBJECT SET TITLE:C194(*;"LB_LenguaMaternaTitulo";__ ("Lengua Materna"))
		OBJECT SET ENABLED:C1123(*;"bRemoveIdioma";False:C215)
		
	: ($pagina=2)  //Pagina de inscripción
		
		C_BLOB:C604($xBlob)
		SET BLOB SIZE:C606($xBlob;0)
		ARRAY TEXT:C222($at_DIAP_CursoUUID;0)
		ARRAY TEXT:C222($at_DIAP_Curso;0)
		ARRAY BOOLEAN:C223($ab_DIAP_CursoDisponible;0)
		ARRAY TEXT:C222(at_cursos_disponibles;0)
		
		DIAP_ConfigCargaCursos (->$at_DIAP_Curso;->$at_DIAP_CursoUUID;->$ab_DIAP_CursoDisponible)
		  //array para menu de curso
		For ($i;1;Size of array:C274($at_DIAP_Curso))
			If ($ab_DIAP_CursoDisponible{$i})
				APPEND TO ARRAY:C911(at_cursos_disponibles;$at_DIAP_Curso{$i})
			End if 
		End for 
		
		  //array para menu de subsector
		ARRAY TEXT:C222(at_menu_subsector;0)
		ARRAY TEXT:C222(at_menu_subsector_UUID;0)
		
		For ($i;1;Size of array:C274(a_LB_Materia))
			If (a_LB_MateriaDisponible{$i})
				APPEND TO ARRAY:C911(at_menu_subsector;a_LB_Materia{$i})
				APPEND TO ARRAY:C911(at_menu_subsector_UUID;a_LB_UUID_Materia{$i})
			End if 
		End for 
		
		
		If (Size of array:C274(at_cursos_disponibles)>0)
			  //LB Alumnos
			OBJECT SET TITLE:C194(*;"LB_AlumnosT1";__ ("Alumnos"))
			OBJECT SET TITLE:C194(*;"LB_AlumnosT2";__ ("Inscripciones"))
			OBJECT SET VISIBLE:C603(*;"al_ID_alumnos";False:C215)
			
			  //LB Alumnos Asignaturas DIAP
			ARRAY INTEGER:C220(a_LB_AADIAP_orden;0)
			ARRAY TEXT:C222(a_LB_AADIAP_abrev;0)
			ARRAY TEXT:C222(a_LB_AADIAP_asignatura;0)
			ARRAY TEXT:C222(a_LB_AADIAP_tipoExamen;0)
			ARRAY TEXT:C222(a_LB_AADIAP_IdiomaMaterno;0)
			ARRAY TEXT:C222(a_inscripcion_UUID;0)
			ARRAY LONGINT:C221(a_id_asignatura;0)
			ARRAY LONGINT:C221(a_id_tipoexamen;0)
			ARRAY LONGINT:C221(a_id_lenguaMaterna;0)
			
			OBJECT SET ENABLED:C1123(*;"bInscribeAlu";False:C215)
			OBJECT SET ENABLED:C1123(*;"bDesinscribeAlu";False:C215)
			
			OBJECT SET TITLE:C194(*;"LB_AluASig_t1";__ ("Orden"))
			OBJECT SET TITLE:C194(*;"LB_AluASig_t2";__ ("Código"))
			OBJECT SET TITLE:C194(*;"LB_AluASig_t3";__ ("Asignatura"))
			OBJECT SET TITLE:C194(*;"LB_AluASig_t4";__ ("Exámen"))
			OBJECT SET TITLE:C194(*;"LB_AluASig_t5";__ ("Lengua"))
			
			  //FALTA INSCRIPCION DE IDIOMAS
			
			ARRAY TEXT:C222(at_alumnos;0)
			ARRAY LONGINT:C221(al_ID_alumnos;0)
			ARRAY TEXT:C222(at_asignaturas_inscritas;0)
			
			$label_alumnos:=DIAP_InscribeCargaAlumnos (at_cursos_disponibles{1};->at_alumnos;->al_ID_alumnos;->at_asignaturas_inscritas)
			OBJECT SET TITLE:C194(*;"txt_alumnosinscritos";$label_alumnos)
			OBJECT SET TITLE:C194(*;"txt_curso_seleccionado";"Curso: "+at_cursos_disponibles{1})
			LB_Alumnos:=0
			ARRAY BOOLEAN:C223(LB_Alumnos;0)
			ARRAY BOOLEAN:C223(LB_Alumnos;Size of array:C274(at_alumnos))
			
			  //LB de inscripciones Alumnos IDIOMAS DIAP
			ARRAY TEXT:C222(a_LB_Aidioma_UUID;0)
			ARRAY INTEGER:C220(a_LB_Aidioma_orden;0)
			ARRAY TEXT:C222(a_LB_Aidioma_Codigo;0)
			ARRAY TEXT:C222(a_LB_Aidioma_DesAleman;0)
			ARRAY TEXT:C222(a_LB_Aidioma_DesEspañol;0)
			ARRAY INTEGER:C220(a_LB_Aidioma_NivelDesde;0)
			ARRAY INTEGER:C220(a_LB_Aidioma_NivelHasta;0)
			
			OBJECT SET VISIBLE:C603(*;"a_LB_Aidioma_UUID";False:C215)
			
			OBJECT SET TITLE:C194(*;"LB_AluIdioma_t1";__ ("Orden"))
			OBJECT SET TITLE:C194(*;"LB_AluIdioma_t2";__ ("Código"))
			OBJECT SET TITLE:C194(*;"LB_AluIdioma_t3";__ ("Desc. Alemán"))
			OBJECT SET TITLE:C194(*;"LB_AluIdioma_t4";__ ("Desc. Español"))
			OBJECT SET TITLE:C194(*;"LB_AluIdioma_t5";__ ("Nivel Desde"))
			OBJECT SET TITLE:C194(*;"LB_AluIdioma_t6";__ ("Nivel Hasta"))
			
			OBJECT SET ENABLED:C1123(*;"bInscribeIdioma";False:C215)
			OBJECT SET ENABLED:C1123(*;"bDesinscribeIdioma";False:C215)
			
		Else 
			$cambiarpagina:=False:C215
			CD_Dlog (0;__ ("No existen cursos disponibles para inscribir DIAP, por favor agreguelos en la página de Configuración de este formulario"))
		End if 
		
End case 

$0:=$cambiarpagina

