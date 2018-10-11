ARRAY TEXT:C222(at_PrintCategoria;0)
ARRAY TEXT:C222(at_PrintMotivo;0)
ARRAY LONGINT:C221(al_PrintPuntajeCat;0)
ARRAY LONGINT:C221(al_PrintPuntajeMot;0)
COPY ARRAY:C226(<>atSTR_Anotaciones_categorias;at_PrintCategoria)
COPY ARRAY:C226(<>atSTR_Anotaciones_motivo;at_PrintMotivo)
COPY ARRAY:C226(<>aiSTR_Anotaciones_puntaje;al_PrintPuntajeCat)
COPY ARRAY:C226(<>aiSTR_Anotaciones_motivo_puntaj;al_PrintPuntajeMot)

ARRAY TEXT:C222(at_PrintTipoCateg;0)
ARRAY TEXT:C222(at_PrintTipoCateg;Size of array:C274(<>aiID_Matriz))
For ($i;1;Size of array:C274(<>aiID_Matriz))
	$encontrado:=Find in array:C230(aiSTR_IDCategoria;<>aiID_Matriz{$i})
	If ($encontrado>0)
		Case of 
			: (ai_TipoAnotacion{$encontrado}=-1)
				at_PrintTipoCateg{$i}:="Negativa"
				al_PrintPuntajeMot{$i}:=al_PrintPuntajeMot{$i}*-1
				al_PrintPuntajeCat{$i}:=al_PrintPuntajeCat{$i}*-1
			: (ai_TipoAnotacion{$encontrado}=1)
				at_PrintTipoCateg{$i}:="Positiva"
			: (ai_TipoAnotacion{$encontrado}=0)
				at_PrintTipoCateg{$i}:="Neutra"
		End case 
	Else 
		at_PrintTipoCateg{$i}:="-"
	End if 
	
End for 



PRINT SETTINGS:C106
READ ONLY:C145([xxSTR_Constants:1])
ALL RECORDS:C47([xxSTR_Constants:1])
ONE RECORD SELECT:C189([xxSTR_Constants:1])
FORM SET OUTPUT:C54([xxSTR_Constants:1];"STR_CFG_PrintMotivosAnot")
PRINT SELECTION:C60([xxSTR_Constants:1];>)