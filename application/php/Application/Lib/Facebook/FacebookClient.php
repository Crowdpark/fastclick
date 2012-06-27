<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/14/12
 * Time: 11:05 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Lib\Facebook;
class FacebookClient extends \Processus\Lib\Facebook\FacebookClient
{

    /**
     * @param null $userFbId
     * @param array|null $friendsArray
     * @return mixed
     */

    public function getUserFriends($userFbId = null)
    {
        $defaultCache    = $this->getProcessusContext()->getDefaultCache();
        $fbNum           = (int)$userFbId > 0 ? $userFbId : $this->getUserId();

        $memKey          = "FacebookClient_getUserFriends_" . $fbNum;
        $facebookFriends = $defaultCache->fetch($memKey);

        if (!$facebookFriends && is_null($userFbId)) {
            $rawData         = $this->getFacebookSdk()->api("/me/friends");
            $facebookFriends = $rawData['data'];

            $defaultCache->insert($memKey, $facebookFriends, 60 * 60 * 3);
        }

        return $facebookFriends;
    }

}
