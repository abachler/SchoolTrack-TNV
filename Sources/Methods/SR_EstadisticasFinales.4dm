//%attributes = {}
  //SR_EstadisticasFinales

For ($i;1;12)
	  //PARA EL NIVEL 1 *********************************************************************************************
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$i;*)  //reemplazar 1 para cada nivel
	QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50#"En Trámite";*)
	QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50#"Oyente")
	  //`MATRICULA AL 30 DE ABRIL, TOTAL, MUJERES Y HOMBRES
	CREATE SET:C116([Alumnos:2];"Nivel")
	$d1:=DT_GetDateFromDayMonthYear (30;4;<>gYear)
	$d2:=DT_GetDateFromDayMonthYear (1;5;<>gYear)
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41<=$d1)
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
	QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Fecha_de_retiro:42>=$d2)
	Case of 
		: ($i=1)
			iMatDeb_N1:=Records in selection:C76([Alumnos:2])
		: ($i=2)
			iMatDeb_N2:=Records in selection:C76([Alumnos:2])
		: ($i=3)
			iMatDeb_N3:=Records in selection:C76([Alumnos:2])
		: ($i=4)
			iMatDeb_N4:=Records in selection:C76([Alumnos:2])
		: ($i=5)
			iMatDeb_N5:=Records in selection:C76([Alumnos:2])
		: ($i=6)
			iMatDeb_N6:=Records in selection:C76([Alumnos:2])
		: ($i=7)
			iMatDeb_N7:=Records in selection:C76([Alumnos:2])
		: ($i=8)
			iMatDeb_N8:=Records in selection:C76([Alumnos:2])
		: ($i=9)
			iMatDeb_N9:=Records in selection:C76([Alumnos:2])
		: ($i=10)
			iMatDeb_N10:=Records in selection:C76([Alumnos:2])
		: ($i=11)
			iMatDeb_N11:=Records in selection:C76([Alumnos:2])
		: ($i=12)
			iMatDeb_N12:=Records in selection:C76([Alumnos:2])
	End case 
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
	
	Case of 
		: ($i=1)
			iMatDebH_N1:=Records in selection:C76([Alumnos:2])
			iMatDebF_N1:=iMatDeb_N1-iMatDebH_N1
		: ($i=2)
			iMatDebH_N2:=Records in selection:C76([Alumnos:2])
			iMatDebF_N2:=iMatDeb_N2-iMatDebH_N2
		: ($i=3)
			iMatDebH_N3:=Records in selection:C76([Alumnos:2])
			iMatDebF_N3:=iMatDeb_N3-iMatDebH_N3
		: ($i=4)
			iMatDebH_N4:=Records in selection:C76([Alumnos:2])
			iMatDebF_N4:=iMatDeb_N4-iMatDebH_N4
		: ($i=5)
			iMatDebH_N5:=Records in selection:C76([Alumnos:2])
			iMatDebF_N5:=iMatDeb_N5-iMatDebH_N5
		: ($i=6)
			iMatDebH_N6:=Records in selection:C76([Alumnos:2])
			iMatDebF_N6:=iMatDeb_N6-iMatDebH_N6
		: ($i=7)
			iMatDebH_N7:=Records in selection:C76([Alumnos:2])
			iMatDebF_N7:=iMatDeb_N7-iMatDebH_N7
		: ($i=8)
			iMatDebH_N8:=Records in selection:C76([Alumnos:2])
			iMatDebF_N8:=iMatDeb_N8-iMatDebH_N8
		: ($i=9)
			iMatDebH_N9:=Records in selection:C76([Alumnos:2])
			iMatDebF_N9:=iMatDeb_N9-iMatDebH_N9
		: ($i=10)
			iMatDebH_N10:=Records in selection:C76([Alumnos:2])
			iMatDebF_N10:=iMatDeb_N10-iMatDebH_N10
		: ($i=11)
			iMatDebH_N11:=Records in selection:C76([Alumnos:2])
			iMatDebF_N11:=iMatDeb_N11-iMatDebH_N11
		: ($i=12)
			iMatDebH_N12:=Records in selection:C76([Alumnos:2])
			iMatDebF_N12:=iMatDeb_N12-iMatDebH_N12
	End case 
	  //MATRICULA FINAL, TOTAL, MUJERES Y HOMBRES
	USE SET:C118("Nivel")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="P";*)
	QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="R")
	Case of 
		: ($i=1)
			iMatfin_N1:=Records in selection:C76([Alumnos:2])
		: ($i=2)
			iMatfin_N2:=Records in selection:C76([Alumnos:2])
		: ($i=3)
			iMatfin_N3:=Records in selection:C76([Alumnos:2])
		: ($i=4)
			iMatfin_N4:=Records in selection:C76([Alumnos:2])
		: ($i=5)
			iMatfin_N5:=Records in selection:C76([Alumnos:2])
		: ($i=6)
			iMatfin_N6:=Records in selection:C76([Alumnos:2])
		: ($i=7)
			iMatfin_N7:=Records in selection:C76([Alumnos:2])
		: ($i=8)
			iMatfin_N8:=Records in selection:C76([Alumnos:2])
		: ($i=9)
			iMatfin_N9:=Records in selection:C76([Alumnos:2])
		: ($i=10)
			iMatfin_N10:=Records in selection:C76([Alumnos:2])
		: ($i=11)
			iMatfin_N11:=Records in selection:C76([Alumnos:2])
		: ($i=12)
			iMatfin_N12:=Records in selection:C76([Alumnos:2])
	End case 
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
	Case of 
		: ($i=1)
			iMatfinH_N1:=Records in selection:C76([Alumnos:2])
			iMatfinF_N1:=iMatfin_N1-iMatfinH_N1
		: ($i=2)
			iMatfinH_N2:=Records in selection:C76([Alumnos:2])
			iMatfinF_N2:=iMatfin_N2-iMatfinH_N2
		: ($i=3)
			iMatfinH_N3:=Records in selection:C76([Alumnos:2])
			iMatfinF_N3:=iMatfin_N3-iMatfinH_N3
		: ($i=4)
			iMatfinH_N4:=Records in selection:C76([Alumnos:2])
			iMatfinF_N4:=iMatfin_N4-iMatfinH_N4
		: ($i=5)
			iMatfinH_N5:=Records in selection:C76([Alumnos:2])
			iMatfinF_N5:=iMatfin_N5-iMatfinH_N5
		: ($i=6)
			iMatfinH_N6:=Records in selection:C76([Alumnos:2])
			iMatfinF_N6:=iMatfin_N6-iMatfinH_N6
		: ($i=7)
			iMatfinH_N7:=Records in selection:C76([Alumnos:2])
			iMatfinF_N7:=iMatfin_N7-iMatfinH_N7
		: ($i=8)
			iMatfinH_N8:=Records in selection:C76([Alumnos:2])
			iMatfinF_N8:=iMatfin_N8-iMatfinH_N8
		: ($i=9)
			iMatfinH_N9:=Records in selection:C76([Alumnos:2])
			iMatfinF_N9:=iMatfin_N9-iMatfinH_N9
		: ($i=10)
			iMatfinH_N10:=Records in selection:C76([Alumnos:2])
			iMatfinF_N10:=iMatfin_N10-iMatfinH_N10
		: ($i=11)
			iMatfinH_N11:=Records in selection:C76([Alumnos:2])
			iMatfinF_N11:=iMatfin_N11-iMatfinH_N11
		: ($i=12)
			iMatfinH_N12:=Records in selection:C76([Alumnos:2])
			iMatfinF_N12:=iMatfin_N12-iMatfinH_N12
	End case 
	
	  //INGRESADOS DESPUES DEL 30 DE ABRIL, TOTAL, MUJERES Y HOMBRES
	USE SET:C118("Nivel")
	$d1:=DT_GetDateFromDayMonthYear (1;5;<>gYear)
	$d2:=DT_GetDateFromDayMonthYear (29;11;<>gYear)
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_Ingreso:41>=$d1;*)
	QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Fecha_de_Ingreso:41<=$d2)
	Case of 
		: ($i=1)
			iMatYear_N1:=Records in selection:C76([Alumnos:2])
		: ($i=2)
			iMatYear_N2:=Records in selection:C76([Alumnos:2])
		: ($i=3)
			iMatYear_N3:=Records in selection:C76([Alumnos:2])
		: ($i=4)
			iMatYear_N4:=Records in selection:C76([Alumnos:2])
		: ($i=5)
			iMatYear_N5:=Records in selection:C76([Alumnos:2])
		: ($i=6)
			iMatYear_N6:=Records in selection:C76([Alumnos:2])
		: ($i=7)
			iMatYear_N7:=Records in selection:C76([Alumnos:2])
		: ($i=8)
			iMatYear_N8:=Records in selection:C76([Alumnos:2])
		: ($i=9)
			iMatYear_N9:=Records in selection:C76([Alumnos:2])
		: ($i=10)
			iMatYear_N10:=Records in selection:C76([Alumnos:2])
		: ($i=11)
			iMatYear_N11:=Records in selection:C76([Alumnos:2])
		: ($i=12)
			iMatYear_N12:=Records in selection:C76([Alumnos:2])
	End case 
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
	Case of 
		: ($i=1)
			iMatYearH_N1:=Records in selection:C76([Alumnos:2])
			iMatYearF_N1:=iMatYear_N1-iMatYearH_N1
		: ($i=2)
			iMatYearH_N2:=Records in selection:C76([Alumnos:2])
			iMatYearF_N2:=iMatYear_N2-iMatYearH_N2
		: ($i=3)
			iMatYearH_N3:=Records in selection:C76([Alumnos:2])
			iMatYearF_N3:=iMatYear_N3-iMatYearH_N3
		: ($i=4)
			iMatYearH_N4:=Records in selection:C76([Alumnos:2])
			iMatYearF_N4:=iMatYear_N4-iMatYearH_N4
		: ($i=5)
			iMatYearH_N5:=Records in selection:C76([Alumnos:2])
			iMatYearF_N5:=iMatYear_N5-iMatYearH_N5
		: ($i=6)
			iMatYearH_N6:=Records in selection:C76([Alumnos:2])
			iMatYearF_N6:=iMatYear_N6-iMatYearH_N6
		: ($i=7)
			iMatYearH_N7:=Records in selection:C76([Alumnos:2])
			iMatYearF_N7:=iMatYear_N7-iMatYearH_N7
		: ($i=8)
			iMatYearH_N8:=Records in selection:C76([Alumnos:2])
			iMatYearF_N8:=iMatYear_N8-iMatYearH_N8
		: ($i=9)
			iMatYearH_N9:=Records in selection:C76([Alumnos:2])
			iMatYearF_N9:=iMatYear_N9-iMatYearH_N9
		: ($i=10)
			iMatYearH_N10:=Records in selection:C76([Alumnos:2])
			iMatYearF_N10:=iMatYear_N10-iMatYearH_N10
		: ($i=11)
			iMatYearH_N11:=Records in selection:C76([Alumnos:2])
			iMatYearF_N11:=iMatYear_N11-iMatYearH_N11
		: ($i=12)
			iMatYearH_N12:=Records in selection:C76([Alumnos:2])
			iMatYearF_N12:=iMatYear_N12-iMatYearH_N12
	End case 
	
	  //RETIRADOS, TOTAL, MUJERES Y HOMBRES
	USE SET:C118("Nivel")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="Y")
	
	Case of 
		: ($i=1)
			iret_N1:=Records in selection:C76([Alumnos:2])
		: ($i=2)
			iret_N2:=Records in selection:C76([Alumnos:2])
		: ($i=3)
			iret_N3:=Records in selection:C76([Alumnos:2])
		: ($i=4)
			iret_N4:=Records in selection:C76([Alumnos:2])
		: ($i=5)
			iret_N5:=Records in selection:C76([Alumnos:2])
		: ($i=6)
			iret_N6:=Records in selection:C76([Alumnos:2])
		: ($i=7)
			iret_N7:=Records in selection:C76([Alumnos:2])
		: ($i=8)
			iret_N8:=Records in selection:C76([Alumnos:2])
		: ($i=9)
			iret_N9:=Records in selection:C76([Alumnos:2])
		: ($i=10)
			iret_N10:=Records in selection:C76([Alumnos:2])
		: ($i=11)
			iret_N11:=Records in selection:C76([Alumnos:2])
		: ($i=12)
			iret_N12:=Records in selection:C76([Alumnos:2])
	End case 
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
	
	Case of 
		: ($i=1)
			iretH_N1:=Records in selection:C76([Alumnos:2])
			iretF_N1:=iRet_N1-iRetH_N1
		: ($i=2)
			iretH_N2:=Records in selection:C76([Alumnos:2])
			iretF_N2:=iRet_N2-iRetH_N2
		: ($i=3)
			iretH_N3:=Records in selection:C76([Alumnos:2])
			iretF_N3:=iRet_N3-iRetH_N3
		: ($i=4)
			iretH_N4:=Records in selection:C76([Alumnos:2])
			iretF_N4:=iRet_N4-iRetH_N4
		: ($i=5)
			iretH_N5:=Records in selection:C76([Alumnos:2])
			iretF_N5:=iRet_N5-iRetH_N5
		: ($i=6)
			iretH_N6:=Records in selection:C76([Alumnos:2])
			iretF_N6:=iRet_N6-iRetH_N6
		: ($i=7)
			iretH_N7:=Records in selection:C76([Alumnos:2])
			iretF_N7:=iRet_N7-iRetH_N7
		: ($i=8)
			iretH_N8:=Records in selection:C76([Alumnos:2])
			iretF_N8:=iRet_N8-iRetH_N8
		: ($i=9)
			iretH_N9:=Records in selection:C76([Alumnos:2])
			iretF_N9:=iRet_N9-iRetH_N9
		: ($i=10)
			iretH_N10:=Records in selection:C76([Alumnos:2])
			iretF_N10:=iRet_N10-iRetH_N10
		: ($i=11)
			iretH_N11:=Records in selection:C76([Alumnos:2])
			iretF_N11:=iRet_N11-iRetH_N11
		: ($i=12)
			iretH_N12:=Records in selection:C76([Alumnos:2])
			iretF_N12:=iret_N12-iretH_N12
	End case 
	
	  //MATRICULA TOTAL FINAL, MUJERES Y HOMBRES
	USE SET:C118("Nivel")
	  //QUERY SELECTION([Alumnos];[Alumnos]Situacion_final="P";*)
	  //QUERY SELECTION([Alumnos]; | [Alumnos]Situacion_final="R";*)
	  //QUERY SELECTION([Alumnos]; | [Alumnos]Situacion_final="Y")
	$d2:=DT_GetDateFromDayMonthYear (29;11;<>gYear)
	  //QUERY SELECTION([Alumnos];[Alumnos]Fecha_de_retiro<=$d2;*)
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@")
	
	Case of 
		: ($i=1)
			iTotal_N1:=Records in selection:C76([Alumnos:2])
		: ($i=2)
			iTotal_N2:=Records in selection:C76([Alumnos:2])
		: ($i=3)
			iTotal_N3:=Records in selection:C76([Alumnos:2])
		: ($i=4)
			iTotal_N4:=Records in selection:C76([Alumnos:2])
		: ($i=5)
			iTotal_N5:=Records in selection:C76([Alumnos:2])
		: ($i=6)
			iTotal_N6:=Records in selection:C76([Alumnos:2])
		: ($i=7)
			iTotal_N7:=Records in selection:C76([Alumnos:2])
		: ($i=8)
			iTotal_N8:=Records in selection:C76([Alumnos:2])
		: ($i=9)
			iTotal_N9:=Records in selection:C76([Alumnos:2])
		: ($i=10)
			iTotal_N10:=Records in selection:C76([Alumnos:2])
		: ($i=11)
			iTotal_N11:=Records in selection:C76([Alumnos:2])
		: ($i=12)
			iTotal_N12:=Records in selection:C76([Alumnos:2])
	End case 
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
	
	Case of 
		: ($i=1)
			iTotalH_N1:=Records in selection:C76([Alumnos:2])
			iTotalF_N1:=iTotal_N1-iTotalH_N1
		: ($i=2)
			iTotalH_N2:=Records in selection:C76([Alumnos:2])
			iTotalF_N2:=iTotal_N2-iTotalH_N2
		: ($i=3)
			iTotalH_N3:=Records in selection:C76([Alumnos:2])
			iTotalF_N3:=iTotal_N3-iTotalH_N3
		: ($i=4)
			iTotalH_N4:=Records in selection:C76([Alumnos:2])
			iTotalF_N4:=iTotal_N4-iTotalH_N4
		: ($i=5)
			iTotalH_N5:=Records in selection:C76([Alumnos:2])
			iTotalF_N5:=iTotal_N5-iTotalH_N5
		: ($i=6)
			iTotalH_N6:=Records in selection:C76([Alumnos:2])
			iTotalF_N6:=iTotal_N6-iTotalH_N6
		: ($i=7)
			iTotalH_N7:=Records in selection:C76([Alumnos:2])
			iTotalF_N7:=iTotal_N7-iTotalH_N7
		: ($i=8)
			iTotalH_N8:=Records in selection:C76([Alumnos:2])
			iTotalF_N8:=iTotal_N8-iTotalH_N8
		: ($i=9)
			iTotalH_N9:=Records in selection:C76([Alumnos:2])
			iTotalF_N9:=iTotal_N9-iTotalH_N9
		: ($i=10)
			iTotalH_N10:=Records in selection:C76([Alumnos:2])
			iTotalF_N10:=iTotal_N10-iTotalH_N10
		: ($i=11)
			iTotalH_N11:=Records in selection:C76([Alumnos:2])
			iTotalF_N11:=iTotal_N11-iTotalH_N11
		: ($i=12)
			iTotalH_N12:=Records in selection:C76([Alumnos:2])
			iTotalF_N12:=iTotal_N12-iTotalH_N12
	End case 
	
	  //REPROBADOS, TOTAL, MUJERES Y HOMBRES
	USE SET:C118("Nivel")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="R")
	
	Case of 
		: ($i=1)
			iRep_N1:=Records in selection:C76([Alumnos:2])
		: ($i=2)
			iRep_N2:=Records in selection:C76([Alumnos:2])
		: ($i=3)
			iRep_N3:=Records in selection:C76([Alumnos:2])
		: ($i=4)
			iRep_N4:=Records in selection:C76([Alumnos:2])
		: ($i=5)
			iRep_N5:=Records in selection:C76([Alumnos:2])
		: ($i=6)
			iRep_N6:=Records in selection:C76([Alumnos:2])
		: ($i=7)
			iRep_N7:=Records in selection:C76([Alumnos:2])
		: ($i=8)
			iRep_N8:=Records in selection:C76([Alumnos:2])
		: ($i=9)
			iRep_N9:=Records in selection:C76([Alumnos:2])
		: ($i=10)
			iRep_N10:=Records in selection:C76([Alumnos:2])
		: ($i=11)
			iRep_N11:=Records in selection:C76([Alumnos:2])
		: ($i=12)
			iRep_N12:=Records in selection:C76([Alumnos:2])
	End case 
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
	
	Case of 
		: ($i=1)
			iRepH_N1:=Records in selection:C76([Alumnos:2])
			iRepF_N1:=iRep_N1-iRepH_N1
		: ($i=2)
			iRepH_N2:=Records in selection:C76([Alumnos:2])
			iRepF_N2:=iRep_N2-iRepH_N2
		: ($i=3)
			iRepH_N3:=Records in selection:C76([Alumnos:2])
			iRepF_N3:=iRep_N3-iRepH_N3
		: ($i=4)
			iRepH_N4:=Records in selection:C76([Alumnos:2])
			iRepF_N4:=iRep_N4-iRepH_N4
		: ($i=5)
			iRepH_N5:=Records in selection:C76([Alumnos:2])
			iRepF_N5:=iRep_N5-iRepH_N5
		: ($i=6)
			iRepH_N6:=Records in selection:C76([Alumnos:2])
			iRepF_N6:=iRep_N6-iRepH_N6
		: ($i=7)
			iRepH_N7:=Records in selection:C76([Alumnos:2])
			iRepF_N7:=iRep_N7-iRepH_N7
		: ($i=8)
			iRepH_N8:=Records in selection:C76([Alumnos:2])
			iRepF_N8:=iRep_N8-iRepH_N8
		: ($i=9)
			iRepH_N9:=Records in selection:C76([Alumnos:2])
			iRepF_N9:=iRep_N9-iRepH_N9
		: ($i=10)
			iRepH_N10:=Records in selection:C76([Alumnos:2])
			iRepF_N10:=iRep_N10-iRepH_N10
		: ($i=11)
			iRepH_N11:=Records in selection:C76([Alumnos:2])
			iRepF_N11:=iRep_N11-iRepH_N11
		: ($i=12)
			iRepH_N12:=Records in selection:C76([Alumnos:2])
			iRepF_N12:=iRep_N12-iRepH_N12
	End case 
	
	  //PROMOVIDOS, TOTAL, MUJERES Y HOMBRES
	USE SET:C118("Nivel")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="P")
	
	Case of 
		: ($i=1)
			iProm_N1:=Records in selection:C76([Alumnos:2])
		: ($i=2)
			iProm_N2:=Records in selection:C76([Alumnos:2])
		: ($i=3)
			iProm_N3:=Records in selection:C76([Alumnos:2])
		: ($i=4)
			iProm_N4:=Records in selection:C76([Alumnos:2])
		: ($i=5)
			iProm_N5:=Records in selection:C76([Alumnos:2])
		: ($i=6)
			iProm_N6:=Records in selection:C76([Alumnos:2])
		: ($i=7)
			iProm_N7:=Records in selection:C76([Alumnos:2])
		: ($i=8)
			iProm_N8:=Records in selection:C76([Alumnos:2])
		: ($i=9)
			iProm_N9:=Records in selection:C76([Alumnos:2])
		: ($i=10)
			iProm_N10:=Records in selection:C76([Alumnos:2])
		: ($i=11)
			iProm_N11:=Records in selection:C76([Alumnos:2])
		: ($i=12)
			iProm_N12:=Records in selection:C76([Alumnos:2])
	End case 
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
	
	Case of 
		: ($i=1)
			iPromH_N1:=Records in selection:C76([Alumnos:2])
			iPromF_N1:=iProm_N1-iPromH_N1
		: ($i=2)
			iPromH_N2:=Records in selection:C76([Alumnos:2])
			iPromF_N2:=iProm_N2-iPromH_N2
		: ($i=3)
			iPromH_N3:=Records in selection:C76([Alumnos:2])
			iPromF_N3:=iProm_N3-iPromH_N3
		: ($i=4)
			iPromH_N4:=Records in selection:C76([Alumnos:2])
			iPromF_N4:=iProm_N4-iPromH_N4
		: ($i=5)
			iPromH_N5:=Records in selection:C76([Alumnos:2])
			iPromF_N5:=iProm_N5-iPromH_N5
		: ($i=6)
			iPromH_N6:=Records in selection:C76([Alumnos:2])
			iPromF_N6:=iProm_N6-iPromH_N6
		: ($i=7)
			iPromH_N7:=Records in selection:C76([Alumnos:2])
			iPromF_N7:=iProm_N7-iPromH_N7
		: ($i=8)
			iPromH_N8:=Records in selection:C76([Alumnos:2])
			iPromF_N8:=iProm_N8-iPromH_N8
		: ($i=9)
			iPromH_N9:=Records in selection:C76([Alumnos:2])
			iPromF_N9:=iProm_N9-iPromH_N9
		: ($i=10)
			iPromH_N10:=Records in selection:C76([Alumnos:2])
			iPromF_N10:=iProm_N10-iPromH_N10
		: ($i=11)
			iPromH_N11:=Records in selection:C76([Alumnos:2])
			iPromF_N11:=iProm_N11-iPromH_N11
		: ($i=12)
			iPromH_N12:=Records in selection:C76([Alumnos:2])
			iPromF_N12:=iProm_N12-iPromH_N12
	End case 
	
End for 

