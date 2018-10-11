//%attributes = {"invisible":true}
  //C_OBJECT($1)
  //C_LONGINT($2;$3)

  //$countParams:=Count parameters

  //DOWNLOAD_END:=False
  //DOWNLOAD_FINISH:=False
  //DOWNLOAD_ERROR:=0

  //UNZIP_END:=False
  //UNZIP_FINISH:=False
  //UNZIP_SUCCESS:=0

  //Case of 
  //: ($countParams=1)

  //$p:=New process(Current method name;0;Current method name;$1;Current process;*)

  //: ($countParams=2)

  //DOWNLOAD_CONTEXT:=$1
  //$callerProcess:=$2

  //$s:=Execute on server(Current method name;0;"$"+Current method name;$1;0;0;*)

  //Repeat 
  //DELAY PROCESS(Current process;6)

  //ON ERR CALL("GLOBAL_ERROR")
  //GET PROCESS VARIABLE($s;<>DOWNLOAD_STATUS;<>DOWNLOAD_STATUS;DOWNLOAD_END;DOWNLOAD_END)
  //SET PROCESS VARIABLE($callerProcess;<>DOWNLOAD_STATUS;<>DOWNLOAD_STATUS)
  //ON ERR CALL("")

  //CALL PROCESS(-1)

  //Until (DOWNLOAD_END | (Get_server_process_state ($s)<0))

  //ON ERR CALL("GLOBAL_ERROR")
  //GET PROCESS VARIABLE($s;DOWNLOAD_ERROR;DOWNLOAD_ERROR)
  //SET PROCESS VARIABLE($s;DOWNLOAD_FINISH;True)
  //ON ERR CALL("")

  //If (DOWNLOAD_ERROR=0)

  //Repeat 
  //DELAY PROCESS(Current process;6)

  //ON ERR CALL("GLOBAL_ERROR")
  //GET PROCESS VARIABLE($s;<>UNZIP_STATUS;<>UNZIP_STATUS;UNZIP_END;UNZIP_END)
  //SET PROCESS VARIABLE($callerProcess;<>UNZIP_STATUS;<>UNZIP_STATUS)
  //ON ERR CALL("")

  //CALL PROCESS(-1)

  //Until (UNZIP_END | (Get_server_process_state ($s)<0))

  //End if 

  //ON ERR CALL("GLOBAL_ERROR")
  //GET PROCESS VARIABLE($s;UNZIP_SUCCESS;UNZIP_SUCCESS)
  //SET PROCESS VARIABLE($s;UNZIP_FINISH;True)
  //ON ERR CALL("")

  //If (DOWNLOAD_ERROR=0) & (UNZIP_SUCCESS=1)
  //EXECUTE METHOD(OB Get(DOWNLOAD_CONTEXT;"onSuccess");*;$callerProcess)
  //Else 
  //EXECUTE METHOD(OB Get(DOWNLOAD_CONTEXT;"onError");*;$callerProcess)
  //End if 

  //: ($countParams=3)

  //<>DOWNLOAD_ABORT:=False
  //<>DOWNLOAD_STATUS:=0

  //<>UNZIP_ABORT:=False
  //<>UNZIP_STATUS:=0

  //DOWNLOAD_CONTEXT:=$1

  //C_TEXT($srcPath;$dstPath;$user;$pass)
  //$srcPath:=OB Get(DOWNLOAD_CONTEXT;"srcPath")
  //$dstPath:=OB Get(DOWNLOAD_CONTEXT;"dstPath")
  //$user:=OB Get(DOWNLOAD_CONTEXT;"user")
  //$pass:=OB Get(DOWNLOAD_CONTEXT;"pass")

  //C_BLOB($in;$out)
  //ARRAY LONGINT($optionNames;0)
  //ARRAY TEXT($optionValues;0)
  //APPEND TO ARRAY($optionNames;CURLOPT_USERNAME)
  //APPEND TO ARRAY($optionValues;$user)
  //APPEND TO ARRAY($optionNames;CURLOPT_PASSWORD)
  //APPEND TO ARRAY($optionValues;$pass)
  //APPEND TO ARRAY($optionNames;CURLOPT_USE_SSL)
  //APPEND TO ARRAY($optionValues;"1")
  //APPEND TO ARRAY($optionNames;CURLOPT_SSL_VERIFYPEER)
  //APPEND TO ARRAY($optionValues;"0")
  //APPEND TO ARRAY($optionNames;CURLOPT_SSL_VERIFYHOST)
  //APPEND TO ARRAY($optionValues;"0")
  //APPEND TO ARRAY($optionNames;CURLOPT_FILETIME)
  //APPEND TO ARRAY($optionValues;"1")
  //APPEND TO ARRAY($optionNames;CURLOPT_NOBODY)
  //APPEND TO ARRAY($optionValues;"1")

  //CREATE FOLDER(Get_folder_path ($dstPath);*)

  //DOWNLOAD_ERROR:=cURL ($srcPath;$optionNames;$optionValues;$in;$out)

  //If (DOWNLOAD_ERROR=0)

  //$header:=Convert to text($out;"utf-8")

  //ARRAY LONGINT($pos;0)
  //ARRAY LONGINT($len;0)

  //If (Match regex("(?mi)^Last-Modified:\\s*(.+)";$header;1;$pos;$len))

  //$dateString:=Substring($header;$pos{1};$len{1})

  //C_DATE($lastModifiedDate_Remote)
  //C_TIME($lastModifiedTime_Remote)

  //If (Date_Parse_RFC ($dateString;->$lastModifiedDate_Remote;->$lastModifiedTime_Remote))

  //ARRAY LONGINT($optionNames;0)
  //ARRAY TEXT($optionValues;0)
  //APPEND TO ARRAY($optionNames;CURLOPT_USERNAME)
  //APPEND TO ARRAY($optionValues;$user)
  //APPEND TO ARRAY($optionNames;CURLOPT_PASSWORD)
  //APPEND TO ARRAY($optionValues;$pass)
  //APPEND TO ARRAY($optionNames;CURLOPT_USE_SSL)
  //APPEND TO ARRAY($optionValues;"1")
  //APPEND TO ARRAY($optionNames;CURLOPT_SSL_VERIFYPEER)
  //APPEND TO ARRAY($optionValues;"0")
  //APPEND TO ARRAY($optionNames;CURLOPT_SSL_VERIFYHOST)
  //APPEND TO ARRAY($optionValues;"0")
  //APPEND TO ARRAY($optionNames;CURLOPT_WRITEDATA)
  //APPEND TO ARRAY($optionValues;$dstPath)
  //APPEND TO ARRAY($optionNames;CURLOPT_XFERINFOFUNCTION)
  //APPEND TO ARRAY($optionValues;"Download_CALLBACK")

  //DOWNLOAD_ERROR:=cURL ($srcPath;$optionNames;$optionValues;$in;$out)

  //End if 

  //End if 

  //End if 

  //DOWNLOAD_END:=True

  //Repeat 
  //DELAY PROCESS(Current process;60)
  //Until (DOWNLOAD_FINISH)

  //If (DOWNLOAD_ERROR=0)
  //$srcPath:=$dstPath
  //$dstPath:=Get_folder_path ($dstPath)
  //UNZIP_SUCCESS:=Unzip ($srcPath;$dstPath;"";ZIP_With_attributes;"Unzip_CALLBACK")
  //If (UNZIP_SUCCESS=1)
  //FOLDER LIST($dstPath;$folders)
  //If (Size of array($folders)#0)
  //If (Version type ?? Merged application)
  //SET UPDATE FOLDER($dstPath+$folders{1})
  //End if 
  //End if 
  //End if 
  //End if 

  //UNZIP_END:=True

  //Repeat 
  //DELAY PROCESS(Current process;60)
  //Until (UNZIP_FINISH)

  //End case 