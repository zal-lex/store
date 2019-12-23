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
require_relative 'lib/disk'
require_relative 'lib/product_collection'

collection = ProductCollection.from_dir("#{__dir__}/data")

collection.sort!(by: :title, order: :asc)

# В массиве purchases как в корзине магазина будем хранить покупки
purchases = []
# Заведём переменную с заведомо неверным значением, чтобы цикл начал выполняться
user_choice = -1
# Ещё в одной переменной будем хранить общую стоимость покупок
total_cost = 0
# В цикле выводим пользователю список товаров, спрашиваем, что он хочет купить,
# уменьшаем количество соответствующего товара на 1, сохраняем выбор в корзине и
# показываем его (выбор) пользователю, обновляем и выводим стоимость покупок в корзине.
until user_choice == 0
  puts "\nЧто хотите купить:"
  puts
  # Выводим список товаров
  puts collection
  puts '0. Выход'
  puts
  # Спрашиваем у пользователя, что он хочет купить
  until (0..collection.to_a.size).include?(user_choice = STDIN.gets.to_i)
    puts "Введите число от '0' до '#{collection.to_a.size}': "
  end

  unless user_choice == 0
    # Уменьшаем количество выбанного товара на складе
    collection.product_by_index(user_choice).amount -= 1
    # Вносим выбранный товар в список покупок
    purchases << collection.product_by_index(user_choice)
    # Прибавляем стоимость товара к общей стоимости товаров в корзине
    total_cost += collection.product_by_index(user_choice).price
    puts "\nВы выбрали: #{collection.product_by_index(user_choice)}"
    puts "\nВсего товаров на сумму: #{total_cost} руб."
  end
end

unless purchases.size ==0
  puts "\nВы купили:"
  puts
  purchases.each do |purchase|
    puts purchase
  end
  puts "\nС вас - #{total_cost} руб. Спасибо за покупки!"
else
  puts "\n Вы ничего не купили :( Надеемся вас не испугал наш сторожевой пёс..."
end
