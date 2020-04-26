pintor_sources = [
  'App.vala',
  'Window.vala',
  'Lienzo.vala',
  'PanelTools.vala',
  'Tool.vala'
]

pintor_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('granite'),
    dependency('libxml-2.0'),
    dependency('libarchive'),

]

gnome = import('gnome')



executable('com.github.djmbdv.pintor', pintor_sources,
  vala_args: '--target-glib=2.50',  dependencies:pintor_deps,
  install: true,
)
