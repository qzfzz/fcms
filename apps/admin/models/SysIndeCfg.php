<?php

namespace apps\admin\models;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use Phalcon\Mvc\Model;
/**
 * 系统后台主页配置项
 * @author Carey
 */
class SysIndeCfg extends Model{
	
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
	 * @var string
	 */
	public $uptime;
	
	/**
	 *
	 * @var integer
	 */
	public $delsign;
	
	/**
	 *
	 * @var string
	 */
	public $descr;
	
	/**
	 * @var string
	 */
	public $name;
	
	/**
	 * @var string
	 */
	public $icon;
	
	/**
	 * @var color
	 */
	public $color;
	
	/**
	 * @var int
	 */
	public $line;
	
	/**
	 * @var int
	 */
	public $size;
	
	/**
	 * @var int
	 */
	public $display;
	
	/**
	 * @var int
	 */
	public $groupid;
	/**
	 * @var int
	 */
	public $sort;
	
	public function columnMap()
	{
		return array(
			'id'        => 'id',
			'addtime'   => 'addtime',
			'uptime'    => 'uptime',
			'delsign'   => 'delsign',
			'descr'     => 'descr',
			'name'      => 'name',
			'icon'		=> 'icon',
			'color'		=> 'color',
			'line'		=> 'line',
			'size'		=> 'size',
			'display'	=> 'display',
			'groupid'	=> 'groupid',
			'sort'		=> 'sort',
		);
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate( TRUE );
		
		$this->belongsTo( 'groupid' , 'apps\admin\models\PriGroups' , 'id' , array( 'alias' => 'prigroups' ) );
		$this->setSource( $this->di[ 'config' ][ 'database'][ 'prefix'] . 'sys_index_cfg' );
	}
	
}

?>