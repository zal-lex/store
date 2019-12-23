class Disk < Product
  attr_accessor :title, :artist, :year, :genre

  def initialize(params)
    super

    @title = params[:title]
    @artist = params[:artist]
    @year = params[:year]
    @genre = params[:genre]
  end

  def self.from_file(path)
    lines = File.readlines(path, encoding: 'UTF-8', chomp: true)
    self.new(
      title: lines[0],
      artist: lines[1],
      genre: lines[2],
      year: lines[3].to_i,
      price: lines[4].to_i,
      amount: lines[5].to_i
    )
  end

  def to_s
    "Альбом #{@artist} - «#{@title}», #{@genre}, #{@year}, #{super}"
  end

  def update(params)
    super

    @title = params[:title] if params[:title]
    @artist = params[:artist] if params[:artist]
    @year = params[:year] if params[:year]
    @genre = params[:genre] if params[:genre]
  end
end
