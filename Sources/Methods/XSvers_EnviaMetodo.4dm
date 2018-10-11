//%attributes = {}
  //  // XSvers_EnviaMetodo()
  //  // Por: Alberto Bachler: 17/04/13, 13:35:34
  //  //  ---------------------------------------------
  //  // 
  //  //
  //  //  ---------------------------------------------
  //C_BLOB($x_blob)
  //C_TEXT($t_TextoMetodo)

  //POST KEY(Character code("s");256)


  //GET MACRO PARAMETER(Full method text;$t_TextoMetodo)

  //BLOB_Variables2Blob (->$x_blob;0;->$t_TextoMetodo)
  //COMPRESS BLOB($x_blob;Compact compression mode)

  //$b_versionDesarrollo:=True
  //$l_buildNumber:=XSvers_buildNumber ($b_versionDesarrollo)
  //$t_usuario:=USR_GetUserName (USR_GetUserID )
  //$t_tipoObjeto:="PM"

  //$t_tituloVentana:=Get window title(Frontmost window)
  //$t_nombreMetodo:=ST_ClearSpaces (ST_GetWord ($t_tituloVentana;2;":"))

  //ARRAY TEXT($at_metodos_Nombres;0)
  //ARRAY LONGINT($al_metodos_Ids;0)
  //4D_GetMethodList (->$at_metodos_Nombres;->$al_metodos_Ids)
  //$l_elemento:=Find in array($at_metodos_Nombres;$t_nombreMetodo+"@")
  //If ($l_elemento>0)
  //$l_IdMetodo:=$al_metodos_Ids{$l_elemento}
  //$t_codigo:=4D_GetMethodTextByID ($l_IdMetodo)
  //$error:=API Get Resource Timestamp ("CC4D";$l_IdMetodo;$d_fecha;$t_hora)
  //$t_dts:=DTS_MakeFromDateTime ($d_fecha;$t_hora)
  //End if 


  //WEB SERVICE SET PARAMETER("buildNumber";$l_buildNumber)
  //WEB SERVICE SET PARAMETER("usuario";$t_usuario)
  //WEB SERVICE SET PARAMETER("nombreMetodo";$t_nombreMetodo)
  //WEB SERVICE SET PARAMETER("textoMetodo";$x_blob)
  //WEB SERVICE SET PARAMETER("tipoObjeto";$t_tipoObjeto)
  //WEB SERVICE SET PARAMETER("dts";$t_dts)

  //$t_textoError:=WS_CallIntranetWebService ("WSvers_RecibeMetodo")
  //If ($t_textoError="")
  //ALERT("El codigo del método fue enviado al repositorio para el build #"+String($l_buildNumber))
  //Else 
  //ALERT("No fue posible enviar el método al repositorio a causa de un error:\r\r "+$t_textoError)
  //End if 