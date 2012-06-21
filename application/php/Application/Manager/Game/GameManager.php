<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/8/12
 * Time: 10:33 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Manager\Game;

class GameManager extends \Processus\Abstracts\Manager\AbstractManager
{

    public function getGifts()
    {
        $giftsMvo = new \Application\Mvo\GiftsMvo();
        $giftsMvo->setMemId($this->getApplicationContext()->getUserBo()->getFacebookUserId());
        return $giftsMvo->getGifts();
    }

    public function sendGift(array $giftData)
    {
        $id = $giftData["id"];
        unset($giftData["id"]);
        $giftsMvo = new \Application\Mvo\GiftsMvo();
        $giftsMvo->setId($id);
        return $giftsMvo->setMemId($id)->addGift($giftData)->saveInMem();
    }

}
