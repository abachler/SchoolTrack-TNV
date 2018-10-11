//%attributes = {}
C_LONGINT:C283($1;$vRow;$2;$vCol)
C_LONGINT:C283(vl_IDAlumnoseleccionadoAL;vl_rowseleccionAL)
C_TEXT:C284(vt_ObsAlumnoSeleccionadoAL)
C_TEXT:C284(vt_NombreAlumnoSeleccionadoAL)
vl_rowseleccionAL:=0
vl_IDAlumnoseleccionadoAL:=0
vt_ObsAlumnoSeleccionadoAL:=""
vt_NombreAlumnoSeleccionadoAL:=""

$vRow:=$1
$vCol:=$2

vl_rowseleccionAL:=$vRow
vl_IDAlumnoseleccionadoAL:=aNtaIDAlumno{$vRow}
vt_ObjAlumnoSeleccionadoAL:=aNtaObj{$vRow}
vt_NombreAlumnoSeleccionadoAL:="Objetivos en el "+vt_periodo+" para "+aNtaStdNme{$vRow}
vp_FotografiaAlumno:=aFotografias{$vRow}

If (bc_MostrarFotografías=1)
	If (($vRow>0) & ($vCol=5))
		WDW_OpenFormWindow (->[Asignaturas:18];"TextoObjetivos";0;8;__ ("Objetivos"))
		DIALOG:C40([Asignaturas:18];"TextoObjetivos")
		CLOSE WINDOW:C154
	End if 
Else 
	If (($vRow>0) & ($vCol=4))
		WDW_OpenFormWindow (->[Asignaturas:18];"TextoObjetivos";0;8;__ ("Objetivos"))
		DIALOG:C40([Asignaturas:18];"TextoObjetivos")
		CLOSE WINDOW:C154
	End if 
	
End if 
vp_FotografiaAlumno:=vp_FotografiaAlumno*0