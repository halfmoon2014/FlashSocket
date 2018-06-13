package  
{
	 
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;

	/**
	 * 按钮类
	 * @author Jave.Lin
	 */	
	public class Button extends Sprite
	{
		private var _text:String;
		private var _isDowned:Boolean=false;
		private var _isOnClickShake:Boolean=true;
		
		public function get isOnClickShake():Boolean{return _isOnClickShake;}
		public function set isOnClickShake(value:Boolean):void
		{
			if(_isOnClickShake!=value)
			{
				_isOnClickShake=value;
				if(_isOnClickShake)
				{
					addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
					addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
				}
				else
				{
					removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
					removeEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
				}
			}
		}
		
		public function get text():String{return _text;}
		public function set text(value:String):void
		{
			if(_text!=value)
			{
				_text=value;
				refresh();
			}
		}
		
		private var _label:Label;
		
		private var _isAutoSize:Boolean=true;
		
		public function get isAutoSize():Boolean{return _isAutoSize;}
		public function set isAutoSize(value:Boolean):void
		{
			if(_isAutoSize!=value)
			{
				_isAutoSize=value;
				refresh();
			}
		}
		//背景与文字的边框间距
		private var _bgMargin:Number=2;
		
		public function Button($text:String="button")
		{
			this.mouseChildren = false;
			
			text=$text;
			
			initialize();
		}
		
		private function initialize():void
		{
			this.mouseChildren=false;
			
			if(stage)
			{
				onAddedToStageHandler();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE,onAddedToStageHandler);
			}
			
			refresh();
		}
		
		private function onAddedToStageHandler(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStageHandler);
			
			addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStageHandler);
			
			addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			//默认抖动的
			if(_isOnClickShake)
			{
				addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
				addEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
			}
		}
		
		private function onMouseUpHandler(e:MouseEvent=null):void
		{
			if(_isDowned)
			{
				_isDowned=false;
				this.x-=1;
				this.y-=1;
			}
		}
		
		private function onMouseDownHandler(e:MouseEvent):void
		{
			if(!_isDowned)
			{
				_isDowned=true;
				this.x+=1;
				this.y+=1;
			}
		}
		
		private function onMouseOutHandler(e:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
			
			onMouseUpHandler();
			
			filters=null;
		}
		
		private function onMouseOverHandler(e:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			
			filters=[new GlowFilter(0x00ff00,1,3,3,3)];
		}
		
		private function onRemovedFromStageHandler(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStageHandler);
			removeEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
			removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			removeEventListener(MouseEvent.MOUSE_UP,onMouseUpHandler);
		}
		
		private function refresh():void
		{
			if(_label==null)
			{
				//font Verdana
				_label=new Label();
				addChild(_label);
			}
			
			_label.text=text;
			
			//获取字体位置、大小
			var textFieldRect:Rectangle=_label.getBounds(this);
			
			//居中
			_label.x=-textFieldRect.width/2;
			_label.y=-textFieldRect.height/2;
			
			if(_isAutoSize)
			{
				refreshBackground();
			}
		}
		
		protected function refreshBackground():void
		{
			//获取字体位置、大小
			var textFieldRect:Rectangle=_label.getBounds(this);
			
			//背景也居中
			this.graphics.clear();
			this.graphics.beginFill(0x55aa00, 0.5);
			this.graphics.drawRect(
				(-textFieldRect.width/2)-_bgMargin,
				(-textFieldRect.height/2)-_bgMargin,
				textFieldRect.width+(_bgMargin*2),
				textFieldRect.height+(_bgMargin*2)
			);
			this.graphics.endFill();
		}
	}

}