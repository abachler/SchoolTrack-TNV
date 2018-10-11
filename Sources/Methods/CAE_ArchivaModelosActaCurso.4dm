//%attributes = {}
  // CAE_ArchivaModelosActaCurso
  // by: Alberto
  // 2/12/03
  // purpose:


QUERY:C277([Cursos:3];[Cursos:3]ActaEspecificaAlCurso:35=True:C214)
SELECTION TO ARRAY:C260([Cursos:3];$aRecNums)
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Cursos:3];$aRecNums{$i})
	$fatDocRef:="ActasCurso_#"+String:C10([Cursos:3]Numero_del_curso:6)+"_"+String:C10(vl_UltimoAño)
	QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$fatDocRef)
	If (Records in selection:C76([XShell_FatObjects:86])=0)
		CREATE RECORD:C68([XShell_FatObjects:86])
		[XShell_FatObjects:86]FatObjectName:1:=$fatDocRef
		[XShell_FatObjects:86]BlobObject:2:=[Cursos:3]Acta:34
		SAVE RECORD:C53([XShell_FatObjects:86])
	End if 
End for 
