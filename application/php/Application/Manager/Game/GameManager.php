<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/8/12
 * Time: 10:33 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Manager\Game;

class GameManager extends \Processus\Abstracts\Manager\AbstractManager
{

    /**
     * @return mixed|null
     */

    public function getCircleConfig()
    {
        return $this->fetchAll($this->
            ccFactory()->
            setSqlStmt("SELECT * FROM circles")->
            setExpiredTime(260)->
            setMemId("circle_config"));
    }

    public function getGameDuration()
    {
        //TODO: Get facebook user from context.
        return $this->fetchOne($this->ccFactory()
        ->setSqlStmt("SELECT duration FROM levels WHERE id = :id")->setSqlParams(array("id" => 2))
            ->setExpiredTime(400));
    }

}
