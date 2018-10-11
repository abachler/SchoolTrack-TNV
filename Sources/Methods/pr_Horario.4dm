//%attributes = {}
  // pr_Horario()
  //
  //
  // creado por: Alberto Bachler Klein: 01-04-16, 17:59:19
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($i;$records)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario)

ARRAY LONGINT:C221($al_recNums;0)

If (False:C215)
	C_TEXT:C284(pr_Horario ;$1)
	C_TEXT:C284(pr_Horario ;$2)
End if 

Case of 
	: (Count parameters:C259=2)
		$t_destinoImpresion:=$1
		$t_formulaNombreDocumento:=$2
	: (Count parameters:C259=1)
		$t_destinoImpresion:=$1
End case 
$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:=[xShell_Reports:54]FormName:17


QR_AjustesImpresion (0;$y_tabla;"Horario")
If (ok=1)
	Case of 
		: (Table:C252($y_tabla)=Table:C252(->[Alumnos:2]))
			vUseColor:=CD_Dlog (0;__ ("¿Desea usar colores en el horario?\rRecuerde configurar los colores en las fichas de los profesores.");__ ("");__ ("Si");__ ("No"))
			If (<>shift)
				ORDER BY:C49([Alumnos:2])
			Else 
				ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
			End if 
			
			LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
			For ($i;1;Size of array:C274($al_recNums))
				KRL_GotoRecord (->[Alumnos:2];$al_recNums{$i})
				PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
				If (vlSTR_Horario_NoCiclos=2)
					vlSTR_Horario_CicloNumero:=1
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
					vlSTR_Horario_CicloNumero:=2
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
				Else 
					vlSTR_Horario_CicloNumero:=1
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
				End if 
			End for 
			
		: (Table:C252($y_tabla)=Table:C252(->[Cursos:3]))
			vUseColor:=CD_Dlog (0;__ ("¿Desea usar colores en el horario?\rRecuerde configurar los colores en las fichas de los profesores.");__ ("");__ ("Si");__ ("No"))
			If (<>shift)
				ORDER BY:C49([Cursos:3])
			Else 
				ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
			End if 
			LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
			For ($i;1;Size of array:C274($al_recNums))
				KRL_GotoRecord (->[Cursos:3];$al_recNums{$i})
				PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
				If (vlSTR_Horario_NoCiclos=2)
					vlSTR_Horario_CicloNumero:=1
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
					vlSTR_Horario_CicloNumero:=2
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
				Else 
					vlSTR_Horario_CicloNumero:=1
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
				End if 
			End for 
			
		: (Table:C252($y_tabla)=Table:C252(->[Profesores:4]))
			If (<>shift)
				ORDER BY:C49([Profesores:4])
			Else 
				ORDER BY:C49([Profesores:4];[Profesores:4]Apellidos_y_nombres:28;>)
			End if 
			LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
			For ($i;1;Size of array:C274($al_recNums))
				KRL_GotoRecord (->[Profesores:4];$al_recNums{$i})
				SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
				SET FIELD RELATION:C919([TMT_Horario:166]ID_Asignatura:5;Automatic:K51:4;Do not modify:K51:1)
				QUERY:C277([TMT_Horario:166];[Asignaturas:18]profesor_numero:4;=;[Profesores:4]Numero:1;*)
				QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]No_Ciclo:14=2)
				SET FIELD RELATION:C919([TMT_Horario:166]ID_Asignatura:5;Structure configuration:K51:2;Structure configuration:K51:2)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($records>0)
					vlSTR_Horario_NoCiclos:=2
					vlSTR_Horario_CicloNumero:=1
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
					vlSTR_Horario_CicloNumero:=2
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
				Else 
					vlSTR_Horario_CicloNumero:=1
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
				End if 
			End for 
	End case 
End if 