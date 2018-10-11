//%attributes = {}
  //ALsq_Hermanos

  //`xShell, Alberto Bachler
  //Metodo: Método: ALsq_Hermanos
  //Por Administrator
  //Creada el 26/03/1998, 11:40:53
  //Modificaciones:
  //  09/04/2005, 11:41:50 ABK
  //  cuadro de diálogo previo para seleccionar Mayores o menores y niveles en los que se busca


ARRAY LONGINT:C221(aLong1;0)
C_LONGINT:C283($nivelDesde;$nivelHasta)
C_LONGINT:C283($i)
_O_C_STRING:C293(1;$1;vtQRY_hermanos)
If (Count parameters:C259=1)
	vtQRY_StringParam1:=$1
	CREATE SET:C116([Alumnos:2];"$RecordSet_Table"+String:C10(Table:C252(->[Alumnos:2])))
Else 
	vtQRY_StringParam1:=""
End if 


NIV_LoadArrays 
READ ONLY:C145([xxSTR_Niveles:6])
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNivelRegular:4=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;aNivelDesde;[xxSTR_Niveles:6]Nivel:1;aNivelHasta;[xxSTR_Niveles:6]NoNivel:5;$aNumeroNivel)
aNivelDesde:=1
aNivelHasta:=Size of array:C274(aNivelHasta)

WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_HermanosMayoresMenores";-1;Movable form dialog box:K39:8;__ ("Búsqueda de Hermanos"))
DIALOG:C40([xxSTR_Constants:1];"STR_HermanosMayoresMenores")
CLOSE WINDOW:C154

If (OK=1)
	$nivel_Desde:=$aNumeroNivel{aNivelDesde}
	$nivel_Hasta:=$aNumeroNivel{aNivelHasta}
	
	
	Case of 
		: (r2_Mayores=1)
			$Process:=IT_UThermometer (1;0;__ ("Seleccionando hermanos mayores..."))
		: (r1_Menores=1)
			$Process:=IT_UThermometer (1;0;__ ("Seleccionando hermanos menores..."))
	End case 
	
	  //selección original
	If (bSearchSelection=1)
		USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(->[Alumnos:2])))
	Else 
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=$nivel_Desde;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<=$nivel_Hasta)
	End if 
	CREATE SET:C116([Alumnos:2];"Original")
	
	  //busqueda de todos los alumnos  pertenecientes a las familias a las que pertenecen los alumnos de la selección oriiginal
	If (act1_PorFamilia=1)
		SELECTION TO ARRAY:C260([Alumnos:2]Familia_Número:24;aLong1)
		QRY_QueryWithArray (->[Alumnos:2]Familia_Número:24;->aLong1)
	Else 
		SELECTION TO ARRAY:C260([Alumnos:2]Apoderado_Cuentas_Número:28;aLong1)
		QRY_QueryWithArray (->[Alumnos:2]Apoderado_Cuentas_Número:28;->aLong1)
	End if 
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>=$nivel_Desde;*)
	QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]nivel_numero:29<=$nivel_Hasta)
	If (Not:C34(IT_AltKeyIsDown ))
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0;*)
		QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]curso:20#"POST")  //para no mostrar los cursos de admissiontrack
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	End if 
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
	
	If (bExcluirOyentes=1)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Oyente")
	End if 
	
	If (bExcluirTramite=1)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"En trámite")
	End if 
	
	
	Case of 
		: (s3_Indiferente=1)
			  //todos los alumnos encontrados
		: (s1_Damas=1)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="F")
		: (s2_Varones=1)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
	End case 
	
	  //selección de los hermanos menores o mayores
	If (act1_PorFamilia=1)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aLong1;[Alumnos:2]Familia_Número:24;aLong2;[Alumnos:2]Fecha_de_nacimiento:7;aDate1)
	Else 
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aLong1;[Alumnos:2]Apoderado_Cuentas_Número:28;aLong2;[Alumnos:2]Fecha_de_nacimiento:7;aDate1)
	End if 
	Case of 
		: (r2_Mayores=1)
			AT_MultiLevelSort ("><";->aLong2;->aDate1;->aLong1)
		: (r1_Menores=1)
			AT_MultiLevelSort (">>";->aLong2;->aDate1;->aLong1)
	End case 
	
	For ($i;Size of array:C274(aLong1);2;-1)
		If (aLong2{$i}=aLong2{$i-1})
			DELETE FROM ARRAY:C228(aLong2;$i-1)
			DELETE FROM ARRAY:C228(aLong1;$i-1)
			DELETE FROM ARRAY:C228(aDate1;$i-1)
		End if 
	End for 
	
	QRY_QueryWithArray (->[Alumnos:2]numero:1;->aLong1;True:C214)
	
	
	
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>Nivel_AdmissionTrack)
	
	IT_UThermometer (-2;$Process)
	
	
	AT_Initialize (->aLong1;->aLong2;->aDate1)
	CLEAR SET:C117("Original")
	CLEAR SET:C117("Mayores")
End if 

