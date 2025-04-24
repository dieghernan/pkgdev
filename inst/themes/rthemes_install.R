f <- system.file("themes", package = "pkgdev")

allt <- list.files(f,pattern = ".rstheme", full.names = TRUE)

for(t in allt){
  rstudioapi::addTheme(t, force = TRUE, apply = FALSE)
}

rstudioapi::applyTheme("Selenized Dark")

