//+------------------------------------------------------------------+
//|                                            AlgogeneGetSignal.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "ALGOGENE FINTECH. CO. LTD."
#property link      "https://algogene.com"
#property version   "1.00"
#property strict
#include <AlgogeneMT4.mqh>

double lasttimestamp;

//+------------------------------------------------------------------+
//| Define variables                                                 |
//+------------------------------------------------------------------+

int      commandPingMS  = 1000;                 // Refresh every 1000 milliseconds to get signals 
string   _user          = "algogene_username";
string   _api_key       = "algogene_apikey";
int      _bot_id        = 0;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
      EventSetMillisecondTimer(commandPingMS);
      
      // ----- Connect to ALGOGENE's WebSocket -----   
      
      checkLocalConnection();
      
      // Local machine not connected
      
      if (!localConnection) {
         return (INIT_FAILED);
      }
      
      // Local machine connected
      
      AG_WebSocket ws;
      
      ws.user = _user;
      ws.api_key = _api_key;
      ws.bot_id = _bot_id;
      
      ws.connect();
         
      return(INIT_SUCCEEDED);
      
      // ----- End -----
  }
  
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
      // ----- Disconnect from ALGOGENE's WebSocket -----
      
      disconnect();
      
      // ----- End -----
  }
  
  
//+------------------------------------------------------------------+
//| Expert timer function                                             |
//+------------------------------------------------------------------+
void OnTimer()
  {      
      

      // Check Local Connection
      
      checkLocalConnection();
      
      // Local Machine Disconnected
      
      if (!localConnection) {
         return;
      }
      
      // Local Machine Reconnected
      
      if (localConnection == 2) {
      
         // Reconnect WebSocket
         
         AG_WebSocket ws;
   
         ws.user = _user;
         ws.api_key = _api_key;
         ws.bot_id = _bot_id;
         
         ws.connect();
      }
      
      // Check WebSockect Connection
      
      if (!checkWebSocketConnection()) {
         return;
      }
      
      // Print Signals
      int n = getNumOfCommands();
      for(int i = 0; i < n; i++)
        {
            AG_Signal s;
            s.printSignal();
            
            //Print("msg>>> ", s.msg);
            //Print("timestamp>>> ", s.timestamp);
            //Print("symbol>>> ", s.symbol);
            //Print("buysell>>> ", s.buysell);
            //Print("openclose>>> ", s.openclose);
            //Print("ordetype>>> ", s.ordertype);
            //Print("quantity>>> ", s.quantity);
            //Print("takeProfitLevel>>> ", s.takeProfitLevel);
            //Print("stopLossLevel>>> ", s.stopLossLevel);
            //Print("price>>> ", s.price);
            //Print("timeinforce>>> ", s.timeinforce);
            //Print("holdtime>>> ", s.holdtime);
            //Print("tradeID>>> ", s.tradeID);
            
        }
      
      // ----- End -----
   }     

  
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   
  }