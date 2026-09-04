package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Product;

public interface IProductDao {
    void insert(Product product);
    void update(Product product);
    void delete(int id) throws Exception;
    Product findById(int id);
    List<Product> findAll();
    List<Product> findAll(int page, int pageSize);
    int count();
    List<Product> findTop10Latest();
    List<Product> findByCategoryId(int cateId);
    List<Product> searchByName(String keyword);
}
