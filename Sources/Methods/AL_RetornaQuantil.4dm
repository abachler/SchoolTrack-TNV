//%attributes = {}
  //Metodo: Método: AL_RetornaQuantil
  //Por abachler
  //Creada el 03/10/2008, 13:45:17
  // ----------------------------------------------------
  // DESCRIPCION
  //Retorna un entero con el numero del quantil(tercil, cuartil, quintil, nonil, decil, duodecil,...percentil) pasado en$3 en el que se sitúa el tipo pr$2 de un alumno en un universo d$1
  //
  //El quantil pasado en$3 debe ser un entero entre 1 y 
  //3: tercil
  //5: quintil
  //10: decil
  //...
  //100: percentil
  //
  //la serie de valores correspondiente al promedio en referencia es ordenada de man
  //
  //Esto debe ser tomado en cuenta cuando si se desea determinar los quantiles en ór
  //Por ejemplo, si se desea que los promedios mas altos se situen estén en el cuant
  //
  //
  //Parámetros
  //$1: puntero sobre un campo de re
  //$2: período(0: final;1: Período_1;2: Período_2;3: Período_3;4: Período_4)
  //$3: quantil buscado
  //
  //Ejemplos
  //$tercil:=AL_RetornaQuantil (->[Alumnos]Nivel_Número;0;3)
  //$quintil:=AL_RetornaQuantil (->[Alumnos]Curso;0;5)
  //$decil:=AL_RetornaQuantil (->[Alumnos]Comuna;0;10)



  // ----------------------------------------------------
  // PARAMETROS
  // $1: puntero sobre un campo de referencia
  // $2: período (0: final; 1: Período1; 2: Período2; 3: Período3; 4: Período4)
  // $3: quantil
  // ----------------------------------------------------



  //DECLARACIONES & INICIALIZACIONES
C_POINTER:C301($1;$universoReferencia)
C_LONGINT:C283($2;$3;$quantil;$periodoValores;$universo;$0;$4;$mode)
ARRAY REAL:C219($aReal;0)
$quantil:=$3
$periodoValores:=$2
$universoReferencia:=$1
If (Count parameters:C259=4)
	$mode:=$4
Else 
	$mode:=Porcentaje
End if 

  //CUERPO
MESSAGES OFF:C175
$selectedRecNum:=Selected record number:C246([Alumnos:2])

  //copio la selección para restaurarla despues de obtener los valores de cada quantil
COPY NAMED SELECTION:C331([Alumnos:2];"temp")

QUERY:C277([Alumnos:2];$universoReferencia->=$universoReferencia->)
KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Institucion:1=<>gInstitucion;*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]Año:2=<>gYear)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268>=0)


Case of 
	: ($mode=Notas)
		If ($periodoValores=0)
			SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269;$aReal)
			$fieldPointer:=->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269
		Else 
			Case of 
				: ($periodoValores=1)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Nota:238
				: ($periodoValores=2)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Nota:243
				: ($periodoValores=3)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Nota:248
				: ($periodoValores=4)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Nota:253
				: ($periodoValores=5)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Nota:258
			End case 
			SELECTION TO ARRAY:C260($fieldPointer->;$aReal)
		End if 
	: ($mode=Puntos)
		If ($periodoValores=0)
			SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270;$aReal)
			$fieldPointer:=->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270
		Else 
			Case of 
				: ($periodoValores=1)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Puntos:239
				: ($periodoValores=2)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Puntos:244
				: ($periodoValores=3)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Puntos:249
				: ($periodoValores=4)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Puntos:254
				: ($periodoValores=5)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Puntos:259
			End case 
			SELECTION TO ARRAY:C260($fieldPointer->;$aReal)
		End if 
	Else 
		If ($periodoValores=0)
			SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268;$aReal)
			$fieldPointer:=->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268
		Else 
			Case of 
				: ($periodoValores=1)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237
				: ($periodoValores=2)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242
				: ($periodoValores=3)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247
				: ($periodoValores=4)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252
				: ($periodoValores=5)
					$fieldPointer:=->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257
			End case 
			SELECTION TO ARRAY:C260($fieldPointer->;$aReal)
		End if 
End case 

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

Case of 
	: ($mode=Notas)
		If ($periodoValores=0)
			$promedioAlumno:=[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269
		Else 
			Case of 
				: ($periodoValores=1)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P01_PromedioOficial_Nota:238
				: ($periodoValores=2)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P02_PromedioOficial_Nota:243
				: ($periodoValores=3)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P03_PromedioOficial_Nota:248
				: ($periodoValores=4)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P04_PromedioOficial_Nota:253
				: ($periodoValores=5)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P05_PromedioOficial_Nota:258
			End case 
		End if 
	: ($mode=Puntos)
		If ($periodoValores=0)
			$promedioAlumno:=[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270
		Else 
			Case of 
				: ($periodoValores=1)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P01_PromedioOficial_Puntos:239
				: ($periodoValores=2)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P02_PromedioOficial_Puntos:244
				: ($periodoValores=3)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P03_PromedioOficial_Puntos:249
				: ($periodoValores=4)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P04_PromedioOficial_Puntos:254
				: ($periodoValores=5)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P05_PromedioOficial_Puntos:259
			End case 
		End if 
	Else 
		If ($periodoValores=0)
			$promedioAlumno:=[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268
		Else 
			Case of 
				: ($periodoValores=1)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237
				: ($periodoValores=2)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242
				: ($periodoValores=3)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247
				: ($periodoValores=4)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252
				: ($periodoValores=5)
					$promedioAlumno:=[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257
			End case 
		End if 
End case 

ARRAY REAL:C219(aQuantiles;$quantil)
For ($i;1;$quantil)
	If ($promedioAlumno<=aQuantiles{$i})
		$0:=$i
		$i:=$quantil+1
	End if 
End for 

  //LIMPIEZA


