//+------------------------------------------------------------------+
//|                                           AlgogeneCloseOrder.mq4 |
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
      int maxDuration = 60 * 1; //close order after 1 minutes
          
      for(int i=0; i<OrdersTotal(); i++) {
          if(OrderSelect(i,SELECT_BY_POS)){
            
            datetime open_time = OrderOpenTime();
            int duration = TimeCurrent() - open_time;
              
            if (duration > maxDuration) {
               int ticketID = OrderTicket();
               bool success = OrderClose(ticketID, OrderLots(), OrderClosePrice(), 1);
               
               if (!success) {
                  Print(">>> OrderClose Error <<<");
               }
               Print("OrderClose Success: ", ticketID);

               
               // ----- Post CloseOrder on ALGOGENE -----
               
               // Initialize AG_Order
               AG_Order order;
               
               // Set required fields
               order.user        = _user;
               order.api_key     = _api_key;
               order.runmode     = _runmode;
               order.accountid   = _acccountid;
               order.orderRef    = ticketID;
                                 
               string res = order.closeOrder();
               Print("Algogene>>> CloseOrder of #", ticketID, ": ", res);
      
               // ----- End -----
            }   
          }
      }
   
  }
