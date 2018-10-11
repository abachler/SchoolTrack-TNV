
POST KEY:C465(Character code:C91("*");Command key mask:K16:1)

  //ARRAY INTEGER(a2Long;2;0)
  //C_LONGINT($i)
  //AL_UpdateArrays (xALP_Autoformat;0)
  //GET LIST ITEM(hl_autoformat;Selected list items(hl_autoformat);$fileRef;$text)
  //QUERY([xShell_Fields];[xShell_Fields]NumeroTabla=$fileRef;*)
  //QUERY([xShell_Fields]; & [xShell_Fields]FormatoNombres#0)
  //SELECTION TO ARRAY([xShell_Fields];aLong1;[xShell_Fields]FormatoNombres;$format;[xShell_Fields]NombreCampo;$at_nombres)
  //ARRAY TEXT(atext1;0)
  //ARRAY TEXT(atext2;Size of array($format))
  //For ($i;1;Size of array(aText2))
  //aText2{$i}:=aFormatOpts{Abs(Dec($format{$i})*10)}
  //GOTO RECORD([xShell_Fields];aLong1{$i})
  //$t_referenciaCampo:=KRL_MakeStringAccesKey (->[xShell_Fields]NumeroTabla;->[xShell_Fields]NumeroCampo;-><>vtXS_CountryCode;-><>vtXS_Langage)
  //QUERY([xShell_FieldAlias];[xShell_FieldAlias]FieldRef=$t_referenciaCampo)
  //If ([xShell_FieldAlias]Alias#"")
  //APPEND TO ARRAY(aText1;[xShell_FieldAlias]Alias)
  //Else 
  //APPEND TO ARRAY(aText1;$at_nombres{$i})
  //End if 
  //End for 
  //SORT ARRAY(aText1;aText2;aLong1;>)
AL_SetStyle (xALP_Autoformat;0;"Tahoma";11;0)
  //AL_UpdateArrays (xALP_Autoformat;-2)
