#!/bin/bash

# إعداد المشروع
git init
git add .
git commit -m "Initial commit"

# ربط المستودع البعيد
git remote add origin git@github.com:mabwy/JavaCardTraining.git

# رفع الفرع وربطه
git push --set-upstream origin main

