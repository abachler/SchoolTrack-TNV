  // CIM_Indices()
  // Por: Alberto Bachler K.: 05-12-14, 10:47:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_tipoCampo)
C_POINTER:C301($y_Campo;$y_IdCampo;$y_IdIndice;$y_IdTabla;$y_NombreIndex;$y_Tabla;$y_tipoCampo;$y_TipoIndex)

ARRAY LONGINT:C221($al_IdCampos;0)
ARRAY LONGINT:C221($al_idTablas;0)
ARRAY TEXT:C222($at_IndexId;0)
ARRAY TEXT:C222($at_nombreCampo;0)
ARRAY TEXT:C222($at_nombreIndex;0)
ARRAY TEXT:C222($at_nombreTabla;0)

Case of 
	: (Form event:C388=On Load:K2:1)
		POST KEY:C465(Character code:C91("*");Command key mask:K16:1)
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

