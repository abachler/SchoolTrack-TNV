//%attributes = {}
  //Spell_CheckSpelling

C_BOOLEAN:C305(vbSpell_StopChecking)
If (Not:C34(vbSpell_StopChecking))
	Case of 
		: ((<>vb_SpellCheckNow) & (Form event:C388=On Outside Call:K2:11))
			SPELL CHECKING:C900
			<>vb_SpellCheckNow:=False:C215
			
		: ((<>vb_AutoSpellCheck) & (Form event:C388=On Data Change:K2:15))
			$currentObjet:=Focus object:C278
			RESOLVE POINTER:C394($currentObjet;$t_nombreVariable;$l_numeroTabla;$l_numeroCampo)
			If (Not:C34(Is nil pointer:C315($currentObjet)))
				$l_tipo:=Type:C295($currentObjet->)
				  //20130520 ASM No se estaba verificando la ortografía en algunos casos.
				Case of 
					: (($l_numeroCampo>0) & ($l_tipo=Is text:K8:3) & <>vb_SpellCheckTextFieldOnly)
						$b_verificar:=True:C214
					: (($l_numeroCampo>0) & (($l_tipo=Is alpha field:K8:1) | ($l_tipo=Is text:K8:3)) & Not:C34(<>vb_SpellCheckTextFieldOnly))
						$b_verificar:=True:C214
					: ($t_nombreVariable="vt@")
						$b_verificar:=True:C214
					Else 
						$b_verificar:=False:C215
				End case 
				  //$b_verificar:=($l_numeroCampo>0) & ($l_tipo=Is Text) & <>vb_SpellCheckTextFieldOnly
				  //$b_verificar:=$b_verificar | ($l_numeroCampo>0) & ($l_tipo=Is Alpha Field) & Not(<>vb_SpellCheckTextFieldOnly)
				  //$b_verificar:=$b_verificar | ($t_nombreVariable="vt_@")
				If ($b_verificar)
					SPELL CHECKING:C900
					$currentObjet->:=Get edited text:C655  //Mono Ticket 181979
				End if 
			End if 
			<>vb_SpellCheckNow:=False:C215
	End case 
Else 
	vbSpell_StopChecking:=False:C215
End if 


