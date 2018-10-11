//%attributes = {}
  //ACTAS_plpHeaders

  //If ((◊actas2000=False) | (◊gYear<2000))
  //ACTAS_plpHeaders_old 
  //Else

If (vi_PEStart>0)
	$err:=PL_SetArraysNam (pl_titles;1;4;"aTtl1";"aTtl2";"aTtl3";"aTtl4")
	PL_SetDividers (pl_Titles;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (pl_Titles;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetWidths (pl_Titles;1;3;leftmarge;PCwidth;PEwidth)
	PL_SetFormat (pl_Titles;2;"";2;0;0)
	PL_SetFormat (pl_Titles;3;"";2;0;0)
	PL_SetStyle (pl_Titles;0;"Times";6;1)
End if 

$err:=PL_SetArraysNam (pl_ActaH;1;6;"aBidon1";"aBidon2";"aBidon3";"aBidon5";"aBidon6";"aBidon7")
For ($i;1;vi_columns)
	$err:=PL_SetArraysNam (pl_actaH;$i+6;1;"aPict"+String:C10($i))
End for 
$err:=PL_SetArraysNam (pl_ActaH;vi_columns+7;1;"aBidon4")
PL_SetHeight (pl_actaH;0;0;0;4)
PL_SetFormat (pl_actaH;1;"1";2;0;1)
PL_SetFormat (pl_actaH;2;"1";2;0;1)
PL_SetFormat (pl_actaH;3;"1";2;0;1)
PL_SetFormat (pl_actaH;4;"1";2;0;1)
PL_SetFormat (pl_actaH;5;"1";2;0;1)
PL_SetFormat (pl_actaH;6;"1";2;0;1)
PL_SetWidths (pl_actaH;1;6;iNo;iNames;iRUT;iSex;iBirthDate;iComuna)
For ($i;1;vi_columns)
	PL_SetStyle (pl_actaH;$i+6;"Tahoma";9;0)  //new
	PL_SetFormat (pl_actaH;$i+6;"1";0;0;0)
	PL_SetWidths (pl_actaH;$i+6;1;colwidth)
End for 
PL_SetWidths (pl_actaH;vi_columns+7;1;obswidth)
PL_SetFormat (pl_actaH;vi_columns+7;"";2;0;1)
PL_SetHdrOpts (pl_ActaH;0;0)
PL_SetColOpts (pl_actaH;0;0)
PL_SetDividers (pl_actaH;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
PL_SetFrame (pl_actaH;1;"Black";"Black";0;0.5;"Black";"Black";0)
PL_SetStyle (pl_actaH;1;"Tahoma";5;1)
PL_SetStyle (pl_actaH;2;"Tahoma";5;1)
PL_SetStyle (pl_actaH;3;"Tahoma";5;1)
PL_SetStyle (pl_actaH;4;"Tahoma";5;1)
PL_SetStyle (pl_actaH;5;"Tahoma";5;1)
PL_SetStyle (pl_actaH;6;"Tahoma";5;1)
PL_SetStyle (pl_actaH;vi_columns+7;"Tahoma";5;1)
PL_SetRowStyle (pl_ActaH;1;1)
  //End if 