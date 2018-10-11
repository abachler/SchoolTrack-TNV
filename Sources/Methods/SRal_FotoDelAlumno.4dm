//%attributes = {}
  // SRal_FotoDelAlumno()
  // Por: Alberto Bachler K.: 15-08-15, 13:29:04
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_PICTURE:C286($0)

C_LONGINT:C283($l_altoImagen;$l_altoObjeto;$l_anchoImagen;$l_anchoObjeto;$l_columnas;$l_elementoArreglo;$l_error;$l_filas;$l_numeroCampo;$l_numeroTabla)
C_LONGINT:C283($l_opciones;$l_orden;$l_PosAbajo;$l_PosArriba;$l_PosDerecha;$l_PosIzquierda;$l_propiedad;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV;$l_seleccionado)
C_LONGINT:C283($l_tipoCalculo;$l_tipoObjeto;$l_tipoVariable)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_objeto)
C_REAL:C285($r_redimensionAlto;$r_redimensionAncho;$r_redimensionFinal)
C_TEXT:C284($t_nombreCalculo;$t_nombreObjeto;$t_RefCampo;$t_tipoObjeto)


If (False:C215)
	C_PICTURE:C286(SRal_FotoDelAlumno ;$0)
End if 

$p_imagen:=SRcust_LeeFotografiaExterna (->[Alumnos:2]Fotografía:78)
If (Picture size:C356($p_imagen)=0)
	$p_imagen:=[Alumnos:2]Fotografía:78
End if 

$l_error:=SR Get Object Properties (SRArea;SRObjectPrintRef;$t_nombreObjeto;$l_PosArriba;$l_PosIzquierda;$l_PosAbajo;$l_PosDerecha;$l_tipoObjeto;$l_opciones;$l_orden;$l_seleccionado;$l_numeroTabla;$l_numeroCampo;$l_tipoVariable;$l_elementoArreglo;$l_tipoCalculo;$t_nombreCalculo;$l_filas;$l_columnas;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV)
Case of 
	: ($l_tipoObjeto=SR Object Type Field)
		$y_objeto:=Field:C253($l_numeroTabla;$l_numeroCampo)
		$t_tipoObjeto:="field"
	: ($l_tipoObjeto=SR Object Type Variable)
		$y_objeto:=Get pointer:C304($t_nombreObjeto)
		$t_tipoObjeto:="var"
End case 
$l_altoObjeto:=$l_PosAbajo-$l_PosArriba+1
$l_anchoObjeto:=$l_PosDerecha-$l_PosIzquierda+1

Case of 
	: (Is nil pointer:C315($y_objeto))
		  // no se hace nada, el metodo no fue llamado desde un objeto
		$0:=$p_imagen*0
	: ((Picture size:C356($p_imagen)>0) & (Not:C34(Is nil pointer:C315($y_objeto))))
		PICTURE PROPERTIES:C457($p_imagen;$l_anchoImagen;$l_altoImagen)
		$l_propiedad:=SR Attribute Format
		$r_redimensionAncho:=$l_anchoObjeto/$l_anchoImagen
		$r_redimensionAlto:=$l_altoObjeto/$l_altoImagen
		Case of 
			: ($r_redimensionAncho<=$r_redimensionAlto)
				$r_redimensionFinal:=$r_redimensionAncho
			: ($r_redimensionAncho>$r_redimensionAlto)
				$r_redimensionFinal:=$r_redimensionAlto
			Else 
				$r_redimensionFinal:=1
		End case 
		
		$0:=$p_imagen*$r_redimensionFinal
	Else 
		
		$0:=$p_imagen*0
		
End case 


