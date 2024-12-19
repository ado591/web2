package servlets;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import data.Response;
import data.ResultContainer;
import util.Validator;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet(name = "areaCheck", value = "/check")
public class AreaCheckServlet extends HttpServlet {
    static DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Response jsonResponse = new Response();
        ResultContainer resultList = (ResultContainer) req.getServletContext().getAttribute("results");

        long startTime = System.nanoTime();
        try {
            Map<String, String> params = getQueryParams(req);
            double x = parseAndValidateDouble(params.get("x"), "x");
            double y = parseAndValidateDouble(params.get("y"), "y");
            double r = parseAndValidateDouble(params.get("r"), "r");

            Validator.containsValidInput(x, y, r);

            jsonResponse.setX(x);
            jsonResponse.setY(y);
            jsonResponse.setR(r);

            boolean isInFigure = doLogic(x, y, r);
            jsonResponse.setData(String.valueOf(isInFigure));
            resp.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            jsonResponse.setError(e.getMessage());
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        finally {
            jsonResponse.setExecuteTime(String.valueOf(System.nanoTime() - startTime));
            jsonResponse.setServerTime(LocalDateTime.now().format(formatter));

            resultList.add(jsonResponse);
            resp.setContentType("application/json");
            req.getRequestDispatcher("/jsp/table.jsp").forward(req, resp);

            new Gson().toJson(jsonResponse, resp.getWriter());
            resp.getWriter().flush();
        }
    }


    private boolean doLogic(double x, double y, double r) {
        double[][] polygon1 = {
                {0.35 * r, 0.75 * r},
                {-0.6 * r, -0.3 * r},
                {-0.25 * r, -0.3 * r},
                {0.6 * r, 0.75 * r}
        };

        double[][] polygon2 = {
                {-0.2 * r, 0.75 * r},
                {-0.6 * r, 0.35 * r},
                {-0.35 * r, 0.35 * r},
                {0.05 * r, 0.75 * r}
        };

        double[][] polygon3 = {
                {0.35 * r, 0.1 * r},
                {0, -0.3 * r},
                {0.25, -0.3 * r},
                {0.6 * r, 0.1 * r}
        };

        boolean insideRectangle1 = isInsideRectangle(x, y, -0.6 * r, r, 1.2 * r, 0.25 * r);
        boolean insideRectangle2 = isInsideRectangle(x, y, -0.6 * r, 0.35 * r, 1.2 * r, 0.25 * r);
        boolean insideRectangle3 = isInsideRectangle(x, y, -0.6 * r, -0.3 * r, 1.2 * r, 0.25 * r);
        boolean insidePolygon1 = isInsidePolygon(x, y, polygon1);
        boolean insidePolygon2 = isInsidePolygon(x, y, polygon2);
        boolean insidePolygon3 = isInsidePolygon(x, y, polygon3);

        return insideRectangle1 || insideRectangle2 || insideRectangle3 ||
                insidePolygon1 || insidePolygon2 || insidePolygon3;
    }


    private static Map<String, String> getQueryParams(HttpServletRequest req) {
        Map<String, String> params = new HashMap<>();
        String queryParams = req.getQueryString();

        if (queryParams != null && !queryParams.isEmpty()) {
            String[] pairs = queryParams.split("&");
            for (String pair : pairs) {
                String[] keyValue = pair.split("=");
                if (keyValue.length == 2) {
                    params.put(keyValue[0], keyValue[1]);
                }
            }
        }

        if (!params.containsKey("x") || !params.containsKey("y") || !params.containsKey("r")) {
            throw new IllegalArgumentException("Не хватает чего то из (x, y, r).");
        }
        return params;
    }


    private static double parseAndValidateDouble(String value, String paramName) throws IllegalArgumentException {
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(String.format("Неверный параметр '%s'. Требуется число.", paramName));
        }
    }

    private static boolean isInsideRectangle(double px, double py, double rectX, double rectY, double width, double height) {
        return (px >= rectX && px <= rectX + width) && (py <= rectY && py >= rectY - height);
    }

    private static boolean isInsidePolygon(double px, double py, double[][] polygon) {
        int n = polygon.length;
        boolean inside = false;

        for (int i = 0, j = n - 1; i < n; j = i++) {
            double xi = polygon[i][0], yi = polygon[i][1];
            double xj = polygon[j][0], yj = polygon[j][1];

            boolean intersect = ((yi > py) != (yj > py)) && (px < (xj - xi) * (py - yi) / (yj - yi) + xi);
            if (intersect) {
                inside = !inside;
            }
        }

        return inside;
    }

}