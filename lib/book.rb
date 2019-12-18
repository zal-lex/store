class Book < Product
  attr_accessor :title, :author, :genre

  def initialize(params)
    super

    @title = params[:title]
    @author = params[:author]
    @genre = params[:genre]
  end

  def to_s
    "Книга «#{@title}», #{@genre}, автор - #{@author}, #{super}"
  end

  def update(params)
    super

    @title = params[:title] if params[:title]
    @author = params[:author] if params[:author]
    @genre = params[:genre] if params[:genre]
  end

  def self.from_file(path)
    lines = File.readlines(path, encoding: 'UTF-8', chomp: true)
    self.new(
      title: lines[0], 
      genre: lines[1], 
      author: lines[2], 
      price: lines[3].to_i, 
      amount: lines[4].to_i
    )
  end
end
