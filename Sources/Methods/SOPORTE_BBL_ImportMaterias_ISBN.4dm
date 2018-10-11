//%attributes = {}
  // SOPORTE_BBL_ImportMaterias_ISBN()
  // Por: Alberto Bachler: 17/09/13, 13:44:40
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_registro;$t_ISBN;$t_materias;$t_materia)
C_LONGINT:C283($l_recNumItem;$l_numeroPalabras;$i_palabras)
READ WRITE:C146([BBL_Items:61])
$h_refDocumento:=Open document:C264("";"TEXT";Read mode:K24:5)

RECEIVE PACKET:C104($h_refDocumento;$t_registro;"\r")
WDW_Open (300;100;0;1986;"Importando Materias en")
TRACE:C157
While ($t_registro#"")
	$t_ISBN:=ST_GetWord ($t_registro;1;"\t")
	If ($t_ISBN#"")
		$t_materias:=ST_GetWord ($t_registro;2;"\t")
		$t_materias:=Replace string:C233($t_materias;"\"";"")
		$l_recNumItem:=KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]ISBN:3;->$t_ISBN;True:C214)
		If ($l_recNumItem>=0)
			If ($t_materias#"")
				$l_numeroPalabras:=ST_CountWords ($t_materias;1;";")
				For ($i_palabras;1;$l_numeroPalabras)
					$t_materia:=ST_GetWord ($t_materias;$i_palabras;";")
					$t_materia:=ST_GetCleanString ($t_materia)
					If ($t_materia#"")
						BBLitm_AgregaMateria ([BBL_Items:61]Numero:1;$t_materia)
					End if 
				End for 
				SAVE RECORD:C53([BBL_Items:61])
			End if 
		End if 
		GOTO XY:C161(0;0)
		MESSAGE:C88("Importando materias en "+$t_ISBN+"\r"+$t_materias)
	End if 
	RECEIVE PACKET:C104($h_refDocumento;$t_registro;"\r")
End while 