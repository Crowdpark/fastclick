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
        $recipients = array_keys($giftData["recipient_list"]);

        foreach ($recipients as $recipient) {
            $gift = array();
            $gift["request"] = $giftData["recipient_list"][$recipient]["request"];
            $gift["amount"] = $giftData["recipient_list"][$recipient]["amount"];
            $gift["type"] = $giftData["recipient_list"][$recipient]["type"];
            $gift["sender_id"] = $this->getApplicationContext()->getUserBo()->getFacebookUserId();

            $giftsMvo = new \Application\Mvo\GiftsMvo();
            $giftsMvo->setId($recipient);
            $giftsMvo->setMemId($recipient)->addGift($gift)->saveInMem();

        }

    }

    public function acceptGift(array $gift)
    {
        $giftsMvo = new \Application\Mvo\GiftsMvo();

        if (!$giftsMvo->removeGift($gift))
            $giftsMvo->deleteFromMem();
        else
            return $giftsMvo->saveInMem();
    }

}
