package
{
	import flash.accessibility.Accessibility;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.XMLSocket;
	import flash.display.Shape;
	import flash.text.TextField;	
	
	import mx.core.FlexSprite;
	import flash.external.*;
	import flash.display.Stage;
	import flash.text.TextFieldType;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	 
	
	/**
	 * ...
	 * @author lilanz
	 */
	public class Main extends Sprite 
	{
		private var socket:XMLSocket;
		private var tag:Number;
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			var nowdate:Date = new Date(); 
			tag = Math.round(nowdate.getTime() / 1000);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			try{
				//ExternalInterface 实现 JavaScript 与 ActionScript 之间的所有通信
				//[Fault] exception, information=Error: Error #2067: ExternalInterface 在此容器中不可用。
				//ExternalInterface 要求使用 Internet Explorer ActiveX、Firefox、Mozilla 1.7.5 及其更高版本或其它支持 NPRuntime 的浏览器。
				ExternalInterface.addCallback("flexTest", flexTest); 
			}catch (err:Error){
				
			}
			
			//var sprite:Sprite = new Sprite();			
			//sprite.graphics.beginFill(0xff0000, 0.5);
			//sprite.graphics.drawCircle(100, 200, 50);
			//sprite.graphics.endFill();
			//this.addChild(sprite);
			//sprite.addEventListener(Event.ENTER_FRAME, mov);
			
			var button:SimpleButton = new SimpleButton();						
			button.upState = drawBtn(0xcc6600,0, 0, 60, 20);			
			button.overState = drawBtn(0xFFcc00,0, 0, 60, 20);
			button.downState = drawBtn(0x996600,0, 0, 60, 20);
			button.hitTestState = button.upState;
			var buttonLab:Label = new Label();			    
			buttonLab.text = "调用外部JS";
			buttonLab.x = 0;
			buttonLab.y = 0;			
			button.addEventListener(MouseEvent.CLICK, callJS);				
			this.addChild(button);
			this.addChild(buttonLab);
			
			var buttonLabJG:Label = new Label();			    
			buttonLabJG.text = "结果:";
			buttonLabJG.x = button.x;
			buttonLabJG.y = button.y+button.height;
			this.addChild(buttonLabJG);
			
			var txt:TextField = new TextField();	
			txt.type = TextFieldType.INPUT;
			txt.name = "text";
			txt.text = "";
			txt.width = 400;
			txt.x = buttonLabJG.x;
			txt.y = buttonLabJG.y+buttonLabJG.height;				
			
			this.addChild(txt);
			
			
			var send:SimpleButton = new SimpleButton();								
			send.upState = drawBtn(0xcc6600,0, txt.y+txt.height, 50, 20);			
			send.overState = drawBtn(0xFFcc00,0, txt.y+txt.height, 50, 20);
			send.downState = drawBtn(0x996600,0, txt.y+txt.height, 50, 20);
			send.hitTestState = send.upState;			
			send.addEventListener(MouseEvent.CLICK, Send);
			var buttonSend:Label = new Label();			    
			buttonSend.text = "发送消息";
			buttonSend.x = 0;
			buttonSend.y = txt.y+txt.height;						
			this.addChild(send);
			this.addChild(buttonSend);
			
			
			var txt2:TextField = new TextField();				
			txt2.type = TextFieldType.INPUT;
			txt2.backgroundColor = 0x996600;
			txt.wordWrap = true;
			txt2.name = "txtContent";			
			txt2.text = "接收到的内容:";
			txt2.width = 400;
			txt2.height = 400;
			txt2.x = 0;
			txt2.y = txt.y + txt.height+20;		
			 
			this.addChild(txt2);
			//对齐方式
			this.stage.align = StageAlign.TOP_LEFT;
						
				
			
			//var loader:Loader = new Loader();
			//loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);

			//var urlLoader:URLLoader = new URLLoader;
			//urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError)

			try{
				socket = new XMLSocket()
				ConncetServer();
			}catch (err:Error)
			{
				trace("soket"+err.message);
			}
		}
		public function onError():void 
		{
			
		}
		//外部JS函数调用此函数
		public function flexTest(param:String):String
		{
			var txt:TextField = this.getChildByName("text") as TextField;
			txt.text = "js参数"+param;			
			return "Return from Flex:"+param;
		}
		//调用外部JS函数
		public function callJS(e:Event):void {
			var s:String
			try{				 
				s = ExternalInterface.call("jsTest", "Flex");   
			}catch (err:Error)
			{
				s = err.message; 
			}
			var txt:TextField = this.getChildByName("text") as TextField;
			txt.text = s;
			//var s:String = "hello";
			   
		} 
		public function drawBtn(color:uint,x:Number,y:Number,width:Number,height:Number):Shape
		{
			var shape:Shape=new Shape();
			with (shape.graphics)
			{
				beginFill(color,1);
				drawRect(x,y,width,height);		
				endFill();
			}
			return shape;
		}
		private function mov(e:Event):void
		{
			var s:Sprite=e.target as Sprite;
			s.x = s.x + 10;
		}
		
		private function ConncetServer():void
		{
			try{		
				this.socket.connect("127.0.0.1", 8080);
				socket.addEventListener(DataEvent.DATA,OnReceived);
				socket.addEventListener(Event.CONNECT , onConnected);
				socket.addEventListener(Event.CLOSE, OnClose); 
				socket.addEventListener(IOErrorEvent.IO_ERROR, OnIOError); 
				socket.addEventListener(ProgressEvent.PROGRESS, OnProgress); 
				socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, OnSecurityError); 

			 }catch (err:Error)
			{
				trace("ConncetServer"+err.message);
			}
		}
		private function OnClose(ArgEvent:Event):void 
		{
			var txt:TextField = this.getChildByName("txtContent") as TextField;
			txt.appendText("\n" + "OnClose--->" + ArgEvent);
			
		} 
		private function OnIOError(ArgEvent:IOErrorEvent):void 
		{ 
			trace("OnIOError--->" + ArgEvent.text); 
		} 
		private function OnProgress(ArgEvent:ProgressEvent):void 
		{ 
			trace("OnProgress--->" + ArgEvent.bytesLoaded + " Total:" + ArgEvent.bytesTotal); 
		} 
		private function OnSecurityError(ArgEvent:SecurityErrorEvent):void 
		{ 
			trace("OnSecurityError--->" + ArgEvent); 
		}
		
		private function onConnected(event:Event):void
		{
			if (socket.connected){
				try{
					socket.send(this.tag);					
				}catch (error:Error)
				{
					
				}
			}else{
				
			}
		}

		private function Send(e:Event):void
		{
			if (socket.connected){
				try{
					var txt:TextField = this.getChildByName("text") as TextField;
					socket.send(txt.text);
				}catch (error:Error)
				{
					
				}
			}else{
				
			}
		}

		private function OnReceived(event:DataEvent):void
		{			
			//trace("receive data.");
			var txt:TextField = this.getChildByName("txtContent") as TextField;
			txt.appendText("\n"+ event.text);
		}
		
	}
	
	
}