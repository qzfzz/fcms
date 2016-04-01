<?php
namespace apps\admin\controllers;

!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use enums\SystemEnums;
use apps\admin\models\FriendLinks;
use libraries\TimeUtils;
use Phalcon\Paginator\Adapter\QueryBuilder;

/**
 * 友情链接管理
 * @author Carey
 * time 2015/10/22
 */
class FriendlinkController extends AdminBaseController{
	
	public function initialize()
	{
		parent::initialize();
	}
	
	/**
	 * @author( author='Carey' )
	 * @date( date = '2015-10-22' )
	 * @comment( comment = '友情链接首页' )
	 * @method( method = 'indexAction' )
	 * @op( op = 'r' )
	 */
	public function indexAction()
	{
		$pageNum = $this->request->getQuery( 'page', 'int' );
		$currentPage = $pageNum ? $pageNum : 1;
		
		$builder = $this->modelsManager->createBuilder()
				->columns( 'id,delsign,addtime,uptime,name,title,nofollow,urltype,url' )
				->from( 'apps\admin\models\FriendLinks' )
				->where( 'delsign='.SystemEnums::DELSIGN_NO . ' ORDER BY sort,uptime DESC ' );
		 
		$paginator = new  QueryBuilder( array(
				'builder' => $builder,
				'limit' => 10,
				'page' => $currentPage
		));
		$page = $paginator->getPaginate();
		
		$this->view->page = $page;
	}
	
	/**
	 * @author( author='Carey' )
	 * @date( date = '2015-10-22' )
	 * @comment( comment = '添加友情链接' )
	 * @method( method = 'addAction' )
	 * @op( op = 'r' )
	 */
	public function addAction()
	{
		
	}
	
	/**
	 * @author( author='Carey' )
	 * @date( date = '2015-10-22' )
	 * @comment( comment = '更新友情链接' )
	 * @method( method = 'updateAction' )
	 * @op( op = 'r' )
	 */
	public function updateAction()
	{
		$optid = $this->dispatcher->getParam( 'id' );
		if( false == $optid )
		{
			$this->response->redirect( '/admin/friendlink/index' );
			exit;
		}
		
		$where = array(
			'column'	=> 'id,delsign,addtime,uptime,name,title,nofollow,urltype,url',
			'conditions'=> 'delsign=:del: and id=:optid:',
			'bind'		=> array( 'del'=> SystemEnums::DELSIGN_NO, 'optid' => $optid ),
		);
		$friends = FriendLinks::findFirst( $where );
		if( count( $friends ) > 0 && false != $friends )
		{
			$this->view->setVar( 'res' , $friends );
			$this->view->pick( 'friendlink/add' );
		}
		else
			$this->response->redirect( '/admin/friendlink/add' );
		
	}
	
	/**
	 * @author( author='Carey' )
	 * @date( date = '2015-10-22' )
	 * @comment( comment = '保存友情链接' )
	 * @method( method = 'saveAction' )
	 * @op( op = 'r' )
	 */
	public function saveAction()
	{
		$this->csrfCheck();
		
		$formData = $this->request->getPost( 'form' );
		if( false != $formData && !empty( $formData ) )
		{
			if( false != $formData[ 'id' ] )
			{
				$where = array(
						'column'	=> 'id,delsign,addtime,uptime,name,title,nofollow,urltype,url,icon',
						'conditions'=> 'delsign=:del: and id=:optid:',
						'bind'		=> array( 'del'=> SystemEnums::DELSIGN_NO, 'optid' => $formData['id'] ),
				);
				$flinks = FriendLinks::findFirst( $where );
				if( count( $flinks ) > 0 && false != $flinks )
				{
					$formData[ 'title' ]?$formData[ 'title' ]:$formData[ 'name' ];
					$formData[ 'uptime' ] = TimeUtils::getFullTime();
					if( !isset( $formData[ 'title' ] ) || false == $formData[ 'title' ] )
						$formData[ 'title' ] = $formData[ 'name' ];
					
					if( $flinks->save( $formData ) )
						$this->response->redirect( '/admin/friendlink/index' );
					else
						$this->response->redirect( '/admin/friendlink/update/id/' . $formData['id']  );
				}
				else
					$this->response->redirect( '/admin/friendlink/add' );
			}
			else
			{
				$formData[ 'addtime' ] = $formData[ 'uptime' ] = TimeUtils::getFullTime();
				$formData[ 'delsign' ] = SystemEnums::DELSIGN_NO;
				if( !isset( $formData[ 'title' ] ) || false == $formData[ 'title' ] )
					$formData[ 'title' ] = $formData[ 'name' ];
				
				$flink = new FriendLinks();
				if( $flink->save( $formData ) )
					$this->response->redirect( '/admin/friendlink/index' );
				else
					$this->response->redirect( '/admin/friendlink/add' );
			}
		}
		else
			$this->response->redirect( '/admin/friendlink/index' );
	}
	
	/**
	 * @author( author='Carey' )
	 * @date( date = '2015-10-22' )
	 * @comment( comment = '删除友情链接' )
	 * @method( method = 'deleteAction' )
	 * @op( op = 'r' )
	 */
	public function deleteAction()
	{
	    $this->csrfCheck(); //csrf检验
	    
		$objRet = new \stdClass();
		$optid  = $this->request->getPost( 'id' );
		
		if( false == $optid )
		{
			$objRet->state = 1;
			$objRet->msg   = '参数设置错误,请稍后重试.';
			echo json_encode( $objRet );
			exit;
		}
		
		$where = array(
				'conditions' => 'delsign=:del: and id=:optid:',
				'bind'		 => array( 'del'=> SystemEnums::DELSIGN_NO, 'optid' => $optid ),
		);
		$flinks = FriendLinks::findFirst( $where );
		if( count( $flinks ) > 0 && false != $flinks )
		{
			$flinks->delete();
			$objRet->state = 0;
			$objRet->msg  = '操作成功';
			$objRet->optid = $optid;
		}
		else
		{
			$objRet->state = 1;
			$objRet->msg = '数据不存在,请刷新后再试';
		}
		
		$objRet->key = $this->security->getTokenKey();
		$objRet->token = $this->security->getToken();
		
		echo json_encode( $objRet );
	}
	
}

?>