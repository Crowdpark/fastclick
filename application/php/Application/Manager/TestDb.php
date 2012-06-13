<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/6/12
 * Time: 4:31 PM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Manager;
class TestDb extends \Processus\Abstracts\Manager\AbstractManager
{

    public function storeInCB(array $params)
    {

    }
    /**
     * @param $values
     * @return string
     */
    public function storeDataInDatabase(array $values)
    {
        return $this->insert($this->ccFactory()
            ->setSqlTableName("helloworld")
            ->setSqlParams($values)
        )->getAdapter()->lastInsertId();

    }

    /**
     * @return mixed|null
     */
    public function getStoredData()
    {
        return $this->fetchAll($this->
            ccFactory()->
            setSqlStmt("SELECT * FROM helloworld")->
            setExpiredTime(60)->
            setMemId("Hello_New_Cache"));
    }

    /**
     * @param $id
     * @param $values
     * @return \Zend\Db\Statement\Pdo
     */

    public function updateRowInDb(\int $id, array $values)
    {

        return $this->update($this->ccFactory()
                    ->setSqlTableName("helloworld")
                    ->setSqlParams($values)
                    ->setSqlUpdateConditions(array("id" => $id))
        );
    }

    public function getDataFromTable(\string $tableName, array $tableColumns, array $params = NULL)
    {
        $query = "SELECT %s FROM %s";


        $columns = implode(",", $tableColumns);

        $where = array();

        if (!is_null($params)) {

            foreach ($params as $whereColumn => $whereValue) {
                $where[$whereColumn] = "$whereColumn = $whereValue";
            }

            $where = implode(" AND ", $where);

            $query .= " WHERE %s";

        }

        $query = sprintf($query, $columns, $tableName, $where);

        echo "\n[QUERY] $query [/QUERY]\n";
        return $this->fetchAll($this->ccFactory()
            ->setSqlStmt($query)
            ->setExpiredTime(160)->setMemId("color_config"));
    }
}
