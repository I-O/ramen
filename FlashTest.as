package
{
/*
	Tonkotsu (pork) Ramen, Enjoy ! :)
	特製 煮卵チャーシュー全部いり、へいおまち
*/
	import flash.display.Sprite;

	public class FlashTest extends Sprite
	{
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		import flash.display.Graphics;
		import flash.display.GradientType;
		import flash.display.SpreadMethod;
		import flash.events.Event;
		import flash.geom.Point;
		import flash.geom.Matrix;

		import flash.filters.BlurFilter;
		import flash.filters.BevelFilter;
		import flash.filters.GlowFilter;

		import flash.display.BlendMode;
		import flash.display.Stage;
		import flash.display.StageScaleMode;

		private var cvSt:Bitmap;
		private var bmSt:BitmapData;
		private var cvStF:Bitmap;
		private var bmStF:BitmapData;
		private var maskR:BitmapData;
		private var maskSt:Sprite;

		private var _spRamenBg:Sprite;
		private var _spRamen:Sprite;

		private var aryOffset:Array   = new Array();
		private var aryOffsetSP:Array = new Array();

		private var aryGC:Array;
		private var aryGA:Array;
		private var aryGR:Array;
		private var matG:Matrix;

		private var bvlDish:BevelFilter;
		private var bvlTopper:BevelFilter;
		private var bvlTopperInner:BevelFilter;

		[swf(width="465", height="465", bgcolor="#ffffff")]

		public function FlashTest():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 15;

			bvlDish        = new BevelFilter(4, -45, 0xffffff,1, 0x000000,1
			                           ,16, 16, 0.5
			                           ,1, "inner", false);
			bvlTopper      = new BevelFilter(4, 45, 0xffffff,1, 0x000000,1
			                           ,4, 4, 0.5
			                           ,1, "outer", false);
			bvlTopperInner = new BevelFilter(4, 15, 0xffffff,1, 0x000000,0
			                           ,16, 16, 1
			                           ,1, "inner", false);

			// Ramen(background)
			_spRamenBg = makeRamenBg();
			addChild(_spRamenBg);

			initSteam();

			// Ramen(main)
			_spRamen= makeRamen();
			addChild(_spRamen);

			initSteamFront();

			// Act
			addEventListener(Event.ENTER_FRAME, actSteam);
		}

		// ------------------------------------
		// Ramen(background)
		private function makeRamenBg():Sprite
		{
			var retVal:Sprite = new Sprite();

			// dish
			var _d1Dish:Sprite = mADish();

			// soup
			var _d1Soup:Sprite = mASoup();

			retVal.addChild(_d1Dish);
			retVal.addChild(_d1Soup);
			return retVal;
		}

		// ------------------------------------
		// Steam
		private function initSteam():void
		{
			bmSt = new BitmapData(470, 220, true, 0xffffff);
			cvSt = new Bitmap(bmSt);
			cvSt.x += 20;
			cvSt.y += 80;
			addChild(cvSt);

			maskR  = new BitmapData(470, 470, true, 0x000000);
			maskSt = new Sprite();
			maskSt.y += 30;
			var aryStC:Array = [0xffffff, 0xffffff, 0xffffff];
			var aryStA:Array = [0.2, 0.2, 1];
			var aryStR:Array = [0, 0x11, 0xcc];
			var matSt:Matrix = new Matrix();
			matSt.createGradientBox(550, 330, 90, 0,0);
			with(maskSt.graphics){
				beginGradientFill(GradientType.RADIAL, aryStC, aryStA, aryStR, matSt, SpreadMethod.PAD, "rgb", 1);
				drawCircle(232.5, 250, 335);
				endFill();
			}
			maskR.draw(maskSt);
			maskR.draw(bmSt);
			addChild(new Bitmap(maskR));
			cvSt.blendMode = BlendMode.SCREEN;

			aryOffsetSP = [0.5, 3];
			aryOffset   = [new Point(), new Point()];
		}

		private function initSteamFront():void
		{
			var maskStF:Sprite = new Sprite();
			with(maskStF.graphics){
				beginFill(0x000000,1);
				drawCircle(232.5, 295, 225);
				endFill();
			}
			maskStF.scaleY=0.58;
			

			cvStF   = new Bitmap(bmSt);
			cvStF.x = 18;
			cvStF.y = 78;
			cvStF.blendMode = BlendMode.OVERLAY;
			cvStF.alpha=0.7;
			cvStF.mask = maskStF;
			addChild(maskStF);
			addChild(cvStF);
		}

		private function actSteam(e:Event):void
		{
			aryOffset[0].x += aryOffsetSP[0];
			aryOffset[1].y += aryOffsetSP[1];
			bmSt.perlinNoise(30, 30, 2, 2, false, true, 1, true, aryOffset);
			bmSt.draw(cvSt);
			bmSt.draw(cvStF);
		}

		// ------------------------------------
		// Ramen(Main)
		private function makeRamen():Sprite
		{
			var retVal:Sprite = new Sprite();

			// garlic chips
			var _d2Chips:Sprite    = mBChips();

			// soup
			var _d2Soup:Sprite     = mBSoup1();
			var _d2SoupOil:Sprite  = mBSoup2();
			var _d2SoupGlow:Sprite = mBSoupGlow();

			// nori 
			var _d2Nori:Sprite     = mBNori();
			// noriTxt
			var _d2Txt:Sprite      = mBTxt();

			// noodle
			var _d2Noodle:Sprite   = mBNoodle();

			// cloud ear
			var _d2Kikurage:Sprite = mBKikurage();

			// char siu
			var _d2Charsiu:Sprite  = mBCharsiu();

			// egg
			var _d2Egg:Sprite      = mBEgg();

			// leek
			var _d2Negi:Sprite     = mBNegi();

			// dish (outline)
			var _d2Dish1:Sprite    = mBDish1();
			var _d2Dish2:Sprite    = mBDish2();
			var _d2Dish3:Sprite    = mBDish3();

			// shade
			var _d2Shade1:Sprite   = mBShade1();

			retVal.addChild(_d2Nori);
			retVal.addChild(_d2Shade1);
			retVal.addChild(_d2SoupGlow);
			retVal.addChild(_d2Dish1);
			retVal.addChild(_d2Txt);
			retVal.addChild(_d2Chips);
			retVal.addChild(_d2Noodle);
			retVal.addChild(_d2Soup);
			retVal.addChild(_d2Kikurage);
			retVal.addChild(_d2Charsiu);
			retVal.addChild(_d2SoupOil);
			retVal.addChild(_d2Negi);
			retVal.addChild(_d2Egg);
			retVal.addChild(_d2Dish2);
			retVal.addChild(_d2Dish3);

			return retVal;
		}

		// ------------------------------------
		// pieces

		private function mADish():Sprite
		{
			var retVal:Sprite = new Sprite();
			with(retVal.graphics){
				beginFill(0x990000, 1);
				moveTo(8, 190);
				curveTo(50,96 , 200,88);
				curveTo(232.5,85 , 265,88);
				curveTo(415,100 , 457,190);
				lineTo(445, 330);
				lineTo(20, 330);
				endFill();
			}
			return retVal;
		}

		private function mASoup():Sprite
		{
			var retVal:Sprite = new Sprite();
			aryGC = [0xff6600, 0xffff99];
			aryGA = [1, 1];
			aryGR = [0, 0xee];
			matG  = new Matrix();
			matG.createGradientBox(470, 330, 0, 0,0);
			with(retVal.graphics){
				beginGradientFill(GradientType.LINEAR, aryGC, aryGA, aryGR, matG, SpreadMethod.PAD, "rgb", 1);
				drawCircle(230, 430, 200);
				endFill();
			}
			retVal.scaleY= 0.5;
			return retVal;
		}


		private function mBChips():Sprite
		{
			var retVal:Sprite = new Sprite();
			for(var i:int=0; i<500; i++){
				var pD2:Sprite = new pChip();
				pD2.x      = 30+ Math.round(Math.random()*400);
				pD2.y      = 130+ Math.round(Math.random()*200);
				pD2.alpha -= Math.round(pD2.y-130)/200;
				retVal.addChild(pD2);
			}
			var maskD2E:Sprite = new Sprite();
			with(maskD2E.graphics){
				beginFill(0x000000,1);
				drawCircle(230, 430, 205);
				endFill();
			}
			maskD2E.scaleY= 0.52;
			retVal.mask = maskD2E;

			return retVal;
		}

		private function mBNori():Sprite
		{
			var retVal:Sprite   = new Sprite();
			var _d2Nori1:Sprite = new Sprite();
			var _d2Nori2:Sprite = new Sprite();

			aryGC = [0x110000, 0xffa033];
			aryGA = [1, 1];
			aryGR = [0, 0x99];
			matG  = new Matrix();
			matG.createGradientBox(200, 200, Math.PI/4*3, 0,0);

			with(_d2Nori1.graphics){
				beginGradientFill(GradientType.LINEAR, aryGC, aryGA, aryGR, matG, SpreadMethod.PAD, "rgb", 0.7);
				moveTo(270, 30);
				curveTo(320,30, 340, 24);
				curveTo(340,170, 320,200);
				lineTo(250,190);
				curveTo(270,150, 270,30);
				endFill();
			}

			aryGC = [0x221111, 0xffaa3a];
			with(_d2Nori2.graphics){
				beginGradientFill(GradientType.LINEAR, aryGC, aryGA, aryGR, matG, SpreadMethod.PAD, "rgb", 0.7);
				moveTo(330, 45);
				curveTo(380,60, 400, 60);
				curveTo(395,170, 355,230);
				lineTo(300,205);
				curveTo(330,150, 330,45);
				endFill();
			}

			var _d2BNori:BitmapData= new BitmapData(200,250,true,0x000000);
			_d2BNori.noise(Math.round(Math.random()*100), 0, 40, 1);
			var _d2PNori1:Bitmap= new Bitmap(_d2BNori);
			var _d2PNori2:Bitmap= new Bitmap(_d2BNori);
			_d2PNori1.x= _d2PNori2.x= 250;
			_d2PNori1.y= _d2PNori2.y= 0;
			_d2PNori1.blendMode= BlendMode.SCREEN;
			_d2PNori2.blendMode= BlendMode.SCREEN;
			_d2Nori1.blendMode = BlendMode.INVERT;
			_d2Nori1.blendMode = BlendMode.INVERT;

			retVal.addChild(_d2Nori1);
			retVal.addChild(_d2Nori2);
			retVal.addChild(_d2PNori1);
			retVal.addChild(_d2PNori2);

			return retVal;
		}

		private function mBTxt():Sprite
		{
			var retVal:Sprite = new Sprite();
			var pTxtC1:Sprite = new Sprite();
			var pTxtC2:Sprite = new Sprite();
			var pTxtC3:Sprite = new Sprite();
			with(pTxtC1.graphics){
				lineStyle(3, 0xfff6f6, 1, false, "NONE", "SQUARE", "MITER", 3);
				moveTo(0,10);
				lineTo(0,6);
				curveTo(1,1, 6,0);
				lineTo(32,0);
			}
			with(pTxtC2.graphics){
				lineStyle(3, 0xfff6f6, 1, false, "NONE", "SQUARE", "MITER", 3);
				moveTo(0,0);
				lineTo(0,10);
			}
			with(pTxtC3.graphics){
				lineStyle(3, 0xfff6f6, 1, false, "NONE", "SQUARE", "MITER", 3);
				moveTo(0,0);
				lineTo(32,0);
			}
			retVal.addChild(pTxtC1);
			retVal.addChild(pTxtC2);
			retVal.addChild(pTxtC3);
			pTxtC2.x = 8;
			pTxtC3.x = 1;
			pTxtC3.y = 16;
			retVal.x = 355;
			retVal.y = 80;
			retVal.scaleX    = -1;
			retVal.rotation  = -80;
			retVal.alpha     = 0.95;
			retVal.blendMode = BlendMode.LAYER;

			var blurNoriTxt:BlurFilter = new BlurFilter(2,0);
			retVal.filters= [blurNoriTxt];
			return retVal;
		}

		private function mBNoodle():Sprite
		{
			var retVal:Sprite = new Sprite();
			return retVal;
		}

		private function mBKikurage():Sprite
		{
			var retVal:Sprite = new Sprite();
			for(var i:int=0; i<80; i++){
				var pD:Sprite = new pKikurage();
				pD.x= Math.round(Math.random()*120);
				pD.y= i+ Math.round(Math.random()*60);
				retVal.addChild(pD);
			}
			retVal.scaleY= 0.6;
			retVal.x = 80;
			retVal.y = 150;
			retVal.filters= [bvlTopper];
			return retVal;
		}

		private function mBCharsiu():Sprite
		{
			var retVal:Sprite = new Sprite();

			var pNum:uint = 3;

			aryGC = [0xbb9999,0xddb9b9, 0x990000,0xffffff];
			aryGA = [1, 1, 1, 0.8];
			aryGR = [0, 0x11, 0x22, 0xcc];
			matG  = new Matrix();
			matG.createGradientBox(100, 100, 0, 0,0);
			var blurC:BlurFilter = new BlurFilter(4,4);
			var bvlC:BevelFilter = new BevelFilter(4, 70, 0xffffff,0, 0x996666,1
			                                      ,8, 8, 1
			                                      ,1, "outer", false);

			for(var i:int=0; i<pNum; i++){
				var rc:uint    = Math.round(Math.random()*0);
				var pS1:Sprite = new Sprite();
				var pS2:Sprite = new Sprite();

				with(pS1.graphics){
					switch(rc){
						case 0:
							beginFill(0xeecccc, 1);
							moveTo(45,0);
							curveTo(78,10, 80,50);
							curveTo(65,100, 50,100);
							curveTo(0,100, 0,70);
							curveTo(0,25, 10,25);
							curveTo(10,10, 45,0);
							endFill();
							break;
		
						case 1:
							break;
		
						case 2:
							break;
		
						case 3:
							break;
					}
				}
				with(pS2.graphics){
					beginGradientFill(GradientType.RADIAL, aryGC, aryGA, aryGR, matG, SpreadMethod.REFLECT, "rgb", 0);
					switch(rc){
						case 0:
							moveTo(40,0);
							curveTo(70,0, 70,45);
							curveTo(60,35, 50,80);
							curveTo(50,90, 20,80);
							curveTo(0,50, 10,30);
							curveTo(0,0, 40,0);
							break;
		
						case 1:
							break;
		
						case 2:
							break;
		
						case 3:
							break;
					}
				}
		
				pS2.x += 7;
				pS2.y += 7;
				pS2.alpha=0.7;
				//pS2.blendMode = BlendMode.OVERLAY;
				pS2.filters= [blurC];

				pS1.addChild(pS2);
				pS1.rotation = -40 + i*10;
				pS1.x       -= i*5;

				var glowC:GlowFilter= new GlowFilter(0x660000,0.5,16,16,2,2,true,false);

				pS1.filters  = [glowC,bvlC];
				retVal.addChild(pS1);
			}

			retVal.scaleX = 1.6;
			retVal.scaleY = 1.1;
			retVal.x      = 235;
			retVal.y      = 170;
			return retVal;
		}

		private function mBEgg():Sprite
		{
			var retVal:Sprite  = new Sprite();
			var pEgg1:Sprite   = new Sprite();
			var pEgg1C1:Sprite = new Sprite();
			var pEgg2:Sprite   = new Sprite();
			var pEgg2C1:Sprite = new Sprite();

			aryGC = [0xffeecc, 0xff9900];
			aryGA = [1, 0.6];
			aryGR = [0xaa, 0xff];
			matG  = new Matrix();
			matG.createGradientBox(90, 120, Math.PI/2, 0,0);
			with(pEgg1.graphics){
				beginGradientFill(GradientType.LINEAR, aryGC, aryGA, aryGR, matG, SpreadMethod.PAD, "rgb", 1);
				moveTo(60,0);
				curveTo(90,20, 90,60);
				curveTo(84,120, 30,120);
				curveTo(0,120, 0,100);
				curveTo(0,60, 10,40);
				curveTo(20,0, 60,0);
				endFill();
			}
			matG  = new Matrix();
			matG.createGradientBox(80, 140, Math.PI/2, 0,0);
			with(pEgg2.graphics){
				beginGradientFill(GradientType.LINEAR, aryGC, aryGA, aryGR, matG, SpreadMethod.PAD, "rgb", 1);
				moveTo(40,0);
				curveTo(80,15, 80,70);
				curveTo(80,140, 50,140);
				curveTo(0,140, 0,80);
				curveTo(0,35, 15,15);
				curveTo(25,0, 40,0);
				endFill();
			}

			aryGC = [0xffff66, 0xff6600];
			aryGA = [1, 1];
			aryGR = [0, 0xff];
			matG  = new Matrix();
			matG.createGradientBox(50, 50, 0, 0,0);
			with(pEgg1C1.graphics){
				beginGradientFill(GradientType.RADIAL, aryGC, aryGA, aryGR, matG, SpreadMethod.REFLECT, "rgb", 0);
				moveTo(50, 0);
				curveTo(70,0, 70,20);
				curveTo(65,80, 35,85);
				curveTo(0,85, 0,65);
				curveTo(-5,-5, 50,0);
				endFill();
			}
			with(pEgg2C1.graphics){
				beginGradientFill(GradientType.RADIAL, aryGC, aryGA, aryGR, matG, SpreadMethod.REFLECT, "rgb", 0);
				moveTo(30, 0);
				curveTo(60,0, 60,45);
				curveTo(60,90, 35,90);
				curveTo(0,85, 0,40);
				curveTo(0,0, 30,0);
				endFill();
			}

			pEgg1C1.x = 7;
			pEgg1C1.y = 20;
			pEgg1.addChild(pEgg1C1);
			pEgg2C1.x = 10;
			pEgg2C1.y = 24;
			pEgg2.addChild(pEgg2C1);
			pEgg1C1.filters= [bvlTopperInner];
			pEgg2C1.filters= [bvlTopperInner];

			pEgg2.x = 88;
			pEgg2.y = 20;
			retVal.addChild(pEgg1);
			retVal.addChild(pEgg2);

			retVal.scaleY = 0.6;
			retVal.x      = 50;
			retVal.y      = 215;

			var blurEgg:BlurFilter= new BlurFilter(2,2);
			var bvlEgg:BevelFilter= new BevelFilter(4, 45, 0xffffff,0, 0x000000,1
			                                       ,4, 4, 0.5
			                                       ,1, "outer", false);

			retVal.filters= [blurEgg, bvlEgg];
			return retVal;
		}

		private function mBNegi():Sprite
		{
			var retVal:Sprite = new Sprite();
			var ir:uint;
			var im:uint= 200;
			for(var i:int=0; i<im; i++){
				var pDG:Sprite = new pNegi();
				ir     = Math.round(Math.random()*90);
				pDG.x  = 120+ Math.round(Math.random()*160);
				pDG.y  = 160 + (Math.abs(200-pDG.x)/2) + ir;
				pDG.x += (pDG.y<205) ? ir/2: -(ir/2);
				pDG.alpha-= ir/90;
				retVal.addChild(pDG);
			}
			retVal.alpha=0.8;
			retVal.scaleY=0.7;
			retVal.filters = [bvlTopper];
			return retVal;
		}

		private function mBSoup1():Sprite
		{
			var retVal:Sprite= new Sprite();
			aryGC = [0xffffff, 0xff9900];
			aryGA = [0.1, 0.4];
			aryGR = [0x66, 0xff];
			matG  = new Matrix();
			matG.createGradientBox(470, 330, 90, 0,0);
			with(retVal.graphics){
				beginGradientFill(GradientType.LINEAR, aryGC, aryGA, aryGR, matG, SpreadMethod.PAD, "rgb", 1);
				drawCircle(230, 430, 205);
				endFill();
			}
			retVal.scaleY  = 0.52;
			var blurSoup:BlurFilter= new BlurFilter(2,2);
			retVal.filters = [blurSoup];
			return retVal;
		}

		private function mBSoup2():Sprite
		{
			var retVal:Sprite = new Sprite();
			var _d2Soup2a:Sprite = new Sprite();
			var _d2Soup2b:Sprite = new Sprite();
			with(_d2Soup2a.graphics){
				beginFill(0xffffff,0.7);
				moveTo(160,125);
				curveTo(0,160, 40,260);
				curveTo(30,180, 160,125);
			}
			retVal.addChild(_d2Soup2a);
			with(_d2Soup2b.graphics){
				beginFill(0xffffff,0.7);
				moveTo(380,155);
				curveTo(470,210, 400,280);
				curveTo(360,300, 250,300);
				curveTo(350,290, 400,240);
				curveTo(430,180, 380,155);
			}
			retVal.addChild(_d2Soup2b);
			return retVal;
		}

		private function mBSoupGlow():Sprite
		{
			var retVal:Sprite = mASoup();
			var bvlSoup:BevelFilter= new BevelFilter(4,135,0xffffff,1,0xcc6600,1
													,16,16
													,1,1,"inner",false);
			retVal.filters        = [bvlSoup];
			retVal.blendMode      = BlendMode.ADD;
			return retVal;
		}

		private function mBDish1():Sprite
		{
			var retVal:Sprite = new Sprite();

			aryGC = [0x000000, 0xcc6600];
			aryGA = [0.3, 0.3];
			aryGR = [0x11, 0xff];
			matG  = new Matrix();
			matG.createGradientBox(400, 280, 0, 0, 0);
			with(retVal.graphics){
				beginGradientFill(GradientType.LINEAR, aryGC, aryGA, aryGR, matG, SpreadMethod.PAD, "rgb", 1);
				moveTo(28, 154);
				curveTo(88,85, 232.5,85);
				curveTo(377,95, 437,154);
				curveTo(377,86, 232.5,86);
				curveTo(88,95, 28,154);
			}
			retVal.blendMode= BlendMode.DARKEN;

			return retVal;
		}

		private function mBDish2():Sprite
		{
			var retVal:Sprite = new Sprite();
			aryGC = [0xa05000, 0x000000];
			aryGA = [1, 1];
			aryGR = [0, 0xff];
			matG  = new Matrix();
			matG.createGradientBox(450, 450, Math.PI/4, 0,0);
			with(retVal.graphics){
				beginGradientFill(GradientType.LINEAR, aryGC, aryGA, aryGR, matG, SpreadMethod.PAD, "rgb", 1);
				moveTo(150, 337);
				curveTo(140,350, 135,378);
				curveTo(150,410, 232.5,414);
				curveTo(315,410, 330,378);
				curveTo(325,350, 315,337);
				endFill();
			}

			retVal.filters= [bvlDish];
			return retVal;
		}

		private function mBDish3():Sprite
		{
			var retVal:Sprite = new Sprite();
			aryGC = [0xcc6600, 0x000000];
			aryGA = [1, 1];
			aryGR = [0, 0xff];
			matG  = new Matrix();
			matG.createGradientBox(450, 450, Math.PI/4, 0,0);
			with(retVal.graphics){
				beginGradientFill(GradientType.LINEAR, aryGC, aryGA, aryGR, matG, SpreadMethod.PAD, "rgb", 1);
				moveTo(17, 170);
				curveTo(6,185, 8,207);
				curveTo(8,220, 17,240);
				curveTo(80,335, 182,377);
				curveTo(232.5,390, 283,377);
				curveTo(385,335, 448,240);
				curveTo(457,220, 457,207);
				curveTo(459,185, 448,170);

				curveTo(459,185, 454,204);
				curveTo(445,270, 320,295);
				curveTo(232.5,312, 145,295);
				curveTo(20,270, 11,204);
				curveTo(10,190, 17,170);

				endFill();
			}

			retVal.filters= [bvlDish];
			return retVal;
		}

		private function mBShade1():Sprite
		{
			var retVal:Sprite  = new Sprite();
			var _pW:Sprite     = new Sprite();
			var _pShade:Sprite = new Sprite();
			with(_pW.graphics){
				beginFill(0xcc6600,1);
				drawCircle(232, 400, 225);
				endFill();
			}
			_pW.scaleY= 0.5;

			with(_pShade.graphics){
				beginFill(0x000000,0.3);
				moveTo(135,378);
				curveTo(150,450, 330,420);
				curveTo(480,350, 540,310);
				curveTo(520,160, 350,120);
				endFill();
			}
			retVal.blendMode = BlendMode.LAYER;
			_pW.blendMode    = BlendMode.ERASE;

			var blurShade:BlurFilter= new BlurFilter(32,32);
			_pShade.filters= [blurShade];
			retVal.addChild(_pShade);
			retVal.addChild(_pW);
			return retVal;
		}
	}
}

import flash.display.Sprite;

// Chip
class pChip extends Sprite
{
	public function pChip():void
	{
		var t1:uint = Math.round(Math.random()*3);
		var t2:uint = Math.round(Math.random()*3);
		var t3:uint = Math.round(Math.random()*3);

		with(graphics){
			beginFill(0x330000,1);
			moveTo(0, 0);
			lineTo(t1, 0);
			lineTo(t1, t2);
			lineTo(t3, t2);
			endFill();
		}
		rotation     = Math.round(Math.random()*360);
		cacheAsBitmap= true;
	}
}

// Noodles
class pNoodle extends Sprite
{
	public function pNoodle():void
	{
	}
}

// leek
class pNegi extends Sprite
{
	public function pNegi():void
	{
		var aryC:Array = [0x009900, 0x009900, 0x00cc33, 0x00cc33, 0x00ff66];
		var t1:uint    = Math.round(Math.random()*(aryC.length-1));
		var t1b:uint   = Math.round(Math.random()*(aryC.length-1));
		var r1:uint    = 3+Math.round(Math.random()*7);
		var t2:uint    = Math.round(Math.random()*(aryC.length-1));
		var t2b:uint   = Math.round(Math.random()*(aryC.length-1));
		var r2:uint    = 2+Math.round(Math.random()*6);

		var p1:Sprite  = drawP(aryC[t1], r1);
		var p1b:Sprite = drawP(aryC[t1], r1-2);
		var p2:Sprite  = drawP(aryC[t2], r2);
		var p2b:Sprite = drawP(aryC[t2], r2-1);

		p1b.x += (p1.width-p1b.width)/2;
		p1b.y += (p1.height-p1b.height)/2;
		p1.addChild(p1b);
		p2b.x += (p2.width-p2b.width)/2;
		p2b.y += (p2.height-p2b.height)/2;
		p2.addChild(p2b);

		p2.x+= Math.round(Math.random()*(p1.width-p2.width));
		p2.y+= Math.round(Math.random()*(p1.height-p2.height));
		addChild(p1);
		addChild(p2);

		rotation       = Math.round(Math.random()*360);
		cacheAsBitmap  = true;
	}
	private function drawP(c:Number, r:uint):Sprite
	{
		var retVal:Sprite = new Sprite();
		with(retVal.graphics){
			beginFill(c, 1);
			drawCircle(0,0, r);
			endFill();
		}
		return retVal;
	}
}

// cloud ear
class pKikurage extends Sprite
{
	public function pKikurage():void
	{
		var pS:uint  = Math.round(Math.random()*1);
		var pT:uint  = 5+Math.round(Math.random()*3);
		var s1x:uint = 1 +Math.round(Math.random()*5);
		var s1y:uint = 1 +Math.round(Math.random()*5);
		var p1x:uint = 2 +Math.round(Math.random()*10);
		var p1y:uint = 2 +Math.round(Math.random()*10);
		var s2x:uint = 1 +Math.round(Math.random()*5);
		var s2y:uint = 1 +Math.round(Math.random()*5);
		var p2x:uint = 2 +Math.round(Math.random()*10);
		var p2y:uint = 2 +Math.round(Math.random()*10);
		var aryC:Array = [0x333333, 0x444444, 0x555555, 0x666666];
		var iC:uint    = Math.round(Math.random()*(aryC.length-1));

		with(graphics){
			lineStyle(pT, aryC[iC], 1, false, "NONE", "SQUARE", "MITER", 3);
			moveTo(0,0);
			curveTo(s1x,s1y, p1x,p2x);
			curveTo(p1x+s2x,p1y+s2y, p1x+p2x,p1y+p2y);
			endFill();
		}
		cacheAsBitmap    = true;
		rotation         = Math.round(Math.random()*360);
		if(pS==0) scaleX = -1;
	}
}
