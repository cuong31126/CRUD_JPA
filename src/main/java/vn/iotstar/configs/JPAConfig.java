package vn.iotstar.configs;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAConfig {

    private static EntityManagerFactory factory;

    static {
        try {
            factory = Persistence.createEntityManagerFactory("jpa-hibernate-mysql");
        } catch (Throwable ex) {
            System.err.println("=== CHI TIẾT LỖI KẾT NỐI JPA/HIBERNATE ===");
            ex.printStackTrace();
            if (ex.getCause() != null) {
                System.err.println("Root Cause: " + ex.getCause().getMessage());
            }
            throw new RuntimeException("Không thể khởi tạo EntityManagerFactory: " + ex.getMessage(), ex);
        }
    }

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }

    public static void shutdown() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
