package vn.iotstar.dao.impl;

import java.time.LocalDateTime;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.iotstar.configs.JPAConfig;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.entity.User;

public class UserDaoImpl implements IUserDao {

    @Override
    public void insert(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user);
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
    public void update(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(user);
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
            User user = enma.find(User.class, id);
            if (user != null) {
                enma.remove(user);
            } else {
                throw new Exception("Không tìm thấy User với ID: " + id);
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
    public User findById(int id) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            return enma.find(User.class, id);
        } finally {
            enma.close();
        }
    }

    @Override
    public User findByUsername(String username) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.username = :username";
        try {
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            enma.close();
        }
    }

    @Override
    public User findByEmail(String email) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.email = :email";
        try {
            TypedQuery<User> query = enma.createQuery(jpql, User.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            enma.close();
        }
    }

    @Override
    public List<User> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<User> query = enma.createNamedQuery("User.findAll", User.class);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean updateOtp(String email, String otp, LocalDateTime expiry) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            String jpql = "UPDATE User u SET u.code = :otp, u.otpExpiry = :expiry WHERE u.email = :email";
            int rowsUpdated = enma.createQuery(jpql)
                    .setParameter("otp", otp)
                    .setParameter("expiry", expiry)
                    .setParameter("email", email)
                    .executeUpdate();
            trans.commit();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            return false;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        User user = findByEmail(email);
        if (user != null && user.getCode() != null && user.getCode().equals(otp)) {
            if (user.getOtpExpiry() != null && user.getOtpExpiry().isAfter(LocalDateTime.now())) {
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean activateUser(String email) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            String jpql = "UPDATE User u SET u.status = 1, u.code = null, u.otpExpiry = null WHERE u.email = :email";
            int rowsUpdated = enma.createQuery(jpql)
                    .setParameter("email", email)
                    .executeUpdate();
            trans.commit();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            return false;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean updatePassword(String email, String newPassword) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            String jpql = "UPDATE User u SET u.password = :password, u.code = null, u.otpExpiry = null WHERE u.email = :email";
            int rowsUpdated = enma.createQuery(jpql)
                    .setParameter("password", newPassword)
                    .setParameter("email", email)
                    .executeUpdate();
            trans.commit();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
            return false;
        } finally {
            enma.close();
        }
    }

    @Override
    public User checkLogin(String username, String password) {
        User user = findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
