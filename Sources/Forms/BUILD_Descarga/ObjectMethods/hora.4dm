  // Build_Descarga.hora()
  // 
  //
  // creado por: Alberto Bachler Klein: 20-08-16, 13:01:30
  // -----------------------------------------------------------


$y_hora:=OBJECT Get pointer:C1124(Object named:K67:5;"hora")
Case of 
	: (Form event:C388=On Load:K2:1)
		  //ARRAY TIME($y_hora->;0)
		  //APPEND TO ARRAY($y_hora->;?19:00:00?)
		  //For ($i;2;26)
		  //If ($y_hora->{$i-1}=?23:30:00?)
		  //APPEND TO ARRAY($y_hora->;?00:00:00?)
		  //Else 
		  //APPEND TO ARRAY($y_hora->;$y_hora->{$i-1}+?00:30:00?)
		  //End if 
		  //End for 
		  //$y_hora->:=1
		  //COPY ARRAY($y_hora->;(OBJECT Get pointer(Object named;"hora1"))->)
		  //COPY ARRAY($y_hora->;(OBJECT Get pointer(Object named;"hora2"))->)
		  //COPY ARRAY($y_hora->;(OBJECT Get pointer(Object named;"hora3"))->)
		
	: (Form event:C388=On Data Change:K2:15)
		
		
End case 