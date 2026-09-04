package vn.iotstar.controllers;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Product;
import vn.iotstar.services.IProductService;
import vn.iotstar.services.impl.ProductServiceImpl;

@WebServlet(urlPatterns = { "/product", "/product/detail" })
public class ProductClientController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (uri.contains("/product/detail")) {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                Product product = productService.findById(id);
                if (product != null) {
                    req.setAttribute("product", product);
                    if (product.getCategory() != null) {
                        List<Product> relatedProducts = productService.findByCategoryId(product.getCategory().getCategoryId());
                        req.setAttribute("relatedProducts", relatedProducts);
                    }
                }
            }
            req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
        } else {
            // Phân trang: 6 sản phẩm / trang
            int pageSize = 6;
            int page = 1;
            String pageStr = req.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            List<Product> productList = productService.findAll(page - 1, pageSize);
            int totalCount = productService.count();
            int totalPage = (int) Math.ceil((double) totalCount / pageSize);
            if (totalPage == 0) totalPage = 1;

            req.setAttribute("productList", productList);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPage", totalPage);
            req.setAttribute("totalCount", totalCount);

            req.getRequestDispatcher("/views/web/product-list.jsp").forward(req, resp);
        }
    }
}
