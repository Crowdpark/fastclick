<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/12/12
 * Time: 5:51 PM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Bo;
class UserBo extends \Processus\Lib\Bo\UserBo
{


    /**
     * @var \Application\Mvo\FacebookUserMvo
     */
    private $_userMvo;

    /**
     * @return \Application\Mvo\FacebookUserMvo
     */
    public function getFacebookUserMvo()
    {
        if (!$this->_userMvo) {
            $this->_userMvo = new \Application\Mvo\FacebookUserMvo();
            $this->_userMvo->setMemId($this->getFacebookUserId());
            $this->_userMvo->getFromMem();
        }

        return $this->_userMvo;
    }

    /**
     * @return array
     */
    public function getAppFriends()
    {
        $connector = $this->getProcessusContext()->getDefaultCache();
        $friendsIdList = $this->getApplicationContext()->getFacebookClient()->getFriendsIdList();

        if (count($friendsIdList) <= 0) {
            return FALSE;
        }

        $mvoFriendsList = array();
        $friendsKeys = $this->array_prefixing("FacebookUserMvo_", $friendsIdList);
        $appUsers = array_filter($connector->getMultipleByKey($friendsKeys));

        foreach ($appUsers as $item)
        {
            $mvo = new \Processus\Lib\Mvo\FacebookUserMvo();
            $mvo->setData($item);

            $mvoFriendsList[] = $mvo;
        }

        return $mvoFriendsList;
    }
    /**
     * @return bool|string
     */
    public function isAuthorized()
    {

        $fbUserId = $this->getFacebookUserId();

        if ($fbUserId > 0)
        {

            $mvo      = $this->getFacebookUserMvo();
            $userData = $mvo->getData();
            $fbClient          = $this->getProcessusContext()->getFacebookClient();
            $fbData            = $fbClient->getUserDataById($fbUserId);

            if (is_null($userData)) {
                $score = 0;
                $level = 1;
            } else {
                $score = $mvo->getHighScore();
                $level = $mvo->getLevel();
            }

            $fbData['created'] = convertUnixTimeToIso(time());
            $fbData['high_score'] = $score;
            $fbData['level'] = $level;

            $resultCode = $mvo->setData($fbData)->saveInMem();

            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }

    private function array_prefixing(string $prefix, array $idList)
    {
        $prefixList = array();
        foreach ($idList as $idItem)
        {
            $prefixList[] = $prefix . $idItem;
        }
        return $prefixList;
    }
}
