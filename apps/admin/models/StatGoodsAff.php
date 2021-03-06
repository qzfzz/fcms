<?php

namespace apps\admin\models;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Behavior\SoftDelete;
use enums\SystemEnums;

/**
 * 商品附属信息  - 总浏览量 /总收藏量  /总好评率
 * @author Carey
 *
 */
class StatGoodsAff extends Model{
	
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
	 * @var int
	 */
	public $unit;
	
	/**
	 * @var string
	 */
	public $p_time;
	
	/**
	 * @var int
	 * @return multitype:string
	 */
	public $glance;
	
	/**
	 * @var int
	 * @return multitype:string
	 */
	public $collect;
	
	/**
	 * @var int
	 * @return multitype:string
	 */
	public $favourite;
	
	
	public function columnMap()
	{
		return array(
				'id'          => 'id',
				'addtime'     => 'addtime',
				'uptime'      => 'uptime',
				'delsign'     => 'delsign',
				'descr'       => 'descr',
				'unit' 		  => 'unit',
				'p_time'      => 'p_time',
				'glance'	  => 'glance',
				'collect'	  => 'collect',
				'favourite'   => 'favourite',
		);
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate( true );
		
		$this->addBehavior( new SoftDelete( array(
            'field' => 'delsign',
            'value' => SystemEnums::DELSIGN_YES,
        ) ) );
		
		$this->setSource( 'stat_goods_others' );
	}
}

?>