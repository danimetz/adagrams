def draw_letters
  letters = {
    "A" => 9,
    "B" => 2,
    "C" => 2,
    "D" => 4,
    "E" => 12,
    "F" => 2,
    "G" => 3,
    "H" => 2,
    "I" => 9,
    "J" => 1,
    "K" => 1,
    "L" => 4,
    "M" => 2,
    "N" => 6,
    "O" => 8,
    "P" => 2,
    "Q" => 1,
    "R" => 6,
    "S" => 4,
    "T" => 6,
    "U" => 4,
    "V" => 2,
    "W" => 2,
    "X" => 1,
    "Y" => 2,
    "Z" => 1
  }

  #Creates the array of all the letters available to pick
  letter_probability = []
  letters.each do |key,value|
    until value == 0
      letter_probability << key
      value -= 1
    end
  end

  #Select letters and replace with 0 once they are pulled
  your_hand = []
  count = 0
  while count < 10 do
    index = rand(0...letter_probability.length)
    if letter_probability[index] != 0
      your_hand << letter_probability [index]
      count += 1
      letter_probability[index] = 0
    end
  end
  return your_hand
end

def uses_available_letters?(input, letters_in_hand)
  input = input.upcase.split("")
  value = []
  if input.length > letters_in_hand.length
    return false
  else
    input.each do |letter|
      if input.count(letter) > letters_in_hand.count(letter)
        value << false
      else
        value << true
      end
    end
  end
  if value.all? true
    return true
  else
    return false
  end
end

def score_word (word)
  word = word.upcase.split("")
  score = 0
  word.each do |letter|
    case letter
    when "A", "E", "I", "O", "U", "L", "N", "R", "S", "T"
      score += 1
    when "D", "G"
      score += 2
    when "B", "C", "M", "P"
      score += 3
    when "F", "H", "V", "W", "Y"
      score += 4
    when "K"
      score += 5
    when "J", "X"
      score += 8
    when "Q", "Z"
      score += 10
    end
  end

  score += 8 if word.length >= 7

  return score
end

def highest_score (word, score)
  highest_score = {}
  highest_score[:word] =  word
  highest_score[:score] = score
  return highest_score
end


def highest_score_from words
  highest_score = {}
  scores = {}
  words.each do |word|
    scores[word] = score_word(word)
  end

  max_score = scores.max_by{|key,value| value}[1]
  max_word = scores.max_by{|key,value| value}[0]

  if scores.values.count(max_score) == 1
    return highest_score(max_word, max_score)
  else
    max_scores = scores.select {|key,value| value==max_score}

    min_length = max_scores.min_by{|key,value| key.length}[0].length

    best_words = max_scores.select {|key,value| key.length == min_length || key.length == 10}

    if best_words.length == 1
      return highest_score(best_words.keys[0],best_words.values[0])
    elsif best_words.length > 1
      best_words.each do |word, score|
        if word.length == 10
          return highest_score(word, score)
        end
      end
      return highest_score(best_words.keys[0],best_words.values[0])
    end
  end
end

highest_score_from ["aa", "dog", "cat"]
