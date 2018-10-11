//%attributes = {}
  //ALrc_SetReportCard

  //DECLARATIONS

ARRAY INTEGER:C220(a2Int;2;0)

  //INITIALIZATION

  //MAIN CODE

vi_Lines:=ALrc_ReadNotas (vPeriodo)
vi_Lines:=vi_Lines+ALrc_ExtraCurriculares 
vi_Lines:=vi_Lines+ALrc_EvaluacionPersonal 
vi_Lines:=vi_Lines+ALrc_Conducta 

If (f1=1)
	Case of 
		: (vi_Lines>=42)
			vi_fontSize:=5
		: (vi_Lines>=38)
			vi_fontSize:=6
		: (vi_Lines>=32)
			vi_FontSize:=7
		: (vi_Lines>=28)
			vi_fontSize:=8
		Else 
			vi_fontSize:=9
	End case 
Else 
	vi_FontSize:=iFSize
End if 
