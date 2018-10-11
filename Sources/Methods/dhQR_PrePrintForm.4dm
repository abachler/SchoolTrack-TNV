//%attributes = {}
  //dhQR_PrePrintForm

Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Cursos:3]))
				ARRAY LONGINT:C221($aLongint;0)
				ARRAY INTEGER:C220(aLines;0)
				$err:=AL_GetSelect (xALP_StdList;aLines)
				If (Size of array:C274(aLines)>0)
					<>bActas_PrintSelected:=True:C214
					AT_DimArrays (Size of array:C274(aLines);->$aLongint)
					For ($i;1;Size of array:C274(aLines))
						$aLongint{$i}:=<>aStdId{aLines{$i}}
					End for 
					SET QUERY DESTINATION:C396(Into named selection:K19:3;"◊Actas")
					QRY_QueryWithArray (->[Alumnos:2]numero:1;->$aLongint)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					
				Else 
					<>bActas_PrintSelected:=False:C215
				End if 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				If (FORM Get current page:C276=10)
					<>icrtfYear:=vl_Year_Historico
				Else 
					<>icrtfYear:=<>gYear
				End if 
		End case 
End case 