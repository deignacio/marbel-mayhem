package com.litl.marbelmayhem.views
{
    import com.litl.marbelmayhem.events.MarbleEvent;

    public class PlayerOneLife extends PlayerLife
    {

        public function PlayerOneLife() {
            super();
        }

        override protected function init():void {
            playerIconURL = "../assets/scoreboard/playerOneLife.png";
            //player = model.player1;
            createChildren();
        }

    }
}
