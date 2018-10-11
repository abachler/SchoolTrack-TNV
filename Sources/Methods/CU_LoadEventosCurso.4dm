//%attributes = {}
  // CU_LoadEventosCurso()
  // Por: Alberto Bachler K.: 28-02-14, 16:54:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($i;$l_año;$l_areaEventos;$l_idCurso)


If (False:C215)
	C_LONGINT:C283(CU_LoadEventosCurso ;$1)
	C_LONGINT:C283(CU_LoadEventosCurso ;$2)
	C_LONGINT:C283(CU_LoadEventosCurso ;$3)
End if 

ALP_RemoveAllArrays (xALP_EventosCurso)

ARRAY DATE:C224(ad_FechaEvCurso;0)  //eventos curso
ARRAY TEXT:C222(at_CategoriaEvCurso;0)
ARRAY TEXT:C222(at_TemaEvCurso;0)
ARRAY DATE:C224(aYears2;0)
ARRAY TEXT:C222(aYears;0)
READ ONLY:C145([Cursos_Eventos:128])

If (Count parameters:C259=3)
	$l_año:=$1
	$l_idCurso:=$2
	$l_areaEventos:=$3
	
	If ($l_año<<>gYear)
		PERIODOS_LeeDatosHistoricos ([Cursos:3]Nivel_Numero:7;$l_año)
	Else 
		PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
	End if 
	
	QUERY:C277([Cursos_Eventos:128];[Cursos_Eventos:128]id_Curso:1=$l_idCurso)
	ORDER BY:C49([Cursos_Eventos:128];[Cursos_Eventos:128]Fecha_Observación:2;>)
	
	QUERY SELECTION:C341([Cursos_Eventos:128];[Cursos_Eventos:128]Fecha_Observación:2>=vdSTR_Periodos_InicioEjercicio;*)
	QUERY SELECTION:C341([Cursos_Eventos:128]; & ;[Cursos_Eventos:128]Fecha_Observación:2<=vdSTR_Periodos_FinEjercicio)
Else 
	$l_idCurso:=[Cursos:3]Numero_del_curso:6
	QUERY:C277([Cursos_Eventos:128];[Cursos_Eventos:128]id_Curso:1=$l_idCurso)
	SELECTION TO ARRAY:C260([Cursos_Eventos:128]Fecha_Observación:2;aYears2)
	For ($i;1;Size of array:C274(aYears2))
		AT_Insert (0;1;->aYears)
		$l_año:=Year of:C25(aYears2{$i})
		If ($l_año#<>gYear)
			aYears{$i}:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->$l_año;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
		Else 
			aYears{$i}:=<>gNombreAgnoEscolar
		End if 
	End for 
End if 

ORDER BY:C49([Cursos_Eventos:128];[Cursos_Eventos:128]Fecha_Observación:2;<)
SELECTION TO ARRAY:C260([Cursos_Eventos:128]Fecha_Observación:2;ad_FechaEvCurso;[Cursos_Eventos:128]Categoría:3;at_CategoriaEvCurso;[Cursos_Eventos:128]Tema:4;at_TemaEvCurso)

If (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
	xALSet_CU_AreaEventos 
End if 
AL_SetLine ($l_areaEventos;0)
_O_DISABLE BUTTON:C193(bDeleteLineEvCurso)