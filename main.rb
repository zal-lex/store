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

films_paths = Dir["#{__dir__}/data/movies/*"]

films = films_paths.map do |path|
  Movie.from_file(path)
end

books_paths = Dir["#{__dir__}/data/books/*"]

books = books_paths.map do |path|
  Book.from_file(path)
end

# Выведем результат на экран
p films
p books

# Пытаемся вызвать метод from_file у класса Product и ловим ошибку
begin
  Product.from_file(__dir__ + '/data/movies/1.txt')
rescue NotImplementedError
  puts 'Метод класса Product.from_file не реализован'
end
