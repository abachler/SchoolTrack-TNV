  // [xShell_Dialogs].FormatManager.cargaFormatos()
  // 
  //
  // creado por: Alberto Bachler Klein: 17-02-17, 17:37:35
  // -----------------------------------------------------------



ARRAY INTEGER:C220(a2Long;2;0)
C_LONGINT:C283($i)
AL_UpdateArrays (xALP_Autoformat;0)
GET LIST ITEM:C378(hl_autoformat;Selected list items:C379(hl_autoformat);$fileRef;$text)
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$fileRef;*)
QUERY:C277([xShell_Fields:52]; & [xShell_Fields:52]FormatoNombres:15#0)
SELECTION TO ARRAY:C260([xShell_Fields:52];aLong1;[xShell_Fields:52]FormatoNombres:15;$format;[xShell_Fields:52]NombreCampo:3;$at_nombres)
ARRAY TEXT:C222(atext1;0)
ARRAY TEXT:C222(atext2;Size of array:C274($format))
For ($i;1;Size of array:C274(aText2))
	aText2{$i}:=aFormatOpts{Abs:C99(Dec:C9($format{$i})*10)}
	GOTO RECORD:C242([xShell_Fields:52];aLong1{$i})
	$t_referenciaCampo:=KRL_MakeStringAccesKey (->[xShell_Fields:52]NumeroTabla:1;->[xShell_Fields:52]NumeroCampo:2;-><>vtXS_CountryCode;-><>vtXS_Langage)
	QUERY:C277([xShell_FieldAlias:198];[xShell_FieldAlias:198]FieldRef:5=$t_referenciaCampo)
	If ([xShell_FieldAlias:198]Alias:3#"")
		APPEND TO ARRAY:C911(aText1;[xShell_FieldAlias:198]Alias:3)
	Else 
		APPEND TO ARRAY:C911(aText1;$at_nombres{$i})
	End if 
End for 
SORT ARRAY:C229(aText1;aText2;aLong1;>)
AL_UpdateArrays (xALP_Autoformat;-2)


For ($i;1;Size of array:C274(aText2))
	If ($format{$i}<0)
		AL_SetRowStyle (xALP_Autoformat;$i;2)
	Else 
		AL_SetRowStyle (xALP_Autoformat;$i;0)
	End if 
End for 

