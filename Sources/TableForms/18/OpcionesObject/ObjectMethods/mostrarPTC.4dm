  // Método: [Asignaturas].OpcionesObject.usaEvaluacionEspecial1
  // 
  // 
  // creado por Alberto Bachler Klein, 01/03/18, 12:49:38
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_OBJECT:C1216($o_Opciones)
C_BOOLEAN:C305($b_opcEvaEsp)
$b_mostrarPTC:=(Self:C308->=1)
$o_Opciones:=[Asignaturas:18]Opciones:57
OB_SET ($o_Opciones;->$b_mostrarPTC;"mostrarPTC")
[Asignaturas:18]Opciones:57:=$o_Opciones
(OBJECT Get pointer:C1124(Object named:K67:5;"mostrarPTC"))->:=Num:C11(OB Get:C1224([Asignaturas:18]Opciones:57;"mostrarPTC"))
