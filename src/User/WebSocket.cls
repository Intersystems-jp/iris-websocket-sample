Class User.WebSocket Extends %CSP.WebSocket
{

Method OnPreServer() As %Status
{

	set ..SharedConnection = +$get(^websocket("smode"))

 	quit $$$OK
}

Method Server() As %Status [ ProcedureBlock = 0 ]
{
    try {
	  set cnt=$I(^websocket)

	  set ^websocket(cnt,"wid") = ..WebSocketID
	  set ^websocket(cnt,"sid") = ..SessionId

	  set ^websocket(cnt,1)="start: job # = "_$job_" datetime = "_$ZDT($H)

	  set sc=$$$OK


      set scount = 0

	  for {

		// read the message from client

		set data = ..Read(0,.sc,200) // Disconnect if no communication for 200 sec

		if $$$ISERR(sc) {
		  // read timeout or the client requets close()	
		  set ^websocket("error",$zh) = $system.Status.GetErrorText(sc)
		  quit
		}
 
		set ^websocket(cnt,$increment(scount))=data

		;; send the message to client

		do ..Write("XYZ")

		//quit  // Disconnect

	  }

	  do ..EndServer()

	  set ^websocket(cnt,2)="close: "_$ZDT($H)

  }
  catch e {
	set status = e.AsStatus()
	set ^websocket("error",$zh) = $system.Status.GetErrorText(status)
  }
  quit $$$OK
}

ClassMethod SendDataAsync() As %Status
{
    try {

      set count = $get(^websocket)
      for i = 1:1:count {
        set websocket = ##class(%CSP.WebSocket).%New()
        set websocketid = $get(^websocket(i,"wid"))
        set status = websocket.OpenServer(websocketid)
		$$$ThrowOnError(status)
        set status = websocket.Write("How are you?")
		$$$ThrowOnError(status)
      }
    }
    catch e {
      set status = e.AsStatus()
      set ^websocket("error",$zh) = $system.Status.GetErrorText(status)
    }
	quit $$$OK
}

ClassMethod Init(smode As %Integer = 0) As %Status
{
  kill ^websocket
  set ^websocket("smode") = smode
  quit $$$OK
}

}
