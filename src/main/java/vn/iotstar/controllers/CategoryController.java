package vn.iotstar.controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import vn.iotstar.services.ICategoryService;
import vn.iotstar.services.impl.CategoryServiceImpl;
import vn.iotstar.utils.Constant;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
@WebServlet(urlPatterns = {
    "/admin/categories",
    "/admin/category/add",
    "/admin/category/insert",
    "/admin/category/edit",
    "/admin/category/update",
    "/admin/category/delete"
})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/categories")) {
            List<Category> list = cateService.findAll();
            req.setAttribute("cateList", list);
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Category category = cateService.findById(id);
                req.setAttribute("category", category);
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
            }
        } else if (url.contains("/admin/category/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                cateService.delete(id);
                req.getSession().setAttribute("flashMessage", "Xóa danh mục thành công!");
            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("flashError", "Không thể xóa danh mục vì đang có sản phẩm liên kết!");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            String images = req.getParameter("images");

            Map<String, String> errors = new HashMap<>();

            // Server-side Validation
            if (categoryname == null || categoryname.trim().isEmpty()) {
                errors.put("categoryname", "Tên danh mục không được để trống!");
            } else if (categoryname.trim().length() < 2 || categoryname.trim().length() > 100) {
                errors.put("categoryname", "Tên danh mục phải có độ dài từ 2 đến 100 ký tự!");
            }

            int status = 1;
            try {
                if (statusStr != null) {
                    status = Integer.parseInt(statusStr);
                }
            } catch (NumberFormatException e) {
                status = 1;
            }

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("categoryname", categoryname);
                req.setAttribute("status", status);
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            Category category = new Category();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

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
                        part = req.getPart("images1");
                    }
                } catch (Exception ignored) {}

                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;

                    part.write(uploadPath + File.separator + fname);
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images.trim());
                } else {
                    category.setImages("default-category.png");
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");

        } else if (url.contains("/admin/category/edit") || url.contains("/admin/category/update")) {
            String categoryIdStr = req.getParameter("categoryId");
            if (categoryIdStr == null) {
                categoryIdStr = req.getParameter("categoryid");
            }
            int categoryId = Integer.parseInt(categoryIdStr);
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            String images = req.getParameter("images");

            Map<String, String> errors = new HashMap<>();

            // Server-side Validation
            if (categoryname == null || categoryname.trim().isEmpty()) {
                errors.put("categoryname", "Tên danh mục không được để trống!");
            } else if (categoryname.trim().length() < 2 || categoryname.trim().length() > 100) {
                errors.put("categoryname", "Tên danh mục phải có độ dài từ 2 đến 100 ký tự!");
            }

            int status = 1;
            try {
                if (statusStr != null) {
                    status = Integer.parseInt(statusStr);
                }
            } catch (NumberFormatException e) {
                status = 1;
            }

            Category category = cateService.findById(categoryId);

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                category.setCategoryname(categoryname);
                category.setStatus(status);
                req.setAttribute("category", category);
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }

            String fileold = category.getImages();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

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
                        part = req.getPart("images1");
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
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images.trim());
                } else {
                    category.setImages(fileold);
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }

            cateService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        if (Files.exists(path)) {
            Files.delete(path);
        }
    }
}
