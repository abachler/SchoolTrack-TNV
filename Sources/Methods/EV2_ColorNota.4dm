//%attributes = {}
  // EV2_ColorNota()
  //
  //
  // creado por: Alberto Bachler Klein: 19-12-15, 13:08:08
  // -----------------------------------------------------------
C_POINTER:C301($y_Nota;$1)
C_REAL:C285($r_minimo)
C_LONGINT:C283($0)
$y_Nota:=$1

EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)

Case of 
	: (Count parameters:C259=4)
		  //$r_minimo:=$4
		  //$r_minimo:=Round($4;11)
		  //$y_Nota->:=Round($1;11)
	Else 
		  //$y_Nota->:=Round($1;11)
		$r_minimo:=Round:C94(rPctMinimum;11)
End case 
Case of 
	: ((iEvaluationMode=4) & ($y_Nota-><$r_minimo))
		$l_colorRGB:=Red:K11:4
		
	: ($y_Nota->=-2)
		$l_colorRGB:=Green:K11:9
		
	: ($y_Nota->=-1)
		$l_colorRGB:=Dark blue:K11:6
		
	: (($y_Nota-><vrNTA_MinimoEscalaReferencia) | ($y_Nota-><$r_minimo))
		$l_colorRGB:=Red:K11:4
		
	: (($y_Nota->>=vrNTA_MinimoEscalaReferencia) | ($y_Nota->>=$r_minimo))
		$l_colorRGB:=Blue:K11:7
End case 
$0:=IT_IndexColor2RGB ($l_colorRGB)
  //LISTBOX SET ROW COLOR(*;"List Box1";$i;$RGB;Listbox font color)
  //ALERT(String($0))

  //TRACE
