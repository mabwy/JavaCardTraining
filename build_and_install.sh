#!/bin/bash

# إعداد المسارات
JC_HOME="$HOME/Downloads/MemoryCardApplet/javacard-sdk"
APPLET_NAME="ImageStorageApplet"
CONFIG_FILE="config.xml"
OUTPUT_DIR="output"

echo "🔧 [1] ترجمة التطبيق..."
javac -source 1.6 -target 1.6 -classpath "$JC_HOME/lib/api_classic-3.0.5.jar" *.java || { echo "❌ فشل في الترجمة"; exit 1; }

echo "📦 [2] تحويل إلى CAP..."
$JC_HOME/bin/converter $CONFIG_FILE || { echo "❌ فشل في التحويل"; exit 1; }

echo "🔍 [3] البحث عن ملف CAP..."
CAP_FILE=$(find $OUTPUT_DIR -name "*.cap" | head -n 1)

if [ -z "$CAP_FILE" ]; then
    echo "❌ لم يتم العثور على ملف CAP"
    exit 1
fi

echo "💳 [4] تثبيت التطبيق على البطاقة..."
gp -install "$CAP_FILE" || { echo "❌ فشل في التثبيت"; exit 1; }

echo "✅ تم التثبيت بنجاح: $CAP_FILE"

