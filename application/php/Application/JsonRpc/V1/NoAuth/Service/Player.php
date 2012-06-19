<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/8/12
 * Time: 9:22 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\JsonRpc\V1\NoAuth\Service;
class Player extends \Application\Core\Abstracts\AbstractService
{

    /**
     * @param array $params
     * @return array
     */
    public function getAppFriends(array $params)
    {
        $manager = new \Application\Manager\Player\PlayerManager();
        $return = $manager->getAppFriends($params["friendsList"]);

        return $return;
    }

    /**
     * @param array $params
     * @return int
     */

    public function updateUser(array $params)
    {
        $manager = new \Application\Manager\Player\PlayerManager();

        $manager->setLevel($params["currentLevel"]);
        $mvo = $manager->setScore($params["curretScore"]);

        return $mvo->saveInMem();

    }

    /**
     * @return array
     */

    public function getScores()
    {
        $mvo = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo();

        $scoreHistory = get_object_vars(($mvo->getScores()));
        arsort($scoreHistory, SORT_NUMERIC);

        return $scoreHistory;
    }

}
