//%attributes = {}
  //  // XSvers_EnviaObjetosModificados()
  //  // Por: Alberto Bachler: 02/04/13, 08:13:07
  //  //  ---------------------------------------------
  //  //
  //  //
  //  //  ---------------------------------------------
  //C_BLOB($x_blob)
  //C_DATE($d_fechaModificacion)
  //C_LONGINT($l_error;$i;$l_buildNumber)
  //C_TIME($h_horaModificacion)
  //C_TEXT($t_codigoObjeto;$t_dtsModificacionObjeto;$t_textoError;$t_tipoObjeto;$t_usuario;$t_version_DTSanterior;$0)

  //ARRAY LONGINT($al_IdMetodos;0)
  //ARRAY TEXT($at_Modificaciones_Codigo;0)
  //ARRAY TEXT($at_Modificaciones_DTS;0)
  //ARRAY TEXT($at_Modificaciones_Metodos;0)
  //ARRAY TEXT($at_NombresMetodos;0)


  //If (Count parameters=1)
  //$t_version_DTSanterior:=$1
  //Else 
  //SYS_LeeVersionEstructura ("dts";->$t_version_DTSanterior)
  //End if 


  //WEB SERVICE SET OPTION(Web Service HTTP timeout;300)


  //$b_versionDesarrollo:=True
  //$l_buildNumber:=XSvers_buildNumber ($b_versionDesarrollo)
  //$t_usuario:=USR_GetUserName (USR_GetUserID )
  //$t_tipoObjeto:="PM"

  //$l_IdProceso:=IT_Progress (1;0;0;"Buscando objetos modificados...")
  //4D_GetMethodList (->$at_NombresMetodos;->$al_IdMetodos)
  //For ($i;1;Size of array($al_IdMetodos))
  //$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/Size of array($al_IdMetodos);"Buscando objetos modificados...\r"+$at_NombresMetodos{$i})
  //$l_error:=API Get Resource Timestamp ("CC4D";$al_IdMetodos{$i};$d_fechaModificacion;$h_horaModificacion)
  //$t_dtsModificacionObjeto:=DTS_MakeFromDateTime ($d_fechaModificacion;$h_horaModificacion)
  //If ($t_dtsModificacionObjeto>=$t_version_DTSanterior)
  //$t_codigoObjeto:=4D_GetMethodTextByID ($al_IdMetodos{$i})
  //APPEND TO ARRAY($at_Modificaciones_Metodos;$at_NombresMetodos{$i})
  //APPEND TO ARRAY($at_Modificaciones_DTS;$t_dtsModificacionObjeto)
  //APPEND TO ARRAY($at_Modificaciones_Codigo;$t_codigoObjeto)
  //End if 

  //End for 
  //$l_IdProceso:=IT_Progress (-1;$l_IdProceso)

  //If (Size of array($at_Modificaciones_Metodos)>0)
  //BLOB_Variables2Blob (->$x_blob;0;->$at_Modificaciones_Metodos;->$at_Modificaciones_DTS;->$at_Modificaciones_Codigo)
  //COMPRESS BLOB($x_blob;Compact compression mode)

  //WEB SERVICE SET PARAMETER("buildNumber";$l_buildNumber)
  //WEB SERVICE SET PARAMETER("usuario";$t_usuario)
  //WEB SERVICE SET PARAMETER("objetosModificados";$x_blob)
  //WEB SERVICE SET PARAMETER("tipoObjetos";$t_tipoObjeto)

  //$t_textoError:=WS_CallIntranetWebService ("WSvers_RecibeObjetosModificados")
  //$0:=$t_textoError
  //End if 


