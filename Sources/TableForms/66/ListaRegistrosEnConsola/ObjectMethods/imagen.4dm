  // [BBL_Prestamos].ListaPrestamos_Items.imagen()
  // Por: Alberto Bachler K.: 19-02-14, 05:42:50
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_variableImagen)


OBJECT SET VISIBLE:C603(*;"rectangulo1";False:C215)
OBJECT SET TITLE:C194(*;"l_recNumRegistro";"-1")
OBJECT SET TITLE:C194(*;"l_selectedRecord";"-1")
OBJECT SET VISIBLE:C603(*;"mail";False:C215)
OBJECT SET VISIBLE:C603(*;"devolver";False:C215)

OBJECT SET TITLE:C194(*;"numeroCopia";"")
OBJECT SET TITLE:C194(*;"lugar";"")
ModernUI_SetTextAttributes ("numeroCopia";Plain:K14:1;12;0)
ModernUI_SetTextAttributes ("lugar";Plain:K14:1;12;0)

OBJECT SET TITLE:C194(*;"l_recNumRegistro";String:C10(Record number:C243([BBL_Registros:66])))
OBJECT SET TITLE:C194(*;"l_selectedRecord";String:C10(Selected record number:C246([BBL_Registros:66])))

OBJECT SET TITLE:C194(*;"numeroCopia";__ ("Copia Nº ")+String:C10([BBL_Registros:66]Número_de_copia:2))
OBJECT SET TITLE:C194(*;"lugar";__ ("Disponible en: ")+[BBL_Registros:66]Lugar:13)
OBJECT SET TITLE:C194(*;"notaAlerta";[BBL_Registros:66]NotaDeAlerta:29)
$y_variableImagen:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_variableImagen->:=[BBL_Registros:66]CodigoBarra_Imagen:24

