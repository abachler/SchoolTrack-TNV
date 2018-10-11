//%attributes = {}
  //  `UTC_CheckDateAndTime
  //
  //C_BOOLEAN($timeError;$dateError)
  //C_TEXT($dlsOff;$gmtOff;$total)
  //
  //If (SYS_IsWindows )
  //$textArrayPointer:=Bash_Get_Array_By_Type (Is Text )
  //$error:=sys_GetNetworkInfo ($networkInfo)
  //AT_Text2Array ($textArrayPointer;$networkInfo;",")
  //$domaine:=$textArrayPointer->{2}
  //Bash_Return_Variable ($textArrayPointer)
  //Else 
  //$domaine:=""
  //End if 
  //$userName:=Current machine owner
  //$machineName:=Current machine
  //If (($userName="aBachler") | ($userName="Jaime") | ($machineName="Colegium-@") | ($domaine="lester.colegium.com") | ($machineName="U2") | (Not(Is compiled mode)))
  //
  //Else 
  //If (Application type=4D Server )
  //◊tUSR_CurrentUserName:="Servidor"
  //End if 
  //vsBWR_CurrentModule:="SchoolTrack"
  //GET PICTURE FROM LIBRARY("Module "+vsBWR_CurrentModule;vpXS_IconModule)
  //
  //error:=0
  //ON ERR CALL("ERR_GenericOnError")
  //READ ONLY([xShell_ApplicationData])
  //ALL RECORDS([xShell_ApplicationData])
  //FIRST RECORD([xShell_ApplicationData])
  //
  //If ([xShell_ApplicationData]Ciudad#"")
  //
  //$url:="http://ws.geonames.org/search?name_equals="+ST_Mac2UTF8 ([xShell_ApplicationData]Ciudad;True)+"&country="+◊vtXS_CountryCode+"&featureClass=P&featureCode=PPLC&featureCode=PPL"
  //
  //$xml:=DOM Parse XML source($url)
  //If ((error=0) & ($xml#"0000000000000000"))
  //$ref:=DOM Get XML element($xml;"totalResultsCount";1;$total)
  //
  //If (Num($total)#0)
  //$lat:=DOM_GetValue ($xml;"geonames/geoname/lat[1]")
  //$lng:=DOM_GetValue ($xml;"geonames/geoname/lng[1]")
  //DOM CLOSE XML($xml)
  //
  //$url:="http://ws.geonames.org/timezone?lat="+$lat+"&lng="+$lng
  //$xml:=DOM Parse XML source($url)
  //If ((error=0) & ($xml#"0000000000000000"))
  //$dstOff:=DOM_GetValue ($xml;"geonames/timezone/dstOffset")
  //$gmtOff:=DOM_GetValue ($xml;"geonames/timezone/gmtOffset")
  //DOM CLOSE XML($xml)
  //If (◊tXS_RS_DecimalSeparator=",")
  //$dstOff:=Replace string($dstOff;".";",")
  //$gmtOff:=Replace string($gmtOff;".";",")
  //End if 
  //
  //$url:="http://www.earthtools.org/timezone-1.1/0/0"
  //$xml:=DOM Parse XML source($url)
  //If ((error=0) & ($xml#"0000000000000000"))
  //$utcTime:=DOM_GetValue ($xml;"timezone/utctime")
  //$utcTimeTM:=Time(ST_GetWord ($utcTime;2;" "))
  //DOM CLOSE XML($xml)
  //
  //$url:="http://www.earthtools.org/timezone-1.1/"+$lat+"/"+$lng
  //$xml:=DOM Parse XML source($url)
  //If ((error=0) & ($xml#"0000000000000000"))
  //$utcDate:=DOM_GetValue ($xml;"timezone/isotime")
  //$utcDate:=ST_GetWord ($utcDate;1;" ")
  //$fechaActual:=Date(ST_GetWord ($utcDate;3;"-")+"/"+ST_GetWord ($utcDate;2;"-")+"/"+ST_GetWord ($utcDate;1;"-"))
  //DOM CLOSE XML($xml)
  //
  //$dateError:=($fechaActual#Current date)
  //
  //If (Not($dateError))
  //$DLS:=UTC_GetDLS4Location ($fechaActual;◊vtXS_CountryCode;[xShell_ApplicationData]Ciudad)
  //
  //If ($DLS)
  //$horaActual:=Time(Time string($utcTimeTM+(Num($gmtOff)*60*60)))
  //Else 
  //$horaActual:=Time(Time string($utcTimeTM+(Num($dlsOff)*60*60)))
  //End if 
  //
  //$timeError:=(Abs($horaActual-Current time)>180)
  //End if 
  //
  //If (Application type=4D Server )
  //If ($dateError)
  //LOG_RegisterEvt ("Al parecer la fecha del servidor ("+Current machine+") no es correcta ("+String(Current date;Internal date short )+")")
  //$copyTo:=""
  //SOPORTE_EnviaMailIncidente ($copyTo;"Al parecer la fecha del servidor ("+Current machine+") no es correcta ("+String(Current date;Internal date short )+")";"Comentario")
  //End if 
  //If ($timeError)
  //LOG_RegisterEvt ("Al parecer la hora del servidor no es correcta ("+String(Current time;HH MM )+")")
  //$copyTo:=""
  //SOPORTE_EnviaMailIncidente ($copyTo;"Al parecer la hora del servidor no es correcta ("+String(Current time;HH MM )+")";"Comentario")
  //End if 
  //Else 
  //If (Application type=4D Remote Mode )
  //If ($dateError)
  //LOG_RegisterEvt ("Al parecer la fecha de la estación ("+Current machine+") no es correcta ("+String(Current date;Internal date short )+")")
  //End if 
  //If ($timeError)
  //LOG_RegisterEvt ("Al parecer la hora de la estación ("+Current machine+") no es correcta ("+String(Current time;HH MM )+")")
  //End if 
  //Else 
  //If ($dateError)
  //LOG_RegisterEvt ("Al parecer la fecha de la máquina ("+Current machine+") no es correcta ("+String(Current date;Internal date short )+")")
  //$copyTo:=""
  //SOPORTE_EnviaMailIncidente ($copyTo;"Al parecer la fecha de la máquina ("+Current machine+") no es correcta ("+String(Current date;Internal date short )+")";"Comentario")
  //CD_Dlog (0;"Al parecer la fecha de la máquina ("+Current machine+") no es correcta ("+String(Current date;Internal date short )+"). Esto podría generar errores en el registro de los datos o en cálculos asociado"+"s. Por favor corriga esta situación ates de seguir adelante.")
  //End if 
  //If ($timeError)
  //LOG_RegisterEvt ("Al parecer la hora de la máquina ("+Current machine+") no es correcta ("+String(Current time;HH MM )+")")
  //$copyTo:=""
  //SOPORTE_EnviaMailIncidente ($copyTo;"Al parecer la hora de la máquina ("+Current machine+") no es correcta ("+String(Current time;HH MM )+")";"Comentario")
  //CD_Dlog (0;"Al parecer la hora de la máquina ("+Current machine+") no es correcta ("+String(Current time;HH MM )+"). Esto podría generar errores en el registro de los datos o en cálculos asociado"+"s. Por favor corriga esta situación antes de seguir delante.")
  //End if 
  //End if 
  //End if 
  //End if 
  //End if 
  //End if 
  //Else 
  //If (Application type=4D Server )
  //LOG_RegisterEvt ("No se han podido determinar la fecha y la hora para la ciudad y pais de esta base"+" de datos.")
  //Else 
  //
  //End if 
  //End if 
  //End if 
  //If ((error#0) | ($xml="0000000000000000"))
  //LOG_RegisterEvt ("No se han podido determinar la fecha y la hora para la ciudad y pais de esta base"+" de datos.")
  //End if 
  //error:=0
  //Else 
  //LOG_RegisterEvt ("El campo Ciudad del colegio está vacío lo que impide verificar fecha y hora de la"+" máquina.")
  //End if 
  //ON ERR CALL("")
  //End if 