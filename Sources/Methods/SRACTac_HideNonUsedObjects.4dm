//%attributes = {}
  //SRACTac_HideNonUsedObjects

vlSRP_AreaRef:=SR New Offscreen Area 
$err:=SR Set Area (vlSRP_AreaRef;xSR_ReportBlob)
If (Count parameters:C259=0)
	ARRAY LONGINT:C221($aObjectIDs;0)
	$err:=SR Get Object IDs (vlSRP_AreaRef;0;$aObjectIDs)
	For ($i;1;Size of array:C274($aObjectIDs))
		$t_nombreVariable:=SR_GetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Variable_Source)
		If (($t_nombreVariable="vEtiquetaColCta") | ($t_nombreVariable="vEtiquetaColCurso") | ($t_nombreVariable="vEtiquetaColNivel") | ($t_nombreVariable="atACT_CAlumno@") | ($t_nombreVariable="atACT_CAlumnoCurso@") | ($t_nombreVariable="atACT_CAlumnoNivelNombre@"))
			If (vb_HideColsCtas)
				SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_TextColor;"#FFFFFF")
				SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_BackColor;"#FFFFFF")
			End if 
		End if 
		If (($t_nombreVariable="vEtiquetaColAfecto") | ($t_nombreVariable="asACT_Afecto@"))
			If (vb_HideColAfecto)
				SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_TextColor;"#FFFFFF")
				SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_BackColor;"#FFFFFF")
			End if 
		End if 
	End for 
Else 
	$aviso:=$1
	ARRAY LONGINT:C221($aObjectIDs;0)
	Case of 
		: ($aviso=1)
			$section:=SR Section SubHeader1
		: ($aviso=2)
			$section:=SR Section SubHeader2
		: ($aviso=3)
			$section:=SR Section SubHeader3
		: ($aviso=4)
			$section:=SR Section SubHeader4
	End case 
	$err:=SR Get Section Object IDs (vlSRP_AreaRef;$section;$aObjectIDs)
	For ($i;1;Size of array:C274($aObjectIDs))
		SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_TextColor;"#FFFFFF")
		SR_SetTextProperty (vlSRP_AreaRef;$aObjectIDs{$i};SRP_Style_BackColor;"#FFFFFF")
	End for 
End if 
$err:=SR Get Area (vlSRP_AreaRef;xSR_ReportBlob)
SR DELETE OFFSCREEN AREA (vlSRP_AreaRef)