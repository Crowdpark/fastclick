<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/29/12
 * Time: 12:23 PM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Mvo;
class UserFacebookFriendsMvo extends \Processus\Abstracts\Vo\AbstractMVO
{

    function __construct()
    {
        if (is_null($this->getMemId()))
            $this->setMemId($this->getApplicationContext()->getUserBo()->getFacebookUserId());
    }

    /**
     * @param array $friends
     * @return \Processus\Abstracts\Vo\AbstractVO
     */
    public function setFriends(array $friends)
    {
        return $this->setValueByKey("friends", $friends);
    }

    /**
     * @return array|mixed
     */
    public function getFriends()
    {
        return $this->getValueByKey("friends");
    }

    /**
     * @param string $mId
     * @return \Processus\Abstracts\Vo\AbstractMVO
     */
    public function setMemId(\string $mId)
    {
        $prefix = "UserFacebookFriends_";
        return parent::setMemId($prefix.$mId);
    }
}
