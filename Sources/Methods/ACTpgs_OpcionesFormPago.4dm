//%attributes = {}
  //ACTpgs_OpcionesFormPago

C_TEXT:C284($1;$vt_accion;$ProcName)
C_LONGINT:C283($vl_protestos)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="SetColorNombrePersona")
		$ProcName:=$ptr1->
		If (($ProcName="Ingreso de Pagos") | ($ProcName="Documentar Deudas"))
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_protestos)
			QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2=[Personas:7]No:1;*)
			QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Ch_Protestadoel:11#!00-00-00!;*)
			QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Reemplazado:14=False:C215)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			ACTpgs_OpcionesFormPago ("SetColor";->$vl_protestos)
		End if 
		
	: ($vt_accion="SetColorNombreTercero")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_protestos)
		QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Tercero:18=[ACT_Terceros:138]Id:1;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Ch_Protestadoel:11#!00-00-00!;*)
		QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Reemplazado:14=False:C215)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		ACTpgs_OpcionesFormPago ("SetColor";->$vl_protestos)
		
	: ($vt_accion="SetColor")
		$vl_protestos:=$ptr1->
		If ($vl_protestos>0)
			OBJECT SET COLOR:C271(vsACT_NomApellidoTer;-(Red:K11:4+(256*White:K11:1)))
			OBJECT SET COLOR:C271(vsACT_NomApellido;-(Red:K11:4+(256*White:K11:1)))
			OBJECT SET COLOR:C271(vsACT_NomApellidoCta;-(Red:K11:4+(256*White:K11:1)))
		Else 
			OBJECT SET COLOR:C271(vsACT_NomApellidoTer;-(Blue:K11:7+(256*White:K11:1)))
			OBJECT SET COLOR:C271(vsACT_NomApellido;-(Blue:K11:7+(256*White:K11:1)))
			OBJECT SET COLOR:C271(vsACT_NomApellidoCta;-(Blue:K11:7+(256*White:K11:1)))
		End if 
		
End case 
