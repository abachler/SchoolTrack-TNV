  // [SN3_PublicationPrefs].GAFE.ListNiveles1()
  // Por: Alberto Bachler K.: 21-12-13, 14:39:54
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283(vHeaderMail;vHeaderDrive)

If (Form event:C388=On Header Click:K2:40)
	$y_Encabezado:=OBJECT Get pointer:C1124(Object current:K67:2)
	Case of 
		: ($y_Encabezado=->vHeaderMail)
			For ($i;1;Size of array:C274(SN3_GAFE_Alu_Mail))
				SN3_GAFE_Alu_Mail{$i}:=mailHeaderNextAction
			End for 
			mailHeaderNextAction:=Not:C34(mailHeaderNextAction)
		: ($y_Encabezado=->vHeaderDrive)
			For ($i;1;Size of array:C274(SN3_GAFE_Alu_Drive))
				SN3_GAFE_Alu_Drive{$i}:=driveHeaderNextAction
			End for 
			driveHeaderNextAction:=Not:C34(driveHeaderNextAction)
			  //: (Self=->vHeaderCal)
			  //For ($i;1;Size of array(SN3_GAFE_Alu_Cal))
			  //SN3_GAFE_Alu_Cal{$i}:=calHeaderNextAction
			  //End for 
			  //calHeaderNextAction:=Not(calHeaderNextAction)
	End case 
	GAFESettingsModificados:=True:C214
End if 