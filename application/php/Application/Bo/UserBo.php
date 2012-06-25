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

        $friendsKeys = $this->_array_prefixing("FacebookUserMvo_", $friendsIdList);
        $appUsers = array_filter($connector->getMultipleByKey($friendsKeys));

        $playerDataKeys = $this->_array_prefixing("PlayerData_", $friendsIdList);
        $playerData = array_filter($connector->getMultipleByKey($playerDataKeys));

        $return["userMvos"] = $appUsers;
        $return["playerDataMvos"] = $playerData;

        return $return;
    }

    private $_facebookUserId;

    /**
     * @param $id
     */
    public function setFacebookUserId($id)
    {
        $this->_facebookUserId = $id;
    }

    /**
     * @return string
     */
    public function getFacebookUserId()
    {
        if (!is_null($this->_facebookUserId) && ($this->_facebookUserId != "null"))
            return $this->_facebookUserId;
        else {
            $this->setFacebookUserId(parent::getFacebookUserId());

            return $this->getFacebookUserId();
        }
    }
    /**
     * @return bool|string
     */
    public function isAuthorized()
    {

        $fbUserId = $this->getFacebookUserId();

        if (is_null($fbUserId)) {
            $fbUserId = $this->getFacebookUserId();
            $this->setFacebookUserId($fbUserId);
        }

        if ($fbUserId > 0) {

            $mvo      = $this->getFacebookUserMvo();
            $playerDataMvo = $this->getApplicationContext()->getPlayerDataMvo();

            if ($mvo->isFirstTime()) {
                $mvo->setFirstTime(FALSE);
                $score = 0;
                $level = 1;
                $data = $this->_getFbData($fbUserId, $mvo->isFirstTime());
                $mvo->setData($data)->saveInMem();
                $playerDataMvo->setHighScore($score)->addScore($score, $level)->setLevel($level)->saveInMem();

            }

            else {
                $userData = $mvo->getData();
                $data = get_object_vars($userData);
                $data['created'] = convertUnixTimeToIso(time());

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

    private function _getFbData($fbUserId, $firstTime)
    {

        $fbClient          = $this->getProcessusContext()->getFacebookClient();
        $fbData            = $fbClient->getUserDataById($fbUserId);

        $fbData['created'] = convertUnixTimeToIso(time());
        $fbData['firstTime'] = $firstTime;

        return $fbData;
    }
}
