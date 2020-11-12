(defpackage :raylib-user
  (:use :cl :raylib))

(in-package :raylib-user)

(defvar +num-frames+ 3)

(defun main ()
  (let* ((screen-width 800)
         (screen-height 450)
         (title "raylib [shapes] example - sprite button"))
    (with-window (screen-width screen-height title)
      (with-audio-device
        (let* ((fx-button (load-sound "resources/buttonfx.wav"))
               (button (load-texture "resources/button.png"))
               (frame-height (float (/ (texture-height button) +num-frames+)))
               (source-rec (make-rectangle :x 0.0 :y 0.0
                                           :width (float (texture-width button))
                                           :height frame-height))
               (btn-bounds (make-rectangle :x (- (/ screen-width 2.0)
                                                 (/ (texture-width button) 2))
                                           :y (- (/ screen-height 2.0)
                                                 (/ (/ (texture-height button) 2)
                                                    (/ +num-frames+ 2)))
                                           :width (float (texture-width button))
                                           :height frame-height))
               ;; 0 - normal
               ;; 1 - mouse-hover
               ;; 2 - pressed
               (btn-state 0))
          (set-target-fps 60)
          
          (loop until (window-should-close)
                for mouse-point = (get-mouse-position)
                for btn-action = nil

                if (check-collision-point-rec mouse-point btn-bounds) do
                  (setf btn-state (if (is-mouse-button-down +mouse-left-button+) 2 1)
                        btn-action (when (is-mouse-button-released +mouse-left-button+) t))
                else do
                  (setf btn-state 0)

                if btn-action do
                  (play-sound fx-button)

                do
                   (setf (rectangle-y source-rec) (* btn-state frame-height))
                   (with-drawing
                     (clear-background +raywhite+)

                     (draw-texture-rec button source-rec
                                       (make-vector2 :x (rectangle-x btn-bounds) :y (rectangle-y btn-bounds))
                                       +white+))

                finally
                   (unload-texture button)
                   (unload-sound fx-button)))))))
                     
