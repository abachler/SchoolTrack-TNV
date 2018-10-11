  //If (vbACT_HabilitaFlechas)
  //If (aiACT_DiaUF=0)
  //aiACT_DiaUF:=1
  //arACT_ValorUF:=1
  //End if 
  //If (aiACT_DiaUF<Size of array(aiACT_DiaUF))
  //aiACT_DiaUF:=aiACT_DiaUF+1
  //arACT_ValorUF:=arACT_ValorUF+1
  //End if 
  //$mes:=Num(ST_GetWord (atACT_UFReference{atACT_UFLabel};3;"/"))
  //$year:=Num(ST_GetWord (atACT_UFReference{atACT_UFLabel};2;"/"))
  //vdACT_FechaUFSel:=DT_GetDateFromDayMonthYear (aiACT_DiaUF{aiACT_DiaUF};$mes;$year)
  //
  //$pos:=Find in array(atACT_NombreMonedaEm;"UF")
  //If ($pos#-1)
  //arACT_ValorMonedaEm{$pos}:=ACTut_fValorDivisa ("UF";vdACT_FechaUFSel)
  //End if 
  //End if 