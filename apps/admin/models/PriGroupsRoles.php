<?php

namespace apps\admin\models;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use Phalcon\Mvc\Model\Behavior\SoftDelete;
use enums\SystemEnums;

class PriGroupsRoles extends \Phalcon\Mvc\Model
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
    public $groupid;
    
 
    public function  initialize()
    {
        $this->useDynamicUpdate( true );
        $this->belongsTo( 'groupid', 'apps\admin\models\PriGroups', 'id', array( 'alias' => 'priGroups' ));
        $this->belongsTo( 'roleid', 'apps\admin\models\PriRoles', 'id', array( 'alias' => 'priRoles') );
        $this->setSource( $this->di[ 'config' ][ 'database'][ 'prefix'] . $this->getSource() );
    }

}
