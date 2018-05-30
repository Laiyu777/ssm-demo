package service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ShopDao;
import dao.UserDao;
import entity.Shop;
import service.ShopService;

@Service
public class ShopServiceImpl implements ShopService{

	@Autowired
	private ShopDao shopDao;
	@Autowired
	private UserDao userDao;
	
	@Override
	public Shop add(String user_id, String name, String description) {
		//�����ݿ����һ��shop�ļ�¼
		shopDao.add(user_id, name, description);
		//����User_id�����ݿ��ѯ�ղ����shop��¼��shop_id
		Shop shop= shopDao.selectByUser(user_id);
		Integer shop_id = shop.getId();
		//����user���shop_id�ֶ�
		userDao.updateIfShop(user_id,shop_id);
		
		return shop;
	}

	@Override
	public Shop updateShop(Shop shop) {
		shopDao.update(shop);
		return null;
	}

	@Override
	public Shop getOne(Integer id) {
		return shopDao.selectById(id);
	}

	@Override
	public Shop getOneByUserId(String user_id) {
		
		return shopDao.selectByUser(user_id);
	}

	@Override
	public int getShopIdByBookId(Integer book_id) {
		return shopDao.getShopIdByBookId(book_id);
	}
	
}
