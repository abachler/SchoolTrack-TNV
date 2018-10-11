//%attributes = {}
  //Metodo: AL_RetornaQuantil_Sel
  //Por abachler -Modificado por : Mono
  //Modificado el `10/03/2010

  //Funciona igual que AL_retornaQuantil pero el orden de los parámtros es distinto
  //1) puntero del campo
  //2) quantil
  //3) (opcional)puntero al universo, si no entrega un parémetro para 3 se tomará como universo l
  //DECLARACIONES & INICIALIZACIONES

C_POINTER:C301($3;$universoReferencia;$1;$punteroCampo)
C_LONGINT:C283($2;$quantil;$periodoValores;$universo;$0;$4;$mode)
ARRAY REAL:C219($aReal;0)
C_BOOLEAN:C305($vb_seleccion)

$punteroCampo:=$1
$quantil:=$2
$vb_seleccion:=False:C215

If (Count parameters:C259>=3)
	$universoReferencia:=$3
	$vb_seleccion:=True:C214
End if 

  //CUERPO
MESSAGES OFF:C175
$selectedRecNum:=Selected record number:C246([Alumnos:2])

  //copio la selección para restaurarla despues de obtener los valores de cada quantil
COPY NAMED SELECTION:C331([Alumnos:2];"temp")

If ($vb_seleccion)
	QUERY:C277([Alumnos:2];$universoReferencia->=$universoReferencia->)
Else 
	USE NAMED SELECTION:C332("temp")
End if 

KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Institucion:1=<>gInstitucion;*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]Año:2=<>gYear)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268>=0)
SELECTION TO ARRAY:C260($punteroCampo->;$aReal)


ARRAY REAL:C219(aQuantiles;$quantil)
For ($i;1;$quantil)
	aQuantiles{$i}:=MATH_Quantile (->$aReal;$i/$quantil)
End for 

  //restauro la selección original y 
USE NAMED SELECTION:C332("temp")
GOTO SELECTED RECORD:C245([Alumnos:2];$selectedRecNum)
CLEAR NAMED SELECTION:C333("temp")

$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)

KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key)

$promedioAlumno:=$punteroCampo->


ARRAY REAL:C219(aQuantiles;$quantil)
For ($i;1;$quantil)
	If ($promedioAlumno<=aQuantiles{$i})
		$0:=$i
		$i:=$quantil+1
	End if 
End for 

  //LIMPIEZA


