(defpackage :raylib-user
  (:use :cl :raylib))

(in-package :raylib-user)

(defun main ()
  (let* ((screen-width 800)
         (screen-height 450)
         (title "raylib [shapes] example - music playing (streaming)"))
    (with-window (screen-width screen-height title)
      (with-audio-device
        (let ((music (load-music-stream "resources/country.mp3"))
              (time-played 0.0))
          (set-target-fps 60)
          (play-music-stream music)

          (loop with pause = nil
                until (window-should-close)

                do (update-music-stream music)

                if (is-key-pressed +key-space+) do
                  (stop-music-stream music)
                  (play-music-stream music)

                if (is-key-pressed +key-p+) do
                  (setf pause (not pause))
                  (if pause (pause-music-stream music) (resume-music-stream music))

                do
                   (setf time-played (* (/ (get-music-time-played music) (get-music-time-length music)) 400))
                   
                   (when (> time-played 400)
                     (stop-music-stream music))

                   (with-drawing
                     (clear-background +raywhite+)
                     
                     (draw-text "MUSIC SHOULD BE PLAYING!" 255 150 20 +lightgray+)

                     (draw-rectangle 200 200 400 12 +lightgray+)
                     ;; truncate time-played to convert it into an int
                     (draw-rectangle 200 200 (truncate time-played) 12 +maroon+)
                     (draw-rectangle-lines 200 200 400 12 +gray+)

                     (draw-text "PRESS SPACE TO RESTART MUSIC" 215 250 20 +lightgray+)
                     (draw-text "PRESS P TO PAUSE/RESUME MUSIC" 208 280 20 +lightgray+))

                finally (unload-music-stream music)))))))
