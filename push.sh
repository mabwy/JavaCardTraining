#!/bin/bash

echo "🔄 Preparing to push changes..."

git add .
git commit -m "تحديث تلقائي"
git push

echo "✅ Done!"
x#!/bin/bash

# إعداد المشروع
git init
git add .
git commit -m "Initial commit"

# ربط المستودع البعيد
git remote add origin git@github.com:mabwy/JavaCardTraining.git

# رفع الفرع وربطه
git push --set-upstream origin main

