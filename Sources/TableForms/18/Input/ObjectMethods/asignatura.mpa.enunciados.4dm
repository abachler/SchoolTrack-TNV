  // [Asignaturas].Input.asignatura.mpa.enunciados()
  // Por: Alberto Bachler K.: 07-05-14, 12:31:15
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_idObjeto;$l_recNumObjeto;$l_refLista;$l_tipoObjeto)
C_TEXT:C284($t_nombreObjeto)


Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		GET LIST ITEM:C378($l_refLista;Selected list items:C379($l_refLista);$l_recNumObjeto;$t_nombreObjeto)
		
	: (Form event:C388=On Selection Change:K2:29)
		$l_refLista:=(OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados"))->
		GET LIST ITEM:C378($l_refLista;Selected list items:C379($l_refLista);$l_recNumObjeto;$t_nombreObjeto)
		GET LIST ITEM PARAMETER:C985($l_refLista;$l_recNumObjeto;"TipoObjeto";$l_tipoObjeto)
		GET LIST ITEM PARAMETER:C985($l_refLista;$l_recNumObjeto;"IdObjeto";$l_idObjeto)
		KRL_GotoRecord (->[MPA_ObjetosMatriz:204];$l_recNumObjeto;False:C215)
		
		VlEVLG_currentID:=$l_idObjeto
		Case of 
			: (OK=1)
				AS_EVLG_CargaEvaluacion ($l_tipoObjeto;[Asignaturas:18]Numero:1;$l_idObjeto;vl_PeriodoSeleccionado)
			: (OK=-1)
				ModernUI_Notificacion (__ ("Error durante la lectura de un enunciado de aprendizaje");__ ("El enunciado no existe o está dañado.\rPor favor verifique la configuración de la matriz de evaluación.");__ ("Cerrar"))
		End case 
End case 
