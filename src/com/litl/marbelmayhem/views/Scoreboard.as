package com.litl.marbelmayhem.views
{
    import com.litl.marbelmayhem.events.MarbleEvent;
    import com.litl.marbelmayhem.model.GameManager;
    import com.litl.marbelmayhem.vo.Player;

    import flash.display.Loader;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class Scoreboard extends ViewBase
    {
        private var _view:ViewBase;
        private var model:GameManager = GameManager.getInstance();

        private var background:Sprite;
        private var timeBG:Loader;
        private var logo:Loader;
        private var timeDisplay:TextField;
        private var player1Icon:Loader;
        private var player2Icon:Loader;
        private var player1Score:TextField;
        private var player2Score:TextField;
        private var player1Life:PlayerOneLife;
        private var player2Life:PlayerTwoLife;

        public function Scoreboard(e:ViewBase) {
            super();
            _view = e;
            init();
        }

        private function init():void {
            createChildren();
            model.addEventListener(MarbleEvent.SCORE_CHANGED, updateProperties);
            model.addEventListener(MarbleEvent.TIMER_TICK, updateProperties);
            model.addEventListener(MarbleEvent.ADD_PLAYER, updateProperties);
            model.addEventListener(MarbleEvent.REMOVE_PLAYER, updateProperties);
        }

        private function createChildren():void {
            background = new Sprite();
            background.graphics.beginFill(0x333333);
            background.graphics.drawRect(0, 0, 1280, 800 * .1);
            addChild(background);

            logo = new Loader;
            logo.load(new URLRequest("../assets/logo.gif"));
            addChild(logo);

            timeBG = new Loader;
            timeBG.load(new URLRequest("../assets/time-bg.gif"));
            addChild(timeBG);

            var timeFormat:TextFormat = new TextFormat();
            timeFormat.font = "Calibri";
            timeFormat.size = 34;
            timeFormat.color = 0x000000;

            timeDisplay = new TextField();
            timeDisplay.text = "3:33";
            timeDisplay.defaultTextFormat = timeFormat;
            timeDisplay.setTextFormat(timeFormat);
            addChild(timeDisplay);

            var scoreFormat:TextFormat = new TextFormat();
            scoreFormat.font = "Calibri";
            scoreFormat.size = 26;
            scoreFormat.color = 0xffffff;

            player1Icon = new Loader;
            player1Icon.load(new URLRequest("../assets/scoreboard/playerOneIcon.png"));
            addChild(player1Icon);

            player1Score = new TextField();
            player1Score.defaultTextFormat = scoreFormat;
            player1Score.setTextFormat(scoreFormat);
            addChild(player1Score);

            player1Life = new PlayerOneLife();
            addChild(player1Life);

            player2Icon = new Loader;
            player2Icon.load(new URLRequest("../assets/scoreboard/playerTwoIcon.png"));
            addChild(player2Icon);

            player2Score = new TextField();
            player2Score.defaultTextFormat = scoreFormat;
            player2Score.setTextFormat(scoreFormat);
            addChild(player2Score);

            player2Life = new PlayerTwoLife();
            addChild(player2Life);

            updateLayout();
            updateProperties();
        }

        private function updateProperties(e:Event = null):void {
            switch (model.playersInGame.length) {
                case 0:
                    player1Icon.visible = false;
                    player1Score.visible = false;
                    player1Life.visible = false;
                    player2Icon.visible = false;
                    player2Score.visible = false;
                    player2Life.visible = false;
                    break;
                case 1:
                    player2Icon.visible = false;
                    player2Life.visible = false;
                    player2Score.visible = false;

                    player1Icon.visible = true;
                    player1Life.visible = true;
                    player1Score.visible = true;
                    player1Score.text = Player(model.playersInGame[0]).score.toString();
                    break;
                case 2:
                    player1Icon.visible = true;
                    player1Life.visible = true;
                    player1Score.visible = true;
                    player1Score.text = Player(model.playersInGame[0]).score.toString();

                    player2Icon.visible = true;
                    player2Life.visible = true;
                    player2Score.visible = true;
                    player2Score.text = Player(model.playersInGame[1]).score.toString();
                    break
            }
            timeDisplay.text = model.time;
        }

        private function updateLayout():void {
            logo.x = 50;
            logo.y = 2;

            timeBG.x = 525;
            timeBG.y = 10;
            timeDisplay.x = 590;
            timeDisplay.y = 15;

            player1Icon.x = 750;
            player1Icon.y = 10;

            player1Score.width = 300;
            player1Score.x = 890;
            player1Score.y = 7;

            player1Life.x = 750;
            player1Life.y = 40;

            player2Icon.x = 1000;
            player2Icon.y = 10;

            player2Score.width = 300;
            player2Score.x = 1145;
            player2Score.y = 7;

            player2Life.x = 1000;
            player2Life.y = 40;
        }
    }
}
