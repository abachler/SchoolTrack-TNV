//%attributes = {}
  //ACTAS_Headers

C_LONGINT:C283($w;$h)
C_POINTER:C301($ptr)

C_TEXT:C284(vPTexto1;vPTexto2;vPTexto3;vPTexto4;vPTexto5;vPTexto6;vPTexto7)  //Para los encabezados fijos
C_TEXT:C284(vPTextoPC;vPTextoPE)
C_PICTURE:C286(vPImagen1;vPImagen2;vPImagen3;vPImagen4;vPImagen5;vPImagen6;vPImagen7;vPImagen8;vPImagen9;vPImagen10;\
vPImagen11;vPImagen12;vPImagen13;vPImagen14;vPImagen15;vPImagen16;vPImagen17;vPImagen18;vPImagen19;vPImagen20;vPImagen21;\
vPImagen22;vPImagen23;vPImagen24;vPImagen25;vPImagen26;vPImagen27;vPImagen28;vPImagen29;vPImagen30;vPImagen31;vPImagen32;\
vPImagen33;vPImagen34;vPImagen35;vPImagen36;vPImagen37)

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
		  //iNo:=12
		  //iNames:=120
		  //ASM 20141210 Ticket 139711 
		iNo:=13
		iNames:=119
		iRUT:=37
		iSex:=19
		iBirthDate:=36
		iComuna:=50
		vi_FontSize:=5
	Else 
		  //iNo:=12
		  //iNames:=80
		  //ASM 20141210 Ticket 139711 
		iNo:=13
		iNames:=63
		iRUT:=37
		iSex:=18
		iBirthDate:=24
		iComuna:=29
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
_O_PLATFORM PROPERTIES:C365($platForm)
Case of 
	: ($platform<3)
		Case of 
			: (iMatFin<=35)
				$maxHeigth:=96
			: (iMatFin<=45)
				$maxHeigth:=84
			: (iMatFin<=50)
				$maxHeigth:=72
			Else 
				$maxHeigth:=60
		End case 
		
	Else 
		Case of 
			: (iMatFin<=35)
				$maxHeigth:=96
			: (iMatFin<=45)
				$maxHeigth:=84
			: (iMatFin<=50)
				$maxHeigth:=72
			Else 
				$maxHeigth:=48
		End case 
End case 


$pct:=1

$columns:=Size of array:C274(atActas_Subsectores)
If ($columns>37)
	$columns:=37
End if 
  //redimensionamiento de las imagenes
$percentResize:=1
For ($k;1;$columns)
	$test:=atActas_Subsectores{$k}
	atActas_Subsectores{$k}:=ST_CleanString (atActas_Subsectores{$k})
	$ptr:=Get pointer:C304("aPict"+String:C10($k))
	
	If ((atActas_Subsectores{$k}#"") & (atActas_Subsectores{$k}#" "))
		QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=atActas_Subsectores{$k})
	End if 
	$textoEtiqueta:=atActas_Subsectores{$k}
	If (vi_EtiquetasEnAltas=1)
		$textoEtiqueta:=ST_Uppercase ($textoEtiqueta)
	End if 
	If (Length:C16($textoEtiqueta)>38)
		For ($i;38;1;-1)
			If ($textoEtiqueta[[$i]]=" ")
				$breakAt:=$i-1
				$i:=0
				$line1:=Substring:C12($textoEtiqueta;1;$breakAt)
				$line2:=Substring:C12($textoEtiqueta;$breakAt+2)
				$textoEtiqueta:=$line1+"\r"+$line2
			End if 
		End for 
	End if 
	
	
	$ptr->{1}:=SVG_Text2Pict ($textoEtiqueta;96;colwidth;"Tahoma";vi_FontSize;Plain:K14:1;Align center:K42:3;"Black";270)
	
	$pict:=$ptr->{1}
	PICTURE PROPERTIES:C457($pict;$w;$h)
	Case of 
		: ($h>$maxHeigth)
			$pct:=$maxHeigth/$h
			$pict:=$pict*$pct
			PICTURE PROPERTIES:C457($pict;$w;$h)
			If ($w>=colwidth)
				$pct:=(colwidth-2)/$w
				$pict:=$pict*$pct
				  //$ptr->{1}:=$pict
			End if 
		: ($w>=colwidth)
			$pct:=(colwidth-3)/$w
			$pict:=$pict*$pct
			PICTURE PROPERTIES:C457($pict;$w;$h)
			If ($h>$maxHeigth)
				$pct:=$maxHeigth/$h
				$pict:=$pict*$pct
			End if 
			  //$ptr->{1}:=$pict
	End case 
	If ($pct<$percentResize)
		$percentResize:=$pct
	End if 
End for 

  //If ($percentResize#1)
  //For ($k;1;$columns)
  //$ptr:=Get pointer("aPict"+String($k))
  //$ptr->{1}:=$ptr->{1}*$percentResize
  //End for 
  //End if 

For ($k;1;$columns)
	$ptr:=Get pointer:C304("aPict"+String:C10($k))
	$ptr2:=Get pointer:C304("vPImagen"+String:C10($k))
	$ptr2->:=$ptr->{1}
End for 

If (vi_PEStart>0)
	ARRAY TEXT:C222(aTtl1;1)
	ARRAY TEXT:C222(aTtl2;1)
	ARRAY TEXT:C222(aTtl3;1)
	ARRAY TEXT:C222(aTtl4;1)
	aTtl1{1}:=""
	aTtl2{1}:=vs_PCText
	aTtl3{1}:=vs_PEText
	aTtl4{1}:=""
	PCwidth:=colwidth*vi_PCEnd
	PEwidth:=colwidth*(vi_PEEnd-vi_PEStart+1)
Else 
	ARRAY TEXT:C222(aTtl1;0)
	ARRAY TEXT:C222(aTtl2;0)
	ARRAY TEXT:C222(aTtl3;0)
	ARRAY TEXT:C222(aTtl4;0)
End if 
ARRAY TEXT:C222(aBidon1;1)
ARRAY TEXT:C222(aBidon2;1)
ARRAY TEXT:C222(aBidon3;1)
ARRAY TEXT:C222(aBidon4;1)
ARRAY TEXT:C222(aBidon5;1)
ARRAY TEXT:C222(aBidon6;1)
ARRAY TEXT:C222(aBidon7;1)
aBidon1{1}:=__ ("Nº")
aBidon2{1}:=__ ("NOMINA DE ALUMNOS")
aBidon3{1}:=__ ("R.U.N.")
aBidon4{1}:=__ ("OBSERVACIONES")
aBidon5{1}:=__ ("Sexo")
aBidon6{1}:=__ ("Fecha Nac.")
aBidon7{1}:=__ ("Comuna Residencia")
  //End if 

vPTexto1:=aBidon1{1}
vPTexto2:=aBidon2{1}
vPTexto3:=aBidon3{1}
vPTexto4:=aBidon4{1}
vPTexto5:=aBidon5{1}
vPTexto6:=aBidon6{1}
vPTexto7:=aBidon7{1}