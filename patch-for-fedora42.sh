#!/bin/bash

echo "🔧 Patching scap-workbench source for Fedora 42 compatibility..."

# Fix range-for loop copies of QString
find src include -type f \( -name "*.cpp" -o -name "*.h" \) \
    -exec sed -i -E 's/for \((const QString) ([a-zA-Z0-9_]+) :/for (\1\& \2 :/g' {} +

# Replace deprecated Qt enums and methods
find src include -type f -exec sed -i 's/QString::SkipEmptyParts/Qt::SkipEmptyParts/g' {} +
find src include -type f -exec sed -i 's/\.toList()/\.values()/g' {} +
find src include -type f -exec sed -i -E 's/QSet<QString>::fromList\(([^)]+)\)/QSet<QString>(\1.begin(), \1.end())/g' {} +

echo "✅ Patch complete. You can now compile with CMake and make."
