library(hexSticker)

library(showtext)

font_add_google("Ubuntu", "ubuntu")

showtext_auto()

sticker(
  "./data-raw/tools.png",
  package = "pkgdev",
  p_family = "ubuntu",
  s_width = 0.55,
  s_height = 0.55,
  s_x = 1,
  s_y = 0.85,
  p_color = "#d34615",
  p_size = 24,
  p_y = 1.6,
  h_fill = "white",
  h_color = "#d34615",
  filename = "man/figures/logo.png"
)
