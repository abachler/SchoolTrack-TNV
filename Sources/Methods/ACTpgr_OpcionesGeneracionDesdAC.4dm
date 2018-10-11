//%attributes = {}
C_LONGINT:C283($vl_ACS)
C_TEXT:C284($vt_accion;$1)
$vt_accion:=$1

Case of 
	: ($vt_accion="FormMethod")
		Case of 
			: (Form event:C388=On Load:K2:1)
				ACTpgr_OpcionesGeneracionDesdAC ("DeclaraVars")
				ACTpgr_OpcionesGeneracionDesdAC ("InitVars")
				
				$vl_rec:=BWR_SearchRecords 
				Case of 
					: ($vl_rec>0)
						btn_ACSeleccionados:=1
					: (Size of array:C274(alBWR_recordNumber)>0)
						btn_ACListados:=1
				End case 
				If ($vl_rec#-1)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_ACS)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=0)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
				End if 
				vt_msjAS:=__ ("La emisión de Pagarés se aplicará a ")+String:C10($vl_ACS)+__ (" de ")+String:C10(Size of array:C274(abrSelect))+" "+__ ("Aviso(s) de Cobranza seleccionados.")
				
				If (Size of array:C274(alBWR_recordNumber)>0)
					CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];alBWR_recordNumber;"")
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_ACS)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=0)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					vt_msjAL:=__ ("La emisión de Pagarés se aplicará a ")+String:C10($vl_ACS)+__ (" de ")+String:C10(Size of array:C274(alBWR_recordNumber))+" "+__ ("Aviso(s) de Cobranza listados en el explorador.")
				End if 
				
				ACTpgr_OpcionesGeneracionDesdAC ("OnClicked")
				
			: (Form event:C388=On Clicked:K2:4)
				ACTpgr_OpcionesGeneracionDesdAC ("OnClicked")
				
		End case 
		
	: ($vt_accion="OnClicked")
		OBJECT SET VISIBLE:C603(*;"vt_msjAS";(btn_ACSeleccionados=1))
		OBJECT SET VISIBLE:C603(*;"vt_msjAL";(btn_ACListados=1))
		
		  //guarda pref seleccionadas
		PREF_Set (<>lUSR_CurrentUserID;"ACT_PGR_vl_generarPorAC";String:C10(vl_generarPorAC))
		PREF_Set (<>lUSR_CurrentUserID;"ACT_PGR_vl_generarPorApdo";String:C10(vl_generarPorApdo))
		
	: ($vt_accion="DeclaraVars")
		C_LONGINT:C283(vl_generarPorAC;vl_generarPorApdo)
		C_LONGINT:C283(btn_ACSeleccionados;btn_ACListados)
		C_TEXT:C284(vt_msjAS;vt_msjAL)
		
	: ($vt_accion="InitVars")
		vl_generarPorAC:=1
		vl_generarPorApdo:=0
		
		btn_ACSeleccionados:=0
		btn_ACListados:=0
		vt_msjAS:=""
		vt_msjAL:=""
		
		  //lee preferencias de ultima generacion
		vl_generarPorAC:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"ACT_PGR_vl_generarPorAC";String:C10(vl_generarPorAC)))
		vl_generarPorApdo:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"ACT_PGR_vl_generarPorApdo";String:C10(vl_generarPorApdo)))
		
	: ($vt_accion="muestraForm")
		WDW_OpenFormWindow (->[ACT_Pagares:184];"GeneracionPagareDesdeAvisos";-1;4;__ ("Emisión de Pagarés"))
		DIALOG:C40([ACT_Pagares:184];"GeneracionPagareDesdeAvisos")
		CLOSE WINDOW:C154
End case 