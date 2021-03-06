# Algogene MetaTrader DLL

Algogene_x86.dll and Algogene_x64.dll are dynamic linked libraries that can be used in your MetaTrader Expert Advisors to obtain useful trading signals from Algogene's server and publish trading records to your Algogene account for advanced analysis.

## Objectives

* To enable users to connect to Algogene's Websockets for obtaining tailored executable trading signals

* To allow users to publish trading signals from MetaTrader onto Algogene's server for advanced algorithmic evaluations 

* To accomodate the two latest versions of MetaTrader, i.e. MetaTrader4 and MetaTrader5

* To adopt Object-Oriented Programming to provide a neat interface by the use of abstractions

* To enable easy and convenient setup without the need for installations

<sub><sup>DLLs from this repository contain third-party packages, which we do not warrant, endorse, or assume liability for.</sup></sub>

## Set up MetaTrader

#### For MetaTrader4

1. Clone/ Download this repository to your local machine

2. From MetaTrader4_DLL > ExpertAdvisors, add the three mq4 files (AlgogeneGetSignal, AlgogeneOpenOrder, AlgogeneCloseOrder) to your MetaTrader's ExpertAdvisors folder

3. From MetaTrader4_DLL> Include, add the header file (AlgogeneMT4.mqh) in your MetaTrader's Include folder

4. Copy the path of the Dynamic Linked Library file (MetaTrader4_DLL > Lib > Algogene_x86.dll), and paste it in line 15 in the header file from Step 3.

5. Input the configurations in your Expert Advisors files
	```
	_user
	_api_key
	_bot_id
	```
	or 
	```
	_user
	_api_key
	_runmode
	_accountid
	```

6. In MetaTrader, enable "Auto Trading" and "Allow DLL imports" under Tools > Options > ExpertAdvisors

#### For MetaTrader5

1. Clone/ Download this repository to your local machine

2. From MetaTrader5_DLL > ExpertAdvisors, add the three mq5 files (AlgogeneGetSignal, AlgogeneOpenOrder, AlgogeneCloseOrder) to your MetaTrader's ExpertAdvisors folder

3. From MetaTrader5_DLL > Include, add the header file (AlgogeneMT5.mqh) in your MetaTrader's Include folder

4. Copy the path of the Dynamic Linked Library file (MetaTrader5_DLL > Lib > Algogene_x64.dll), and paste it in line 16 in the header file from Step 3.

5. Input the configurations in your Expert Advisors files
	```
	_user
	_api_key
	_bot_id
	```
	or 
	```
	_user
	_api_key
	_runmode
	_accountid
	```

6. In MetaTrader, enable "Auto Trading" and "Allow DLL imports" under Tools > Options > ExpertAdvisors

## Functionalities

### Get Trading Signals from Algogene

- `AG_WebSocket` is a class for establishing a websocket connection with Algogene's server
- `AG_Signal` configures the structure of signals received from the server, whereas users can print the full trading signals by calling `printSignal()`
- Extract/Access information from signal by accessing the data members of `AG_Signal` instance
- Below are all the information/ data members available in a trading signal
	```
	msg
	timestamp
	symbol
	buysell
	openclose
	ordertype
	quantity
	takeProfitLevel
	stopLossLevel
	price
	timeinforce
	holdtime
	tradeID
	```
- With the spontaneous extraction of details of the obtained trading signals, users can place orders in a convenient manner
- Refer to AlgogeneGetSignal for relevant examples

### Publish Trading Signals to Algogene

- `AG_Order` defines the structure of an order with the following fields available for users to input
	```
	instrument (required)
	expiry
	right
	strike
	buysell
	volume
	ordertype
	price
	orderRef
	timeinforce
	takeProfitLevel
	stopLosslevel
	holdtime
	callback
	```

#### Publish Open Order Signals
- After doing OrderSend on MetaTrader, users can record their transactions on Algogene's platform by calling `openOrder()`
- Refer to AlgogeneOpenOrder for relevant examples

#### Publish Close Order Signals
- After doing OrderClose on MetaTrader, users can record their transactions on Algogene's platform by calling `closeOrder()`
- Refer to AlgogeneCloseOrder for relevant examples

## References

- AG_Websocket connects to Algogene's Trade History Channel: https://algogene.com/RestDoc#/schemas/WebSocket-Trade
- Open order function calls Algogene's REST API: https://algogene.com/RestDoc#/operations/post-open_order
- Close order function calls Algogene's REST API: https://algogene.com/RestDoc#/operations/post-close_orders


