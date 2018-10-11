//%attributes = {}
  // Método: ACTpp_OpcionesPagares
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 16:13:12
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
  //ACTpp_OpcionesPagares

C_TEXT:C284($1;$vt_accion)
C_POINTER:C301(${2};$ptr1)
C_LONGINT:C283($vl_idPagare)
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="SetAreas")
		ACTpp_OpcionesPagares ("SetAreaPagares")
		ACTpp_OpcionesPagares ("SetAreaDesglose")
		
	: ($vt_accion="SetAreaPagares")
		$vl_multiLine:=0
		ACTcfg_OpcionesPagares ("ConfiguraALP";->$vl_multiLine)
		
	: ($vt_accion="SetAreaDesglose")
		ACTpp_OpcionesPagares ("DeclaraArreglosDesglose")
		$vl_columnasOcultas:=2
		ACTcfg_OpcionesGeneracionP ("SetAreaListAvisos";->$vl_columnasOcultas)
		
	: ($vt_accion="DeclaraArreglosPagares")
		ACTcfg_OpcionesPagares ("DeclaraArreglosALP")
		
	: ($vt_accion="DeclaraArreglosDesglose")
		ACTcfg_OpcionesGeneracionP ("DeclaraArreglosCuotas")
		
	: ($vt_accion="CargaArreglos")
		READ ONLY:C145([ACT_Pagares:184])
		QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]ID_Apdo:17=[Personas:7]No:1)
		$vb_noMostrarMensaje:=True:C214
		ACTcfg_OpcionesPagares ("CargaArreglosALP";->$vb_noMostrarMensaje)
		
	: ($vt_accion="CargaDesglosePagare")
		$vl_idPagare:=$ptr1->
		If ($vl_idPagare>0)
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=$vl_idPagare)
			ACTcfg_OpcionesGeneracionP ("CargaArreglosAvisos")
		Else 
			ACTcfg_OpcionesGeneracionP ("DeclaraArreglosCuotas")
		End if 
End case 