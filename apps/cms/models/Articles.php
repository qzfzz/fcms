<?php

namespace apps\cms\models;

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Resultset\Simple as Resultset;

!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

/**
 * 文章表模型
 * @author Carey
 *
 */
class Articles extends Model
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
     *
     * @var string
     */
    public $title;

    /**
     *
     * @var string
     */
    public $description;

    /**
     *
     * @var integer
     */
    public $cat_id;

    /**
     *
     * @var string
     */
    public $content;

    /**
     *
     * @var integer
     */
    public $status;

    /**
     *
     * @var string
     */
    public $begin_time;

    /**
     *
     * @var string
     */
    public $end_time;

    /**
     *
     * @var integer
     */
    public $top;

    /**
     *
     * @var string
     */
    public $author;

    /**
     *
     * @var string
     */
    public $keywords;
    
    /**
     * @var string
     */
    public $face;
    
    /**
     * @var string
     */
    public $pubtime;
    

    /**
     * Independent Column Mapping.
     * Keys are the real names in the table and the values their names in the application
     *
     * @return array
     */
    public function columnMap()
    {
        return array(
            'id'          => 'id',
            'addtime'     => 'addtime',
            'uptime'      => 'uptime',
            'delsign'     => 'delsign',
            'descr'       => 'descr',
            'title'       => 'title',
            'description' => 'description',
            'cat_id'      => 'cat_id',
            'content'     => 'content',
            'status'      => 'status',
            'begin_time'  => 'begin_time',
            'end_time'    => 'end_time',
            'top'         => 'top',
            'author'      => 'author',
            'keywords'    => 'keywords',
        	'face'		  => 'face',
        	'pubtime'	  => 'pubtime',
        );
    }

    public function initialize()
    {
        $this->useDynamicUpdate( true );
        
        $this->hasMany( 'id' , '\apps\cms\models\ArticleTags' , 'aid' , array( 'alias' => 'arttags' ) );
        $this->belongsTo( 'cat_id' , '\apps\cms\models\ArticleCats' , 'id' , array( 'alias' => 'catinfo' ) );
       
        $this->setSource( $this->di[ 'config' ][ 'database'][ 'prefix'] . $this->getSource() );
    }
    
    public static function findSearch( $key )
    {
        $articles = new Articles();
        $sql = 'select a.id,a.title,a.face,a.content,a.author,a.pubtime,c.name as catname,  cat_id as catid  from fcms_articles as a '
                . 'join fcms_article_cats as c on a.cat_id = c.id '
                . 'where match( a.title,a.description,a.content ) against ( ? IN BOOLEAN MODE)  ';
        return new Resultset(null, $articles, $articles->getReadConnection()->query($sql, [ $key ]));
    }
}
