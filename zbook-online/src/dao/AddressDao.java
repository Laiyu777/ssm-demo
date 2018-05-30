package dao;

import java.util.List;

import entity.Address;

public interface AddressDao {

	void add(Address address);
	void delete(Integer id);
	Address selectOne(Integer id);
	List<Address> selectList(String user_id);
	void update(Address address);
}
