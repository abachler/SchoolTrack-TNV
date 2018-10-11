//%attributes = {}
  // SR_GetOrganisationLogo()
  // Por: Alberto Bachler K.: 14-08-15, 19:34:32
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_PICTURE:C286($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_altoImagen;$l_altoObjeto;$l_anchoImagen;$l_anchoObjeto;$l_columnas;$l_elementoArreglo;$l_error;$l_estiloFuente;$l_filas;$l_fondoMotivo)
C_LONGINT:C283($l_fondoRGBAzul;$l_fondoRGBRojo;$l_fondoRGBVerde;$l_formatoImagen;$l_grosorLinea;$l_justificacion;$l_numeroCampo;$l_numeroNivel;$l_numeroTabla;$l_opciones)
C_LONGINT:C283($l_orden;$l_PosAbajo;$l_PosArriba;$l_PosDerecha;$l_PosIzquierda;$l_propiedad;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV;$l_seleccionado;$l_tamañoFuente)
C_LONGINT:C283($l_textoMotivo;$l_textoRGBAzul;$l_textoRGBRojo;$l_textoRGBVerde;$l_tipoCalculo;$l_tipoObjeto;$l_tipoVariable)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_objeto)
C_REAL:C285($r_redimensionAlto;$r_redimensionAncho;$r_redimensionFinal)
C_TEXT:C284($t_CadenaFormato;$t_formato;$t_fuente;$t_nombreCalculo;$t_nombreObjeto;$t_nombreVariable;$t_RefCampo;$t_tipoObjeto)

If (False:C215)
	C_PICTURE:C286(SR_GetOrganisationLogo ;$0)
	C_LONGINT:C283(SR_GetOrganisationLogo ;$1)
End if 

C_PICTURE:C286(vp_Logo;vLogo1)

If (Count parameters:C259>0)
	$l_numeroNivel:=$1
	$p_imagen:=KRL_GetPictureFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_numeroNivel;->[xxSTR_Niveles:6]Logo:49)
End if 

If (Picture size:C356($p_imagen)=0)
	READ ONLY:C145([xShell_ApplicationData:45])
	ALL RECORDS:C47([xShell_ApplicationData:45])
	FIRST RECORD:C50([xShell_ApplicationData:45])
	PICTURE PROPERTIES:C457([xShell_ApplicationData:45]Logo:9;$l_anchoImagen;$l_altoImagen)
	$p_imagen:=[xShell_ApplicationData:45]Logo:9
End if 

$0:=$p_imagen

  //MONO 21-07-2018: todo esto está un poco demas con respecto al redimensionar ya que le objeto donde mostraremos el logo debe estar con el escalamiento.
  //Asi evitamos en este caso los problemas que estamos teniendo con los get properties de SR
  //También podemos utilizar el método para otra parte que no sea Super Report

  //If (Application version<"15@")
  //$l_error:=SR Get Object Properties (SRArea;SRObjectPrintRef;$t_nombreVariable;$l_PosArriba;$l_PosIzquierda;$l_PosAbajo;$l_PosDerecha;$l_tipoObjeto;$l_opciones;$l_orden;$l_seleccionado;$l_numeroTabla;$l_numeroCampo;$l_tipoVariable;$l_elementoArreglo;$l_tipoCalculo;$t_nombreCalculo;$l_filas;$l_columnas;$l_Repeticion_DesfaseH;$l_Repeticion_DesfaseV)
  //$l_altoObjeto:=$l_PosAbajo-$l_PosArriba+1
  //$l_anchoObjeto:=$l_PosDerecha-$l_PosIzquierda+1
  //$l_propiedad:=SR Attribute Format
  //Else 
  //If ((SRObjectPrintRef>0) & (SRArea#0))
  //$t_tipoObjeto:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Object_Kind)
  //$t_nombreObjeto:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Object_Name)
  //$t_RefCampo:=SR_GetTextProperty (SRArea;SRObjectPrintRef;SRP_Field_Source)
  //$l_numeroTabla:=Num(ST_GetWord ($t_RefCampo;1;"]"))
  //$l_numeroCampo:=Num(ST_GetWord ($t_RefCampo;2;"]"))

  //Case of 
  //: ($t_tipoObjeto="field")
  //$y_objeto:=Field($l_numeroTabla;$l_numeroCampo)
  //: (($t_tipoObjeto="var") | ($t_tipoObjeto="variable"))
  //$y_objeto:=Get pointer($t_RefCampo)  // $refCampo (SRP_Field_Source) contiene a ref delcampo en la forma [numeroTabla]numeroCampo o el nombre de la variable
  //End case 

  //If (Not(Nil($y_objeto)))
  //$l_anchoObjeto:=SR_GetLongProperty (SRArea;SRObjectPrintRef;SRP_Object_PosWidth)
  //$l_altoObjeto:=SR_GetLongProperty (SRArea;SRObjectPrintRef;SRP_Object_PosHeight)
  //End if 
  //End if 
  //End if 

  //Case of 
  //: (Nil($y_objeto))
  //  // no se hace nada, el metodo no fue llamado desde un objeto
  //$0:=$p_imagen*0
  //: ((Picture size($p_imagen)>0) & (Not(Nil($y_objeto))))
  //PICTURE PROPERTIES($p_imagen;$l_anchoImagen;$l_altoImagen)
  //$l_propiedad:=SR Attribute Format
  //$r_redimensionAncho:=$l_anchoObjeto/$l_anchoImagen
  //$r_redimensionAlto:=$l_altoObjeto/$l_altoImagen
  //Case of 
  //: ($r_redimensionAncho<=$r_redimensionAlto)
  //$r_redimensionFinal:=$r_redimensionAncho
  //: ($r_redimensionAncho>$r_redimensionAlto)
  //$r_redimensionFinal:=$r_redimensionAlto
  //Else 
  //$r_redimensionFinal:=1
  //End case 

  //If (Not(Nil($y_objeto)))
  //$y_objeto->:=$p_imagen*$r_redimensionFinal
  //End if 
  //$0:=$y_objeto->
  //Else 
  //  //20161112 ASM ticket 170038 
  //If (Not(Nil($y_objeto)))
  //$y_objeto->:=$p_imagen*0
  //End if 
  //$0:=$p_imagen*0

  //End case 
