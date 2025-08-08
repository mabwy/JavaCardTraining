import java.io.*;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

public class ImageToByteArray {
    public static void main(String[] args) {
        try {
            File imageFile = new File("Copilot_20250808_002759.png");
            BufferedImage image = ImageIO.read(imageFile);

            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(image, "png", baos);
            baos.flush();
            byte[] imageBytes = baos.toByteArray();
            baos.close();

            System.out.println("private static final byte[] ROSE_IMAGE = {");
            for (int i = 0; i < imageBytes.length; i++) {
                System.out.print("(byte)0x" + String.format("%02X", imageBytes[i]));
                if (i != imageBytes.length - 1) System.out.print(", ");
                if ((i + 1) % 16 == 0) System.out.println();
            }
            System.out.println("};");

        } catch (IOException e) {
            System.err.println("❌ خطأ: " + e.getMessage());
        }
    }
}
