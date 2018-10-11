//%attributes = {}
  //SRACT_SelFecha

C_LONGINT:C283($1;$vl_retorno;$lastday;$0)
C_DATE:C307(vd_Fecha1;vd_Fecha2)
C_BOOLEAN:C305(vb_ocultarExportar;vbACT_SoloMes)
C_BOOLEAN:C305(vbACT_BuscaEnSel)
C_BOOLEAN:C305(vbACTrz_InformePreparado)

vd_Fecha1:=!00-00-00!
vd_Fecha2:=!00-00-00!
If (Count parameters:C259=1)
	Case of 
		: ($1=1)
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SelFechaSimple";0;Palette form window:K39:9;__ ("Selección de Fecha"))
			DIALOG:C40([xxSTR_Constants:1];"ACT_SelFechaSimple")
			CLOSE WINDOW:C154
			$vl_retorno:=1
			If (ok=1)
				vd_Fecha1:=vdFechaCargo
				vd_Fecha2:=vdFechaCargo
			End if 
		: ($1=2)
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SelAñoSimple";0;Palette form window:K39:9;__ ("Selección de Año"))
			DIALOG:C40([xxSTR_Constants:1];"ACT_SelAñoSimple")
			CLOSE WINDOW:C154
			$vl_retorno:=1
			If (ok=1)
				vd_Fecha1:=DT_GetDateFromDayMonthYear (1;1;vlSelAño)
				vd_Fecha2:=DT_GetDateFromDayMonthYear (31;12;vlSelAño)
			End if 
		: ($1=3)
			WDW_OpenFormWindow (->[xxACT_Items:179];"SeleccionaPeriodoFact";0;Palette form window:K39:9;__ ("Seleccione Período"))
			DIALOG:C40([xxACT_Items:179];"SeleccionaPeriodoFact")
			CLOSE WINDOW:C154
		: ($1=4)  //ventana de seleccion de periodo con exportacion ocultada
			vb_ocultarExportar:=True:C214
			WDW_OpenFormWindow (->[xxACT_Items:179];"SeleccionaPeriodoFact";0;Palette form window:K39:9;__ ("Seleccione Período"))
			DIALOG:C40([xxACT_Items:179];"SeleccionaPeriodoFact")
			CLOSE WINDOW:C154
			vb_ocultarExportar:=False:C215
			
		: ($1=5)  //ventana de seleccion de periodo con exportacion ocultada
			C_DATE:C307(vdACT_SelFecha1;vdACT_SelFecha2)
			vdACT_SelFecha1:=PERIODOS_InicioAñoSTrack 
			vdACT_SelFecha2:=PERIODOS_FinAñoPeriodosSTrack 
			vb_ocultarExportar:=True:C214
			WDW_OpenFormWindow (->[xxACT_Items:179];"SeleccionaPeriodoFact";0;Palette form window:K39:9;__ ("Seleccione Período"))
			DIALOG:C40([xxACT_Items:179];"SeleccionaPeriodoFact")
			CLOSE WINDOW:C154
			vdACT_SelFecha1:=!00-00-00!
			vdACT_SelFecha2:=!00-00-00!
			vb_ocultarExportar:=False:C215
			
		: ($1=6)  //ventana de seleccion de MES con exportacion ocultada
			vbACT_SoloMes:=True:C214
			vb_ocultarExportar:=True:C214
			WDW_OpenFormWindow (->[xxACT_Items:179];"SeleccionaPeriodoFact";0;Palette form window:K39:9;__ ("Seleccione Período"))
			DIALOG:C40([xxACT_Items:179];"SeleccionaPeriodoFact")
			CLOSE WINDOW:C154
			vbACT_SoloMes:=False:C215
			
			vb_ocultarExportar:=False:C215
			
		: ($1=7)
			vbACT_BuscaEnSel:=True:C214
			WDW_OpenFormWindow (->[xxACT_Items:179];"SeleccionaPeriodoFact";0;Palette form window:K39:9;__ ("Seleccione Período"))
			DIALOG:C40([xxACT_Items:179];"SeleccionaPeriodoFact")
			CLOSE WINDOW:C154
			vbACT_BuscaEnSel:=False:C215
			
		: ($1=8)
			vbACTrz_InformePreparado:=True:C214
			WDW_OpenFormWindow (->[xxACT_Items:179];"SeleccionaPeriodoFact";0;Palette form window:K39:9;__ ("Seleccione Período"))
			DIALOG:C40([xxACT_Items:179];"SeleccionaPeriodoFact")
			CLOSE WINDOW:C154
			vbACTrz_InformePreparado:=False:C215
			
		: ($1=9)
			vbACTrz_InformePreparado:=True:C214
			vb_ocultarExportar:=True:C214
			WDW_OpenFormWindow (->[xxACT_Items:179];"SeleccionaPeriodoFact";0;Palette form window:K39:9;__ ("Seleccione Período"))
			DIALOG:C40([xxACT_Items:179];"SeleccionaPeriodoFact")
			CLOSE WINDOW:C154
			vbACTrz_InformePreparado:=False:C215
			vb_ocultarExportar:=False:C215
			
		: ($1=10)
			vbACTrz_InformePreparado:=True:C214
			vbACT_BuscaEnSel:=True:C214
			WDW_OpenFormWindow (->[xxACT_Items:179];"SeleccionaPeriodoFact";0;Palette form window:K39:9;__ ("Seleccione Período"))
			DIALOG:C40([xxACT_Items:179];"SeleccionaPeriodoFact")
			CLOSE WINDOW:C154
			vbACTrz_InformePreparado:=False:C215
			vbACT_BuscaEnSel:=True:C214
		Else 
			WDW_OpenFormWindow (->[xxACT_Items:179];"SeleccionaPeriodoFact";0;Palette form window:K39:9;__ ("Seleccione Período"))
			DIALOG:C40([xxACT_Items:179];"SeleccionaPeriodoFact")
			CLOSE WINDOW:C154
	End case 
	If (ok=0)
		$0:=0
	Else 
		$0:=$vl_retorno
	End if 
End if 