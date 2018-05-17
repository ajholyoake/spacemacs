;;; packages.el --- Debug Layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: troy.j.hinckley <troy.hinckley@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst debug-packages
  '(realgud))

(defun debug/init-realgud()
  (eval
   `(use-package realgud
      :defer t
      :commands
      ,(append debug-autoload-debuggers
               (mapcar 'spacemacs/debug-generate-symbol
                       (if (listp debug-additional-debuggers)
                           debug-additional-debuggers
                         (list debug-additional-debuggers))))

      :init
      (advice-add 'realgud-short-key-mode-setup
                  :before #'spacemacs/debug-short-key-state)

      (add-hook 'realgud-short-key-mode-hook
                'spacemacs/realgud-transient-state/body)

      (evilified-state-evilify-map realgud:shortkey-mode-map
        :eval-after-load realgud
        :mode realgud-short-key-mode
        :bindings
        "bb" 'realgud:cmd-break
        "bc" 'realgud:cmd-clear
        "bd" 'realgud:cmd-delete
        "be" 'realgud:cmd-enable
        "bs" 'realgud:cmd-disable

        "c" 'realgud:cmd-continue
        "i" 'realgud:cmd-step
        "J" 'realgud:cmd-jump
        "o" 'realgud:cmd-finish
        "q" 'realgud-short-key-mode-off
        "Q" 'realgud:cmd-quit
        "r" 'realgud:cmd-restart
        "s" 'realgud:cmd-next
        "S" 'realgud-window-cmd-undisturb-src

        "v" 'spacemacs/debug-eval-dwim))))

