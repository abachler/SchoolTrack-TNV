  // 4D_ObjetosInutilizados.lb_comandos()
  // Por: Alberto Bachler K.: 29-07-15, 21:47:38
  //  ---------------------------------------------
  //
  //
  //  --------------------------------------------
C_BOOLEAN:C305($b_editar;$b_muestraUso)
C_LONGINT:C283($i;$l_elemento;$l_opcion)
C_POINTER:C301($y_comandos;$y_comandosObjeto;$y_metodos;$y_usoCodigo;$y_usoRutas)
C_TEXT:C284($t_metodo)
C_OBJECT:C1216($ob_llamados)

ARRAY POINTER:C280($ay_jerarquia;0)

$y_metodos:=OBJECT Get pointer:C1124(Object named:K67:5;"metodos")
$y_comandos:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_comandosObjeto:=OBJECT Get pointer:C1124(Object named:K67:5;"comandosObjeto")

$t_metodo:=$y_comandos->{$y_comandos->}

$y_usoRutas:=OBJECT Get pointer:C1124(Object named:K67:5;"usoRuta")
$y_usoCodigo:=OBJECT Get pointer:C1124(Object named:K67:5;"usoLinea")



Case of 
	: (Form event:C388=On Clicked:K2:4)
		Case of 
			: (Macintosh option down:C545 | Windows Alt down:C563)
				$b_muestraUso:=True:C214
			: (Contextual click:C713)
				$l_opcion:=Pop up menu:C542("Ver llamados…;Editar método")
				Case of 
					: ($l_opcion=1)
						$b_muestraUso:=True:C214
					: ($l_opcion=2)
						$b_editar:=True:C214
				End case 
		End case 
		
	: (Form event:C388=On Double Clicked:K2:5)
		$b_editar:=True:C214
End case 

Case of 
	: ($b_muestraUso)
		CLEAR VARIABLE:C89($ob_llamados)
		$ob_llamados:=$y_comandosObjeto->{$y_comandos->}
		OB_GET ($ob_llamados;$y_usoRutas;"metodo")
		OB_GET ($ob_llamados;$y_usoCodigo;"codigo")
		
		APPEND TO ARRAY:C911($ay_jerarquia;$y_usoRutas)
		LISTBOX SET HIERARCHY:C1098(*;"uso_Referencias";True:C214;$ay_jerarquia)
		
		OBJECT SET TITLE:C194(*;"metodoactual";$t_metodo)
		FORM GOTO PAGE:C247(2)
		
	: ($b_editar)
		METHOD OPEN PATH:C1213($y_comandos->{$y_comandos->};*)
		
End case 