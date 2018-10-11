//%attributes = {}
  //CAE_CreaHistoricoAlumnos

  //REGISTOR DE CAMBIOS
  //20080303 RCH. Se almacena nuevo campo con número de días trabajados

C_LONGINT:C283($1;$2;$l_nivelAlu)  //MONO 184433
If (Count parameters:C259=2)  //MONO 184433
	vl_UltimoAño:=$1  //MONO 184433
	$l_nivelAlu:=$2  //MONO 184433
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$l_nivelAlu)  //MONO 184433
Else 
	QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)  //MONO 184433
End if 

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
ARRAY LONGINT:C221($aRecNum;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNum;"")
$n:=Size of array:C274($aRecNum)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Archivando las informaciones sobre alumnos del año ")+String:C10(vl_UltimoAño))
For ($i;1;$n)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$n)
	READ WRITE:C146([Alumnos:2])
	GOTO RECORD:C242([Alumnos:2];$aRecNum{$i})
	If ([Alumnos:2]ocultoEnNominas:89)
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]Curso_alRetirarse:83)
	Else 
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
	End if 
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
	QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2=vl_UltimoAño)
	If (Records in selection:C76([Alumnos_Historico:25])=0)
		CREATE RECORD:C68([Alumnos_Historico:25])
		[Alumnos_Historico:25]Alumno_Numero:1:=[Alumnos:2]numero:1
		[Alumnos_Historico:25]Año:2:=vl_UltimoAño
	End if 
	[Alumnos_Historico:25]ID_Curso:34:=[Cursos:3]Numero_del_curso:6  //rch para NF eventos cursos.
	[Alumnos_Historico:25]Curso:3:=[Alumnos:2]curso:20
	[Alumnos_Historico:25]ProfesorJefe:33:=[Profesores:4]Apellidos_y_nombres:28
	[Alumnos_Historico:25]Nivel:11:=[Alumnos:2]nivel_numero:29
	[Alumnos_Historico:25]Nivel_Nombre:38:=[Alumnos:2]Nivel_Nombre:34
	[Alumnos_Historico:25]NombreAgnoEscolar:37:=vt_NombreUltimoAñoEscolar
	[Alumnos_Historico:25]ObservacionesActas:22:=[Alumnos:2]Observaciones_en_Acta:58
	[Alumnos_Historico:25]cl_CodigoTipoEnseñanza:32:=[Cursos:3]cl_CodigoTipoEnseñanza:21
	[Alumnos_Historico:25]Situacion_final:19:=[Alumnos:2]Situacion_final:33
	[Alumnos_Historico:25]NumeroDeFolio:43:=[Alumnos:2]NumeroDeFolio:103
	If (([Cursos:3]Sede:19#"") & (([Cursos:3]cl_RolBaseDatos:20#<>gRolBD) | ([Cursos:3]ActaEspecificaAlCurso:35)))
		[Alumnos_Historico:25]Colegio_anterior:20:=[Cursos:3]Sede:19
		If ([Cursos:3]cl_CodigoDecretoPlanEstudios:22>0)
			[Alumnos_Historico:25]DPE_ColegioAnterior:26:=String:C10([Cursos:3]cl_CodigoDecretoPlanEstudios:22)
		Else 
			[Alumnos_Historico:25]DPE_ColegioAnterior:26:=String:C10(KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Historico:25]Nivel:11;->[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39))
		End if 
		If ([Cursos:3]cl_CodigoDecretoEvaluacion:24>0)
			[Alumnos_Historico:25]DEyP_ColegioAnterior:27:=String:C10([Cursos:3]cl_CodigoDecretoEvaluacion:24)
		Else 
			[Alumnos_Historico:25]DEyP_ColegioAnterior:27:=String:C10(KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Historico:25]Nivel:11;->[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38))
		End if 
	Else 
		[Alumnos_Historico:25]Colegio_anterior:20:=<>gCustom
		[Alumnos_Historico:25]DPE_ColegioAnterior:26:=String:C10(KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Historico:25]Nivel:11;->[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39))
		[Alumnos_Historico:25]DEyP_ColegioAnterior:27:=String:C10(KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_Historico:25]Nivel:11;->[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38))
	End if 
	
	  //20101209 RCH Separador para decretos. Se obtienen desde lo usado en las concentraciones para cuarto medio.
	C_TEXT:C284($vt_separador)
	If ([Alumnos_Historico:25]DPE_ColegioAnterior:26="0")
		[Alumnos_Historico:25]DPE_ColegioAnterior:26:=""
	Else 
		  //$vt_separador:=STRal_OpcionesConcentracion ("ObtieneSeparadorPlan")
		[Alumnos_Historico:25]DPE_ColegioAnterior:26:="N° "+Insert string:C231([Alumnos_Historico:25]DPE_ColegioAnterior:26;" de ";(Length:C16([Alumnos_Historico:25]DPE_ColegioAnterior:26)-4)+1)
	End if 
	If ([Alumnos_Historico:25]DEyP_ColegioAnterior:27="0")
		[Alumnos_Historico:25]DEyP_ColegioAnterior:27:=""
	Else 
		  //$vt_separador:=STRal_OpcionesConcentracion ("ObtieneSeparadorPromocion")
		[Alumnos_Historico:25]DEyP_ColegioAnterior:27:="N° "+Insert string:C231([Alumnos_Historico:25]DEyP_ColegioAnterior:27;" de ";(Length:C16([Alumnos_Historico:25]DEyP_ColegioAnterior:27)-4)+1)
	End if 
	
	[Alumnos_Historico:25]Total_DiasTrabajadosAño:41:=viSTR_Periodos_DiasAgno
	[Alumnos_Historico:25]ID:23:=SQ_SeqNumber (->[Alumnos_Historico:25]ID:23)
	SAVE RECORD:C53([Alumnos_Historico:25])
	
End for 
FLUSH CACHE:C297
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)