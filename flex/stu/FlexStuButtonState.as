package 
{
	/**
	 * ...
	 * @author lilanz
	 */
	//导入包

         import flash.display.*;

         import flash.text.TextField;

         import flash.text.TextFormat;

         //定义一个继承于Sprite的按钮样式类FlexStuButtonState

         public class FlexStuButtonState extends Sprite

         {

                   //声明一个包可见的TextField实例用于显示按钮上的文本

                   internal var label:TextField;

                   //创建一个构造函数，在构建按钮的时候就传入按钮的颜色和显示文本

                   public function FlexStuButtonState(color:uint, labelText:String)

                   {

                   //创建按钮文本的实例

                   label = new TextField();

                   //将文本内容赋值给TextField实例

                   label.text = labelText;

                   //控制文本的位置

                   label.x = 2;

                   //声明文本格式

                   var format:TextFormat = new TextFormat("bold");

                   //设置文本格式

                   label.setTextFormat(format);

                   //设置按钮的宽度

                   var buttonWidth:Number = label.textWidth + 10;

                   //创建一个按钮的几何图形

                   var background:Shape = new Shape();

                   //填充颜色

                   background.graphics.beginFill(color);

                   //确定边界的颜色和粗细

                   background.graphics.lineStyle(1, 0x000000);

                   //绘画一个矩形作为按钮的形状

                   background.graphics.drawRoundRect(0, 0, buttonWidth, 18, 4);

                   //添加添加背景和文本给按钮

                   addChild(background);

                   addChild(label);

                   }

          }

}