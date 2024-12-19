package util;


import java.util.ArrayList;
import java.util.Arrays;

public class Validator {
    private static ArrayList<Integer> validValues = new ArrayList<>(Arrays.asList(-5, -4, -3, -2, -1, 0, 1, 2, 3));
    public static boolean containsValidInput(Double x, Double y, Double r) {
        if (!validValues.contains(x)) {
            throw new IllegalArgumentException("Недопустимое значение х");
        }
        if (y < -3 || y > 5) {
            throw new IllegalArgumentException("Недопустимое значение y");
        }
        if (r < 1 || r > 4) {
            throw new IllegalArgumentException("Недопустимое значение r");
        }
        return true;
    }
}
