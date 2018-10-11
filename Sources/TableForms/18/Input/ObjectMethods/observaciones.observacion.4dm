  // [Asignaturas].Input.observaciones_observacion()
  //
  //
  // creado por: Alberto Bachler Klein: 23-12-15, 18:49:04
  // -----------------------------------------------------------
  //C_LONGINT($l_ancho;$l_columna;$l_estilo;$l_fila;$l_tamaño)
  //C_TEXT($t_fuente;$t_objeto;$t_texto)

  //$t_objeto:=OBJECT Get name(Object current)
  //Case of 
  //: (Form event=On Clicked)
  //If (<>viSTR_UtilizarObservaciones=0)
  //AS_EditaObservaciones 
  //End if 

  //: (Form event=On Before Data Entry)
  //  //$0:=-1
  //  //LISTBOX GET CELL POSITION(*;"lb_observaciones";$l_columna;$l_fila)
  //  //If (<>viSTR_UtilizarObservaciones=0)
  //  //AS_EditaObservaciones ($l_fila;$l_columna)
  //  //End if

  //: (Form event=On After Keystroke)
  //$t_fuente:=OBJECT Get font(*;$t_objeto)
  //$l_tamaño:=OBJECT Get font size(*;$t_objeto)
  //$l_estilo:=OBJECT Get font style(*;$t_objeto)
  //$t_texto:=Get edited text
  //LISTBOX GET CELL POSITION(*;"lb_observaciones";$l_columna;$l_fila)
  //$l_ancho:=IT_Objeto_Ancho ("observaciones.observacion")
  //  //LISTBOX GET CELL COORDINATES(*;"lb_observaciones";$l_columna;$l_fila;$l_izquierda;$l_a
  //  //TEXT TO ARRAY(

  //End case 

