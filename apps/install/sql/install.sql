/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : fcms

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2016-04-01 11:16:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for fcms_ad
-- ----------------------------
DROP TABLE IF EXISTS `fcms_ad`;
CREATE TABLE `fcms_ad` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `media_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0图片 1视频',
  `name` varchar(60) NOT NULL DEFAULT '',
  `url` varchar(512) NOT NULL DEFAULT '',
  `begin_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `click_count` mediumint(8) unsigned DEFAULT '0',
  `enabled` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否展示',
  `cat_id` mediumint(5) NOT NULL,
  `sort_order` smallint(5) NOT NULL DEFAULT '50',
  `title` varchar(128) NOT NULL,
  `uptime` datetime DEFAULT NULL COMMENT 'update time',
  `delsign` tinyint(1) NOT NULL,
  `click_left` mediumint(9) DEFAULT NULL,
  `weight` tinyint(4) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL COMMENT 'user_id',
  `descr` varchar(256) DEFAULT NULL COMMENT 'description',
  `addtime` datetime NOT NULL COMMENT 'create time',
  `src` tinytext NOT NULL COMMENT 'img url flash url etc.',
  `shopid` bigint(20) NOT NULL,
  `nofollow` tinyint(1) DEFAULT NULL COMMENT '0 for no follow 1 for yes',
  PRIMARY KEY (`id`),
  KEY `enabled` (`enabled`) USING BTREE,
  KEY `cat_id` (`cat_id`,`sort_order`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fcms_ad
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_ad_cats
-- ----------------------------
DROP TABLE IF EXISTS `fcms_ad_cats`;
CREATE TABLE `fcms_ad_cats` (
  `id` mediumint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `pid` mediumint(5) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT NULL,
  `width` mediumint(9) NOT NULL,
  `height` mediumint(9) NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `base_price` float DEFAULT NULL,
  `click_price` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告分类表格';

-- ----------------------------
-- Records of fcms_ad_cats
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_ad_trace
-- ----------------------------
DROP TABLE IF EXISTS `fcms_ad_trace`;
CREATE TABLE `fcms_ad_trace` (
  `id` bigint(20) NOT NULL,
  `addtime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `ad_id` bigint(20) NOT NULL,
  `referer` tinytext,
  `city` varchar(64) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='广告追踪';

-- ----------------------------
-- Records of fcms_ad_trace
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_articles
-- ----------------------------
DROP TABLE IF EXISTS `fcms_articles`;
CREATE TABLE `fcms_articles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `title` varchar(128) NOT NULL,
  `face` varchar(128) DEFAULT NULL,
  `description` tinytext,
  `cat_id` bigint(20) NOT NULL,
  `content` text,
  `status` tinyint(4) NOT NULL COMMENT '0 for ok 1 for not review 2 for reviewed',
  `begin_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `top` tinyint(1) DEFAULT '0' COMMENT '0 for not set top 1 for yes',
  `author` varchar(64) DEFAULT NULL,
  `keywords` tinytext,
  `pubtime` datetime DEFAULT NULL COMMENT '文章发布日期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_articles
-- ----------------------------
INSERT INTO `fcms_articles` VALUES ('1', '2016-03-31 17:04:25', '2016-04-01 09:27:14', '0', null, '百度王劲：不能看不起中国技术 不能太妄自菲薄', '/upload/image/user/1/20160331/1459414994794797.jpg', '3月30日下午消息，百度公司今天举行人工智能媒体开放日，百度公司高级副总裁、自动驾驶事业部总经理王劲，百度深度学习研究院主任林元庆就百度人工智能和自动驾驶的最新进展进行了分享', '2', '<p style=\"text-align: center;\"><img src=\"/upload/image/user/1/20160331/1459414994794797.jpg\" alt=\"1459414994794797.jpg\"/></p><p>3月30日下午消息，<span id=\"usstock_BIDU\">百度</span><span id=\"quote_BIDU\"></span>公司今天举行人工智能媒体开放日，百度公司高级副总裁、自动驾驶事业部总经理王劲，百度深度学习研究院主任林元庆就百度人工智能和自动驾驶的最新进展进行了分享，百度首席科学家吴恩达以视频会议形式参与了此次活动。</p><p>王劲首先就百度人工智能和无人驾驶的最新情况进行了分享，并再次强调了百度无人车将在3年内实现商用、5年内达到量产的规划，还表示百度之所以如此迫切地希望以无人车作为人工智能的核心突破点，主要是无人车能带来巨大的社会效益。</p><p>“一方面是对生命的尊重，如果无人驾驶能够克服诸多人类驾驶中的问题，那可以挽救很多生命，据统计，平均每天有500人丧生于交通事故，百度认\n为做无人驾驶是对生命价值的尊重；另一方面是效率，无人车可以极大提高车的使用效率，节约社会资源和人力资源，能够很好地让社会效率得到提升；还有就是环\n保，车的使用效率提升了，车就少了，环保效能就达到了。”王劲告诉在场媒体。</p><p>提问环节，新浪科技以近期<span id=\"usstock_GOOG\">谷歌</span><span id=\"quote_GOOG\"></span>围棋程序AlphaGo和李世石比赛为例，问这位百度公司高级副总裁、自动驾驶事业部总经理是否有计划围绕无人车进行比赛，以实现无人车更广泛的普及？</p><p>王劲回答称：“这个问题我们内部昨天也在讨论，但就目前来讲，还是以研发和测试为主，而且我们认为无人驾驶需要的技术比AlphaGo难很多。你看AlphaGo研发了2年就能和人类最优秀选手比赛，但谷歌无人车已经研究那么久了，现在还需要不断测试。”</p><p>此外，身在硅谷、以视频参会的吴恩达还告诉新浪科技，百度目前也在美国进行测试，“北京之外，我们在硅谷也有一辆在同步进行路测研发，这个项目\n是我目前主要花精力的项目之一。”实际上，在之前接受新浪科技采访时，吴恩达表示目前主要将精力集中在无人车和语音识别两个项目上，“百度硅谷研究院来\n讲，目前头疼的是想法很多，但人力确实有限，只好集中在最具价值的几个领域。”</p><p>不过，关于“谷歌和百度”的问题，并没有一直在融和的气氛中进行下去。</p><p>当有现场记者表示：“博鳌期间有国外人工智能学者认为，谷歌在将人工智能技术用到了更多改变世界的领域，但百度倾向于商业变现，您怎么看？”</p><p>这个问题打破了王劲脸上的笑容。王劲表示：“您的这个问题的表达让我有些‘激动’，我刚才讲到百度无人驾驶的研发，最首要的就是出于对生命的尊\n重，这个技术越早实现一天，就会让500人免于在交通事故中丧生，难道这不是改变世界？一个围棋程序在忙着比赛，每比赛一天，就有500人离去。”</p><p>王劲进一步评价道：“在技术的问题上，我们中国人总是有些不自信，以前我们是比硅谷落后一些，但现在不一样了，现在有很多领域我们都已经处于领先，我们不能总是看不起中国的技术，总是妄自菲薄。”</p><p><ins style=\"display: block; overflow: hidden; text-decoration: none;\" data-ad-offset-top=\"0\" data-ad-offset-left=\"0\" data-ad-status=\"done\" id=\"SinaAdsArtical\" class=\"sinaads sinaads-done\" data-ad-pdps=\"PDPS000000056054\"><ins style=\"text-decoration:none;margin:0px auto;width:300px;display:block;position:relative;\"></ins></ins></p><p>这位百度高级副总裁还举例称，在广告领域里应用人工智能，百度就比“某搜索公司”要领先，“他们之前研究过2年，但后来觉得不可能就放弃了，百度通过自己努力实现了。别人认为不可能的事百度做到了，算不算领先？”</p><p>对于这个问题，视频那端的吴恩达主动发言了。这位从谷歌大脑计划负责人跳槽到百度的首席科学家表示，在图像识别和语音识别等领域，百度都是领先的。吴恩达还表示，人工智能的深入发展，需要足够大的数据和大计算平台，中国会在这方面具有优势，尤其是大数据方面。</p><p>最后，王劲向媒体表示，自己之所以如此“激动”，主要还是中国人对于自己技术的不自信，认为别人的才是先进的，总是妄自菲薄。</p><p>值得一提的是，回答该问题的王劲和吴恩达都是从谷歌“跳槽”到百度的，王劲加盟百度前曾任职谷歌中国工程研究院副院长，吴恩达则是谷歌大脑计划的负责人。</p><p style=\"text-align: right;\">（摘自新浪科技）<br/></p><p><br/></p>', '0', null, null, '1', 'admin', '百度 技术 中国', '2016-03-31 05:04:14');
INSERT INTO `fcms_articles` VALUES ('2', '2016-03-31 17:30:37', '2016-04-01 09:27:06', '0', null, 'PhalconPHP and PHP7', '/upload/image/user/1/20160331/1459416558971098.jpg', '前不久，phalcon发布新版本并支持php7，让我们一起来先睹为快吧！', '2', '<p style=\"text-align: center;\"><img alt=\"ada977e1d68aa8359aaeab5a92330e97.jpg\" src=\"/upload/image/user/1/20160331/1459416667696469.jpg\" title=\"1459416667696469.jpg\"/></p><p>PHP7 was released on the 3rd of December, 2015. This new version brought forward a large number of new and exiting features (<a href=\"http://php.net/manual/en/migration70.new-features.php\" rel=\"nofollow\">http://php.net/manual/en/migration70.new-features.php</a>) to PHP. Perhaps one of the biggest of the new features is a new Zend Engine (the engine that powers PHP).</p><p>This new engine, code named PHPNG, will give some of your applications double the performance speed.</p><p>Some benchmarks that have been run so far:</p><ul class=\" list-paddingleft-2\"><li><p>Wordpress&nbsp;3.6&nbsp;–&nbsp;20.0%&nbsp;gain&nbsp;(253&nbsp;vs&nbsp;211&nbsp;req/sec)</p></li><li><p>Drupal&nbsp;6.1&nbsp;–&nbsp;11.7%&nbsp;gain&nbsp;(1770&nbsp;vs&nbsp;1585&nbsp;req/sec)</p></li><li><p>Qdig&nbsp;–&nbsp;15.3%&nbsp;gain&nbsp;(555&nbsp;vs&nbsp;482&nbsp;req/sec)</p></li><li><p>ZF&nbsp;test&nbsp;app&nbsp;–&nbsp;30.5%&nbsp;gain&nbsp;(217&nbsp;vs&nbsp;166&nbsp;req/sec)</p></li></ul><p>It\n is only natural that once it came out the PhalconPHP community was \ndying to know when we would get a chance to work with PhalconPHP and \nPHP7.</p><h4>The Problem</h4><p>We all know that PhalconPHP is written \nin Zephir starting with version 2.0, and that this language compiles its\n code into a C PHP Extension. Because of PHP7’s new engine the extension\n had to be rewritten and adapted to the new specifications.</p><h4>The Solution</h4><p>Knowing\n this, the PhalconPHP team started working since last year on an updated\n version of Zephir to make the compiled code work with PHP7.</p><p>After a few months we are finally delivered PhalconPHP 2.1 and Zephir 0.9.x which brings PHP7 support.</p><h3>Installing PhalconPHP with PHP7</h3><p>You\n will need to install PHP7+ and Zephir 0.9.2a-dev (or its latest \nbranch). After you have them installed go to PhalconPHP 2.1.0+ branch \nand download the source code.</p><p><strong>Installation example:</strong></p><pre>root@localhost:~$&nbsp;cd&nbsp;cphalcon-2.1.x/\nroot@localhost:~/cphalcon-2.1.x$&nbsp;zephir&nbsp;build&nbsp;—backend=ZendEngine3</pre><p>If you get these warnings ignore them:</p><pre>Warning:&nbsp;Variable&nbsp;&quot;_SESSION&quot;&nbsp;assigned&nbsp;but&nbsp;not&nbsp;used&nbsp;in&nbsp;Phalcon\\Session\\Adapter::remove&nbsp;in&nbsp;/root/cphalcon-2.1.x/phalcon/session/adapter.zep&nbsp;on&nbsp;204&nbsp;[unused-variable]\n\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\n&nbsp;&nbsp;&nbsp;&nbsp;-^Warning:&nbsp;Variable&nbsp;&quot;beforeLine&quot;&nbsp;assigned&nbsp;but&nbsp;not&nbsp;used&nbsp;in&nbsp;Phalcon\\Debug::showTraceItem&nbsp;in&nbsp;/root/cphalcon-2.1.x/phalcon/debug.zep&nbsp;on&nbsp;339&nbsp;[unused-variable]\n\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;beforeLine,&nbsp;firstLine,&nbsp;afterLine,&nbsp;lastLine,&nbsp;i,&nbsp;linePosition,&nbsp;currentLine;\n&nbsp;&nbsp;&nbsp;&nbsp;-------------^Warning:&nbsp;Variable&nbsp;&quot;possibleSetter&quot;&nbsp;declared&nbsp;but&nbsp;not&nbsp;used&nbsp;in&nbsp;Phalcon\\Mvc\\Model::assign&nbsp;in&nbsp;/root/cphalcon-2.1.x/phalcon/mvc/model.zep&nbsp;on&nbsp;440&nbsp;[unused-variable]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var&nbsp;key,&nbsp;keyMapped,&nbsp;value,&nbsp;attribute,&nbsp;attributeField,&nbsp;possibleSetter,&nbsp;metaData,&nbsp;columnMap,&nbsp;dataMapped;\n&nbsp;&nbsp;&nbsp;&nbsp;----------------------------------------------------------------------^Warning:&nbsp;Function&nbsp;&quot;\\\\sodium\\\\randombytes_buf&quot;&nbsp;does&nbsp;not&nbsp;exist&nbsp;at&nbsp;compile&nbsp;time&nbsp;in&nbsp;/root/cphalcon-2.1.x/phalcon/security/random.zep&nbsp;on&nbsp;119&nbsp;[nonexistent-function]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;\\\\Sodium\\\\randombytes_buf(len);\n&nbsp;&nbsp;&nbsp;&nbsp;----------------------------------------^Warning:&nbsp;Function&nbsp;&quot;\\\\sodium\\\\randombytes_uniform&quot;&nbsp;does&nbsp;not&nbsp;exist&nbsp;at&nbsp;compile&nbsp;time&nbsp;in&nbsp;/root/cphalcon-2.1.x/phalcon/security/random.zep&nbsp;on&nbsp;310&nbsp;[nonexistent-function]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;\\\\Sodium\\\\randombytes_uniform(len);\n&nbsp;&nbsp;&nbsp;&nbsp;--------------------------------------------^\n\nCompiling...\nInstalling...\nExtension&nbsp;installed!\nDon&#39;t&nbsp;forget&nbsp;to&nbsp;restart&nbsp;your&nbsp;web&nbsp;server\n\nroot@localhost:~/cphalcon-2.1.x$&nbsp;&nbsp;service&nbsp;php-fpm&nbsp;restart</pre><p><strong>That’s it!</strong></p><p>You now have PhalconPHP and PHP7&nbsp;working.</p><p>Can\n you expect PhalconPHP to be even faster? No, but you can expect to see \nyour your app be much faster since your PHP code will run better with \nthe new engine. Plus, you won’t have any overhead since PhalconPHP is a \nextension. The best part of all this is that you get all the new \nfeatures that PHP7 brings to the table.</p><p>Do take into account that \nPHP7 is still rather new, and most of the commonly used extensions like \nmemcache, memcached, and redis are available in Dev/Beta branches, so \nyou need to reinstall them.</p><p><strong>Best of luck to all and enjoy PhalconPHP + PHP7.</strong></p><p><br/></p>', '0', null, null, '1', 'admin', 'phalcon php7', '2016-03-31 05:30:29');
INSERT INTO `fcms_articles` VALUES ('3', '2016-03-31 17:35:05', '2016-04-01 09:27:24', '0', null, 'FCMS特点全解析', '/upload/image/user/1/20160331/1459416838127029.png', 'FCMS 0.1a 隆重发布啦，FCMS到底有哪些特点和过人之处呢，让我们一起来了解！', '1', '<p><span style=\"font-size: 14px;\"><strong>1.严密的权限管理系统</strong></span></p><p><span style=\"font-size: 14px;\">严密控制后端用户权限，精细到用户的每一个操作点</span></p><p><span style=\"font-size: 14px;\"><strong>2.用户角色分组管理</strong></span></p><p><span style=\"font-size: 14px;\">用户所在组可多存在多个角色，避免用户因权限不足导致无法操作 <br/></span></p><p><span style=\"font-size: 14px;\"><strong>3.文章回收</strong></span></p><p><span style=\"font-size: 14px;\">智能文章回收，人性化操作，例如文章分类已被删除的情况下，可以智能恢复（可修改文章分类也可选择直接恢复文章分类）</span></p><p><span style=\"font-size: 14px;\"><strong>4.静态化功能</strong></span></p><p><span style=\"font-size: 14px;\"><strong>5.导航多功能（菜单） </strong><br/></span></p><p><span style=\"font-size: 14px;\">可实现多分类切换，可自由切换前台显示导航（菜单）</span></p><p><span style=\"font-size: 14px;\"><strong>6.前端幻灯片管理</strong></span></p><p><span style=\"font-size: 14px;\">以组的方式管理幻灯片，可严格限制用户上传的幻灯片的图片大小</span></p><p><br/></p><p><br/></p>', '0', null, null, '1', 'admin', 'FCMS 特点 解析', '2016-03-31 05:34:46');
INSERT INTO `fcms_articles` VALUES ('4', '2016-04-01 09:08:38', '2016-04-01 09:27:19', '0', null, 'FCMS静态化指南', '/upload/image/user/1/20160401/1459472854205821.png', 'FCMS为大家提供了丰富的静态化功能，这篇文章就教你如何去实现静态化。', '1', '<p><strong><span style=\"font-size:19px\">1</span></strong><strong><span style=\"font-size:19px;font-family:宋体\">、</span></strong><strong><span style=\"font-size:19px;font-family: 宋体\">配置静态化（缓存管理</span></strong><strong><span style=\"font-size:19px\">-</span></strong><strong><span style=\"font-size:19px;font-family: 宋体\">静态化）</span></strong></p><p>&nbsp;</p><p><strong><span style=\"font-size:16px;font-family:宋体\">栏目配置（站点主页）</span></strong></p><p><span style=\"font-size:16px;font-family:宋体\">配置名称——该项只支持英文</span></p><p><span style=\"font-size:16px;font-family:宋体\">配置前缀——该项为动态访问主页时对应的模块、控制器、动作名称。如</span><span style=\"font-size:16px\">: /cms/index/index</span></p><p><span style=\"font-size:16px\">&nbsp;</span></p><p><strong><span style=\"font-size:16px;font-family:宋体\">缓存类型（目前我们只支持了文件方式缓存）</span></strong></p><p><span style=\"font-size:16px;font-family:宋体\">缓存时间——该缓存的有效时间</span></p><p><span style=\"font-size:16px\">&nbsp;</span></p><p><strong><span style=\"font-size:16px;font-family:宋体\">列表配置（文章列表页）</span></strong></p><p><span style=\"font-size:16px;font-family:宋体\">配置名称——该项只支持英文</span></p><p><span style=\"font-size:16px;font-family:宋体\">配置前缀——该项为动态访问列表页时对应的模块、控制器、动作以及携带参数名称。如：</span><span style=\"font-size:16px\">/cms/index/list/cid</span></p><p><span style=\"font-size:16px;font-family:宋体\">缓存类型——目前我们只支持了文件方式缓存</span></p><p><span style=\"font-size:16px;font-family:宋体\">缓存时间——该缓存的有效时间</span></p><p><span style=\"font-size:16px\">&nbsp;</span></p><p><strong><span style=\"font-size:16px;font-family:宋体\">详细页配置</span></strong></p><p><span style=\"font-size:16px;font-family:宋体\">配置名称——该项只支持英文</span></p><p><span style=\"font-size:16px;font-family:宋体\">配置前缀——该项为动态访问详情页时对应的模块、控制器、动作以及携带参数名称。如：</span><span style=\"font-size:16px\">/cms/index/detail/id</span></p><p><span style=\"font-size:16px;font-family:宋体\">缓存类型——目前我们只支持了文件方式缓存</span></p><p><span style=\"font-size:16px;font-family:宋体\">缓存时间——该缓存的有效时</span></p><p><span style=\"font-size:16px\">&nbsp;</span></p><p><strong><span style=\"font-size:19px\">2</span></strong><strong><span style=\"font-size:19px;font-family:宋体\">、生成静态文件（文章管理</span></strong><strong><span style=\"font-size:19px\">-</span></strong><strong><span style=\"font-size:19px;font-family: 宋体\">文章）</span></strong></p><p><strong><span style=\"font-size:19px;font-family: 宋体\"><img alt=\"123.png\" src=\"/upload/image/user/1/20160401/1459473765106249.png\" title=\"1459473765106249.png\" height=\"127\" width=\"697\"/></span></strong></p><p><span style=\"font-size:16px\"></span></p><p><strong><span style=\"font-size:16px;font-family:宋体\">如上图所示：</span></strong></p><p><span style=\"font-size: 16px\">1</span><span style=\"font-size:16px;font-family:宋体\">为全站静态化按钮</span></p><p><span style=\"font-size: 16px\">2</span><span style=\"font-size:16px;font-family:宋体\">为继续静态化按钮</span></p><p><span style=\"font-size: 16px\">3</span><span style=\"font-size:16px;font-family:宋体\">为单篇文章静态化按钮</span></p><p><span style=\"font-size: 16px\">&nbsp;</span></p><p><span style=\"font-size:16px;font-family:宋体\">我们将静态化文件库放在网站根目录下的</span><span style=\"font-size:16px\">/static</span><span style=\"font-size:16px;font-family:宋体\">文件夹下，静态化时会根据对应静态化配置前缀生成对应的文件夹之后才会生成对应的静态化文件（</span><span style=\"font-size:16px\">.html</span><span style=\"font-size:16px;font-family:宋体\">）。</span><span style=\"font-size:16px\"> PS</span><span style=\"font-size:16px;font-family: 宋体\">：</span><span style=\"font-size: 16px\">Linux/OS X</span><span style=\"font-size:16px;font-family:宋体\">下该要注意该</span><span style=\"font-size:16px\"> static</span><span style=\"font-size:16px;font-family:宋体\">文件夹的权限哟</span><span style=\"font-size:16px\">!</span></p><p><span style=\"font-size: 16px\">&nbsp;</span></p><p><strong><span style=\"font-size:16px;font-family:宋体\">全站静态化：</span></strong><span style=\"font-size:16px;font-family:宋体\">即生成全站点的所有静态文件（</span><span style=\"font-size:16px\">.html</span><span style=\"font-size:16px;font-family:宋体\">）</span></p><p><strong><span style=\"font-size:16px;font-family:宋体\">继续静态化：</span></strong><span style=\"font-size:16px;font-family:宋体\">即已经生成的静态文件则不会再次生成，没有生成静态化文件的文章则生成对应的静态文件（</span><span style=\"font-size:16px\">.html</span><span style=\"font-size:16px;font-family:宋体\">）</span></p><p><strong><span style=\"font-size:16px;font-family:宋体\">单篇文章静态化</span></strong><strong><span style=\"font-size:16px\">:</span></strong><span style=\"font-size:16px;font-family:宋体\">即生该片文章对应的静态文件，如果存在该篇文章之前的静态文件则覆盖，没有则重新生成静态文件（</span><span style=\"font-size:16px\">.html</span><span style=\"font-size:16px;font-family:宋体\">）</span></p><p><br/></p>', '0', null, null, '1', 'admin', 'FCMS 静态化', '2016-04-01 09:08:20');

-- ----------------------------
-- Table structure for fcms_article_cats
-- ----------------------------
DROP TABLE IF EXISTS `fcms_article_cats`;
CREATE TABLE `fcms_article_cats` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `title` varchar(64) DEFAULT NULL COMMENT 'for seo',
  `keywords` varchar(256) DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 for catagory 1 for single article',
  `description` varchar(512) DEFAULT NULL COMMENT 'description for seo',
  `nofollow` tinyint(1) DEFAULT NULL COMMENT '0 for no follow 1 for yes',
  `img` varchar(512) DEFAULT NULL COMMENT '栏目首图',
  `parent_id` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_article_cats
-- ----------------------------
INSERT INTO `fcms_article_cats` VALUES ('1', '2015-11-25 11:04:42', '2016-03-24 09:34:34', '0', null, 'FCMS强势登陆', '0', null, '0', null, null, null, '0');
INSERT INTO `fcms_article_cats` VALUES ('2', '2015-11-25 13:53:09', '2016-03-24 09:34:38', '0', null, '互联网动态', '0', null, '0', null, null, null, '0');
INSERT INTO `fcms_article_cats` VALUES ('3', '2015-11-27 13:27:11', '2015-11-27 13:27:11', '0', null, '关于我们', '0', null, '0', null, null, null, '0');
INSERT INTO `fcms_article_cats` VALUES ('4', '2015-11-27 13:27:17', '2015-11-27 13:27:17', '0', null, '联系我们', '0', null, '0', null, null, null, '0');

-- ----------------------------
-- Table structure for fcms_article_imgs
-- ----------------------------
DROP TABLE IF EXISTS `fcms_article_imgs`;
CREATE TABLE `fcms_article_imgs` (
  `id` bigint(20) NOT NULL,
  `addtime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `name` varchar(128) NOT NULL COMMENT 'uuid 301a9e765c2192b0b9e66bc48bf69990efdfeng',
  `dir` varchar(512) DEFAULT NULL COMMENT '001/axz/03b',
  `realname` varchar(256) DEFAULT NULL COMMENT 'avatar.jpg',
  `server` char(8) DEFAULT NULL COMMENT 'img001 img002 img003....',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_article_imgs
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_article_tags
-- ----------------------------
DROP TABLE IF EXISTS `fcms_article_tags`;
CREATE TABLE `fcms_article_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `name` varchar(36) DEFAULT NULL COMMENT 'tag名称',
  `seo` varchar(64) DEFAULT NULL COMMENT 'seo标题',
  `seokey` varchar(128) DEFAULT NULL COMMENT 'seo关键字',
  `seodescr` varchar(255) DEFAULT NULL COMMENT 'seo描述',
  `display` tinyint(1) unsigned DEFAULT '0' COMMENT '是否显示  0 显示  1 不现实 ',
  `pinyin` varchar(64) DEFAULT NULL COMMENT '拼音名字',
  `fname` varchar(64) DEFAULT NULL COMMENT '首字母',
  `linkurl` varchar(128) DEFAULT NULL COMMENT '链接网址',
  `descr` varchar(256) DEFAULT '0',
  `aid` bigint(20) unsigned DEFAULT NULL COMMENT '文章id',
  `sort` int(20) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_article_tags
-- ----------------------------
INSERT INTO `fcms_article_tags` VALUES ('30', '0', '2016-04-01 09:27:13', '2016-04-01 09:27:13', '妄自菲薄', null, null, null, '0', null, null, null, '0', '1', '0');
INSERT INTO `fcms_article_tags` VALUES ('29', '0', '2016-04-01 09:27:13', '2016-04-01 09:27:13', '中国', null, null, null, '0', null, null, null, '0', '1', '0');
INSERT INTO `fcms_article_tags` VALUES ('28', '0', '2016-04-01 09:27:13', '2016-04-01 09:27:13', '技术', null, null, null, '0', null, null, null, '0', '1', '0');
INSERT INTO `fcms_article_tags` VALUES ('27', '0', '2016-04-01 09:27:13', '2016-04-01 09:27:13', '百度', null, null, null, '0', null, null, null, '0', '1', '0');
INSERT INTO `fcms_article_tags` VALUES ('25', '0', '2016-04-01 09:27:02', '2016-04-01 09:27:02', 'php7', null, null, null, '0', null, null, null, '0', '2', '0');
INSERT INTO `fcms_article_tags` VALUES ('26', '0', '2016-04-01 09:27:02', '2016-04-01 09:27:02', 'phalcon', null, null, null, '0', null, null, null, '0', '2', '0');
INSERT INTO `fcms_article_tags` VALUES ('36', '0', '2016-04-01 09:27:23', '2016-04-01 09:27:23', '解析', null, null, null, '0', null, null, null, '0', '3', '0');
INSERT INTO `fcms_article_tags` VALUES ('35', '0', '2016-04-01 09:27:23', '2016-04-01 09:27:23', '特点', null, null, null, '0', null, null, null, '0', '3', '0');
INSERT INTO `fcms_article_tags` VALUES ('34', '0', '2016-04-01 09:27:23', '2016-04-01 09:27:23', 'FCMS', null, null, null, '0', null, null, null, '0', '3', '0');
INSERT INTO `fcms_article_tags` VALUES ('33', '0', '2016-04-01 09:27:18', '2016-04-01 09:27:18', '指南', null, null, null, '0', null, null, null, '0', '4', '0');
INSERT INTO `fcms_article_tags` VALUES ('32', '0', '2016-04-01 09:27:18', '2016-04-01 09:27:18', '静态化', null, null, null, '0', null, null, null, '0', '4', '0');
INSERT INTO `fcms_article_tags` VALUES ('31', '0', '2016-04-01 09:27:18', '2016-04-01 09:27:18', 'FCMS', null, null, null, '0', null, null, null, '0', '4', '0');

-- ----------------------------
-- Table structure for fcms_article_visits
-- ----------------------------
DROP TABLE IF EXISTS `fcms_article_visits`;
CREATE TABLE `fcms_article_visits` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) NOT NULL,
  `addtime` datetime DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `visit_times` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_article_visits
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_cache_manage
-- ----------------------------
DROP TABLE IF EXISTS `fcms_cache_manage`;
CREATE TABLE `fcms_cache_manage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `name` varchar(128) NOT NULL COMMENT '缓存中文名字',
  `ename` varchar(128) NOT NULL COMMENT '缓存英文名字',
  `ename_rule` varchar(255) NOT NULL COMMENT '缓存英文名规则 ',
  `cache_time` int(11) NOT NULL COMMENT '缓存时间',
  `type` tinyint(1) NOT NULL COMMENT '缓存类型  0 memcache 1memcachedb 2 redis 3mongodb 4 mysql',
  `is_warm_up` tinyint(1) NOT NULL COMMENT '是否预热 0 no 1 yes',
  `module` tinyint(1) NOT NULL COMMENT '0 前台 1 后台 2 OA 3 common',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fcms_cache_manage
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_cache_manage_config
-- ----------------------------
DROP TABLE IF EXISTS `fcms_cache_manage_config`;
CREATE TABLE `fcms_cache_manage_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `index` varchar(32) DEFAULT NULL COMMENT '配置项',
  `list` varchar(128) DEFAULT NULL COMMENT '配置项值',
  `detail` varchar(255) DEFAULT NULL,
  `type` tinyint(1) unsigned DEFAULT NULL COMMENT '类别  0 基本配置 1 驱动配置 2 存储配置',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_cache_manage_config
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_cache_page_manage
-- ----------------------------
DROP TABLE IF EXISTS `fcms_cache_page_manage`;
CREATE TABLE `fcms_cache_page_manage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `cname` varchar(128) DEFAULT NULL COMMENT '缓存名称',
  `cache_time` int(11) DEFAULT NULL COMMENT '缓存时间',
  `type` tinyint(1) DEFAULT NULL COMMENT '驱动类型',
  `is_warm_up` tinyint(1) NOT NULL COMMENT '是否预热 0 no 1 yes',
  `module` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '所属页面   0 首页 1 列表页 2 详细页面',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_cache_page_manage
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_cache_static_manage
-- ----------------------------
DROP TABLE IF EXISTS `fcms_cache_static_manage`;
CREATE TABLE `fcms_cache_static_manage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `name` varchar(128) DEFAULT NULL COMMENT '缓存名称',
  `cache_time` int(11) DEFAULT NULL COMMENT '缓存时间',
  `type` tinyint(1) DEFAULT NULL COMMENT '驱动类型',
  `cfgtype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '静态化类型  1 栏目配置 2 列表页配置 3 详情页配置',
  `prefix` varchar(128) NOT NULL COMMENT '访问前缀  module/controller/action/params',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_cache_static_manage
-- ----------------------------
INSERT INTO `fcms_cache_static_manage` VALUES ('1', '2015-12-03 15:00:34', '2015-12-22 11:01:31', '0', '0', 'Index', '60', '1', '1', '/cms/index/index');
INSERT INTO `fcms_cache_static_manage` VALUES ('2', '2015-12-03 15:02:12', '2016-03-23 17:02:47', '0', '0', 'Detail', '60', '1', '3', '/cms/index/detail/id');
INSERT INTO `fcms_cache_static_manage` VALUES ('3', '2016-03-29 10:27:54', '2016-03-29 10:28:41', '0', '0', 'List', '60', '1', '2', '/cms/index/listabc/cid');

-- ----------------------------
-- Table structure for fcms_cards
-- ----------------------------
DROP TABLE IF EXISTS `fcms_cards`;
CREATE TABLE `fcms_cards` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL DEFAULT '',
  `img` varchar(255) NOT NULL DEFAULT '',
  `fee` decimal(6,2) unsigned NOT NULL DEFAULT '0.00',
  `free_money` decimal(6,2) unsigned NOT NULL DEFAULT '0.00',
  `descr` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fcms_cards
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_customers
-- ----------------------------
DROP TABLE IF EXISTS `fcms_customers`;
CREATE TABLE `fcms_customers` (
  `id` bigint(20) NOT NULL,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `nickname` varchar(128) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `province` tinyint(64) DEFAULT NULL,
  `city` smallint(6) DEFAULT NULL,
  `disctrict` smallint(6) DEFAULT NULL,
  `detail_addr` varchar(256) DEFAULT NULL,
  `qq` varchar(32) DEFAULT NULL,
  `cellphone1` varchar(32) DEFAULT NULL,
  `cellphone2` varchar(32) DEFAULT NULL,
  `phone1` varchar(32) DEFAULT NULL,
  `phone2` varchar(32) DEFAULT NULL,
  `fax1` varchar(32) DEFAULT NULL,
  `fax2` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_customers
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_friendly_links
-- ----------------------------
DROP TABLE IF EXISTS `fcms_friendly_links`;
CREATE TABLE `fcms_friendly_links` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `title` varchar(64) NOT NULL,
  `nofollow` tinyint(1) NOT NULL COMMENT '0 for no follow 1 for yes',
  `urltype` tinyint(1) unsigned NOT NULL COMMENT '0表示本站url，1表示外站url',
  `target` tinyint(1) unsigned DEFAULT '0' COMMENT '打开方式，默认为0新窗口打开，1为本窗口打开',
  `url` varchar(256) NOT NULL,
  `sort` bigint(20) DEFAULT NULL,
  `icon` varchar(128) DEFAULT NULL COMMENT '友情连接icon',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='友情链接';

-- ----------------------------
-- Records of fcms_friendly_links
-- ----------------------------
INSERT INTO `fcms_friendly_links` VALUES ('10', '2016-03-29 10:42:47', '2016-03-31 16:18:56', '0', null, 'Phalcon', 'Phalcon', '1', '1', '0', 'https://phalconphp.com/zh/', '50', '');

-- ----------------------------
-- Table structure for fcms_log_members_login
-- ----------------------------
DROP TABLE IF EXISTS `fcms_log_members_login`;
CREATE TABLE `fcms_log_members_login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NOT NULL,
  `last_login_time` datetime DEFAULT NULL COMMENT '2013',
  `last_login_ip` varchar(16) DEFAULT NULL,
  `last_logout_time` datetime DEFAULT NULL,
  `last_login_city` varchar(256) DEFAULT NULL,
  `device` tinyint(4) DEFAULT '0' COMMENT '0 for pc 1 for android phone 2 for android pad 3 for iphone 4 for ipad 5 for wp phone 6 for others',
  `useragent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='登陆日志';

-- ----------------------------
-- Records of fcms_log_members_login
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_log_members_operation
-- ----------------------------
DROP TABLE IF EXISTS `fcms_log_members_operation`;
CREATE TABLE `fcms_log_members_operation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned DEFAULT NULL COMMENT '前台用户id',
  `username` char(128) DEFAULT NULL,
  `controller` char(128) NOT NULL COMMENT '控制器',
  `action` char(32) NOT NULL COMMENT '方法',
  `operation` tinyint(1) unsigned NOT NULL COMMENT '操作类型    1:add  2:update 3:delete',
  `dataid` bigint(20) unsigned DEFAULT NULL COMMENT '数据id',
  `dataids` mediumtext COMMENT '以@为分隔符的字符串形式记录数据id 如： 1@2@3',
  `addtime` datetime DEFAULT NULL,
  `delsign` tinyint(4) DEFAULT NULL,
  `postcontent` mediumtext,
  `descr` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fcms_log_members_operation
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_log_users_operation
-- ----------------------------
DROP TABLE IF EXISTS `fcms_log_users_operation`;
CREATE TABLE `fcms_log_users_operation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL COMMENT '后台用户id',
  `username` char(128) NOT NULL,
  `controller` char(128) NOT NULL COMMENT '控制器',
  `action` char(32) NOT NULL COMMENT '方法',
  `operation` tinyint(1) unsigned NOT NULL COMMENT '操作类型    1:add  2:update 3:delete',
  `dataid` bigint(20) unsigned DEFAULT NULL COMMENT '数据id',
  `dataids` mediumtext COMMENT '以@为分隔符的字符串形式记录数据id 如： 1@2@3',
  `addtime` datetime DEFAULT NULL,
  `delsign` tinyint(4) DEFAULT NULL,
  `postcontent` mediumtext,
  `descr` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fcms_log_users_operation
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_log_visit_record
-- ----------------------------
DROP TABLE IF EXISTS `fcms_log_visit_record`;
CREATE TABLE `fcms_log_visit_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `memid` bigint(16) unsigned DEFAULT NULL,
  `ip` varchar(16) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `agent` varchar(255) DEFAULT NULL,
  `goodid` bigint(16) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `refer` varchar(255) DEFAULT NULL COMMENT '从哪个页面跳转过来',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='访问统计表';

-- ----------------------------
-- Records of fcms_log_visit_record
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_mem_footprint
-- ----------------------------
DROP TABLE IF EXISTS `fcms_mem_footprint`;
CREATE TABLE `fcms_mem_footprint` (
  `id` bigint(20) NOT NULL,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `spec_id` bigint(20) NOT NULL COMMENT ' 规格ID',
  `visit_cnt` smallint(6) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `mem_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户足迹';

-- ----------------------------
-- Records of fcms_mem_footprint
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_mem_grades
-- ----------------------------
DROP TABLE IF EXISTS `fcms_mem_grades`;
CREATE TABLE `fcms_mem_grades` (
  `id` bigint(20) NOT NULL,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `mem_id` bigint(20) DEFAULT NULL,
  `left_point` int(11) DEFAULT NULL COMMENT '升级之后剩余点数',
  `grade_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_mem_grades
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_mem_grade_dic
-- ----------------------------
DROP TABLE IF EXISTS `fcms_mem_grade_dic`;
CREATE TABLE `fcms_mem_grade_dic` (
  `id` bigint(20) NOT NULL,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `title` varchar(32) DEFAULT NULL,
  `lowlimit` int(11) DEFAULT NULL COMMENT '最低消费 >=',
  `highlimit` int(11) DEFAULT NULL COMMENT '到 <',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_mem_grade_dic
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_mem_members
-- ----------------------------
DROP TABLE IF EXISTS `fcms_mem_members`;
CREATE TABLE `fcms_mem_members` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT '0000-00-00 00:00:00',
  `email` varchar(128) DEFAULT '0.00',
  `username` varchar(128) DEFAULT '' COMMENT 'user''s real name',
  `login_name` varchar(128) NOT NULL,
  `password` char(128) NOT NULL COMMENT 'algor:hash(hash(password)+sessionid))',
  `head_img` varchar(128) DEFAULT NULL,
  `gender` tinyint(1) unsigned DEFAULT '0' COMMENT '0 for male 1 for female',
  `birthdate` date DEFAULT '2014-01-01' COMMENT '出生日期',
  `money_left` decimal(10,2) DEFAULT '0.00',
  `accu_points` int(10) unsigned DEFAULT '0' COMMENT '累积积分',
  `rest_points` mediumint(11) DEFAULT NULL COMMENT '剩余积分',
  `rank` int(10) unsigned DEFAULT '0' COMMENT '会员等级',
  `visit_count` smallint(5) unsigned DEFAULT '0',
  `salt` varchar(10) DEFAULT '0',
  `parent_id` mediumint(9) DEFAULT '0',
  `qq` varchar(20) DEFAULT '0',
  `office_phone` varchar(20) DEFAULT '0',
  `home_phone` varchar(20) DEFAULT '0',
  `mobile_phone` varchar(20) DEFAULT '0',
  `passwd_question` varchar(50) DEFAULT NULL,
  `passwd_answer` varchar(255) DEFAULT NULL,
  `user_icon` varchar(255) DEFAULT 'usericon/user_icon.jpg',
  `active` tinyint(3) DEFAULT '0',
  `activation_key` varchar(32) DEFAULT NULL,
  `ucode` varchar(25) DEFAULT NULL,
  `nickname` varchar(30) DEFAULT NULL COMMENT '妮称',
  `province` tinyint(2) DEFAULT NULL,
  `city` smallint(5) DEFAULT NULL,
  `district` smallint(5) DEFAULT NULL,
  `addr` varchar(100) DEFAULT NULL,
  `bind_email` tinyint(1) DEFAULT '0' COMMENT '0 for yes 1 for no',
  `bind_mobile` tinyint(1) DEFAULT '0' COMMENT '0 for yes 1 for no',
  `forget_code` varchar(16) DEFAULT NULL COMMENT '忘记密码找回码',
  `status` tinyint(1) DEFAULT '0' COMMENT '0 for ok 1 for lock 2 for delete 3 for forget password ',
  `delsign` tinyint(4) DEFAULT '0' COMMENT '0 for ok',
  `height` smallint(6) DEFAULT NULL COMMENT 'cm',
  `weight` smallint(6) DEFAULT NULL,
  `waistline` smallint(6) DEFAULT NULL COMMENT '腰围',
  `chest` smallint(6) DEFAULT NULL COMMENT '胸围',
  `hipline` smallint(6) DEFAULT NULL COMMENT '臀围',
  `legline` smallint(6) DEFAULT NULL COMMENT '腿围',
  `shoesize` tinyint(4) DEFAULT NULL COMMENT '足长',
  `marital_status` tinyint(4) DEFAULT '0' COMMENT '婚否 0 for yes 1 for no',
  `alipay` varchar(128) DEFAULT '0' COMMENT '支付宝帐号',
  `token` varchar(128) DEFAULT '0',
  `token_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of fcms_mem_members
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_mem_member_login_address
-- ----------------------------
DROP TABLE IF EXISTS `fcms_mem_member_login_address`;
CREATE TABLE `fcms_mem_member_login_address` (
  `id` bigint(16) unsigned NOT NULL AUTO_INCREMENT,
  `mem_id` mediumint(8) unsigned DEFAULT NULL COMMENT '会员ID',
  `min` bigint(16) unsigned DEFAULT NULL COMMENT '起始IP对应的整型',
  `max` bigint(16) unsigned DEFAULT NULL COMMENT '终止IP对应的整型',
  `address` varchar(128) DEFAULT NULL COMMENT '用户常用登录地址（理想情况下精确到市）',
  `addtime` varchar(20) DEFAULT NULL,
  `network` varchar(128) DEFAULT NULL COMMENT '网段',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='用户常用登录IP地址字典表（轻量级）\r\n理想情况下精确到市\r\n每个用户保存10条记录，且不断更新';

-- ----------------------------
-- Records of fcms_mem_member_login_address
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_mem_notices
-- ----------------------------
DROP TABLE IF EXISTS `fcms_mem_notices`;
CREATE TABLE `fcms_mem_notices` (
  `id` bigint(20) NOT NULL,
  `mem_id` bigint(20) DEFAULT NULL,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `title` varchar(256) DEFAULT NULL,
  `content` text,
  `status` tinyint(4) DEFAULT '0' COMMENT '0 for yes 1 for not',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='针对会员的站内通知';

-- ----------------------------
-- Records of fcms_mem_notices
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_menu
-- ----------------------------
DROP TABLE IF EXISTS `fcms_menu`;
CREATE TABLE `fcms_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `cid` bigint(20) unsigned NOT NULL COMMENT '分类id',
  `pid` bigint(20) unsigned DEFAULT '0' COMMENT '父级id   0顶级',
  `name` varchar(64) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(128) DEFAULT NULL COMMENT '链接地址',
  `relid` bigint(20) DEFAULT NULL COMMENT '关联文章分类id',
  `target` tinyint(2) DEFAULT NULL COMMENT '打开方式 0 内  1 外',
  `icon` varchar(128) DEFAULT NULL COMMENT '图标',
  `is_show` tinyint(2) DEFAULT '0' COMMENT '是否显示 0显示  1不显示',
  `sort` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_menu
-- ----------------------------
INSERT INTO `fcms_menu` VALUES ('1', '2016-04-01 11:14:00', '2016-04-01 11:14:00', '0', '0', '1', '0', '首页', null, '0', '0', '', '0', '50');
INSERT INTO `fcms_menu` VALUES ('2', '2016-04-01 11:15:19', '2016-04-01 11:15:49', '0', '0', '1', '0', '特点解析', '/cms/index/detail/id/3', null, '0', '', '0', '49');

-- ----------------------------
-- Table structure for fcms_menu_category
-- ----------------------------
DROP TABLE IF EXISTS `fcms_menu_category`;
CREATE TABLE `fcms_menu_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `is_main` tinyint(1) unsigned zerofill DEFAULT '1' COMMENT '是否主导航 0是  1否',
  `name` varchar(64) DEFAULT NULL COMMENT '菜单分类名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_menu_category
-- ----------------------------
INSERT INTO `fcms_menu_category` VALUES ('1', '2016-03-14 17:22:46', '2016-03-30 10:50:25', '0', '主导航', '0', '前台主菜单');

-- ----------------------------
-- Table structure for fcms_payment
-- ----------------------------
DROP TABLE IF EXISTS `fcms_payment`;
CREATE TABLE `fcms_payment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) DEFAULT '0',
  `descr` varchar(256) DEFAULT NULL COMMENT '支付描述',
  `name` varchar(128) DEFAULT '' COMMENT '支付名称',
  `config` text COMMENT '支付配置',
  `img` varchar(256) DEFAULT NULL COMMENT '支付图片',
  `style` tinyint(1) DEFAULT '0' COMMENT '支付方式  0 货到付款 1 在线支付',
  `sort` smallint(5) DEFAULT NULL,
  `fee` varchar(10) DEFAULT NULL COMMENT '支付的费率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_payment
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_pri_groups
-- ----------------------------
DROP TABLE IF EXISTS `fcms_pri_groups`;
CREATE TABLE `fcms_pri_groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT NULL,
  `shopid` bigint(20) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fcms_pri_groups
-- ----------------------------
INSERT INTO `fcms_pri_groups` VALUES ('1', '2016-03-03 13:54:31', '2016-03-03 13:54:31', '0', null, '0', '超级管理员');

-- ----------------------------
-- Table structure for fcms_pri_groups_roles
-- ----------------------------
DROP TABLE IF EXISTS `fcms_pri_groups_roles`;
CREATE TABLE `fcms_pri_groups_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `roleid` bigint(20) NOT NULL,
  `groupid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=221 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of fcms_pri_groups_roles
-- ----------------------------
INSERT INTO `fcms_pri_groups_roles` VALUES ('1', '2015-07-28 15:43:28', '0', '1', '1');

-- ----------------------------
-- Table structure for fcms_pri_pris
-- ----------------------------
DROP TABLE IF EXISTS `fcms_pri_pris`;
CREATE TABLE `fcms_pri_pris` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT '' COMMENT '可以用作菜单的icon',
  `name` varchar(64) DEFAULT '' COMMENT 'module name controller name action name ',
  `pid` bigint(20) NOT NULL DEFAULT '0' COMMENT '显示菜单的父id',
  `display` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 for not display 1 for display ',
  `src` varchar(64) DEFAULT '' COMMENT 'action, controller, module',
  `sort` tinyint(3) DEFAULT '0' COMMENT '排序',
  `loadmode` tinyint(1) NOT NULL DEFAULT '0' COMMENT '加载模式, 0:异步(存在了不加载）， 1： 同步（强制刷新）',
  `type` tinyint(16) DEFAULT '0' COMMENT '0:操作 1：控制器  2 ： 模块  3:只是菜单',
  `apid` int(11) DEFAULT '0' COMMENT 'action controller module 的关系 apid代表 上一级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fcms_pri_pris
-- ----------------------------
INSERT INTO `fcms_pri_pris` VALUES ('1', '2015-06-15 14:53:33', '2015-06-15 14:53:35', '0', '', '管理后台', '0', '0', ' ', '0', '0', '0', '0');
INSERT INTO `fcms_pri_pris` VALUES ('2', '2015-06-15 14:54:44', '2016-03-14 15:41:10', '0', null, '后台首页', '1', '1', 'index', '0', '0', '0', '171');
INSERT INTO `fcms_pri_pris` VALUES ('3', '2015-06-15 14:56:19', '2016-03-14 14:52:40', '0', null, '权限管理', '1', '1', '_privilege', '0', '0', '0', '184');
INSERT INTO `fcms_pri_pris` VALUES ('4', '2015-06-15 14:57:32', '2015-06-15 14:57:33', '0', null, '用户', '3', '1', 'index', '0', '1', '0', '189');
INSERT INTO `fcms_pri_pris` VALUES ('5', '2015-06-15 14:58:32', '2015-06-15 14:58:33', '0', null, '删除用户', '4', '0', 'delete', '0', '0', '0', '189');
INSERT INTO `fcms_pri_pris` VALUES ('6', '2015-06-15 15:02:46', '2015-06-15 15:02:48', '0', null, '新增用户', '4', '0', 'add', '0', '0', '0', '189');
INSERT INTO `fcms_pri_pris` VALUES ('7', '2015-06-15 15:04:36', '2015-06-15 15:04:38', '0', null, '编辑用户', '4', '0', 'edit', '0', '0', '0', '189');
INSERT INTO `fcms_pri_pris` VALUES ('9', '2015-07-08 10:36:46', '2015-07-08 10:36:50', '0', '', '用户组', '3', '1', 'index', '0', '0', '0', '164');
INSERT INTO `fcms_pri_pris` VALUES ('10', '2015-07-09 13:33:10', '2015-07-09 13:33:14', '0', '', '删除用户组', '9', '0', 'delete', '0', '0', '0', '164');
INSERT INTO `fcms_pri_pris` VALUES ('11', '2015-07-09 13:39:16', '2015-07-09 13:39:19', '0', '', '新增用户组', '9', '0', 'add', '0', '0', '0', '164');
INSERT INTO `fcms_pri_pris` VALUES ('12', '2015-07-09 13:40:16', '2015-07-09 13:40:18', '0', '', '编辑用户组', '9', '0', 'edit', '0', '0', '0', '164');
INSERT INTO `fcms_pri_pris` VALUES ('13', '2015-07-09 13:42:04', '2015-07-09 13:42:06', '0', '', '角色', '3', '1', 'index', '0', '0', '0', '172');
INSERT INTO `fcms_pri_pris` VALUES ('14', '2015-07-10 10:02:02', '2015-07-10 10:02:03', '0', '', '删除角色', '13', '0', 'delete', '0', '0', '0', '172');
INSERT INTO `fcms_pri_pris` VALUES ('15', '2015-07-10 10:02:30', '2015-07-10 10:02:33', '0', '', '新增角色', '13', '0', 'add', '0', '0', '0', '172');
INSERT INTO `fcms_pri_pris` VALUES ('16', '2015-07-10 10:03:02', '2015-07-10 10:03:04', '0', '', '编辑角色', '13', '0', 'edit', '0', '0', '0', '172');
INSERT INTO `fcms_pri_pris` VALUES ('19', '2015-07-13 09:59:36', '2015-07-13 09:59:39', '0', '', '检验用户名', '4', '0', 'checkloginname', '0', '0', '0', '189');
INSERT INTO `fcms_pri_pris` VALUES ('25', '2015-07-17 09:27:33', '2015-07-17 09:27:35', '0', '', '更新用户', '4', '0', 'update', '0', '0', '0', '189');
INSERT INTO `fcms_pri_pris` VALUES ('26', '2015-07-17 09:28:39', '2015-07-17 09:28:41', '0', '', '更新用户组', '9', '0', 'update', '0', '0', '0', '164');
INSERT INTO `fcms_pri_pris` VALUES ('27', '2015-07-17 09:29:09', '2015-07-17 09:29:05', '0', '', '更新角色', '13', '0', 'update', '0', '0', '0', '172');
INSERT INTO `fcms_pri_pris` VALUES ('37', '2015-07-23 10:06:18', '2015-07-23 10:06:24', '1', 'user', '会员管理', '1', '1', 'membersmanager', '0', '0', '0', null);
INSERT INTO `fcms_pri_pris` VALUES ('38', '2015-07-23 10:07:21', '2015-07-23 10:07:25', '1', '', '会员', '37', '0', 'members', '0', '0', '0', null);
INSERT INTO `fcms_pri_pris` VALUES ('39', '2015-07-23 10:08:18', '2015-07-23 10:08:21', '1', '', '删除会员', '38', '0', 'delete', '0', '0', '0', null);
INSERT INTO `fcms_pri_pris` VALUES ('47', '2015-07-27 09:47:58', '2015-07-27 09:47:59', '0', 'file', '文章管理', '1', '1', '_article', '0', '0', '3', '184');
INSERT INTO `fcms_pri_pris` VALUES ('48', '2015-07-27 09:50:09', '2015-07-27 09:50:07', '0', '', '文章分类', '47', '1', 'index', '0', '0', '0', '173');
INSERT INTO `fcms_pri_pris` VALUES ('49', '2015-07-27 09:50:15', '2015-07-27 09:50:16', '0', '', '文章', '47', '1', 'index', '0', '1', '0', '174');
INSERT INTO `fcms_pri_pris` VALUES ('50', '2015-07-28 10:46:59', '2015-07-28 10:47:02', '0', '', '删除分类', '48', '0', 'delete', '0', '0', '0', '173');
INSERT INTO `fcms_pri_pris` VALUES ('51', '2015-07-28 10:48:05', '2015-07-28 10:48:07', '0', '', '新增分类', '48', '0', 'add', '0', '0', '0', '173');
INSERT INTO `fcms_pri_pris` VALUES ('52', '2015-07-28 10:48:37', '2015-07-28 10:48:38', '0', '', '编辑分类', '48', '0', 'edit', '0', '0', '0', '173');
INSERT INTO `fcms_pri_pris` VALUES ('53', '2015-07-28 10:49:00', '2015-07-28 10:49:03', '0', '', '删除文章', '49', '0', 'delete', '0', '0', '0', '174');
INSERT INTO `fcms_pri_pris` VALUES ('54', '2015-07-28 10:50:16', '2015-07-28 10:50:17', '0', '', '新增文章', '49', '0', 'add', '0', '0', '0', '174');
INSERT INTO `fcms_pri_pris` VALUES ('55', '2015-07-28 10:52:36', '2015-07-28 10:52:38', '0', '', '编辑文章', '49', '0', 'edit', '0', '0', '0', '174');
INSERT INTO `fcms_pri_pris` VALUES ('60', '2015-08-11 10:12:28', '2015-08-11 10:12:30', '1', 'picture-o', '图片管理', '1', '1', 'index', '0', '0', '0', '175');
INSERT INTO `fcms_pri_pris` VALUES ('61', '2015-08-24 14:12:44', '2015-08-24 14:12:51', '1', 'table', '广告管理', '1', '1', '_ad', '0', '0', '0', '184');
INSERT INTO `fcms_pri_pris` VALUES ('62', '2015-08-24 14:14:51', '2015-08-24 14:14:56', '1', '', '广告分类', '61', '1', 'index', '0', '0', '0', '177');
INSERT INTO `fcms_pri_pris` VALUES ('63', '2015-08-24 14:16:39', '2015-08-24 14:16:42', '1', '', '广告', '61', '1', 'index', '0', '0', '0', '176');
INSERT INTO `fcms_pri_pris` VALUES ('64', '2015-08-27 13:57:21', '2015-08-27 13:57:28', '0', '', '删除分类', '62', '0', 'delete', '0', '0', '0', '177');
INSERT INTO `fcms_pri_pris` VALUES ('65', '2015-08-27 13:57:35', '2015-08-27 13:57:40', '0', '', '新增分类', '62', '0', 'add', '0', '0', '0', '177');
INSERT INTO `fcms_pri_pris` VALUES ('66', '2015-08-27 13:57:51', '2015-08-27 13:57:51', '0', '', '编辑分类', '62', '0', 'edit', '0', '0', '0', '177');
INSERT INTO `fcms_pri_pris` VALUES ('67', '2015-08-27 13:57:51', '2015-08-27 13:57:51', '0', '', '删除广告', '63', '0', 'delete', '0', '0', '0', '176');
INSERT INTO `fcms_pri_pris` VALUES ('68', '2015-08-27 13:57:51', '2015-08-27 13:57:51', '0', '', '新增广告', '63', '0', 'add', '0', '0', '0', '176');
INSERT INTO `fcms_pri_pris` VALUES ('69', '2015-08-27 13:57:51', '2015-08-27 13:57:51', '0', '', '编辑广告', '63', '0', 'edit', '0', '0', '0', '176');
INSERT INTO `fcms_pri_pris` VALUES ('76', '2015-08-28 13:53:43', '2015-08-28 13:53:45', '0', 'cog', '系统配置', '1', '1', 'index', '0', '0', '0', '178');
INSERT INTO `fcms_pri_pris` VALUES ('78', '2015-08-31 16:37:03', '2015-08-28 16:37:06', '1', '', '通信配置', '76', '1', 'cmm', '0', '0', '0', '178');
INSERT INTO `fcms_pri_pris` VALUES ('79', '2015-08-31 14:18:58', '2015-08-31 14:19:00', '1', '', 'seo配置', '76', '1', 'seo', '0', '0', '0', '178');
INSERT INTO `fcms_pri_pris` VALUES ('80', '2015-09-02 15:31:14', '2015-09-02 15:31:16', '1', 'wrench', '安全中心', '1', '1', '_security', '0', '0', '0', '184');
INSERT INTO `fcms_pri_pris` VALUES ('81', '2015-09-02 15:32:01', '2015-09-02 15:32:03', '1', '', '文件安全', '80', '1', 'file', '0', '0', '0', '179');
INSERT INTO `fcms_pri_pris` VALUES ('82', '2015-09-02 15:33:38', '2015-09-02 15:33:40', '0', '', '全站扫描', '81', '0', 'scanWebSite', '0', '0', '0', '179');
INSERT INTO `fcms_pri_pris` VALUES ('83', '2015-09-02 15:33:49', '2015-09-02 15:33:51', '0', '', '异常扫描', '81', '0', 'scanAbnormal', '0', '0', '0', '179');
INSERT INTO `fcms_pri_pris` VALUES ('84', '2015-09-02 15:34:21', '2015-09-02 15:34:24', '0', '', '异常文件', '81', '0', 'abnomalList', '0', '0', '0', '179');
INSERT INTO `fcms_pri_pris` VALUES ('85', '2015-09-02 15:35:25', '2015-09-02 15:35:27', '0', '', '处理异常', '81', '0', 'handle', '0', '0', '0', '179');
INSERT INTO `fcms_pri_pris` VALUES ('93', '2015-09-16 16:19:36', '2015-09-16 16:19:39', '0', '', '缓存管理', '1', '1', '_cache', '0', '0', '0', '184');
INSERT INTO `fcms_pri_pris` VALUES ('94', '2015-09-16 16:25:51', '2015-09-16 16:25:54', '1', '', '添加缓存', '141', '0', 'add', '0', '0', '0', '181');
INSERT INTO `fcms_pri_pris` VALUES ('95', '2015-09-16 16:27:25', '2015-09-16 16:27:28', '1', '', '编辑缓存', '141', '0', 'edit', '0', '0', '0', '181');
INSERT INTO `fcms_pri_pris` VALUES ('96', '2015-09-16 16:27:30', '2015-09-16 16:27:33', '1', '', '删除缓存', '141', '0', 'delete', '0', '0', '0', '181');
INSERT INTO `fcms_pri_pris` VALUES ('97', '2015-09-18 16:47:33', '2015-09-18 16:47:35', '1', '', '部门', '3', '1', 'departments', '0', '0', '0', null);
INSERT INTO `fcms_pri_pris` VALUES ('98', '2015-09-25 16:50:33', '2015-09-18 16:50:36', '1', '', '添加部门', '97', '0', 'add', '0', '0', '0', null);
INSERT INTO `fcms_pri_pris` VALUES ('99', '2015-09-18 16:51:42', '2015-09-18 16:51:45', '1', '', '编辑部门', '97', '0', 'edit', '0', '0', '0', null);
INSERT INTO `fcms_pri_pris` VALUES ('100', '2015-09-18 16:52:38', '2015-09-18 16:52:41', '1', '', '删除部门', '97', '0', 'delete', '0', '0', '0', null);
INSERT INTO `fcms_pri_pris` VALUES ('109', '2015-10-15 17:13:13', '2015-10-15 17:13:17', '1', '', '敏感词管理', '76', '1', 'index', '0', '0', '0', '190');
INSERT INTO `fcms_pri_pris` VALUES ('110', '2015-10-15 17:14:10', '2015-10-15 17:14:12', '0', '', 'Tags管理', '47', '1', 'index', '0', '0', '0', '185');
INSERT INTO `fcms_pri_pris` VALUES ('111', '2015-10-15 17:15:02', '2015-10-15 17:15:04', '1', '', '添加敏感词', '109', '0', 'add', '0', '0', '0', '178');
INSERT INTO `fcms_pri_pris` VALUES ('112', '2015-10-15 17:16:13', '2015-10-15 17:16:15', '1', '', '删除敏感词', '109', '0', 'delete', '0', '0', '0', '178');
INSERT INTO `fcms_pri_pris` VALUES ('113', '2015-10-15 17:17:06', '2015-10-15 17:17:03', '1', '', '修改敏感词', '109', '0', 'replace', '0', '0', '0', '178');
INSERT INTO `fcms_pri_pris` VALUES ('114', '2015-10-15 17:18:35', '2015-10-15 17:18:37', '0', '', 'tag更新', '110', '0', 'optionPage', '0', '0', '0', '185');
INSERT INTO `fcms_pri_pris` VALUES ('115', '2015-10-15 17:19:23', '2015-10-15 17:19:24', '0', '', 'tag删除', '110', '0', 'delete', '0', '0', '0', '185');
INSERT INTO `fcms_pri_pris` VALUES ('116', '2015-10-20 16:27:29', '2015-10-20 16:27:31', '0', 'list', '菜单管理', '1', '1', '_menu', '0', '0', '0', '184');
INSERT INTO `fcms_pri_pris` VALUES ('117', '2015-10-20 16:28:03', '2015-10-20 16:28:05', '0', '', '前台菜单', '116', '1', 'frontend', '0', '0', '0', '186');
INSERT INTO `fcms_pri_pris` VALUES ('118', '2015-10-20 16:29:38', '2015-10-20 16:29:40', '1', '', '后端菜单', '116', '1', 'backend', '0', '0', '0', '186');
INSERT INTO `fcms_pri_pris` VALUES ('119', '2015-10-20 16:40:07', '2015-10-20 16:40:09', '0', '', '菜单分类', '117', '0', 'category', '0', '0', '0', '186');
INSERT INTO `fcms_pri_pris` VALUES ('120', '2015-10-22 13:22:59', '2015-10-22 13:23:18', '0', '', '添加菜单分类', '117', '0', 'addCategory', '0', '0', '0', '186');
INSERT INTO `fcms_pri_pris` VALUES ('121', '2015-10-22 13:23:02', '2015-10-22 13:23:21', '0', '', '更新菜单分类', '117', '0', 'upcmenus', '0', '0', '0', '186');
INSERT INTO `fcms_pri_pris` VALUES ('122', '2015-10-22 13:23:05', '2015-10-22 13:23:24', '0', '', '删除菜单分类', '117', '0', 'delete', '0', '0', '0', '186');
INSERT INTO `fcms_pri_pris` VALUES ('123', '2015-10-22 13:23:08', '2015-10-22 13:23:27', '0', '', '添加菜单', '117', '0', 'addmenus', '0', '0', '0', '186');
INSERT INTO `fcms_pri_pris` VALUES ('124', '2015-10-22 13:23:12', '2015-10-22 13:23:29', '0', '', '更新菜单', '117', '0', 'upmenus', '0', '0', '0', '186');
INSERT INTO `fcms_pri_pris` VALUES ('125', '2015-10-22 13:23:15', '2015-10-22 13:23:32', '0', '', '删除菜单', '117', '0', 'delete', '0', '0', '0', '186');
INSERT INTO `fcms_pri_pris` VALUES ('126', '2015-10-22 14:09:44', '2015-10-22 14:09:46', '0', '', '站点管理', '76', '1', 'index', '0', '0', '0', '188');
INSERT INTO `fcms_pri_pris` VALUES ('127', '2015-10-22 17:11:43', '2015-10-22 17:11:45', '0', 'cloud', '扩展工具', '1', '1', '_tools', '0', '0', '0', '184');
INSERT INTO `fcms_pri_pris` VALUES ('128', '2015-10-22 17:16:51', '2015-10-22 17:16:53', '0', '', '友情链接', '127', '1', 'index', '0', '0', '0', '183');
INSERT INTO `fcms_pri_pris` VALUES ('129', '2015-10-22 17:17:40', '2015-10-22 17:17:42', '1', '', '备份中心', '127', '1', 'backup', '0', '0', '0', null);
INSERT INTO `fcms_pri_pris` VALUES ('130', '2015-10-23 09:20:48', '2015-10-23 09:20:51', '0', '', '添加站点', '126', '0', 'addsite', '0', '0', '0', '188');
INSERT INTO `fcms_pri_pris` VALUES ('131', '2015-10-23 09:21:31', '2015-10-23 09:21:33', '0', '', '修改站点', '126', '0', 'upsiteinfo', '0', '0', '0', '188');
INSERT INTO `fcms_pri_pris` VALUES ('132', '2015-10-23 09:22:11', '2015-10-23 09:22:13', '0', '', '删除站点', '126', '0', 'delete', '0', '0', '0', '188');
INSERT INTO `fcms_pri_pris` VALUES ('133', '2015-10-23 09:22:47', '2015-10-23 09:22:48', '0', '', '添加友链', '128', '0', 'add', '0', '0', '0', '183');
INSERT INTO `fcms_pri_pris` VALUES ('134', '2015-10-23 09:23:27', '2015-10-23 09:23:28', '0', '', '更新友链', '128', '0', 'update', '0', '0', '0', '183');
INSERT INTO `fcms_pri_pris` VALUES ('135', '2015-10-23 09:23:52', '2015-10-23 09:23:55', '0', '', '删除友链', '128', '0', 'update', '0', '0', '0', '183');
INSERT INTO `fcms_pri_pris` VALUES ('141', '2015-11-13 16:00:16', '2015-11-13 16:00:18', '1', '', '应用缓存', '93', '1', 'index', '0', '0', '0', '181');
INSERT INTO `fcms_pri_pris` VALUES ('142', '2015-11-13 16:01:34', '2015-11-13 16:01:36', '1', '', '页面缓存', '93', '1', 'index', '0', '0', '0', '169');
INSERT INTO `fcms_pri_pris` VALUES ('143', '2015-11-13 16:02:04', '2015-11-13 16:02:07', '1', '', '添加缓存', '142', '0', 'add', '0', '0', '0', '169');
INSERT INTO `fcms_pri_pris` VALUES ('144', '2015-11-13 16:03:24', '2015-11-13 16:03:28', '1', '', '更新缓存', '142', '0', 'update', '0', '0', '0', '169');
INSERT INTO `fcms_pri_pris` VALUES ('145', '2015-11-13 16:03:52', '2015-11-13 16:03:54', '1', '', '删除缓存', '142', '0', 'delete', '0', '0', '0', '169');
INSERT INTO `fcms_pri_pris` VALUES ('146', '2015-11-13 16:04:17', '2015-11-13 16:04:19', '0', '', '静态化', '93', '1', 'column', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('147', '2015-11-13 16:05:27', '2015-11-13 16:05:29', '1', '', '自动化配置', '146', '0', 'index', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('148', '2015-11-13 16:06:02', '2015-11-13 16:06:03', '0', '', '栏目配置', '146', '0', 'column', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('149', '2015-11-13 16:06:33', '2015-11-13 16:06:34', '0', '', '列表配置', '146', '0', 'list', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('150', '2015-11-13 16:06:53', '2015-11-13 16:06:55', '0', '', '详细页配置', '146', '0', 'detail', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('151', '2015-11-13 16:07:27', '2015-11-13 16:07:28', '0', '', '配置项处理', '146', '0', 'optcolumn', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('152', '2015-11-13 16:09:22', '2015-11-13 16:09:24', '0', '', '配置项删除', '146', '0', 'delcolumn', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('153', '2015-11-13 16:07:27', '2015-11-13 16:07:28', '0', '', '配置项处理', '146', '0', 'optlist', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('154', '2015-11-13 16:09:22', '2015-11-13 16:09:24', '0', '', '配置项删除', '146', '0', 'dellist', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('155', '2015-11-13 16:07:27', '2015-11-13 16:07:28', '0', '', '配置项处理', '146', '0', 'optdetail', '0', '0', '0', '168');
INSERT INTO `fcms_pri_pris` VALUES ('157', '2015-11-18 15:16:14', '2015-11-18 15:16:15', '1', '', '系统主页配置', '76', '1', 'index', '0', '0', '0', '167');
INSERT INTO `fcms_pri_pris` VALUES ('158', '2015-11-18 15:16:43', '2015-11-18 15:16:44', '1', '', '系统主页操作', '157', '0', 'opt', '0', '0', '0', '167');
INSERT INTO `fcms_pri_pris` VALUES ('159', '2015-11-18 15:17:26', '2015-11-18 15:17:28', '1', '', '删除主页配置', '157', '0', 'delete', '0', '0', '0', '167');
INSERT INTO `fcms_pri_pris` VALUES ('160', '2015-12-24 14:27:13', '2015-12-28 10:02:12', '0', '', '文章回收站', '47', '1', 'index', '0', '1', '0', '187');
INSERT INTO `fcms_pri_pris` VALUES ('161', '2016-01-21 14:51:48', '2016-01-21 14:51:51', '1', '', '示例页面', '1', '1', 'demo', '0', '0', '0', '171');
INSERT INTO `fcms_pri_pris` VALUES ('162', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'admin', '0', '0', '2', '0');
INSERT INTO `fcms_pri_pris` VALUES ('163', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'oa', '0', '0', '2', '0');
INSERT INTO `fcms_pri_pris` VALUES ('164', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'groups', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('165', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'privilege', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('167', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'sysindex', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('168', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'staticcache', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('169', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'pagecache', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('170', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'backup', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('171', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'index', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('172', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'roles', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('173', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'articlecats', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('174', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'articles', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('175', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'images', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('176', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'ad', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('177', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'adcats', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('178', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'config', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('179', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'security', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('180', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'menu', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('181', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'cache', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('183', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'friendlink', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('184', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', '_backmenu', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('185', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'articlestags', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('186', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'menu', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('187', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'articletrash', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('188', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'sitesetting', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('189', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'users', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('190', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'sensitive', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('191', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', '', '首页展示', '2', '1', 'show', '0', '0', '0', '171');
INSERT INTO `fcms_pri_pris` VALUES ('192', '0000-00-00 00:00:00', '2016-03-14 17:12:31', '0', null, '权限项', '3', '1', 'index', '0', '0', '0', '165');
INSERT INTO `fcms_pri_pris` VALUES ('193', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '删除权限项', '192', '0', 'delete', '0', '0', '0', '165');
INSERT INTO `fcms_pri_pris` VALUES ('194', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '添加权限项', '192', '0', 'add', '0', '0', '0', '165');
INSERT INTO `fcms_pri_pris` VALUES ('195', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '编辑权限项', '192', '0', 'edit', '0', '0', '0', '165');
INSERT INTO `fcms_pri_pris` VALUES ('197', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '幻灯片', '127', '1', '_slide', '0', '0', '3', '184');
INSERT INTO `fcms_pri_pris` VALUES ('198', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'slide', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('199', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '', '0', '0', 'slidegroup', '0', '0', '1', '162');
INSERT INTO `fcms_pri_pris` VALUES ('200', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '幻灯片管理', '197', '1', 'index', '0', '0', '0', '198');
INSERT INTO `fcms_pri_pris` VALUES ('201', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '', '幻灯片组管理', '197', '1', 'index', '0', '0', '0', '199');
INSERT INTO `fcms_pri_pris` VALUES ('204', '2016-03-28 15:02:00', '2016-03-28 15:02:00', '1', '', 'test', '1', '0', 'test', '0', '0', '0', '171');
INSERT INTO `fcms_pri_pris` VALUES ('205', '2016-03-28 16:58:10', '2016-03-28 16:58:10', '1', '', 'test', '1', '0', '_56f8f222b5a48', '0', '0', '3', '184');
INSERT INTO `fcms_pri_pris` VALUES ('206', '2016-03-29 09:36:13', '2016-03-29 09:36:13', '1', '', '123', '1', '0', '_56f9dc0d39857', '0', '0', '3', '184');
INSERT INTO `fcms_pri_pris` VALUES ('207', '2016-03-29 10:03:33', '2016-03-29 10:03:33', '1', '', 'a', '1', '0', '_56f9e275ceb76', '0', '0', '3', '184');
INSERT INTO `fcms_pri_pris` VALUES ('208', '2016-03-29 10:12:44', '2016-03-29 10:12:44', '1', '', 'tt', '1', '0', '_56f9e49c10923', '0', '0', '3', '184');

-- ----------------------------
-- Table structure for fcms_pri_roles
-- ----------------------------
DROP TABLE IF EXISTS `fcms_pri_roles`;
CREATE TABLE `fcms_pri_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `descr` varchar(256) DEFAULT '',
  `shopid` bigint(20) DEFAULT NULL COMMENT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fcms_pri_roles
-- ----------------------------
INSERT INTO `fcms_pri_roles` VALUES ('1', '2015-07-08 12:08:19', '2016-03-01 15:29:46', '0', '所有权限', '0', 'superadmin');

-- ----------------------------
-- Table structure for fcms_pri_roles_pris
-- ----------------------------
DROP TABLE IF EXISTS `fcms_pri_roles_pris`;
CREATE TABLE `fcms_pri_roles_pris` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL,
  `delsign` tinyint(1) NOT NULL,
  `roleid` bigint(20) NOT NULL,
  `priid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_pri_roles_pris
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_pri_site_setting
-- ----------------------------
DROP TABLE IF EXISTS `fcms_pri_site_setting`;
CREATE TABLE `fcms_pri_site_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `name` varchar(128) DEFAULT NULL COMMENT '网站名称',
  `domain` varchar(64) DEFAULT NULL COMMENT '网站域名',
  `logo` varchar(128) DEFAULT NULL COMMENT '网站logo',
  `seokey` varchar(64) DEFAULT NULL COMMENT 'seo关键字',
  `seodescr` varchar(255) DEFAULT NULL COMMENT 'seo描述',
  `copyright` varchar(255) DEFAULT NULL COMMENT '版权',
  `static_code` text COMMENT '统计访问代码',
  `is_main` tinyint(1) unsigned DEFAULT '1' COMMENT '是否是默认 0 是 1否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_pri_site_setting
-- ----------------------------
INSERT INTO `fcms_pri_site_setting` VALUES ('1', '2016-03-28 14:33:06', '2016-03-28 14:33:06', '0', '0', 'FCMS', 'www.huaersc.com', '/upload/image/user/1/20160331/1459414039100784.png', '', '', 'FCMS', '', '0');

-- ----------------------------
-- Table structure for fcms_pri_users
-- ----------------------------
DROP TABLE IF EXISTS `fcms_pri_users`;
CREATE TABLE `fcms_pri_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `addtime` datetime DEFAULT NULL,
  `uptime` datetime DEFAULT NULL,
  `delsign` tinyint(1) DEFAULT '0',
  `descr` varchar(256) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `nickname` varchar(128) DEFAULT NULL,
  `loginname` varchar(128) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `pwd` varchar(64) NOT NULL COMMENT 'password',
  `email` varchar(64) NOT NULL,
  `shopid` bigint(20) DEFAULT NULL,
  `groupid` bigint(20) DEFAULT NULL,
  `forget_code` varchar(16) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0 for ok 1 for lock 2 for delete 3 for forget password',
  `avatar` varchar(64) DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表格';

-- ----------------------------
-- Records of fcms_pri_users
-- ----------------------------
INSERT INTO `fcms_pri_users` VALUES ('1', null, '2016-03-26 10:14:25', '0', null, 'admin', 'admin', 'admin', null, 'e10adc3949ba59abbe56e057f20f883e', 'admin@admin.com', null, '1', null, '0', null);

-- ----------------------------
-- Table structure for fcms_sec_file
-- ----------------------------
DROP TABLE IF EXISTS `fcms_sec_file`;
CREATE TABLE `fcms_sec_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `filename` varchar(128) DEFAULT NULL COMMENT '异常文件名称',
  `hashname` varchar(180) DEFAULT NULL COMMENT '加密文件名称',
  `filepath` varchar(180) DEFAULT NULL COMMENT '异常文件所处位置',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '处理状态 1处理 0未处理',
  `descr` varchar(256) DEFAULT '0' COMMENT '备注信息',
  `addtime` datetime NOT NULL COMMENT '文件扫描时间',
  `opttime` datetime DEFAULT NULL COMMENT '异常文件处理时间',
  `uptime` datetime DEFAULT NULL COMMENT '手动扫描时 文件异常时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fname` (`filename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_sec_file
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_sens_wd
-- ----------------------------
DROP TABLE IF EXISTS `fcms_sens_wd`;
CREATE TABLE `fcms_sens_wd` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `word` varchar(64) DEFAULT NULL COMMENT '敏感词',
  `rword` varchar(32) DEFAULT NULL,
  `uid` int(20) unsigned DEFAULT NULL COMMENT '添加人',
  `descr` varchar(256) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_sens_wd
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_slide
-- ----------------------------
DROP TABLE IF EXISTS `fcms_slide`;
CREATE TABLE `fcms_slide` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '幻灯片图片id',
  `addtime` datetime NOT NULL,
  `uptime` datetime NOT NULL,
  `title` varchar(256) DEFAULT NULL COMMENT '幻灯片标题',
  `content` varchar(256) DEFAULT NULL COMMENT '幻灯片简介',
  `delsign` tinyint(1) unsigned NOT NULL COMMENT '删除标记',
  `descr` varchar(256) DEFAULT NULL COMMENT '数据描述',
  `sort` bigint(20) unsigned DEFAULT '1' COMMENT '幻灯片排序，默认值为1，为1时按id排序',
  `groupid` bigint(20) NOT NULL,
  `width` int(10) unsigned DEFAULT NULL COMMENT '幻灯片宽度',
  `height` int(10) unsigned DEFAULT NULL COMMENT '幻灯片高度',
  `dir` varchar(256) NOT NULL COMMENT '幻灯片保存路径',
  `url` varchar(256) DEFAULT NULL COMMENT '链接',
  `alt` varchar(256) DEFAULT NULL COMMENT '图片hover时显示内容',
  `nofollow` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `isshow` tinyint(1) unsigned NOT NULL COMMENT '是否显示该幻灯片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fcms_slide
-- ----------------------------
INSERT INTO `fcms_slide` VALUES ('13', '0000-00-00 00:00:00', '2016-03-31 16:09:16', '', '', '0', null, '50', '1', '1680', '500', '/public/upload/image/user/1/20160331/1459410576381691.png', '', 'FCMS 0.1 上线', '1', '1');
INSERT INTO `fcms_slide` VALUES ('14', '0000-00-00 00:00:00', '2016-03-31 16:09:22', '', '', '0', null, '48', '1', '1680', '500', '/upload/image/user/1/20160331/1459410942489056.png', '', 'FCMS 0.1a 上线', '1', '1');
INSERT INTO `fcms_slide` VALUES ('15', '0000-00-00 00:00:00', '2016-03-31 16:09:08', '', '', '0', null, '49', '1', '1680', '500', '/upload/image/user/1/20160331/1459410818105866.png', '', 'FCMS 0.1a 上线', '1', '1');

-- ----------------------------
-- Table structure for fcms_slide_group
-- ----------------------------
DROP TABLE IF EXISTS `fcms_slide_group`;
CREATE TABLE `fcms_slide_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '幻灯片图片表id',
  `addtime` datetime NOT NULL COMMENT '添加时间',
  `uptime` datetime NOT NULL COMMENT '修改时间',
  `delsign` tinyint(1) unsigned NOT NULL COMMENT '删除标记',
  `descr` varchar(256) DEFAULT NULL COMMENT '数据描述',
  `name` varchar(128) NOT NULL COMMENT '幻灯片分组名称',
  `type` tinyint(1) unsigned NOT NULL COMMENT '幻灯片类型（1为图片，2为视频，3为flash）',
  `width` int(10) unsigned DEFAULT NULL COMMENT '幻灯片宽度',
  `height` int(10) unsigned DEFAULT NULL COMMENT '幻灯片高度',
  `size` int(10) unsigned NOT NULL COMMENT '幻灯片尺寸',
  `islimit` tinyint(1) unsigned NOT NULL COMMENT '是否限制宽高（1为限制，0为不限制）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fcms_slide_group
-- ----------------------------
INSERT INTO `fcms_slide_group` VALUES ('1', '2016-03-31 15:26:55', '2016-03-31 15:26:55', '0', null, '示例幻灯片', '1', '1680', '500', '0', '1');

-- ----------------------------
-- Table structure for fcms_system_dic
-- ----------------------------
DROP TABLE IF EXISTS `fcms_system_dic`;
CREATE TABLE `fcms_system_dic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `title` varchar(128) DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` mediumtext,
  `valtype` tinyint(4) DEFAULT '0' COMMENT '0 int 1 float 2 string',
  `kind` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_system_dic
-- ----------------------------

-- ----------------------------
-- Table structure for fcms_sys_index_cfg
-- ----------------------------
DROP TABLE IF EXISTS `fcms_sys_index_cfg`;
CREATE TABLE `fcms_sys_index_cfg` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `addtime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `uptime` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `delsign` tinyint(1) NOT NULL DEFAULT '0',
  `descr` varchar(256) DEFAULT '0',
  `name` varchar(32) DEFAULT NULL COMMENT '标题',
  `icon` varchar(64) DEFAULT NULL COMMENT '小图标',
  `color` varchar(32) DEFAULT NULL COMMENT '颜色',
  `line` int(10) unsigned DEFAULT NULL COMMENT '行数',
  `size` int(2) unsigned NOT NULL DEFAULT '0' COMMENT '模块大小',
  `display` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否显示  0 显示  1 不显示',
  `groupid` bigint(20) unsigned DEFAULT NULL COMMENT '用户组id',
  `sort` bigint(20) unsigned DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of fcms_sys_index_cfg
-- ----------------------------
