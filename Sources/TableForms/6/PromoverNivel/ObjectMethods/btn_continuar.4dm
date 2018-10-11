If (Form event:C388=On Clicked:K2:4)
	ARRAY LONGINT:C221($al_nivSel;0)
	ARRAY TEXT:C222($at_nivNombre;0)
	ARRAY TEXT:C222($at_nombrePropiedades;0)
	C_POINTER:C301($y_lbColSeleccion;$y_lbColNiveles;$y_lbColNoNivel)
	C_LONGINT:C283($i;$l_resp;$l_propiedades)
	C_TEXT:C284($t_msg;$t_niveles)
	C_OBJECT:C1216($o_log;$o_promoInfo)
	C_BOOLEAN:C305($b_OK)
	
	$y_lbColNoNivel:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColNoNivel")
	$y_lbColNiveles:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColNiveles")
	$y_lbColSeleccion:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColSeleccion")
	
	For ($i;1;Size of array:C274($y_lbColSeleccion->))
		If ($y_lbColSeleccion->{$i})
			APPEND TO ARRAY:C911($al_nivSel;$y_lbColNoNivel->{$i})
			$t_niveles:=$t_niveles+$y_lbColNiveles->{$i}+"\n"
		End if 
	End for 
	
	If (Size of array:C274($al_nivSel)>0)
		$t_msg:=__ ("Se dispone a promover los siguientes niveles:")+"\n"
		$t_msg:=$t_msg+$t_niveles
		$t_msg:=$t_msg+__ ("¿Desea continuar?")
		$l_resp:=CD_Dlog (0;$t_msg;"";__ ("Si");__ ("No"))
		
		If ($l_resp=1)
			SORT ARRAY:C229($al_nivSel;<)
			NIV_promoverNiveles (->$al_nivSel)
			  //registramos en un objeto un dts como nodo que contiene los niveles promovidos y el usuario que ejecutó la promoción
			For ($i;1;Size of array:C274($al_nivSel))
				$fia:=Find in array:C230(<>al_NumeroNivelesActivos;$al_nivSel{$i})
				APPEND TO ARRAY:C911($at_nivNombre;<>at_NombreNivelesActivos{$fia})
			End for 
			$o_log:=OB_Create 
			$o_log:=PREF_fGetObject (0;"LOG_PROMOCION_NIVEL";$o_log)
			$l_propiedades:=OB_GetChildNodes ($o_log;->$at_nombrePropiedades)
			$o_promoInfo:=OB_Create 
			OB SET ARRAY:C1227($o_promoInfo;"NoNiveles";$al_nivSel)
			OB SET ARRAY:C1227($o_promoInfo;"Niveles";$at_nivNombre)
			OB SET:C1220($o_promoInfo;"usuario";USR_CurrentUser )
			OB SET:C1220($o_log;String:C10($l_propiedades)+"_"+DTS_MakeFromDateTime ;$o_promoInfo)
			PREF_SetObject (0;"LOG_PROMOCION_NIVEL";$o_log)
			
			$y_lbColSeleccion:=OBJECT Get pointer:C1124(Object named:K67:5;"lbColSeleccion")
			For ($i;1;Size of array:C274($y_lbColSeleccion->))
				$y_lbColSeleccion->{$i}:=False:C215
			End for 
			OBJECT Get pointer:C1124(Object named:K67:5;"totalAlumnos")->:=0
			OBJECT Get pointer:C1124(Object named:K67:5;"alumnosPromovidos")->:=0
			OBJECT Get pointer:C1124(Object named:K67:5;"alumnosReprobados")->:=0
			OBJECT Get pointer:C1124(Object named:K67:5;"alumnosRetirados")->:=0
			OBJECT Get pointer:C1124(Object named:K67:5;"alumnosEspeciales")->:=0
			OBJECT Get pointer:C1124(Object named:K67:5;"alumnosPendientes")->:=0
			
			CD_Dlog (0;__ ("Proceso de promoción finalizado"))
		End if 
	Else 
		CD_Dlog (0;__ ("No hay niveles seleccionados para promover."))
	End if 
	
End if 