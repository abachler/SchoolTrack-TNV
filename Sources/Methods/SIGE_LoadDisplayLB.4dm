//%attributes = {}
C_LONGINT:C283($ref;$1;$cols_to_delete)
C_LONGINT:C283(vl_titulo1;vl_titulo2;vl_titulo3;vl_titulo4;vl_titulo5)

$ref:=$1

$cols_to_delete:=LISTBOX Get number of columns:C831(LB_SIGE)
LISTBOX DELETE COLUMN:C830(*;"LB_SIGE";1;$cols_to_delete)

Case of 
	: ($ref=1)  //alumnos
		
		LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";1;"col_alumno";at_alumno;"vl_Titulo1";vl_Titulo1)
		LISTBOX SET COLUMN WIDTH:C833(*;"col_alumno";220;180;220)
		OBJECT SET TITLE:C194(*;"vl_Titulo1";"Alumnos")
		
		LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";2;"col_cur";at_cur;"vl_Titulo2";vl_Titulo2)
		LISTBOX SET COLUMN WIDTH:C833(*;"col_cur";70;50;70)
		OBJECT SET TITLE:C194(*;"vl_Titulo2";"Curso")
		
		LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";3;"col_problema_alu";at_problema_alu;"vl_Titulo3";vl_Titulo3)
		OBJECT SET TITLE:C194(*;"vl_Titulo3";"Detalle")
		
	: ($ref=2)  //Tipos de enseñanzas
		
		LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";1;"col_RolBD_P";at_RolBD_P;"vl_Titulo1";vl_Titulo1)
		LISTBOX SET COLUMN WIDTH:C833(*;"col_RolBD_P";70;50;70)
		OBJECT SET TITLE:C194(*;"vl_Titulo1";"Rol")
		
		LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";2;"col_CodTipoEns_P";at_CodTipoEns_P;"vl_Titulo2";vl_Titulo2)
		LISTBOX SET COLUMN WIDTH:C833(*;"col_CodTipoEns_P";60;50;60)
		OBJECT SET TITLE:C194(*;"vl_Titulos2";"Código")
		
		LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";3;"col_detalle_P";at_detalle_P;"vl_Titulo3";vl_Titulo3)
		OBJECT SET TITLE:C194(*;"vl_Titulo3";"Detalle")
		
	: ($ref=3)  //Cursos
		
		LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";1;"col_curso_P";at_curso_P;"vl_Titulo1";vl_Titulo1)
		LISTBOX SET COLUMN WIDTH:C833(*;"col_curso_P";70;50;70)
		OBJECT SET TITLE:C194(*;"vl_Titulo1";"Cursos")
		
		LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";2;"col_cod_ejec_curso_P";at_cod_ejec_curso_P;"vl_Titulo2";vl_Titulo2)
		OBJECT SET TITLE:C194(*;"vl_Titulo2";"Detalle")
		LISTBOX SET ROWS HEIGHT:C835(*;"LB_SIGE";20)
	: ($ref=4)  //Asistencia
		
		Case of 
			: (opt1=1)
				
				LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";1;"col_NombreNivelesActivos";<>at_NombreNivelesActivos;"vl_Titulo1";vl_Titulo1)
				LISTBOX SET COLUMN WIDTH:C833(*;"col_NombreNivelesActivos";100;80;100)
				OBJECT SET TITLE:C194(*;"vl_Titulo1";"Niveles")
				
				LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";2;"col_NivDetail";at_NivDetail;"vl_Titulo2";vl_Titulo2)
				OBJECT SET TITLE:C194(*;"vl_Titulo2";"Detalle "+vt_mes)
				LISTBOX SET ROWS HEIGHT:C835(*;"LB_SIGE";20)
				
			: ((opt2=1) | (opt3=1))
				
				LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";1;"col_Rol";at_Rol;"vl_Titulo1";vl_Titulo1)
				LISTBOX SET COLUMN WIDTH:C833(*;"col_Rol";70;50;70)
				OBJECT SET TITLE:C194(*;"vl_Titulo1";"Rol")
				
				LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";2;"col_Cod_ens";at_Cod_ens;"vl_Titulo2";vl_Titulo2)
				LISTBOX SET COLUMN WIDTH:C833(*;"col_Cod_ens";60;40;60)
				OBJECT SET TITLE:C194(*;"vl_Titulo2";"Código")  //enseñanza
				
				LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";3;"col_Cod_grado";at_Cod_grado;"vl_Titulo3";vl_Titulo3)
				LISTBOX SET COLUMN WIDTH:C833(*;"col_Cod_grado";60;40;60)
				OBJECT SET TITLE:C194(*;"vl_Titulo3";"Grado")  //código de grado
				
				LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";4;"col_Fecha";at_Fecha;"vl_Titulo4";vl_Titulo4)
				LISTBOX SET COLUMN WIDTH:C833(*;"col_Fecha";70;40;70)
				OBJECT SET TITLE:C194(*;"vl_Titulo4";"Fecha")
				
				LISTBOX INSERT COLUMN:C829(*;"LB_SIGE";5;"col_Detalle";at_Detalle;"vl_Titulo5";vl_Titulo5)
				LISTBOX SET COLUMN WIDTH:C833(*;"col_Detalle";575;575;575)
				OBJECT SET TITLE:C194(*;"vl_Titulo5";"Detalle del Nivel ST "+<>at_NombreNivelesActivos{Find in array:C230(<>al_NumeroNivelesActivos;vi_NivelNum)})
				
				LISTBOX SET ROWS HEIGHT:C835(*;"LB_SIGE";40)
		End case 
End case 
OBJECT SET ENTERABLE:C238(*;"LB_SIGE";False:C215)
OBJECT SET FONT SIZE:C165(*;"LB_SIGE";10)