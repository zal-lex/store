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

# Метод для проверки пользовательского ввода
def check_input(user_choice, products)
  until (0..products.size).include?(user_choice = STDIN.gets.to_i)
    puts "Введите число от '0' до '#{products.size}': "
  end

  if products[user_choice-1].amount == 0
    puts 'К сожалению этого товара не осталось на складе. Выберите пожалуйста другой.'
    check_input(user_choice, products)
  else
    return user_choice
  end
end
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
  collection.to_a.each.with_index(1) do |product, index|
    puts "#{index}. #{product}"
  end
  puts '0. Выход'
  puts
  # Вызываем метод проверки ввода пользователя
  user_choice = check_input(user_choice, collection.to_a)

  unless user_choice == 0
    # Уменьшаем количество выбанного товара на складе
    collection.to_a[user_choice-1].amount -= 1
    # Вносим выбранный товар в список покупок
    purchases << collection.to_a[user_choice-1]
    # Прибавляем стоимость товара к общей стоимости товаров в корзине
    total_cost += collection.to_a[user_choice-1].price
    puts "\nВы выбрали: #{collection.to_a[user_choice-1]}"
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
