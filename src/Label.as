package 
{
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * 显示标签，习惯了C#的输入文本框的名称：Label
	 * @author Jave.Lin
	 */
	public class Label extends TextField
	{
		public function get currentWidth():Number
		{
			return getBounds(this).width;
		}
		
		public function get currentHeight():Number
		{
			return getBounds(this).height;
		}
		
		public function Label($text:String="")
		{
			super();
			mouseEnabled=false;
			defaultTextFormat = new TextFormat("Verdana", 10, 0xffffff);
			autoSize = TextFieldAutoSize.LEFT;
			selectable = false;
			//描边
			filters=[new GlowFilter(0,1,2,2,6)];
			text=$text;
		}
	}
}