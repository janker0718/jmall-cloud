CREATE TABLE `area`  (
                         `area_id` bigint NOT NULL COMMENT '主键id',
                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                         `area_name` varchar(50) NULL COMMENT '地址',
                         `parent_id` bigint NULL COMMENT '上级id',
                         `level` int NULL COMMENT '等级',
                         PRIMARY KEY (`area_id`)
);

CREATE TABLE `order`  (
                          `order_id` bigint NOT NULL COMMENT '订单id',
                          `shop_id` bigint NOT NULL COMMENT '店铺id',
                          `user_id` bigint NOT NULL COMMENT '用户ID',
                          `consignor` varchar(50) NOT NULL COMMENT '发货人',
                          `delivery_type` tinyint NOT NULL DEFAULT 1 COMMENT '配送类型：1 无需快递',
                          `shop_name` varchar(32) NULL COMMENT '店铺名称',
                          `status` tinyint NOT NULL DEFAULT 0 COMMENT '订单状态 1:待付款 2:待发货 3:待收货(已发货) 5:成功 6:失败',
                          `all_count` int NOT NULL DEFAULT 0 COMMENT '订单商品总数',
                          `pay_time` datetime NULL COMMENT '付款时间',
                          `delivery_time` datetime NULL COMMENT '发货时间',
                          `final_time` datetime NULL COMMENT '完成时间',
                          `settled_time` datetime NULL COMMENT '结算时间',
                          `cancel_time` datetime NULL COMMENT '取消时间',
                          `is_payed` tinyint NOT NULL DEFAULT 0 COMMENT '是否已支付，1.已支付0.未支付',
                          `close_type` tinyint NULL COMMENT '订单关闭原因 1-超时未支付 4-买家取消 15-已通过货到付款交易',
                          `delete_status` tinyint NOT NULL DEFAULT 0 COMMENT '用户订单删除状态，0：没有删除， 1：回收站， 2：永久删除',
                          `version` int NULL COMMENT '订单版本号，每处理一次订单，版本号+1',
                          `order_addr_id` int NULL COMMENT '用户订单地址id',
                          `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                          `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                          PRIMARY KEY (`order_id`),
                          INDEX `idx_shop_id`(`shop_id`) USING BTREE,
                          INDEX `idx_user_id`(`user_id`) USING BTREE
);

CREATE TABLE `order_address`  (
                                  `order_addr_id` bigint NOT NULL COMMENT '主键id',
                                  `user_id` bigint NOT NULL COMMENT '用户id',
                                  `consignee` varchar(50) NOT NULL COMMENT '收货人',
                                  `province_id` bigint NULL COMMENT '省id',
                                  `province` varchar(20) NULL COMMENT '省',
                                  `city_id` bigint NULL COMMENT '城市id',
                                  `city` varchar(20) NULL COMMENT '城市',
                                  `area_id` bigint NULL COMMENT '区域id',
                                  `area` varchar(20) NULL COMMENT '区',
                                  `address` varchar(1000) NULL COMMENT '地址',
                                  `post_code` varchar(15) NULL COMMENT '邮编',
                                  `mobile` varchar(20) NULL COMMENT '手机',
                                  `lng` decimal(12, 6) NULL COMMENT '经度',
                                  `lat` varchar(12) NULL COMMENT '纬度',
                                  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                  PRIMARY KEY (`order_addr_id`)
);

CREATE TABLE `order_item`  (
                               `order_item_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单条目ID',
                               `shop_id` bigint NOT NULL COMMENT '店铺id',
                               `order_id` bigint NOT NULL COMMENT '订单id',
                               `spu_id` bigint NOT NULL COMMENT '产品ID',
                               `sku_id` bigint NOT NULL COMMENT '产品SkuID',
                               `spu_name` varchar(120) NOT NULL DEFAULT '' COMMENT '产品名称',
                               `sku_name` varchar(120) NULL DEFAULT NULL COMMENT 'sku名称',
                               `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '产品主图片路径',
                               `shop_cart_time` datetime NULL COMMENT '加购时间',
                               `count` int NOT NULL DEFAULT 0 COMMENT '商品个数',
                               `price` bigint NOT NULL COMMENT '价格',
                               `status` tinyint NULL COMMENT '状态',
                               `spu_total_amount` bigint NOT NULL COMMENT '商品总金额',
                               `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                               `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               PRIMARY KEY (`order_item_id`),
                               INDEX `idx_order_id`(`order_id`) USING BTREE,
                               INDEX `idx_shop_id`(`shop_id`) USING BTREE,
                               INDEX `idx_spu_id`(`spu_id`) USING BTREE,
                               INDEX `idx_sku_id`(`sku_id`) USING BTREE
);

CREATE TABLE `pay_info`  (
                             `pay_id` bigint NOT NULL COMMENT '支付单号',
                             `user_id` bigint NULL COMMENT '用户id',
                             `order_ids` varchar(255) NULL COMMENT '本次支付关联的多个订单号',
                             `pay_status` tinyint NULL COMMENT '支付状态',
                             `pay_amount` tinyint NULL COMMENT '支付金额',
                             `version` int NULL COMMENT '版本号',
                             `sys_type` tinyint NULL COMMENT '系统类型 见SysTypeEnum',
                             `biz_pay_no` varchar(255) NULL COMMENT '外部订单流水号',
                             `callback_content` text NULL COMMENT '回调内容',
                             `callback_time` datetime NULL DEFAULT NULL COMMENT '回调时间',
                             `confirm_time` datetime NULL DEFAULT NULL COMMENT '确认时间',
                             `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                             `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                             PRIMARY KEY (`pay_id`)
);

CREATE TABLE `product_attr`  (
                                 `attr_id` bigint NOT NULL AUTO_INCREMENT COMMENT '属性id',
                                 `shop_id` bigint NOT NULL DEFAULT 0,
                                 `name` varchar(20) NOT NULL COMMENT '属性名称',
                                 `desc` varchar(200) NULL COMMENT '属性描述',
                                 `attr_type` tinyint NOT NULL DEFAULT 0,
                                 `search_type` tinyint NOT NULL DEFAULT 0 COMMENT '是否需要搜索 0:不需要，1:需要',
                                 `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                 `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                 PRIMARY KEY (`attr_id`)
);

CREATE TABLE `product_attr_value`  (
                                       `attr_value_id` bigint NOT NULL AUTO_INCREMENT COMMENT '属性值id',
                                       `attr_id` bigint NOT NULL COMMENT '属性ID',
                                       `value` varchar(20) NOT NULL COMMENT '属性值',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       PRIMARY KEY (`attr_value_id`)
);

CREATE TABLE `product_brand`  (
                                  `brand_id` bigint NOT NULL COMMENT '主键id',
                                  `name` varchar(255) NULL COMMENT '品牌名称',
                                  `desc` varchar(255) NULL COMMENT '描述',
                                  `img_url` varchar(255) NULL COMMENT '品牌logo',
                                  `first_letter` char(1) NULL COMMENT '检索首字母',
                                  `sort` int NULL COMMENT '排序',
                                  `status` tinyint NULL DEFAULT 1 COMMENT '1 可用 0不可用 -1 删除',
                                  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                  PRIMARY KEY (`brand_id`)
);

CREATE TABLE `product_category`  (
                                     `category_id` bigint NOT NULL COMMENT '主键id',
                                     `shop_id` bigint NULL,
                                     `parent_id` bigint NULL COMMENT '父级id',
                                     `name` varchar(20) NULL COMMENT '分类名称',
                                     `desc` varchar(255) NULL COMMENT '分类描述',
                                     `path` varchar(255) NULL COMMENT '分类地址',
                                     `status` tinyint NULL,
                                     `level` int NULL,
                                     `sort` int NULL,
                                     `create_time` datetime NULL,
                                     `update_time` datetime NULL,
                                     PRIMARY KEY (`category_id`)
);

CREATE TABLE `product_category_brand`  (
                                           `id` bigint NOT NULL COMMENT '主键id',
                                           `brand_id` bigint NOT NULL COMMENT '品牌id',
                                           `category_id` bigint NOT NULL COMMENT '分类id',
                                           `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                           `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                           PRIMARY KEY (`id`),
                                           UNIQUE INDEX `uni_brand_category_id`(`brand_id`, `category_id`) USING BTREE
);

CREATE TABLE `product_sku`  (
                                `sku_id` bigint NOT NULL COMMENT '主键id',
                                `create_time` datetime NULL,
                                `update_time` datetime NULL,
                                `spu_id` bigint NULL,
                                `sku_name` varchar(255) NULL,
                                `attrs` varchar(255) NULL,
                                `image_url` varchar(1000) NULL,
                                `weight` decimal(15, 3) NULL,
                                `volume` decimal(15, 3) NULL,
                                `price` bigint NULL COMMENT '售价',
                                `market_price` bigint NULL COMMENT '市场价',
                                `party_code` varchar(100) NULL COMMENT '商品编码',
                                `bar_code` varchar(100) NULL COMMENT '条形码',
                                `status` tinyint NULL COMMENT '1 可用 0 不可用  -1 删除',
                                PRIMARY KEY (`sku_id`),
                                INDEX `idx_spu_id`(`spu_id`) USING BTREE
);

CREATE TABLE `product_sku_attr_value`  (
                                           `sku_attr_id` bigint NOT NULL AUTO_INCREMENT,
                                           `create_time` datetime NULL,
                                           `update_time` datetime NULL,
                                           `spu_id` bigint NULL,
                                           `sku_id` bigint NULL,
                                           `attr_id` bigint NULL,
                                           `attr_name` varchar(255) NULL,
                                           `attr_value_id` int NULL,
                                           `attr_value_name` varchar(255) NULL,
                                           `status` tinyint NULL,
                                           PRIMARY KEY (`sku_attr_id`)
);

CREATE TABLE `product_sku_stock`  (
                                      `stock_id` bigint NOT NULL COMMENT '主键id',
                                      `sku_id` bigint NULL COMMENT 'sku id',
                                      `actual_stock` int NULL COMMENT '实际库存',
                                      `lock_stock` int NULL COMMENT '锁定库存',
                                      `stock` int NULL COMMENT '可售卖库存',
                                      `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      PRIMARY KEY (`stock_id`),
                                      INDEX `idx_sku_id`(`sku_id`) USING BTREE
);

CREATE TABLE `product_sku_stock_lock`  (
                                           `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                           `spu_id` bigint NULL,
                                           `sku_id` bigint NULL,
                                           `order_id` bigint NULL,
                                           `status` tinyint NULL,
                                           `count` int NULL COMMENT '锁定库存数量',
                                           `create_time` datetime NULL,
                                           `update_time` datetime NULL,
                                           PRIMARY KEY (`id`),
                                           UNIQUE INDEX `uni_spu_sku_order`(`spu_id`, `sku_id`, `order_id`) USING BTREE
);

CREATE TABLE `product_spu`  (
                                `spu_id` bigint NOT NULL COMMENT '主键id',
                                `brand_id` bigint NULL COMMENT '品牌ID',
                                `category_id` bigint NULL COMMENT '分类ID',
                                `shop_category_id` bigint NULL,
                                `shop_id` bigint NULL,
                                `name` varchar(255) NULL,
                                `selling_point` varchar(255) NULL,
                                `main_img_url` varchar(255) NULL,
                                `img_urls` varchar(255) NULL,
                                `video` varchar(255) NULL,
                                `price` decimal(15, 3) NULL,
                                `market_price` decimal(15, 3) NULL,
                                `status` tinyint NULL,
                                `has_sku_img` tinyint NULL,
                                `sort` int NULL,
                                `create_time` datetime NULL,
                                `update_time` datetime NULL,
                                PRIMARY KEY (`spu_id`),
                                INDEX `idx_brand_id`(`brand_id`) USING BTREE,
                                INDEX `idx_cat_id`(`category_id`) USING BTREE,
                                INDEX `idx_shop_id`(`shop_id`) USING BTREE,
                                INDEX `idx_shop_cat_id`(`shop_category_id`) USING BTREE
);

CREATE TABLE `product_spu_attr_value`  (
                                           `spu_attr_value_id` bigint NOT NULL COMMENT '主键id',
                                           `spu_id` bigint NULL,
                                           `attr_id` bigint NULL,
                                           `attr_name` varchar(255) NULL,
                                           `attr_value_id` bigint NULL,
                                           `attr_value_name` varchar(255) NULL,
                                           `attr_desc` varchar(255) NULL,
                                           `create_time` datetime NULL,
                                           `update_time` datetime NULL,
                                           PRIMARY KEY (`spu_attr_value_id`),
                                           UNIQUE INDEX `uni_spu_id`(`spu_id`, `attr_id`) USING BTREE
);

CREATE TABLE `product_spu_detail`  (
                                       `spu_id` bigint NULL,
                                       `detail` mediumtext NULL COMMENT '商品详情',
                                       `create_time` datetime NULL,
                                       `update_time` datetime NULL
);

CREATE TABLE `product_spu_extension`  (
                                          `spu_extend_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                          `create_time` datetime NULL,
                                          `update_time` datetime NULL,
                                          `spu_id` bigint NULL,
                                          `sale_num` int NOT NULL DEFAULT 0,
                                          `actual_stock` int NOT NULL DEFAULT 0,
                                          `lock_stock` int NOT NULL DEFAULT 0,
                                          `stock` int NOT NULL DEFAULT 0,
                                          PRIMARY KEY (`spu_extend_id`)
);

CREATE TABLE `product_spu_tag_reference`  (
                                              `reference_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分组引用id',
                                              `shop_id` bigint NULL,
                                              `tag_id` bigint NULL,
                                              `spu_id` bigint NULL,
                                              `status` tinyint NULL,
                                              `sort` int NULL,
                                              `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                              `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                              PRIMARY KEY (`reference_id`)
);

CREATE TABLE `shop_cart_item`  (
                                   `cart_item_id` bigint NOT NULL,
                                   `shop_id` bigint NULL,
                                   `spu_id` bigint NULL,
                                   `sku_id` bigint NULL,
                                   `user_id` bigint NULL,
                                   `count` int NULL,
                                   `price_fee` bigint NULL,
                                   `is_checked` tinyint NULL COMMENT '是否已勾选',
                                   `create_time` datetime NULL,
                                   `update_time` datetime NULL,
                                   PRIMARY KEY (`cart_item_id`),
                                   UNIQUE INDEX `uk_user_shop_sku`(`shop_id`, `sku_id`, `user_id`) USING BTREE,
                                   UNIQUE INDEX `idx_user_id`(`user_id`) USING BTREE,
                                   UNIQUE INDEX `idx_shop_id`(`shop_id`) USING BTREE
);

CREATE TABLE `shop_info`  (
                              `shop_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
                              `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                              `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                              `shop_name` varchar(50) NOT NULL COMMENT '店铺名称',
                              `intro` varchar(255) NULL DEFAULT NULL COMMENT '店铺简介',
                              `shop_logo` varchar(255) NULL COMMENT '店铺logo(可修改)',
                              `mobile_background_pic` varchar(255) NULL COMMENT '店铺移动端背景图',
                              `shop_status` tinyint NOT NULL DEFAULT 1 COMMENT '店铺状态(-1:已删除 0: 停业中 1:营业中)',
                              `business_license` varchar(255) NOT NULL COMMENT '营业执照',
                              `identity_card_front` varchar(255) NULL DEFAULT NULL COMMENT '身份证正面',
                              `identity_card_later` varchar(255) NULL DEFAULT NULL COMMENT '身份证反面',
                              `type` tinyint NOT NULL DEFAULT 2 COMMENT '店铺类型1自营店 2普通店',
                              PRIMARY KEY (`shop_id`)
);

CREATE TABLE `shop_user`  (
                              `shop_user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '商家用户id',
                              `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                              `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                              `shop_id` bigint NOT NULL COMMENT '关联店铺id',
                              `nick_name` varchar(32) NOT NULL COMMENT '昵称',
                              `job_code` varchar(255) NULL DEFAULT NULL COMMENT '员工编号',
                              `phone_num` varchar(64) NULL COMMENT '联系方式',
                              PRIMARY KEY (`shop_user_id`),
                              INDEX `idx_shopid`(`shop_id`) USING BTREE
);

CREATE TABLE `spu_tag`  (
                            `id` bigint NOT NULL,
                            `create_time` datetime NULL,
                            `update_time` datetime NULL,
                            `title` varchar(36) NULL,
                            `shop_id` bigint NULL,
                            `status` tinyint NULL,
                            `is_default` tinyint NULL,
                            `prod_count` bigint NULL,
                            `style` int NULL,
                            `sort` int NULL,
                            `delete_time` datetime NULL,
                            PRIMARY KEY (`id`)
);

CREATE TABLE `system_config`  (
                                  `id` bigint NOT NULL COMMENT '主键id',
                                  `param_key` varchar(50) NOT NULL COMMENT 'key',
                                  `param_value` text NOT NULL COMMENT 'value',
                                  `remark` varchar(500) NULL DEFAULT NULL COMMENT '备注',
                                  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                  PRIMARY KEY (`id`),
                                  UNIQUE INDEX `param_key`(`param_key`) USING BTREE
);

CREATE TABLE `system_menu`  (
                                `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
                                `menu_name` varchar(32) NOT NULL COMMENT '菜单名称',
                                `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父菜单ID，一级菜单为0',
                                `biz_type` tinyint NOT NULL COMMENT '业务类型 1 店铺菜单 2平台菜单',
                                `perms` varchar(100) NULL COMMENT '权限标识',
                                `path` varchar(255) NULL DEFAULT '' COMMENT '路由地址',
                                `component` varchar(255) NULL DEFAULT NULL COMMENT '组件路径',
                                `title` varchar(255) NULL COMMENT '设置该路由在侧边栏和面包屑中展示的名字',
                                `query` varchar(255) NULL DEFAULT NULL COMMENT '路由参数',
                                `icon` varchar(32) NOT NULL DEFAULT # COMMENT '菜单图标',
                                `sort` int NOT NULL,
                                `visible` tinyint NOT NULL DEFAULT 0 COMMENT '菜单状态（0显示 1隐藏）',
                                `status` tinyint NOT NULL DEFAULT 0 COMMENT '菜单状态（0正常 1停用）',
                                `is_frame` tinyint NOT NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
                                `is_cache` tinyint NOT NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
                                `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `create_by` varchar(255) NULL COMMENT '创建者',
                                `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                `update_by` varchar(64) NULL COMMENT '更新者',
                                `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
                                PRIMARY KEY (`menu_id`)
);

CREATE TABLE `system_menu_permission`  (
                                           `menu_permission_id` bigint NOT NULL AUTO_INCREMENT,
                                           `create_time` datetime NULL,
                                           `update_time` datetime NULL,
                                           `menu_id` bigint NULL,
                                           `biz_type` tinyint NULL,
                                           `permission` varchar(255) NULL,
                                           `name` varchar(32) NULL,
                                           `uri` varchar(32) NULL,
                                           `method` tinyint NULL,
                                           PRIMARY KEY (`menu_permission_id`)
);

CREATE TABLE `system_role`  (
                                `role_id` bigint NULL AUTO_INCREMENT,
                                `role_name` varchar(32) NULL,
                                `role_key` varchar(100) NULL,
                                `sort` int NULL,
                                `data_scope` tinyint NULL,
                                `menu_check_strictly` tinyint NULL,
                                `dept_check_strictly` tinyint NULL,
                                `status` tinyint NULL,
                                `del_flag` tinyint NULL DEFAULT 0,
                                `create_time` datetime NULL,
                                `create_by` varchar(64) NULL,
                                `update_time` datetime NULL,
                                `update_by` varchar(64) NULL
);

CREATE TABLE `system_role_menu`  (
                                     `id` bigint NOT NULL COMMENT '主键id',
                                     `role_id` bigint NOT NULL COMMENT '角色ID',
                                     `menu_id` bigint NOT NULL COMMENT '菜单ID',
                                     `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                     PRIMARY KEY (`id`),
                                     UNIQUE INDEX `uni_role_menu`(`role_id`, `menu_id`) USING BTREE
);

CREATE TABLE `system_user`  (
                                `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户id',
                                `avatar` varchar(255) NULL COMMENT '头像',
                                `job_no` varchar(255) NULL,
                                `phone` varchar(64) NOT NULL DEFAULT '',
                                `nick_name` varchar(32) NOT NULL COMMENT '昵称',
                                `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                PRIMARY KEY (`user_id`)
) COMMENT = '平台用户';

CREATE TABLE `system_user_role`  (
                                     `id` bigint NOT NULL COMMENT '主键id',
                                     `user_id` bigint NOT NULL COMMENT '用户ID',
                                     `role_id` bigint NOT NULL COMMENT '角色ID',
                                     `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                     PRIMARY KEY (`id`),
                                     UNIQUE INDEX `uni_user_role`(`user_id`, `role_id`) USING BTREE
);

CREATE TABLE `user`  (
                         `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户id',
                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                         `nick_name` varchar(255) NULL DEFAULT NULL COMMENT '用户昵称',
                         `pic` varchar(255) NULL DEFAULT NULL COMMENT '头像图片路径',
                         `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态 1 正常 0 无效',
                         PRIMARY KEY (`user_id`)
);

CREATE TABLE `user_addr`  (
                              `addr_id` bigint NOT NULL COMMENT '地址id',
                              `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                              `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                              `user_id` bigint NOT NULL COMMENT '用户ID',
                              `mobile` varchar(20) NOT NULL COMMENT '手机',
                              `is_default` tinyint NOT NULL DEFAULT 0 COMMENT '是否默认地址 1是',
                              `consignee` varchar(50) NOT NULL COMMENT '收货人',
                              `province_id` bigint NULL DEFAULT NULL COMMENT '省ID',
                              `province` varchar(100) NULL DEFAULT NULL COMMENT '省',
                              `city_id` bigint NULL COMMENT '城市ID',
                              `city` varchar(20) NULL DEFAULT NULL COMMENT '城市',
                              `area_id` bigint NULL COMMENT '区ID',
                              `area` varchar(20) NULL COMMENT '区',
                              `post_code` varchar(15) NULL DEFAULT NULL COMMENT '邮编',
                              `addr` varchar(255) NULL COMMENT '地址',
                              `lng` decimal(12, 6) NULL COMMENT '经度',
                              `lat` decimal(12, 6) NULL COMMENT '纬度',
                              PRIMARY KEY (`addr_id`),
                              INDEX `idx_user_id`(`user_id`) USING BTREE
);

ALTER TABLE `order` ADD CONSTRAINT `fk_order_pay_info_1` FOREIGN KEY (`delivery_time`) REFERENCES `pay_info` (`pay_status`);
ALTER TABLE `order` ADD CONSTRAINT `fk_order_order_address_1` FOREIGN KEY (`cancel_time`) REFERENCES `order_address` (`city_id`);
ALTER TABLE `order_item` ADD CONSTRAINT `fk_order_item_order_1` FOREIGN KEY (`sku_name`) REFERENCES `order` (`status`);
ALTER TABLE `product_attr` ADD CONSTRAINT `fk_product_attr_product_attr_value_1` FOREIGN KEY (`desc`) REFERENCES `product_attr_value` (`create_time`);
ALTER TABLE `product_attr` ADD CONSTRAINT `fk_product_attr_product_sku_1` FOREIGN KEY (`search_type`) REFERENCES `product_sku` (`create_time`);
ALTER TABLE `product_brand` ADD CONSTRAINT `fk_product_brand_product_category_brand_1` FOREIGN KEY (`brand_id`) REFERENCES `product_category_brand` (`brand_id`);
ALTER TABLE `product_category` ADD CONSTRAINT `fk_product_category_product_category_brand_1` FOREIGN KEY (`category_id`) REFERENCES `product_category_brand` (`category_id`);
ALTER TABLE `product_sku` ADD CONSTRAINT `fk_product_sku_product_sku_stock_lock_1` FOREIGN KEY (`image_url`) REFERENCES `product_sku_stock_lock` (`sku_id`);
ALTER TABLE `product_sku` ADD CONSTRAINT `fk_product_sku_product_sku_stock_1` FOREIGN KEY (`image_url`) REFERENCES `product_sku_stock` (`sku_id`);
ALTER TABLE `product_sku` ADD CONSTRAINT `fk_product_sku_product_sku_attr_value_1` FOREIGN KEY (`attrs`) REFERENCES `product_sku_attr_value` (`spu_id`);
ALTER TABLE `product_sku` ADD CONSTRAINT `fk_product_sku_shop_cart_item_1` FOREIGN KEY (`create_time`) REFERENCES `shop_cart_item` (`spu_id`);
ALTER TABLE `product_spu` ADD CONSTRAINT `fk_product_spu_product_brand_1` FOREIGN KEY (`shop_id`) REFERENCES `product_brand` (`first_letter`);
ALTER TABLE `product_spu` ADD CONSTRAINT `fk_product_spu_product_sku_1` FOREIGN KEY (`main_img_url`) REFERENCES `product_sku` (`update_time`);
ALTER TABLE `product_spu` ADD CONSTRAINT `fk_product_spu_product_spu_detail_1` FOREIGN KEY (`brand_id`) REFERENCES `product_spu_detail` (`detail`);
ALTER TABLE `product_spu` ADD CONSTRAINT `fk_product_spu_product_spu_tag_reference_1` FOREIGN KEY (`price`) REFERENCES `product_spu_tag_reference` (`spu_id`);
ALTER TABLE `product_spu` ADD CONSTRAINT `fk_product_spu_product_spu_extension_1` FOREIGN KEY (`price`) REFERENCES `product_spu_extension` (`spu_id`);
ALTER TABLE `product_spu` ADD CONSTRAINT `fk_product_spu_product_spu_attr_value_1` FOREIGN KEY (`price`) REFERENCES `product_spu_attr_value` (`spu_id`);
ALTER TABLE `shop_cart_item` ADD CONSTRAINT `fk_shop_cart_item_shop_info_1` FOREIGN KEY (`user_id`) REFERENCES `shop_info` (`intro`);
ALTER TABLE `shop_info` ADD CONSTRAINT `fk_shop_info_shop_user_1` FOREIGN KEY (`shop_logo`) REFERENCES `shop_user` (`update_time`);
ALTER TABLE `shop_info` ADD CONSTRAINT `fk_shop_info_spu_tag_1` FOREIGN KEY (`shop_status`) REFERENCES `spu_tag` (`shop_id`);
ALTER TABLE `system_menu` ADD CONSTRAINT `fk_tb_student_table_1_1` FOREIGN KEY (`age`) REFERENCES `system_menu_permission` (`menu_permission_id`);
ALTER TABLE `system_menu` ADD CONSTRAINT `fk_system_menu_system_role_menu_1` FOREIGN KEY (`component`) REFERENCES `system_role_menu` (`role_id`);
ALTER TABLE `system_role` ADD CONSTRAINT `fk_system_role_system_user_role_1` FOREIGN KEY (`role_id`) REFERENCES `system_user_role` (`update_time`);
ALTER TABLE `system_role` ADD CONSTRAINT `fk_system_role_system_role_menu_1` FOREIGN KEY (`role_name`) REFERENCES `system_role_menu` (`create_time`);
ALTER TABLE `system_user` ADD CONSTRAINT `fk_system_user_system_user_role_1` FOREIGN KEY (`avatar`) REFERENCES `system_user_role` (`id`);
ALTER TABLE `user` ADD CONSTRAINT `fk_user_user_addr_1` FOREIGN KEY (`update_time`) REFERENCES `user_addr` (`update_time`);

CREATE VIEW `view_1` AS;

CREATE VIEW `view_2` AS;

CREATE VIEW `view_3` AS;

CREATE VIEW `view_4` AS;

