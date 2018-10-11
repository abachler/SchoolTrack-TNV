  // Método: Método de Objeto: [xxSTR_Constants].STR_ReplicaConfigAsignaturas.lb_Asignaturas
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 23/07/10, 10:55:08
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
If ((vt_secciones#"") & (Find in array:C230(lb_Asignaturas;True:C214)>0))
	_O_ENABLE BUTTON:C192(bReplicar)
Else 
	_O_DISABLE BUTTON:C193(bReplicar)
End if 



