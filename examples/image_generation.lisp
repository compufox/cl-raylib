(defpackage :raylib-user
  (:use :cl :raylib))

(in-package :raylib-user)

(defun main ()
  (let* ((screen-width 800)
         (screen-height 450)
         (title "raylib [shapes] example - Procedural images generation")
         (current-texture 0))
    (with-window (screen-width screen-height title)
      (let* ((vertical-gradient (gen-image-gradient-v screen-width screen-height +red+ +blue+))
             (horizontal-gradient (gen-image-gradient-h screen-width screen-height +red+ +blue+))
             (radial-gradient (gen-image-gradient-radial screen-width screen-height 0.0 +white+ +black+))
             (checked (gen-image-checked screen-width screen-height 32 32 +red+ +blue+))
             (white-noise (gen-image-white-noise screen-width screen-height 0.5))
             (perlin-noise (gen-image-perlin-noise screen-width screen-height 50 50 4.0))
             (cellular (gen-image-cellular screen-width screen-height 32))
             (textures (mapcar #'load-texture-from-image (list vertical-gradient horizontal-gradient radial-gradient
                                                               checked white-noise perlin-noise cellular))))
        (mapcar #'unload-image (list vertical-gradient horizontal-gradient radial-gradient
                                     checked white-noise perlin-noise cellular))

        (loop until (window-should-close)

              when (or (is-mouse-button-pressed +mouse-left-button+)
                       (is-key-pressed +key-right+))
                do (setf current-texture (mod (1+ current-texture)
                                              (length textures)))

              do
                 (with-drawing
                   (clear-background +raywhite+)

                   (draw-texture (elt textures current-texture) 0 0 +white+)

                   (draw-rectangle 30 400 325 30 (fade +skyblue+ 0.5))
                   (draw-rectangle-lines 30 400 325 30 (fade +white+ 0.5))
                   (draw-text "MOUSE LEFT BUTTON to CYCLE PROCEDURAL TEXTURES" 40 410 10 +white+)

                   (case current-texture
                     (0 (draw-text "VERTICAL GRADIENT" 560 10 20 +raywhite+))
                     (1 (draw-text "HORIZONTAL GRADIENT" 540 10 20 +raywhite+))
                     (2 (draw-text "RADIAL GRADIENT" 580 10 20 +lightgray+))
                     (3 (draw-text "CHECKED" 680 10 20 +raywhite+))
                     (4 (draw-text "WHITE NOISE" 640 10 20 +red+))
                     (5 (draw-text "PERLIN NOISE" 630 10 20 +raywhite+))
                     (6 (draw-text "CELLULAR" 670 10 20 +raywhite+)))))))))
