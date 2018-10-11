//%attributes = {}
  // ACTAS_Ajustes_y_Orden()
  // Por: Alberto Bachler K.: 01-03-14, 12:34:54
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($i_filas;$l_año;$l_electivas;$l_finElectivas;$l_finNoPromediables;$l_idxSituacionFinal;$l_inicioElectivas;$l_inicioNoPromediables;$l_nivel;$l_noPromediable)
C_LONGINT:C283($l_total;$l_totalColumnas;$l_totalElectivas;$l_totalPlanComun;$l_antesReligion;$l_reli)
C_TEXT:C284($t_rel)
C_BOOLEAN:C305($b_agregarRel)

If (False:C215)
	C_LONGINT:C283(ACTAS_Ajustes_y_Orden ;$1)
	C_LONGINT:C283(ACTAS_Ajustes_y_Orden ;$2)
End if 

$l_nivel:=$1
$l_año:=<>gYear
If (Count parameters:C259=2)
	$l_año:=$2
End if 


SORT ARRAY:C229(alActas_ColumnNumber;atActas_Subsectores;>)

For ($i_filas;Size of array:C274(atActas_Subsectores);2;-1)
	If (atActas_Subsectores{$i_filas}=atActas_Subsectores{$i_filas-1})
		AT_Delete ($i_filas;1;->atActas_Subsectores;->alActas_ColumnNumber)
	End if 
End for 

ARRAY LONGINT:C221($al_esElectiva;Size of array:C274(atActas_Subsectores))
ARRAY LONGINT:C221($al_esNoPromediable;Size of array:C274(atActas_Subsectores))
For ($i_filas;Size of array:C274(atActas_Subsectores);1;-1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_total)
	If ($l_año<<>gYear)
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Nivel:4=$l_nivel;*)
		QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Asignatura:2=atActas_Subsectores{$i_filas})
	Else 
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivel;*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas})
	End if 
	
	If ($l_total=0)
		AT_Delete ($i_filas;1;->atActas_Subsectores;->alActas_ColumnNumber;->$al_esElectiva;->$al_esNoPromediable)
	Else 
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_electivas)
		If ($l_año<<>gYear)
			QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Nivel:4=$l_nivel;*)
			QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Asignatura:2=atActas_Subsectores{$i_filas};*)
			QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Electiva:10=True:C214;*)
			QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Promediable:6=True:C214)
		Else 
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivel;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Electiva:11=True:C214;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Incide_en_promedio:27=True:C214)
		End if 
		If ($l_total=$l_electivas)
			$al_esElectiva{$i_filas}:=1
		Else 
			$al_esElectiva{$i_filas}:=0
		End if 
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_noPromediable)
		If ($l_año<<>gYear)
			QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Nivel:4=$l_nivel;*)
			QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Asignatura:2=atActas_Subsectores{$i_filas};*)
			QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Optativa:24=True:C214;*)
			QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Promediable:6=True:C214)
		Else 
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$l_nivel;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Asignatura:3=atActas_Subsectores{$i_filas};*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Incide_en_promedio:27=False:C215;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Es_Optativa:70=True:C214)
		End if 
		If ($l_total=$l_noPromediable)
			$al_esNoPromediable{$i_filas}:=1
		Else 
			$al_esNoPromediable{$i_filas}:=0
		End if 
	End if 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End for 

AT_MultiLevelSort (">>>";->$al_esNoPromediable;->$al_esElectiva;->alActas_ColumnNumber;->atActas_Subsectores)
For ($i_filas;1;Size of array:C274(alActas_ColumnNumber))
	alActas_ColumnNumber{$i_filas}:=$i_filas
End for 

$l_totalColumnas:=Size of array:C274(atActas_Subsectores)
$l_inicioElectivas:=Find in array:C230($al_esElectiva;1)
$l_inicioNoPromediables:=Find in array:C230($al_esNoPromediable;1)

If ($l_inicioElectivas>0)
	$l_totalElectivas:=Choose:C955($l_inicioNoPromediables>0;$l_inicioNoPromediables-$l_inicioElectivas+1;$l_totalColumnas-$l_inicioElectivas+1)
	$l_finElectivas:=Choose:C955($l_inicioNoPromediables>0;$l_inicioNoPromediables-1;Size of array:C274(atActas_Subsectores))
Else 
	$l_inicioElectivas:=0
End if 
$l_totalPlanComun:=$l_totalColumnas-$l_totalElectivas


  // Modificado por: Alexis Bustamante (08/08/2017)
  //186700
  //agrego variable para que ninguna aisgnatura que sea distinto de religion quede debajo de promedio final
  //$l_reli:=Find in array(atActas_Subsectores;"Religión")
  //If ($l_reli=-1)
  //$l_inicioNoPromediables:=Size of array(atActas_Subsectores)
  //Else 
  //DELETE FROM ARRAY(atActas_Subsectores;$l_reli)
  //DELETE FROM ARRAY(alActas_ColumnNumber;$l_reli)
  //DELETE FROM ARRAY($al_esElectiva;$l_reli)
  //DELETE FROM ARRAY($al_esNoPromediable;$l_reli)
  //$l_inicioNoPromediables:=Size of array(atActas_Subsectores)+1
  //End if 

  //20171108 ASM Ticket 192334  
$l_reli:=Find in array:C230(atActas_Subsectores;"Religión")
If ($l_reli#-1)
	DELETE FROM ARRAY:C228(atActas_Subsectores;$l_reli)
	DELETE FROM ARRAY:C228(alActas_ColumnNumber;$l_reli)
	DELETE FROM ARRAY:C228($al_esElectiva;$l_reli)
	DELETE FROM ARRAY:C228($al_esNoPromediable;$l_reli)
End if 
$l_inicioNoPromediables:=Size of array:C274(atActas_Subsectores)+1

$l_finNoPromediables:=Size of array:C274(atActas_Subsectores)
AT_Insert ($l_inicioNoPromediables;1;->atActas_Subsectores;->alActas_ColumnNumber;->$al_esElectiva;->$al_esNoPromediable)
atActas_Subsectores{$l_inicioNoPromediables}:="Promedio Final"
alActas_ColumnNumber{$l_inicioNoPromediables}:=$l_inicioNoPromediables
  ////MONO TICKET 205611
  //$t_rel:="Religión"
  //If (Find in field([Asignaturas]Asignatura;$t_rel)#-1)
  //$b_agregarRel:=True
  //End if 
  //If ($b_agregarRel)
$l_inicioNoPromediables:=$l_inicioNoPromediables+1
AT_Insert ($l_inicioNoPromediables;1;->atActas_Subsectores;->alActas_ColumnNumber;->$al_esElectiva;->$al_esNoPromediable)
atActas_Subsectores{Size of array:C274(atActas_Subsectores)}:="Religión"
  //End if 
  /////ABC

APPEND TO ARRAY:C911(atActas_Subsectores;"Porcentaje de asistencia")
APPEND TO ARRAY:C911(alActas_ColumnNumber;Size of array:C274(atActas_Subsectores))
APPEND TO ARRAY:C911($al_esElectiva;0)
APPEND TO ARRAY:C911($al_esNoPromediable;0)

APPEND TO ARRAY:C911(atActas_Subsectores;"Situación Final")
APPEND TO ARRAY:C911(alActas_ColumnNumber;Size of array:C274(atActas_Subsectores))
APPEND TO ARRAY:C911($al_esElectiva;0)
APPEND TO ARRAY:C911($al_esNoPromediable;0)

For ($i_filas;1;Size of array:C274(alActas_ColumnNumber))
	alActas_ColumnNumber{$i_filas}:=$i_filas
End for 

vi_columns:=Size of array:C274(alActas_ColumnNumber)
vi_PCStart:=1
vi_PCEnd:=$l_totalPlanComun
vi_PEStart:=$l_inicioElectivas
vi_PEEnd:=$l_finElectivas

COPY ARRAY:C226(atActas_Subsectores;atActas_SubsectoresCertif)
$l_idxSituacionFinal:=Find in array:C230(atActas_SubsectoresCertif;"Situación Final")
If ($l_idxSituacionFinal>0)
	DELETE FROM ARRAY:C228(atActas_SubsectoresCertif;$l_idxSituacionFinal)
End if 




