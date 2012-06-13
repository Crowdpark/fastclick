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
     * @return array
     */
    public function getAppFriends()
    {
        $friendsIdList = $this->getProcessusContext()->getFacebookClient()->getFriendsIdList();
        if (count($friendsIdList) <= 0) {
            return FALSE;
        }
        $connector = $this->getProcessusContext()->getDefaultCache();

        $mvoFriendsList = array();
        $friendsKeys = $this->array_prefixing("FacebookUserMvo_", $friendsIdList);
        $appUsers = array_filter($connector->getMultipleByKey($friendsKeys));

        // get friends from membase || or add them
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
//        $isInMySql = $this->_isInMySqlTable();
//
//        if (count($isInMySql) == 1)
//        {
//            return TRUE;
//        }

        $fbUserId = $this->getFacebookUserId();

        if ($fbUserId > 0)
        {

            $mvo      = $this->getFacebookUserMvo();
            $userData = $mvo->getData();

            $fbClient          = $this->getProcessusContext()->getFacebookClient();
            $fbData            = $fbClient->getUserDataById($fbUserId);
            $fbData['created'] = convertUnixTimeToIso(time());

            $resultCode = $mvo->setData($fbData)->saveInMem();
//            $this->getUserManager()->insertNewUser($mvo);

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
