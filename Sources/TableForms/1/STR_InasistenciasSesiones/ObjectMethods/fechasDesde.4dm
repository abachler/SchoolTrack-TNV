  // [xxSTR_Constants].STR_InasistenciasSesiones.calendarioSupervision()
If (False:C215)
	  // Por: Alberto Bachler K.: 12-06-14, 11:54:26
	  //  ---------------------------------------------
	  // 
	  //
	  //  ---------------------------------------------
	
	
End if 

C_DATE:C307($d_fechaDesde)
$d_fechaDesde:=DT_PopCalendar 
$y_pctAsistencia:=OBJECT Get pointer:C1124(Object named:K67:5;"chkBox_IncidePctAsistencia")
$b_pctAsistencia:=($y_pctAsistencia->=1)

If (OK=1)
	OBJECT SET TITLE:C194(*;"fechasDesde";String:C10($d_fechaDesde;Internal date short special:K1:4))
	$d_fechaHasta:=Date:C102(ST_GetWord (OBJECT Get title:C1068(*;"fechasHasta");2;": "))
	If (($d_fechaHasta=!00-00-00!) | ($d_fechaHasta<$d_fechaDesde))
		$d_fechaHasta:=$d_fechaDesde
	End if 
	IT_PropiedadesBotonPopup ("fechasDesde";__ ("Desde el: ")+String:C10($d_fechaDesde;System date short:K1:1);160)
	IT_PropiedadesBotonPopup ("fechasHasta";__ ("Hasta el: ")+String:C10($d_fechaHasta;System date short:K1:1);160)
	
	If (($d_fechaDesde=!00-00-00!) | ($d_fechaDesde>$d_fechaHasta))
		ASrs_SinRegistroAsistencia (!00-00-00!;!00-00-00!;$b_pctAsistencia)
	Else 
		ASrs_SinRegistroAsistencia ($d_fechaDesde;$d_fechaHasta;$b_pctAsistencia)
	End if 
Else 
	ASrs_SinRegistroAsistencia (!00-00-00!;!00-00-00!;$b_pctAsistencia)
End if 
