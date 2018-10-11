//%attributes = {}
  // ACTAS_Encabezados()
  // Por: Alberto Bachler K.: 27-02-14, 13:44:14
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_caracteres;$i_columna;$l_aLaLineaEn;$l_altoImagen;$l_altoMaximo;$l_anchoImagen;$l_numeroColumnas)
C_PICTURE:C286($p_imagenEncabezadoColumna)
C_POINTER:C301($y_variableEncabezado)
C_REAL:C285($r_factorRedimensionamiento)
C_TEXT:C284($t_linea1;$t_linea2;$t_textoEncabezado)

C_TEXT:C284(vPTexto1;vPTexto2;vPTexto3;vPTexto4;vPTexto5;vPTexto6;vPTexto7)
C_TEXT:C284(vPTextoPC;vPTextoPE)
C_PICTURE:C286(vPImagen1;vPImagen2;vPImagen3;vPImagen4;vPImagen5;vPImagen6;vPImagen7;vPImagen8;vPImagen9;vPImagen10)
C_PICTURE:C286(vPImagen11;vPImagen12;vPImagen13;vPImagen14;vPImagen15;vPImagen16;vPImagen17;vPImagen18;vPImagen19;vPImagen20)
C_PICTURE:C286(vPImagen21;vPImagen22;vPImagen23;vPImagen24;vPImagen25;vPImagen26;vPImagen27;vPImagen28;vPImagen29;vPImagen30)
C_PICTURE:C286(vPImagen31;vPImagen32;vPImagen33;vPImagen34;vPImagen35;vPImagen36;vPImagen37)

Case of 
	: ([Cursos:3]Nivel_Numero:7<=2)
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.B. 1"
	: ([Cursos:3]Nivel_Numero:7<=4)
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.B. 2"
	: ([Cursos:3]Nivel_Numero:7=5)
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.B. 3"
	: (([Cursos:3]Nivel_Numero:7=6) & (<>gYear>=2000))
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.B. 4"
	: (([Cursos:3]Nivel_Numero:7=7) & (<>gYear>=2001))
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.B. 5"
	: (([Cursos:3]Nivel_Numero:7=8) & (<>gYear>=2002))
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.B. 6"
	: (([Cursos:3]Nivel_Numero:7=9) & (<>gYear>=1999))
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.M. 1"
	: (([Cursos:3]Nivel_Numero:7=10) & (<>gYear>=2000))
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.M. 2"
	: (([Cursos:3]Nivel_Numero:7=11) & (<>gYear>=2001))
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.M. 3"
	: (([Cursos:3]Nivel_Numero:7=12) & (<>gYear>=2002))
		vs_curso:="Curso: "+[Cursos:3]Nombre_Oficial_Curso:15+", N.M. 4"
	Else 
		vs_curso:=[Cursos:3]Nombre_Oficial_Curso:15
End case 

Case of 
	: (vi_columns<30)
		iNo:=13
		iNames:=120
		iRUT:=37
		iSex:=19
		iBirthDate:=36
		iComuna:=50
		vi_FontSize:=5
	Else 
		iNo:=13
		iNames:=80
		iRUT:=34  ///193355  le doy 4 puntos al ancho de la columnamas antes estaba en 30 ABC 2017/11/22
		iSex:=20
		iBirthDate:=28
		iComuna:=40
		vi_FontSize:=4
End case 
leftmarge:=iNo+iNames+iRUT+iSex+iBirthDate+iComuna


obswidth:=100
colwidth:=0
Case of 
	: (vt_PLConfigMessage="carta")
		colwidth:=Int:C8((728-leftMarge-obswidth)/vi_columns)
		obswidth:=728-leftmarge-(vi_columns*colwidth)
	: (vt_PLConfigMessage="oficio")
		colwidth:=Int:C8((824-leftMarge-obswidth)/vi_columns)
		obswidth:=824-leftmarge-(vi_columns*colwidth)
	Else 
		colwidth:=Int:C8((728-leftMarge-obswidth)/vi_columns)
		obswidth:=728-leftmarge-(vi_columns*colwidth)
End case 



If (colwidth<11)
	colwidth:=11
	Case of 
		: (vt_PLConfigMessage="carta")
			obswidth:=728-leftmarge-(vi_columns*colwidth)
		: (vt_PLConfigMessage="oficio")
			obswidth:=824-leftmarge-(vi_columns*colwidth)
	End case 
End if 


  //calculo de la dimension máxima de imagenes
Case of 
	: (SYS_IsMacintosh )
		Case of 
			: (iMatFin<=35)
				$l_altoMaximo:=96
			: (iMatFin<=45)
				$l_altoMaximo:=84
			: (iMatFin<=50)
				$l_altoMaximo:=72
			Else 
				$l_altoMaximo:=60
		End case 
		
	: (SYS_IsWindows )
		Case of 
			: (iMatFin<=35)
				$l_altoMaximo:=96
			: (iMatFin<=45)
				$l_altoMaximo:=84
			: (iMatFin<=50)
				$l_altoMaximo:=72
			Else 
				$l_altoMaximo:=48
		End case 
End case 


$r_factorRedimensionamiento:=1

$l_numeroColumnas:=Size of array:C274(atActas_Subsectores)
If ($l_numeroColumnas>37)
	$l_numeroColumnas:=37
End if 


  //redimensionamiento de las imagenes
For ($i_columna;1;$l_numeroColumnas)
	atActas_Subsectores{$i_columna}:=ST_CleanString (atActas_Subsectores{$i_columna})
	$y_variableEncabezado:=Get pointer:C304("vpImagen"+String:C10($i_columna))
	
	
	If ((atActas_Subsectores{$i_columna}#"") & (atActas_Subsectores{$i_columna}#" "))
		QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=atActas_Subsectores{$i_columna})
	End if 
	$t_textoEncabezado:=atActas_Subsectores{$i_columna}
	If (vi_EtiquetasEnAltas=1)
		$t_textoEncabezado:=ST_Uppercase ($t_textoEncabezado)
	End if 
	If (Length:C16($t_textoEncabezado)>38)
		For ($i_caracteres;38;1;-1)
			If ($t_textoEncabezado[[$i_caracteres]]=" ")
				$l_aLaLineaEn:=$i_caracteres-1
				$i_caracteres:=0
				$t_linea1:=Substring:C12($t_textoEncabezado;1;$l_aLaLineaEn)
				$t_linea2:=Substring:C12($t_textoEncabezado;$l_aLaLineaEn+2)
				$t_textoEncabezado:=$t_linea1+"\r"+$t_linea2
			End if 
		End for 
	End if 
	
	
	$p_imagenEncabezadoColumna:=SVG_Text2Pict ($t_textoEncabezado;96;colwidth;"Tahoma";vi_FontSize;Plain:K14:1;Align center:K42:3;"Black";270)
	
	
	PICTURE PROPERTIES:C457($p_imagenEncabezadoColumna;$l_anchoImagen;$l_altoImagen)
	Case of 
		: ($l_altoImagen>$l_altoMaximo)
			$r_factorRedimensionamiento:=$l_altoMaximo/$l_altoImagen
			$p_imagenEncabezadoColumna:=$p_imagenEncabezadoColumna*$r_factorRedimensionamiento
			PICTURE PROPERTIES:C457($p_imagenEncabezadoColumna;$l_anchoImagen;$l_altoImagen)
			If ($l_anchoImagen>=colwidth)
				$r_factorRedimensionamiento:=(colwidth-2)/$l_anchoImagen
				$p_imagenEncabezadoColumna:=$p_imagenEncabezadoColumna*$r_factorRedimensionamiento
			End if 
		: ($l_anchoImagen>=colwidth)
			$r_factorRedimensionamiento:=(colwidth-3)/$l_anchoImagen
			$p_imagenEncabezadoColumna:=$p_imagenEncabezadoColumna*$r_factorRedimensionamiento
			PICTURE PROPERTIES:C457($p_imagenEncabezadoColumna;$l_anchoImagen;$l_altoImagen)
			If ($l_altoImagen>$l_altoMaximo)
				$r_factorRedimensionamiento:=$l_altoMaximo/$l_altoImagen
				$p_imagenEncabezadoColumna:=$p_imagenEncabezadoColumna*$r_factorRedimensionamiento
			End if 
	End case 
	$y_variableEncabezado->:=$p_imagenEncabezadoColumna
	
End for 


If (vi_PEStart>0)
	PCwidth:=colwidth*vi_PCEnd
	PEwidth:=colwidth*(vi_PEEnd-vi_PEStart+1)
End if 

  // Modificado por: Alexis Bustamante (17-07-2017)
  //TICKET 185271

vPTexto1:=__ ("Nº")
vPTexto2:=__ ("NOMINA DE ALUMNOS")
vPTexto3:=__ ("R.U.N.")
vPTexto4:=__ ("OBSERVACIONES")
vPTexto5:=__ ("Sexo")
vPTexto6:=__ ("Fecha Nac.")
vPTexto7:=__ ("Comuna Residencia")

