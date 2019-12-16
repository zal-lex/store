# encoding: utf-8
#
# Программа-магазин книг и фильмов. Версия 0.1 — заготовка.
#
# Этот код необходим только при использовании русских букв на Windows
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'

leon = Movie.new(title: 'Леон', cost: 290, in_stock: 5)

puts "Фильм #{leon.title} стоит #{leon.cost} руб."
