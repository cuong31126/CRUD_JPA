package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iotstar.configs.JPAConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDaoImpl implements IProductDao {

    @Override
    public void insert(Product product) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Product product = enma.find(Product.class, id);
            if (product != null) {
                enma.remove(product);
            } else {
                throw new Exception("Không tìm thấy Product với ID: " + id);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Product findById(int id) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            return enma.find(Product.class, id);
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<Product> query = enma.createNamedQuery("Product.findAll", Product.class);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<Product> query = enma.createNamedQuery("Product.findAll", Product.class);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public int count() {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT COUNT(p) FROM Product p";
        try {
            Query query = enma.createQuery(jpql);
            return ((Long) query.getSingleResult()).intValue();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findTop10Latest() {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p ORDER BY p.productId DESC";
        try {
            TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
            query.setFirstResult(0);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> findByCategoryId(int cateId) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p WHERE p.category.categoryId = :cateId ORDER BY p.productId DESC";
        try {
            TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
            query.setParameter("cateId", cateId);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Product> searchByName(String keyword) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p WHERE p.productName LIKE :keyword ORDER BY p.productId DESC";
        try {
            TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            enma.close();
        }
    }
}
