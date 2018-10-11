//%attributes = {}
  // MPAcfg_Area_EsValida()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/07/12, 13:05:56
  // ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_registroValido)
C_POINTER:C301($y_objectPointer)
C_TEXT:C284($t_mensaje)

If (False:C215)
	C_BOOLEAN:C305(MPAcfg_Area_EsValida ;$0)
End if 



  // CÓDIGO
$b_registroValido:=True:C214
Case of 
	: ([MPA_DefinicionAreas:186]AreaAsignatura:4="")
		$b_registroValido:=False:C215
		$t_mensaje:=__ ("Un área de aprendizaje debe tener obligatoriamente un nombre.")
		$y_objectPointer:=->[MPA_DefinicionAreas:186]AreaAsignatura:4
		If (Old:C35($y_objectPointer->)#"")
			$y_objectPointer->:=Old:C35($y_objectPointer->)
			OBJECT SET VISIBLE:C603(*;"ot_MensajeEntrada";False:C215)
		End if 
		
	: ($b_registroValido & (Not:C34(MPAcfg_Area_EsUnica )))
		$b_registroValido:=False:C215
		$t_mensaje:=__ ("Ya existe un área con este nombre.\r\rPor favor registre un nombre único.")
		$y_objectPointer:=->[MPA_DefinicionAreas:186]AreaAsignatura:4
End case 

If (Not:C34($b_registroValido))
	CD_Dlog (0;$t_mensaje)
	If (Not:C34(Is nil pointer:C315($y_objectPointer)))
		GOTO OBJECT:C206($y_objectPointer->)
		If ((Type:C295($y_objectPointer->)=Is text:K8:3) | (Type:C295($y_objectPointer->)=Is alpha field:K8:1))
			HIGHLIGHT TEXT:C210($y_objectPointer->;1;Length:C16($y_objectPointer->)+1)
		End if 
	End if 
End if 

$0:=$b_registroValido