# ImageMagick's convert command
CONVERT=/usr/bin/convert

ifeq "$(RENDERER)" "pixie"
  # Pixie
  MAKE_TEXTURE=texmake
  RENDER=rndr
  COMPILE_SHADER=bin/sdrc
  SHADER_EXT=sdr
else ifeq "$(RENDERER)" "3delight"
  # 3delight
  MAKE_TEXTURE=tdlmake
  RENDER=renderdl
  COMPILE_SHADER=shaderdl
  SHADER_EXT=sdl
else ifeq "$(RENDERER)" "aqsis"
  # Aqsis
  MAKE_TEXTURE=teqser
  RENDER=aqsis
  COMPILE_SHADER=aqsl
  SHADER_EXT=slx
else
  # Photorealistic Renderman
  MAKE_TEXTURE=txmake
  RENDER=prman
  COMPILE_SHADER=shader
  SHADER_EXT=slo
endif

%.tif: %.jpg
	$(CONVERT) $< $@

%.tex: %.tif
	$(MAKE_TEXTURE) $< $@

%.$(SHADER_EXT): %.sl
	$(COMPILE_SHADER) $<
