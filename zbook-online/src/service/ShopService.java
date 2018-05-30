package service;

import entity.Shop;

public interface ShopService {
	public Shop add(String user_id,String name,String description);
	Shop updateShop(Shop shop);
	Shop getOne(Integer id);
	Shop getOneByUserId(String user_id);
	int  getShopIdByBookId(Integer book_id);
}
