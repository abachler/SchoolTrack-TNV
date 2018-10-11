//%attributes = {}
  //xALP_CB_XSAutoFormat

C_BOOLEAN:C305($0;$b_ok)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($row;$col)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	  //If (vl_TestEntryMethod=1)
	  //vl_TestEntryMethod:=vl_TestEntryMethod+1
	If (AL_GetCellMod (xALP_Autoformat)=1)
		AL_GetCurrCell (xALP_Autoformat;$col;$row)
		READ WRITE:C146([xShell_Fields:52])
		GOTO RECORD:C242([xShell_Fields:52];aLong1{$row})
		If (Abs:C99(Int:C8([xShell_Fields:52]FormatoNombres:15))>0)
			$method:=Find in array:C230(aFormatOpts;aText2{$row})/10
			$r:=CD_Dlog (0;__ ("¿Desea aplicar esta modificación a las informaciones existentes?");__ ("");__ ("Sí");__ ("No");__ ("Cancelar"))
			Case of 
				: ($r=1)  //yes
					[xShell_Fields:52]FormatoNombres:15:=1+$method
					SAVE RECORD:C53([xShell_Fields:52])
					$b_ok:=ST_ApplyFormat2Selection ([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2;[xShell_Fields:52]FormatoNombres:15)
					UNLOAD RECORD:C212([xShell_Fields:52])
					If (Not:C34($b_ok))  //MONO 213762
						aText2{$row}:=aText2{0}
					End if 
				: ($r=2)  //No
					[xShell_Fields:52]FormatoNombres:15:=1+$method
					SAVE RECORD:C53([xShell_Fields:52])
				: ($r=3)  //cancelar
					aText2{$row}:=aText2{0}
			End case 
		End if 
		UNLOAD RECORD:C212([xShell_Fields:52])
	End if 
	  //Else 
	  //vl_TestEntryMethod:=1
	  //End if 
End if 
