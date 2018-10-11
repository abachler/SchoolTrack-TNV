//%attributes = {}
  //dbuSTR_GeneraBoletinSubvencione

  //xlsdt:XC_LONGINT($records;$days)
C_LONGINT:C283($records;$days)
$t:="\t"
$monthTxt:=CD_Request (__ ("Número del mes:");__ ("Aceptar");__ ("");__ (""))
$month:=Num:C11($monthTxt)
If (($month>0) & ($month<13))
	$d1:=DT_GetDateFromDayMonthYear (1;$month;<>gYear)
	$last:=DT_GetLastDay ($month;<>gYear)
	$d2:=DT_GetDateFromDayMonthYear ($last;$month;<>gYear)
	SET QUERY DESTINATION:C396(3;$records)
	$m1:=Milliseconds:C459
	
	$text:=""
	  //por cada nivel
	For ($i;1;12)
		  //numero de cursos en el nivel
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$i)
		$text:=$text+String:C10($records;"00")+$t
		
		  //matricula en el nivel
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$i;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50="Activo")
		$text:=$text+$t+String:C10($records;"000")+$t
		
		  //Alumnos nuevos (altas)
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$i;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50="Activo";*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Fecha_de_Ingreso:41>=$d1)
		$text:=$text+String:C10($records;"000")+$t
		
		  //alumnos retirados(bajas)
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$i;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50="Activo";*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Fecha_de_retiro:42>=$d1;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Fecha_de_retiro:42<=$d2)
		$text:=$text+String:C10($records;"000")+$t
		
		  //inasistencias en el nivel
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos:2]nivel_numero:29=$i;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos:2]Status:50="Activo";*)
		QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1>=$d1;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=$d2)
		$text:=$text+$t+String:C10($records;"00000")+$t
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		  //numero de dias trabajados
		QUERY:C277([xShell_Feriados:71];[xShell_Feriados:71]Fecha:1>=$d1;*)
		QUERY:C277([xShell_Feriados:71];[xShell_Feriados:71]Fecha:1<=$d2)
		$days:=$d2-$d1-$records
		$text:=$text+String:C10($days;"00000")+$t
	End for 
	
	$text:=Substring:C12($text;1;Length:C16($text)-1)
	
	$ref:=Create document:C266("Boletin Inasistencia "+<>atXS_MonthNames{$Month}+".txt")
	SEND PACKET:C103($ref;$text)
	CLOSE DOCUMENT:C267($ref)
	
	$m:=Milliseconds:C459-$m1
	CD_Dlog (0;__ ("El documento ")+document+__ (" fue generado en ")+String:C10($m/1000)+__ (" segundos."))
Else 
	CD_Dlog (0;__ ("Mes incorrecto."))
End if 