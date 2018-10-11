//%attributes = {}
  // MÉTODO: AS_PaginaObjetivos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 27/12/11, 10:27:32
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AS_PageObjetivos()
  // ----------------------------------------------------
C_LONGINT:C283($l_recNumAsignatura)

ARRAY LONGINT:C221($al_IdPestaña;0)
ARRAY TEXT:C222($at_nombrePestaña;0)

  // CODIGO PRINCIPAL
vObj_P1:=""
vObj_P2:=""
vObj_P3:=""
vObj_P4:=""
vObj_P5:=""
modObjetivos:=False:C215

If ([Asignaturas:18]ID_Objetivos:43#0)
	QUERY:C277([Asignaturas_Objetivos:104];[Asignaturas_Objetivos:104]ID:1=[Asignaturas:18]ID_Objetivos:43)
	If (Records in selection:C76([Asignaturas_Objetivos:104])=0)
		CREATE RECORD:C68([Asignaturas_Objetivos:104])
		[Asignaturas_Objetivos:104]ID:1:=SQ_SeqNumber (->[Asignaturas_Objetivos:104]ID:1;False:C215)
		[Asignaturas_Objetivos:104]Nivel_numero:4:=[Asignaturas:18]Numero_del_Nivel:6
		[Asignaturas_Objetivos:104]ID_Autor:3:=[Asignaturas:18]profesor_numero:4
		[Asignaturas_Objetivos:104]Subsector:2:=[Asignaturas:18]Asignatura:3
		[Asignaturas_Objetivos:104]Objetivos_P1:6:=""
		[Asignaturas_Objetivos:104]Objetivos_P2:7:=""
		[Asignaturas_Objetivos:104]Objetivos_P3:8:=""
		[Asignaturas_Objetivos:104]Objetivos_P4:9:=""
		[Asignaturas_Objetivos:104]Objetivos_P5:10:=""
		SAVE RECORD:C53([Asignaturas_Objetivos:104])
		KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;True:C214)
		[Asignaturas:18]ID_Objetivos:43:=[Asignaturas_Objetivos:104]ID:1
		SAVE RECORD:C53([Asignaturas:18])
		KRL_UnloadReadOnly (->[Asignaturas:18])
		modObjetivos:=True:C214
	Else 
		vObj_P1:=[Asignaturas_Objetivos:104]Objetivos_P1:6
		vObj_P2:=[Asignaturas_Objetivos:104]Objetivos_P2:7
		vObj_P3:=[Asignaturas_Objetivos:104]Objetivos_P3:8
		vObj_P4:=[Asignaturas_Objetivos:104]Objetivos_P4:9
		vObj_P5:=[Asignaturas_Objetivos:104]Objetivos_P5:10
	End if 
End if 
UNLOAD RECORD:C212([Asignaturas_Objetivos:104])
READ ONLY:C145([Asignaturas_Objetivos:104])
GOTO OBJECT:C206(*;"vObj_P"+String:C10(vlSTR_PeriodoSeleccionado))
OBJECT SET VISIBLE:C603(*;"ListaAsg@";[Asignaturas:18]ConObjetivosEspecificos:62)
OBJECT SET VISIBLE:C603(*;"vObj_P@";False:C215)
OBJECT SET VISIBLE:C603(*;"vObj_P"+String:C10(vlSTR_PeriodoSeleccionado);True:C214)

  //Objetivos por alumnos se guardan en alumnos_complemento evaluación y hay uno por periodo y uno final
C_LONGINT:C283(vl_refPestañaObjetivosActiva)
If ([Asignaturas:18]ObjetivosxAlumno:112)
	C_LONGINT:C283(hl_list_objetivos)
	APPEND TO ARRAY:C911($at_nombrePestaña;__ ("Objetivos comunes de la asignatura"))
	APPEND TO ARRAY:C911($al_IdPestaña;1)
	APPEND TO ARRAY:C911($at_nombrePestaña;__ ("Objetivos específicos por alumno"))
	APPEND TO ARRAY:C911($al_IdPestaña;2)
	OBJECT SET VISIBLE:C603(*;"vObj_P@";False:C215)
	OBJECT SET VISIBLE:C603(*;"vObj_P"+String:C10(vlSTR_PeriodoSeleccionado);True:C214)
	OBJECT SET VISIBLE:C603(*;"xALP_ObjxAlu";False:C215)
	OBJECT SET VISIBLE:C603(*;"bc_MostrarFotografias1";False:C215)
	hl_list_objetivos:=AT_Array2ReferencedList (->$at_nombrePestaña;->$al_IdPestaña;0;False:C215;True:C214)
	SELECT LIST ITEMS BY POSITION:C381(hl_list_objetivos;1)
	vl_refPestañaObjetivosActiva:=1
Else 
	vl_refPestañaObjetivosActiva:=0
	OBJECT SET VISIBLE:C603(*;"xALP_ObjxAlu";False:C215)
	OBJECT SET VISIBLE:C603(*;"bc_MostrarFotografias1";False:C215)
End if 

FORM GOTO PAGE:C247(2)