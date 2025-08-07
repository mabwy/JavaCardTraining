#!/bin/bash

# 🎨 ألوان للتفاعل البصري
G='\033[0;32m'  # أخضر
R='\033[0;31m'  # أحمر
Y='\033[1;33m'  # أصفر
N='\033[0m'     # إعادة ضبط اللون

# 📦 اسم ملف CAP
CAP_FILE="MemoryCardApplet.cap"

# 🆔 معرفات التطبيق (يمكنك تعديلها لاحقًا)
PACKAGE_AID="A000000001"
APPLET_AID="A00000000101"
KEYS="default"

# ✅ التحقق من وجود الملف
if [ ! -f "$CAP_FILE" ]; then
    echo -e "${R}❌ الملف $CAP_FILE غير موجود في المجلد الحالي.${N}"
    exit 1
fi

# 🚀 تثبيت التطبيق
echo -e "${Y}🚀 جاري تثبيت التطبيق على البطاقة...${N}"
java -jar gp.jar --install "$CAP_FILE" --package "$PACKAGE_AID" --applet "$APPLET_AID" --key "$KEYS"

# 📋 عرض التطبيقات المثبتة
echo -e "${G}📋 التطبيقات المثبتة الآن:${N}"
java -jar gp.jar --listapps --key "$KEYS"

# 📡 إرسال SELECT للتطبيق
echo -e "${Y}📡 إرسال SELECT للتطبيق...${N}"
java -jar gp.jar --select "$APPLET_AID" --key "$KEYS"

# 🎊 ختام مفرح
echo -e "${G}🎊 تم تثبيت التطبيق بنجاح! أنت الآن تتحكم في البطاقة الذكية يا مهند 👑${N}"

