AL_ExitCell (xALP_CsdList2)

For ($i;1;Size of array:C274(arAS_EvalPropPonderacion))
	arAS_EvalPropPercent{$i}:=0
	arAS_EvalPropPonderacion{$i}:=0
	arAS_EvalPropCoefficient{$i}:=1
End for 


vlAS_CalcMethod:=1
AL_UpdateArrays (xALP_CsdList2;0)

COPY ARRAY:C226(arAS_EvalPropCoefficient;arAS_EvalPropPonderacion)
AL_SetColOpts (xALP_CsdList2;0;0;0;2)
AL_SetWidths (xALP_CsdList2;5;2;145;80)
AL_SetFormat (xALP_CsdList2;6;"##0";0;0;0;0)
AL_SetHeaders (xALP_CsdList2;6;1;__ ("Coeficientes"))
AL_UpdateArrays (xALP_CsdList2;-2)
vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")


OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)

  // Ticket 175179
  //APPEND TO ARRAY(atSTR_EventLog;"Atributo \"Peso relativo de la evaluación: Multiplicado por un coeficiente\" activa"+"do")

