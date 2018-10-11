  // Método: Método de Formulario: [SN3_PublicationPrefs]UserModification
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/02/10, 18:45:14
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
Case of 
	: (Form event:C388=On Load:K2:1)
		SN3_ModUserPass:=""
		SN3_ModUserPassConfirm:=""
		cb_EnviarMail:=0
		IT_SetButtonState (False:C215;->bModify;->cb_EnviarMail)
	: (Form event:C388=On After Keystroke:K2:26)
		Focus object:C278->:=Get edited text:C655
		$cond:=((SN3_ModUserPass#"") & (SN3_ModUserPassConfirm#"") & (SN3_ModUserPass=SN3_ModUserPassConfirm) & (SN3_ModUserLogin#"") & (Length:C16(SN3_ModUserPass)>=4))
		IT_SetButtonState ($cond;->bModify;->cb_EnviarMail)
End case 



