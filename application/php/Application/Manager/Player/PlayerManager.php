<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/8/12
 * Time: 9:31 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Manager\Player;

class PlayerManager extends \Processus\Abstracts\Manager\AbstractManager
{

    public function __call($method, $args)
    {
        if (method_exists($this, $method)) {
            return $this->$method($args);
        } else {
            throw new \Exception("PlayerManager doesn't have a function called $method");
        }
    }

    /**
     * @desc Get user friends list from cache
     *
     * @return \array
     */
    public function getFriendsList()
    {
        $fb_id = $this->getProcessusContext()->getUserBo()->getFacebookUserId();
        $friendsListKey = "user_".$fb_id."_friends_list";
        $friendsListValue = $this->getProcessusContext()->getDefaultCache()->fetch($friendsListKey);

        return $friendsListValue;
    }

    /**
     * @desc Set user friends list cache
     *
     * @param $friendsList
     *
     * @return UserCacheManager
     */
    public function setFriendsList($friendsList)
    {
        $fb_id = $this->getApplicationContext()->getUserBo()->getFacebookUserId();
        $friendsListKey = "user_".$fb_id."_friends_list";
        $this->getProcessusContext()->getDefaultCache()->insert($friendsListKey, ($friendsList), 120);
        return $this;
    }

    /**
     * @return array
     */
    public function getAppFriends()
    {
        $friends = $this->getApplicationContext()->getUserBo()->getAppFriends();
        return $friends;
    }

    /**
     * @param array $params
     * @return string
     */
    public function saveGame(array $params)
    {
        $key = "";
//        $this->getProcessusContext()->getDefaultCache()->insert($friendsListKey, $friendsList, 120);
//        return $this->insert($this->ccFactory()
//                ->setSqlTableName("games")
//                ->setSqlParams($params)
//        )->getAdapter()->lastInsertId();
    }
    /**
     * @param array $experience
     * @return \Zend\Db\Statement\Pdo
     */

    public function updateExperience(array $experience)
    {
        //$facebookId = $this->getApplicationContext()->getUserBo()->getFacebookUserId();
        return $this->update($this->ccFactory()
            ->setSqlTableName("users")
            ->setSqlParams($experience)
            ->setSqlUpdateConditions(array("fb_id" => 777)));
    }

    /**
     * @return mixed|null
     */

    public function getExperience()
    {
        //TODO: Get facebook user from context.
        return $this->fetchOne($this->
            ccFactory()->
            setSqlStmt("SELECT experience FROM users"));
    }

}
