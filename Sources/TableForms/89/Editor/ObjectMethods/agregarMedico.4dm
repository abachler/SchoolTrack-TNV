  // [STR_Medicos].Input.inscribir()
  // Por: Alberto Bachler K.: 27-06-14, 15:26:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		IT_MuestraTip (__ ("Agregar un médico"))
		
		
	: (Form event:C388=On Clicked:K2:4)
		CREATE RECORD:C68([STR_Medicos:89])
		[STR_Medicos:89]ID:3:=SQ_SeqNumber (->[STR_Medicos:89]ID:3)
		OBJECT SET TITLE:C194(*;"boton";__ ("Aceptar"))
		OBJECT SET ENABLED:C1123(*;"boton";False:C215)
		OBJECT SET RGB COLORS:C628(*;"boton";<>vl_ColorTextoBoton_Azul;Background color:K23:2)
		OBJECT SET ENTERABLE:C238(*;"campo@";True:C214)
		FORM GOTO PAGE:C247(2)
		
		
End case 