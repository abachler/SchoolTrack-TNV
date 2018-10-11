//%attributes = {}
  // Método: AS_xALP_ManejoExcepciones
  //
  //
  // por Alberto Bachler Klein
  // creación 19/07/17, 10:03:07
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($0)

C_BOOLEAN:C305($b_modificacionRestringida)
C_LONGINT:C283($l_columna;$l_columnaEditable;$l_columnaVisible;$l_Error;$l_fila)

ARRAY POINTER:C280($ay_Columnas;0)
ARRAY TEXT:C222($at_nombreArreglos;0)


If (False:C215)
	C_TEXT:C284(AS_xALP_ManejoExcepciones ;$0)
End if 

$l_columna:=$1
$l_fila:=$2

If ($l_columna>0) & ($l_fila>0)
	$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Columns;$ay_Columnas)
	$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Source;$at_nombreArreglos)
	
	$l_tipo:=Type:C295($ay_Columnas{$l_columna}->)
	$l_tipo:=Choose:C955($l_tipo=21;Text array:K8:16;$l_tipo)
	
	If ($l_tipo=Text array:K8:16)
		$l_columnaVisible:=AL_GetColumnLongProperty (xALP_ASNotas;$l_columna;ALP_Column_Visible)
		$l_columnaEditable:=AL_GetColumnLongProperty (xALP_ASNotas;$l_columna;ALP_Column_Enterable)
		$b_modificacionRestringida:=((<>viSTR_NoModificarNotas=1) & (Not:C34(USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
		$b_modificacionRestringida:=$b_modificacionRestringida & (($l_columnaVisible+$l_columnaEditable)=2)
		$b_modificacionRestringida:=$b_modificacionRestringida & (($ay_Columnas{$l_columna}->{$l_fila}#"") & ($at_nombreArreglos{$l_columna}="aNta@"))
	End if 
	
	Case of 
		: (($b_modificacionRestringida) & ($l_columnaEditable=1))
			IT_MuestraTip (__ ("No dispone de permisos para editar calificaciones registradas");20)
			$0:=__ ("No dispone de permisos para editar calificaciones registradas")
		: (False:C215)
			  // manejar aquí otros casos
	End case 
End if 

