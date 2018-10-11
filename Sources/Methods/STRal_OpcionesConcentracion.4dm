//%attributes = {}
  // Método: STRal_OpcionesConcentracion
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 09-12-10, 14:02:58
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //STRal_OpcionesConcentracion

C_TEXT:C284($0;$1;$vt_retorno;$vt_accion)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="LeeBlobConcentracion")
		C_TEXT:C284(vt_TituloConcentracion)
		
		sAltSchool1:=<>gCustom
		sAltSchool2:=<>gCustom
		sAltSchool3:=<>gCustom
		sAltSchool4:=<>gCustom
		sAltCity1:=<>gCiudad
		sAltCity2:=<>gCiudad
		sAltCity3:=<>gCiudad
		sAltCity4:=<>gCiudad
		sAltCoop1:=<>gPlanEst
		sAltCoop2:=<>gPlanEst
		sAltCoop3:=<>gPlanEst
		sAltCoop4:=<>gPlanEst
		sAltPlan1:=<>gDecEval
		sAltPlan2:=<>gDecEval
		sAltPlan3:=<>gDecEval
		sAltPlan4:=<>gDecEval
		
		vt_TituloConcentracion:="CERTIFICADO DE CONCENTRACION DE CALIFICACIONES DE ENSEÑANZA MEDIA HUMANISTICO-CIENTIFICA"
		vi_DecAsistencia:=0
		
		C_BLOB:C604(xBlob)
		xBlob:=PREF_fGetBlob (0;"Decretos Concentraciones")
		BLOB_Blob2Vars (->xBlob;0;->sAltSchool1;->sAltSchool2;->sAltSchool3;->sAltSchool4;->sAltCity1;->sAltCity2;->sAltCity3;->sAltCity4;->sAltCoop1;->sAltCoop2;->sAltCoop3;->sAltCoop4;->sAltPlan1;->sAltPlan2;->sAltPlan3;->sAltPlan4;->vi_DecAsistencia;->vt_TituloConcentracion)
		If (vt_TituloConcentracion="")
			vt_TituloConcentracion:="CERTIFICADO DE CONCENTRACION DE CALIFICACIONES DE ENSEÑANZA MEDIA HUMANISTICO-CIE"+"NTIFICA"
		End if 
		SET BLOB SIZE:C606(xBlob;0)
		
	: ($vt_accion="ValidaPlanesConcentracion")
		  //colorea decretos y muestra mensaje en formulario si los datos no son igual a lo configurado para el nivel.
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=9)
		$sAltCoop1:=[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39
		$sAltPlan1:=[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=10)
		$sAltCoop2:=[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39
		$sAltPlan2:=[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=11)
		$sAltCoop3:=[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39
		$sAltPlan3:=[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=12)
		$sAltCoop4:=[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39
		$sAltPlan4:=[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38
		
		$vbSTR_MensajeConcen:=False:C215
		If ($sAltCoop1=Num:C11(STRal_OpcionesConcentracion ("ObtieneNumeroDecreto";->sAltCoop1)))
			OBJECT SET COLOR:C271(sAltCoop1;-(Black:K11:16+(256*White:K11:1)))
		Else 
			$vbSTR_MensajeConcen:=True:C214
			OBJECT SET COLOR:C271(sAltCoop1;-(Blue:K11:7+(256*White:K11:1)))
		End if 
		If ($sAltPlan1=Num:C11(STRal_OpcionesConcentracion ("ObtieneNumeroDecreto";->sAltPlan1)))
			OBJECT SET COLOR:C271(sAltPlan1;-(Black:K11:16+(256*White:K11:1)))
		Else 
			$vbSTR_MensajeConcen:=True:C214
			OBJECT SET COLOR:C271(sAltPlan1;-(Blue:K11:7+(256*White:K11:1)))
		End if 
		
		If ($sAltCoop2=Num:C11(STRal_OpcionesConcentracion ("ObtieneNumeroDecreto";->sAltCoop2)))
			OBJECT SET COLOR:C271(sAltCoop2;-(Black:K11:16+(256*White:K11:1)))
		Else 
			$vbSTR_MensajeConcen:=True:C214
			OBJECT SET COLOR:C271(sAltCoop2;-(Blue:K11:7+(256*White:K11:1)))
		End if 
		If ($sAltPlan2=Num:C11(STRal_OpcionesConcentracion ("ObtieneNumeroDecreto";->sAltPlan2)))
			OBJECT SET COLOR:C271(sAltPlan2;-(Black:K11:16+(256*White:K11:1)))
		Else 
			$vbSTR_MensajeConcen:=True:C214
			OBJECT SET COLOR:C271(sAltPlan2;-(Blue:K11:7+(256*White:K11:1)))
		End if 
		
		If ($sAltCoop3=Num:C11(STRal_OpcionesConcentracion ("ObtieneNumeroDecreto";->sAltCoop3)))
			OBJECT SET COLOR:C271(sAltCoop3;-(Black:K11:16+(256*White:K11:1)))
		Else 
			$vbSTR_MensajeConcen:=True:C214
			OBJECT SET COLOR:C271(sAltCoop3;-(Blue:K11:7+(256*White:K11:1)))
		End if 
		If ($sAltPlan3=Num:C11(STRal_OpcionesConcentracion ("ObtieneNumeroDecreto";->sAltPlan3)))
			OBJECT SET COLOR:C271(sAltPlan3;-(Black:K11:16+(256*White:K11:1)))
		Else 
			$vbSTR_MensajeConcen:=True:C214
			OBJECT SET COLOR:C271(sAltPlan3;-(Blue:K11:7+(256*White:K11:1)))
		End if 
		
		If ($sAltCoop4=Num:C11(STRal_OpcionesConcentracion ("ObtieneNumeroDecreto";->sAltCoop4)))
			OBJECT SET COLOR:C271(sAltCoop4;-(Black:K11:16+(256*White:K11:1)))
		Else 
			$vbSTR_MensajeConcen:=True:C214
			OBJECT SET COLOR:C271(sAltCoop4;-(Blue:K11:7+(256*White:K11:1)))
		End if 
		If ($sAltPlan4=Num:C11(STRal_OpcionesConcentracion ("ObtieneNumeroDecreto";->sAltPlan4)))
			OBJECT SET COLOR:C271(sAltPlan4;-(Black:K11:16+(256*White:K11:1)))
		Else 
			$vbSTR_MensajeConcen:=True:C214
			OBJECT SET COLOR:C271(sAltPlan4;-(Blue:K11:7+(256*White:K11:1)))
		End if 
		
		OBJECT SET VISIBLE:C603(*;"vt_msjConcent";$vbSTR_MensajeConcen)
		
	: ($vt_accion="ObtieneNumeroDecreto")
		For ($i;1;Length:C16($ptr1->))
			$ascii:=Character code:C91($ptr1->[[$i]])
			If (($ascii>=48) & ($ascii<=57))
				$vt_retorno:=$vt_retorno+$ptr1->[[$i]]
			End if 
		End for 
		
	: ($vt_accion="ObtieneSeparador")
		For ($i;1;Length:C16($ptr1->))
			$ascii:=Character code:C91($ptr1->[[$i]])
			If (($ascii>=48) & ($ascii<=57))
			Else 
				$vt_retorno:=$vt_retorno+$ptr1->[[$i]]
			End if 
		End for 
		
	: ($vt_accion="ObtieneSeparadorPlan")
		STRal_OpcionesConcentracion ("LeeBlobConcentracion")
		$vt_retorno:=STRal_OpcionesConcentracion ("ObtieneSeparador";->sAltCoop4)
		$vt_retorno:=STRal_OpcionesConcentracion ("LimpiaString";->$vt_retorno)
		
	: ($vt_accion="ObtieneSeparadorPromocion")
		STRal_OpcionesConcentracion ("LeeBlobConcentracion")
		$vt_retorno:=STRal_OpcionesConcentracion ("ObtieneSeparador";->sAltPlan4)
		$vt_retorno:=STRal_OpcionesConcentracion ("LimpiaString";->$vt_retorno)
		
	: ($vt_accion="LimpiaString")
		$vt_retorno:=Replace string:C233($ptr1->;"\t";"")
		$vt_retorno:=Replace string:C233($ptr1->;"\r";"")
		$vt_retorno:=Replace string:C233($ptr1->;"  ";" ")
		
End case 
$0:=$vt_retorno