/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50614
Source Host           : localhost:3306
Source Database       : onlinebookshop

Target Server Type    : MYSQL
Target Server Version : 50614
File Encoding         : 65001

Date: 2017-05-13 08:43:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) DEFAULT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `addressdetail` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fkuserid` (`user_id`),
  CONSTRAINT `fkuserid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('18', 'aaa', '小明', '浙江财经大学', '123456');
INSERT INTO `address` VALUES ('19', 'bbb', '小红', '浙江工商大学', '9999');
INSERT INTO `address` VALUES ('20', 'bbb', '小红22', '浙江工商大学', '789');
INSERT INTO `address` VALUES ('21', 'bbb', '周杰伦', '直接来找我', '110');
INSERT INTO `address` VALUES ('23', '2', '测试', '测试', '213123');
INSERT INTO `address` VALUES ('24', '5', '我你你', '亲亲我', '123');
INSERT INTO `address` VALUES ('25', '6', 'as ', 'wq ', '2');
INSERT INTO `address` VALUES ('26', '7', 'w ', 's', '1');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('admin', '123');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` double(11,0) DEFAULT NULL,
  `price2` double(11,0) DEFAULT NULL,
  `ifkill` int(11) DEFAULT '0',
  `description` varchar(9000) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `clickcount` int(11) DEFAULT '0',
  `salecount` int(11) DEFAULT '0',
  `bookdown` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fkshopid` (`shop_id`),
  CONSTRAINT `fkshopid` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('67', 'java编程思想', '20', '10', '1', '在有关算法的书中，有一些叙述非常严谨，但不够全面；另一些涉及了大量的题材，但又缺乏严谨性。本书将严谨性和全面性融为一体，深入讨论各类算法，并着力使这些算法的设计和分析能为各个层次的读者接受。全书各章自成体系，可以作为独立的学习单元；算法以英语和伪代码的形式描述，具备初步程序设计经验的人就能看懂；说明和解释力求浅显易懂，不失深度和数学严谨性。\r\n《算法导论(原书第3版)》选材经典、内容丰富、结构合理、逻辑清晰，对本科生的数据结构课程和研究生的算法课程都是非常实用的教材，在IT专业人员的职业生涯中，本书也是一本案头必备的参考书或工程实践手册。', '27', '100', '2017-05-05 16:54:33', '2', '0', '0');
INSERT INTO `book` VALUES ('68', '算法导论', '50', '0', '0', '在有关算法的书中，有一些叙述非常严谨，但不够全面；另一些涉及了大量的题材，但又缺乏严谨性。本书将严谨性和全面性融为一体，深入讨论各类算法，并着力使这些算法的设计和分析能为各个层次的读者接受。全书各章自成体系，可以作为独立的学习单元；算法以英语和伪代码的形式描述，具备初步程序设计经验的人就能看懂；说明和解释力求浅显易懂，不失深度和数学严谨性。\r\n《算法导论(原书第3版)》选材经典、内容丰富、结构合理、逻辑清晰，对本科生的数据结构课程和研究生的算法课程都是非常实用的教材，在IT专业人员的职业生涯中，本书也是一本案头必备的参考书或工程实践手册。', '27', '100', '2017-05-05 16:55:01', '1', '0', '0');
INSERT INTO `book` VALUES ('69', '深入理解java虚拟机', '30', '30', '0', '《深入理解Java虚拟机：JVM高级特性与最佳实践(第2版)》第1版两年内印刷近10次，4家网上书店的评论近4?000条，98%以上的评论全部为5星级的好评，是整个Java图书领域公认的经典著作和超级畅销书，繁体版在台湾也十分受欢迎。第2版在第1版的基础上做了很大的改进：根据最新的JDK 1.7对全书内容进行了全面的升级和补充；增加了大量处理各种常见JVM问题的技巧和最佳实践；增加了若干与生产环境相结合的实战案例；对第1版中的错误和不足之处的修正；等等。第2版不仅技术更新、内容更丰富，而且实战性更强。\r\n全书共分为五大部分，围绕内存管理、执行子系统、程序编译与优化、高效并发等核心主题对JVM进行了全面而深入的分析，深刻揭示了JVM的工作原理。第一部分从宏观的角度介绍了整个Java技术体系、Java和JVM的发展历程、模块化，以及JDK的编译，这对理解本书后面内容有重要帮助。第二部分讲解了JVM的自动内存管理，包括虚拟机内存区域的划分原理以及各种内存溢出异常产生的原因；常见的垃圾收集算法以及垃圾收集器的特点和工作原理；常见虚拟机监控与故障处理工具的原理和使用方法。第三部分分析了虚拟机的执行子系统，包括类文件结构、虚拟机类加载机制、虚拟机字节码执行引擎。第四部分讲解了程序的编译与代码的优化，阐述了泛型、自动装箱拆箱、条件编译等语法糖的原理；讲解了虚拟机的热点探测方法、HotSpot的即时编译器、编译触发条件，以及如何从虚拟机外部观察和分析JIT编译的数据和结果；第五部分探讨了Java实现高效并发的原理，包括JVM内存模型的结构和操作；原子性、可见性和有序性在Java内存模型中的体现；先行发生原则的规则和使用；线程在Java语言中的实现原理；虚拟机实现高效并发所做的一系列锁优化措施。', '28', '100', '2017-05-05 16:56:06', '2', '0', '0');
INSERT INTO `book` VALUES ('70', 'Effective Java中文版', '50', '0', '0', '  你是否正在寻找一本能够更加深入地了解Java编程语言的书，以便编写出更清晰、更正确、更健壮且更易于重用的代码。不用找了！本书为我们带来了共78条程序员推荐的经验法则，针对你每天都会遇到的编程问题提出了*有效、*实用的解决方案。 本书涵盖了自第l版之后所引入的Java E5和Java SE 6的特性，同时开发了新的设计模式和语言习惯用法，介绍了如何充分利用从泛型到枚举、从注解到自动装箱的各种特性。书中的每一章都包含几个“条目”，以简洁的形式呈现，自成独立的短文，它们提出了具体的建议，对于Java平台精妙之处的独到见解，以及很好的代码范例。每个条目的综合描述和解释都阐明了应该怎么做，不应该怎么做，以及为什么。', '27', '100', '2017-05-06 14:05:48', '3', '0', '0');
INSERT INTO `book` VALUES ('71', '追问', '50', '50', '0', '1、全面从严治党背景下，党风廉洁建设的鲜活教材读本！\r\n\r\n把纪律挺在前面，引导党员领导干部从“不敢腐”到“不想腐”的一个有效探索和创新，能够增强党风廉政教育的感染力、渗透力和影响力。\r\n\r\n \r\n\r\n2、反腐警示录：落马高官的“罪与罚”！\r\n\r\n本书与其说是一部运用文学力量贯穿历史与现实的“劫后人语”，不如说是一部党风廉洁建设的鲜活教材；与其说是一部与所谓“落马者”正面交锋的心灵碰撞实录，不如说是一部哲思蕴含于理性追问之中的“醒世恒言”。\r\n\r\n \r\n\r\n3、二月河作序强力推荐\r\n\r\n我曾经说过，如今的反腐力度是空前的，是历史上从来没有过的。这样的一场生死较量殊死搏斗，这样的一场人性善恶的水火难容，这样的一场永远在路上的“马拉松”，这样的一场扬汤止沸，在治标之中为釜底抽薪的治本之策赢得时间、取得经验的漫漫长旅中，听听一位有良知有担当有勇气有血性的作家的真情独白，看看一位有焦虑有不安有感受*有心得的基层纪委书记的如此文本，于人，于己，于公，于私，于家，于国，都是有益的啊。', '27', '98', '2017-05-06 14:08:52', '1', '0', '0');
INSERT INTO `book` VALUES ('72', '数据结构与算法分析6', '20', '20', '0', '本书是国外经典教材，使用卓越的Java编程语言作为实现工具，讨论数据结构(组织大量数据的方法)和算法分析(对算法运行时间的估计)。第3版的主要新增内容包括AVL树删除算法、布谷鸟散列、跳房子散列、基数排序、后缀树和后缀数组等，并对全书代码进行了更新。\r\n本书要求读者具备一定的编程基础，适合作为计算机相关专业高年级本科生和研究生教材，也可供广大程序员参考。', '27', '100', '2017-05-07 13:58:18', '0', '0', '0');
INSERT INTO `book` VALUES ('73', '测试', '665', '665', '0', '柔软', '38', '100', '2017-05-11 09:29:56', '0', '0', '0');
INSERT INTO `book` VALUES ('74', '我的世界永不言败', '23', '23', '0', '本书全面讲述马云从出生至今五十年间的奋斗历程，展现一个商业传奇人物的精彩故事。首批披露马云创业前默默跋涉的艰难岁月、鲜为人知的家庭生活，他的喜好、性格，甚至直面其心境。\r\n\r\n马云的一生充满曲折与励志色彩，又极富传奇，50年间，跌宕沉浮，起起落落，一直贯穿其间的是他永不言败的坚韧理念。从两次高考失利到进入大学校园，从四处求职无门到终于当上老师，从创业初始无人相助到公司逐步走上正轨，从力排众议创建中国黄页到经营阿里巴巴帝国，从淘宝危机到赴美上市……\r\n\r\n马云屡败屡战，永不止步，*终登上事业，其奋斗饱含惊人的个人意志；马云的一生与时代交织，布满坎坷又逐渐辉煌，成为中国*企业家的观察样本。', '28', '100', '2017-05-11 10:53:57', '0', '0', '0');
INSERT INTO `book` VALUES ('75', '塔木德', '40', '40', '0', '《塔木德》一书是犹太人继《旧约全书》(塔纳 赫)之后*重要的一部典籍，又称犹太智慧羊皮卷。\r\n是犹太人的“思维圣经”和“智慧DNA”，堪称人类 文明智慧的重要遗产，是揭开犹太人超凡智慧之谜的 一把金钥匙。与《圣经》、柏拉图的《理想国》、亚 里士多德的《政治学》和伊斯兰教的《古兰经》等书 ，并称为影响人类文明的巨著，是真正的传世经典。\r\n《塔木德》在世界上广泛流传，大约被译成12种 语言。几乎每个犹太人终生都要阅读《塔木德》，常 读常新。爱因斯坦、弗洛伊德、索罗斯、格林斯潘等 犹太名人无不受到《塔木德》的滋养和熏陶。羊皮卷 《塔木德》深受广大中国读者的喜爱，先后印刷14次 ，发行量逾10万册，现已修订再版。\r\n贺雄飞、铁戈主编的《塔木德启蒙书(精装彩色 插图版)(精)》是编译者从250万字的《塔木德》英文 原著中精选出来的常识性内容，同羊皮卷《塔木德》 堪称姊妹书，故称《塔木德启蒙书》。非常值得中国 读者研究和收藏。', '28', '100', '2017-05-11 10:58:15', '2', '0', '0');
INSERT INTO `book` VALUES ('76', '被嘲笑过的梦想', '20', '20', '0', '彭敏，人称“北大**文艺青年”，在北京大学就读时，历获北京大学校园原创小说大赛一等奖、原创诗词大赛|*佳原创奖、未名诗歌奖、王默人小说奖一等奖等，堪称中文系历史上的全满贯。\r\n\r\n就 是这样的文艺青年潜质，大学毕业后也架不住迅速成功的诱惑，投身股票和期货市场，经历了人生*大的困顿。*终在文学、文字的感召下，重新拾笔，在小说、评 论上再度发力，获得人民文学年度新人奖的同时，更以古典文化的积累，先后获得中央电视台*三届中国汉字听写大会媒体竞赛团年度总冠军、中央电视台*二届中 国成语大会年度总冠军。\r\n\r\n经此种种，感触、感慨良多，积累成文，有了本书。从自身的经历、从身边的听闻，和所有身处苦闷青春、困顿人生的人分享，梦想不但是人和咸鱼的区别，有了梦想还要不怕嘲笑，不要气馁，坚持做下去、走下去。\r\n\r\n因为，那些被嘲笑过的梦想，总有一天会让你闪闪发光。', '28', '100', '2017-05-11 10:58:48', '0', '0', '0');
INSERT INTO `book` VALUES ('77', '你只是看起来很努力', '22', '22', '0', '为什么你一直努力，却还是没有满意的成果？为什么你每天都很忙碌，却始终看不到终点？……你是真的努力了，还是，只是看起来很努力？\r\n本书是中国优质新偶像李尚龙先生写给写给千万年轻人的成长和成功之书。本书以夯实别致的内容，独特另类的思考，让你在面对学业的压力，青春的迷茫，爱情的复杂中保持无畏无惧的心态，成为*好的自己。\r\n在本书中，作者提到了很多朋友，他们有的因为父母的压力一直待在军校，有的因为和朋友爱上同一个女孩，坚持放弃了自己的爱情。有的人是在孤寂的大山之中的一面之缘，有的是教学课上的数面之交，虽是小角色，却都熠熠发光。因为他们受伤，他们坚强，他们努力，他们有勇气。\r\n这本书的文字，没有无聊的励志。这些故事也许你生活中永远不会碰触，亦或许曾经经历，它会告诉你“只是看起来很努力”的生活状态是可怕的；它会告诉你“再好的朋友也经不起你过分直白”；它还会告诉你不要为讨好别人而为难自己，因为“你以为你在合群，其实你在浪费青春”……47篇随笔和故事，或让人忍俊不禁，或让人潸然泪下，或让人茅塞顿开，或让人微笑释然，*终汇集成被《人民日报》盛赞的“改变千万热血青年的思维轨迹”。', '28', '100', '2017-05-11 11:00:24', '1', '0', '0');
INSERT INTO `book` VALUES ('78', '你一定要努力,但千万别着急', '42', '42', '0', '不要总是抱怨自己不升职不加薪，其实你并不是一无所获，也许，在下个转角，你就能收获无心插柳柳成荫的喜悦。千错万错，你的付出不会有错。陈道明老师在某节目担任嘉宾时，节目里一群打鼓的孩子当场受到了一些人的质疑，陈道明老师以自己成名前7年跑龙套的经历鼓舞那些孩子们：“你们一定要努力，但千万别着急。”同样一句话，送给所有坚持努力着的你。希望这本由简书主编的《你一定要努力但千万别着急》，可以陪你走过漫长的努力岁月，陪你一起励志，打倒那些“小野兽”。\r\n     亲爱的你，没有谁的青春是踩着红毯走过的，也没有谁能够毫不费力、步履轻盈地赢得掌声，在熠熠生辉之前总要捱过一段孤独不安的日子。如果你只为自己的人生画一条浅浅的吃苦底线，那就不要妄想跨越深邃的幸福极限，唯有承担起厚重的经历，才能禁得起岁月的推敲。', '28', '100', '2017-05-11 11:02:24', '1', '0', '0');
INSERT INTO `book` VALUES ('79', '苦难辉煌', '30', '30', '0', '推荐一 首版《苦难辉煌》未能面世的数万字内容此次得以全面呈现！增补数十处罕见历史细节。 \r\n\r\n推荐二 当下，为什么还要再度阅读《苦难辉煌》？以史为鉴，在新形势下，《苦难辉煌》所提供的历史信息，依然可以为今天的新难题提供丰富的启示。本书不仅是了解真实的中共早期党史必读书，更是了解中国的当下和未来的必读书。 \r\n\r\n推荐三  众多高层领导争相阅读大力推荐的历史巨著； 2013年“X受中央国家机关干部欢迎的10本书”中，《苦难辉煌》位列XX；中宣部中组部要求全体党员干部学习的重点图书；2011年1月14日，《苦难辉煌》荣获*二届中国出版政府奖图书奖。', '28', '100', '2017-05-11 11:08:01', '8', '0', '0');
INSERT INTO `book` VALUES ('80', '测试0', '100', '100', '1', '测试0', '39', '5', '2017-05-11 15:45:08', '2', '0', '0');
INSERT INTO `book` VALUES ('81', '测试1', '100', '100', '1', '测试1', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('82', '测试2', '100', '100', '1', '测试2', '39', '5', '2017-05-11 15:45:08', '2', '0', '1');
INSERT INTO `book` VALUES ('83', '测试3', '100', '100', '1', '测试3', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('84', '测试4', '100', '100', '1', '测试4', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('85', '测试5', '100', '100', '1', '测试5', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('86', '测试6', '100', '100', '1', '测试6', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('87', '测试7', '100', '100', '1', '测试7', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('88', '测试8', '100', '100', '1', '测试8', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('89', '测试9', '100', '100', '1', '测试9', '39', '5', '2017-05-11 15:45:08', '0', '0', '1');
INSERT INTO `book` VALUES ('90', '测试10', '100', '100', '1', '测试10', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('91', '测试11', '100', '100', '0', '测试11', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('92', '测试12', '100', '100', '0', '测试12', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('93', '测试13', '100', '100', '0', '测试13', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('94', '测试14', '100', '100', '0', '测试14', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('95', '测试15', '100', '100', '0', '测试15', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('96', '测试16', '100', '100', '0', '测试16', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('97', '测试17', '100', '100', '0', '测试17', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('98', '测试18', '100', '100', '0', '测试18', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('99', '测试19', '100', '100', '0', '测试19', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('100', '测试20', '100', '100', '0', '测试20', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('101', '测试21', '100', '100', '0', '测试21', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('102', '测试22', '100', '100', '0', '测试22', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('103', '测试23', '100', '100', '0', '测试23', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('104', '测试24', '100', '100', '0', '测试24', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('105', '测试25', '100', '60', '1', '测试25', '39', '98', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('106', '测试26', '100', '100', '0', '测试26', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('107', '测试27', '100', '100', '0', '测试27', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('108', '测试28', '100', '100', '0', '测试28', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('109', '测试29', '100', '100', '0', '测试29', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('110', '测试30', '100', '100', '0', '测试30', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('111', '测试31', '100', '100', '0', '测试31', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('112', '测试32', '100', '100', '0', '测试32', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('113', '测试33', '100', '100', '0', '测试33', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('114', '测试34', '100', '100', '0', '测试34', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('115', '测试35', '100', '100', '0', '测试35', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('116', '测试36', '100', '100', '0', '测试36', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('117', '测试37', '100', '100', '0', '测试37', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('118', '测试38', '100', '100', '0', '测试38', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('119', '测试39', '100', '100', '0', '测试39', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('120', '测试40', '100', '100', '0', '测试40', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('121', '测试41', '100', '100', '0', '测试41', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('122', '测试42', '100', '100', '0', '测试42', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('123', '测试43', '100', '100', '0', '测试43', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('124', '测试44', '100', '100', '0', '测试44', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('125', '测试45', '100', '100', '0', '测试45', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('126', '测试46', '100', '100', '0', '测试46', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('127', '测试47', '100', '100', '0', '测试47', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('128', '测试48', '100', '100', '0', '测试48', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('129', '测试49', '100', '100', '0', '测试49', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('130', '测试50', '100', '100', '0', '测试50', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('131', '测试51', '100', '100', '0', '测试51', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('132', '测试52', '100', '100', '0', '测试52', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('133', '测试53', '100', '100', '0', '测试53', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('134', '测试54', '100', '100', '0', '测试54', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('135', '测试55', '100', '100', '0', '测试55', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('136', '测试56', '100', '100', '0', '测试56', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('137', '测试57', '100', '100', '0', '测试57', '39', '5', '2017-05-11 15:45:08', '0', '0', '0');
INSERT INTO `book` VALUES ('138', '测试58', '100', '100', '0', '测试58', '39', '-2', '2017-05-11 15:45:09', '0', '1', '0');
INSERT INTO `book` VALUES ('139', '666测试59', '100', '30', '1', ' 额', '39', '100', '2017-05-12 10:42:36', '1', '0', '0');
INSERT INTO `book` VALUES ('140', '测试60', '100', '100', '0', '测试60', '39', '0', '2017-05-11 15:45:09', '1', '0', '0');
INSERT INTO `book` VALUES ('141', '测试61', '100', '100', '0', '测试61', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('142', '测试62', '100', '100', '0', '测试62', '39', '4', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('143', '测试63', '100', '100', '0', '测试63', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('144', '测试64', '100', '100', '0', '测试64', '39', '0', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('145', '测试65', '100', '100', '0', '测试65', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('146', '测试66', '100', '100', '0', '测试66', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('147', '测试67', '100', '100', '0', '测试67', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('148', '测试68', '100', '100', '0', '测试68', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('149', '测试69', '100', '100', '0', '测试69', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('150', '测试70', '100', '100', '0', '测试70', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('151', '测试71', '100', '100', '0', '测试71', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('152', '测试72', '100', '100', '0', '测试72', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('153', '测试73', '100', '100', '0', '测试73', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('154', '测试74', '100', '100', '0', '测试74', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('155', '测试75', '100', '100', '0', '测试75', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('156', '测试76', '100', '100', '0', '测试76', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('157', '测试77', '100', '100', '0', '测试77', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('158', '测试78', '100', '100', '0', '测试78', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('159', '测试79', '100', '100', '0', '测试79', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('160', '测试80', '100', '100', '0', '测试80', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('161', '测试81', '100', '100', '0', '测试81', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('162', '测试82', '100', '100', '0', '测试82', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('163', '测试83', '100', '100', '0', '测试83', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('164', '测试84', '100', '100', '0', '测试84', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('165', '测试85', '100', '100', '0', '测试85', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('166', '测试86', '100', '100', '0', '测试86', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('167', '测试87', '100', '100', '0', '测试87', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('168', '测试88', '100', '100', '0', '测试88', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('169', '测试89', '100', '100', '0', '测试89', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('170', '测试90', '100', '100', '0', '测试90', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('171', '测试91', '100', '100', '0', '测试91', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('172', '测试92', '100', '100', '0', '测试92', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('173', '测试93', '100', '100', '0', '测试93', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('174', '测试94', '100', '100', '0', '测试94', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('175', '测试95', '100', '100', '0', '测试95', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('176', '测试96', '100', '100', '0', '测试96', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('177', '测试97', '100', '100', '0', '测试97', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('178', '测试98', '100', '100', '0', '测试98', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('179', '测试99', '100', '100', '0', '测试99', '39', '5', '2017-05-11 15:45:09', '0', '0', '0');
INSERT INTO `book` VALUES ('180', '午安', '50', '50', '0', '好吧', '39', '97', '2017-05-11 23:53:02', '0', '0', '0');
INSERT INTO `book` VALUES ('181', '么么哒', '123', '123', '0', '请求', '39', '5', '2017-05-12 00:03:46', '0', '0', '0');
INSERT INTO `book` VALUES ('182', 'pppp', '100', '100', '0', '546', '39', '7', '2017-05-12 00:06:36', '0', '0', '0');
INSERT INTO `book` VALUES ('183', '积分IE', '50', '50', '0', '阿萨德', '40', '90', '2017-05-12 09:14:01', '4', '6', '0');

-- ----------------------------
-- Table structure for bookcomment
-- ----------------------------
DROP TABLE IF EXISTS `bookcomment`;
CREATE TABLE `bookcomment` (
  `user_id` varchar(255) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `comment` varchar(9000) DEFAULT NULL,
  KEY `vgs` (`user_id`),
  KEY `saafwfcse` (`book_id`),
  CONSTRAINT `saafwfcse` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vgs` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bookcomment
-- ----------------------------

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sdgsdf` (`user_id`),
  KEY `asfff` (`book_id`),
  CONSTRAINT `sdgsdf` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('22', 'bbb', '67', '2');
INSERT INTO `cart` VALUES ('23', 'aaa', '69', '1');
INSERT INTO `cart` VALUES ('24', 'bbb', '70', '1');
INSERT INTO `cart` VALUES ('25', '20', '72', '1');
INSERT INTO `cart` VALUES ('26', '20', '67', '1');
INSERT INTO `cart` VALUES ('33', '5', '181', '1');
INSERT INTO `cart` VALUES ('34', '6', '182', '1');
INSERT INTO `cart` VALUES ('35', '6', '181', '1');
INSERT INTO `cart` VALUES ('36', '6', '105', '1');
INSERT INTO `cart` VALUES ('47', '7', '183', '2');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `buyerid` varchar(11) DEFAULT NULL,
  `sellerid` varchar(11) DEFAULT NULL,
  `addressid` int(11) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `asffew` (`buyerid`),
  KEY `hhfdg` (`sellerid`),
  KEY `egfb` (`addressid`),
  CONSTRAINT `asffew` FOREIGN KEY (`buyerid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hhfdg` FOREIGN KEY (`sellerid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('102', 'bbb', 'aaa', '19', '订单完成', '36', '2017-05-06 23:39:51');
INSERT INTO `order` VALUES ('103', 'bbb', 'ccc', '19', '已付款，等待发货', '60', '2017-05-06 23:39:51');
INSERT INTO `order` VALUES ('104', 'bbb', 'aaa', '20', '已付款，等待发货', '50', '2017-05-06 23:50:48');
INSERT INTO `order` VALUES ('105', 'bbb', 'aaa', '19', '订单取消', '12', '2017-05-06 23:56:58');
INSERT INTO `order` VALUES ('106', 'bbb', 'aaa', '19', '等待付款', '20', '2017-05-07 00:03:18');
INSERT INTO `order` VALUES ('107', 'bbb', 'aaa', '19', '已付款，等待发货', '10', '2017-05-07 00:24:39');
INSERT INTO `order` VALUES ('108', 'bbb', 'aaa', '20', '已付款，等待发货', '20', '2017-05-07 00:27:43');
INSERT INTO `order` VALUES ('109', 'aaa', 'ccc', '18', '已付款，等待发货', '30', '2017-05-07 14:18:26');
INSERT INTO `order` VALUES ('110', 'aaa', 'ccc', '18', '订单取消', '30', '2017-05-07 14:20:00');
INSERT INTO `order` VALUES ('111', 'aaa', 'ccc', '18', '已付款，等待发货', '30', '2017-05-07 14:45:57');
INSERT INTO `order` VALUES ('112', 'bbb', 'aaa', '19', '已付款，等待发货', '1500', '2017-05-07 14:47:07');
INSERT INTO `order` VALUES ('113', 'bbb', 'aaa', '19', '已付款，等待发货', '50', '2017-05-08 15:02:30');
INSERT INTO `order` VALUES ('124', '5', '4', '24', '已付款，等待发货', '100', '2017-05-11 23:31:59');
INSERT INTO `order` VALUES ('130', '5', 'aaa', '24', '等待付款', '50', '2017-05-11 23:47:19');
INSERT INTO `order` VALUES ('135', '6', '4', '25', '等待付款', '100', '2017-05-12 00:29:37');
INSERT INTO `order` VALUES ('138', '7', '4', '26', '等待付款', '100', '2017-05-12 00:32:17');
INSERT INTO `order` VALUES ('140', '7', '4', '26', '订单取消', '200', '2017-05-12 00:33:51');
INSERT INTO `order` VALUES ('142', '7', '4', '26', '等待付款', '60', '2017-05-12 00:50:22');
INSERT INTO `order` VALUES ('143', '7', '4', '26', '等待付款', '60', '2017-05-12 01:00:38');
INSERT INTO `order` VALUES ('145', '7', '4', '26', '等待付款', '120', '2017-05-12 08:57:25');
INSERT INTO `order` VALUES ('151', '7', 'CESHI', '26', '等待付款', '100', '2017-05-12 10:13:58');
INSERT INTO `order` VALUES ('152', '7', 'CESHI', '26', '订单完成', '300', '2017-05-12 11:14:28');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `gfbv` (`order_id`),
  KEY `dsfr` (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2812 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('104', '102', '67', '3', '2017-05-06 23:39:51');
INSERT INTO `order_detail` VALUES ('105', '103', '69', '2', '2017-05-06 23:39:51');
INSERT INTO `order_detail` VALUES ('106', '104', '70', '1', '2017-05-06 23:50:48');
INSERT INTO `order_detail` VALUES ('107', '105', '67', '1', '2017-05-06 23:56:58');
INSERT INTO `order_detail` VALUES ('108', '106', '67', '1', '2017-05-07 00:03:18');
INSERT INTO `order_detail` VALUES ('109', '107', '67', '1', '2017-05-07 00:24:39');
INSERT INTO `order_detail` VALUES ('110', '108', '67', '2', '2017-05-07 00:27:43');
INSERT INTO `order_detail` VALUES ('111', '109', '69', '1', '2017-05-07 14:18:26');
INSERT INTO `order_detail` VALUES ('112', '110', '69', '1', '2017-05-07 14:20:00');
INSERT INTO `order_detail` VALUES ('113', '111', '69', '1', '2017-05-07 14:45:57');
INSERT INTO `order_detail` VALUES ('114', '112', '68', '30', '2017-05-07 14:47:07');
INSERT INTO `order_detail` VALUES ('116', '114', '72', '2', '2017-05-09 11:23:24');
INSERT INTO `order_detail` VALUES ('117', '114', '71', '1', '2017-05-09 11:23:24');
INSERT INTO `order_detail` VALUES ('120', '124', '139', '1', '2017-05-11 23:31:59');
INSERT INTO `order_detail` VALUES ('121', '130', '71', '1', '2017-05-11 23:47:19');
INSERT INTO `order_detail` VALUES ('122', '135', '105', '1', '2017-05-12 00:29:37');
INSERT INTO `order_detail` VALUES ('123', '138', '140', '1', '2017-05-12 00:32:17');
INSERT INTO `order_detail` VALUES ('124', '140', '105', '2', '2017-05-12 00:33:51');
INSERT INTO `order_detail` VALUES ('125', '142', '105', '1', '2017-05-12 00:50:22');
INSERT INTO `order_detail` VALUES ('126', '143', '105', '1', '2017-05-12 01:00:38');
INSERT INTO `order_detail` VALUES ('127', '145', '105', '2', '2017-05-12 08:57:25');
INSERT INTO `order_detail` VALUES ('2810', '151', '183', '2', '2017-05-12 10:13:58');
INSERT INTO `order_detail` VALUES ('2811', '152', '183', '6', '2017-05-12 11:14:28');

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `integral` int(11) DEFAULT '0',
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `salecount` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `bnght` (`user_id`),
  CONSTRAINT `bnght` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES ('27', 'aaa', '小明专卖店666', '这里是小明的专卖店', '0', '2017-05-04 00:51:51', '0');
INSERT INTO `shop` VALUES ('28', 'ccc', '小黄的店铺', '小黄专卖店', '0', '2017-05-04 21:52:34', '0');
INSERT INTO `shop` VALUES ('37', '1', '测试', '测试\r\n', '0', '2017-05-10 13:18:16', '0');
INSERT INTO `shop` VALUES ('38', '20', 'aaa', '啊发', '0', '2017-05-11 09:29:43', '0');
INSERT INTO `shop` VALUES ('39', '4', '测试店铺', '			       \r\n			   的分公司的v   \r\n			      ', '10', '2017-05-11 15:40:27', '1');
INSERT INTO `shop` VALUES ('40', 'CESHI', 'W D', 'SKJWO', '10', '2017-05-12 09:13:01', '6');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sex` varchar(11) DEFAULT NULL,
  `integral` int(11) DEFAULT '0',
  `shop_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `blance` double DEFAULT '0',
  `state` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ooojsj` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1ooo', '123', '99', '1@qq.com', '男', '0', '37', '2017-05-08 10:25:24', '0', '禁用');
INSERT INTO `user` VALUES ('10', '10ooo', '123', '99', '10@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', '禁用');
INSERT INTO `user` VALUES ('11', '11ooo', '123', '99', '11@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', '禁用');
INSERT INTO `user` VALUES ('12', '12ooo', '123', '99', '12@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('13', '13ooo', '123', '99', '13@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('14', '14ooo', '123', '99', '14@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('15', '15ooo', '123', '99', '15@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('16', '16ooo', '123', '99', '16@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('17', '17ooo', '123', '99', '17@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('18', '18ooo', '123', '99', '18@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('19', '19ooo', '123', '99', '19@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('2', '2ooo', '123', '99', '2@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('20', '20ooo', '123', '99', '20@qq.com', '男', '0', '38', '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('21', '21ooo', '123', '99', '21@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('22', '22ooo', '123', '99', '22@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('23', '23ooo', '123', '99', '23@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('24', '24ooo', '123', '99', '24@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('25', '25ooo', '123', '99', '25@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('26', '26ooo', '123', '99', '26@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('27', '27ooo', '123', '99', '27@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('28', '28ooo', '123', '99', '28@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('29', '29ooo', '123', '99', '29@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('3', '3ooo', '123', '99', '3@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('30', '30ooo', '123', '99', '30@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('31', '31ooo', '123', '99', '31@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('32', '32ooo', '123', '99', '32@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('33', '33ooo', '123', '99', '33@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('34', '34ooo', '123', '99', '34@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('35', '35ooo', '123', '99', '35@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('36', '36ooo', '123', '99', '36@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('37', '37ooo', '123', '99', '37@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('38', '38ooo', '123', '99', '38@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('39', '39ooo', '123', '99', '39@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('4', '4ooo', '123', '99', '4@qq.com', '男', '5', '39', '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('40', '40ooo', '123', '99', '40@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('41', '41ooo', '123', '99', '41@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('42', '42ooo', '123', '99', '42@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('43', '43ooo', '123', '99', '43@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('44', '44ooo', '123', '99', '44@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('45', '45ooo', '123', '99', '45@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('46', '46ooo', '123', '99', '46@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('47', '47ooo', '123', '99', '47@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('48', '48ooo', '123', '99', '48@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('49', '49ooo', '123', '99', '49@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('5', '5ooo', '123', '99', '5@qq.com', '男', '5', null, '2017-05-08 10:25:24', '9400', null);
INSERT INTO `user` VALUES ('50', '50ooo', '123', '99', '50@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('51', '51ooo', '123', '99', '51@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('52', '52ooo', '123', '99', '52@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('53', '53ooo', '123', '99', '53@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('54', '54ooo', '123', '99', '54@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('55', '55ooo', '123', '99', '55@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('56', '56ooo', '123', '99', '56@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('57', '57ooo', '123', '99', '57@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('58', '58ooo', '123', '99', '58@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('59', '59ooo', '123', '99', '59@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('6', '6ooo', '123', '99', '6@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('60', '60ooo', '123', '99', '60@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('61', '61ooo', '123', '99', '61@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('62', '62ooo', '123', '99', '62@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('63', '63ooo', '123', '99', '63@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('64', '64ooo', '123', '99', '64@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('65', '65ooo', '123', '99', '65@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('66', '66ooo', '123', '99', '66@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('67', '67ooo', '123', '99', '67@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('68', '68ooo', '123', '99', '68@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('69', '69ooo', '123', '99', '69@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('7', '7ooo', '123', '99', '7@qq.com', '男', '5', null, '2017-05-08 10:25:24', '700', null);
INSERT INTO `user` VALUES ('70', '70ooo', '123', '99', '70@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('71', '71ooo', '123', '99', '71@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('72', '72ooo', '123', '99', '72@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('73', '73ooo', '123', '99', '73@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('74', '74ooo', '123', '99', '74@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('75', '75ooo', '123', '99', '75@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('76', '76ooo', '123', '99', '76@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('77', '77ooo', '123', '99', '77@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('78', '78ooo', '123', '99', '78@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('79', '79ooo', '123', '99', '79@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('8', '8ooo', '123', '99', '8@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('80', '80ooo', '123', '99', '80@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('81', '81ooo', '123', '99', '81@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('82', '82ooo', '123', '99', '82@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('83', '83ooo', '123', '99', '83@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('84', '84ooo', '123', '99', '84@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('85', '85ooo', '123', '99', '85@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('86', '86ooo', '123', '99', '86@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('87', '87ooo', '123', '99', '87@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('88', '88ooo', '123', '99', '88@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('89', '89ooo', '123', '99', '89@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('9', '9ooo', '123', '99', '9@qq.com', '男', '0', null, '2017-05-08 10:25:24', '0', null);
INSERT INTO `user` VALUES ('90', '90ooo', '123', '99', '90@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('91', '91ooo', '123', '99', '91@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('92', '92ooo', '123', '99', '92@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('93', '93ooo', '123', '99', '93@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('94', '94ooo', '123', '99', '94@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('95', '95ooo', '123', '99', '95@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('96', '96ooo', '123', '99', '96@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('97', '97ooo', '123', '99', '97@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('98', '98ooo', '123', '99', '98@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('99', '99ooo', '123', '99', '99@qq.com', '男', '0', null, '2017-05-08 10:25:25', '0', null);
INSERT INTO `user` VALUES ('aaa', '小明', '123', '22', '888@qq.com', '男', '10', '27', '2017-05-04 00:51:20', '100', null);
INSERT INTO `user` VALUES ('bbb', '小红', '123', '20', '888@qq.com', '女', '5', null, '2017-05-04 01:07:25', '550', null);
INSERT INTO `user` VALUES ('ccc', '小黄', '123', '20', '888@qq.com', '女', '0', '28', '2017-05-04 21:52:16', '0', null);
INSERT INTO `user` VALUES ('CESHI', 'CESHI', 'AIWOLANQIU', '20', '22@QQ', '男', '5', '40', '2017-05-12 09:12:51', '0', null);
INSERT INTO `user` VALUES ('tt', '李文新', '123', '22', '888@qq.com', '男', '0', null, '2017-05-06 22:54:40', '0', null);

-- ----------------------------
-- Table structure for userkey
-- ----------------------------
DROP TABLE IF EXISTS `userkey`;
CREATE TABLE `userkey` (
  `user_id` varchar(255) DEFAULT NULL,
  `user_key` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  KEY `asfdsf` (`user_id`),
  CONSTRAINT `asfdsf` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userkey
-- ----------------------------
INSERT INTO `userkey` VALUES ('aaa', 'java', '2017-05-07 21:20:45');
INSERT INTO `userkey` VALUES ('aaa', '算法', '2017-05-07 21:20:45');
INSERT INTO `userkey` VALUES ('aaa', '我的', '2017-05-07 21:20:45');
INSERT INTO `userkey` VALUES ('aaa', '算法', '2017-05-07 21:21:23');
INSERT INTO `userkey` VALUES ('bbb', '编程', '2017-05-07 22:02:52');
INSERT INTO `userkey` VALUES ('bbb', 'java', '2017-05-07 22:04:43');
INSERT INTO `userkey` VALUES ('bbb', '小明', '2017-05-08 14:09:05');
INSERT INTO `userkey` VALUES ('bbb', '追问', '2017-05-08 14:09:30');
INSERT INTO `userkey` VALUES ('bbb', '追问', '2017-05-08 14:21:05');
INSERT INTO `userkey` VALUES ('bbb', '追问', '2017-05-08 14:22:49');
INSERT INTO `userkey` VALUES ('bbb', 'JAVA', '2017-05-08 14:24:47');
INSERT INTO `userkey` VALUES ('bbb', '虚拟机', '2017-05-08 14:25:01');
INSERT INTO `userkey` VALUES ('4', '测试', '2017-05-11 15:46:47');
INSERT INTO `userkey` VALUES ('4', 'java', '2017-05-11 15:47:35');
INSERT INTO `userkey` VALUES ('4', '测试', '2017-05-11 15:53:06');
INSERT INTO `userkey` VALUES ('4', '测试', '2017-05-11 15:53:13');
INSERT INTO `userkey` VALUES ('7', '25', '2017-05-12 00:50:14');
INSERT INTO `userkey` VALUES ('7', '25', '2017-05-12 08:57:16');
INSERT INTO `userkey` VALUES ('4', '0', '2017-05-12 11:13:41');
INSERT INTO `userkey` VALUES ('4', '测试', '2017-05-12 16:59:37');
INSERT INTO `userkey` VALUES ('4', '测试', '2017-05-12 17:00:00');
INSERT INTO `userkey` VALUES ('4', 'java', '2017-05-12 17:00:38');
