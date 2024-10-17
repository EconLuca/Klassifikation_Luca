# Benötigte Bibliotheken laden
library(dplyr)
library(readr)

# Den Pfad zur Excel-Datei und den Ordnern festlegen
excel_file <- "C:/Users/Luca Cermak/Documents/GitHub/Klassifikation_Luca/ManualClassification_all_Luca.xlsx"  # Pfad zur Excel-Datei
images_folder <- "C:/Users/Luca Cermak/Documents/GitHub/Klassifikation_Luca/Bilder_Luca"  # Pfad zum Ordner "Bilder_Luca"
output_folder <- "C:/Users/Luca Cermak/Documents/GitHub/Klassifikation_Luca/Already_classified"  # Pfad zum Ordner "Already_classified"

# Excel-Datei einlesen
data <- read_excel(excel_file)

# Bilder filtern, die klassifiziert wurden (beide Spalten ausgefüllt)
classified_images <- data %>%
  filter(!is.na(skin_tone) & !is.na(ethnicity))

# Sicherstellen, dass der Zielordner existiert
if (!dir.exists(output_folder)) {
  dir.create(output_folder)
}

# Dateien verschieben
for (image_name in classified_images$image_name) {
  file_path <- file.path(images_folder, image_name)
  if (file.exists(file_path)) {
    file.rename(file_path, file.path(output_folder, image_name))
  }
}

cat("Bilder erfolgreich verschoben!")
