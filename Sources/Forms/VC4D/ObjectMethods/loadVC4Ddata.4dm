  // VC4D.loadVC4Ddata()
  //
  //
  // creado por: Alberto Bachler Klein: 29-02-16, 13:34:58
  // -----------------------------------------------------------
C_DATE:C307($d_fecha)
C_TIME:C306($h_hora)
C_POINTER:C301($y_opcion)
C_TEXT:C284($t_dtsDesde;$t_dtsHasta)

$l_opcion:=(OBJECT Get pointer:C1124(Object named:K67:5;"universo"))->

  //Case of 
  //: ($y_opcion->=1)  // todo
  //$t_dtsDesde:=""

  //: ($y_opcion->=3)  // ultima hora
  //$h_hora:=Current time(*)-(60*60)
  //$t_dtsDesde:=String(Current date(*);ISO date;$h_hora)

  //: ($y_opcion->=4)  // ultimas 3 horas
  //$h_hora:=Current time(*)-(60*60*3)
  //$t_dtsDesde:=String(Current date(*);ISO date;$h_hora)

  //: ($y_opcion->=6)  // hoy
  //$t_dtsDesde:=String(Current date(*);ISO date;?00:00:00?)

  //: ($y_opcion->=7)  // desde ayer
  //$t_dtsDesde:=String(Current date(*)-1;ISO date;?00:00:00?)

  //: ($y_opcion->=8)  // desde antes de ayer
  //$t_dtsDesde:=String(Current date(*)-2;ISO date;?00:00:00?)

  //: ($y_opcion->=9)  // ultimos 3 días
  //$t_dtsDesde:=String(Current date(*)-3;ISO date;?00:00:00?)

  //: ($y_opcion->=10)  // ultima semana
  //$t_dtsDesde:=String(Current date(*)-6;ISO date;?00:00:00?)

  //: ($y_opcion->=11)  // ultimas dos semanas
  //$t_dtsDesde:=String(Current date(*)-13;ISO date;?00:00:00?)

  //: ($y_opcion->=12)  // ultimo més
  //$t_dtsDesde:=String(Add to date(Current date(*);0;-1;0);ISO date;?00:00:00?)

  //: ($y_opcion->=14)  //
  //  //OBJECT SET VISIBLE(*;"fechas@";True)
  //  //OBJECT SET VISIBLE(*;"fechas_@_hasta";False)
  //$d_fecha:=(OBJECT Get pointer(Object named;"fechas_fecha_desde"))->
  //$h_Hora:=(OBJECT Get pointer(Object named;"fechas_hora_desde"))->
  //$t_dtsDesde:=String($d_fecha;ISO date;$h_hora)

  //: ($y_opcion->=15)  //
  //  //OBJECT SET VISIBLE(*;"fechas@";True)
  //  //OBJECT SET VISIBLE(*;"fechas_@_hasta";True)
  //$d_fecha:=(OBJECT Get pointer(Object named;"fechas_fecha_desde"))->
  //$h_Hora:=(OBJECT Get pointer(Object named;"fechas_hora_desde"))->
  //$t_dtsDesde:=String($d_fecha;ISO date;$h_hora)
  //$d_fecha:=(OBJECT Get pointer(Object named;"fechas_fecha_hasta"))->
  //$h_Hora:=(OBJECT Get pointer(Object named;"fechas_hora_hasta"))->
  //$t_dtsDesde:=String($d_fecha;ISO date;$h_hora)
  //End case 

  //OB SET($ob_parametros;"dts";$t_dtsDesde)

VC4D_LoadChanges ($l_opcion)
  //OBJECT SET VISIBLE(*;"fechas@";False)