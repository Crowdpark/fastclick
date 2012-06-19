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

    private function _getIdFromItem($item)
    {
        return $item["id"];
    }
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
    public function getAppFriends(array $friendsRawList)
    {
        $connector = $this->getProcessusContext()->getDefaultCache();

        $friendsIdList = array_map(array($this, "_getIdFromItem"), $friendsRawList);
        if (count($friendsIdList) <= 0) {
            return FALSE;
        }

        $mvoFriendsList = array();
        $friendsKeys = $this->_array_prefixing("FacebookUserMvo_", $friendsIdList);
        $appUsers = array_filter($connector->getMultipleByKey($friendsKeys));

        foreach ($appUsers as $item) {
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

        if ($fbUserId > 0) {

            $mvo      = $this->getFacebookUserMvo();

            if ($mvo->isFirstTime()) {
                $mvo->setFirstTime(FALSE);
                $score = 0;
                $level = 1;
                $data = $this->_getFbData($fbUserId, $score, $level, $mvo->isFirstTime());
                $mvo->setData($data)->saveInMem();
            }

            else {
                $userData = $mvo->getData();
                $score = $mvo->getHighScore();
                $level = $mvo->getLevel();
                $data = get_object_vars($userData);
                $data['created'] = convertUnixTimeToIso(time());
                $data['high_score'] = $score;
                $data['level'] = $level;

                $updated = $mvo->getValueByKey("updated");

                $updated = (is_null($updated)) ? strtotime($mvo->getCreated()) : $updated;

                if (!$updated)
                    $resultCode = $mvo->setData($data)->saveInMem();
                else
                    $this->_updateUserCache($mvo, $updated, $data);
            }

            return TRUE;
        }
        else {
            return FALSE;
        }
    }

    /**
     * @param AbstractMVO $mvo
     * @param int $updated the last updated or created value for the player.
     * @param array $fbData
     * @return int
     */
    private function _updateUserCache(\Processus\Abstracts\Vo\AbstractMVO $mvo, \int $updated, array $fbData)
    {
        $twoWeeksAgo = strtotime('-2 weeks');
        if ($updated < $twoWeeksAgo)
            return $mvo->setData($fbData)->saveInMem();

        return 1;
    }

    /**
     * @param string $prefix
     * @param array $idList
     * @return array
     */
    private function _array_prefixing(string $prefix, array $idList)
    {
        $prefixList = array();
        foreach ($idList as $idItem) {
            $prefixList[] = $prefix . $idItem;
        }
        return $prefixList;
    }

    /**
     * @param $fbUserId
     * @param $score
     * @param $level
     * @param $firstTime
     * @return array|mixed
     */

    private function _getFbData($fbUserId, $score, $level, $firstTime)
    {

        $fbClient          = $this->getProcessusContext()->getFacebookClient();
        $fbData            = $fbClient->getUserDataById($fbUserId);

        $fbData['created'] = convertUnixTimeToIso(time());
        $fbData['high_score'] = $score;
        $fbData['level'] = $level;
        $fbData['firstTime'] = $firstTime;

        return $fbData;
    }
}
