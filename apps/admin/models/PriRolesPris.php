<?php

namespace apps\admin\models;

!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use Phalcon\Mvc\Model\Behavior\SoftDelete;
use enums\SystemEnums;

class PriRolesPris extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $addtime;

    /**
     *
     * @var integer
     */
    public $delsign;

    /**
     *
     * @var integer
     */
    public $roleid;

    /**
     *
     * @var integer
     */
    public $priid;

    public function initialize()
    {
        $this->useDynamicUpdate( true );

        $this->belongsTo( 'roleid', 'apps\admin\models\PriRoles', 'id', array( 'alias' => 'priRoles' ) );
        $this->belongsTo( 'priid', 'apps\admin\models\PriPris', 'id', array( 'alias' => 'priPris' ) );
        $this->setSource( $this->di[ 'config' ][ 'database' ][ 'prefix' ] . $this->getSource() );
    }

    /**
     * 添加多个角色权限项
     * @param type $roleId
     * @param type $pri
     * @return type
     */
    public function addData( $roleId, $pri )
    {
        $addtime = date( 'Y-m-d H:i:s' );
        $query = $this->modelsManager->createQuery( "insert into apps\admin\models\PriRolesPris (roleid, addtime, delsign, priid) values ('$roleId', '$addtime', 0, :priid:)" );
        foreach( $pri as $id )
        {
            if( !empty( $id ) ) $status = $query->execute( [ 'priid' => $id ] )->success();
        }
        return $status;
    }

}
