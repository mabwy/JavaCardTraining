package com.personaldata;

import javacard.framework.*;

public class PersonalDataApplet extends Applet {

    private static final byte[] name = {(byte)'M', (byte)'A', (byte)'N', (byte)'N'};
    private static final byte[] surname = {(byte)'M', (byte)'A', (byte)'S', (byte)'A', (byte)'S'};
    private static final byte[] dob = {(byte)'0', (byte)'1', (byte)'.', (byte)'0', (byte)'1', (byte)'.', (byte)'1', (byte)'9', (byte)'9', (byte)'0'};
    private static final byte[] expiry = {(byte)'0', (byte)'1', (byte)'.', (byte)'0', (byte)'1', (byte)'.', (byte)'2', (byte)'0', (byte)'2', (byte)'7'};

    private PersonalDataApplet() {}

    public static void install(byte[] bArray, short bOffset, byte bLength) {
        new PersonalDataApplet().register();
    }

    public void process(APDU apdu) {
        byte[] buffer = apdu.getBuffer();

        if (selectingApplet()) return;

        switch (buffer[ISO7816.OFFSET_INS]) {
            case (byte) 0x01: // اسم
                sendData(apdu, name);
                break;
            case (byte) 0x02: // لقب
                sendData(apdu, surname);
                break;
            case (byte) 0x03: // تاريخ الميلاد
                sendData(apdu, dob);
                break;
            case (byte) 0x04: // تاريخ الانتهاء
                sendData(apdu, expiry);
                break;
            default:
                ISOException.throwIt(ISO7816.SW_INS_NOT_SUPPORTED);
        }
    }

    private void sendData(APDU apdu, byte[] data) {
        byte[] buffer = apdu.getBuffer();
        short length = (short) data.length;
        Util.arrayCopy(data, (short) 0, buffer, (short) 0, length);
        apdu.setOutgoingAndSend((short) 0, length);
    }
}

