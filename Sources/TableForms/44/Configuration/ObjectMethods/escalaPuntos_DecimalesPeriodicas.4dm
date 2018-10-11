  // [xxSTR_EstilosEvaluacion].Configuration.escalaPuntos_DecimalesPeriodicas()
  //
  //
  // creado por: Alberto Bachler Klein: 11-07-16, 12:16:57
  // -----------------------------------------------------------
C_LONGINT:C283($l_decimales;$l_decimalesimales;$l_digitosMaximoEscala;$l_evaluaciones;$l_maximoDigitosDecimales;$l_parteEnteraIntervalo)
C_REAL:C285($r_intervalo)
C_TEXT:C284($t_cadenaDecimales;$t_mensaje)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		$l_evaluaciones:=(OBJECT Get pointer:C1124(Object named:K67:5;"usoEvaluaciones"))->
		$t_mensaje:=__ ("Número de decimales aceptados durante el registro de calificaciones en la escala de puntos.")
		If ($l_evaluaciones>0)
			$t_mensaje:=$t_mensaje+"\r"+__ ("No puede ser modificado ya que hay evaluaciones registradas con este estilo de evaluacion.")
		End if 
		OBJECT SET HELP TIP:C1181(*;OBJECT Get name:C1087(Object current:K67:2);$t_mensaje)
		
		
	: (Form event:C388=On Data Change:K2:15)
		$l_decimales:=Self:C308->
		$l_digitosMaximoEscala:=Length:C16(String:C10(rPointsTo))
		$l_maximoDigitosDecimales:=4-$l_digitosMaximoEscala
		If ($l_decimales>$l_maximoDigitosDecimales)
			CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("El número de decimales no puede ser superior a ^0 si el puntaje máximo se compone de ^1 cifra(s).");__ ("^0");String:C10($l_maximoDigitosDecimales));__ ("^1");String:C10($l_digitosMaximoEscala));__ ("");__ ("OK"))
			Self:C308->:=$l_maximoDigitosDecimales
			GOTO OBJECT:C206(Self:C308->)
		Else 
			$l_decimales:=iPointsDec
			$r_intervalo:=rPointsInterval
			
			If ($l_decimalesimales>0)
				$l_parteEnteraIntervalo:=Int:C8($r_intervalo)
				$t_cadenaDecimales:=Substring:C12(String:C10(Dec:C9($r_intervalo));3)
				If (Length:C16($t_cadenaDecimales)>$l_decimales)
					$r_intervalo:=Num:C11(String:C10($l_parteEnteraIntervalo)+<>tXS_RS_DecimalSeparator+Substring:C12($t_cadenaDecimales;1;$l_decimales))
					BEEP:C151
				End if 
			Else 
				If ($r_intervalo<1)
					$r_intervalo:=1
					BEEP:C151
				End if 
			End if 
			rPointsInterval:=$r_intervalo
			EVS_SetFormats 
			EVS_SetModified 
		End if 
		
End case 