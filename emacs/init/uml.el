(use-package plantuml-mode
  :ensure t
  :init
  (setq plantuml-jar-path (expand-file-name "~/lib/java/plantuml.jar")
        indent-tabs-mode nil
        tab-width 2)
  :mode
  ("\\.uml\\'" . plantuml-mode)
  ("\\.plantuml\\'" . plantuml-mode))