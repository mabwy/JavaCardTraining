#!/bin/bash

# مسار المشروع
PROJECT_DIR=~/Downloads/MemoryCardApplet/GlobalPlatformPro-next

# اسم الملف الناتج
JAR_NAME=GlobalPlatformPro.jar

# انتقل إلى مجلد المشروع
cd "$PROJECT_DIR" || { echo "❌ لم يتم العثور على المجلد"; exit 1; }

# بناء المشروع باستخدام Maven
echo "🔨 جاري بناء المشروع..."
mvn clean package || { echo "❌ فشل البناء"; exit 1; }

# البحث عن الملف التنفيذي الناتج
JAR_PATH=$(find "$PROJECT_DIR" -name "*shaded.jar" | head -n 1)

# التحقق من وجود الملف
if [ -z "$JAR_PATH" ]; then
    echo "❌ لم يتم العثور على الملف التنفيذي"
    exit 1
fi

# نسخه إلى مجلد العمل باسم موحد
cp "$JAR_PATH" ~/Downloads/MemoryCardApplet/"$JAR_NAME"
echo "✅ تم نسخ الملف إلى ~/Downloads/MemoryCardApplet/$JAR_NAME"

# تشغيل الأداة
echo "🚀 تشغيل GlobalPlatformPro..."
java -jar ~/Downloads/MemoryCardApplet/"$JAR_NAME" "$@"

