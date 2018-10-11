Case of 
	: (Form event:C388=On Load:K2:1)
		C_OBJECT:C1216($ob_objetoDir;$ob_direccion2;$ob_objetoPersona)
		C_POINTER:C301($y_datos;$y_valores;$y_campos)
		
		ARRAY LONGINT:C221($al_campos;0)
		ARRAY TEXT:C222($at_valores;0)
		
		$y_datos:=OBJECT Get pointer:C1124(Object named:K67:5;"atACTdf_datos")
		$y_valores:=OBJECT Get pointer:C1124(Object named:K67:5;"atACTdf_valores")
		$y_campos:=OBJECT Get pointer:C1124(Object named:K67:5;"alACTdf_campos")
		
		  //Lee información guardada
		If (OB Is defined:C1231([ACT_Terceros:138]OB_Direccion_Facturacion:82;"objeto_facturacion"))
			$ob_objetoPersona:=OB Get:C1224([ACT_Terceros:138]OB_Direccion_Facturacion:82;"objeto_facturacion")
			If (OB Is defined:C1231($ob_objetoPersona;"campos"))
				OB GET ARRAY:C1229($ob_objetoPersona;"campos";$al_campos)
				OB GET ARRAY:C1229($ob_objetoPersona;"valores";$at_valores)
			End if 
		End if 
		$ob_objetoDir:=ACTpp_DireccionDeFacturacion ("ObtieneObjetoDireccionFacturacion")
		$ob_direccion2:=OB Get:C1224($ob_objetoDir;"campos_direccion_facturacion";Is object:K8:27)
		OB GET ARRAY:C1229($ob_direccion2;"nombres";$y_datos->)
		OB GET ARRAY:C1229($ob_direccion2;"terceros";$y_campos->)
		AT_RedimArrays (Size of array:C274($y_datos->);$y_valores)
		
		  //Actualiza valores de arreglo a desplegar
		If (Size of array:C274($al_campos)>0)
			For ($l_indice;1;Size of array:C274($al_campos))
				If ($at_valores{$l_indice}#"")
					$l_pos:=Find in array:C230($y_campos->;$al_campos{$l_indice})
					If ($l_pos>0)
						$y_valores->{$l_pos}:=$at_valores{$l_indice}
					End if 
				End if 
			End for 
		End if 
		
End case 

