package 
{
	/**
	 * ...
	 * @author lilanz
	 */
//导入包

import flash.display.*;

import flash.display.SimpleButton;

import flash.events.*;

import mx.controls.Alert;

import flex.stu.FlexStuButtonState;

         //声明FlexStuButton类,继承于SimpleButton

         public class FlexStuButton extends SimpleButton

         {

                   //声明为未选中状态

                   public var selected:Boolean = false;

                   //声明一个具有构造参数的构造器

                   public function FlexStuButton(txt:String)

                   {

                            //创建一个抬起状态

                            upState= new FlexStuButtonState(0xFFFFFF, txt);

                            //创建一个按下状态

                            downState = new FlexStuButtonState(0xCCCCCC, txt);

                            //单击的状态

                            hitTestState = upState;

                            //经过的状态

                            overState = downState;

                            //添加一个单击事件

                            addEventListener(MouseEvent.CLICK, buttonClicked);

                   }

                   //创建一个响应单击事件的函数

                   public function buttonClicked(e:Event)

                   {

                   //弹出一个窗口

                            Alert.show("单击了按钮");

                   }

         }

}