# 🛠️ AutoCAD LISP Toolkit for Survey & Construction Annotation

> **Automate elevation calculations, fact/project comparisons, and smart text updates in Civil Engineering drawings — all inside AutoCAD!**

This repository contains a set of powerful **AutoLISP utilities** designed for surveyors, civil engineers, and CAD technicians working with **project vs. as-built (fact) elevation data** in AutoCAD. Whether you're processing field measurements or preparing construction documentation, these tools help you **extract, compute, and update annotations** with precision and speed.

---

## 🌟 Key Features

### 🔢 Smart Text Parsing
- Extract **project elevation** (e.g., `3.512`) and **fact value** (e.g., `(3.498)`) from:
  - `TEXT`
  - `MTEXT`
  - `MULTILEADER`
  - `DIMENSION`
- Handles formats like:  
  `3.512\P(3.498)` or `3.512\X(3.498)`

### ➕ On-the-Fly Calculations
- **Add two fact values** and write the sum into a third annotation.
- Compute **differences**, **averages**, or custom logic (extendable!).

### 📝 Auto-Formatting & Update
- Automatically format numbers to **3 decimal places** (mm precision).
- Preserve **"+" signs** and **multiline formatting** in multileaders.
- Update both **project and fact** parts in a single call.

### 🧪 Robust & Safe
- Type-safe parsing (`atof`, `atoi`, string validation).
- Handles edge cases: empty fact fields, single-value labels, mixed object types.

---

## 📁 File Overview

| File | Purpose |
|------|--------|
| `TextProcessing.txt` | Core library: parsing, number extraction, text updating |
| `21sumrazcpyinproj.txt` | Example command: **sum two fact values** and write result + project value into a third label |

> 💡 **Note**: These `.txt` files are actually **AutoLISP source code** — rename to `.lsp` to load in AutoCAD.

---

## 🚀 How to Use

### 1. Load into AutoCAD
```lisp
(load "TextProcessing.lsp")
(load "21sumrazcpyinproj.lsp")
```

### 2. Run the Example Command
Type in AutoCAD command line:
```
21sumrazcpyinprojV02
```
Then:
1. Select **first fact label** (e.g., `(3.450)`)
2. Select **second fact label** (e.g., `(3.520)`)
3. Select **target label** — the sum (`6.970`) and its project value will be written automatically!

> The tool intelligently detects object type and updates text while preserving formatting.

---

## 🔧 Core Functions (for Developers)

| Function | Description |
|--------|-------------|
| `getProjectElevFromItemProectText` | Extract project elevation as **string** |
| `getProjectElevFromItemFactText` | Extract fact value (inside parentheses) as **string** |
| `getIntProjectElevation` / `getIntFactElevation` | Return values in **millimeters as integers** (×1000) |
| `changeItemSmartProectFact` | Update both project and fact parts in one go |
| `find_num_before` / `find_number` | Parse numbers before/inside parentheses |

---

## 💡 Use Cases

- **As-built vs. design comparison** in road/earthwork projects
- **Automated QA/QC** of survey point annotations
- **Batch updating** of elevation labels after field revisions
- **Custom calculation scripts** (e.g., average of 5 points, deviation alerts)

---

## 🛠️ Extend It!

Want to compute **deviation = fact – project**? Add a new command:
```lisp
(defun C:DEVIATION ( / prop proj fact dev)
  (setq prop (entget (car (entsel "\nSelect label: "))))
  (setq proj (getIntProjectElevation prop))
  (setq fact (getIntFactElevation prop))
  (setq dev (- fact proj))
  (princ (strcat "\nDeviation: " (rtos (/ dev 1000.0) 2 3) " m"))
  (princ)
)
```

---

## 📜 License

MIT License — free for personal and commercial use.

---

## 👷 Author

Crafted by a civil engineer for civil engineers.  
Optimized for **real-world AutoCAD workflows** in Russian and international projects.

---

> 💬 **Pro Tip**: Combine with **AutoCAD Scripts (.scr)** or **.NET plugins** for full automation pipelines!
