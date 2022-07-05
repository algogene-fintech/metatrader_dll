//+------------------------------------------------------------------+
//|                                                  AlgogeneMT4.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "ALGOGENE FINTECH. CO. LTD."
#property link      "https://algogene.com"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+

#import "C:\Users\user\Desktop\AlgogeneMT4.dll"
void initWebSocket(int msg_id, string user, string api_key, int bot_id);
void deinitWebSocket();
int getCommand(uchar& data[]);
int getNumOfCommands();
int checkConnection();

string getMsg();
string getTimestamp();
string getSymbol();
int getBuysell();
string getOpenclose();
string getOrdertype();
double getQuantity();
double getTakeProfitLevel();
double getStopLossLevel();
double getPrice();
int getTimeinforce();
int getHoldtime();
string getTradeID();

string openOrder(
   const string userID, const string api_key, const string runmode,
   const string accountid, const string instrument,
   const string expiry, const string right, const string strike,
   const string buysell, const string volume, const string ordertype,
   const double price, const int timeinforce, const double takeProfitLevel,
   const double stopLossLevel, const int holdtime, const string orderRef,
   const string callback);
string closeOrder(
   const string user, const string api_key, const string runmode,
   const string accountid, const string tradeIDs, const string orderRef);
#import


// Declaring Global Variables

int localConnection = 1;
uchar _command[260480];


// Declaring functions and classes

class AG_Signal
{
   public:
   
   string msg;
   string timestamp;
   string symbol;
   string buysell;
   string openclose;
   string ordertype;
   double quantity;
   double takeProfitLevel;
   double stopLossLevel;
   double price;
   int timeinforce;
   int holdtime;
   string tradeID;
   
   // Default Constructor
   AG_Signal() {
      msg = "";
      timestamp = "";
      symbol = "";
      buysell = 0;
      openclose = "";
      ordertype = "";
      quantity = 0.0;
      takeProfitLevel = 0.0;
      stopLossLevel = 0.0;
      price = 0.0;
      timeinforce = 0;
      holdtime = 0;
      tradeID = "";
   }
   
   void printSignal() {
      int isSuccess = getCommand( _command );
      if (isSuccess) {  
             
         // Set data members
         msg = getMsg();
         timestamp = getTimestamp();
         symbol = getSymbol();
         buysell = getBuysell();
         openclose = getOpenclose();
         ordertype = getOrdertype();
         quantity = getQuantity();
         takeProfitLevel = getTakeProfitLevel();
         stopLossLevel = getStopLossLevel();
         price = getPrice();
         timeinforce = getTimeinforce();
         holdtime = getHoldtime();
         tradeID = getTradeID();
         
         Print("signal>>> ",CharArrayToString( _command ));
      }
   }
};

class AG_WebSocket
{
   public:
   
   string user;
   string api_key;
   int msg_id;
   int bot_id;

   // Default Constructor
   AG_WebSocket() {
      user = "";
      api_key = "";
      msg_id = 1;
      bot_id = 0;
   }   
   
   int connect() {
      initWebSocket(msg_id, user, api_key, bot_id);
      return 1;
   }
};

void disconnect() {
   deinitWebSocket();
}

int checkWebSocketConnection() {
   if (!checkConnection()) {
      Print ("No WebSocket Connection");
      return 0;
   }
   return 1;
}

void checkLocalConnection() {
      // Local Machine Disconnected
      
      if (!IsConnected() && localConnection == 1) {
         Print("No Network Connection");
         disconnect(); // Disconnect from WebSocket
         localConnection = 0;
         return;
      }
      if (!IsConnected() && localConnection == 0) {
         return;
      }
      if (IsConnected() && localConnection == 0) {
         // Reconnect
         Print("Network Reconnected");
         localConnection = 2;
         return;
      }
      
      // Local Machine Connected
      localConnection = 1;
}

class AG_Order
{
   public:
   
   string user;
   string api_key;
   string runmode;
   string accountid;
   string token;
   string instrument;
   string expiry;
   string right;
   string strike;
   string buysell;
   string volume;
   string ordertype;
   double price;
   int timeinforce;
   double takeProfitLevel;
   double stopLossLevel;
   int holdtime;
   string orderRef;
   string callback;
   string tradeIDs;
   
   // Default Constructor
   AG_Order() {
      user = "";
      api_key = "";
      runmode = "";
      accountid = "";
      token = "";
      instrument = "";
      expiry = "";
      right = "";
      strike = "";
      buysell = "";
      volume = "";
      ordertype = "";
      price = 0.0;
      timeinforce = 0;
      takeProfitLevel = 0.0;
      stopLossLevel = 0.0;
      holdtime = 0;
      orderRef = "";
      callback = "";
      tradeIDs = "";
   }
      
   string openOrder() {
      string res = openOrder(
         user, api_key, runmode,
         accountid, instrument, expiry,
         right, strike, buysell,
         volume, ordertype, price,
         timeinforce, takeProfitLevel, stopLossLevel,
         holdtime, orderRef, callback);
      return res;
   }
   
   string closeOrder() {
      string res = closeOrder(
         user, api_key, runmode,
         accountid, tradeIDs, orderRef);
      return res;   
   }

};

