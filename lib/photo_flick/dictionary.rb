module PhotoFlick
  # This class responsible for providing random words from a 
  # dictionary 
  class Dictionary

    def initialize
      path = File.expand_path('../../../data', __FILE__)
      @words =  File.read("#{path}/words").split("\n")
    end

    def get_random_words(count)
      @words.sample(count)
    end

  end
end
