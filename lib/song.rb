class Song

    attr_accessor :name
    attr_reader :artist, :genre
    extend Concerns::Findable

    @@all = []

    def initialize(name, artist = nil, genre = nil)
      @name = name
      if artist == nil
      else
        self.artist=(artist)
      end
      if genre == nil
      else
        self.genre=(genre)
      end
    end

    def artist=(artist)
      @artist = artist
      artist.add_song(self)
    end

    def genre=(genre)
      @genre = genre
      genre.add_song(self)
    end

    def self.all
      @@all
    end

    def self.destroy_all
      self.all.clear
    end

    def save
      @@all << self
    end

    def self.create(name)
      song = new(name)
      song.save
      song
    end

    def self.new_from_filename(filename)
      artist_str = filename.split(" - ")[0]
      genre_str = filename.split(" - ")[2].split(".")[0]
      song_str = filename.split(" - ")[1]
      artist = Artist.find_or_create_by_name(artist_str)
      genre = Genre.find_or_create_by_name(genre_str)
      new(song_str, artist, genre)
    end

    def self.create_from_filename(filename)
      song = new_from_filename(filename)
      song.save
    end

end
