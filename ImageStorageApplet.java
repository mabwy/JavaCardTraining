import javacard.framework.APDU;
import javacard.framework.Applet;
import javacard.framework.ISO7816;
import javacard.framework.ISOException;
import javacard.framework.Util;

public class ImageStorageApplet extends Applet {

    private static final byte INS_STORE_IMAGE = (byte) 0x10;
    private static final short MAX_IMAGE_SIZE = 256;
    private byte[] imageBuffer;
    private short imageLength;

    protected ImageStorageApplet() {
        imageBuffer = new byte[MAX_IMAGE_SIZE];
        imageLength = 0;
        register();
    }

    public static void install(byte[] bArray, short bOffset, byte bLength) {
        new ImageStorageApplet();
    }

    public void process(APDU apdu) {
        byte[] buffer = apdu.getBuffer();

        if (selectingApplet()) return;

        switch (buffer[ISO7816.OFFSET_INS]) {
            case INS_STORE_IMAGE:
                receiveImage(apdu);
                break;
            default:
                ISOException.throwIt(ISO7816.SW_INS_NOT_SUPPORTED);
        }
    }

    private void receiveImage(APDU apdu) {
        byte[] buffer = apdu.getBuffer();
        short bytesRead = apdu.setIncomingAndReceive();

        if ((short)(imageLength + bytesRead) > MAX_IMAGE_SIZE) {
            ISOException.throwIt(ISO7816.SW_WRONG_LENGTH);
        }

        Util.arrayCopy(buffer, ISO7816.OFFSET_CDATA, imageBuffer, imageLength, bytesRead);
        imageLength += bytesRead;
    }
}
