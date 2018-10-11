//%attributes = {}
  //MINEDUC_File10

If (Count parameters:C259=1)
	$folder:=$1
Else 
	$folder:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
End if 

READ ONLY:C145([Alumnos:2])
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)

QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=12;*)
QUERY:C277([Alumnos:2]; & [Cursos:3]cl_RolBaseDatos:20=<>gRolBD;*)
QUERY:C277([Alumnos:2]; & [Cursos:3]cl_CodigoTipoEnseñanza:21>=410;*)
QUERY:C277([Alumnos:2]; & [Cursos:3]cl_CodigoTipoEnseñanza:21<=861;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]Situacion_final:33="P")
ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
If (Records in selection:C76([Alumnos:2])>0)
	$rolCompleto:=ST_GetCleanString (Replace string:C233(Replace string:C233(<>gRolBD;".";"");"-";""))
	$rolBD:=Substring:C12($rolCompleto;1;Length:C16($rolCompleto)-1)
	$rolDV:=Substring:C12($rolCompleto;Length:C16($rolCompleto))
	$fileName:=$folder+"A"+$rolBD+"_10.txt"
	$fileRef:=Create document:C266($fileName;"TEXT")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando archivo Nómina alumnos para titulación (")+$rolBD+__ ("_10.txt)"))
	$numeroRegistro:=0
	While (Not:C34(End selection:C36([Alumnos:2])))
		$numeroRegistro:=$numeroRegistro+1
		If (([Alumnos:2]RUT:5="") & ([Alumnos:2]Nacionalidad:8#"Chilen@"))
			$indicadorExtranjero:="1"
			$run:=[Alumnos:2]NoPasaporte:87
			$DV:=""
		Else 
			$rut:=CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)
			If (Num:C11(Substring:C12($rut;1;1))>0)
				$dv:=$rut[[Length:C16($rut)]]
				$run:=Substring:C12($rut;1;Length:C16($rut)-1)
			Else 
				$run:="ERR"
				$dv:="ERR"
			End if 
		End if 
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
		$noRegistro:=""
		$codeTitulo:=""
		$fechaTitulo:=""
		$CodigoEspecialidad:=String:C10([Cursos:3]cl_CodigoEspecialidadTP:29)
		$CodigoEnseñanza:=String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21)
		$record:="10"+"\t"+$rolBD+"\t"+$rolDV+"\t"+$CodigoEnseñanza+"\t"+$CodigoEspecialidad+"\t"+$run+"\t"+$dv+"\t"+String:C10(<>gYear)+"\t"+$noRegistro+"\t"+$codeTitulo+"\t"+$fechaTitulo+"\t"+"\r"
		SEND PACKET:C103($fileRef;_O_Mac to Win:C463($record))
		NEXT RECORD:C51([Alumnos:2])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Alumnos:2])/Records in selection:C76([Alumnos:2]);__ ("Generando archivo Nómina alumnos para titulación (")+$rolBD+__ ("_10.txt)"))
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CLOSE DOCUMENT:C267($fileref)
End if 