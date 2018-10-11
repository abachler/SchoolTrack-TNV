AL_ExitCell (xALP_CsdList2)

For ($i;1;Size of array:C274(arAS_EvalPropPonderacion))
	arAS_EvalPropPercent{$i}:=0
	arAS_EvalPropPonderacion{$i}:=0
	arAS_EvalPropCoefficient{$i}:=1
End for 

w1coeficiente:=0
w2porcentaje:=0
vlAS_CalcMethod:=0
AL_UpdateArrays (xALP_CsdList2;0)
AL_SetColOpts (xALP_CsdList2;0;0;0;3)
AL_SetWidths (xALP_CsdList2;5;1;225)
OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)
AL_UpdateArrays (xALP_CsdList2;-2)
vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")

OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)

  // Ticket 175179
  //APPEND TO ARRAY(atSTR_EventLog;"Atributo \"Multiplicado por un factor de ponderación \" activado")