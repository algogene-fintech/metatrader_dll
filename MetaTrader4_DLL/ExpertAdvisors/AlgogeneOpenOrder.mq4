//+------------------------------------------------------------------+
//|                                           AlgogeneOpenOrder.mq4 |
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
string   _runmode       = "livetest";
string   _acccountid    = "algogene_accountid";


//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+

bool isNextCall(double t){
   if(lasttimestamp != t){
      lasttimestamp = t;
      return true;
   }
   else return false; 
}


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
      
   return(INIT_SUCCEEDED);
   
  }
  
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }
  
  
//+------------------------------------------------------------------+
//| Expert timer function                                             |
//+------------------------------------------------------------------+
void OnTimer()
  {      
      
  }     

  
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  
      string _symbol    = Symbol();
      int _buysell      = OP_BUY;
      double _lotsize   = 0.01;
      string _orderRef  = 123;
      double _slippage  = 1;
      double _price     = MarketInfo(Symbol(), MODE_ASK);
      
      
      // Get current timestamp
      double timestamp = iTime(_symbol, PERIOD_M1, 0); 
      
      // Check open condition
      if (isNextCall(timestamp)){
              
         // Send order
         int ticketID = OrderSend(_symbol, _buysell, _lotsize, _price, _slippage, 0, 0, 0, _orderRef, 0,0);
         
         if (ticketID < 0) {
            Print(">>> OrderSend Error <<<");
            return;
         }
         Print("OrderSend Success: ", ticketID);

         // ----- Post OpenOrder on ALGOGENE -----

         // Initialize AG_Order
         AG_Order order;
         
         // Set required fields
         order.user              = _user;
         order.api_key           = _api_key;
         order.runmode           = _runmode;
         order.accountid         = _acccountid;
         order.instrument        = "BTCUSD";
         
         // Set optional fields
         order.expiry            = "";
         order.right             = "";
         order.strike            = "";
         order.buysell           = "buy";
         order.volume            = _lotsize;
         order.ordertype         = "MKT";
         order.price             = _price;
         order.orderRef          = ticketID;
         //order.timeinforce       = 0;
         //order.takeProfitLevel   = _sl;
         //order.stopLossLevel     = _tp;
         //order.holdtime          = 0;
         //order.callback          = "";
                           
         string res = order.openOrder();
         Print("Algogene>>> OpenOrder of #", ticketID, ": ", res);
         
         // ----- End -----
      }
      
  }
