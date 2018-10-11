//%attributes = {}
  // ACTAS_ConfiguraFormCertificado()
  // Por: Alberto Bachler K.: 26-02-14, 18:01:12
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_TEXT:C284(sFinalSit)

Case of 
	: (<>aYears{<>aYears}>=2002)
		OBJECT SET VISIBLE:C603(*;"Old@";False:C215)
		OBJECT SET VISIBLE:C603(*;"New@";True:C214)
	: ((([xxSTR_Niveles:6]NoNivel:5<=6) | ([xxSTR_Niveles:6]NoNivel:5=7) | ([xxSTR_Niveles:6]NoNivel:5=10) | ([xxSTR_Niveles:6]NoNivel:5=11)) & (<>aYears{<>aYears}>=2001))
		OBJECT SET VISIBLE:C603(*;"Old@";False:C215)
		OBJECT SET VISIBLE:C603(*;"New@";True:C214)
	: ((([xxSTR_Niveles:6]NoNivel:5<=6) | ([xxSTR_Niveles:6]NoNivel:5=10) | ([xxSTR_Niveles:6]NoNivel:5=10)) & (<>aYears{<>aYears}>=2000))
		OBJECT SET VISIBLE:C603(*;"Old@";False:C215)
		OBJECT SET VISIBLE:C603(*;"New@";True:C214)
	: ((([xxSTR_Niveles:6]NoNivel:5<=5) | ([xxSTR_Niveles:6]NoNivel:5=9)) & (<>aYears{<>aYears}>=1999))
		OBJECT SET VISIBLE:C603(*;"Old@";False:C215)
		OBJECT SET VISIBLE:C603(*;"New@";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"Old@";True:C214)
		OBJECT SET VISIBLE:C603(*;"New@";False:C215)
End case 

ARRAY POINTER:C280(aCertParts;7)

lastYear:=<>aYears
aCertParts{1}:=->vCert1
aCertParts{2}:=->vCert2
aCertParts{3}:=->vCert3
aCertParts{4}:=->vCert4
aCertParts{5}:=->vCert5
aCertParts{6}:=->vCert6
aCertParts{7}:=->xALP_Certificado

If (vCert1="")
	vCert1:=__ ("CERTIFICADO ANUAL DE ESTUDIOS")
	vFont1:="Tahoma"
	vSize1:=14
	vStyle1:=1
End if 
If (vCert2="")
	vCert2:=<>gCustom
	vFont2:="Tahoma"
	vSize2:=14
	vStyle2:=1
End if 

If (vCert3="")
	If (([xxSTR_Niveles:6]NoNivel:5>=1) & ([xxSTR_Niveles:6]NoNivel:5<=8))
		vCert3:="ENSEÑANZA BASICA"
	Else 
		vCert3:="ENSEÑANZA MEDIA"
	End if 
	vFont3:="Arial"
	vSize3:=12
	vStyle3:=0
End if 
If (vCert4="")
	Case of 
		: (<>aYears{<>aYears}>=2002)
			vCert4:=__ ("Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, según Resolución Exenta de Educación Nº ^0, Rol Base de Datos Nº ^1, otorga el presente certificado de calificaciones anuales y situación final a:")
			vCert4:=Replace string:C233(vCert4;"^0";<>gDecCoop)
			vCert4:=Replace string:C233(vCert4;"^1";<>gRolBD)
		: ((([xxSTR_Niveles:6]NoNivel:5<=6) | ([xxSTR_Niveles:6]NoNivel:5=10) | ([xxSTR_Niveles:6]NoNivel:5=10) | ([xxSTR_Niveles:6]NoNivel:5=11)) & (<>aYears{<>aYears}>=2001))
			vCert4:=__ ("Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, según Resolución Exenta de Educación Nº ^0, Rol Base de Datos Nº ^1, otorga el presente certificado de calificaciones anuales y situación final a:")
			vCert4:=Replace string:C233(vCert4;"^0";<>gDecCoop)
			vCert4:=Replace string:C233(vCert4;"^1";<>gRolBD)
		: ((([xxSTR_Niveles:6]NoNivel:5<=6) | ([xxSTR_Niveles:6]NoNivel:5=9) | ([xxSTR_Niveles:6]NoNivel:5=10)) & (<>gYear>=2000))
			vCert4:=__ ("Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, según Resolución Exenta de Educación Nº ^0, Rol Base de Datos Nº ^1, otorga el presente certificado de calificaciones anuales y situación final a:")
			vCert4:=Replace string:C233(vCert4;"^0";<>gDecCoop)
			vCert4:=Replace string:C233(vCert4;"^1";<>gRolBD)
		: ((([xxSTR_Niveles:6]NoNivel:5<=5) | ([xxSTR_Niveles:6]NoNivel:5=9)) & (<>gYear>=1999))
			vCert4:=__ ("Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, según Resolución Exenta de Educación Nº ^0, Rol Base de Datos Nº ^1, otorga el presente certificado de calificaciones anuales y situación final a:")
			vCert4:=Replace string:C233(vCert4;"^0";<>gDecCoop)
			vCert4:=Replace string:C233(vCert4;"^1";<>gRolBD)
		: ([xxSTR_Niveles:6]NoNivel:5<=8)
			vCert4:=__ ("- Decreto Exento de Educación que reglamenta la Evaluación y Promoción de Alumnos º ^0\r- Decreto Exento que aprueba Plan y Programas de Estudio Nº ^1\r- Resolución Exenta que lo declara Cooperador de la Función Educacional del Estado Nº ^2")
			vCert4:=Replace string:C233(vCert4;"^0";<>gDecEval)
			vCert4:=Replace string:C233(vCert4;"^1";"4002 de 1980")
			vCert4:=Replace string:C233(vCert4;"^2";"146 de 1988")
		: ([xxSTR_Niveles:6]NoNivel:5<=12)
			vCert4:=__ ("- Decreto Exento de Educación que reglamenta la Evaluación y Promoción de Alumnos º ^0\r- Decreto Exento que aprueba Plan y Programas de Estudio Nº ^1\r- Resolución Exenta que lo declara Cooperador de la Función Educacional del Estado Nº ^2")
			vCert4:=Replace string:C233(vCert4;"^0";<>gDecEval)
			vCert4:=Replace string:C233(vCert4;"^1";"300 de 1981")
			vCert4:=Replace string:C233(vCert4;"^2";"146 de 1988")
	End case 
	vFont4:="Arial"
	vSize4:=9
	vStyle4:=0
End if 
If (vCert5="")
	If ((([xxSTR_Niveles:6]NoNivel:5<=6) | ([xxSTR_Niveles:6]NoNivel:5=9) | ([xxSTR_Niveles:6]NoNivel:5=10) | ([xxSTR_Niveles:6]NoNivel:5=11)) & (<>gYear>=1999))
		vCert5:=__ ("de acuerdo al Plan de Estudios aprobado por Decreto Exento Nº ^0 y del Reglamento de Evaluación y Promoción Escolar Decreto Exento Nº ^1")
		Case of 
			: ([xxSTR_Niveles:6]NoNivel:5<=2)
				vCert5:=Replace string:C233(vCert5;"^0";"545 del año 1996")
				vCert5:=Replace string:C233(vCert5;"^1";"511 del año 1997")
			: ([xxSTR_Niveles:6]NoNivel:5<=4)
				vCert5:=Replace string:C233(vCert5;"^0";"552 del año 1997")
				vCert5:=Replace string:C233(vCert5;"^1";"511 del año 1997")
			: ([xxSTR_Niveles:6]NoNivel:5=5)
				vCert5:=Replace string:C233(vCert5;"^0";"220 del año 1999")
				vCert5:=Replace string:C233(vCert5;"^1";"511 del año 1997")
			: ([xxSTR_Niveles:6]NoNivel:5=5)
				vCert5:=Replace string:C233(vCert5;"^0";"220 del año 1999")
				vCert5:=Replace string:C233(vCert5;"^1";"511 del año 1997")
			: ([xxSTR_Niveles:6]NoNivel:5=9)
				vCert5:=Replace string:C233(vCert5;"^0";"77 del año 1999")
				vCert5:=Replace string:C233(vCert5;"^1";"112 del año 1999")
			: ([xxSTR_Niveles:6]NoNivel:5=10)
				vCert5:=Replace string:C233(vCert5;"^0";"77 del año 1999")
				vCert5:=Replace string:C233(vCert5;"^1";"112 del año 1999")
		End case 
	Else 
		vCert5:=__ ("ha obtenido, de acuerdo a las dispocisiones reglamentarias vigentes, las siguientes calificaciones:")
	End if 
	vFont5:="Arial"
	vSize5:=10
	vStyle5:=0
End if 
If (vCert6="")
	If (<>gRector#"")
		vCert6:=<>gRector+"\r"+"Director(a)"
	End if 
	vFont6:="Arial"
	vSize6:=10
	vStyle6:=1
End if 


sTitulo:="Doña"
sStudent:="Claudia Andrea Montijo de la Fuente"
sSex:="alumna de "

  //ABC192542 
  //Agrego arreglo AL_orden
  //cada vez que se carga el form se limpia.
ARRAY LONGINT:C221(al_Orden;0)
ARRAY LONGINT:C221(da_return;0)

  //Primero Verifico si Religion se repite y las elimino del arreglo.
atActas_SubsectoresCertif{0}:="Religion"
AT_SearchArray (->atActas_SubsectoresCertif;"=";->DA_return)
If (Size of array:C274(DA_return)>1)
	For ($i;1;Size of array:C274(DA_return))
		If ($i#1)
			DELETE FROM ARRAY:C228(atActas_SubsectoresCertif;DA_return{$i})
		End if 
	End for 
End if 
  //Luego redimensiono arrelgos parelelo de despliegue
AT_Insert (1;Size of array:C274(atActas_SubsectoresCertif);->atActas_CertNotas_Cifras;->atActas_NotasCertif_Letras;->al_Orden)

Case of 
	: (<>aYears{<>aYears}>=2002)
		sClass:="RUN Nº 12.074.423-1, de "+GetGrado ([xxSTR_Niveles:6]NoNivel:5)+", "
	: ((([xxSTR_Niveles:6]NoNivel:5<=6) | ([xxSTR_Niveles:6]NoNivel:5=10) | ([xxSTR_Niveles:6]NoNivel:5=10) | ([xxSTR_Niveles:6]NoNivel:5=11)) & (<>aYears{<>aYears}>=2001))
		sClass:="RUN Nº 12.074.423-1, de "+GetGrado ([xxSTR_Niveles:6]NoNivel:5)+", "
	: ((([xxSTR_Niveles:6]NoNivel:5<=6) | ([xxSTR_Niveles:6]NoNivel:5=10) | ([xxSTR_Niveles:6]NoNivel:5=10)) & (<>aYears{<>aYears}>=2000))
		sClass:="RUN Nº 12.074.423-1, de "+GetGrado ([xxSTR_Niveles:6]NoNivel:5)+", "
	: ((([xxSTR_Niveles:6]NoNivel:5<=5) | ([xxSTR_Niveles:6]NoNivel:5=9)) & (<>aYears{<>aYears}>=1999))
		sClass:="RUN Nº 12.074.423-1, de "+GetGrado ([xxSTR_Niveles:6]NoNivel:5)+", "
	Else 
		sClass:=GetGrado ([xxSTR_Niveles:6]NoNivel:5)+", "
End case 

vCertDate:=<>gCiudad+", "+String:C10(Current date:C33;5)
sFinalSit:=""
If (sFinalSit="")
	If ([xxSTR_Niveles:6]NoNivel:5=12)
		sFinalSit:="obtiene Licencia de Educación Media"
	Else 
		$el:=Find in array:C230(<>al_NumeroNivelesOficiales;[xxSTR_Niveles:6]NoNivel:5)
		If ($el>0)
			If (($el+1)>Size of array:C274(<>at_NombreNivelesOficiales))
				$el:=Find in array:C230(<>aNivNo;[xxSTR_Niveles:6]NoNivel:5)
				sFinalSit:="es promovido(a) a "+<>aNivel{$el+1}+"."
			Else 
				sFinalSit:="es promovido(a) a "+<>at_NombreNivelesOficiales{$el+1}+"."
			End if 
		Else 
			sFinalSit:=""
		End if 
	End if 
End if 


ALP_RemoveAllArrays (xALP_Certificado)
  //Configuration commands for ALP object 'xALP_Certificado'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

If (Size of array:C274(atActas_CertNotas_Cifras)=0)
	ARRAY TEXT:C222(atActas_CertNotas_Cifras;Size of array:C274(atActas_SubsectoresCertif))
End if 
If (Size of array:C274(atActas_NotasCertif_Letras)=0)
	ARRAY TEXT:C222(atActas_NotasCertif_Letras;Size of array:C274(atActas_SubsectoresCertif))
End if 

  //specify arrays to display
$Error:=AL_SetArraysNam (xALP_Certificado;1;1;"atActas_SubsectoresCertif")
$Error:=AL_SetArraysNam (xALP_Certificado;2;1;"atActas_CertNotas_Cifras")
$Error:=AL_SetArraysNam (xALP_Certificado;3;1;"atActas_NotasCertif_Letras")
$Error:=AL_SetArraysNam (xALP_Certificado;4;1;"al_Orden")

  //column 1 settings
AL_SetHeaders (xALP_Certificado;1;1;"Column 1")
AL_SetWidths (xALP_Certificado;1;1;300)
AL_SetFormat (xALP_Certificado;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Certificado;1;"Geneva";9;1)
AL_SetFtrStyle (xALP_Certificado;1;"Geneva";9;0)
AL_SetStyle (xALP_Certificado;1;"Geneva";9;0)
AL_SetForeColor (xALP_Certificado;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Certificado;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Certificado;1;1)
AL_SetEntryCtls (xALP_Certificado;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Certificado;2;1;"Column 2")
AL_SetWidths (xALP_Certificado;2;1;60)
AL_SetFormat (xALP_Certificado;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Certificado;2;"Geneva";9;1)
AL_SetFtrStyle (xALP_Certificado;2;"Geneva";9;0)
AL_SetStyle (xALP_Certificado;2;"Geneva";9;0)
AL_SetForeColor (xALP_Certificado;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Certificado;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Certificado;2;1)
AL_SetEntryCtls (xALP_Certificado;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Certificado;3;1;"Column 3")
AL_SetWidths (xALP_Certificado;3;1;141)
AL_SetFormat (xALP_Certificado;3;"";0;0;0;0)
AL_SetHdrStyle (xALP_Certificado;3;"Geneva";9;1)
AL_SetFtrStyle (xALP_Certificado;3;"Geneva";9;0)
AL_SetStyle (xALP_Certificado;3;"Geneva";9;0)
AL_SetForeColor (xALP_Certificado;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Certificado;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Certificado;3;1)
AL_SetEntryCtls (xALP_Certificado;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Certificado;4;1;"Column 4")
AL_SetFormat (xALP_Certificado;4;"";0;0;0;0)
AL_SetHdrStyle (xALP_Certificado;4;"Geneva";9;1)
AL_SetFtrStyle (xALP_Certificado;4;"Geneva";9;0)
AL_SetStyle (xALP_Certificado;4;"Geneva";9;0)
AL_SetForeColor (xALP_Certificado;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Certificado;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Certificado;4;1)
AL_SetEntryCtls (xALP_Certificado;4;0)

  //general options

AL_SetColOpts (xALP_Certificado;0;0;0;1;0)
AL_SetRowOpts (xALP_Certificado;0;1;0;0;1;0)
AL_SetCellOpts (xALP_Certificado;0;1;1)
AL_SetMiscOpts (xALP_Certificado;1;0;"\\";0;1)
AL_SetMiscColor (xALP_Certificado;0;"White";0)
AL_SetMiscColor (xALP_Certificado;1;"White";0)
AL_SetMiscColor (xALP_Certificado;2;"White";0)
AL_SetMiscColor (xALP_Certificado;3;"White";0)
AL_SetMainCalls (xALP_Certificado;"";"")
AL_SetScroll (xALP_Certificado;0;-3)
AL_SetCopyOpts (xALP_Certificado;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_Certificado;0;0;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_Certificado;1;0;0;0;0;".")
AL_SetHeight (xALP_Certificado;1;2;1;1;2)
AL_SetDividers (xALP_Certificado;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetDrgOpts (xALP_Certificado;0;30;0)


  //dragging options
If (<>aYears{<>aYears}#<>gYear)
	AL_SetDrgSrc (xALP_Certificado;1;String:C10(xALP_Certificado);"";"")
	AL_SetDrgDst (xALP_Certificado;1;String:C10(xALP_Certificado);"";"")
Else 
	AL_SetDrgSrc (xALP_Certificado;1;"";"";"")
	AL_SetDrgDst (xALP_Certificado;1;"";"";"")
End if 

  //(OBJECT Get pointer(Object named;"añoSeleccionado"))->:=<>aYears{<>aYears}
(OBJECT Get pointer:C1124(Object named:K67:5;"cert.ImprimirProfesorJefe"))->:=vi_PrintHeadName
(OBJECT Get pointer:C1124(Object named:K67:5;"cert.imprimirObservaciones"))->:=vi_ImprimeObsActas
(OBJECT Get pointer:C1124(Object named:K67:5;"cert.soloEvaluadas"))->:=vi_PrintEvaluadas

