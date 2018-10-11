//%attributes = {}
  //Metodo: AS_RetornaVariableEstadistica
  //Por abachler
  //Creada el 09/06/2008, 10:19:39
  // ----------------------------------------------------
  // Descripción
  // Retorna la variable estadística pasada en el argumento 1,
  // calculada obtenida de un conjunto de valores en el campo pasado como puntero en el argumento 2
  // sobre la base de los registros de calificaciones de la asignatura actual
  // o de la asignatura correspondiente a los argumentos opcionales 3 a 5
  // Si es llamado desde una variable SuperReport retorna el valor en esa variable
  //
  // ----------------------------------------------------
  // Parámetros
  // AS_RetornaVariableEstadistica(nombreVariable;punteroCampo{;ID_asignatura{;Año{;ID_institucion}}})
  // $1: nombreVariable :texto
  // $2: punteroCampo :puntero
  // $3: ID_asignatura :longint (opcional)
  // $4: Año: longint (opcional)
  // $5: ID_institucion :longint (opcional)
C_REAL:C285($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_LONGINT:C283($i;$l_Año;$l_idAsignatura;$l_IdInstitucion;$l_Periodo;$l_ValoresAdmitidos)
C_POINTER:C301($y_objeto;$y_PunteroCampoNumerico)
C_REAL:C285($r_Maximo;$r_minimo;$r_Resultado;$r_valorMinimo)
C_TEXT:C284($t_NombreVariableRetorno)

ARRAY REAL:C219($ar_Values;0)



If (False:C215)
	C_REAL:C285(AS_RetornaVariableEstadistica ;$0)
	C_TEXT:C284(AS_RetornaVariableEstadistica ;$1)
	C_POINTER:C301(AS_RetornaVariableEstadistica ;$2)
	C_LONGINT:C283(AS_RetornaVariableEstadistica ;$3)
	C_LONGINT:C283(AS_RetornaVariableEstadistica ;$4)
	C_LONGINT:C283(AS_RetornaVariableEstadistica ;$5)
End if 

$t_NombreVariableRetorno:=$1
$y_PunteroCampoNumerico:=$2
$l_Periodo:=vPeriodo
$l_idAsignatura:=[Asignaturas:18]Numero:1
$l_IdInstitucion:=<>gInstitucion
$l_Año:=<>gYear
Case of 
	: (Count parameters:C259=3)
		$l_idAsignatura:=$3
	: (Count parameters:C259=4)
		$l_idAsignatura:=$3
		$l_Año:=$4
	: (Count parameters:C259=5)
		$l_idAsignatura:=$3
		$l_Año:=$4
		$l_IdInstitucion:=$5
End case 

If ($l_idAsignatura=0)
	$l_idAsignatura:=[Asignaturas:18]Numero:1
End if 


EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
  //determino el modo que será utilizado para los cálculos estadísticos
If (vrNTA_MinimoEscalaReferencia>=0)
	$l_ValoresAdmitidos:=3  //cero y valores positivos
	$r_valorMinimo:=0
Else 
	$l_ValoresAdmitidos:=1  //solo valores positivos
	$r_valorMinimo:=0.0000000001
End if 

If ((SRArea#0) & (SRObjectPrintRef#0))  //si el método es llamado desde un objeto SuperReport válido
	$y_objeto:=SR_GetVariableFieldInfo 
End if 

EV2_RegistrosDeLaAsignatura ($l_idAsignatura;$l_Año;$l_IdInstitucion)
SELECTION TO ARRAY:C260($y_PunteroCampoNumerico->;$ar_Values)

Case of 
	: (($t_NombreVariableRetorno="Media") | ($t_NombreVariableRetorno="Promedio") | ($t_NombreVariableRetorno="Average") | ($t_NombreVariableRetorno="Moyenne"))
		$r_Resultado:=AT_Mean (->$ar_Values;$l_ValoresAdmitidos)
	: (($t_NombreVariableRetorno="Max") | ($t_NombreVariableRetorno="Maximo") | ($t_NombreVariableRetorno="Maxima") | ($t_NombreVariableRetorno="Maximum"))
		$r_Resultado:=AT_Maximum (->$ar_Values;$l_ValoresAdmitidos)
	: (($t_NombreVariableRetorno="Min") | ($t_NombreVariableRetorno="Minimo") | ($t_NombreVariableRetorno="Minima") | ($t_NombreVariableRetorno="Minimum"))
		$r_Resultado:=AT_Minimum (->$ar_Values;$l_ValoresAdmitidos)
	: (($t_NombreVariableRetorno="StdDev") | ($t_NombreVariableRetorno="Desviacion estandar") | ($t_NombreVariableRetorno="Standard Deviation") | ($t_NombreVariableRetorno="Ecart type"))
		$r_Resultado:=AT_StandardDeviation (->$ar_Values;$l_ValoresAdmitidos)
	: (($t_NombreVariableRetorno="Varianza") | ($t_NombreVariableRetorno="Promedio") | ($t_NombreVariableRetorno="Average") | ($t_NombreVariableRetorno="Moyenne"))
		$r_Resultado:=AT_StandardDeviation (->$ar_Values;$l_ValoresAdmitidos)
		$r_Resultado:=$r_Resultado*$r_Resultado
	: (($t_NombreVariableRetorno="Rango") | ($t_NombreVariableRetorno="Range"))
		$r_Maximo:=AT_Maximum (->$ar_Values;$l_ValoresAdmitidos)
		$r_minimo:=AT_Minimum (->$ar_Values;$l_ValoresAdmitidos)
		$r_Resultado:=$r_Maximo-$r_minimo
		
	: (($t_NombreVariableRetorno="Valores") | ($t_NombreVariableRetorno="Valores significativos") | ($t_NombreVariableRetorno="Values") | ($t_NombreVariableRetorno="Valeurs") | ($t_NombreVariableRetorno="Count"))
		$r_Resultado:=0
		For ($i;Size of array:C274($ar_Values);1;-1)
			If ($ar_Values{$i}=$r_valorMinimo)
				$r_Resultado:=$r_Resultado
			End if 
		End for 
End case 

If ((SRArea#0) & (SRObjectPrintRef#0) & (Not:C34(Is nil pointer:C315($y_objeto))))  //si el método es llamado desde un objeto SuperReport válido
	$y_objeto->:=$r_Resultado
End if 

$0:=$r_Resultado

  //LIMPIEZA

