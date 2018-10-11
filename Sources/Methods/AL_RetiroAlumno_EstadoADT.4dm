//%attributes = {}
  // AL_RetiroAlumno_EstadoADT()
  // Por: Alberto Bachler: 13/11/13, 08:48:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($hl_Estados;$l_idAlumno;$l_refEstadoRetiroADT)
C_TEXT:C284($t_estadoRetiroADT)

If (False:C215)
	C_LONGINT:C283(AL_RetiroAlumo_EstadoADT;$1)
End if 

$l_idAlumno:=$1

  //buscar el equivalente en ADT, para cambiar es estado a Retirado y mantener la consistencia.
READ WRITE:C146([ADT_Candidatos:49])
QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_numero:1=$l_idAlumno)
If (Records in selection:C76([ADT_Candidatos:49])>0)
	$hl_Estados:=ADTcfg_LoadEstados 
	$l_refEstadoRetiroADT:=Num:C11(PREF_fGet (0;"estadoRetiroADT";"0"))
	If ($l_refEstadoRetiroADT>0)  //ASM 20130212 Cuando el estado de retiro es cero, da error de lista.
		$t_estadoRetiroADT:=HL_FindInListByReference ($hl_Estados;$l_refEstadoRetiroADT;True:C214)
		If ($t_estadoRetiroADT#"")
			[ADT_Candidatos:49]Estado:52:=$t_estadoRetiroADT
		End if 
	End if 
	SAVE RECORD:C53([ADT_Candidatos:49])
End if 
KRL_UnloadReadOnly (->[ADT_Candidatos:49])

