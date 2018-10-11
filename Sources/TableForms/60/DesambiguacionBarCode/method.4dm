  // [BBL_Préstamos].DesambiguacionBarCode()
  // Por: Alberto Bachler: 29/08/13, 18:52:53
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_objeto_abajo;$l_objeto_arriba;$l_objeto_derecha;$l_objeto_izquierda)
C_POINTER:C301($y_objeto;$y_nil)
C_TEXT:C284($t_objetoAnterior;$t_ObjetoDuplicado)


Case of 
	: (Form event:C388=On Load:K2:1)
		$t_variable:="vtBBL_DetalleRegistro1"
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;$t_variable)
		$y_objeto->:=atBBL_CodigosBarra_nombre{1}
		
		$t_variable:="vpBBL_Imagen1"
		$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;$t_variable)
		$y_objeto->:=apBBL_CodigosBarra_imagen{1}
		If (Picture size:C356($y_objeto->)=0)
			OBJECT SET VISIBLE:C603(*;$t_variable;False:C215)
		End if 
		
		For ($i_registros;2;Size of array:C274(atBBL_CodigosBarra_nombre))
			  // duplico el rectángulo
			$t_nuevoNombre:="Rectángulo"+String:C10($i_registros)
			OBJECT DUPLICATE:C1111(*;"Rectángulo1";$t_nuevoNombre;$y_Nil;"";0;77*($i_registros-1))
			
			  // duplico la variable
			$t_nuevoNombre:="vtBBL_DetalleRegistro"+String:C10($i_registros)
			OBJECT DUPLICATE:C1111(*;"vtBBL_DetalleRegistro1";$t_nuevoNombre;$y_Nil;"";0;77*($i_registros-1))
			$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;$t_nuevoNombre)
			$y_objeto->:=atBBL_CodigosBarra_nombre{$i_registros}
			
			  // duplico la variable  imagen
			$t_nuevoNombre:="vpBBL_Imagen"+String:C10($i_registros)
			OBJECT DUPLICATE:C1111(*;"vpBBL_Imagen1";$t_nuevoNombre;$y_Nil;"";0;77*($i_registros-1))
			$y_objeto:=OBJECT Get pointer:C1124(Object named:K67:5;$t_nuevoNombre)
			$y_objeto->:=apBBL_CodigosBarra_imagen{$i_registros}
			If (Picture size:C356($y_objeto->)=0)
				OBJECT SET VISIBLE:C603(*;$t_nuevoNombre;False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*;$t_nuevoNombre;True:C214)
			End if 
			
			  // duplico el boton
			$t_nuevoNombre:="opcion"+String:C10($i_registros)
			OBJECT DUPLICATE:C1111(*;"opcion1";$t_nuevoNombre;$y_Nil;"";0;77*($i_registros-1))
		End for 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

