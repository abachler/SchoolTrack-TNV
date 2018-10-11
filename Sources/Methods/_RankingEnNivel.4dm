//%attributes = {}
  // _RankingEnNivel()
  // Por: Alberto Bachler K.: 16-06-14, 15:19:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($i;$l_nivel;$l_posicion;$l_ranking;$l_recNum;$l_registroSeleccionado)
C_REAL:C285($r_promedio;$r_ultimoValor)

ARRAY LONGINT:C221($al_recNumAlumnos;0)
ARRAY REAL:C219($ar_promedios;0)
If (False:C215)
	C_LONGINT:C283(_RankingEnCurso ;$0)
End if 


$l_recNum:=Record number:C243([Alumnos:2])
$r_promedio:=[Alumnos:2]Promedio_General_Numerico:57
$l_nivel:=[Alumnos:2]nivel_numero:29
$l_registroSeleccionado:=Selected record number:C246([Alumnos:2])
CUT NAMED SELECTION:C334([Alumnos:2];"seleccion")
QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$l_nivel)
KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos:2];$al_recNumAlumnos;[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272;$ar_promedios)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
SORT ARRAY:C229($ar_promedios;$al_recNumAlumnos;<)
ARRAY INTEGER:C220($al_Ranking;Size of array:C274($al_recNumAlumnos))
$r_ultimoValor:=0
$l_ranking:=0
For ($i;1;Size of array:C274($al_recNumAlumnos))
	If ($ar_promedios{$i}#$r_ultimoValor)
		$l_ranking:=$l_ranking+1
	End if 
	$al_Ranking{$i}:=$l_ranking
	$r_ultimoValor:=$ar_promedios{$i}
End for 
$l_posicion:=Find in array:C230($al_recNumAlumnos;$l_recNum)
If ($l_posicion>0)
	$0:=$al_Ranking{$l_posicion}
End if 
USE NAMED SELECTION:C332("seleccion")
GOTO SELECTED RECORD:C245([Alumnos:2];$l_registroSeleccionado)
