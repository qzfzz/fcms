<?php

namespace apps\admin\controllers;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use enums\SystemEnums;
use libraries\TimeUtils;
use apps\admin\models\Sensitive;
use Phalcon\Paginator\Adapter\QueryBuilder;

class SensitiveController extends AdminBaseController{
	
	public function initialize()
	{
		parent::initialize();
	}
	
	/**
	 * @author( author='Carey' )
	 * @date( date = '2015.10.14' )
	 * @comment( comment = '敏感词列表' )
	 * @method( method = 'indexAction' )
	 * @op( op = 'r' )
	 */
	public function indexAction()
	{
		$pageNum = $this->request->getQuery( 'page', 'int' );
		$currentPage = $pageNum ? $pageNum : 1;
	
		$builder = $this->modelsManager->createBuilder()
						->from( 'apps\admin\models\Sensitive' )
						->where( 'delsign=' . SystemEnums::DELSIGN_NO . ' ORDER BY id DESC' );
		 
		$paginator = new  QueryBuilder( array(
				'builder' => $builder,
				'limit' => 10,
				'page' => $currentPage
		));
		$page = $paginator->getPaginate();
			
		$this->view->page = $page;
		$this->view->default = $this->config[ 'sensitive_default_replace' ];
		
	}
	
	/**
	 * @author( author='Carey' )
	 * @date( date = '2015.10.14' )
	 * @comment( comment = '添加敏感词' )
	 * @method( method = 'addAction' )
	 * @op( op = 'r' )
	 */
	public function addAction()
	{
		
	}
	
	/**
	 * @author( author='Carey' )
	 * @date( date = '2015.10.14' )
	 * @comment( comment = '保存敏感词' )
	 * @method( method = 'addAction' )
	 * @op( op = 'r' )
	 */
	public function saveAction()
	{
		$loginInfo = $this->session->get( 'userInfo' );
		$key = $this->request->getPost( 'key' );
		$arrKeys = explode( "\n", $key );
		if( count( $arrKeys ) > 0 )
		{
			foreach( $arrKeys as $val )
			{
				$sens = new Sensitive();
				$sens->delsign = SystemEnums::DELSIGN_NO;
				$sens->addtime = $sens->uptime = TimeUtils::getFullTime();
				$sens->word	   = $val;
				$sens->uid	   = $loginInfo[ 'id' ];
				$sens->save();			
			}
		}
		
		$this->response->redirect( '/admin/sensitive/index' );
	}
	
	
	/**
	 * @author( author='Carey' )
	 * @date( date = '2015.10.14' )
	 * @comment( comment = '删除敏感词' )
	 * @method( method = 'deleteAction' )
	 * @op( op = 'r' )
	 */
	public function deleteAction()
	{
		$objRet = new \stdClass();
		
		$optid = $this->dispatcher->getParam( 'id' );
		if( false == $optid )
		{
			//获取参数出错,请刷新后再试
			$ret = 1;
			echo json_encode( $objRet );
			exit;
		}
		
		$where = array(
			'conditions' => 'delsign=:del: and id=:optid:',
			'bind'		 => array( 'del' => SystemEnums::DELSIGN_NO, 'optid' => $optid ),
		);
		$sens = Sensitive::findFirst( $where );
		if( count( $sens ) > 0 )
		{
			//删除成功
			$sens->delete();
			$ret = 0;
		}
		else//删除失败,未找到该条信息
			$ret = 2;
		
		echo $ret;
	 }
	 
	 /**
	 * @author( author='Carey' )
	 * @date( date = '2015.10.15' )
	 * @comment( comment = '设置敏感词替换词' )
	 * @method( method = 'replaceAction' )
	 * @op( op = 'u' )
	 */
	 public function replaceAction()
	 {
	 	$objRet = new \stdClass();
	 	
	 	$optid  = $this->dispatcher->getParam( 'id' );
	 	$reword = urldecode( $this->dispatcher->getParam( 'strreplace' ) );
	 	
	 	if( false == $optid || false == $reword )
	 	{
	 		$objRet->state = 1;
	 		$objRet->msg = '对不起,参数设置错误,请稍后重试.';
	 		echo json_encode( $objRet );
	 		
	 		exit;
	 	}
	 	
	 	$where = array(
	 		'conditions'	=> 'delsign=:del: and id=:optid:',
	 		'bind'			=> array( 'del' => SystemEnums::DELSIGN_NO , 'optid' => $optid ),
	 	);
	 	$res = Sensitive::findFirst( $where );
	 	if( count( $res ) > 0 )
	 	{
	 		$res->rword = $reword;
			$res->save();

			$objRet->state = 0;
			$objRet->rword = $reword;
			$objRet->msg = '设置成功.';
	 	}
	 	else 
	 	{
	 		$objRet->state = 1;
	 		$objRet->msg = '信息为找到,设置失败.';
	 	}
	 	
	 	echo json_encode( $objRet );
	 }
}

?>