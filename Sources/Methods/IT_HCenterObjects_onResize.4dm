//%attributes = {}
  // MÉTODO: IT_HCenterObjects_onResize
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/11, 12:06:46
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Centra horizontalmente uno o más objectos de acuerdo a la posición que toma un objeto de referencia
  // luego de redimensionar la ventana
  //
  // PARÁMETROS
  // IT_HCenterObjects_onResize(ObjectoReferencia;Objecto1{;Objecto2{;ObjetoN}})
  // $1 (T): Objeto de referencia
  // $2 (T):Objeto a centrar
  // $3 (T): Objeto1 a centrar (opcional)
  // $N (T): ObjetoN a centrar (opcional)
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284(${1})
C_TEXT:C284($referenceObject;$objectName)
C_LONGINT:C283($left;$top;$right;$bottom;$width;$center)
C_LONGINT:C283($left_RelatedObject;$top_RelatedObject;$right_RelatedObject;$bottom_RelatedObject)
C_LONGINT:C283($sWidth;$sCenter;$moveH)
$referenceObjectName:=$1


  // CODIGO PRINCIPAL
OBJECT GET COORDINATES:C663(*;$referenceObjectName;$left;$top;$right;$bottom)
$width:=$right-$left+1
$center:=$left+Int:C8($width/2)


For ($i;2;Count parameters:C259)
	$objectName:=${$i}
	OBJECT GET COORDINATES:C663(*;$objectName;$left_RelatedObject;$top_RelatedObject;$right_RelatedObject;$bottom_RelatedObject)
	$sWidth:=$right_RelatedObject-$left_RelatedObject+1
	$sCenter:=$left_RelatedObject+Int:C8($sWidth/2)
	$moveH:=$center-$sCenter
	OBJECT MOVE:C664(*;$objectName;$moveH;0)
End for 

