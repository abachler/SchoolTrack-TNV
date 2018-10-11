  // [xShell_RecordNotes].Lista()
  // Por: Alberto Bachler K.: 18-03-15, 19:10:06
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		CLEAR SET:C117("$ListboxSet0")
		CREATE EMPTY SET:C140([xShell_RecordNotes:283];"$ListboxSet0")
		ORDER BY:C49([xShell_RecordNotes:283];[xShell_RecordNotes:283]DTS:6;<)
		FIRST RECORD:C50([xShell_RecordNotes:283])
		ADD TO SET:C119([xShell_RecordNotes:283];"$ListboxSet0")
		$y_fechaUsuario:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha_y_usuario")
		$y_fechaUsuario->:=__ ("Anotación registrada el ")+DT_FechaISO_a_FechaHora ([xShell_RecordNotes:283]DTS:6)+__ (" por ")+[xShell_RecordNotes:283]Usuario:5
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 
