//%attributes = {}
  // Método: XS_CIM
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/09/10, 14:55:46
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal


If (USR_IsGroupMember_by_GrpID (-15001))
	XS_CIM_ObjetMethods 
Else 
	CD_Dlog (0;__ ("Sólo los miembros del grupo Administración pueden utilizar estas funciones."))
End if 



