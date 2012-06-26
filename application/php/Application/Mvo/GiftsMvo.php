<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/21/12
 * Time: 4:47 PM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Mvo;
class GiftsMvo extends \Processus\Abstracts\Vo\AbstractMVO
{

    function __construct()
    {
        if (is_null($this->getMemId()))
            $this->setMemId($this->getApplicationContext()->getUserBo()->getFacebookUserId());
    }

    public function setId($id)
    {
        return $this->setValueByKey($id, "id");
    }
    /**
     * @param array $giftData
     * @return \Application\Mvo\GiftsMvo|\Processus\Abstracts\Vo\AbstractVO
     */
    public function addGift(array $giftData)
    {
        $gifts = $this->getGifts();

        if (is_null($gifts))
            return $this->setGift(array($giftData));
        else {

            if (sizeof($gifts) == 1) {
                foreach($gifts as $gift) {
                    $gifts = array(get_object_vars($gift));
                    break;
                }
            }

            $gifts[] = $giftData;

            return $this->setGift($gifts);
        }

    }

    /**
     * @param array $giftData
     * @return \Application\Mvo\GiftsMvo|\Processus\Abstracts\Vo\AbstractVO
     */
    public function setGift(array $giftData)
    {

        return $this->setValueByKey("gifts", $giftData);
    }

    /**
     * @return array|mixed
     */
    public function getGifts()
    {
        $connector = $this->getApplicationContext()->getDefaultCache();

        $gifts = get_object_vars(json_decode($connector->fetch($this->getMemId())));

        $return = array();
        foreach ($gifts["gifts"] as $gift)
        {
            $return[] = $gift;
        }

        return $return;
    }

    /**
     * @param string $mId
     * @return \Processus\Abstracts\Vo\AbstractMVO
     */
    public function setMemId(\string $mId)
    {
        $prefix = "UserGifts_";
        return parent::setMemId($prefix.$mId);
    }
}
