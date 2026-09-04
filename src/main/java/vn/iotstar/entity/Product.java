package vn.iotstar.entity;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "products")
@NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p ORDER BY p.productId DESC")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productId")
    private int productId;

    @Column(name = "productName", columnDefinition = "NVARCHAR(255) NOT NULL")
    private String productName;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX) NULL")
    private String description;

    @Column(name = "price")
    private Double price;

    @Column(name = "quantity")
    private Integer quantity = 0;

    @Column(name = "images", columnDefinition = "NVARCHAR(500) NULL")
    private String images;

    @Column(name = "status")
    private Integer status = 1; // 1: Hoạt động, 0: Khóa/Hết hàng

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "createDate")
    private Date createDate = new Date();

    // Quan hệ ManyToOne với Category
    @ManyToOne
    @JoinColumn(name = "categoryId")
    private Category category;
}
