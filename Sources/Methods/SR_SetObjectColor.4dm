//%attributes = {}
  // SR_SetObjectColor()
  // Por: Alberto Bachler K.: 15-08-15, 10:38:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_error;$l_colorFondoAzul;$l_colorFondoRojo;$l_colorFondoVerde;$l_colorHexa;$l_colorTextoAzul;$l_colorTextoRojo;$l_colorTextoVerde;$l_plano)
C_TEXT:C284($t_colorFondo;$t_colorFondoAzul;$t_colorFondoHexa;$t_colorFondoRojo;$t_colorFondoVerde;$t_colorTexto;$t_colorTextoAzul;$t_colorTextoHexa;$t_colorTextoRojo;$t_colorTextoVerde)


If (False:C215)
	C_TEXT:C284(SR_SetObjectColor ;$1)
	C_TEXT:C284(SR_SetObjectColor ;$2)
	C_LONGINT:C283(SR_SetObjectColor ;$3)
End if 

Case of 
	: (Count parameters:C259=3)
		$l_plano:=$3
		$t_colorTexto:=$1
		$t_colorFondo:=$2
	: (Count parameters:C259=2)
		$t_colorTexto:=$1
		$t_colorFondo:=$2
	: (Count parameters:C259=1)
		$t_colorTexto:=$1
		$t_colorFondo:="White"
	: (Count parameters:C259=0)
		$t_colorTexto:="black"
		$t_colorFondo:="White"
End case 

Case of 
	: (($t_colorTexto="Red") | ($t_colorTexto="Rojo") | ($t_colorTexto="Rouge") | ($t_colorTexto="Rot") | ($t_colorTexto="vermelho"))
		$l_colorTextoRojo:=65535
		$t_colorTextoHexa:="#FF0000"
	: (($t_colorTexto="Blue") | ($t_colorTexto="Azul") | ($t_colorTexto="Bleu") | ($t_colorTexto="Blau") | ($t_colorTexto="Azul"))
		$l_colorTextoAzul:=65535
		$l_colorHexa:=0x00FF
		$t_colorTextoHexa:="#0000FF"
	: (($t_colorTexto="Green") | ($t_colorTexto="Verde") | ($t_colorTexto="Vert") | ($t_colorTexto="Grün") | ($t_colorTexto="Verde"))
		$l_colorTextoVerde:=39321
		$t_colorTextoHexa:="#008000"
	: (($t_colorTexto="Light Green") | ($t_colorTexto="Verde Claro") | ($t_colorTexto="Vert Clair") | ($t_colorTexto="Hellgrün") | ($t_colorTexto="Verde Claro"))
		$l_colorTextoVerde:=48059
		$t_colorTextoHexa:="#00E000"
	: (($t_colorTexto="Yellow") | ($t_colorTexto="Amarillo") | ($t_colorTexto="Jaune") | ($t_colorTexto="Gelb") | ($t_colorTexto="Amarelo"))
		$l_colorTextoRojo:=65535
		$l_colorTextoVerde:=65535
		$t_colorTextoHexa:="#FFF00"
	: (($t_colorTexto="Orange") | ($t_colorTexto="Naranja") | ($t_colorTexto="Orange") | ($t_colorTexto="Apfelsine") | ($t_colorTexto="Alaranjado"))
		$l_colorTextoRojo:=65535
		$l_colorTextoVerde:=26214
		$t_colorTextoHexa:="#FF8000"
	: (($t_colorTexto="Pink") | ($t_colorTexto="Rosado") | ($t_colorTexto="Rose") | ($t_colorTexto="Pink") | ($t_colorTexto="Cor da rosa") | ($t_colorTexto="Rosa"))
		$l_colorTextoRojo:=65535
		$l_colorTextoAzul:=39321
		$t_colorTextoHexa:="#FF00A0"
	: (($t_colorTexto="Light Blue") | ($t_colorTexto="Azul Claro") | ($t_colorTexto="Bleu Clair") | ($t_colorTexto="Hellblau") | ($t_colorTexto="Azul Claro"))
		  //AOQ 20170401 Ticket 196832 Hexa no corresponde al color trae un verde
		$l_colorTextoVerde:=39321
		$l_colorTextoAzul:=65535
		$t_colorTextoHexa:="#38AEEE"
	: (($t_colorTexto="Dark Blue") | ($t_colorTexto="Azul Marino") | ($t_colorTexto="Bleu foncé") | ($t_colorTexto="Dunkelblau") | ($t_colorTexto="Azul Escuro"))
		$l_colorTextoAzul:=39321
		$t_colorTextoHexa:="#0000A0"
	: (($t_colorTexto="Brown") | ($t_colorTexto="Marrón") | ($t_colorTexto="Marron") | ($t_colorTexto="Braun") | ($t_colorTexto="Marrom"))
		$l_colorTextoRojo:=26214
		$l_colorTextoVerde:=13107
		$t_colorTextoHexa:="#602000"
	: (($t_colorTexto="Light Brown") | ($t_colorTexto="Marrón claro") | ($t_colorTexto="Marrón clair") | ($t_colorTexto="Hellbraun") | ($t_colorTexto="Marrom Claro"))
		$l_colorTextoRojo:=39321
		$l_colorTextoVerde:=26214
		$l_colorHexa:=0x00FFA060
		$t_colorTextoHexa:="#FFA060"
	: (($t_colorTexto="Dark Grey") | ($t_colorTexto="Gris Oscuro") | ($t_colorTexto="Gris foncé") | ($t_colorTexto="Dunkles Grau") | ($t_colorTexto="Cinzento Escuro"))
		$l_colorTextoRojo:=17476
		$l_colorTextoVerde:=17476
		$l_colorTextoAzul:=17476
		$t_colorTextoHexa:="#505050"
	: (($t_colorTexto="Grey") | ($t_colorTexto="Gris") | ($t_colorTexto="Gris") | ($t_colorTexto="Grau") | ($t_colorTexto="Cinzento"))
		$l_colorTextoRojo:=43690
		$l_colorTextoVerde:=43690
		$l_colorTextoAzul:=43690
		$t_colorTextoHexa:="#B0B0B0"
	: (($t_colorTexto="Light Grey") | ($t_colorTexto="Gris Claro") | ($t_colorTexto="Gris Clair") | ($t_colorTexto="Hellgrau") | ($t_colorTexto="Cinzento claro"))
		$l_colorTextoRojo:=52750
		$l_colorTextoVerde:=52750
		$l_colorTextoAzul:=52750
		$t_colorTextoHexa:="#C0C0C0"
	: ($t_colorTexto="")
		$l_colorTextoRojo:=56797
		$l_colorTextoVerde:=56797
		$l_colorTextoAzul:=56797
		$t_colorTextoHexa:="#000000"
	: (($t_colorTexto="White") | ($t_colorTexto="Blanco") | ($t_colorTexto="Blanc") | ($t_colorTexto="Weiß") | ($t_colorTexto="Branco"))
		$l_colorTextoRojo:=65535
		$l_colorTextoVerde:=65535
		$l_colorTextoAzul:=65535
		$t_colorTextoHexa:="#FFFFFF"
	: (($t_colorTexto="Black") | ($t_colorTexto="Negro") | ($t_colorTexto="Noir") | ($t_colorTexto="Schwarzes") | ($t_colorTexto="Preto") | ($t_colorTexto="Black"))
		$t_colorTextoHexa:="#000000"
End case 


Case of 
	: (($t_colorFondo="Red") | ($t_colorFondo="Rojo") | ($t_colorFondo="Rouge") | ($t_colorFondo="Rot") | ($t_colorFondo="vermelho"))
		$l_colorFondoRojo:=65535
		$t_colorFondoHexa:="#FF0000"
	: (($t_colorFondo="Blue") | ($t_colorFondo="Azul") | ($t_colorFondo="Bleu") | ($t_colorFondo="Blau") | ($t_colorFondo="Azul"))
		$l_colorFondoAzul:=65535
		$l_colorHexa:=0x00FF
		$t_colorFondoHexa:="#0000FF"
	: (($t_colorFondo="Green") | ($t_colorFondo="Verde") | ($t_colorFondo="Vert") | ($t_colorFondo="Grün") | ($t_colorFondo="Verde"))
		$l_colorFondoVerde:=39321
		$t_colorFondoHexa:="#008000"
	: (($t_colorFondo="Light Green") | ($t_colorFondo="Verde Claro") | ($t_colorFondo="Vert Clair") | ($t_colorFondo="Hellgrün") | ($t_colorFondo="Verde Claro"))
		$l_colorFondoVerde:=48059
		$t_colorFondoHexa:="#00E000"
	: (($t_colorFondo="Yellow") | ($t_colorFondo="Amarillo") | ($t_colorFondo="Jaune") | ($t_colorFondo="Gelb") | ($t_colorFondo="Amarelo"))
		$l_colorFondoRojo:=65535
		$l_colorFondoVerde:=65535
		$t_colorFondoHexa:="#FFFF00"
	: (($t_colorFondo="Orange") | ($t_colorFondo="Naranja") | ($t_colorFondo="Orange") | ($t_colorFondo="Apfelsine") | ($t_colorFondo="Alaranjado"))
		$l_colorFondoRojo:=65535
		$l_colorFondoVerde:=26214
		$t_colorFondoHexa:="#FF8000"
	: (($t_colorFondo="Pink") | ($t_colorFondo="Rosado") | ($t_colorFondo="Rose") | ($t_colorFondo="Pink") | ($t_colorFondo="Cor da rosa") | ($t_colorFondo="Rosa"))
		$l_colorFondoRojo:=65535
		$l_colorFondoAzul:=39321
		$t_colorFondoHexa:="#FF00A0"
	: (($t_colorFondo="Light Blue") | ($t_colorFondo="Azul Claro") | ($t_colorFondo="Bleu Clair") | ($t_colorFondo="Hellblau") | ($t_colorFondo="Azul Claro"))
		  //AOQ 20170401 Ticket 196832 Hexa no corresponde al color trae un verde
		$l_colorFondoVerde:=39321
		$l_colorFondoAzul:=65535
		$t_colorFondoHexa:="#38AEEE"
	: (($t_colorFondo="Dark Blue") | ($t_colorFondo="Azul Marino") | ($t_colorFondo="Bleu foncé") | ($t_colorFondo="Dunkelblau") | ($t_colorFondo="Azul Escuro"))
		$l_colorFondoAzul:=39321
		$t_colorFondoHexa:="#0000A0"
	: (($t_colorFondo="Brown") | ($t_colorFondo="Marrón") | ($t_colorFondo="Marron") | ($t_colorFondo="Braun") | ($t_colorFondo="Marrom"))
		$l_colorFondoRojo:=26214
		$l_colorFondoVerde:=13107
		$t_colorFondoHexa:="#602000"
	: (($t_colorFondo="Light Brown") | ($t_colorFondo="Marrón claro") | ($t_colorFondo="Marrón clair") | ($t_colorFondo="Hellbraun") | ($t_colorFondo="Marrom Claro"))
		$l_colorFondoRojo:=39321
		$l_colorFondoVerde:=26214
		$l_colorHexa:=0x00FFA060
		$t_colorFondoHexa:="#FFA060"
	: (($t_colorFondo="Dark Grey") | ($t_colorFondo="Gris Oscuro") | ($t_colorFondo="Gris foncé") | ($t_colorFondo="Dunkles Grau") | ($t_colorFondo="Cinzento Escuro"))
		$l_colorFondoRojo:=17476
		$l_colorFondoVerde:=17476
		$l_colorFondoAzul:=17476
		$t_colorFondoHexa:="#505050"
	: (($t_colorFondo="Grey") | ($t_colorFondo="Gris") | ($t_colorFondo="Gris") | ($t_colorFondo="Grau") | ($t_colorFondo="Cinzento"))
		$l_colorFondoRojo:=43690
		$l_colorFondoVerde:=43690
		$l_colorFondoAzul:=43690
		$t_colorFondoHexa:="#B0B0B0"
	: (($t_colorFondo="Light Grey") | ($t_colorFondo="Gris Claro") | ($t_colorFondo="Gris Clair") | ($t_colorFondo="Hellgrau") | ($t_colorFondo="Cinzento claro"))
		$l_colorFondoRojo:=52750
		$l_colorFondoVerde:=52750
		$l_colorFondoAzul:=52750
		$t_colorFondoHexa:="#C0C0C0"
	: ($t_colorFondo="")
		  //MONO: Ticket 182057 deja por defecto el negro, cuando usas el "Color texto" lo cambio a blanco
		  //$l_colorFondoRojo:=56797
		  //$l_colorFondoVerde:=56797
		  //$l_colorFondoAzul:=56797
		  //$t_colorFondoHexa:="#000000"
		$l_colorFondoRojo:=65535
		$l_colorFondoVerde:=65535
		$l_colorFondoAzul:=65535
		$t_colorFondoHexa:="#FFFFFF"
	: (($t_colorFondo="White") | ($t_colorFondo="Blanco") | ($t_colorFondo="Blanc") | ($t_colorFondo="Weiß") | ($t_colorFondo="Branco"))
		$l_colorFondoRojo:=65535
		$l_colorFondoVerde:=65535
		$l_colorFondoAzul:=65535
		$t_colorFondoHexa:="#FFFFFF"
	: (($t_colorFondo="Black") | ($t_colorFondo="Negro") | ($t_colorFondo="Noir") | ($t_colorFondo="Schwarzes") | ($t_colorFondo="Preto") | ($t_colorFondo="Black"))
		$t_colorFondoHexa:="#000000"
End case 


  //SR_SetTextProperty (SRArea;SRObjectPrintRef;SRP_Style_TextColor;$t_colorTextoHexa)
  //SR_SetTextProperty (SRArea;SRObjectPrintRef;SRP_Style_BackColor;$t_colorFondoHexa)
  //20171003 RCH Se agrega caso para setear por separado color texto y color fondo
Case of 
	: (($l_plano=0) | ($l_plano=3))
		  //$l_error:=SR Set Object Format (SRArea;SRObjectPrintRef;SR Attribute Fore Color+SR Attribute Back Color;"";0;0;0;"";$l_colorTextoRojo;$l_colorTextoVerde;$l_colorTextoAzul;65535;65535;65535;0;0;0;0;0)
		SR_SetTextProperty (SRArea;SRObjectPrintRef;SRP_Style_TextColor;$t_colorTextoHexa)
		SR_SetTextProperty (SRArea;SRObjectPrintRef;SRP_Style_BackColor;$t_colorFondoHexa)
		
	: ($l_plano=1)
		SR_SetTextProperty (SRArea;SRObjectPrintRef;SRP_Style_TextColor;$t_colorTextoHexa)
		  //$l_error:=SR Set Object Format (SRArea;SRObjectPrintRef;SR Attribute Fore Color;"";0;0;0;"";$l_colorTextoRojo;$l_colorTextoVerde;$l_colorTextoAzul;$l_colorFondoRojo;$l_colorFondoVerde;$l_colorFondoAzul;0;0;0;0;0)
	: ($l_plano=2)
		SR_SetTextProperty (SRArea;SRObjectPrintRef;SRP_Style_BackColor;$t_colorFondoHexa)
		  //$l_error:=SR Set Object Format (SRArea;SRObjectPrintRef;SR Attribute Back Color;"";0;0;0;"";$l_colorTextoRojo;$l_colorTextoVerde;$l_colorTextoAzul;$l_colorFondoRojo;$l_colorFondoVerde;$l_colorFondoAzul;0;0;0;0;0)
End case 



