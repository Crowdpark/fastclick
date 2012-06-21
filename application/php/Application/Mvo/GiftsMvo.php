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

        if (is_null($giftData))
            return $this->setGift($gifts);
        else {
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

        return $gifts["gifts"];

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
