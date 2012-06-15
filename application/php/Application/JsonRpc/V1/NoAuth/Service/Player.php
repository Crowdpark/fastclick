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

        return $manager->getAppFriends($params["friendsList"]);

    }

    /**
     * @param array $params
     * @return array|mixed
     */
    public function updateUser(array $params)
    {
        $manager = new \Application\Manager\Player\PlayerManager();

        $manager->setLevel($params["currentLevel"]);
        $mvo = $manager->setScore($params["currentScore"]);
        $mvo->saveInMem();

        $scoreHistory = get_object_vars(($mvo->getScores()));
        arsort($scoreHistory, SORT_NUMERIC);
        return $scoreHistory;
    }

}
