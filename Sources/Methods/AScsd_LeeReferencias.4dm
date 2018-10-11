//%attributes = {}
  // MÄTODO: AScsd_LeeReferencias
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creaciÑn: 23/03/12, 16:11:39
  // ----------------------------------------------------
  // DESCRIPCI”N
  // Lee las referencias de consolidaciÑn en asignaturas madres de la asignatura cuyo ID es pasado en $1
  // Si se especifica el parametro $2, solo se lee la referencia de consolidaciÑn en ese perÕodo
  //
  // PAR?METROS
  // AScsd_LeeReferencias(ID_madre{;NumeroPeriodo})
  // ----------------------------------------------------
C_LONGINT:C283($1;$l_idAsignaturaConsolidable;$2;$l_periodo)
$l_idAsignaturaConsolidable:=$1
$l_periodo:=0

Case of 
	: (Count parameters:C259=2)
		$l_Periodo:=$2
End case 


  // CODIGO PRINCIPAL
CREATE EMPTY SET:C140([Asignaturas_Consolidantes:231];"$ancestros")


READ ONLY:C145([Asignaturas_Consolidantes:231])
QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;$l_idAsignaturaConsolidable)
Case of 
	: ($l_periodo=-1)
		
	: ($l_periodo>0)
		QUERY SELECTION:C341([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]Periodo:3;=;String:C10($l_periodo);*)
		QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | ;[Asignaturas_Consolidantes:231]Periodo:3="";*)
		QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | ;[Asignaturas_Consolidantes:231]Periodo:3="0")
	Else 
		QUERY SELECTION:C341([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]Periodo:3="";*)
		QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | [Asignaturas_Consolidantes:231]Periodo:3="0")
End case 


  //ABK 20130618 NUEVO CODIGO
  // codigo nuevo para consolidaciÑn multiple
  // hay que mejorarlo para que tome todo el arbol de ascendencia si la asignatura es nieta, bisnieta, etc
If (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
	CREATE SET:C116([Asignaturas_Consolidantes:231];"$ancestros")
	SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231];$al_recNumAncestros)
	ARRAY LONGINT:C221($al_RecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Consolidantes:231];$al_RecNums;"")
	For ($i_registros;1;Size of array:C274($al_RecNums))
		GOTO RECORD:C242([Asignaturas_Consolidantes:231];$al_RecNums{$i_registros})
		While (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
			QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1)
			If ($l_periodo>0)
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]Periodo:3;=;String:C10($l_periodo);*)
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | ;[Asignaturas_Consolidantes:231]Periodo:3="";*)
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | ;[Asignaturas_Consolidantes:231]Periodo:3="0")
			Else 
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]Periodo:3="";*)
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | [Asignaturas_Consolidantes:231]Periodo:3="0")
			End if 
			If (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
				CREATE SET:C116([Asignaturas_Consolidantes:231];"$l_masAncestros")
				UNION:C120("$l_masAncestros";"$ancestros";"$ancestros")
			End if 
		End while 
	End for 
End if 
  //.NUEVO CODIGO

USE SET:C118("$ancestros")
CLEAR SET:C117("$ancestros")

