//%attributes = {}
  // ACTAS_ConfiguracionPorDefecto()
  // Por: Alberto Bachler K.: 27-02-14, 10:26:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($l_nivel;$l_nivelPromocion)
C_TEXT:C284($t_decretoEvaluacion;$t_subtituloActa)


If (False:C215)
	C_LONGINT:C283(ACTAS_ConfiguracionPorDefecto ;$1)
End if 

$l_nivel:=$1

ACTAS_Initialize 
Case of 
	: (($l_nivel>=1) & ($l_nivel<=2))
		$t_subtituloActa:="Enseñanza Básica N.B. 1"
		$t_decretoEvaluacion:="511 del año 1997"
	: (($l_nivel>=3) & ($l_nivel<=4))
		$t_subtituloActa:="Enseñanza Básica N.B. 2"
		$t_decretoEvaluacion:="511 del año 1997"
	: ($l_nivel=5)
		$t_subtituloActa:="Enseñanza Básica N.B. 3"
		$t_decretoEvaluacion:="511 del año 1997"
	: ($l_nivel=6)
		$t_subtituloActa:="Enseñanza Básica N.B. 4"
		$t_decretoEvaluacion:="511 del año 1997"
	: ($l_nivel=7)
		$t_subtituloActa:="Enseñanza Básica N.B. 5"
		$t_decretoEvaluacion:="511 del año 1997"
	: ($l_nivel=8)
		$t_subtituloActa:="Enseñanza Básica N.B. 6"
		$t_decretoEvaluacion:="511 del año 1997"
	: ($l_nivel=9)
		$t_subtituloActa:="1er Año de Enseñanza Media Humanístico-Científico"
		$t_decretoEvaluacion:="112 del año 1999"
	: ($l_nivel=10)
		$t_subtituloActa:="2˚ Año de Enseñanza Media Humanístico-Científico"
		$t_decretoEvaluacion:="112 del año 1999"
	: ($l_nivel=11)
		$t_subtituloActa:="3er Año de Enseñanza Media Humanístico-Científico"
		$t_decretoEvaluacion:="83 del año 2001"
	: ($l_nivel=12)
		$t_subtituloActa:="4˚ Año de Enseñanza Media Humanístico-Científico"
		$t_decretoEvaluacion:="83 del año 2001"
End case 

If (vs_ActaFont="")
	vs_ActaFont:="Arial"
End if 

If (vs_ActaTitle="")
	vs_ActaTitle:="ACTA DE REGISTRO DE CALIFICACIONES Y PROMOCION ESCOLAR"
End if 
If (vs_ActaSubTitle="")
	vs_ActaSubTitle:=$t_subtituloActa
	vs_ActaSubTitle:=vs_ActaSubTitle+"\r"+"(Calificaciones finales)"
End if 
If (vi_columns=0)
	vi_columns:=24
End if 
If (vi_PCStart=0)
	vi_PCStart:=1
	vi_PCEnd:=20
	vi_PEStart:=0
	vi_PEEnd:=0
End if 
If (vt_Menciones="")
	vt_menciones:="Reconocido Oficialmente por el Ministerio de Educación de la República de Chile, "+"según Resolución Exenta de Educación Nº XXX de XXXX, Rol Base de Datos Nº "+<>gRolBD+", Plan de Estudios aprobado por Decreto Exento Nº XXX del año XXXX y del Reglamen"+"to"+" de Evaluación y Promoción Escolar Decreto Exento Nº "+$t_decretoEvaluacion
End if 

  //CERTIFICADOS
If (vCert1="")
	vCert1:="CERTIFICADO ANUAL DE ESTUDIOS"
	vFont1:="Arial"
	vSize1:=18
	vStyle1:=1
End if 
If (vCert2="")
	vCert2:=<>gCustom
	vFont2:="Arial"
	vSize2:=18
	vStyle2:=1
End if 
vCert2:=<>gCustom
If (vCert3="")
	If (($l_nivel>=1) & ($l_nivel<=8))
		vCert3:="ENSEÑANZA BASICA  -  1º a 8º AÑO"
	Else 
		vCert3:="ENSEÑANZA MEDIA"
	End if 
	Case of 
		: (($l_nivel>=1) & ($l_nivel<=2))
			vCert3:="Enseñanza Básica N.B. 1"
			If (vs_PromoAbs="")
				vs_PromoAbs:="Art. 10 Dec. 511"
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art. 12 Dcto. 511/97"
			End if 
			
		: (($l_nivel>=3) & ($l_nivel<=4))
			vCert3:="Enseñanza Básica N.B. 2"
			If (vs_PromoAbs="")
				vs_PromoAbs:="Art. 10 Dec. 511"
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art. 12 Dcto. 511/97"
			End if 
			
		: ($l_nivel=5)
			vCert3:="Enseñanza Básica N.B. 3"
			If (vs_PromoAbs="")
				vs_PromoAbs:=""
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art. 12 Dcto. 511/97"
			End if 
			
		: ($l_nivel=6)
			vCert3:="Enseñanza Básica N.B. 4"
			If (vs_PromoAbs="")
				vs_PromoAbs:="Art. 11°, N°2"
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art. 12 Dcto. 511/97"
			End if 
			
		: ($l_nivel=7)
			vCert3:="Enseñanza Básica N.B. 5"
			If (vs_PromoAbs="")
				vs_PromoAbs:=""
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art. 12 Dcto. 511/97"
			End if 
			
		: ($l_nivel=8)
			vCert3:="Enseñanza Básica N.B. 6"
			If (vs_PromoAbs="")
				vs_PromoAbs:="Art. 11°, N°2"
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art. 12 Dcto. 511/97"
			End if 
			
		: ($l_nivel=9)
			vCert3:="1er Año de Enseñanza Media Humanístico-Científico"
			If (vs_PromoAbs="")
				vs_PromoAbs:="Art. 8°, N°2"
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art.4º  Dcto. 112/99"
			End if 
			
		: ($l_nivel=10)
			vCert3:="2º Año de Enseñanza Media Humanístico-Científico"
			If (vs_PromoAbs="")
				vs_PromoAbs:="Art. 8°, N°2"
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art.4º  Dcto. 112/99"
			End if 
			
		: ($l_nivel=11)
			vCert3:="3er Año de Enseñanza Media Humanístico-Científico"
			If (vs_PromoAbs="")
				vs_PromoAbs:="Art. 5 Letra C"
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art. 12i Dcto. 83/2001"
			End if 
			
		: ($l_nivel=12)
			vCert3:="4º Año de Enseñanza Media Humanístico-Científico"
			If (vs_PromoAbs="")
				vs_PromoAbs:="Art. 5 Letra C"
			End if 
			If (vs_PromoAnticipada="")
				vs_PromoAnticipada:="Art. 12i Dcto. 83/2001"
			End if 
			
	End case 
	
	
	vFont3:="Arial"
	vSize3:=12
	vStyle3:=0
End if 
If (vCert4="")
	vCert4:="Reconocido Oficialmente por el Ministerio de Educación de la República de Chile"+", según  Resolución  Exenta de Educación Nº XXXX de XXXX,  Rol Base de Datos  "+"Nº "+<>gRolBD+" otorga el presente certificado de calificaciones anuales y situación f"+"inal a:"
	vFont4:="Arial"
	vSize4:=9
	vStyle4:=0
End if 
If (vCert5="")
	vcert5:="ha obtenido, de acuerdo a las disposiciones reglamentarias vigentes, "
	vCert5:=vCert5+"las siguientes calificaciones:"
	vFont5:="Arial"
	vSize5:=9
	vStyle5:=0
End if 
If (vCert6="")
	vCert6:=<>gRector+"\r"+"Director(a)"
	vFont6:="Arial"
	vSize6:=9
	vStyle6:=1
End if 
sTitulo:="Doña"
sStudent:="Claudia Andrea Montijo de la Fuente"
sSex:="alumna de "
sClass:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
vCertDate:=<>gCiudad+", "+String:C10(Current date:C33;5)
$l_nivelPromocion:=$l_nivel+1
sFinalSit:="es promovido(a) a "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelPromocion;->[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
If (vs_NoReligion="")
	vs_NoReligion:="No Opta"
End if 
If (vs_AbrNoReligion="")
	vs_AbrNoReligion:="N/O"
End if 
If (vs_PCtext="")
	vs_PCtext:="Formación General"
End if 
If (vs_PEtext="")
	vs_PEtext:="Formación Diferenciada"
End if 

vi_printCodes:=0
vi_printEvaluadas:=0



