module PhotoFlick
  # This class responsible for providing random words from a 
  # dictionary 
  class Dictionary

    def initialize
      path = File.expand_path('../../../data', __FILE__)
      @file =  File.read("#{path}/words")
    end

    def get_random_words(count)
      @file.split("\n").sample(count)
    end

  end
end
