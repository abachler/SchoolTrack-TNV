  //$r:=CD_Dlog (0;__ ("SchoolNet enviará los datos de acceso a todos los usuarios que tengan una dirección de eMail registrada en SchoolNet 3. ¿Desea proceder?");__ ("");__ ("No");__ ("Si"))
  //If ($r=2)
  //SN3_SendUserAccessData 
  //End if 
  // 20131118 ASM Ticket  96825 
$r:=CD_Dlog (0;__ ("SchoolNet enviará los datos de acceso a todos los usuarios que tengan una dirección de eMail registrada en SchoolNet 3. ¿Desea proceder?");__ ("");__ ("No");__ ("Si");__ ("Mostrar usuarios sin mail"))
Case of 
	: ($r=2)
		SN3_SendUserAccessData 
	: ($r=3)
		SN3_ReporteUsuariosSinMail 
End case 