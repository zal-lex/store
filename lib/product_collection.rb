class ProductCollection

  PRODUCT_TYPES = {
    movies: {folder: 'movies', class: Movie},
    books: {folder: 'books', class: Book},
    disks: {folder: 'disks', class: Disk}
  }

  def initialize(products =[])
    @products = products
  end

  def self.from_dir(dir_path)
    products = []

    PRODUCT_TYPES.each do |type, hash|
      product_folder = hash[:folder]
      product_class = hash[:class]

      Dir["#{dir_path}/#{product_folder}/*.txt"].each do |product_path|
        products << product_class.from_file(product_path)
      end
    end

    self.new(products)
  end

  def product_by_index(user_choice)
    @products[user_choice - 1]
  end

  def sort!(params)
    case params[:by]
    when :title
      @products.sort_by! {|product| product.to_s}
    when :price
      @products.sort_by! {|product| product.price}
    when :amount
      @products.sort_by! {|product| product.amount}
    end

    @products.reverse! if params[:order] == :asc

    self
  end

  def stock_update(user_choice)
    product_by_index(user_choice).amount -= 1
    @products.delete_at(user_choice - 1) if product_by_index(user_choice).amount == 0
  end

  def to_a
    @products
  end

  def to_s
    result = ''
    @products.each.with_index(1) do |product, ind|
      result += "#{ind}. #{product}\n"
    end
    "#{result}"
  end
end
