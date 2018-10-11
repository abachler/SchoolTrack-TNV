  // [Cursos].OpcionesImpresionPlanillas()
  // 
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 11:07:19
  // -----------------------------------------------------------


If (<>vtXS_CountryCode="ar")
	OBJECT SET VISIBLE:C603(*;"Variable5";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"Variable5";False:C215)
End if 
Case of 
	: (Form event:C388=On Load:K2:1)
		FORM GOTO PAGE:C247(vi_formPage)
		aEvViewMode:=1
		aEvStyleType:=1
		vi_EvStyleToUse:=0
		vlEVS_CurrentEvStyleID:=0
		vi_ConvertGradesTo:=0
		cb_HideAverage:=Num:C11(PREF_fGet (0;"Planilla_cb_HideAverage"+<>gRolBD;"0"))
		cb_PrintConsolidantes:=Num:C11(PREF_fGet (0;"Planilla_cb_PrintConsolidantes"+<>gRolBD;"0"))
		p1_Internas:=Num:C11(PREF_fGet (0;"Planilla_p1_Internas"+<>gRolBD;"1"))
		p2_EnActas:=Num:C11(PREF_fGet (0;"Planilla_p2_EnActas"+<>gRolBD;"0"))
		cbAsistencia:=Num:C11(PREF_fGet (0;"Planilla_cbAsistencia"+<>gRolBD;"1"))
		n1NotaFinalOficial:=Num:C11(PREF_fGet (0;"Planilla_n1NotaFinalOficial"+<>gRolBD;"1"))
		n2NotaFinalInterna:=Num:C11(PREF_fGet (0;"Planilla_n2NotaFinalInterna"+<>gRolBD;"0"))
		o1Ordenamiento:=Num:C11(PREF_fGet (0;"Planilla_OrdenAlfabetico"+<>gRolBD;"1"))
		o2Ordenamiento:=Num:C11(PREF_fGet (0;"Planilla_OrdenNoLista"+<>gRolBD;"0"))
		If ([xShell_Reports:54]FormName:17="prPlanillaPeriodo")
			vl_NotaFinalOficial:=Num:C11(PREF_fGet (0;"Planilla_vl_NotaFinalOficial"+<>gRolBD;"0"))
			vl_NotaFinalInterna:=Num:C11(PREF_fGet (0;"Planilla_vl_NotaFinalInterna"+<>gRolBD;"0"))
		Else 
			vl_NotaFinalOficial:=0
			vl_NotaFinalInterna:=0
		End if 
		
		OBJECT SET ENABLED:C1123(vl_NotaFinalOficial;[xShell_Reports:54]FormName:17="prPlanillaPeriodo")
		OBJECT SET ENABLED:C1123(vl_NotaFinalInterna;[xShell_Reports:54]FormName:17="prPlanillaPeriodo")
		
		  //OBJECT SET ENABLED(cb_PrintConsolidantes;p2_enActas=1)
		If (p2_enActas=0)
			OBJECT SET ENABLED:C1123(*;"Variable34";True:C214)
		Else 
			OBJECT SET ENABLED:C1123(*;"Variable34";False:C215)
		End if 
		
		r2_promedios:=1
		vi_Parciales:=0
		
		If (vi_formPage=2)
			OBJECT GET COORDINATES:C663(*;"imprimir2";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			GET WINDOW RECT:C443($l_izquierdaW;$l_arribaW;$l_derechaW;$l_abajoW)
			SET WINDOW RECT:C444($l_izquierdaW;$l_arribaW;$l_derechaW;$l_arribaW+$l_abajo+13)
		End if 
		
	: (Form event:C388=On Deactivate:K2:10)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
