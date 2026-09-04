package vn.iotstar.controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.services.impl.ProductServiceImpl;
import vn.iotstar.utils.Constant;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(urlPatterns = {
    "/admin/products",
    "/admin/product/add",
    "/admin/product/insert",
    "/admin/product/edit",
    "/admin/product/update",
    "/admin/product/delete"
})
public class AdminProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/products")) {
            List<Product> list = productService.findAll();
            req.setAttribute("productList", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/add")) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = productService.findById(id);
                List<Category> categories = categoryService.findAll();
                req.setAttribute("product", product);
                req.setAttribute("categories", categories);
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        } else if (url.contains("/admin/product/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/product/insert")) {
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String quantityStr = req.getParameter("quantity");
            String statusStr = req.getParameter("status");
            String categoryIdStr = req.getParameter("categoryId");
            String onlineImage = req.getParameter("images");

            Map<String, String> errors = new HashMap<>();

            // 1. Validation productName
            if (productName == null || productName.trim().isEmpty()) {
                errors.put("productName", "Tên sản phẩm không được để trống!");
            } else if (productName.trim().length() < 2 || productName.trim().length() > 200) {
                errors.put("productName", "Tên sản phẩm phải từ 2 đến 200 ký tự!");
            }

            // 2. Validation categoryId
            int categoryId = 0;
            if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                errors.put("categoryId", "Vui lòng chọn danh mục cho sản phẩm!");
            } else {
                try {
                    categoryId = Integer.parseInt(categoryIdStr.trim());
                } catch (NumberFormatException e) {
                    errors.put("categoryId", "Danh mục không hợp lệ!");
                }
            }

            // 3. Validation price
            double price = 0;
            if (priceStr == null || priceStr.trim().isEmpty()) {
                errors.put("price", "Giá sản phẩm không được để trống!");
            } else {
                try {
                    price = Double.parseDouble(priceStr.trim());
                    if (price < 0) {
                        errors.put("price", "Giá sản phẩm phải lớn hơn hoặc bằng 0!");
                    }
                } catch (NumberFormatException e) {
                    errors.put("price", "Định dạng giá không hợp lệ!");
                }
            }

            // 4. Validation quantity
            int quantity = 0;
            if (quantityStr == null || quantityStr.trim().isEmpty()) {
                errors.put("quantity", "Số lượng tồn kho không được để trống!");
            } else {
                try {
                    quantity = Integer.parseInt(quantityStr.trim());
                    if (quantity < 0) {
                        errors.put("quantity", "Số lượng phải lớn hơn hoặc bằng 0!");
                    }
                } catch (NumberFormatException e) {
                    errors.put("quantity", "Số lượng phải là số nguyên!");
                }
            }

            int status = 1;
            try {
                if (statusStr != null) {
                    status = Integer.parseInt(statusStr);
                }
            } catch (NumberFormatException ignored) {}

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("productName", productName);
                req.setAttribute("description", description);
                req.setAttribute("price", priceStr);
                req.setAttribute("quantity", quantityStr);
                req.setAttribute("status", status);
                req.setAttribute("categoryId", categoryId);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            Product product = new Product();
            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);
            product.setCreateDate(new Date());

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            // Xử lý upload file ảnh multipart
            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try {
                Part part = null;
                try {
                    part = req.getPart("images");
                    if (part == null || part.getSize() == 0) {
                        part = req.getPart("imageFile");
                    }
                } catch (Exception ignored) {}

                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;

                    part.write(uploadPath + File.separator + fname);
                    product.setImages(fname);
                } else if (onlineImage != null && !onlineImage.trim().isEmpty()) {
                    product.setImages(onlineImage.trim());
                } else {
                    product.setImages("product-default.png");
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if (url.contains("/admin/product/edit") || url.contains("/admin/product/update")) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String quantityStr = req.getParameter("quantity");
            String statusStr = req.getParameter("status");
            String categoryIdStr = req.getParameter("categoryId");
            String onlineImage = req.getParameter("images");

            Map<String, String> errors = new HashMap<>();

            // 1. Validation productName
            if (productName == null || productName.trim().isEmpty()) {
                errors.put("productName", "Tên sản phẩm không được để trống!");
            } else if (productName.trim().length() < 2 || productName.trim().length() > 200) {
                errors.put("productName", "Tên sản phẩm phải từ 2 đến 200 ký tự!");
            }

            // 2. Validation categoryId
            int categoryId = 0;
            if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                errors.put("categoryId", "Vui lòng chọn danh mục cho sản phẩm!");
            } else {
                try {
                    categoryId = Integer.parseInt(categoryIdStr.trim());
                } catch (NumberFormatException e) {
                    errors.put("categoryId", "Danh mục không hợp lệ!");
                }
            }

            // 3. Validation price
            double price = 0;
            if (priceStr == null || priceStr.trim().isEmpty()) {
                errors.put("price", "Giá sản phẩm không được để trống!");
            } else {
                try {
                    price = Double.parseDouble(priceStr.trim());
                    if (price < 0) {
                        errors.put("price", "Giá sản phẩm phải lớn hơn hoặc bằng 0!");
                    }
                } catch (NumberFormatException e) {
                    errors.put("price", "Định dạng giá không hợp lệ!");
                }
            }

            // 4. Validation quantity
            int quantity = 0;
            if (quantityStr == null || quantityStr.trim().isEmpty()) {
                errors.put("quantity", "Số lượng tồn kho không được để trống!");
            } else {
                try {
                    quantity = Integer.parseInt(quantityStr.trim());
                    if (quantity < 0) {
                        errors.put("quantity", "Số lượng phải lớn hơn hoặc bằng 0!");
                    }
                } catch (NumberFormatException e) {
                    errors.put("quantity", "Số lượng phải là số nguyên!");
                }
            }

            int status = 1;
            try {
                if (statusStr != null) {
                    status = Integer.parseInt(statusStr);
                }
            } catch (NumberFormatException ignored) {}

            Product product = productService.findById(productId);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                product.setProductName(productName);
                product.setDescription(description);
                if (priceStr != null && !priceStr.isEmpty()) {
                    try { product.setPrice(Double.parseDouble(priceStr)); } catch (Exception ignored) {}
                }
                if (quantityStr != null && !quantityStr.isEmpty()) {
                    try { product.setQuantity(Integer.parseInt(quantityStr)); } catch (Exception ignored) {}
                }
                product.setStatus(status);
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            String fileold = product.getImages();
            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);

            Category category = categoryService.findById(categoryId);
            product.setCategory(category);

            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try {
                Part part = null;
                try {
                    part = req.getPart("images_file");
                    if (part == null || part.getSize() == 0) {
                        part = req.getPart("imageFile");
                    }
                    if (part == null || part.getSize() == 0) {
                        part = req.getPart("images");
                    }
                } catch (Exception ignored) {}

                if (part != null && part.getSize() > 0) {
                    if (fileold != null && !fileold.startsWith("http")) {
                        deleteFile(uploadPath + File.separator + fileold);
                    }
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;

                    part.write(uploadPath + File.separator + fname);
                    product.setImages(fname);
                } else if (onlineImage != null && !onlineImage.trim().isEmpty()) {
                    product.setImages(onlineImage.trim());
                } else {
                    product.setImages(fileold);
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        if (Files.exists(path)) {
            Files.delete(path);
        }
    }
}
