require "marky_markov"
require "pry"

class PoemBuilder
  def initialize(user:)
    @user = user
    @dictionary = MarkyMarkov::Dictionary.new("surrealism")
    @words = assemble_words
  end

  def poof
    first_line = sentence_line
    second_line = abstract_line
    final_line = sentence_line

    finished_work = "#{user} #{first_line} / #{second_line} / #{final_line}"

    finished_work.size > 140 ? trimmed_work(finished_work) : finished_work
  end

  private
  attr_accessor :words, :dictionary, :user

  def fill_dictionary
    dictionary.parse_file "source-texts/curated.txt"
  end

  def assemble_words
    fill_dictionary

    dictionary.generate_n_words(1000).downcase.split(" ")
  end

  def trimmed_work(finished_work)
    array_ified_poem = finished_work.split(" ")

    until finished_work.size < 140
      remove = rand(array_ified_poem.size - 1)
      array_ified_poem.delete_at(remove) unless delimiter_or_usn?(array_ified_poem[remove])
      finished_work = array_ified_poem.join(" ")
    end
    finished_work
  end

  def delimiter_or_usn?(selection)
    selection == "/" || selection == user
  end

  def abstract_line
    line = ""

    length = (5..8).to_a.sample

    length.times do
      n = rand(999)
      line << "#{words[n]} "
    end
    line
  end

  def sentence_line
    dictionary.generate_n_sentences(1).downcase.split(" ")[0..8].join(" ")
  end
end
