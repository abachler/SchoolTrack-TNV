//%attributes = {}
  //FM_fSave

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : FM_fSave
	  //Autor: Alberto Bachler
	  //Creada el 1/7/96 a 7:21 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
  //If (KRL_RegistroFueModificado (->[Familia]) | (campopropio))  //ABC 198018 // 20180123
If (KRL_RegistroFueModificado (->[Familia:78]) | (vb_guardarCambios))
	  //20180404 RCH Ticket 203523
	C_TEXT:C284($t_camposObligatorios;$t_datosNoUnicos;$t_datoNoValido)
	$b_error:=STR_ValidaCreacionRegistro ("Familias";->$t_camposObligatorios;->$t_datosNoUnicos;->$t_datoNoValido)
	If ($b_error)
		
		Case of 
			: ($t_camposObligatorios#"")
				CD_Dlog (0;__ ("El campo ^0 debe ser completado obligatoriamente antes de guardar el registro de una familia";$t_camposObligatorios))
			: ($t_datosNoUnicos#"")
				CD_Dlog (0;__ ("El campo ^0 debe tener valor único para permitir guardar el registro de una familia.";$t_datosNoUnicos))
			: ($t_datoNoValido#"")
				CD_Dlog (0;__ ("El campo ^0 no tiene un dato válido que permita guardar el registro de una familia.";$t_datoNoValido))
		End case 
		
		$0:=-1
	Else 
		SAVE RECORD:C53([Familia:78])
		$0:=1
	End if 
Else 
	$0:=0
End if 